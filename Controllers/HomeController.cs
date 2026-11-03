using System.Diagnostics;
using System.Globalization;
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
        int idGrupo = HttpContext.Session.GetInt32("IdGrupo") ?? 0;

        ViewBag.Proximos3Cuidadores = _bd.ObtenerProximos3Cuidadores(idGrupo);
        ViewBag.Proximos3Ejercicios = _bd.ObtenerProximos3Ejercicios(idGrupo);
        ViewBag.Proximos3Articulos = _bd.ObtenerProximos3Articulos(idGrupo);

        return View();
    }
    public IActionResult Cuidadores()
    {
        int idGrupo = HttpContext.Session.GetInt32("IdGrupo") ?? 0;
        int idUsuario = HttpContext.Session.GetInt32("IdUsuario") ?? 0;

        if (idGrupo <= 0)
        {
            return RedirectToAction("Grupo");
        }

        int idCuidador = _bd.ObtenerIdCuidadorPorUsuario(idUsuario);
        bool esPropietario = idCuidador > 0 && _bd.EsPropietarioDelGrupo(idGrupo, idCuidador);

        ViewBag.UltimosMensajes = _bd.ObtenerUltimosMensajes(idGrupo, 3);
        ViewBag.Cuidadores = _bd.ObtenerCuidadoresDelGrupo(idGrupo);
        ViewBag.EventosDelMes = _bd.ObtenerEventosDelMes(idGrupo, DateTime.Today.Year, DateTime.Today.Month);
        ViewBag.NombreGrupo = _bd.ObtenerNombreGrupo(idGrupo);
        ViewBag.EsPropietario = esPropietario;
        ViewBag.IdGrupoActual = idGrupo;
        ViewBag.MesActual = CultureInfo.GetCultureInfo("es-AR").DateTimeFormat.GetMonthName(DateTime.Today.Month);
        ViewBag.AnioActual = DateTime.Today.Year;

        return View();
    }

    [HttpPost]
    public IActionResult AgregarCuidador(string identificador)
    {
        int idGrupo = HttpContext.Session.GetInt32("IdGrupo") ?? 0;
        int idUsuario = HttpContext.Session.GetInt32("IdUsuario") ?? 0;

        if (idGrupo <= 0 || idUsuario <= 0)
        {
            return Json(new { success = false, message = "Sesión inválida." });
        }

        int idCuidadorSolicitante = _bd.ObtenerIdCuidadorPorUsuario(idUsuario);
        bool esPropietario = idCuidadorSolicitante > 0 && _bd.EsPropietarioDelGrupo(idGrupo, idCuidadorSolicitante);
        if (!esPropietario)
        {
            return StatusCode(403, new { success = false, message = "No tienes permisos para agregar cuidadores." });
        }

        int resultado = _bd.AgregarCuidadorPorIdentificador(idGrupo, identificador);
        return resultado switch
        {
            1 => Json(new { success = true, message = "Cuidador agregado correctamente." }),
            -1 => Json(new { success = false, message = "No se encontró un cuidador con ese identificador." }),
            -2 => Json(new { success = false, message = "Ese cuidador ya pertenece al grupo." }),
            -3 => Json(new { success = false, message = "No es posible realizar la operación con los permisos actuales." }),
            _ => Json(new { success = false, message = "No se pudo agregar el cuidador." })
        };
    }

    [HttpPost]
    public IActionResult EliminarCuidador(int idCuidadorAEliminar)
    {
        int idGrupo = HttpContext.Session.GetInt32("IdGrupo") ?? 0;
        int idUsuario = HttpContext.Session.GetInt32("IdUsuario") ?? 0;

        if (idGrupo <= 0 || idUsuario <= 0)
        {
            return Json(new { success = false, message = "Sesión inválida." });
        }

        int idCuidadorSolicitante = _bd.ObtenerIdCuidadorPorUsuario(idUsuario);
        bool esPropietario = idCuidadorSolicitante > 0 && _bd.EsPropietarioDelGrupo(idGrupo, idCuidadorSolicitante);
        if (!esPropietario)
        {
            return StatusCode(403, new { success = false, message = "No tienes permisos para eliminar cuidadores." });
        }

        if (idCuidadorAEliminar <= 0)
        {
            return Json(new { success = false, message = "Cuidador inválido." });
        }

        if (idCuidadorAEliminar == idCuidadorSolicitante)
        {
            return Json(new { success = false, message = "No puedes eliminarte a ti mismo siendo propietario." });
        }

        if (_bd.EsPropietarioDelGrupo(idGrupo, idCuidadorAEliminar))
        {
            return Json(new { success = false, message = "No se puede eliminar al propietario del grupo." });
        }

        bool eliminado = _bd.EliminarCuidadorDeGrupo(idGrupo, idCuidadorAEliminar);
        return Json(new
        {
            success = eliminado,
            message = eliminado ? "Cuidador eliminado correctamente." : "No se pudo eliminar el cuidador."
        });
    }
    public IActionResult AgregarInfoMedica()
    {
        return View();
    }
    public IActionResult EditarAdultoMayor()
    {
        return View();
    }
    public IActionResult Recordatorios()
    {
        return View();
    }
    public IActionResult AdultoMayor()
    {
        ViewBag.Recordatorios = _bd.ObtenerRecordatorios(HttpContext.Session.GetInt32("IdGrupo") ?? 0);
        ViewBag.AdultoMayor = _bd.ObtenerAdultoMayorPorGrupo(HttpContext.Session.GetInt32("IdGrupo") ?? 0);
        ViewBag.Medicaciones = _bd.ObtenerMedicaciones(HttpContext.Session.GetInt32("IdGrupo") ?? 0);
        ViewBag.Episodios = _bd.ObtenerEpisodios(HttpContext.Session.GetInt32("IdGrupo") ?? 0);
        ViewBag.Documentos = _bd.ObtenerDocumentos(HttpContext.Session.GetInt32("IdGrupo") ?? 0);
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
    public IActionResult Dashboard(int? idGrupo)
    {  
        int? idUsuario = HttpContext.Session.GetInt32("IdUsuario");

        if (idGrupo == null || idGrupo <= 0)
        {
            idGrupo = HttpContext.Session.GetInt32("IdGrupo");
        }

        if (idGrupo == null || idGrupo <= 0)
        {
            return RedirectToAction("Grupo", new { idUsuario = idUsuario ?? 0 });
        }

        if (string.IsNullOrWhiteSpace(_bd.ObtenerNombreGrupo(idGrupo.Value)))
        {
            return RedirectToAction("Grupo", new { idUsuario = idUsuario ?? 0 });
        }

        HttpContext.Session.SetInt32("IdGrupo", idGrupo.Value);

        ViewBag.NombreGrupo = _bd.ObtenerNombreGrupo(idGrupo.Value);
        ViewBag.NombreAdulto = _bd.ObtenerNombreAdulto(idGrupo.Value);
        ViewBag.Proximos5Eventos = _bd.ObtenerProximos5Eventos(idGrupo.Value);
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
