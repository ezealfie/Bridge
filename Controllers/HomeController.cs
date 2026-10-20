using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Dapper;
using Bridge.Models;

namespace Bridge.Controllers;

public class HomeController : Controller
{
    private readonly ILogger<HomeController> _logger;
    private readonly string _connectionString = @"Server=localhost;DataBase Bridge; Integrated Security=True; TrustServer Certificate=True;";

    public HomeController(ILogger<HomeController> logger)
    {
        _logger = logger;
    }

    public IActionResult Index()
    {
        return View();
    }
    public IActionResult SobreNosotros()
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
    public IActionResult Dashboard()
    {  
        int? idGrupoSession = HttpContext.Session.GetInt32("IdGrupo");
            if (idGrupoSession == null)
            {
                return RedirectToAction("Login");
            }
        int IdGrupo = idGrupoSession.Value;
        ViewBag.NombreAdulto = ObtenerNombreAdulto(IdGrupo);
        ViewBag.Proximos5Eventos = ObtenerProximos5Eventos();
        return View();
    }
    public IActionResult Grupos()
    {
        ViewBag.Grupos = BD.ObtenerGruposUsuario(Idusuario);
        return View();
    }
}
