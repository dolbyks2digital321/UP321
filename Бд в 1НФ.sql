USE [UP321]
GO
/****** Object:  UserDefinedFunction [dbo].[CountryAmount]    Script Date: 14.11.2023 11:05:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[CountryAmount](@Letter char(1))
returns int
as
begin
	declare @number int
	select @number = count(c.Name_Country) from Country c where CHARINDEX(@Letter, c.Name_Country) = 0
	return @number
end
GO
/****** Object:  UserDefinedFunction [dbo].[IsPalindrom]    Script Date: 14.11.2023 11:05:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create function [dbo].[IsPalindrom](@P int)
returns int
as
begin
	declare @true int
	if left(cast(@P as nvarchar(30)), len(cast(@P as nvarchar(30)))/2) = reverse(right(cast(@P as nvarchar(30)), len(cast(@P as nvarchar(30)))/2))
		set @true = 1
	else 
		set @true = 0
	return @true
end
GO
/****** Object:  UserDefinedFunction [dbo].[IsPrime]    Script Date: 14.11.2023 11:05:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create function [dbo].[IsPrime](@N int)
returns int
as
begin
	declare @true int = 1, @nn int = 2
	While @nn < @N/2
	begin
		if @N % @nn = 0 set @true = 0
		set @nn = @nn + 1
	end
	return @true
end
GO
/****** Object:  UserDefinedFunction [dbo].[MaxPopOnContinent]    Script Date: 14.11.2023 11:05:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Function [dbo].[MaxPopOnContinent](@Continent nvarchar(30)='Азия')
returns nvarchar(30)
as
begin
	declare @Name nvarchar(30)
	Select  Top 1 @Name = c.Name_Country from Country c 
	Where c.Continent = @Continent 
	Order By c.Population desc
	return @Name
end
GO
/****** Object:  UserDefinedFunction [dbo].[NameFromCapital]    Script Date: 14.11.2023 11:05:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Function [dbo].[NameFromCapital](@Cap nvarchar(30))
Returns nvarchar(30)
AS
Begin
	Declare @Name nvarchar(30)
	Select @Name = c.Name_Country from Country c Where c.Capital = @Cap
	Return @Name
End
GO
/****** Object:  UserDefinedFunction [dbo].[PopOnSqr]    Script Date: 14.11.2023 11:05:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Function [dbo].[PopOnSqr](@Continent nvarchar(30))
Returns int
as
begin
	declare @Pop int
	Select @Pop = c.Population/c.Square_Country from Country c Where c.Continent = @Continent
	return @Pop
end
GO
/****** Object:  UserDefinedFunction [dbo].[PopulationInMillion]    Script Date: 14.11.2023 11:05:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Function [dbo].[PopulationInMillion](@Id int)
returns int
as
begin
	declare @num int
	Select @num = c.Population/1000000 from Country c Where c.ID = @Id
	Return @num
end
GO
/****** Object:  UserDefinedFunction [dbo].[Quarter]    Script Date: 14.11.2023 11:05:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create function [dbo].[Quarter](@x decimal, @y decimal)
returns int
as
begin
	declare @quarter int
	if @x > 0 and @y > 0 set @quarter = 1
	if @x < 0 and @y > 0 set @quarter = 2
	if @x < 0 and @y < 0 set @quarter = 3
	if @x > 0 and @y < 0 set @quarter = 4
	return @quarter
end
GO
/****** Object:  UserDefinedFunction [dbo].[TestZamena]    Script Date: 14.11.2023 11:05:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Function [dbo].[TestZamena](@word nvarchar(30))
returns nvarchar(30)
as
begin
	declare @word2 nvarchar(30)
	set @word2 = substring(@word, 0, 3) + 'тест' + right(@word,2)
	return @word2
end
GO
/****** Object:  UserDefinedFunction [dbo].[ThirdOnPopCountry]    Script Date: 14.11.2023 11:05:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Function [dbo].[ThirdOnPopCountry]()
returns nvarchar(30)
as
begin
	declare @Name nvarchar(30)
	Select @Name = c.Name_Country from Country c Order By c.Population desc Offset 2 Rows Fetch Next 1 Row only
	return @Name
end
GO
/****** Object:  Table [dbo].[Country]    Script Date: 14.11.2023 11:05:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Country](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name_Country] [nvarchar](50) NULL,
	[Capital] [nvarchar](50) NULL,
	[Square_Country] [int] NULL,
	[Population] [int] NULL,
	[Continent] [nvarchar](30) NULL,
 CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[CountryLessSqr]    Script Date: 14.11.2023 11:05:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create function [dbo].[CountryLessSqr](@sqr int)
returns table
	return (select c.Name_Country from Country c where c.Square_Country < @sqr)
GO
/****** Object:  UserDefinedFunction [dbo].[CountryBetweenPop]    Script Date: 14.11.2023 11:05:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--9.	Напишите функцию для возврата списка стран с населением в интервале заданных значений и вызовите ее.
Create function [dbo].[CountryBetweenPop](@popmin int, @popmax int)
returns table
	return (select c.Name_Country from Country c where c.Population between @popmin and @popmax)
GO
/****** Object:  UserDefinedFunction [dbo].[ContinentAndSumPop]    Script Date: 14.11.2023 11:05:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create function [dbo].[ContinentAndSumPop]()
returns table
	return (select c.Continent, sum(c.Population) as Population from Country c Group by c.Continent)
GO
/****** Object:  View [dbo].[Lab13_1]    Script Date: 14.11.2023 11:05:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[Lab13_1]
as
select c.Name_Country from Country c Where c.Continent = 'Африка' and c.Population > 10000000 and c.Square_Country > 500000
GO
/****** Object:  View [dbo].[Lab13_2]    Script Date: 14.11.2023 11:05:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create View [dbo].[Lab13_2]
as
select c.Continent, avg(c.Square_Country) as 'Средняя площадь', avg(c.Population/c.Square_Country) as 'Средняя плотность' from Country c group by c.Continent
GO
/****** Object:  Table [dbo].[Teacher]    Script Date: 14.11.2023 11:05:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Teacher](
	[Id_Teacher] [int] NOT NULL,
	[Grade] [nvarchar](30) NULL,
	[Degree] [nvarchar](30) NULL,
 CONSTRAINT [PK_Teacher] PRIMARY KEY CLUSTERED 
(
	[Id_Teacher] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Exam]    Script Date: 14.11.2023 11:05:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Exam](
	[Date_Exam] [date] NOT NULL,
	[Id_Subject] [int] NULL,
	[Id_Student] [int] NOT NULL,
	[Id_Employee] [int] NULL,
	[Auditory] [nvarchar](10) NULL,
	[Mark] [int] NULL,
 CONSTRAINT [PK_Exam] PRIMARY KEY CLUSTERED 
(
	[Date_Exam] ASC,
	[Id_Student] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 14.11.2023 11:05:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[Id_Employee] [int] NOT NULL,
	[Id_Lectern] [nvarchar](2) NULL,
	[Surname] [nvarchar](50) NULL,
	[Position] [nvarchar](30) NULL,
	[Salary] [decimal](8, 2) NULL,
	[Chief] [int] NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[Id_Employee] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Lab13_3]    Script Date: 14.11.2023 11:05:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--и используйте его.
Create View [dbo].[Lab13_3]
as
select e.Surname, e.Position, t.Grade, t.Degree, e.Id_Lectern, count(e2.Date_Exam) as 'количество экзаменов'
from Employee e join Teacher t on t.Id_Teacher = e.Id_Employee join Exam e2 on e.Id_Employee = e2.Id_Employee
where e.Position = 'преподаватель'
group by e.Surname, e.Position, t.Grade, t.Degree, e.Id_Lectern
GO
/****** Object:  Table [dbo].[Academics]    Script Date: 14.11.2023 11:05:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Academics](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FIO] [nvarchar](100) NULL,
	[BirthDate] [date] NULL,
	[Spec] [nvarchar](30) NULL,
	[YearZvanie] [int] NULL,
 CONSTRAINT [PK_Academics] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Engineer]    Script Date: 14.11.2023 11:05:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Engineer](
	[Id_Engineer] [int] NOT NULL,
	[Profession] [nvarchar](30) NULL,
 CONSTRAINT [PK_Engineer] PRIMARY KEY CLUSTERED 
(
	[Id_Engineer] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Faculty]    Script Date: 14.11.2023 11:05:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Faculty](
	[Id_Faculty] [nvarchar](2) NOT NULL,
	[Name_Faculty] [nvarchar](100) NULL,
 CONSTRAINT [PK_Facukty] PRIMARY KEY CLUSTERED 
(
	[Id_Faculty] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GymnasiumPupil]    Script Date: 14.11.2023 11:05:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GymnasiumPupil](
	[ID] [int] NOT NULL,
	[Surname] [nvarchar](20) NOT NULL,
	[Subject] [nvarchar](20) NOT NULL,
	[School] [nvarchar](20) NOT NULL,
	[Balls] [decimal](5, 2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Head_Lectern]    Script Date: 14.11.2023 11:05:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Head_Lectern](
	[Id_HL] [int] NOT NULL,
	[Stage] [int] NULL,
 CONSTRAINT [PK_HL] PRIMARY KEY CLUSTERED 
(
	[Id_HL] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lectern]    Script Date: 14.11.2023 11:05:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lectern](
	[Id_Lectern] [nvarchar](2) NOT NULL,
	[Name_Lectern] [nvarchar](100) NULL,
	[Id_Faculty] [nvarchar](2) NULL,
 CONSTRAINT [PK_Lectern] PRIMARY KEY CLUSTERED 
(
	[Id_Lectern] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pupil]    Script Date: 14.11.2023 11:05:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pupil](
	[ID] [int] NOT NULL,
	[Surname] [nvarchar](20) NOT NULL,
	[Subject] [nvarchar](20) NOT NULL,
	[School] [nvarchar](20) NOT NULL,
	[Balls] [decimal](5, 2) NULL,
 CONSTRAINT [PK_Pupil] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Request]    Script Date: 14.11.2023 11:05:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Request](
	[Id_Spec] [nvarchar](10) NOT NULL,
	[Id_Subject] [int] NOT NULL,
 CONSTRAINT [PK_Request] PRIMARY KEY CLUSTERED 
(
	[Id_Spec] ASC,
	[Id_Subject] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Specs]    Script Date: 14.11.2023 11:05:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Specs](
	[Id_Spec] [nvarchar](10) NOT NULL,
	[Direction] [nvarchar](50) NULL,
	[Id_Lectern] [nvarchar](2) NULL,
 CONSTRAINT [PK_Specs] PRIMARY KEY CLUSTERED 
(
	[Id_Spec] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student]    Script Date: 14.11.2023 11:05:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[Id_Student] [int] NOT NULL,
	[Id_Spec] [nvarchar](10) NULL,
	[Surname_Student] [nvarchar](50) NULL,
 CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED 
(
	[Id_Student] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Subject]    Script Date: 14.11.2023 11:05:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Subject](
	[Id_Subject] [int] NOT NULL,
	[Cize_Subject] [int] NULL,
	[Name_Subject] [nvarchar](30) NULL,
	[Id_Lectern] [nvarchar](2) NULL,
 CONSTRAINT [PK_Subject] PRIMARY KEY CLUSTERED 
(
	[Id_Subject] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Животные_АлюсеваСадриев]    Script Date: 14.11.2023 11:05:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Животные_АлюсеваСадриев](
	[Ид_Животных] [int] IDENTITY(1,1) NOT NULL,
	[Название] [nvarchar](50) NULL,
	[Отряд] [nvarchar](50) NULL,
 CONSTRAINT [PK_Животные] PRIMARY KEY CLUSTERED 
(
	[Ид_Животных] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Страны_АлюсеваСадриев]    Script Date: 14.11.2023 11:05:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Страны_АлюсеваСадриев](
	[Ид_Страны] [int] IDENTITY(1,1) NOT NULL,
	[Страна] [nvarchar](50) NOT NULL,
	[Столица] [nvarchar](50) NULL,
	[Часть_Света] [nvarchar](50) NULL,
	[Население] [int] NOT NULL,
	[Площадь] [nvarchar](50) NULL,
	[Тип_Управление] [int] NULL,
 CONSTRAINT [PK_Страны] PRIMARY KEY CLUSTERED 
(
	[Ид_Страны] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Управление_АлюсеваСадриев]    Script Date: 14.11.2023 11:05:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Управление_АлюсеваСадриев](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Type] [nvarchar](50) NULL,
 CONSTRAINT [PK_Управление] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Цветы_АлюсеваСадриев]    Script Date: 14.11.2023 11:05:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Цветы_АлюсеваСадриев](
	[Ид_Цветов] [int] IDENTITY(1,1) NOT NULL,
	[Название] [nvarchar](50) NULL,
	[Класс] [nvarchar](50) NULL,
 CONSTRAINT [PK_Цветы] PRIMARY KEY CLUSTERED 
(
	[Ид_Цветов] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Academics] ON 

INSERT [dbo].[Academics] ([ID], [FIO], [BirthDate], [Spec], [YearZvanie]) VALUES (1, N'Аничков Николай Николаевич', CAST(N'1885-11-03' AS Date), N'медицина', 1939)
INSERT [dbo].[Academics] ([ID], [FIO], [BirthDate], [Spec], [YearZvanie]) VALUES (2, N'Бартольд Василий Владимирович', CAST(N'1869-11-15' AS Date), N'историк', 1913)
INSERT [dbo].[Academics] ([ID], [FIO], [BirthDate], [Spec], [YearZvanie]) VALUES (3, N'Белопольский Аристарх Аполлонович', CAST(N'1854-07-13' AS Date), N'астрофизик', 1903)
INSERT [dbo].[Academics] ([ID], [FIO], [BirthDate], [Spec], [YearZvanie]) VALUES (4, N'Бородин Иван Парфеньевич', CAST(N'1847-01-30' AS Date), N'ботаник', 1902)
INSERT [dbo].[Academics] ([ID], [FIO], [BirthDate], [Spec], [YearZvanie]) VALUES (5, N'Вальден Павел Иванович', CAST(N'1863-07-26' AS Date), N'химик-технолог', 1910)
INSERT [dbo].[Academics] ([ID], [FIO], [BirthDate], [Spec], [YearZvanie]) VALUES (6, N'Вернадский Владимир Иванович', CAST(N'1863-03-12' AS Date), N'геохимик', 1908)
INSERT [dbo].[Academics] ([ID], [FIO], [BirthDate], [Spec], [YearZvanie]) VALUES (7, N'Виноградов Павел Гаврилович', CAST(N'1854-11-30' AS Date), N'историк', 1914)
INSERT [dbo].[Academics] ([ID], [FIO], [BirthDate], [Spec], [YearZvanie]) VALUES (8, N'Ипатьев Владимир Николаевич', CAST(N'1867-11-21' AS Date), N'химик', 1916)
INSERT [dbo].[Academics] ([ID], [FIO], [BirthDate], [Spec], [YearZvanie]) VALUES (9, N'Истрин Василий Михайлович', CAST(N'1865-02-22' AS Date), N'филолог', 1907)
INSERT [dbo].[Academics] ([ID], [FIO], [BirthDate], [Spec], [YearZvanie]) VALUES (10, N'Карпинский Александр Петрович', CAST(N'1847-01-07' AS Date), N'геолог', 1889)
INSERT [dbo].[Academics] ([ID], [FIO], [BirthDate], [Spec], [YearZvanie]) VALUES (11, N'Коковцов Павел Константинович', CAST(N'1861-07-01' AS Date), N'историк', 1906)
INSERT [dbo].[Academics] ([ID], [FIO], [BirthDate], [Spec], [YearZvanie]) VALUES (12, N'Курнаков Николай Семёнович', CAST(N'1860-12-06' AS Date), N'химик', 1913)
INSERT [dbo].[Academics] ([ID], [FIO], [BirthDate], [Spec], [YearZvanie]) VALUES (13, N'Марр Николай Яковлевич', CAST(N'1865-01-06' AS Date), N'лингвист', 1912)
INSERT [dbo].[Academics] ([ID], [FIO], [BirthDate], [Spec], [YearZvanie]) VALUES (14, N'Насонов Николай Викторович', CAST(N'1855-02-26' AS Date), N'зоолог', 1906)
INSERT [dbo].[Academics] ([ID], [FIO], [BirthDate], [Spec], [YearZvanie]) VALUES (15, N'Ольденбург Сергей Фёдорович', CAST(N'1863-09-26' AS Date), N'историк', 1903)
INSERT [dbo].[Academics] ([ID], [FIO], [BirthDate], [Spec], [YearZvanie]) VALUES (16, N'Павлов Иван Петрович', CAST(N'1849-09-26' AS Date), N'физиолог', 1907)
INSERT [dbo].[Academics] ([ID], [FIO], [BirthDate], [Spec], [YearZvanie]) VALUES (17, N'Перетц Владимир Николаевич', CAST(N'1870-01-31' AS Date), N'филолог', 1914)
INSERT [dbo].[Academics] ([ID], [FIO], [BirthDate], [Spec], [YearZvanie]) VALUES (18, N'Соболевский Алексей Иванович', CAST(N'1857-01-07' AS Date), N'лингвист', 1900)
INSERT [dbo].[Academics] ([ID], [FIO], [BirthDate], [Spec], [YearZvanie]) VALUES (19, N'Стеклов Владимир Андреевич', CAST(N'1864-01-09' AS Date), N'математик', 1912)
SET IDENTITY_INSERT [dbo].[Academics] OFF
GO
SET IDENTITY_INSERT [dbo].[Country] ON 

INSERT [dbo].[Country] ([ID], [Name_Country], [Capital], [Square_Country], [Population], [Continent]) VALUES (1, N'Австрия', N'Вена', 83858, 8741753, N'Европа')
INSERT [dbo].[Country] ([ID], [Name_Country], [Capital], [Square_Country], [Population], [Continent]) VALUES (2, N'Азербайджан', N'Баку', 86600, 9705600, N'Азия')
INSERT [dbo].[Country] ([ID], [Name_Country], [Capital], [Square_Country], [Population], [Continent]) VALUES (3, N'Албания', N'Тирана', 28748, 2866026, N'Европа')
INSERT [dbo].[Country] ([ID], [Name_Country], [Capital], [Square_Country], [Population], [Continent]) VALUES (4, N'Алжир', N'Алжир', 2381740, 39813722, N'Африка')
INSERT [dbo].[Country] ([ID], [Name_Country], [Capital], [Square_Country], [Population], [Continent]) VALUES (5, N'Ангола', N'Луанда', 1246700, 25831000, N'Африка')
INSERT [dbo].[Country] ([ID], [Name_Country], [Capital], [Square_Country], [Population], [Continent]) VALUES (6, N'Аргентина', N'Буэнос-Айрес', 2766890, 43847000, N'Южная Америка')
INSERT [dbo].[Country] ([ID], [Name_Country], [Capital], [Square_Country], [Population], [Continent]) VALUES (7, N'Афганистан', N'Кабул', 647500, 29822848, N'Азия')
INSERT [dbo].[Country] ([ID], [Name_Country], [Capital], [Square_Country], [Population], [Continent]) VALUES (8, N'Бангладеш', N'Дакка', 144000, 160221000, N'Азия')
INSERT [dbo].[Country] ([ID], [Name_Country], [Capital], [Square_Country], [Population], [Continent]) VALUES (9, N'Бахрейн', N'Манама', 701, 1397000, N'Азия')
INSERT [dbo].[Country] ([ID], [Name_Country], [Capital], [Square_Country], [Population], [Continent]) VALUES (10, N'Белиз', N'Бельмопан', 22966, 377968, N'Северная Америка')
INSERT [dbo].[Country] ([ID], [Name_Country], [Capital], [Square_Country], [Population], [Continent]) VALUES (11, N'Белоруссия', N'Минск', 207595, 9498400, N'Европа')
INSERT [dbo].[Country] ([ID], [Name_Country], [Capital], [Square_Country], [Population], [Continent]) VALUES (12, N'Бельгия', N'Брюссель', 30528, 11250585, N'Европа')
INSERT [dbo].[Country] ([ID], [Name_Country], [Capital], [Square_Country], [Population], [Continent]) VALUES (13, N'Бенин', N'Порто-Ново', 112620, 11167000, N'Африка')
INSERT [dbo].[Country] ([ID], [Name_Country], [Capital], [Square_Country], [Population], [Continent]) VALUES (14, N'Болгария', N'София', 110910, 7153784, N'Европа')
INSERT [dbo].[Country] ([ID], [Name_Country], [Capital], [Square_Country], [Population], [Continent]) VALUES (15, N'Боливия', N'Сукре', 1098580, 10985059, N'Южная Америка')
INSERT [dbo].[Country] ([ID], [Name_Country], [Capital], [Square_Country], [Population], [Continent]) VALUES (16, N'Ботсвана', N'Габороне', 600370, 2209208, N'Африка')
INSERT [dbo].[Country] ([ID], [Name_Country], [Capital], [Square_Country], [Population], [Continent]) VALUES (17, N'Бразилия', N'Бразилиа', 8511965, 206081432, N'Южная Америка')
INSERT [dbo].[Country] ([ID], [Name_Country], [Capital], [Square_Country], [Population], [Continent]) VALUES (18, N'Буркина-Фасо', N'Уагадугу', 274200, 19034397, N'Африка')
INSERT [dbo].[Country] ([ID], [Name_Country], [Capital], [Square_Country], [Population], [Continent]) VALUES (19, N'Бутан', N'Тхимпху', 47000, 784000, N'Азия')
INSERT [dbo].[Country] ([ID], [Name_Country], [Capital], [Square_Country], [Population], [Continent]) VALUES (20, N'Великобритания', N'Лондон', 244820, 65341183, N'Европа')
INSERT [dbo].[Country] ([ID], [Name_Country], [Capital], [Square_Country], [Population], [Continent]) VALUES (21, N'Венгрия', N'Будапешт', 93030, 9830485, N'Европа')
INSERT [dbo].[Country] ([ID], [Name_Country], [Capital], [Square_Country], [Population], [Continent]) VALUES (22, N'Венесуэла', N'Каракас', 912050, 31028637, N'Южная Америка')
INSERT [dbo].[Country] ([ID], [Name_Country], [Capital], [Square_Country], [Population], [Continent]) VALUES (23, N'Восточный Тимор', N'Дили', 14874, 1167242, N'Азия')
INSERT [dbo].[Country] ([ID], [Name_Country], [Capital], [Square_Country], [Population], [Continent]) VALUES (24, N'Вьетнам', N'Ханой', 329560, 91713300, N'Азия')
SET IDENTITY_INSERT [dbo].[Country] OFF
GO
INSERT [dbo].[Employee] ([Id_Employee], [Id_Lectern], [Surname], [Position], [Salary], [Chief]) VALUES (101, N'пи', N'Прохоров П.П.', N'зав. кафедрой', CAST(35000.00 AS Decimal(8, 2)), 101)
INSERT [dbo].[Employee] ([Id_Employee], [Id_Lectern], [Surname], [Position], [Salary], [Chief]) VALUES (102, N'пи', N'Семенов С.С.', N'преподаватель', CAST(25000.00 AS Decimal(8, 2)), 101)
INSERT [dbo].[Employee] ([Id_Employee], [Id_Lectern], [Surname], [Position], [Salary], [Chief]) VALUES (105, N'пи', N'Петров П.П.', N'преподаватель', CAST(25000.00 AS Decimal(8, 2)), 101)
INSERT [dbo].[Employee] ([Id_Employee], [Id_Lectern], [Surname], [Position], [Salary], [Chief]) VALUES (153, N'пи', N'Сидорова С.С.', N'инженер', CAST(15000.00 AS Decimal(8, 2)), 102)
INSERT [dbo].[Employee] ([Id_Employee], [Id_Lectern], [Surname], [Position], [Salary], [Chief]) VALUES (201, N'ис', N'Андреев А.А.', N'зав. кафедрой', CAST(35000.00 AS Decimal(8, 2)), 201)
INSERT [dbo].[Employee] ([Id_Employee], [Id_Lectern], [Surname], [Position], [Salary], [Chief]) VALUES (202, N'ис', N'Борисов Б.Б.', N'преподаватель', CAST(25000.00 AS Decimal(8, 2)), 201)
INSERT [dbo].[Employee] ([Id_Employee], [Id_Lectern], [Surname], [Position], [Salary], [Chief]) VALUES (241, N'ис', N'Глухов Г.Г.', N'инженер', CAST(20000.00 AS Decimal(8, 2)), 201)
INSERT [dbo].[Employee] ([Id_Employee], [Id_Lectern], [Surname], [Position], [Salary], [Chief]) VALUES (242, N'ис', N'Чернов Ч.Ч.', N'инженер', CAST(15000.00 AS Decimal(8, 2)), 202)
INSERT [dbo].[Employee] ([Id_Employee], [Id_Lectern], [Surname], [Position], [Salary], [Chief]) VALUES (301, N'мм', N'Басов Б.Б.', N'зав. кафедрой', CAST(35000.00 AS Decimal(8, 2)), 301)
INSERT [dbo].[Employee] ([Id_Employee], [Id_Lectern], [Surname], [Position], [Salary], [Chief]) VALUES (302, N'мм', N'Сергеева С.С.', N'преподаватель', CAST(25000.00 AS Decimal(8, 2)), 301)
INSERT [dbo].[Employee] ([Id_Employee], [Id_Lectern], [Surname], [Position], [Salary], [Chief]) VALUES (401, N'оф', N'Волков В.В.', N'зав. кафедрой', CAST(35000.00 AS Decimal(8, 2)), 401)
INSERT [dbo].[Employee] ([Id_Employee], [Id_Lectern], [Surname], [Position], [Salary], [Chief]) VALUES (402, N'оф', N'Зайцев З.З.', N'преподаватель', CAST(25000.00 AS Decimal(8, 2)), 401)
INSERT [dbo].[Employee] ([Id_Employee], [Id_Lectern], [Surname], [Position], [Salary], [Chief]) VALUES (403, N'оф', N'Смирнов С.С.', N'преподаватель', CAST(15000.00 AS Decimal(8, 2)), 401)
INSERT [dbo].[Employee] ([Id_Employee], [Id_Lectern], [Surname], [Position], [Salary], [Chief]) VALUES (435, N'оф', N'Лисин Л.Л.', N'инженер', CAST(20000.00 AS Decimal(8, 2)), 402)
INSERT [dbo].[Employee] ([Id_Employee], [Id_Lectern], [Surname], [Position], [Salary], [Chief]) VALUES (501, N'вм', N'Кузнецов К.К.', N'зав. кафедрой', CAST(35000.00 AS Decimal(8, 2)), 501)
INSERT [dbo].[Employee] ([Id_Employee], [Id_Lectern], [Surname], [Position], [Salary], [Chief]) VALUES (502, N'вм', N'Романцев Р.Р.', N'преподаватель', CAST(25000.00 AS Decimal(8, 2)), 501)
INSERT [dbo].[Employee] ([Id_Employee], [Id_Lectern], [Surname], [Position], [Salary], [Chief]) VALUES (503, N'вм', N'Соловьев С.С.', N'преподаватель', CAST(25000.00 AS Decimal(8, 2)), 501)
INSERT [dbo].[Employee] ([Id_Employee], [Id_Lectern], [Surname], [Position], [Salary], [Chief]) VALUES (601, N'эф', N'Зверев З.З.', N'зав. кафедрой', CAST(35000.00 AS Decimal(8, 2)), 601)
INSERT [dbo].[Employee] ([Id_Employee], [Id_Lectern], [Surname], [Position], [Salary], [Chief]) VALUES (602, N'эф', N'Сорокина С.С.', N'преподаватель', CAST(25000.00 AS Decimal(8, 2)), 601)
INSERT [dbo].[Employee] ([Id_Employee], [Id_Lectern], [Surname], [Position], [Salary], [Chief]) VALUES (614, N'эф', N'Григорьев Г.Г.', N'инженер', CAST(20000.00 AS Decimal(8, 2)), 602)
GO
INSERT [dbo].[Engineer] ([Id_Engineer], [Profession]) VALUES (153, N'электроник')
INSERT [dbo].[Engineer] ([Id_Engineer], [Profession]) VALUES (241, N'электроник')
INSERT [dbo].[Engineer] ([Id_Engineer], [Profession]) VALUES (242, N'программист')
INSERT [dbo].[Engineer] ([Id_Engineer], [Profession]) VALUES (435, N'электроник')
INSERT [dbo].[Engineer] ([Id_Engineer], [Profession]) VALUES (614, N'программист')
GO
INSERT [dbo].[Exam] ([Date_Exam], [Id_Subject], [Id_Student], [Id_Employee], [Auditory], [Mark]) VALUES (CAST(N'2015-06-05' AS Date), 102, 10101, 102, N'т505', 4)
INSERT [dbo].[Exam] ([Date_Exam], [Id_Subject], [Id_Student], [Id_Employee], [Auditory], [Mark]) VALUES (CAST(N'2015-06-05' AS Date), 102, 10102, 102, N'т505', 4)
INSERT [dbo].[Exam] ([Date_Exam], [Id_Subject], [Id_Student], [Id_Employee], [Auditory], [Mark]) VALUES (CAST(N'2015-06-05' AS Date), 202, 20101, 202, N'т506', 4)
INSERT [dbo].[Exam] ([Date_Exam], [Id_Subject], [Id_Student], [Id_Employee], [Auditory], [Mark]) VALUES (CAST(N'2015-06-05' AS Date), 202, 20102, 202, N'т506', 3)
INSERT [dbo].[Exam] ([Date_Exam], [Id_Subject], [Id_Student], [Id_Employee], [Auditory], [Mark]) VALUES (CAST(N'2015-06-07' AS Date), 102, 30101, 105, N'ф419', 3)
INSERT [dbo].[Exam] ([Date_Exam], [Id_Subject], [Id_Student], [Id_Employee], [Auditory], [Mark]) VALUES (CAST(N'2015-06-07' AS Date), 102, 30102, 101, N'т506', 4)
INSERT [dbo].[Exam] ([Date_Exam], [Id_Subject], [Id_Student], [Id_Employee], [Auditory], [Mark]) VALUES (CAST(N'2015-06-07' AS Date), 102, 80101, 102, N'м425', 5)
INSERT [dbo].[Exam] ([Date_Exam], [Id_Subject], [Id_Student], [Id_Employee], [Auditory], [Mark]) VALUES (CAST(N'2015-06-09' AS Date), 209, 20101, 302, N'ф333', 3)
INSERT [dbo].[Exam] ([Date_Exam], [Id_Subject], [Id_Student], [Id_Employee], [Auditory], [Mark]) VALUES (CAST(N'2015-06-09' AS Date), 205, 80102, 402, N'м424', 4)
INSERT [dbo].[Exam] ([Date_Exam], [Id_Subject], [Id_Student], [Id_Employee], [Auditory], [Mark]) VALUES (CAST(N'2015-06-10' AS Date), 101, 10101, 501, N'т506', 4)
INSERT [dbo].[Exam] ([Date_Exam], [Id_Subject], [Id_Student], [Id_Employee], [Auditory], [Mark]) VALUES (CAST(N'2015-06-10' AS Date), 101, 10102, 501, N'т506', 4)
INSERT [dbo].[Exam] ([Date_Exam], [Id_Subject], [Id_Student], [Id_Employee], [Auditory], [Mark]) VALUES (CAST(N'2015-06-10' AS Date), 204, 30102, 601, N'ф349', 5)
INSERT [dbo].[Exam] ([Date_Exam], [Id_Subject], [Id_Student], [Id_Employee], [Auditory], [Mark]) VALUES (CAST(N'2015-06-10' AS Date), 209, 80101, 301, N'э105', 5)
INSERT [dbo].[Exam] ([Date_Exam], [Id_Subject], [Id_Student], [Id_Employee], [Auditory], [Mark]) VALUES (CAST(N'2015-06-10' AS Date), 209, 80102, 301, N'э105', 4)
INSERT [dbo].[Exam] ([Date_Exam], [Id_Subject], [Id_Student], [Id_Employee], [Auditory], [Mark]) VALUES (CAST(N'2015-06-12' AS Date), 101, 80101, 502, N'с324', 4)
INSERT [dbo].[Exam] ([Date_Exam], [Id_Subject], [Id_Student], [Id_Employee], [Auditory], [Mark]) VALUES (CAST(N'2015-06-15' AS Date), 103, 10101, 403, N'ф414', 4)
INSERT [dbo].[Exam] ([Date_Exam], [Id_Subject], [Id_Student], [Id_Employee], [Auditory], [Mark]) VALUES (CAST(N'2015-06-15' AS Date), 101, 30101, 503, N'ф417', 4)
INSERT [dbo].[Exam] ([Date_Exam], [Id_Subject], [Id_Student], [Id_Employee], [Auditory], [Mark]) VALUES (CAST(N'2015-06-15' AS Date), 101, 50101, 501, N'ф201', 5)
INSERT [dbo].[Exam] ([Date_Exam], [Id_Subject], [Id_Student], [Id_Employee], [Auditory], [Mark]) VALUES (CAST(N'2015-06-15' AS Date), 101, 50102, 501, N'ф201', 3)
INSERT [dbo].[Exam] ([Date_Exam], [Id_Subject], [Id_Student], [Id_Employee], [Auditory], [Mark]) VALUES (CAST(N'2015-06-17' AS Date), 102, 10101, 102, N'т505', 5)
GO
INSERT [dbo].[Faculty] ([Id_Faculty], [Name_Faculty]) VALUES (N'гн', N'Гуманитарные науки')
INSERT [dbo].[Faculty] ([Id_Faculty], [Name_Faculty]) VALUES (N'ен', N'Естественные науки')
INSERT [dbo].[Faculty] ([Id_Faculty], [Name_Faculty]) VALUES (N'ит', N'Информационные технологии')
INSERT [dbo].[Faculty] ([Id_Faculty], [Name_Faculty]) VALUES (N'фм', N'Физико-математический')
GO
INSERT [dbo].[Head_Lectern] ([Id_HL], [Stage]) VALUES (101, 15)
INSERT [dbo].[Head_Lectern] ([Id_HL], [Stage]) VALUES (201, 18)
INSERT [dbo].[Head_Lectern] ([Id_HL], [Stage]) VALUES (301, 20)
INSERT [dbo].[Head_Lectern] ([Id_HL], [Stage]) VALUES (401, 10)
INSERT [dbo].[Head_Lectern] ([Id_HL], [Stage]) VALUES (501, 18)
INSERT [dbo].[Head_Lectern] ([Id_HL], [Stage]) VALUES (601, 8)
GO
INSERT [dbo].[Lectern] ([Id_Lectern], [Name_Lectern], [Id_Faculty]) VALUES (N'вм', N'Высшая математика', N'ен')
INSERT [dbo].[Lectern] ([Id_Lectern], [Name_Lectern], [Id_Faculty]) VALUES (N'ис', N'Информационные системы', N'ит')
INSERT [dbo].[Lectern] ([Id_Lectern], [Name_Lectern], [Id_Faculty]) VALUES (N'мм', N'Математическое моделирование', N'фм')
INSERT [dbo].[Lectern] ([Id_Lectern], [Name_Lectern], [Id_Faculty]) VALUES (N'оф', N'Общая физика', N'ен')
INSERT [dbo].[Lectern] ([Id_Lectern], [Name_Lectern], [Id_Faculty]) VALUES (N'пи', N'Прикладная информатика', N'ит')
INSERT [dbo].[Lectern] ([Id_Lectern], [Name_Lectern], [Id_Faculty]) VALUES (N'эф', N'Экспериментальная физика', N'фм')
GO
INSERT [dbo].[Pupil] ([ID], [Surname], [Subject], [School], [Balls]) VALUES (1, N'Иванова', N'Математика', N'Лицей', CAST(98.50 AS Decimal(5, 2)))
INSERT [dbo].[Pupil] ([ID], [Surname], [Subject], [School], [Balls]) VALUES (2, N'Петров', N'Физика', N'Лицей', CAST(99.00 AS Decimal(5, 2)))
INSERT [dbo].[Pupil] ([ID], [Surname], [Subject], [School], [Balls]) VALUES (3, N'Сидоров', N'Математика', N'Лицей', CAST(88.00 AS Decimal(5, 2)))
INSERT [dbo].[Pupil] ([ID], [Surname], [Subject], [School], [Balls]) VALUES (4, N'Полухина', N'Физика', N'Гимназия', CAST(78.00 AS Decimal(5, 2)))
INSERT [dbo].[Pupil] ([ID], [Surname], [Subject], [School], [Balls]) VALUES (5, N'Матвеева', N'Химия', N'Лицей', CAST(92.00 AS Decimal(5, 2)))
INSERT [dbo].[Pupil] ([ID], [Surname], [Subject], [School], [Balls]) VALUES (6, N'Касимов', N'Химия', N'Гимназия', CAST(68.00 AS Decimal(5, 2)))
INSERT [dbo].[Pupil] ([ID], [Surname], [Subject], [School], [Balls]) VALUES (7, N'Нурулин', N'Математика', N'Гимназия', CAST(81.00 AS Decimal(5, 2)))
INSERT [dbo].[Pupil] ([ID], [Surname], [Subject], [School], [Balls]) VALUES (8, N'Авдеев', N'Физика', N'Лицей', CAST(87.00 AS Decimal(5, 2)))
INSERT [dbo].[Pupil] ([ID], [Surname], [Subject], [School], [Balls]) VALUES (9, N'Никитина', N'Химия', N'Лицей', CAST(94.00 AS Decimal(5, 2)))
INSERT [dbo].[Pupil] ([ID], [Surname], [Subject], [School], [Balls]) VALUES (10, N'Барышева', N'Химия', N'Лицей', CAST(88.00 AS Decimal(5, 2)))
INSERT [dbo].[Pupil] ([ID], [Surname], [Subject], [School], [Balls]) VALUES (12, N'Иванов', N'Химия', N'Школа №11', CAST(47.30 AS Decimal(5, 2)))
INSERT [dbo].[Pupil] ([ID], [Surname], [Subject], [School], [Balls]) VALUES (13, N'Петрова', N'Математика', N'Гимназия', CAST(93.00 AS Decimal(5, 2)))
INSERT [dbo].[Pupil] ([ID], [Surname], [Subject], [School], [Balls]) VALUES (14, N'Сидорова', N'Физика', N'Лицей', CAST(99.50 AS Decimal(5, 2)))
GO
INSERT [dbo].[Request] ([Id_Spec], [Id_Subject]) VALUES (N'01.03.04', 101)
INSERT [dbo].[Request] ([Id_Spec], [Id_Subject]) VALUES (N'01.03.04', 205)
INSERT [dbo].[Request] ([Id_Spec], [Id_Subject]) VALUES (N'01.03.04', 209)
INSERT [dbo].[Request] ([Id_Spec], [Id_Subject]) VALUES (N'09.03.02', 101)
INSERT [dbo].[Request] ([Id_Spec], [Id_Subject]) VALUES (N'09.03.02', 102)
INSERT [dbo].[Request] ([Id_Spec], [Id_Subject]) VALUES (N'09.03.02', 103)
INSERT [dbo].[Request] ([Id_Spec], [Id_Subject]) VALUES (N'09.03.02', 202)
INSERT [dbo].[Request] ([Id_Spec], [Id_Subject]) VALUES (N'09.03.02', 205)
INSERT [dbo].[Request] ([Id_Spec], [Id_Subject]) VALUES (N'09.03.02', 209)
INSERT [dbo].[Request] ([Id_Spec], [Id_Subject]) VALUES (N'09.03.03', 101)
INSERT [dbo].[Request] ([Id_Spec], [Id_Subject]) VALUES (N'09.03.03', 102)
INSERT [dbo].[Request] ([Id_Spec], [Id_Subject]) VALUES (N'09.03.03', 103)
INSERT [dbo].[Request] ([Id_Spec], [Id_Subject]) VALUES (N'09.03.03', 202)
INSERT [dbo].[Request] ([Id_Spec], [Id_Subject]) VALUES (N'09.03.03', 205)
INSERT [dbo].[Request] ([Id_Spec], [Id_Subject]) VALUES (N'14.03.02', 101)
INSERT [dbo].[Request] ([Id_Spec], [Id_Subject]) VALUES (N'14.03.02', 102)
INSERT [dbo].[Request] ([Id_Spec], [Id_Subject]) VALUES (N'14.03.02', 103)
INSERT [dbo].[Request] ([Id_Spec], [Id_Subject]) VALUES (N'14.03.02', 204)
INSERT [dbo].[Request] ([Id_Spec], [Id_Subject]) VALUES (N'38.03.05', 101)
INSERT [dbo].[Request] ([Id_Spec], [Id_Subject]) VALUES (N'38.03.05', 103)
INSERT [dbo].[Request] ([Id_Spec], [Id_Subject]) VALUES (N'38.03.05', 202)
INSERT [dbo].[Request] ([Id_Spec], [Id_Subject]) VALUES (N'38.03.05', 209)
GO
INSERT [dbo].[Specs] ([Id_Spec], [Direction], [Id_Lectern]) VALUES (N'01.03.04', N'Прикладная математика', N'мм')
INSERT [dbo].[Specs] ([Id_Spec], [Direction], [Id_Lectern]) VALUES (N'09.03.02', N'Информационные системы и технологии', N'ис')
INSERT [dbo].[Specs] ([Id_Spec], [Direction], [Id_Lectern]) VALUES (N'09.03.03', N'Прикладная информатика', N'пи')
INSERT [dbo].[Specs] ([Id_Spec], [Direction], [Id_Lectern]) VALUES (N'14.03.02', N'Ядерные физика и технологии', N'эф')
INSERT [dbo].[Specs] ([Id_Spec], [Direction], [Id_Lectern]) VALUES (N'38.03.05', N'Бизнес-информатика', N'ис')
GO
INSERT [dbo].[Student] ([Id_Student], [Id_Spec], [Surname_Student]) VALUES (10101, N'09.03.2003', N'Николаева Н. Н.')
INSERT [dbo].[Student] ([Id_Student], [Id_Spec], [Surname_Student]) VALUES (10102, N'09.03.2003', N'Иванов И. И.')
INSERT [dbo].[Student] ([Id_Student], [Id_Spec], [Surname_Student]) VALUES (10103, N'09.03.2003', N'Крюков К. К.')
INSERT [dbo].[Student] ([Id_Student], [Id_Spec], [Surname_Student]) VALUES (20101, N'09.03.2002', N'Андреев А. А.')
INSERT [dbo].[Student] ([Id_Student], [Id_Spec], [Surname_Student]) VALUES (20102, N'09.03.2002', N'Федоров Ф. Ф.')
INSERT [dbo].[Student] ([Id_Student], [Id_Spec], [Surname_Student]) VALUES (30101, N'14.03.2002', N'Бондаренко Б. Б.')
INSERT [dbo].[Student] ([Id_Student], [Id_Spec], [Surname_Student]) VALUES (30102, N'14.03.2002', N'Цветков К. К.')
INSERT [dbo].[Student] ([Id_Student], [Id_Spec], [Surname_Student]) VALUES (30103, N'14.03.2002', N'Петров П. П.')
INSERT [dbo].[Student] ([Id_Student], [Id_Spec], [Surname_Student]) VALUES (50101, N'01.03.2004', N'Сергеев С. С.')
INSERT [dbo].[Student] ([Id_Student], [Id_Spec], [Surname_Student]) VALUES (50102, N'01.03.2004', N'Кудрявцев К. К.')
INSERT [dbo].[Student] ([Id_Student], [Id_Spec], [Surname_Student]) VALUES (80101, N'38.03.05', N'Макаров М. М.')
INSERT [dbo].[Student] ([Id_Student], [Id_Spec], [Surname_Student]) VALUES (80102, N'38.03.05', N'Яковлев Я. Я.')
GO
INSERT [dbo].[Subject] ([Id_Subject], [Cize_Subject], [Name_Subject], [Id_Lectern]) VALUES (101, 320, N'Математика', N'вм')
INSERT [dbo].[Subject] ([Id_Subject], [Cize_Subject], [Name_Subject], [Id_Lectern]) VALUES (102, 160, N'Информатика', N'пи')
INSERT [dbo].[Subject] ([Id_Subject], [Cize_Subject], [Name_Subject], [Id_Lectern]) VALUES (103, 160, N'Физика', N'оф')
INSERT [dbo].[Subject] ([Id_Subject], [Cize_Subject], [Name_Subject], [Id_Lectern]) VALUES (202, 120, N'Базы данных', N'ис')
INSERT [dbo].[Subject] ([Id_Subject], [Cize_Subject], [Name_Subject], [Id_Lectern]) VALUES (204, 160, N'Электроника', N'эф')
INSERT [dbo].[Subject] ([Id_Subject], [Cize_Subject], [Name_Subject], [Id_Lectern]) VALUES (205, 80, N'Программирование', N'пи')
INSERT [dbo].[Subject] ([Id_Subject], [Cize_Subject], [Name_Subject], [Id_Lectern]) VALUES (209, 80, N'Моделирование', N'мм')
GO
INSERT [dbo].[Teacher] ([Id_Teacher], [Grade], [Degree]) VALUES (101, N'профессор', N'д. т.н.')
INSERT [dbo].[Teacher] ([Id_Teacher], [Grade], [Degree]) VALUES (102, N'доцент', N'к. ф.-м. н.')
INSERT [dbo].[Teacher] ([Id_Teacher], [Grade], [Degree]) VALUES (105, N'доцент', N'к. т.н.')
INSERT [dbo].[Teacher] ([Id_Teacher], [Grade], [Degree]) VALUES (201, N'профессор', N'д. ф.-м. н.')
INSERT [dbo].[Teacher] ([Id_Teacher], [Grade], [Degree]) VALUES (202, N'доцент', N'к. ф.-м. н.')
INSERT [dbo].[Teacher] ([Id_Teacher], [Grade], [Degree]) VALUES (301, N'профессор', N'д. т.н.')
INSERT [dbo].[Teacher] ([Id_Teacher], [Grade], [Degree]) VALUES (302, N'доцент', N'к. т.н.')
INSERT [dbo].[Teacher] ([Id_Teacher], [Grade], [Degree]) VALUES (401, N'профессор', N'д. т.н.')
INSERT [dbo].[Teacher] ([Id_Teacher], [Grade], [Degree]) VALUES (402, N'доцент', N'к. т.н.')
INSERT [dbo].[Teacher] ([Id_Teacher], [Grade], [Degree]) VALUES (403, N'ассистент', NULL)
INSERT [dbo].[Teacher] ([Id_Teacher], [Grade], [Degree]) VALUES (501, N'профессор', N'д. ф.-м. н.')
INSERT [dbo].[Teacher] ([Id_Teacher], [Grade], [Degree]) VALUES (502, N'профессор', N'д. ф.-м. н.')
INSERT [dbo].[Teacher] ([Id_Teacher], [Grade], [Degree]) VALUES (503, N'доцент', N'к. ф.-м. н.')
INSERT [dbo].[Teacher] ([Id_Teacher], [Grade], [Degree]) VALUES (601, N'профессор', N'д. ф.-м. н.')
GO
/****** Object:  Index [UQ_Животные]    Script Date: 14.11.2023 11:05:44 ******/
ALTER TABLE [dbo].[Животные_АлюсеваСадриев] ADD  CONSTRAINT [UQ_Животные] UNIQUE NONCLUSTERED 
(
	[Ид_Животных] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Цветы]    Script Date: 14.11.2023 11:05:44 ******/
