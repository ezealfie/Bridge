// Please see documentation at https://learn.microsoft.com/aspnet/core/client-side/bundling-and-minification
// for details on configuring this project to bundle and minify static web assets.

// Write your JavaScript code.

document.addEventListener('DOMContentLoaded', function () {
    const loginForm = document.getElementById('login-form');
    const registerForm = document.getElementById('register-form');

    const showMessage = (selector, message) => {
        const box = document.querySelector(selector);
        if (!box) return;

        if (message && message.trim()) {
            box.textContent = message.trim();
            box.style.display = 'block';
        } else {
            box.textContent = '';
            box.style.display = 'none';
        }
    };

    if (loginForm) {
        loginForm.addEventListener('submit', function (event) {
            event.preventDefault();

            const email = loginForm.querySelector('input[name="email"]')?.value.trim();
            const password = loginForm.querySelector('input[name="password"]')?.value.trim();

            if (!email || !password) {
                showMessage('#login-error', 'Completa email y contraseña para continuar.');
                return;
            }

            const formData = new FormData(loginForm);

            fetch(loginForm.action, {
                method: 'POST',
                body: formData,
                headers: {
                    'X-Requested-With': 'XMLHttpRequest'
                }
            })
            .then(async response => {
                const text = await response.text();

                try {
                    const data = JSON.parse(text);

                    if (data.success) {
                        window.location.href = data.redirectUrl;
                        return;
                    }

                    showMessage('#login-error', data.message || 'No se pudo iniciar sesión.');
                } catch (error) {
                    if (response.ok) {
                        window.location.reload();
                        return;
                    }
                    showMessage('#login-error', 'Hubo un problema al iniciar sesión.');
                }
            })
            .catch(() => {
                showMessage('#login-error', 'No se pudo conectar con el servidor.');
            });
        });
    }

    if (registerForm) {
        const registerMessage = document.getElementById('register-error')?.textContent.trim();
        if (registerMessage) {
            showMessage('#register-error', registerMessage);
        }
            const tipoUsuarioSelect = registerForm.querySelector('#tipoUsuario');
            const adultoMayorFields = registerForm.querySelector('#adulto-mayor-fields');
            const dniInput = registerForm.querySelector('input[name="dni"]');
            const fechaNacimientoInput = registerForm.querySelector('input[name="fechaNacimiento"]');

            const actualizarCamposPorTipoUsuario = () => {
                const esAdultoMayor = (tipoUsuarioSelect?.value || '').toLowerCase().includes('adulto');

                if (adultoMayorFields) {
                    adultoMayorFields.style.display = esAdultoMayor ? 'block' : 'none';
                }

                if (dniInput) {
                    dniInput.required = esAdultoMayor;
                    if (!esAdultoMayor) {
                        dniInput.value = '';
                    }
                }

                if (fechaNacimientoInput) {
                    fechaNacimientoInput.required = esAdultoMayor;
                    if (!esAdultoMayor) {
                        fechaNacimientoInput.value = '';
                    }
                }
            };

            actualizarCamposPorTipoUsuario();

            if (tipoUsuarioSelect) {
                tipoUsuarioSelect.addEventListener('change', actualizarCamposPorTipoUsuario);
            }

        registerForm.addEventListener('submit', function (event) {
            const password = registerForm.querySelector('input[name="contrasena"]')?.value;
            const repeatPassword = registerForm.querySelector('input[name="repetirContrasena"]')?.value;
                const esAdultoMayor = (tipoUsuarioSelect?.value || '').toLowerCase().includes('adulto');
                const dni = dniInput?.value.trim();
                const fechaNacimiento = fechaNacimientoInput?.value;

            if (!password || !repeatPassword) {
                event.preventDefault();
                showMessage('#register-error', 'Completá ambas contraseñas.');
                return;
            }

            if (password !== repeatPassword) {
                event.preventDefault();
                showMessage('#register-error', 'Las contraseñas no coinciden.');
                    return;
                }

                if (esAdultoMayor && (!dni || !fechaNacimiento)) {
                    event.preventDefault();
                    showMessage('#register-error', 'Para Adulto Mayor completá DNI y fecha de nacimiento.');
                    return;
                return;
            }
        });
    }
});
