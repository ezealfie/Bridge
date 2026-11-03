namespace Bridge.Models;

public class CuidadorGrupoViewModel
{
    public int id_cuidador { get; set; }
    public int id_cuidadorGrupo { get; set; }
    public string nombre { get; set; } = string.Empty;
    public string? fotoPerfil { get; set; }
    public string estadoAutorizacion { get; set; } = string.Empty;
    public bool esPropietario { get; set; }
}
