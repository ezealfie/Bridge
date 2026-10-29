using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using Bridge.Models;

namespace Bridge.Controllers;

public class HomeController : Controller
{
    private readonly ILogger<HomeController> _logger;
    private readonly BD _bd = new BD();

    public HomeController(ILogger<HomeController> logger)
    {
        _logger = logger;
    }

    public IActionResult Index()
    {
        /*Hace que pueda ver en la pagina el nombre y contraseña del usuario para poder hacer biene l testeo
        */
        int? id = HttpContext.Session.GetInt32("IdUsuario");
        ViewBag.NombreUsuario = id;
        return View();
    }
    public IActionResult SobreNosotros()
    {
        return View();
    }
   public IActionResult Configuracion()
    {
        Usuario usuario = _bd.ObtenerUsuarioPorId(HttpContext.Session.GetInt32("IdUsuario") ?? 0);
        ViewBag.user = usuario.fotoPerfil;
        return View();
    }
    public IActionResult Herramientas()
    {
        return View();
    }
    public IActionResult Cuidadores()
    {
        return View();
    }
    public IActionResult AdultoMayor()
    {
        return View();
    }
    public IActionResult Privacy()
    {
        return View();
    }
   [HttpPost]
    public IActionResult CambiarFotoPerfil(IFormFile fotoPerfilInput)
    {
        Usuario usuario = _bd.ObtenerUsuarioPorId(HttpContext.Session.GetInt32("IdUsuario") ?? 0);

        MemoryStream ms = new MemoryStream();
        fotoPerfilInput.CopyTo(ms);
        usuario.fotoPerfil = "data:" + fotoPerfilInput.ContentType + ";base64," + Convert.ToBase64String(ms.ToArray());

        _bd.ActualizarFotoPerfil(usuario.id_usuario, usuario.fotoPerfil);
        return RedirectToAction("Configuracion");
    }
    public IActionResult Error()
    {
        return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
    }
    public IActionResult Dashboard(int idGrupo)
    {  
        BD bd = new BD();
        HttpContext.Session.SetInt32("IdGrupo", idGrupo);
        int? idGrupoSession = HttpContext.Session.GetInt32("IdGrupo");
        if (idGrupoSession == null)
        {
            return RedirectToAction("Login", "Sesiones");
        }
        ViewBag.NombreAdulto = _bd.ObtenerNombreAdulto(idGrupo);
        ViewBag.Proximos5Eventos = _bd.ObtenerProximos5Eventos(idGrupo);
        return View();
    }
    public IActionResult Grupo(int? idUsuario)
    {   
        int? usuarioActual = idUsuario ?? HttpContext.Session.GetInt32("IdUsuario");

        if (usuarioActual == null || usuarioActual <= 0)
        {
            return RedirectToAction("Login", "Sesiones");
        }

        ViewBag.Grupos = _bd.ObtenerGruposUsuario(usuarioActual.Value);
        return View();
    }
    [HttpPost]
    public IActionResult CrearGrupo(string nombre, string? dniAdulto, string? descripcion)
    {
        int? idUsuario = HttpContext.Session.GetInt32("IdUsuario");

        if (idUsuario == null || string.IsNullOrWhiteSpace(nombre))
        {
            if (Request.Headers["X-Requested-With"] == "XMLHttpRequest")
            {
                return Json(new { success = false, message = "Faltan datos obligatorios para crear el grupo." });
            }

            return RedirectToAction("Grupo", new { idUsuario = idUsuario ?? 0 });
        }

        int idAdultoMayor;
        bool esAdultoMayor = _bd.EsAdultoMayor(idUsuario.Value);

        if (esAdultoMayor)
        {
            idAdultoMayor = _bd.ObtenerIdAdultoMayorPorUsuario(idUsuario.Value);
        }
        else
        {
            if (string.IsNullOrWhiteSpace(dniAdulto))
            {
                if (Request.Headers["X-Requested-With"] == "XMLHttpRequest")
                {
                    return Json(new { success = false, message = "Debes ingresar el DNI del adulto mayor." });
                }

                return RedirectToAction("Grupo", new { idUsuario = idUsuario.Value });
            }

            idAdultoMayor = _bd.ObtenerIdAdultoMayorPorDni(dniAdulto.Trim());
        }

        if (idAdultoMayor <= 0)
        {
            if (Request.Headers["X-Requested-With"] == "XMLHttpRequest")
            {
                return Json(new { success = false, message = "No se encontró el adulto mayor asociado." });
            }

            return RedirectToAction("Grupo", new { idUsuario = idUsuario.Value });
        }

        int idCuidador = _bd.ObtenerIdCuidadorPorUsuario(idUsuario.Value);
        int idGrupo = _bd.CrearGrupo(nombre.Trim(), idAdultoMayor, idCuidador > 0 ? idCuidador : null, descripcion);

        if (idGrupo <= 0)
        {
            if (Request.Headers["X-Requested-With"] == "XMLHttpRequest")
            {
                return Json(new { success = false, message = "No se pudo guardar el grupo. Verificá que el adulto mayor no tenga ya un grupo asignado." });
            }

            return RedirectToAction("Grupo", new { idUsuario = idUsuario.Value });
        }

        if (Request.Headers["X-Requested-With"] == "XMLHttpRequest")
        {
            return Json(new
            {
                success = true,
                grupo = new
                {
                    id_grupo = idGrupo,
                    Nombre = nombre.Trim(),
                    id_adultoMayor = idAdultoMayor,
                    descripcion = descripcion
                },
                redirectUrl = Url.Action("Dashboard", "Home", new { idGrupo })
            });
        }

        return RedirectToAction("Dashboard", new { idGrupo });
    }
}
