# Pendientes / LEER

Estado: commits `1df4bbd` y `7da695d` pusheados a `main`. Bootstrap se restauró a pedido (no quitar).

## Verificación que faltó
- Tras reiniciar el servidor se perdió la sesión, por lo que **no se pudo confirmar visualmente logueado** el resultado final de:
  - `Dashboard.cshtml` (bloque `landing-brand` eliminado, "Cambiar grupo" movido al header).
  - `Cuidadores.cshtml` (avatares con iniciales, empty state con botón "Agregar cuidador").
  - `Herramientas.cshtml` (cards sin `min-height: 24rem`, sin placeholder gris).
  - `Configuracion.cshtml` (avatar con iniciales, botón "Cerrar sesión" en color de paleta).
  - Footer con Bootstrap restaurado (orden de elementos).
- Revisar `AdultoMayor` en móvil (390px) **con sesión activa**: al consolidar el CSS inline en `site.css`, el override mobile dejó de ser pisado por el `<style>` de la vista, pero no se reverificó con datos reales.
- No se corrieron gates de accesibilidad (axe/contraste/teclado) ni `verify_responsive`; los cambios son de juicio visual, no medidos.

## Mejoras detectadas y NO aplicadas
1. Unificar los dos sistemas de botones: `.primary-btn` (teal) vs `.btn` / `.btn-primary` de Bootstrap.
2. Quitar el `!important` masivo de `site.css` (especialmente `text-align` en headings) y usar especificidad/orden.
3. Variar los degradados idénticos de hero, dashboard, grupo, cards de auth y footer (Variance Mandate).
4. Reducir sombras: casi todos los cards tienen `box-shadow`; dejar solo superficies elevadas.
5. Definir escala única de `border-radius` (hay 14/16/18/24/28/32/999px).
6. Jerarquía de headings: several vistas siguen con `BRIDGE`/marca como `h1`; el título real de la página debería ser el `h1`.
7. Calendario de `Cuidadores`: días con `<span>` no interactivos; usar `<button>` o `role="gridcell"`.
8. Empty states con CTA en Dashboard (eventos) y `AdultoMayor` (medicaciones/episodios/documentos).
9. Toggles de `Configuracion` sin persistencia (solo cambian texto/clase con JS); conectar al backend o deshabilitar.
10. Modal de `Cuidadores`: falta *focus trap* y devolver el foco al disparador al cerrar (tiene `role="dialog"`/`aria-modal`).
11. `Grupo.cshtml`: reemplazar `alert()` por mensaje inline con `aria-live`; además `@Html.Raw(Json.Serialize(...))` es riesgo XSS.
12. Links muertos de `Herramientas`: `VerContacto`, `AgregarContacto`, `HacerEjercicio`, `LeerArticulo` no existen como actions en `HomeController`.
13. `Términos de servicio` y redes sociales quedaron como `aria-disabled` (no llevan a ningún lado); falta destino real.
14. `Soporte` usa `mailto:soporte@bridge.com` genérico; Confirmar dirección real.
15. `Olvidé mi contraseña` no tiene flujo; implementar o quitar.
16. Validación de formularios (`novalidate` + JS parcial) en Login/Registrarse.
17. Imágenes restantes sin `loading="lazy"` / `width` / `height`.
18. Modularizar `site.css` (archivo único de ~2400 líneas) por secciones.
19. Extraer los `<script>` inline de las vistas a archivos `.js` cacheables.
20. Revisar colores hardcoded (`#0d8d92`, `#82dfe2`, `#3ec7ca`, etc.) y llevarlos a variables.
21. Avatar de `Configuracion` muestra "U": `ViewBag.nombre` parece venir vacío desde BD; verificar el dato y el cálculo de iniciales.
22. Bootstrap cargado dos veces (local + CDN): se dejó así a pedido del usuario.
23. El error de consola `WebSocket wss://localhost:* err_cert_authority_invalid` es del hot-reload de desarrollo, no de la UI.
