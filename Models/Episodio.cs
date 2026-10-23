namespace Bridge.Models;

public class Episodio
{
    public int id_episodio { get; set; }
    public string titulo { get; set; } = string.Empty;
    public DateTime fecha_hora { get; set; }
    public int id_registro { get; set; }
    public string? descripcion { get; set; }
    public string? causa { get; set; }
}
