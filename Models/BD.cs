
using Microsoft.Data.SqlClient;
using Dapper;
namespace Bridge.Models;

public class BD
{
   private string _connectionString = @"Server=localhost;DataBase Bridge; Integrated Security=True; TrustServer Certificate=True;";

    public string ObtenerNombreAdulto(int IdGrupo)
    {
        string nombreAdulto = " ";
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            string query = "SELECT nombre FROM AdultoMayor WHERE Id = @IdGrupo";
            nombreAdulto = connection.QueryFirstOrDefault<string>(query, new { Id = IdGrupo });
        }
        return nombreAdulto;
    }
    public List<Evento> ObtenerProximos5Eventos()
    {
        List<Evento> proximosEventos = new List<Evento>();
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            string query = "SELECT TOP 5 * FROM Evento ORDER BY fechaHora ASC";
            proximosEventos = connection.Query<Evento>(query).ToList();
        }
        return proximosEventos;
    }
    //arrgelalo alfie
    public int UsuarioExiste(string email)
    {
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {   int id = -1;
            string query = "SELECT Id FROM Usuarios WHERE Email = @Email";
            id = connection.QueryFirstOrDefault<int>(query, new { Email = email });
            return id;
            
        }
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
    public List<Grupo> ObtenerGruposUsuario()
    {
        
    }
}