USE [master]
GO
/****** Object:  Database [DbCinema]    Script Date: 5/27/2022 4:57:55 PM ******/
CREATE DATABASE [DbCinema]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DbCinema', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\DbCinema.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DbCinema_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\DbCinema_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [DbCinema] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DbCinema].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DbCinema] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DbCinema] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DbCinema] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DbCinema] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DbCinema] SET ARITHABORT OFF 
GO
ALTER DATABASE [DbCinema] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [DbCinema] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DbCinema] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DbCinema] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DbCinema] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DbCinema] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DbCinema] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DbCinema] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DbCinema] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DbCinema] SET  ENABLE_BROKER 
GO
ALTER DATABASE [DbCinema] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DbCinema] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DbCinema] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DbCinema] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DbCinema] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DbCinema] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DbCinema] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DbCinema] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [DbCinema] SET  MULTI_USER 
GO
ALTER DATABASE [DbCinema] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DbCinema] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DbCinema] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DbCinema] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DbCinema] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DbCinema] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [DbCinema] SET QUERY_STORE = OFF
GO
USE [DbCinema]
GO
/****** Object:  Table [dbo].[Biglietto]    Script Date: 5/27/2022 4:57:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Biglietto](
	[IdBiglietto] [int] IDENTITY(1,1) NOT NULL,
	[Posto] [int] NOT NULL,
	[IdSala] [int] NOT NULL,
	[Prezzo] [decimal](18, 0) NOT NULL,
	[Valido] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdBiglietto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Film]    Script Date: 5/27/2022 4:57:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Film](
	[IdFilm] [int] IDENTITY(1,1) NOT NULL,
	[Titolo] [varchar](50) NOT NULL,
	[Autore] [varchar](50) NULL,
	[Produttore] [varchar](50) NULL,
	[Genere] [varchar](50) NOT NULL,
	[Durata] [decimal](18, 0) NULL,
 CONSTRAINT [PK_Film] PRIMARY KEY CLUSTERED 
(
	[IdFilm] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IncassiCinema]    Script Date: 5/27/2022 4:57:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IncassiCinema](
	[IdIncasso] [int] IDENTITY(1,1) NOT NULL,
	[IdSala] [int] NOT NULL,
	[Incasso] [decimal](18, 2) NOT NULL,
	[Data] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdIncasso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sala]    Script Date: 5/27/2022 4:57:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sala](
	[IdSala] [int] IDENTITY(1,1) NOT NULL,
	[Capienza] [int] NOT NULL,
	[PostiOccupati] [int] NOT NULL,
	[IdFilm] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdSala] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Spettatore]    Script Date: 5/27/2022 4:57:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Spettatore](
	[IdSpettatore] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [varchar](50) NULL,
	[Cognome] [varchar](50) NULL,
	[DataNascita] [datetime] NOT NULL,
	[IdBiglietto] [int] NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Biglietto] ON 

INSERT [dbo].[Biglietto] ([IdBiglietto], [Posto], [IdSala], [Prezzo], [Valido]) VALUES (1, 1, 1, CAST(5 AS Decimal(18, 0)), 0)
INSERT [dbo].[Biglietto] ([IdBiglietto], [Posto], [IdSala], [Prezzo], [Valido]) VALUES (2, 1, 2, CAST(5 AS Decimal(18, 0)), 1)
INSERT [dbo].[Biglietto] ([IdBiglietto], [Posto], [IdSala], [Prezzo], [Valido]) VALUES (3, 2, 2, CAST(5 AS Decimal(18, 0)), 1)
INSERT [dbo].[Biglietto] ([IdBiglietto], [Posto], [IdSala], [Prezzo], [Valido]) VALUES (4, 1, 1, CAST(5 AS Decimal(18, 0)), 0)
INSERT [dbo].[Biglietto] ([IdBiglietto], [Posto], [IdSala], [Prezzo], [Valido]) VALUES (5, 1, 1, CAST(5 AS Decimal(18, 0)), 0)
INSERT [dbo].[Biglietto] ([IdBiglietto], [Posto], [IdSala], [Prezzo], [Valido]) VALUES (6, 1, 1, CAST(5 AS Decimal(18, 0)), 0)
INSERT [dbo].[Biglietto] ([IdBiglietto], [Posto], [IdSala], [Prezzo], [Valido]) VALUES (7, 7, 1, CAST(5 AS Decimal(18, 0)), 0)
SET IDENTITY_INSERT [dbo].[Biglietto] OFF
GO
SET IDENTITY_INSERT [dbo].[Film] ON 

INSERT [dbo].[Film] ([IdFilm], [Titolo], [Autore], [Produttore], [Genere], [Durata]) VALUES (1, N'2001 Odissea nello spazio', N'kubrik', N'Unversal', N'SciFi', CAST(179 AS Decimal(18, 0)))
INSERT [dbo].[Film] ([IdFilm], [Titolo], [Autore], [Produttore], [Genere], [Durata]) VALUES (2, N'Shining', N'kubrik', N'Universal', N'Horror', CAST(145 AS Decimal(18, 0)))
INSERT [dbo].[Film] ([IdFilm], [Titolo], [Autore], [Produttore], [Genere], [Durata]) VALUES (3, N'Django unchained', N'Tarantino', N'20 cerntury fox', N'Commedia', CAST(124 AS Decimal(18, 0)))
SET IDENTITY_INSERT [dbo].[Film] OFF
GO
SET IDENTITY_INSERT [dbo].[Sala] ON 

INSERT [dbo].[Sala] ([IdSala], [Capienza], [PostiOccupati], [IdFilm]) VALUES (1, 50, 0, 1)
INSERT [dbo].[Sala] ([IdSala], [Capienza], [PostiOccupati], [IdFilm]) VALUES (2, 40, 0, 2)
SET IDENTITY_INSERT [dbo].[Sala] OFF
GO
SET IDENTITY_INSERT [dbo].[Spettatore] ON 

INSERT [dbo].[Spettatore] ([IdSpettatore], [Nome], [Cognome], [DataNascita], [IdBiglietto]) VALUES (1, N'Mario', N'Super', CAST(N'1989-03-02T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Spettatore] ([IdSpettatore], [Nome], [Cognome], [DataNascita], [IdBiglietto]) VALUES (2, N'Marco', N'rossi', CAST(N'1923-03-12T00:00:00.000' AS DateTime), 2)
INSERT [dbo].[Spettatore] ([IdSpettatore], [Nome], [Cognome], [DataNascita], [IdBiglietto]) VALUES (3, N'Franco', N'Battiato', CAST(N'1943-02-04T00:00:00.000' AS DateTime), 3)
INSERT [dbo].[Spettatore] ([IdSpettatore], [Nome], [Cognome], [DataNascita], [IdBiglietto]) VALUES (4, N'Mario', N'Verdi', CAST(N'2000-01-01T01:00:00.000' AS DateTime), 5)
INSERT [dbo].[Spettatore] ([IdSpettatore], [Nome], [Cognome], [DataNascita], [IdBiglietto]) VALUES (5, N'gas', N'gas', CAST(N'2001-01-01T01:01:00.000' AS DateTime), 6)
INSERT [dbo].[Spettatore] ([IdSpettatore], [Nome], [Cognome], [DataNascita], [IdBiglietto]) VALUES (6, N'lino', N'banfi', CAST(N'2045-01-01T01:01:00.000' AS DateTime), 7)
SET IDENTITY_INSERT [dbo].[Spettatore] OFF
GO
ALTER TABLE [dbo].[Biglietto]  WITH CHECK ADD FOREIGN KEY([IdSala])
REFERENCES [dbo].[Sala] ([IdSala])
GO
ALTER TABLE [dbo].[IncassiCinema]  WITH CHECK ADD FOREIGN KEY([IdSala])
REFERENCES [dbo].[Sala] ([IdSala])
GO
ALTER TABLE [dbo].[Sala]  WITH CHECK ADD FOREIGN KEY([IdFilm])
REFERENCES [dbo].[Film] ([IdFilm])
GO
ALTER TABLE [dbo].[Spettatore]  WITH CHECK ADD FOREIGN KEY([IdBiglietto])
REFERENCES [dbo].[Biglietto] ([IdBiglietto])
GO
USE [master]
GO
ALTER DATABASE [DbCinema] SET  READ_WRITE 
GO
