namespace Bridge.Models;

public class MensajeViewModel
{
    public int id_mensaje { get; set; }
    public string nombreCuidador { get; set; } = string.Empty;
    public string? fotoPerfil { get; set; }
    public string contenido { get; set; } = string.Empty;
    public DateTime fechaHora { get; set; }
}
