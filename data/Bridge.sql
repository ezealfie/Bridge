USE [master]
GO
/****** Object:  Database [Bridge]    Script Date: 20/10/2026 08:23:55 ******/
CREATE DATABASE [Bridge]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Bridge', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Bridge.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Bridge_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Bridge_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Bridge] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Bridge].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Bridge] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Bridge] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Bridge] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Bridge] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Bridge] SET ARITHABORT OFF 
GO
ALTER DATABASE [Bridge] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Bridge] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Bridge] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Bridge] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Bridge] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Bridge] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Bridge] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Bridge] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Bridge] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Bridge] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Bridge] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Bridge] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Bridge] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Bridge] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Bridge] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Bridge] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Bridge] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Bridge] SET RECOVERY FULL 
GO
ALTER DATABASE [Bridge] SET  MULTI_USER 
GO
ALTER DATABASE [Bridge] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Bridge] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Bridge] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Bridge] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Bridge] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Bridge', N'ON'
GO
ALTER DATABASE [Bridge] SET QUERY_STORE = OFF
GO
USE [Bridge]
GO
/****** Object:  User [alumno]    Script Date: 20/10/2026 08:23:55 ******/
CREATE USER [alumno] FOR LOGIN [alumno] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[AdultoMayor]    Script Date: 20/10/2026 08:23:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdultoMayor](
	[id_adultoMayor] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](100) NOT NULL,
	[apellido] [varchar](100) NOT NULL,
	[nombreUsuario] [varchar](50) NOT NULL,
	[contraseña] [varchar](255) NOT NULL,
	[mail] [varchar](150) NULL,
	[telefono] [varchar](50) NULL,
	[fecha_ingreso] [date] NOT NULL,
	[dni] [varchar](50) NOT NULL,
	[fecha_nacimiento] [date] NOT NULL,
	[condicion] [varchar](255) NULL,
	[fotoPerfil] [varchar](500) NULL,
 CONSTRAINT [PK__AdultoMa__87C4AADB79843C2B] PRIMARY KEY CLUSTERED 
