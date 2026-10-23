namespace Bridge.Models;

public class Articulo
{
    public int id_articulo { get; set; }
    public string nombre { get; set; } = string.Empty;
    public string? descripcion { get; set; }
    public DateTime fechaPublicacion { get; set; }
    public string? autor { get; set; }
}
