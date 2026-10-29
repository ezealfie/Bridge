namespace Bridge.Models;

public class Recordatorio
{
    public int id_recordatorio { get; set; }
    public string nombre { get; set; }
    public string? descripcion { get; set; }
    public DateTime fechaHora { get; set; }
    public int id_adultoMayor { get; set; }
}
