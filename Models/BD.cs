using System.Data;
using Microsoft.Data.SqlClient;
using Dapper;

namespace Bridge.Models;

public class BD
{
    private string _connectionString = @"Server=localhost;Database=Bridge;Integrated Security=True;TrustServerCertificate=True;";

    public string ObtenerNombreAdulto(int IdGrupo)
    {
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            return connection.QueryFirstOrDefault<string>(
                "ObtenerNombreAdulto",
                new { IdGrupo = IdGrupo },
                commandType: CommandType.StoredProcedure
            ) ?? string.Empty;
        }
    }

    public List<Evento> ObtenerProximos5Eventos(int idGrupo)
    {
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            return connection.Query<Evento>(
                "ObtenerProximos5Eventos",
                new { IdGrupo = idGrupo },
                commandType: CommandType.StoredProcedure
            ).ToList();
        }
    }

    public int UsuarioExiste(string mail)
    {
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            int? id = connection.QueryFirstOrDefault<int?>(
                "UsuarioExiste",
                new { Mail = mail },
                commandType: CommandType.StoredProcedure
            );
            return id ?? -1;
        }
    }

    public bool VerificarCredenciales(int id, string password)
    {
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            int count = connection.QueryFirstOrDefault<int>(
                "VerificarCredenciales",
                new { IdUsuario = id, Password = password },
                commandType: CommandType.StoredProcedure
            );
            return count > 0;
        }
    }

    public bool ExisteAdultoMayorPorDni(string dni)
    {
        if (string.IsNullOrWhiteSpace(dni))
        {
            return false;
        }

        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            int count = connection.QueryFirstOrDefault<int>(
                @"SELECT COUNT(*)
                  FROM dbo.AdultoMayor
                  WHERE dni = @Dni",
                new { Dni = dni.Trim() }
            );

            return count > 0;
        }
    }

    public int RegistrarUsuario(string emailOrNombre, string contrasenaOrApellido, string nombreOrEmail, string apellidoOrContrasena = "", string telefono = "", string tipoUsuario = "Cuidador", string? dniAdultoMayor = null, DateTime? fechaNacimientoAdultoMayor = null, string? condicionAdultoMayor = null)
    {
        string email;
        string contrasena;
        string nombre;
        string apellido;

        bool esAdultoMayor = !string.IsNullOrWhiteSpace(tipoUsuario) &&
                             tipoUsuario.Trim().StartsWith("adulto", StringComparison.OrdinalIgnoreCase);

        if (esAdultoMayor && ExisteAdultoMayorPorDni(dniAdultoMayor ?? string.Empty))
        {
            return -1;
        }

        if (emailOrNombre != null && emailOrNombre.Contains("@"))
        {
            email = emailOrNombre;
            contrasena = contrasenaOrApellido;
            nombre = nombreOrEmail;
            apellido = apellidoOrContrasena;
        }
        else
        {
            nombre = emailOrNombre ?? string.Empty;
            apellido = contrasenaOrApellido ?? string.Empty;
            email = nombreOrEmail ?? string.Empty;
            contrasena = apellidoOrContrasena ?? string.Empty;
        }

        string nombreCompleto = string.IsNullOrWhiteSpace(apellido) ? nombre : $"{nombre} {apellido}".Trim();

        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            connection.Execute(
                "RegistrarUsuario",
                new
                {
                    Mail = email,
                    Contrasena = contrasena,
                    Nombre = nombreCompleto,
                    Telefono = telefono ?? string.Empty,
                    TipoUsuario = tipoUsuario,
                    FotoPerfil = (string?)null,
                    NombreUsuario = email
                },
                commandType: CommandType.StoredProcedure
            );

            int idUsuario = connection.QueryFirstOrDefault<int>(
                "ObtenerIdUsuario",
                new { Mail = email },
                commandType: CommandType.StoredProcedure
            );

            if (idUsuario <= 0)
            {
                return -1;
            }

            bool esAdultoMayorRegistro = !string.IsNullOrWhiteSpace(tipoUsuario) &&
                                         tipoUsuario.Trim().StartsWith("adulto", StringComparison.OrdinalIgnoreCase);

            if (esAdultoMayorRegistro)
            {
                connection.Execute(
                    @"INSERT INTO dbo.AdultoMayor (dni, fecha_nacimiento, condicion, id_usuario, fecha_ingreso)
                      VALUES (@Dni, @FechaNacimiento, @Condicion, @IdUsuario, @FechaIngreso)",
                    new
                    {
                        Dni = (dniAdultoMayor ?? string.Empty).Trim(),
                        FechaNacimiento = fechaNacimientoAdultoMayor ?? new DateTime(1900, 1, 1),
                        Condicion = string.IsNullOrWhiteSpace(condicionAdultoMayor) ? null : condicionAdultoMayor.Trim(),
                        IdUsuario = idUsuario,
                        FechaIngreso = DateTime.Today
                    }
                );
            }
            else
            {
                connection.Execute(
                    @"INSERT INTO dbo.Cuidador (id_usuario)
                      VALUES (@IdUsuario)",
                    new
                    {
                        IdUsuario = idUsuario
                    }
                );
            }

            return idUsuario;
        }
    }

    public List<Grupo> ObtenerGruposUsuario(int idUsuario)
    {
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            const string sql = @"
                SELECT DISTINCT
                    g.id_grupo,
                    g.Nombre,
                    g.id_adultoMayor,
                    g.descripcion
                FROM dbo.Grupo g
                LEFT JOIN dbo.AdultoMayor am ON am.id_adultoMayor = g.id_adultoMayor
                LEFT JOIN dbo.CuidadorGrupo cg ON cg.id_grupo = g.id_grupo
                LEFT JOIN dbo.Cuidador c ON c.id_cuidador = cg.id_cuidador
                WHERE am.id_usuario = @IdUsuario
                   OR c.id_usuario = @IdUsuario
                ORDER BY g.id_grupo;";

            return connection.Query<Grupo>(sql, new { IdUsuario = idUsuario }).ToList();
        }
    }

    public int ObtenerIdUsuario(string mail)
    {
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            int? id = connection.QueryFirstOrDefault<int?>(
                "ObtenerIdUsuario",
                new { Mail = mail },
                commandType: CommandType.StoredProcedure
            );
            return id ?? -1;
        }
    }

    public bool EsCuidador(int idUsuario)
    {
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            int count = connection.QueryFirstOrDefault<int>(
                @"SELECT COUNT(*)
                  FROM dbo.Cuidador
                  WHERE id_usuario = @IdUsuario",
                new { IdUsuario = idUsuario }
            );

            if (count > 0)
            {
                return true;
            }

            string tipoUsuario = connection.QueryFirstOrDefault<string>(
                @"SELECT tipoUsuario
                  FROM dbo.Usuario
                  WHERE id_usuario = @IdUsuario",
                new { IdUsuario = idUsuario }
            ) ?? string.Empty;

            return !string.IsNullOrWhiteSpace(tipoUsuario) &&
                   tipoUsuario.Trim().StartsWith("cuidador", StringComparison.OrdinalIgnoreCase);
        }
    }

    public int CrearGrupo(string nombre, int idAdultoMayor, int? idCuidador = null, string? descripcion = null)
    {
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            return connection.ExecuteScalar<int>(
                "CrearGrupo",
                new
                {
                    Nombre = nombre,
                    IdAdultoMayor = idAdultoMayor,
                    Descripcion = descripcion,
                    IdCuidador = idCuidador
                },
                commandType: CommandType.StoredProcedure
            );
        }
    }

    public int ObtenerIdCuidadorPorUsuario(int idUsuario)
    {
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            int? id = connection.QueryFirstOrDefault<int?>(
                "ObtenerIdCuidadorPorUsuario",
                new { IdUsuario = idUsuario },
                commandType: CommandType.StoredProcedure
            );
            return id ?? -1;
        }
    }

    public bool AgregarCuidadorAGrupo(int idGrupo, int idCuidador)
    {
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            int resultado = connection.ExecuteScalar<int>(
                "AgregarCuidadorAGrupo",
                new
                {
                    IdGrupo = idGrupo,
                    IdCuidador = idCuidador,
                    EstadoAutorizacion = "pendiente"
                },
                commandType: CommandType.StoredProcedure
            );
            return resultado > 0;
        }
    }

    public int ObtenerIdAdultoMayorPorUsuario(int idUsuario)
    {
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            int? id = connection.QueryFirstOrDefault<int?>(
                "ObtenerIdAdultoMayorPorUsuario",
                new { IdUsuario = idUsuario },
                commandType: CommandType.StoredProcedure
            );
            return id ?? -1;
        }
    }

    public int ObtenerIdAdultoMayorPorDni(string dni)
    {
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            int? id = connection.QueryFirstOrDefault<int?>(
                "ObtenerIdAdultoMayorPorDni",
                new { Dni = dni },
                commandType: CommandType.StoredProcedure
            );
            return id ?? -1;
        }
    }

    public string ObtenerTipoUsuario(int idUsuario)
    {
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            return connection.QueryFirstOrDefault<string>(
                "ObtenerTipoUsuario",
                new { IdUsuario = idUsuario },
                commandType: CommandType.StoredProcedure
            ) ?? string.Empty;
        }
    }

    public bool EsAdultoMayor(int idUsuario)
    {
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            int count = connection.QueryFirstOrDefault<int>(
                @"SELECT COUNT(*)
                  FROM dbo.AdultoMayor
                  WHERE id_usuario = @IdUsuario",
                new { IdUsuario = idUsuario }
            );

            if (count > 0)
            {
                return true;
            }

            string tipoUsuario = connection.QueryFirstOrDefault<string>(
                @"SELECT tipoUsuario
                  FROM dbo.Usuario
                  WHERE id_usuario = @IdUsuario",
                new { IdUsuario = idUsuario }
            ) ?? string.Empty;

            return !string.IsNullOrWhiteSpace(tipoUsuario) &&
                   tipoUsuario.Trim().StartsWith("adulto", StringComparison.OrdinalIgnoreCase);
        }
    }
    public Usuario ObtenerUsuarioPorId(int id_usuario)
    {
        Usuario usuario = new Usuario();
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            string query = @"SELECT *FROM Usuario WHERE id_usuario = @id_usuario";
            usuario = connection.QueryFirstOrDefault<Usuario>(query, new { id_usuario });
        }
        return usuario;
    }
    public void ActualizarFotoPerfil(int id_usuario, string fotoPerfil)
    {
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            string query = @"UPDATE Usuario SET fotoPerfil = @fotoPerfil WHERE id_usuario = @id_usuario";
            connection.Execute(query, new { fotoPerfil = fotoPerfil, id_usuario = id_usuario });
        }
    }

}
