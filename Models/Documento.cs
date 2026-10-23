namespace Bridge.Models;

public class Documento
{
    public int id_documento { get; set; }
    public string titulo { get; set; } = string.Empty;
    public DateTime fecha_hora { get; set; }
    public int id_registro { get; set; }
    public string? descripcion { get; set; }
}
