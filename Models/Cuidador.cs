namespace Bridge.Models;

public class Cuidador
{
    public int id_cuidador { get; set; }
    public int id_usuario { get; set; }
    public string rol { get; set; } = string.Empty;
}
