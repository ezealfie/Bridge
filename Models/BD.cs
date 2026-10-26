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

    public void RegistrarUsuario(string emailOrNombre, string contrasenaOrApellido, string nombreOrEmail, string apellidoOrContrasena = "", string telefono = "", string tipoUsuario = "Cuidador")
    {
        string email;
        string contrasena;
        string nombre;
        string apellido;

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
        }
    }

    public List<Grupo> ObtenerGruposUsuario(int idUsuario)
    {
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            return connection.Query<Grupo>(
                "ObtenerGruposUsuario",
                new { IdUsuario = idUsuario },
                commandType: CommandType.StoredProcedure
            ).ToList();
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
                "EsCuidador",
                new { IdUsuario = idUsuario },
                commandType: CommandType.StoredProcedure
            );
            return count > 0;
        }
    }

    public int CrearGrupo(string nombre, int idAdultoMayor, string? descripcion = null)
    {
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            return connection.ExecuteScalar<int>(
                "CrearGrupo",
                new
                {
                    Nombre = nombre,
                    IdAdultoMayor = idAdultoMayor,
                    Descripcion = descripcion
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
}
