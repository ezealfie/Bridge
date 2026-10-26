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
    [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
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
    public IActionResult Grupo(int idUsuario)
    {   
        BD BD = new BD();
        ViewBag.Grupos = BD.ObtenerGruposUsuario(idUsuario);
        return View();
    }
    [HttpPost]
    public IActionResult CrearGrupo(string nombre, string? descripcion)
    {
        int? idUsuario = HttpContext.Session.GetInt32("IdUsuario");

        if (idUsuario == null || string.IsNullOrWhiteSpace(nombre))
        {
            return RedirectToAction("Grupo", new { idUsuario = idUsuario ?? 0 });
        }

        int idAdultoMayor = _bd.ObtenerIdAdultoMayorPorUsuario(idUsuario.Value);

        if (idAdultoMayor <= 0)
        {
            return RedirectToAction("Grupo", new { idUsuario = idUsuario.Value });
        }

        int idGrupo = _bd.CrearGrupo(nombre, idAdultoMayor, descripcion);

        if (idGrupo <= 0)
        {
            return RedirectToAction("Grupo", new { idUsuario = idUsuario.Value });
        }

        return RedirectToAction("Dashboard", new { idGrupo });
    }
}
