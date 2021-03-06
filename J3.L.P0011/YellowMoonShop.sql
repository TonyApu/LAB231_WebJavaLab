USE [master]
GO
/****** Object:  Database [YellowMoonShop]    Script Date: 23/09/2021 22:39:18 ******/
CREATE DATABASE [YellowMoonShop]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'YellowMoonShop', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\YellowMoonShop.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'YellowMoonShop_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\YellowMoonShop_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [YellowMoonShop] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [YellowMoonShop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [YellowMoonShop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [YellowMoonShop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [YellowMoonShop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [YellowMoonShop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [YellowMoonShop] SET ARITHABORT OFF 
GO
ALTER DATABASE [YellowMoonShop] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [YellowMoonShop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [YellowMoonShop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [YellowMoonShop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [YellowMoonShop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [YellowMoonShop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [YellowMoonShop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [YellowMoonShop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [YellowMoonShop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [YellowMoonShop] SET  DISABLE_BROKER 
GO
ALTER DATABASE [YellowMoonShop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [YellowMoonShop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [YellowMoonShop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [YellowMoonShop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [YellowMoonShop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [YellowMoonShop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [YellowMoonShop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [YellowMoonShop] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [YellowMoonShop] SET  MULTI_USER 
GO
ALTER DATABASE [YellowMoonShop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [YellowMoonShop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [YellowMoonShop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [YellowMoonShop] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [YellowMoonShop] SET DELAYED_DURABILITY = DISABLED 
GO
USE [YellowMoonShop]
GO
/****** Object:  Table [dbo].[Cake]    Script Date: 23/09/2021 22:39:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cake](
	[cake_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[image] [varchar](200) NULL,
	[description] [nvarchar](500) NULL,
	[price] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	[create_date] [datetime] NOT NULL,
	[expiration_date] [datetime] NOT NULL,
	[category_id] [int] NOT NULL,
	[cake_status] [varchar](20) NOT NULL DEFAULT ('Active'),
PRIMARY KEY CLUSTERED 
(
	[cake_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Category]    Script Date: 23/09/2021 22:39:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[category_id] [int] IDENTITY(1,1) NOT NULL,
	[category_name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderCake]    Script Date: 23/09/2021 22:39:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OrderCake](
	[order_id] [varchar](25) NOT NULL,
	[username] [varchar](200) NOT NULL,
	[full_name] [nvarchar](100) NOT NULL,
	[phone] [varchar](20) NOT NULL,
	[address] [nvarchar](200) NOT NULL,
	[total] [int] NOT NULL,
	[order_date] [datetime] NOT NULL,
	[order_status] [varchar](20) NULL DEFAULT ('Confirmed'),
PRIMARY KEY CLUSTERED 
(
	[order_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 23/09/2021 22:39:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[order_id] [varchar](25) NOT NULL,
	[cake_id] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	[price] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[order_id] ASC,
	[cake_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RecordUpdate]    Script Date: 23/09/2021 22:39:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RecordUpdate](
	[record_id] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](200) NOT NULL,
	[cake_id] [int] NOT NULL,
	[update_time] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[record_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Role]    Script Date: 23/09/2021 22:39:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Role](
	[role_id] [varchar](10) NOT NULL,
	[role_name] [varchar](25) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserInfor]    Script Date: 23/09/2021 22:39:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserInfor](
	[username] [varchar](200) NOT NULL,
	[password] [varchar](50) NOT NULL,
	[full_name] [nvarchar](100) NOT NULL,
	[phone] [varchar](15) NULL,
	[address] [nvarchar](200) NULL,
	[role_id] [varchar](10) NOT NULL,
	[user_status] [varchar](20) NOT NULL DEFAULT ('Active'),
PRIMARY KEY CLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Cake] ON 

INSERT [dbo].[Cake] ([cake_id], [name], [image], [description], [price], [quantity], [create_date], [expiration_date], [category_id], [cake_status]) VALUES (1, N'Banh 1', N'images\banh 1.jpg', N'Banh Ngon', 30000, 14, CAST(N'2020-10-12 16:50:38.817' AS DateTime), CAST(N'2021-10-09 00:00:00.000' AS DateTime), 1, N'Active')
INSERT [dbo].[Cake] ([cake_id], [name], [image], [description], [price], [quantity], [create_date], [expiration_date], [category_id], [cake_status]) VALUES (2, N'Banh 2', N'images\banh 2.jpg', N'Banh rat ngon', 50000, 9, CAST(N'2020-10-12 16:51:15.200' AS DateTime), CAST(N'2021-10-09 00:00:00.000' AS DateTime), 2, N'Active')
INSERT [dbo].[Cake] ([cake_id], [name], [image], [description], [price], [quantity], [create_date], [expiration_date], [category_id], [cake_status]) VALUES (3, N'Banh 3', N'images\banh 3.jpg', N'Banh ngon oi la ngon.', 20000, 15, CAST(N'2020-10-13 09:16:10.557' AS DateTime), CAST(N'2021-10-09 00:00:00.000' AS DateTime), 2, N'Active')
INSERT [dbo].[Cake] ([cake_id], [name], [image], [description], [price], [quantity], [create_date], [expiration_date], [category_id], [cake_status]) VALUES (4, N'Banh 4', N'images\banh 3.jpg', N'Banh ngon hon nguoi yeu cu cua ban', 40000, 24, CAST(N'2020-10-13 09:38:20.113' AS DateTime), CAST(N'2021-10-08 00:00:00.000' AS DateTime), 3, N'Active')
INSERT [dbo].[Cake] ([cake_id], [name], [image], [description], [price], [quantity], [create_date], [expiration_date], [category_id], [cake_status]) VALUES (5, N'Banh 5', N'images\banh 4.jpg', N'Banh nay khong ngon dau', 10000, 17, CAST(N'2020-10-13 09:41:26.433' AS DateTime), CAST(N'2021-10-08 00:00:00.000' AS DateTime), 1, N'Active')
INSERT [dbo].[Cake] ([cake_id], [name], [image], [description], [price], [quantity], [create_date], [expiration_date], [category_id], [cake_status]) VALUES (6, N'Banh 6', N'images\banh 4.jpg', N'Banh nay do et', 30000, 13, CAST(N'2020-10-13 09:55:03.327' AS DateTime), CAST(N'2021-10-08 00:00:00.000' AS DateTime), 3, N'Active')
INSERT [dbo].[Cake] ([cake_id], [name], [image], [description], [price], [quantity], [create_date], [expiration_date], [category_id], [cake_status]) VALUES (7, N'Banh 9', N'images\banh 2.jpg', N'Banh nay ngon lam', 20000, 24, CAST(N'2020-10-17 17:29:03.257' AS DateTime), CAST(N'2021-10-08 00:00:00.000' AS DateTime), 2, N'Active')
INSERT [dbo].[Cake] ([cake_id], [name], [image], [description], [price], [quantity], [create_date], [expiration_date], [category_id], [cake_status]) VALUES (8, N'Set Banh Trung Thu', N'images\banh 12.jpg', N'Ngon, bo, re', 200000, 8, CAST(N'2021-09-23 22:07:15.743' AS DateTime), CAST(N'2021-10-08 00:00:00.000' AS DateTime), 1, N'Active')
INSERT [dbo].[Cake] ([cake_id], [name], [image], [description], [price], [quantity], [create_date], [expiration_date], [category_id], [cake_status]) VALUES (9, N'Banh Moi', N'images\banh 11.jpg', N'Banh ngon nha lam', 75000, 6, CAST(N'2021-09-23 22:19:59.363' AS DateTime), CAST(N'2021-10-02 00:00:00.000' AS DateTime), 1, N'Active')
INSERT [dbo].[Cake] ([cake_id], [name], [image], [description], [price], [quantity], [create_date], [expiration_date], [category_id], [cake_status]) VALUES (10, N'Set Banh 3', N'images\banh 10.jpg', N'set banh ngon', 75000, 6, CAST(N'2021-09-23 22:20:41.347' AS DateTime), CAST(N'2021-10-02 00:00:00.000' AS DateTime), 1, N'Active')
INSERT [dbo].[Cake] ([cake_id], [name], [image], [description], [price], [quantity], [create_date], [expiration_date], [category_id], [cake_status]) VALUES (11, N'Set Banh 4', N'images\banh 13.jpg', N'set banh ngon', 123500, 7, CAST(N'2021-09-23 22:21:14.620' AS DateTime), CAST(N'2021-11-04 00:00:00.000' AS DateTime), 1, N'Active')
SET IDENTITY_INSERT [dbo].[Cake] OFF
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([category_id], [category_name]) VALUES (1, N'Bánh Nướng')
INSERT [dbo].[Category] ([category_id], [category_name]) VALUES (2, N'Bánh Dẻo')
INSERT [dbo].[Category] ([category_id], [category_name]) VALUES (3, N'Bánh Cao Cấp')
SET IDENTITY_INSERT [dbo].[Category] OFF
INSERT [dbo].[OrderCake] ([order_id], [username], [full_name], [phone], [address], [total], [order_date], [order_status]) VALUES (N'YMS08620920', N'tamnxlse141130@fpt.edu.vn', N'Nguyen Xuan Linh Tam (K14 HCM)', N'0960166659', N'quan 9', 60000, CAST(N'2021-09-23 22:31:23.557' AS DateTime), N'Confirmed')
INSERT [dbo].[OrderCake] ([order_id], [username], [full_name], [phone], [address], [total], [order_date], [order_status]) VALUES (N'YMS39384664', N'tamnxlse141130@fpt.edu.vn', N'Nguyen Xuan Linh Tam (K14 HCM)', N'0960166659', N'quan 9', 40000, CAST(N'2021-09-23 22:35:59.080' AS DateTime), N'Confirmed')
INSERT [dbo].[OrderCake] ([order_id], [username], [full_name], [phone], [address], [total], [order_date], [order_status]) VALUES (N'YMS59224649', N'tamnxlse141130@fpt.edu.vn', N'Nguyen Xuan Linh Tam (K14 HCM)', N'0960166659', N'quan 9', 190000, CAST(N'2021-09-23 22:29:57.277' AS DateTime), N'Confirmed')
INSERT [dbo].[OrderCake] ([order_id], [username], [full_name], [phone], [address], [total], [order_date], [order_status]) VALUES (N'YMS96443416', N'tamnxlse141130@fpt.edu.vn', N'Nguyen Xuan Linh Tam (K14 HCM)', N'0960166659', N'quan 9', 70000, CAST(N'2021-09-23 22:36:10.427' AS DateTime), N'Confirmed')
INSERT [dbo].[OrderDetail] ([order_id], [cake_id], [quantity], [price]) VALUES (N'YMS08620920', 1, 1, 30000)
INSERT [dbo].[OrderDetail] ([order_id], [cake_id], [quantity], [price]) VALUES (N'YMS08620920', 6, 1, 30000)
INSERT [dbo].[OrderDetail] ([order_id], [cake_id], [quantity], [price]) VALUES (N'YMS39384664', 4, 1, 40000)
INSERT [dbo].[OrderDetail] ([order_id], [cake_id], [quantity], [price]) VALUES (N'YMS59224649', 1, 1, 30000)
INSERT [dbo].[OrderDetail] ([order_id], [cake_id], [quantity], [price]) VALUES (N'YMS59224649', 2, 2, 50000)
INSERT [dbo].[OrderDetail] ([order_id], [cake_id], [quantity], [price]) VALUES (N'YMS59224649', 4, 1, 40000)
INSERT [dbo].[OrderDetail] ([order_id], [cake_id], [quantity], [price]) VALUES (N'YMS59224649', 7, 1, 20000)
INSERT [dbo].[OrderDetail] ([order_id], [cake_id], [quantity], [price]) VALUES (N'YMS96443416', 2, 1, 50000)
INSERT [dbo].[OrderDetail] ([order_id], [cake_id], [quantity], [price]) VALUES (N'YMS96443416', 3, 1, 20000)
INSERT [dbo].[Role] ([role_id], [role_name]) VALUES (N'Ad', N'Admin')
INSERT [dbo].[Role] ([role_id], [role_name]) VALUES (N'Cus', N'Customer')
INSERT [dbo].[Role] ([role_id], [role_name]) VALUES (N'Gu', N'Guest')
INSERT [dbo].[UserInfor] ([username], [password], [full_name], [phone], [address], [role_id], [user_status]) VALUES (N'guest', N'123456', N'Guest', NULL, NULL, N'Cus', N'Active')
INSERT [dbo].[UserInfor] ([username], [password], [full_name], [phone], [address], [role_id], [user_status]) VALUES (N'nhannt1', N'123456', N'Nguyen Thanh Nhan', N'0329272250', N'quan 9', N'Cus', N'Active')
INSERT [dbo].[UserInfor] ([username], [password], [full_name], [phone], [address], [role_id], [user_status]) VALUES (N'tamnxl', N'123456', N'Nguyen Xuan Linh Tam', N'0966016658', N'quan 9', N'Ad', N'Active')
INSERT [dbo].[UserInfor] ([username], [password], [full_name], [phone], [address], [role_id], [user_status]) VALUES (N'tamnxlse141130@fpt.edu.vn', N'123456', N'Nguyen Xuan Linh Tam (K14 HCM)', NULL, NULL, N'Cus', N'Active')
ALTER TABLE [dbo].[Cake]  WITH CHECK ADD FOREIGN KEY([category_id])
REFERENCES [dbo].[Category] ([category_id])
GO
ALTER TABLE [dbo].[OrderCake]  WITH CHECK ADD FOREIGN KEY([username])
REFERENCES [dbo].[UserInfor] ([username])
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD FOREIGN KEY([cake_id])
REFERENCES [dbo].[Cake] ([cake_id])
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD FOREIGN KEY([order_id])
REFERENCES [dbo].[OrderCake] ([order_id])
GO
ALTER TABLE [dbo].[RecordUpdate]  WITH CHECK ADD FOREIGN KEY([cake_id])
REFERENCES [dbo].[Cake] ([cake_id])
GO
ALTER TABLE [dbo].[RecordUpdate]  WITH CHECK ADD FOREIGN KEY([username])
REFERENCES [dbo].[UserInfor] ([username])
GO
ALTER TABLE [dbo].[UserInfor]  WITH CHECK ADD FOREIGN KEY([role_id])
REFERENCES [dbo].[Role] ([role_id])
GO
USE [master]
GO
ALTER DATABASE [YellowMoonShop] SET  READ_WRITE 
GO
