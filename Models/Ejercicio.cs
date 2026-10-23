namespace Bridge.Models;

public class Ejercicio
{
    public int id_ejercicio { get; set; }
    public string nombre { get; set; } = string.Empty;
    public string? descripcion { get; set; }
    public DateTime fechaPublicacion { get; set; }
}
