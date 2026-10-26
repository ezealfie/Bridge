USE [master]
GO
/****** Object:  Database [Bridge]    Script Date: 21/10/2026 08:31:13 ******/
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
/****** Object:  User [alumno]    Script Date: 21/10/2026 08:31:13 ******/
CREATE USER [alumno] FOR LOGIN [alumno] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[AdultoMayor]    Script Date: 21/10/2026 08:31:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdultoMayor](
	[id_adultoMayor] [int] IDENTITY(1,1) NOT NULL,
	[dni] [varchar](50) NOT NULL,
	[fecha_nacimiento] [date] NOT NULL,
	[condicion] [varchar](255) NULL,
	[id_usuario] [int] NOT NULL,
	[fecha_ingreso] [date] NOT NULL,
 CONSTRAINT [PK__AdultoMa__87C4AADBCE59064F] PRIMARY KEY CLUSTERED 
(
	[id_adultoMayor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Articulo]    Script Date: 21/10/2026 08:31:13 ******/
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
 CONSTRAINT [PK__Articulo__3F6E8288577887A5] PRIMARY KEY CLUSTERED 
(
	[id_articulo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cuidador]    Script Date: 21/10/2026 08:31:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cuidador](
	[id_cuidador] [int] IDENTITY(1,1) NOT NULL,
	[id_usuario] [int] NOT NULL,
 CONSTRAINT [PK__Cuidador__5DEB10C5A24825EC] PRIMARY KEY CLUSTERED 
(
	[id_cuidador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CuidadorGrupo]    Script Date: 21/10/2026 08:31:13 ******/
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
 CONSTRAINT [PK__Cuidador__77A13BC899D134A2] PRIMARY KEY CLUSTERED 
(
	[id_cuidadorGrupo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Documento]    Script Date: 21/10/2026 08:31:13 ******/
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
 CONSTRAINT [PK__Document__5D2EE7E5BE9BF556] PRIMARY KEY CLUSTERED 
(
	[id_documento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ejercicio]    Script Date: 21/10/2026 08:31:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ejercicio](
	[id_ejercicio] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](100) NOT NULL,
	[descripcion] [varchar](500) NULL,
	[fechaPublicacion] [date] NOT NULL,
 CONSTRAINT [PK__Ejercici__7BB4D9DB9BD738F1] PRIMARY KEY CLUSTERED 
(
	[id_ejercicio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EjercicioAdulto]    Script Date: 21/10/2026 08:31:13 ******/
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
/****** Object:  Table [dbo].[Episodio]    Script Date: 21/10/2026 08:31:13 ******/
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
 CONSTRAINT [PK__Episodio__03DE01FA7A9DC78F] PRIMARY KEY CLUSTERED 
(
	[id_episodio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Evento]    Script Date: 21/10/2026 08:31:13 ******/
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
 CONSTRAINT [PK__Evento__AF150CA5AB13BB86] PRIMARY KEY CLUSTERED 
(
	[id_evento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Grupo]    Script Date: 21/10/2026 08:31:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Grupo](
	[id_grupo] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[id_adultoMayor] [int] NOT NULL,
	[descripcion] [varchar](500) NULL,
 CONSTRAINT [PK__Grupo__8B68D68807B05F12] PRIMARY KEY CLUSTERED 
(
	[id_grupo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Medicacion]    Script Date: 21/10/2026 08:31:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Medicacion](
	[id_medicacion] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[descripcion] [varchar](500) NULL,
 CONSTRAINT [PK__Medicaci__FACF5C67DD407736] PRIMARY KEY CLUSTERED 
(
	[id_medicacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MedicacionRegistro]    Script Date: 21/10/2026 08:31:13 ******/
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
/****** Object:  Table [dbo].[Mensaje]    Script Date: 21/10/2026 08:31:13 ******/
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
 CONSTRAINT [PK__Mensaje__5B37C7F65305B98B] PRIMARY KEY CLUSTERED 
(
	[id_mensaje] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Recordatorio]    Script Date: 21/10/2026 08:31:13 ******/
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
 CONSTRAINT [PK__Recordat__F82EFCBB42B9918E] PRIMARY KEY CLUSTERED 
(
	[id_recordatorio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RecordatorioCuidador]    Script Date: 21/10/2026 08:31:13 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RegistroMedico]    Script Date: 21/10/2026 08:31:13 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 21/10/2026 08:31:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[id_usuario] [int] IDENTITY(1,1) NOT NULL,
	[mail] [varchar](150) NOT NULL,
	[contraseña] [varchar](225) NOT NULL,
	[nombre] [varchar](100) NOT NULL,
	[telefono] [varchar](30) NOT NULL,
	[tipoUsuario] [varchar](30) NOT NULL,
	[fotoPerfil] [varchar](500) NULL,
	[fecha_ingreso] [date] NOT NULL,
	[nombreUsuario] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED 
(
	[id_usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__AdultoMa__D87608A79B775F8E]    Script Date: 21/10/2026 08:31:13 ******/
ALTER TABLE [dbo].[AdultoMayor] ADD  CONSTRAINT [UQ__AdultoMa__D87608A79B775F8E] UNIQUE NONCLUSTERED 
(
	[dni] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_CuidadorGrupo]    Script Date: 21/10/2026 08:31:13 ******/
ALTER TABLE [dbo].[CuidadorGrupo] ADD  CONSTRAINT [UQ_CuidadorGrupo] UNIQUE NONCLUSTERED 
(
	[id_grupo] ASC,
	[id_cuidador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Documento_Registro]    Script Date: 21/10/2026 08:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_Documento_Registro] ON [dbo].[Documento]
(
	[id_registro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_EjAdulto_Adulto]    Script Date: 21/10/2026 08:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_EjAdulto_Adulto] ON [dbo].[EjercicioAdulto]
(
	[id_adultoMayor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_EjAdulto_Ejercicio]    Script Date: 21/10/2026 08:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_EjAdulto_Ejercicio] ON [dbo].[EjercicioAdulto]
(
	[id_ejercicio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Episodio_Registro]    Script Date: 21/10/2026 08:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_Episodio_Registro] ON [dbo].[Episodio]
(
	[id_registro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Evento_Adulto_Fecha]    Script Date: 21/10/2026 08:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_Evento_Adulto_Fecha] ON [dbo].[Evento]
(
	[id_adultoMayor] ASC,
	[fechaHora] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Grupo__87C4AADAA68BC46B]    Script Date: 21/10/2026 08:31:13 ******/
ALTER TABLE [dbo].[Grupo] ADD  CONSTRAINT [UQ__Grupo__87C4AADAA68BC46B] UNIQUE NONCLUSTERED 
(
	[id_adultoMayor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_MedReg_Registro]    Script Date: 21/10/2026 08:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_MedReg_Registro] ON [dbo].[MedicacionRegistro]
(
	[id_registro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Mensaje_Grupo_Fecha]    Script Date: 21/10/2026 08:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_Mensaje_Grupo_Fecha] ON [dbo].[Mensaje]
(
	[id_grupo] ASC,
	[fechaHora] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Recordatorio_Adulto]    Script Date: 21/10/2026 08:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_Recordatorio_Adulto] ON [dbo].[Recordatorio]
(
	[id_adultoMayor] ASC,
	[fechaHora] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_RecCuid]    Script Date: 21/10/2026 08:31:13 ******/
ALTER TABLE [dbo].[RecordatorioCuidador] ADD  CONSTRAINT [UQ_RecCuid] UNIQUE NONCLUSTERED 
(
	[id_cuidador] ASC,
	[id_recordatorio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Registro__87C4AADAEB8C3C6D]    Script Date: 21/10/2026 08:31:13 ******/
ALTER TABLE [dbo].[RegistroMedico] ADD UNIQUE NONCLUSTERED 
(
	[id_adultoMayor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Usuario]    Script Date: 21/10/2026 08:31:13 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Usuario] ON [dbo].[Usuario]
(
	[mail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Articulo] ADD  CONSTRAINT [DF__Articulo__fechaP__59FA5E80]  DEFAULT (CONVERT([date],getdate())) FOR [fechaPublicacion]
GO
ALTER TABLE [dbo].[CuidadorGrupo] ADD  CONSTRAINT [DF__CuidadorG__fecha__5AEE82B9]  DEFAULT (CONVERT([date],getdate())) FOR [fechaIngreso]
GO
ALTER TABLE [dbo].[CuidadorGrupo] ADD  CONSTRAINT [DF__CuidadorG__estad__5BE2A6F2]  DEFAULT ('pendiente') FOR [estadoAutorizacion]
GO
ALTER TABLE [dbo].[Documento] ADD  CONSTRAINT [DF__Documento__fecha__5CD6CB2B]  DEFAULT (getdate()) FOR [fecha_hora]
GO
ALTER TABLE [dbo].[Ejercicio] ADD  CONSTRAINT [DF__Ejercicio__fecha__5DCAEF64]  DEFAULT (CONVERT([date],getdate())) FOR [fechaPublicacion]
GO
ALTER TABLE [dbo].[EjercicioAdulto] ADD  DEFAULT ((0)) FOR [hecho]
GO
ALTER TABLE [dbo].[Episodio] ADD  CONSTRAINT [DF__Episodio__fecha___5FB337D6]  DEFAULT (getdate()) FOR [fecha_hora]
GO
ALTER TABLE [dbo].[Mensaje] ADD  CONSTRAINT [DF__Mensaje__fechaHo__60A75C0F]  DEFAULT (getdate()) FOR [fechaHora]
GO
ALTER TABLE [dbo].[Usuario] ADD  CONSTRAINT [DF_Usuario_fecha_ingreso]  DEFAULT (CONVERT([date],getdate())) FOR [fecha_ingreso]
GO
ALTER TABLE [dbo].[AdultoMayor]  WITH CHECK ADD  CONSTRAINT [FK_AdultoMayor_Usuario] FOREIGN KEY([id_usuario])
REFERENCES [dbo].[Usuario] ([id_usuario])
GO
ALTER TABLE [dbo].[AdultoMayor] CHECK CONSTRAINT [FK_AdultoMayor_Usuario]
GO
ALTER TABLE [dbo].[Cuidador]  WITH CHECK ADD  CONSTRAINT [FK_Cuidador_Usuario] FOREIGN KEY([id_usuario])
REFERENCES [dbo].[Usuario] ([id_usuario])
GO
ALTER TABLE [dbo].[Cuidador] CHECK CONSTRAINT [FK_Cuidador_Usuario]
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

/****** Object:  StoredProcedures [dbo]    Script Date: 21/10/2026 ******/
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

-- Obtener el id_adultoMayor por DNI
CREATE OR ALTER PROCEDURE ObtenerIdAdultoMayorPorDni
    @Dni VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT id_adultoMayor
    FROM dbo.AdultoMayor
    WHERE dni = @Dni;
END
GO

-- Crear un grupo y dejar la invitación del adulto como pendiente hasta aceptar
CREATE OR ALTER PROCEDURE CrearGrupo
    @Nombre VARCHAR(100),
    @IdAdultoMayor INT,
    @Descripcion VARCHAR(500) = NULL,
    @IdCuidador INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM dbo.Grupo WHERE id_adultoMayor = @IdAdultoMayor)
    BEGIN
        SELECT 0;
        RETURN;
    END

    INSERT INTO dbo.Grupo (Nombre, id_adultoMayor, descripcion)
    VALUES (@Nombre, @IdAdultoMayor, @Descripcion);

    DECLARE @IdGrupo INT = SCOPE_IDENTITY();

    IF @IdCuidador IS NOT NULL
    BEGIN
        INSERT INTO dbo.CuidadorGrupo (id_grupo, id_cuidador, fechaIngreso, estadoAutorizacion)
        VALUES (@IdGrupo, @IdCuidador, CONVERT(date, GETDATE()), 'autorizado');
    END

    SELECT @IdGrupo;
END
GO

-- Obtener el id_cuidador a partir del id_usuario
CREATE OR ALTER PROCEDURE ObtenerIdCuidadorPorUsuario
    @IdUsuario INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT id_cuidador
    FROM dbo.Cuidador
    WHERE id_usuario = @IdUsuario;
END
GO

-- Asociar un cuidador a un grupo
CREATE OR ALTER PROCEDURE AgregarCuidadorAGrupo
    @IdGrupo INT,
    @IdCuidador INT,
    @EstadoAutorizacion VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM dbo.Grupo WHERE id_grupo = @IdGrupo)
    BEGIN
        SELECT 0;
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM dbo.Cuidador WHERE id_cuidador = @IdCuidador)
    BEGIN
        SELECT 0;
        RETURN;
    END

    IF EXISTS (
        SELECT 1
        FROM dbo.CuidadorGrupo
        WHERE id_grupo = @IdGrupo
          AND id_cuidador = @IdCuidador
    )
    BEGIN
        SELECT 0;
        RETURN;
    END

    INSERT INTO dbo.CuidadorGrupo (id_grupo, id_cuidador, fechaIngreso, estadoAutorizacion)
    VALUES (@IdGrupo, @IdCuidador, CONVERT(date, GETDATE()), @EstadoAutorizacion);

    SELECT 1;
END
GO

-- Obtener el id_adultoMayor del usuario actual
CREATE OR ALTER PROCEDURE ObtenerIdAdultoMayorPorUsuario
    @IdUsuario INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT am.id_adultoMayor
    FROM dbo.AdultoMayor am
    WHERE am.id_usuario = @IdUsuario;
END
GO

-- Obtener tipo de usuario
CREATE OR ALTER PROCEDURE ObtenerTipoUsuario
    @IdUsuario INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT tipoUsuario
    FROM dbo.Usuario
    WHERE id_usuario = @IdUsuario;
END
GO
USE [master]
GO
ALTER DATABASE [Bridge] SET  READ_WRITE 
GO

/****** Object:  StoredProcedures [dbo]    Script Date: 21/10/2026 ******/
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

-- Obtener el id_adultoMayor por DNI
CREATE OR ALTER PROCEDURE ObtenerIdAdultoMayorPorDni
    @Dni VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT id_adultoMayor
    FROM dbo.AdultoMayor
    WHERE dni = @Dni;
END
GO

-- Crear un grupo y dejar la invitación del adulto como pendiente hasta aceptar
CREATE OR ALTER PROCEDURE CrearGrupo
    @Nombre VARCHAR(100),
    @IdAdultoMayor INT,
    @Descripcion VARCHAR(500) = NULL,
    @IdCuidador INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM dbo.Grupo WHERE id_adultoMayor = @IdAdultoMayor)
    BEGIN
        SELECT 0;
        RETURN;
    END

    INSERT INTO dbo.Grupo (Nombre, id_adultoMayor, descripcion)
    VALUES (@Nombre, @IdAdultoMayor, @Descripcion);

    DECLARE @IdGrupo INT = SCOPE_IDENTITY();

    IF @IdCuidador IS NOT NULL
    BEGIN
        INSERT INTO dbo.CuidadorGrupo (id_grupo, id_cuidador, fechaIngreso, estadoAutorizacion)
        VALUES (@IdGrupo, @IdCuidador, CONVERT(date, GETDATE()), 'autorizado');
    END

    SELECT @IdGrupo;
END
GO

-- Obtener el id_cuidador a partir del id_usuario
CREATE OR ALTER PROCEDURE ObtenerIdCuidadorPorUsuario
    @IdUsuario INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT id_cuidador
    FROM dbo.Cuidador
    WHERE id_usuario = @IdUsuario;
END
GO

-- Asociar un cuidador a un grupo
CREATE OR ALTER PROCEDURE AgregarCuidadorAGrupo
    @IdGrupo INT,
    @IdCuidador INT,
    @EstadoAutorizacion VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM dbo.Grupo WHERE id_grupo = @IdGrupo)
    BEGIN
        SELECT 0;
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM dbo.Cuidador WHERE id_cuidador = @IdCuidador)
    BEGIN
        SELECT 0;
        RETURN;
    END

    IF EXISTS (
        SELECT 1
        FROM dbo.CuidadorGrupo
        WHERE id_grupo = @IdGrupo
          AND id_cuidador = @IdCuidador
    )
    BEGIN
        SELECT 0;
        RETURN;
    END

    INSERT INTO dbo.CuidadorGrupo (id_grupo, id_cuidador, fechaIngreso, estadoAutorizacion)
    VALUES (@IdGrupo, @IdCuidador, CONVERT(date, GETDATE()), @EstadoAutorizacion);

    SELECT 1;
END
GO

-- Obtener el id_adultoMayor del usuario actual
CREATE OR ALTER PROCEDURE ObtenerIdAdultoMayorPorUsuario
    @IdUsuario INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT am.id_adultoMayor
    FROM dbo.AdultoMayor am
    WHERE am.id_usuario = @IdUsuario;
END
GO

-- Obtener tipo de usuario
CREATE OR ALTER PROCEDURE ObtenerTipoUsuario
    @IdUsuario INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT tipoUsuario
    FROM dbo.Usuario
    WHERE id_usuario = @IdUsuario;
END
GO
