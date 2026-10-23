namespace Bridge.Models;

public class Usuario
{
    public int id_usuario { get; set; }
    public string mail { get; set; } = string.Empty;
    public string contraseña { get; set; } = string.Empty;
    public string nombre { get; set; } = string.Empty;
    public string telefono { get; set; } = string.Empty;
    public string tipoUsuario { get; set; } = string.Empty;
    public string? fotoPerfil { get; set; }
    public DateTime fecha_ingreso { get; set; }
    public string nombreUsuario { get; set; } = string.Empty;
}
