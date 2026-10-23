namespace Bridge.Models;

public class AdultoMayor
{
    public int id_adultoMayor { get; set; }
    public string dni { get; set; } = string.Empty;
    public DateTime fecha_nacimiento { get; set; }
    public string? condicion { get; set; }
    public int id_usuario { get; set; }
    public DateTime fecha_ingreso { get; set; }
}
