using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using Bridge.Models;

namespace Bridge.Controllers;

public class SesionesController : Controller
{
    private readonly ILogger<SesionesController> _logger;
    private readonly BD bd = new BD();

    public SesionesController(ILogger<SesionesController> logger)
    {
        _logger = logger;
    }

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

    [HttpPost]
    public IActionResult LoginVerificar(string? email, string? password, string? usuario, string? contrasena)
    {
        string mailInput = !string.IsNullOrWhiteSpace(email) ? email : (usuario ?? string.Empty);
        string passInput = !string.IsNullOrWhiteSpace(password) ? password : (contrasena ?? string.Empty);

        int id = bd.UsuarioExiste(mailInput);
        if (id != -1)
        {
            if (bd.VerificarCredenciales(id, passInput))
            {
                HttpContext.Session.SetInt32("IdUsuario", id);
                return RedirectToAction("Grupo", "Home", new { idUsuario = id });
            }
            else
            {
                ViewBag.Error = "Contraseña incorrecta. Inténtalo de nuevo.";
                ViewBag.Message = ViewBag.Error;
                return View("Login");
            }
        }
        else
        {
            ViewBag.Error = "El correo electrónico no está registrado. Por favor, regístrese primero.";
            ViewBag.Message = ViewBag.Error;
            return View("Login");
        }
    }

    public IActionResult Registrarse()
    {
        return View();
    }

    [HttpPost]
    public IActionResult RegistrarseVerificar(string email, string? password = null, string? contrasena = null, string nombre = "", string apellido = "", string telefono = "", string tipoUsuario = "Cuidador")
    {
        string passInput = !string.IsNullOrWhiteSpace(password) ? password : (contrasena ?? string.Empty);

        if (bd.UsuarioExiste(email) != -1)
        {
            ViewBag.Error = "El correo electrónico ya está registrado. Por favor, inicia sesión.";
            ViewBag.Message = ViewBag.Error;
            return View("Registrarse");
        }
        else
        {
            bd.RegistrarUsuario(email, passInput, nombre, apellido, telefono, tipoUsuario);
            int idUsuario = bd.ObtenerIdUsuario(email);
            HttpContext.Session.SetInt32("IdUsuario", idUsuario);
            return RedirectToAction("Grupo", "Home", new { idUsuario = idUsuario });
        }
    }

    public IActionResult Logout()
    {
        HttpContext.Session.Clear();
        return RedirectToAction("Login");
    }
}