ALTER TABLE [dbo].[Цветы_АлюсеваСадриев] ADD  CONSTRAINT [UQ_Цветы] UNIQUE NONCLUSTERED 
(
	[Ид_Цветов] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Животные_АлюсеваСадриев] ADD  CONSTRAINT [DF_Животные]  DEFAULT ('Хищные') FOR [Отряд]
GO
ALTER TABLE [dbo].[Управление_АлюсеваСадриев] ADD  CONSTRAINT [DF_Вид]  DEFAULT ('Президентская республика') FOR [Type]
GO
ALTER TABLE [dbo].[Цветы_АлюсеваСадриев] ADD  CONSTRAINT [DF_Цветы]  DEFAULT ('Двудольные') FOR [Класс]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_To_Chief] FOREIGN KEY([Chief])
REFERENCES [dbo].[Employee] ([Id_Employee])
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Employee_To_Chief]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_To_Lectern] FOREIGN KEY([Id_Lectern])
REFERENCES [dbo].[Lectern] ([Id_Lectern])
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Employee_To_Lectern]
GO
ALTER TABLE [dbo].[Engineer]  WITH CHECK ADD  CONSTRAINT [FK_Engineer_To_Employee] FOREIGN KEY([Id_Engineer])
REFERENCES [dbo].[Employee] ([Id_Employee])
GO
ALTER TABLE [dbo].[Engineer] CHECK CONSTRAINT [FK_Engineer_To_Employee]
GO
ALTER TABLE [dbo].[Exam]  WITH CHECK ADD  CONSTRAINT [FK_Exam_To_Employee] FOREIGN KEY([Id_Employee])
REFERENCES [dbo].[Employee] ([Id_Employee])
GO
ALTER TABLE [dbo].[Exam] CHECK CONSTRAINT [FK_Exam_To_Employee]
GO
ALTER TABLE [dbo].[Exam]  WITH CHECK ADD  CONSTRAINT [FK_Exam_To_Student] FOREIGN KEY([Id_Student])
REFERENCES [dbo].[Student] ([Id_Student])
GO
ALTER TABLE [dbo].[Exam] CHECK CONSTRAINT [FK_Exam_To_Student]
GO
ALTER TABLE [dbo].[Exam]  WITH CHECK ADD  CONSTRAINT [FK_Exam_To_Subject] FOREIGN KEY([Id_Subject])
REFERENCES [dbo].[Subject] ([Id_Subject])
GO
ALTER TABLE [dbo].[Exam] CHECK CONSTRAINT [FK_Exam_To_Subject]
GO
ALTER TABLE [dbo].[Head_Lectern]  WITH CHECK ADD  CONSTRAINT [FK_HL_To_Employee] FOREIGN KEY([Id_HL])
REFERENCES [dbo].[Employee] ([Id_Employee])
GO
ALTER TABLE [dbo].[Head_Lectern] CHECK CONSTRAINT [FK_HL_To_Employee]
GO
ALTER TABLE [dbo].[Lectern]  WITH CHECK ADD  CONSTRAINT [FK_Lectern_To_Faculty] FOREIGN KEY([Id_Faculty])
REFERENCES [dbo].[Faculty] ([Id_Faculty])
GO
ALTER TABLE [dbo].[Lectern] CHECK CONSTRAINT [FK_Lectern_To_Faculty]
GO
ALTER TABLE [dbo].[Request]  WITH CHECK ADD  CONSTRAINT [FK_Request_To_Subject] FOREIGN KEY([Id_Subject])
REFERENCES [dbo].[Subject] ([Id_Subject])
GO
ALTER TABLE [dbo].[Request] CHECK CONSTRAINT [FK_Request_To_Subject]
GO
ALTER TABLE [dbo].[Specs]  WITH CHECK ADD  CONSTRAINT [FK_Specs_To_Lectern] FOREIGN KEY([Id_Lectern])
REFERENCES [dbo].[Lectern] ([Id_Lectern])
GO
ALTER TABLE [dbo].[Specs] CHECK CONSTRAINT [FK_Specs_To_Lectern]
GO
ALTER TABLE [dbo].[Subject]  WITH CHECK ADD  CONSTRAINT [FK_Subject_To_Lectern] FOREIGN KEY([Id_Lectern])
REFERENCES [dbo].[Lectern] ([Id_Lectern])
GO
ALTER TABLE [dbo].[Subject] CHECK CONSTRAINT [FK_Subject_To_Lectern]
GO
ALTER TABLE [dbo].[Teacher]  WITH CHECK ADD  CONSTRAINT [FK_Teacher_To_Employee] FOREIGN KEY([Id_Teacher])
REFERENCES [dbo].[Employee] ([Id_Employee])
GO
ALTER TABLE [dbo].[Teacher] CHECK CONSTRAINT [FK_Teacher_To_Employee]
GO
ALTER TABLE [dbo].[Страны_АлюсеваСадриев]  WITH CHECK ADD  CONSTRAINT [FK_ТипУправления] FOREIGN KEY([Тип_Управление])
REFERENCES [dbo].[Управление_АлюсеваСадриев] ([ID])
GO
ALTER TABLE [dbo].[Страны_АлюсеваСадриев] CHECK CONSTRAINT [FK_ТипУправления]
GO
ALTER TABLE [dbo].[Pupil]  WITH CHECK ADD  CONSTRAINT [CK_Balls_Between0_100] CHECK  (([Balls]>=(0) AND [Balls]<=(100)))
GO
ALTER TABLE [dbo].[Pupil] CHECK CONSTRAINT [CK_Balls_Between0_100]
GO
ALTER TABLE [dbo].[Страны_АлюсеваСадриев]  WITH CHECK ADD  CONSTRAINT [CK_Население] CHECK  (([Население]<(7888000)))
GO
ALTER TABLE [dbo].[Страны_АлюсеваСадриев] CHECK CONSTRAINT [CK_Население]
GO
ALTER TABLE [dbo].[Страны_АлюсеваСадриев]  WITH CHECK ADD  CONSTRAINT [CK_Площадь] CHECK  (([Площадь]<(149939)))
GO
ALTER TABLE [dbo].[Страны_АлюсеваСадриев] CHECK CONSTRAINT [CK_Площадь]
GO
