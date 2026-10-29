using System.Data;
using Microsoft.Data.SqlClient;
using Dapper;

namespace Bridge.Models;

public class BD
{
    private readonly string _connectionString = @"Server=localhost;Database=Bridge;Integrated Security=True;TrustServerCertificate=True;";

    public string ObtenerNombreAdulto(int IdGrupo)
    {
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            string nombre = connection.QueryFirstOrDefault<string>(
                "ObtenerNombreAdulto",
                new { IdGrupo = IdGrupo },
                commandType: CommandType.StoredProcedure
            ) ?? string.Empty;

            return nombre;
        }
    }

    public string ObtenerNombreGrupo(int IdGrupo)
    {
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            string nombre = connection.QueryFirstOrDefault<string>(
                "ObtenerNombreGrupo",
                new { IdGrupo = IdGrupo },
                commandType: CommandType.StoredProcedure
            ) ?? string.Empty;

            return nombre;
        }
    }

    public List<Evento> ObtenerProximos5Eventos(int idGrupo)
    {
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            List<Evento> eventos = connection.Query<Evento>(
                "ObtenerProximos5Eventos",
                new { IdGrupo = idGrupo },
                commandType: CommandType.StoredProcedure
            ).ToList();

            return eventos;
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
                "ExisteAdultoMayorPorDni",
                new { Dni = dni.Trim() },
                commandType: CommandType.StoredProcedure
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
                    "InsertarAdultoMayor",
                    new
                    {
                        Dni = (dniAdultoMayor ?? string.Empty).Trim(),
                        FechaNacimiento = fechaNacimientoAdultoMayor ?? new DateTime(1900, 1, 1),
                        Condicion = string.IsNullOrWhiteSpace(condicionAdultoMayor) ? null : condicionAdultoMayor.Trim(),
                        IdUsuario = idUsuario,
                        FechaIngreso = DateTime.Today
                    },
                    commandType: CommandType.StoredProcedure
                );
            }
            else
            {
                connection.Execute(
                    "InsertarCuidador",
                    new
                    {
                        IdUsuario = idUsuario
                    },
                    commandType: CommandType.StoredProcedure
                );
            }

            return idUsuario;
        }
    }

    public List<Grupo> ObtenerGruposUsuario(int idUsuario)
    {
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            List<Grupo> grupos = connection.Query<Grupo>(
                "ObtenerGruposUsuario",
                new { IdUsuario = idUsuario },
                commandType: CommandType.StoredProcedure
            ).ToList();

            return grupos;
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
            int resultado = connection.QueryFirstOrDefault<int>(
                "EsCuidador",
                new { IdUsuario = idUsuario },
                commandType: CommandType.StoredProcedure
            );

            return resultado > 0;
        }
    }

    public int CrearGrupo(string nombre, int idAdultoMayor, int? idCuidador = null, string? descripcion = null)
    {
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            int idGrupo = connection.ExecuteScalar<int>(
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

            return idGrupo;
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
            string tipoUsuario = connection.QueryFirstOrDefault<string>(
                "ObtenerTipoUsuario",
                new { IdUsuario = idUsuario },
                commandType: CommandType.StoredProcedure
            ) ?? string.Empty;

            return tipoUsuario;
        }
    }

    public bool EsAdultoMayor(int idUsuario)
    {
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            int resultado = connection.QueryFirstOrDefault<int>(
                "EsAdultoMayor",
                new { IdUsuario = idUsuario },
                commandType: CommandType.StoredProcedure
            );

            return resultado > 0;
        }
    }

    public Usuario ObtenerUsuarioPorId(int id_usuario)
    {
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            Usuario usuario = connection.QueryFirstOrDefault<Usuario>(
                "ObtenerUsuarioPorId",
                new { IdUsuario = id_usuario },
                commandType: CommandType.StoredProcedure
            ) ?? new Usuario();

            return usuario;
        }
    }

    public void ActualizarFotoPerfil(int id_usuario, string fotoPerfil)
    {
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            connection.Execute(
                "ActualizarFotoPerfil",
                new { IdUsuario = id_usuario, FotoPerfil = fotoPerfil },
                commandType: CommandType.StoredProcedure
            );
        }
    }
}
