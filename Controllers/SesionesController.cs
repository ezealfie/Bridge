using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using Bridge.Models;
using System.Data;

namespace Bridge.Controllers;

public class SesionesController : Controller
{
    private readonly ILogger<SesionesController> _logger;

    public SesionesController(ILogger<SesionesController> logger)
    {
        _logger = logger;
    }
    BD bd = new BD();
    public IActionResult Index()
    {
        return View("Grupo");
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
    public IActionResult Login()
    {

        return View();
    }
public IActionResult LoginVerificar(string email, string password)
    {
        int id = bd.UsuarioExiste(email);
        //verificacion con la bd
        if (id != -1)
        {
            if (bd.VerificarCredenciales(id, password))
            {
                HttpContext.Session.SetInt32("IdUsuario", id);
                return RedirectToAction("Grupo", "Home", new { idUsuario = HttpContext.Session.GetInt32("IdUsuario")});
            }
            else
            {
                ViewBag.Error = "Contraseña incorrecta. Inténtalo de nuevo.";
                return View("Login");
            }
        }
        else
        {
            ViewBag.Error = "El correo electrónico no está registrado. Por favor, regístrese primero.";
            return View();
        }

    }

    public IActionResult Registrarse()
    {
        return View();
    }
    public IActionResult RegistrarseVerificar(string email, string password, string nombre, string apellido, string telefono)
    {
        if (bd.UsuarioExiste(email) != -1)
        {
            ViewBag.Error = "El correo electrónico ya está registrado. Por favor, inicia sesión.";
            return View();
        }
        else
        {
          
            bd.RegistrarUsuario(email, password, nombre, apellido, telefono);
            int idUsuario = bd.ObtenerIdUsuario(email);
            HttpContext.Session.SetInt32("IdUsuario", idUsuario);
            return RedirectToAction("Grupo", "Home", new { idUsuario = HttpContext.Session.GetInt32("IdUsuario") });
   
        }
        
        
    }
    public IActionResult Logout()
    {
        HttpContext.Session.Clear();
        return RedirectToAction("Login");
    }
}
