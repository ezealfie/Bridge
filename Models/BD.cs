
using Microsoft.Data.SqlClient;
using Dapper;
namespace Bridge.Models;

public class BD
{
   private string _connectionString = @"Server=localhost;DataBase Bridge; Integrated Security=True; TrustServer Certificate=True;";

    public string ObtenerNombreAdulto(int IdGrupo)
    {
        string nombreAdulto = "";
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            string query = "SELECT nombre FROM AdultoMayor inner join Grupo on AdultoMayor_id = Grupo.adultoMayor_id WHERE Grupo.id_grupo = @IdGrupo";
            nombreAdulto = connection.QueryFirstOrDefault<string>(query, new { IdGrupo = IdGrupo });
        }
        return nombreAdulto;
    }
    public List<Evento> ObtenerProximos5Eventos(int idGrupo)
    {
        List<Evento> proximosEventos = new List<Evento>();
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            string query = "SELECT TOP 5 * FROM Evento WHERE Grupo_Id = @IdGrupo ORDER BY fechaHora ASC";
            proximosEventos = connection.Query<Evento>(query, new { IdGrupo = idGrupo }).ToList();
        }
        return proximosEventos;
    }
    //arrgelalo alfie
    public int UsuarioExiste(string mail)
    {
        int id = -1;
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {   
            string query = "SELECT id_usuario FROM Usuarios WHERE mail = @mail";
            id = connection.QueryFirstOrDefault<int>(query, new { mail = mail });
        }
        return id;
    }
    public bool VerificarCredenciales(int id, string password)
    {
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            string query = "SELECT Password FROM Usuarios WHERE Id = @Id AND Password = @Password";
            int count = connection.Execute(query, new { Id = id, Password = password });
            return count > 0;
        }
    }
    public void RegistrarUsuario(string nombre, string apellido, string email, string contrasena, string telefono)
    {
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            string query = "INSERT INTO Usuarios (Nombre, Apellido, Email, Password, Telefono) VALUES (@Nombre, @Apellido, @Email, @Password, @Telefono)";
            connection.Execute(query, new { Nombre = nombre, Apellido = apellido, Email = email, Password = contrasena, Telefono = telefono });
        }
    }
    public List<Grupo> ObtenerGruposUsuario(int idUsuario)
    {
        //verifivasr si el id del usuario es cuidador o adulto matyor.- si es adulto mayor solo tiene un gruoo. si es cuidador tiene mas. hacer ambas querys en cada caso
        List<Grupo> grupos = new List<Grupo>();
        if (EsCuidador(idUsuario))
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                string query = "SELECT * FROM Grupos INNER JOIN Cuidador ON grupo.cuidador_id = cuidador_Id WHERE cuidador_Id = @IdUsuario";
                grupos = connection.Query<Grupo>(query, new { IdUsuario = idUsuario }).ToList();
            }
        }
        else
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                string query = "SELECT * FROM Grupos INNER JOIN AdultoMayor ON grupo.adultoMayor_id = adultoMayor_Id WHERE adultoMayor_Id = @IdUsuario";
                grupos = connection.Query<Grupo>(query, new { IdUsuario = idUsuario }).ToList();
            }
        }
        return grupos;
    }
    public int ObtenerIdUsuario(string mail)
    {
        int id = -1;
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            string query = "SELECT Id FROM Usuarios WHERE mail = @mail";
            id = connection.QueryFirstOrDefault<int>(query, new { mail = mail });
        }
        return id;
    }
    public bool EsCuidador(int idUsuario)
    {
        int count = 0;
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            string query = "SELECT COUNT(*) FROM Cuidador WHERE id_usuario = @IdUsuario";
            count = connection.QueryFirstOrDefault<int>(query, new { IdUsuario = idUsuario });
        }
        return count > 0;
    }
}