namespace Bridge.Models;

public class Grupo
{
    public int id_grupo { get; set; }
    public string Nombre { get; set; } = string.Empty;
    public int id_adultoMayor { get; set; }
    public string? descripcion { get; set; }
}
