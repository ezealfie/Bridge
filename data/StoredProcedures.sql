USE [Bridge]
GO

-- 1. Obtener nombre del adulto mayor según el grupo
CREATE OR ALTER PROCEDURE ObtenerNombreAdulto
    @IdGrupo INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT u.nombre
    FROM dbo.Usuario u
    INNER JOIN dbo.AdultoMayor am ON u.id_usuario = am.id_usuario
    INNER JOIN dbo.Grupo g ON am.id_adultoMayor = g.id_adultoMayor
    WHERE g.id_grupo = @IdGrupo;
END
GO

-- 2. Obtener los próximos 5 eventos del grupo
CREATE OR ALTER PROCEDURE ObtenerProximos5Eventos
    @IdGrupo INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP 5 
        e.id_evento, 
        e.nombre, 
        e.fechaHora, 
        e.id_adultoMayor, 
        e.descripcion
    FROM dbo.Evento e
    INNER JOIN dbo.Grupo g ON e.id_adultoMayor = g.id_adultoMayor
    WHERE g.id_grupo = @IdGrupo
    ORDER BY e.fechaHora ASC;
END
GO

-- 3. Verificar si el usuario existe por email y devolver su id_usuario
CREATE OR ALTER PROCEDURE UsuarioExiste
    @Mail VARCHAR(150)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT id_usuario 
    FROM dbo.Usuario 
    WHERE mail = @Mail;
END
GO

-- 4. Verificar credenciales (id y contraseña)
CREATE OR ALTER PROCEDURE VerificarCredenciales
    @IdUsuario INT,
    @Password VARCHAR(225)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT COUNT(*) 
    FROM dbo.Usuario 
    WHERE id_usuario = @IdUsuario 
      AND [contraseña] = @Password;
END
GO

-- 5. Registrar un nuevo usuario
CREATE OR ALTER PROCEDURE RegistrarUsuario
    @Mail VARCHAR(150),
    @Contrasena VARCHAR(225),
    @Nombre VARCHAR(100),
    @Telefono VARCHAR(30) = '',
    @TipoUsuario VARCHAR(30),
    @FotoPerfil VARCHAR(500) = NULL,
    @NombreUsuario VARCHAR(50) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    IF @NombreUsuario IS NULL OR @NombreUsuario = ''
        SET @NombreUsuario = @Mail;

    INSERT INTO dbo.Usuario (mail, [contraseña], nombre, telefono, tipoUsuario, fotoPerfil, fecha_ingreso, nombreUsuario)
    VALUES (@Mail, @Contrasena, @Nombre, @Telefono, @TipoUsuario, @FotoPerfil, CONVERT(date, GETDATE()), @NombreUsuario);
END
GO

-- 6. Saber si un usuario es cuidador
CREATE OR ALTER PROCEDURE EsCuidador
    @IdUsuario INT
AS
BEGIN
    SET NOCOUNT ON;

    IF (SELECT tipoUsuario FROM dbo.Usuario WHERE id_usuario = @IdUsuario) = 'Cuidador'
       OR EXISTS (SELECT 1 FROM dbo.Cuidador WHERE id_usuario = @IdUsuario)
    BEGIN
        SELECT 1;
    END
    ELSE
    BEGIN
        SELECT 0;
    END
END
GO

-- 7. Obtener los grupos del usuario (sea cuidador o adulto mayor)
CREATE OR ALTER PROCEDURE ObtenerGruposUsuario
    @IdUsuario INT
AS
BEGIN
    SET NOCOUNT ON;

    IF (SELECT tipoUsuario FROM dbo.Usuario WHERE id_usuario = @IdUsuario) = 'Cuidador'
       OR EXISTS (SELECT 1 FROM dbo.Cuidador WHERE id_usuario = @IdUsuario)
    BEGIN
        SELECT 
            g.id_grupo, 
            g.Nombre, 
            g.id_adultoMayor, 
            g.descripcion
        FROM dbo.Grupo g
        INNER JOIN dbo.CuidadorGrupo cg ON g.id_grupo = cg.id_grupo
        INNER JOIN dbo.Cuidador c ON cg.id_cuidador = c.id_cuidador
        WHERE c.id_usuario = @IdUsuario;
    END
    ELSE
    BEGIN
        SELECT 
            g.id_grupo, 
            g.Nombre, 
            g.id_adultoMayor, 
            g.descripcion
        FROM dbo.Grupo g
        INNER JOIN dbo.AdultoMayor am ON g.id_adultoMayor = am.id_adultoMayor
        WHERE am.id_usuario = @IdUsuario;
    END
END
GO

-- 8. Obtener id de usuario por email
CREATE OR ALTER PROCEDURE ObtenerIdUsuario
    @Mail VARCHAR(150)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT id_usuario 
    FROM dbo.Usuario 
    WHERE mail = @Mail;
END
GO
