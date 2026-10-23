namespace Bridge.Models;

public class Mensaje
{
    public int id_mensaje { get; set; }
    public int id_grupo { get; set; }
    public int id_cuidador { get; set; }
    public string contenido { get; set; } = string.Empty;
    public DateTime fechaHora { get; set; }
}
