namespace Bridge.Models;

using Microsoft.Data.SqlClient;
using Dapper;
public class BD
{
   private string _connectionString = @"Server=localhost;DataBase Bridge; Integrated Security=True; TrustServer Certificate=True;";

    public void ObtenerNombreAdulto(int IdGrupo)
    {
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            string query = "SELECT Nombre FROM Adultos WHERE Id = @IdGrupo";
            string nombreAdulto = connection.QueryFirstOrDefault<string>(query, new { Id = IdGrupo });
        }
        return nombreAdulto;
    }
    public void ObtenerProximos5Eventos()
    {
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            string query = "SELECT TOP 5 * FROM Eventos ORDER BY FechaEvento ASC";
            List<Evento> proximosEventos = connection.Query<Evento>(query).ToList();
        }
        return proximosEventos;
    }
}