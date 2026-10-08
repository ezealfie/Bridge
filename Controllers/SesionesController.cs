using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using Bridge.Models;

namespace Bridge.Controllers;

public class SesionesController : Controller
{
    private readonly ILogger<SesionesController> _logger;

    public SesionesController(ILogger<SesionesController> logger)
    {
        _logger = logger;
    }

    public IActionResult Index()
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
public IActionResult Login()
    {

        return View();
    }
}
public IActionResult Login(string username, string password)
    {
        //desarrollar login
        if (username == "admin" && password == "password") 
        {
            HttpContext.Session.SetString("Username", username);
            return RedirectToAction("Dashboard", "Home");
        }
        else
        {
            ViewBag.ErrorMessage = "Nombre de usuario o contraseña incorrectos.";
            return View();
        }
    }

    public IActionResult Logout()
    {
        HttpContext.Session.Clear();
        return RedirectToAction("Login");
    }
}
    