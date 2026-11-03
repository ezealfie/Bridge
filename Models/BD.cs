using System.Data;
using Microsoft.Data.SqlClient;
using Dapper;

namespace Bridge.Models;

public class BD
{
    private readonly string _connectionString = @"Server=localhost;Database=Bridge;Integrated Security=True;TrustServerCertificate=True;";

    private bool ExisteColumnaEsPropietario(SqlConnection connection)
    {
        const string query = @"
            SELECT COUNT(1)
            FROM sys.columns
            WHERE Name = N'esPropietario'
              AND Object_ID = Object_ID(N'dbo.CuidadorGrupo');";

        int cantidad = connection.ExecuteScalar<int>(query);
        return cantidad > 0;
    }

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

            List<Grupo> grupos = connection.Query<Grupo>(sql, new { IdUsuario = idUsuario }).ToList();
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

            if (esAdultoMayor)
            {
                if (string.IsNullOrWhiteSpace(dniAdultoMayor) || fechaNacimientoAdultoMayor == null)
                {
                    return -1;
                }

                connection.Execute(
                    "InsertarAdultoMayor",
                    new
                    {
                        Dni = dniAdultoMayor.Trim(),
                        FechaNacimiento = fechaNacimientoAdultoMayor.Value.Date,
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
                    new { IdUsuario = idUsuario },
                    commandType: CommandType.StoredProcedure
                );
            }
            return idUsuario;

            if (idUsuario <= 0)
            {
                return -1;
            }

            if (esAdultoMayor)
            {
                if (string.IsNullOrWhiteSpace(dniAdultoMayor) || fechaNacimientoAdultoMayor == null)
                {
                    return -1;
                }

                connection.Execute(
                    "InsertarAdultoMayor",
                    new
                    {
                        Dni = dniAdultoMayor.Trim(),
                        FechaNacimiento = fechaNacimientoAdultoMayor.Value.Date,
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
                    new { IdUsuario = idUsuario },
                    commandType: CommandType.StoredProcedure
                );
            }
            return idUsuario;
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
  public List<Recordatorio> ObtenerRecordatorios(int idGrupo)
    {
        List<Recordatorio> recordatorios = new List<Recordatorio>();
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            string query = @"
            SELECT 
                Recordatorio.id_recordatorio,
                Recordatorio.nombre,
                Recordatorio.descripcion,
                Recordatorio.fechaHora,
                Recordatorio.id_adultoMayor
            FROM Recordatorio
            INNER JOIN AdultoMayor 
                ON Recordatorio.id_adultoMayor = AdultoMayor.id_adultoMayor
            INNER JOIN Grupo 
                ON AdultoMayor.id_adultoMayor = Grupo.id_adultoMayor
            WHERE Grupo.id_grupo = @id_grupo";
            recordatorios = connection.Query<Recordatorio>(query, new { id_grupo = idGrupo }).ToList();
        }
        return recordatorios;
    }
        public AdultoMayor ObtenerAdultoMayorPorGrupo(int idGrupo)
        {
            AdultoMayor adultoMayor = new AdultoMayor();
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                string query = @"SELECT AdultoMayor.*
                    FROM AdultoMayor
                    INNER JOIN Grupo ON AdultoMayor.id_adultoMayor = Grupo.id_adultoMayor
                    WHERE Grupo.id_grupo = @id_grupo";
                adultoMayor = connection.QueryFirstOrDefault<AdultoMayor>(query, new { id_grupo = idGrupo }) ?? new AdultoMayor();
            }
            return adultoMayor;
        }
    public List<Medicacion> ObtenerMedicaciones(int idGrupo)
    {
        List<Medicacion> medicaciones = new List<Medicacion>();
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            string query = @"SELECT 
                            Medicacion.*
                            FROM Medicacion
                            INNER JOIN MedicacionRegistro ON Medicacion.id_medicacion = MedicacionRegistro.id_medicacion
                            INNER JOIN RegistroMedico ON MedicacionRegistro.id_registro = RegistroMedico.id_registro
                            INNER JOIN AdultoMayor ON RegistroMedico.id_adultoMayor = AdultoMayor.id_adultoMayor
                            INNER JOIN Grupo ON AdultoMayor.id_adultoMayor = Grupo.id_adultoMayor
                            WHERE Grupo.id_grupo = @id_grupo";

            medicaciones = connection.Query<Medicacion>(query, new { id_grupo = idGrupo }).ToList();
        }
        return medicaciones;
    }

    public List<Episodio> ObtenerEpisodios(int idGrupo)
    {
        List<Episodio> episodios = new List<Episodio>();
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            string query = @"SELECT 
                                Episodio.*
                            FROM Episodio
                            INNER JOIN RegistroMedico ON Episodio.id_registro = RegistroMedico.id_registro
                            INNER JOIN AdultoMayor ON RegistroMedico.id_adultoMayor = AdultoMayor.id_adultoMayor
                            INNER JOIN Grupo ON AdultoMayor.id_adultoMayor = Grupo.id_adultoMayor
                            WHERE Grupo.id_grupo = @id_grupo";

            episodios = connection.Query<Episodio>(query, new { id_grupo = idGrupo }).ToList();
        }
        return episodios;
    }

    public List<Documento> ObtenerDocumentos(int idGrupo)
    {
        List<Documento> documentos = new List<Documento>();
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            string query = @"SELECT 
                                Documento.*
                            FROM Documento
                            INNER JOIN RegistroMedico ON Documento.id_registro = RegistroMedico.id_registro
                            INNER JOIN AdultoMayor ON RegistroMedico.id_adultoMayor = AdultoMayor.id_adultoMayor
                            INNER JOIN Grupo ON AdultoMayor.id_adultoMayor = Grupo.id_adultoMayor
                            WHERE Grupo.id_grupo = @id_grupo";

            documentos = connection.Query<Documento>(query, new { id_grupo = idGrupo }).ToList();
        }
        return documentos;
    }
    public List<Usuario> ObtenerProximos3Cuidadores(int idGrupo)
    {
        List<Usuario> cuidadores = new List<Usuario>();

        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            string query = @"SELECT TOP 3
                                c.id_cuidador,
                                c.id_usuario,
                                u.nombre,
                                u.telefono
                            FROM Cuidador c
                            INNER JOIN CuidadorGrupo cg ON c.id_cuidador = cg.id_cuidador
                            INNER JOIN Grupo g ON cg.id_grupo = g.id_grupo
                            WHERE g.id_grupo = @id_grupo
                            ORDER BY u.nombre ASC";

            cuidadores = connection.Query<Usuario>(query, new { id_grupo = idGrupo }).ToList();
        }
        return cuidadores;
    }
}
