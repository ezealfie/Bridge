namespace Bridge.Models;

public class Evento
{
    public int id_evento { get; set; }
    public string nombre { get; set; } = string.Empty;
    public DateTime fechaHora { get; set; }
    public int id_adultoMayor { get; set; }
    public string? descripcion { get; set; }
}
