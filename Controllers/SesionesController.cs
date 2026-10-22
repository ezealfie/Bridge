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

                if (Request.Headers["X-Requested-With"] == "XMLHttpRequest")
                {
                    return Json(new { success = true, redirectUrl = Url.Action("Grupo", "Home", new { idUsuario = id }) });
                }

                return RedirectToAction("Grupo", "Home", new { idUsuario = id });
            }
            else
            {
                var errorMessage = "Contraseña incorrecta. Inténtalo de nuevo.";

                if (Request.Headers["X-Requested-With"] == "XMLHttpRequest")
                {
                    return Json(new { success = false, message = errorMessage });
                }

                ViewBag.Error = errorMessage;
                ViewBag.Message = ViewBag.Error;
                return View("Login");
            }
        }
        else
        {
            var errorMessage = "El correo electrónico no está registrado. Por favor, regístrese primero.";

            if (Request.Headers["X-Requested-With"] == "XMLHttpRequest")
            {
                return Json(new { success = false, message = errorMessage });
            }

            ViewBag.Error = errorMessage;
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
