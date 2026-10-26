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
    public IActionResult RegistrarseVerificar(string email, string? password = null, string? contrasena = null, string nombre = "", string apellido = "", string telefono = "", string tipoUsuario = "Cuidador", string? dni = null, DateTime? fechaNacimiento = null, string? condicion = null)
    {
        string passInput = !string.IsNullOrWhiteSpace(password) ? password : (contrasena ?? string.Empty);
        bool esAdultoMayor = !string.IsNullOrWhiteSpace(tipoUsuario) && tipoUsuario.Trim().StartsWith("adulto", StringComparison.OrdinalIgnoreCase);

        if (esAdultoMayor && (string.IsNullOrWhiteSpace(dni) || fechaNacimiento == null))
        {
            ViewBag.Error = "Para Adulto Mayor debes completar DNI y fecha de nacimiento.";
            ViewBag.Message = ViewBag.Error;
            return View("Registrarse");
        }

        if (bd.UsuarioExiste(email) != -1)
        {
            ViewBag.Error = "El correo electrónico ya está registrado. Por favor, inicia sesión.";
            ViewBag.Message = ViewBag.Error;
            return View("Registrarse");
        }
        else
        {
            int idUsuario = bd.RegistrarUsuario(email, passInput, nombre, apellido, telefono, tipoUsuario, dni, fechaNacimiento, condicion);

            if (idUsuario <= 0)
            {
                ViewBag.Error = "No se pudo completar el registro. Inténtalo nuevamente.";
                ViewBag.Message = ViewBag.Error;
                return View("Registrarse");
            }

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