(
	[id_adultoMayor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ__AdultoMa__A0436BD7BD27F1AC] UNIQUE NONCLUSTERED 
(
	[nombreUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ__AdultoMa__D87608A75A79279F] UNIQUE NONCLUSTERED 
(
	[dni] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Articulo]    Script Date: 20/10/2026 08:23:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Articulo](
	[id_articulo] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](150) NOT NULL,
	[descripcion] [varchar](max) NULL,
	[fechaPublicacion] [date] NOT NULL,
	[autor] [varchar](100) NULL,
 CONSTRAINT [PK__Articulo__3F6E82888935B542] PRIMARY KEY CLUSTERED 
(
	[id_articulo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cuidador]    Script Date: 20/10/2026 08:23:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cuidador](
	[id_cuidador] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](100) NOT NULL,
	[apellido] [varchar](100) NOT NULL,
	[nombreUsuario] [varchar](50) NOT NULL,
	[contraseña] [varchar](255) NOT NULL,
	[mail] [varchar](150) NOT NULL,
	[telefono] [varchar](50) NULL,
	[rol] [varchar](50) NOT NULL,
	[fotoPerfil] [varchar](500) NULL,
 CONSTRAINT [PK__Cuidador__5DEB10C5A16096D8] PRIMARY KEY CLUSTERED 
(
	[id_cuidador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ__Cuidador__7A212904E2FF077B] UNIQUE NONCLUSTERED 
(
	[mail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ__Cuidador__A0436BD729041290] UNIQUE NONCLUSTERED 
(
	[nombreUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CuidadorGrupo]    Script Date: 20/10/2026 08:23:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CuidadorGrupo](
	[id_cuidadorGrupo] [int] IDENTITY(1,1) NOT NULL,
	[id_grupo] [int] NOT NULL,
	[id_cuidador] [int] NOT NULL,
	[fechaIngreso] [date] NOT NULL,
	[estadoAutorizacion] [varchar](50) NOT NULL,
 CONSTRAINT [PK__Cuidador__77A13BC844CF50BB] PRIMARY KEY CLUSTERED 
(
	[id_cuidadorGrupo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_CuidadorGrupo] UNIQUE NONCLUSTERED 
(
	[id_grupo] ASC,
	[id_cuidador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Documento]    Script Date: 20/10/2026 08:23:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Documento](
	[id_documento] [int] IDENTITY(1,1) NOT NULL,
	[titulo] [varchar](150) NOT NULL,
	[fecha_hora] [datetime] NOT NULL,
	[id_registro] [int] NOT NULL,
	[descripcion] [varchar](500) NULL,
 CONSTRAINT [PK__Document__5D2EE7E5C4C35E7A] PRIMARY KEY CLUSTERED 
(
	[id_documento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ejercicio]    Script Date: 20/10/2026 08:23:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ejercicio](
	[id_ejercicio] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](100) NOT NULL,
	[descripcion] [varchar](500) NULL,
	[fechaPublicacion] [date] NOT NULL,
 CONSTRAINT [PK__Ejercici__7BB4D9DBFF499CBF] PRIMARY KEY CLUSTERED 
(
	[id_ejercicio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EjercicioAdulto]    Script Date: 20/10/2026 08:23:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EjercicioAdulto](
	[id_ejercicioAdulto] [int] IDENTITY(1,1) NOT NULL,
	[id_adultoMayor] [int] NOT NULL,
	[id_ejercicio] [int] NOT NULL,
	[hecho] [bit] NOT NULL,
	[puntaje] [float] NULL,
	[fechaRealizacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_ejercicioAdulto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Episodio]    Script Date: 20/10/2026 08:23:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Episodio](
	[id_episodio] [int] IDENTITY(1,1) NOT NULL,
	[titulo] [varchar](150) NOT NULL,
	[fecha_hora] [datetime] NOT NULL,
	[id_registro] [int] NOT NULL,
	[descripcion] [varchar](max) NULL,
	[causa] [varchar](500) NULL,
 CONSTRAINT [PK__Episodio__03DE01FA582E1049] PRIMARY KEY CLUSTERED 
(
	[id_episodio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Evento]    Script Date: 20/10/2026 08:23:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Evento](
	[id_evento] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](100) NOT NULL,
	[fechaHora] [datetime] NOT NULL,
	[id_adultoMayor] [int] NOT NULL,
	[descripcion] [varchar](500) NULL,
 CONSTRAINT [PK__Evento__AF150CA54F50AAD4] PRIMARY KEY CLUSTERED 
(
	[id_evento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Grupo]    Script Date: 20/10/2026 08:23:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Grupo](
	[id_grupo] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[id_adultoMayor] [int] NOT NULL,
	[descripcion] [varchar](500) NULL,
 CONSTRAINT [PK__Grupo__8B68D688C0C3E726] PRIMARY KEY CLUSTERED 
(
	[id_grupo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ__Grupo__87C4AADA0650C717] UNIQUE NONCLUSTERED 
(
	[id_adultoMayor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Medicacion]    Script Date: 20/10/2026 08:23:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Medicacion](
	[id_medicacion] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[descripcion] [varchar](500) NULL,
 CONSTRAINT [PK__Medicaci__FACF5C677F18B195] PRIMARY KEY CLUSTERED 
(
	[id_medicacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MedicacionRegistro]    Script Date: 20/10/2026 08:23:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MedicacionRegistro](
	[id_medicacionRegistro] [int] IDENTITY(1,1) NOT NULL,
	[id_registro] [int] NOT NULL,
	[horario] [datetime] NOT NULL,
	[id_medicacion] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_medicacionRegistro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Mensaje]    Script Date: 20/10/2026 08:23:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mensaje](
	[id_mensaje] [int] IDENTITY(1,1) NOT NULL,
	[id_grupo] [int] NOT NULL,
	[id_cuidador] [int] NOT NULL,
	[contenido] [varchar](max) NOT NULL,
	[fechaHora] [datetime] NOT NULL,
 CONSTRAINT [PK__Mensaje__5B37C7F6E9A2AFAD] PRIMARY KEY CLUSTERED 
(
	[id_mensaje] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Recordatorio]    Script Date: 20/10/2026 08:23:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Recordatorio](
	[id_recordatorio] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](100) NOT NULL,
	[descripcion] [varchar](500) NULL,
	[fechaHora] [datetime] NOT NULL,
	[id_adultoMayor] [int] NOT NULL,
 CONSTRAINT [PK__Recordat__F82EFCBB7A67C6B4] PRIMARY KEY CLUSTERED 
(
	[id_recordatorio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RecordatorioCuidador]    Script Date: 20/10/2026 08:23:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecordatorioCuidador](
	[id_recordatorioCuidador] [int] IDENTITY(1,1) NOT NULL,
	[id_cuidador] [int] NOT NULL,
	[id_recordatorio] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_recordatorioCuidador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_RecCuid] UNIQUE NONCLUSTERED 
(
	[id_cuidador] ASC,
	[id_recordatorio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RegistroMedico]    Script Date: 20/10/2026 08:23:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RegistroMedico](
	[id_registro] [int] IDENTITY(1,1) NOT NULL,
	[id_adultoMayor] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_registro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[id_adultoMayor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [IX_Documento_Registro]    Script Date: 20/10/2026 08:23:55 ******/
CREATE NONCLUSTERED INDEX [IX_Documento_Registro] ON [dbo].[Documento]
(
	[id_registro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_EjAdulto_Adulto]    Script Date: 20/10/2026 08:23:55 ******/
CREATE NONCLUSTERED INDEX [IX_EjAdulto_Adulto] ON [dbo].[EjercicioAdulto]
(
	[id_adultoMayor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_EjAdulto_Ejercicio]    Script Date: 20/10/2026 08:23:55 ******/
CREATE NONCLUSTERED INDEX [IX_EjAdulto_Ejercicio] ON [dbo].[EjercicioAdulto]
(
	[id_ejercicio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Episodio_Registro]    Script Date: 20/10/2026 08:23:55 ******/
CREATE NONCLUSTERED INDEX [IX_Episodio_Registro] ON [dbo].[Episodio]
(
	[id_registro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Evento_Adulto_Fecha]    Script Date: 20/10/2026 08:23:55 ******/
CREATE NONCLUSTERED INDEX [IX_Evento_Adulto_Fecha] ON [dbo].[Evento]
(
	[id_adultoMayor] ASC,
	[fechaHora] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_MedReg_Registro]    Script Date: 20/10/2026 08:23:55 ******/
CREATE NONCLUSTERED INDEX [IX_MedReg_Registro] ON [dbo].[MedicacionRegistro]
(
	[id_registro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Mensaje_Grupo_Fecha]    Script Date: 20/10/2026 08:23:55 ******/
CREATE NONCLUSTERED INDEX [IX_Mensaje_Grupo_Fecha] ON [dbo].[Mensaje]
(
	[id_grupo] ASC,
	[fechaHora] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Recordatorio_Adulto]    Script Date: 20/10/2026 08:23:55 ******/
CREATE NONCLUSTERED INDEX [IX_Recordatorio_Adulto] ON [dbo].[Recordatorio]
(
	[id_adultoMayor] ASC,
	[fechaHora] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AdultoMayor] ADD  CONSTRAINT [DF__AdultoMay__fecha__5AEE82B9]  DEFAULT (CONVERT([date],getdate())) FOR [fecha_ingreso]
GO
ALTER TABLE [dbo].[Articulo] ADD  CONSTRAINT [DF__Articulo__fechaP__5BE2A6F2]  DEFAULT (CONVERT([date],getdate())) FOR [fechaPublicacion]
GO
ALTER TABLE [dbo].[CuidadorGrupo] ADD  CONSTRAINT [DF__CuidadorG__fecha__5CD6CB2B]  DEFAULT (CONVERT([date],getdate())) FOR [fechaIngreso]
GO
ALTER TABLE [dbo].[CuidadorGrupo] ADD  CONSTRAINT [DF__CuidadorG__estad__5DCAEF64]  DEFAULT ('pendiente') FOR [estadoAutorizacion]
GO
ALTER TABLE [dbo].[Documento] ADD  CONSTRAINT [DF__Documento__fecha__5EBF139D]  DEFAULT (getdate()) FOR [fecha_hora]
GO
ALTER TABLE [dbo].[Ejercicio] ADD  CONSTRAINT [DF__Ejercicio__fecha__5FB337D6]  DEFAULT (CONVERT([date],getdate())) FOR [fechaPublicacion]
GO
ALTER TABLE [dbo].[EjercicioAdulto] ADD  DEFAULT ((0)) FOR [hecho]
GO
ALTER TABLE [dbo].[Episodio] ADD  CONSTRAINT [DF__Episodio__fecha___619B8048]  DEFAULT (getdate()) FOR [fecha_hora]
GO
ALTER TABLE [dbo].[Mensaje] ADD  CONSTRAINT [DF__Mensaje__fechaHo__628FA481]  DEFAULT (getdate()) FOR [fechaHora]
GO
ALTER TABLE [dbo].[CuidadorGrupo]  WITH CHECK ADD  CONSTRAINT [FK_CuidadorGrupo_Cuidador] FOREIGN KEY([id_cuidador])
REFERENCES [dbo].[Cuidador] ([id_cuidador])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CuidadorGrupo] CHECK CONSTRAINT [FK_CuidadorGrupo_Cuidador]
GO
ALTER TABLE [dbo].[CuidadorGrupo]  WITH CHECK ADD  CONSTRAINT [FK_CuidadorGrupo_Grupo] FOREIGN KEY([id_grupo])
REFERENCES [dbo].[Grupo] ([id_grupo])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CuidadorGrupo] CHECK CONSTRAINT [FK_CuidadorGrupo_Grupo]
GO
ALTER TABLE [dbo].[Documento]  WITH CHECK ADD  CONSTRAINT [FK_Documento_Registro] FOREIGN KEY([id_registro])
REFERENCES [dbo].[RegistroMedico] ([id_registro])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Documento] CHECK CONSTRAINT [FK_Documento_Registro]
GO
ALTER TABLE [dbo].[EjercicioAdulto]  WITH CHECK ADD  CONSTRAINT [FK_EjAdulto_AdultoMayor] FOREIGN KEY([id_adultoMayor])
REFERENCES [dbo].[AdultoMayor] ([id_adultoMayor])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EjercicioAdulto] CHECK CONSTRAINT [FK_EjAdulto_AdultoMayor]
GO
ALTER TABLE [dbo].[EjercicioAdulto]  WITH CHECK ADD  CONSTRAINT [FK_EjAdulto_Ejercicio] FOREIGN KEY([id_ejercicio])
REFERENCES [dbo].[Ejercicio] ([id_ejercicio])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EjercicioAdulto] CHECK CONSTRAINT [FK_EjAdulto_Ejercicio]
GO
ALTER TABLE [dbo].[Episodio]  WITH CHECK ADD  CONSTRAINT [FK_Episodio_Registro] FOREIGN KEY([id_registro])
REFERENCES [dbo].[RegistroMedico] ([id_registro])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Episodio] CHECK CONSTRAINT [FK_Episodio_Registro]
GO
ALTER TABLE [dbo].[Evento]  WITH CHECK ADD  CONSTRAINT [FK_Evento_AdultoMayor] FOREIGN KEY([id_adultoMayor])
REFERENCES [dbo].[AdultoMayor] ([id_adultoMayor])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Evento] CHECK CONSTRAINT [FK_Evento_AdultoMayor]
GO
ALTER TABLE [dbo].[Grupo]  WITH CHECK ADD  CONSTRAINT [FK_Grupo_AdultoMayor] FOREIGN KEY([id_adultoMayor])
REFERENCES [dbo].[AdultoMayor] ([id_adultoMayor])
GO
ALTER TABLE [dbo].[Grupo] CHECK CONSTRAINT [FK_Grupo_AdultoMayor]
GO
ALTER TABLE [dbo].[MedicacionRegistro]  WITH CHECK ADD  CONSTRAINT [FK_MedReg_Medicacion] FOREIGN KEY([id_medicacion])
REFERENCES [dbo].[Medicacion] ([id_medicacion])
GO
ALTER TABLE [dbo].[MedicacionRegistro] CHECK CONSTRAINT [FK_MedReg_Medicacion]
GO
ALTER TABLE [dbo].[MedicacionRegistro]  WITH CHECK ADD  CONSTRAINT [FK_MedReg_Registro] FOREIGN KEY([id_registro])
REFERENCES [dbo].[RegistroMedico] ([id_registro])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[MedicacionRegistro] CHECK CONSTRAINT [FK_MedReg_Registro]
GO
ALTER TABLE [dbo].[Mensaje]  WITH CHECK ADD  CONSTRAINT [FK_Mensaje_Cuidador] FOREIGN KEY([id_cuidador])
REFERENCES [dbo].[Cuidador] ([id_cuidador])
GO
ALTER TABLE [dbo].[Mensaje] CHECK CONSTRAINT [FK_Mensaje_Cuidador]
GO
ALTER TABLE [dbo].[Mensaje]  WITH CHECK ADD  CONSTRAINT [FK_Mensaje_Grupo] FOREIGN KEY([id_grupo])
REFERENCES [dbo].[Grupo] ([id_grupo])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Mensaje] CHECK CONSTRAINT [FK_Mensaje_Grupo]
GO
ALTER TABLE [dbo].[Recordatorio]  WITH CHECK ADD  CONSTRAINT [FK_Recordatorio_AdultoMayor] FOREIGN KEY([id_adultoMayor])
REFERENCES [dbo].[AdultoMayor] ([id_adultoMayor])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Recordatorio] CHECK CONSTRAINT [FK_Recordatorio_AdultoMayor]
GO
ALTER TABLE [dbo].[RecordatorioCuidador]  WITH CHECK ADD  CONSTRAINT [FK_RecCuid_Cuidador] FOREIGN KEY([id_cuidador])
REFERENCES [dbo].[Cuidador] ([id_cuidador])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RecordatorioCuidador] CHECK CONSTRAINT [FK_RecCuid_Cuidador]
GO
ALTER TABLE [dbo].[RecordatorioCuidador]  WITH CHECK ADD  CONSTRAINT [FK_RecCuid_Recordatorio] FOREIGN KEY([id_recordatorio])
REFERENCES [dbo].[Recordatorio] ([id_recordatorio])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RecordatorioCuidador] CHECK CONSTRAINT [FK_RecCuid_Recordatorio]
GO
ALTER TABLE [dbo].[RegistroMedico]  WITH CHECK ADD  CONSTRAINT [FK_RegMed_AdultoMayor] FOREIGN KEY([id_adultoMayor])
REFERENCES [dbo].[AdultoMayor] ([id_adultoMayor])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RegistroMedico] CHECK CONSTRAINT [FK_RegMed_AdultoMayor]
GO
ALTER TABLE [dbo].[CuidadorGrupo]  WITH CHECK ADD  CONSTRAINT [CK_CuidadorGrupo_Estado] CHECK  (([estadoAutorizacion]='rechazado' OR [estadoAutorizacion]='autorizado' OR [estadoAutorizacion]='pendiente'))
GO
ALTER TABLE [dbo].[CuidadorGrupo] CHECK CONSTRAINT [CK_CuidadorGrupo_Estado]
GO
USE [master]
GO
ALTER DATABASE [Bridge] SET  READ_WRITE 
GO
