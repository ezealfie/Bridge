namespace Bridge.Models;

public class CuidadorGrupo
{
    public int id_cuidadorGrupo { get; set; }
    public int id_grupo { get; set; }
    public int id_cuidador { get; set; }
    public DateTime fechaIngreso { get; set; }
    public string estadoAutorizacion { get; set; } = string.Empty;
}
