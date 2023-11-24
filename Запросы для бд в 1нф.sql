--ЛР2

Create table Academics
(
ID int CONSTRAINT PK_Academics Primary Key Identity,
FIO nvarchar(100),
BirthDate Date,
Spec nvarchar(30),
YearZvanie int
)

--1.	Вывести ФИО, специализацию и дату рождения всех академиков.
Select FIO, Spec, BirthDate From Academics

--2.	Создать вычисляемое поле «О присвоении звания», которое содержит информацию об академиках в виде: «Петров Петр Петрович получил звание в 1974».
Select 'О присвоении звания'=(FIO +' получил звание в '+ CAST(YearZvanie as nvarchar)) from Academics

--3.	Вывести ФИО академиков и вычисляемое поле «Через 5 лет после присвоения звания».
SELECT FIO, YearZvanie, 'Через 5 лет после присвоения звания'=(YearZvanie + 5) From Academics

--4.	Вывести список годов присвоения званий, убрав дубликаты.
Select distinct YearZvanie from Academics
--5.	Вывести список академиков, отсортированный по убыванию даты рождения.
Select FIO, BirthDate From Academics
Order by BirthDate desc

--6.	Вывести список академиков, отсортированный в обратном алфавитном порядке специализаций, по убыванию года присвоения звания, и в алфавитном порядке ФИО.
Select Spec, YearZvanie, FIO from Academics
Order by Spec desc, YearZvanie desc, FIO 

--7.	Вывести первую строку из списка академиков, отсортированного в обратном алфавитном порядке ФИО.
Select top 1 * From Academics
Order by FIO

--8.	Вывести фамилию академика, который раньше всех получил звание.
Select FIO from Academics
WHERE  YearZvanie = (Select MIN(YearZvanie) FROM Academics)

--9.	Вывести первые 10% строк из списка академиков, отсортированного в алфавитном порядке ФИО.
Select top 10 percent * From Academics
Order by FIO Desc

--10.	Вывести из таблицы «Академики», отсортированной по возрастанию года присвоения звания, список академиков, у которых год присвоения звания – один из первых пяти в отсортированной таблице.
Select * From Academics
where YearZvanie IN (Select distinct top 5 YearZvanie From Academics Order by YearZvanie)
Order by YearZvanie

--11.	Вывести, начиная с десятого, список академиков, отсортированный по возрастанию даты рождения.
Select * From Academics
Order by BirthDate offset 9 rows

--12.	Вывести девятую и десятую строку из списка академиков, отсортированного в алфавитном порядке ФИО.
Select * From Academics
Order by FIO Offset 8 rows
Fetch next 2 rows only

--ЛР3
Create table Country
(
ID int CONSTRAINT PK_Country Primary Key Identity,
Name_Country nvarchar(50),
Capital nvarchar(50),
Square_Country int,
Population int,
Continent nvarchar(30)
)

--1.	Вывести названия и столицы пяти наибольших стран по площади.
SELECT Top 5 Name_Country, Square_Country From Country
Order by Square_Country desc

--2.	Вывести список африканских стран, население которых не превышает 1 млн. чел.
Select * From Country
Where Continent = 'Африка' AND Population < 1000000

--3.	Вывести список стран, население которых больше 5 млн. чел., а площадь меньше 100	тыс. кв. км, и они расположены не в Европе.
Select * From Country
Where Population > 5000000 AND Square_Country < 100000 AND Continent <> 'Европа'

--4.	Вывести список стран Северной и Южной Америки, население которых больше 20	млн. чел., или стран Африки, у которых население больше 30 млн. чел.
Select * From Country
WHERE Continent in ('Северная Америка','Южная Америка') AND Population > 20000000 OR
Continent = 'Африка' AND Population > 30000000

--5.	Вывести список стран, население которых составляет от 10 до 100 млн. чел., а площадь не больше 500 тыс. кв. км.
Select * From Country 
WHERE Population Between 10000000 AND 100000000 AND Square_Country <= 500000

--6.	Вывести список стран, названия которых не начинаются с буквы «К».
Select * From Country
WHERE Name_Country NOT LIKE 'К%'

--7.	Вывести список стран, в названии которых третья буква – «а», а предпоследняя – «и».
Select * From Country
WHERE Name_Country LIKE '__А%И_'
--8.	Вывести список стран, в названии которых вторая буква – гласная.
Select * From Country
WHERE Name_Country LIKE '_[уеыаоэяию]%'

--9.	Вывести список стран, названия которых начинаются с букв от «К» до «П».
Select * From Country
WHERE Name_Country LIKE '[К-П]%'

--10.	Вывести список стран, названия которых начинаются с букв от «А» до «Г», но не с буквы «Б».
Select * From Country
WHERE Name_Country LIKE '[А-Г]%' AND Name_Country LIKE '[^Б]%'

--11.	Вывести список стран, столицы которых есть в базе.
Select * From Country
WHERE Capital IS NOT Null

--12.	Вывести список стран Африки, Северной и Южной Америки.
Select * From Country
WHERE Continent IN ('Африка','Северная Америка','Южная Америка')


--ЛР4

--1.	Вывести список академиков, отсортированный по количеству символов в ФИО.
Select * From Academics
Order by Len(FIO)

--2.	Вывести список академиков, убрать лишние пробелы в ФИО.
Select Trim(FIO) AS Академик From Academics
Order by Len(FIO)

--3.	Найти позиции «ов» в ФИО каждого академика. Вывести ФИО и номер позиции.
Select FIO, CHARINDEX('ов', FIO) AS 'Номер позиции' From Academics

--4.	Вывести ФИО и последние две буквы специализации для каждого академика.
Select FIO, RIGHT(Spec, 2) From Academics

--5.	Вывести список академиков, ФИО в формате Фамилия и Инициалы.
select FIO, CONCAT(SUBSTRING(Fio, 0, CHARINDEX(' ', Fio)+1), 
(SUBSTRING(Fio, Len(SUBSTRING(Fio, 0, CHARINDEX(' ', Fio))) + 2, 1) + '.'), 
(SUBSTRING(FIO, CHARINDEX(' ',FIO,Len(SUBSTRING(Fio, 0, CHARINDEX(' ', Fio))) + 2), 2)+ '.')) From Academics

--6.	Вывести список специализаций в правильном и обратном виде. Убрать дубликаты.
Select distinct Spec, REVERSE(Spec) From Academics

--7.	Вывести свою фамилию в одной строке столько раз, сколько вам лет.
Select REPLICATE('Садриев ', 17)

--9.	Вывести количество дней до конца семестра.
Select DATEDIFF(Day, GetDate(), '30-12-2023')

--10.	Вывести количество месяцев от вашего рождения.
Select DATEDIFF(Month, '03-04-2006', GetDate())

--11.	Вывести ФИО и високосность года рождения каждого академика.
Select Fio, BirthDate,
Case
When Year(BirthDate) % 4 = 0 Then 'Високосный'
Else 'Нет'
End as 'Високосность'
From Academics

--12.	Вывести список специализаций без повторений. Для каждой специализации вывести «длинный» или «короткий», в зависимости от количества символов.
Select Distinct Spec,
CASE
WHEN Len(Spec) > 9 Then 'Длинный'
Else 'Короткий'
END AS Длина
From Academics

--ЛР5
--1.	Вывести минимальную площадь стран.
Select Min(Square_Country) 'Площадь' From Country 

--2.	Вывести наибольшую по населению страну в Северной и Южной Америке.
Select Name_Country FROM Country
Where Population = (Select Max(Population) From Country WHERE Continent in ('Северная Америка','Южная Америка'))

--3.	Вывести среднее население стран. Результат округлить до одного знака.
Select Round(AVG(Cast(Population as decimal)), 1) From Country

--4.	Вывести количество стран, у которых название заканчивается на «ан», кроме стран, у которых название заканчивается на «стан».
Select Count(Id) from Country
Where Name_Country Like '%ан' AND Name_Country Not Like '%стан'

--5.	Вывести количество континентов, где есть страны, название которых начинается с буквы «Р».
Select distinct Count(Continent) Колво from Country
Where Name_Country like 'Р%'

--6.	Сколько раз страна с наибольшей площадью больше, чем страна с наименьшей площадью?
Select Max(Square_Country)/Min(Square_Country) As Ответ From Country

--7.	Вывести количество стран с населением больше, чем 100 млн. чел. на каждом кон-тиненте. Результат отсортировать по количеству стран по возрастанию.
Select Continent, Count(Id) Количество From Country
Where Population > 100000000
Group by Continent
Order by Count(Id)

--8.	Вывести количество стран по количеству букв в названии. Результат отсортировать по убыванию.
Select Len(Name_Country) 'Кол-во букв', Count(Name_Country) 'Кол-во стран' From Country
Group by Len(Name_Country)

--9.	Ожидается, что через 20 лет население мира вырастет на 10%. Вывести список континентов с прогнозируемым населением:
Select Continent, (Sum(Population) * 1.1) 'Прогнозируемое население' From Country
Group by Continent

--10.	Вывести список континентов, где разница по площади между наибольшими и наименьшими странами не более в 10000 раз:
Select Continent From Country
Group by Continent
Having Max(Square_Country)/Min(Square_Country) <= 10000

--11.	Вывести среднюю длину названий Африканских стран.
Select Avg(Len(Name_Country)) from Country
Where Continent = 'Африка'

--12.	Вывести список континентов, у которых средняя плотность среди стран с населе-нием более 1 млн. чел. больше, чем 30 чел. на кв. км.
Select Continent from Country
Where Population > 1000000
Group by Continent
Having Avg(Population/Square_Country) > 30


--ЛР6
Create Table Faculty
(
Id_Faculty nvarchar(2) Constraint PK_Facukty Primary Key,
Name_Faculty nvarchar(100)
)

Create Table Lectern
(
Id_Lectern nvarchar(2) Constraint PK_Lectern Primary Key,
Name_Lectern nvarchar(100),
Id_Faculty nvarchar(2) Constraint FK_Lectern_To_Faculty Foreign key references Faculty(Id_Faculty)
)

Create table Employee
(
Id_Employee Int Constraint PK_Employee Primary Key,
Id_Lectern nvarchar(2) Constraint FK_Employee_To_Lectern Foreign key references Lectern(Id_Lectern),
Surname nvarchar(50),
Position nvarchar(30),
Salary decimal(8,2),
Chief Int Constraint FK_Employee_To_Chief Foreign key references Employee(Id_Employee)
)

Create table Specs
(
Id_Spec nvarchar(8) Constraint PK_Specs Primary Key,
Direction nvarchar(50),
Id_Lectern nvarchar(2) Constraint FK_Specs_To_Lectern Foreign key references Lectern(Id_Lectern)
)

Create table Subject
(
Id_Subject int Constraint PK_Subject Primary Key,
Cize_Subject int,
Name_Subject nvarchar(30),
Id_Lectern nvarchar(2) Constraint FK_Subject_To_Lectern Foreign key references Lectern(Id_Lectern)
)

Create Table Request
(
Id_Spec nvarchar(10) Constraint FK_Request_To_Spec Foreign key references Specs(Id_Spec),
Id_Subject Int Constraint FK_Request_To_Subject Foreign key references Subject(Id_Subject)
CONSTRAINT PK_Request PRIMARY KEY(Id_Spec, Id_Subject)
)

Create table Head_Lectern
(
Id_HL Int Constraint PK_HL Primary Key Constraint FK_HL_To_Employee Foreign key references Employee(Id_Employee),
Stage Int
)

Create table Engineer
(
Id_Engineer Int Constraint PK_Engineer Primary Key Constraint FK_Engineer_To_Employee Foreign key references Employee(Id_Employee),
Profession nvarchar(30)
)

Create table Teacher
(
Id_Teacher Int Constraint PK_Teacher Primary Key Constraint FK_Teacher_To_Employee Foreign key references Employee(Id_Employee),
Grade nvarchar(30),
Degree nvarchar(10)
)

Create table Student
(
Id_Student Int Constraint PK_Student Primary Key,
Id_Spec nvarchar(8) Constraint FK_Student_To_Spec Foreign key references Specs(Id_Spec),
Surname_Student nvarchar(50),
)

Create table Exam
(
Date_Exam date,
Id_Subject int Constraint FK_Exam_To_Subject Foreign Key references Subject(Id_Subject),
Id_Student int Constraint FK_Exam_To_Student Foreign Key references Student(Id_Student),
Id_Employee int Constraint FK_Exam_To_Employee Foreign Key references Employee(Id_Employee),
Auditory nvarchar(10),
Mark int,
Constraint PK_Exam Primary KEY (Date_Exam, Id_Student)
)

--1.	Вывести из таблиц «Кафедра», «Специальность» и «Студент» данные о студентах, которые обучаются на данном факультете (например, «ит»).
SELECT s.Surname_Student FROM dbo.Student s JOIN dbo.Specs s1
ON s.Id_Spec = s1.Id_Spec JOIN dbo.Lectern l
ON s1.Id_Lectern = l.Id_Lectern JOIN dbo.Faculty f
ON l.Id_Faculty = f.Id_Faculty
WHERE f.Id_Faculty = 'ит'

--2.	Вывести из таблиц «Кафедра», «Специальность» и «Сотрудник» данные о выпускающих кафедрах (факультет, шифр, название, фамилию заведующего). Выпускающей считается та кафедра, на которую есть ссылки в таблице «Специальность».
SELECT DISTINCT f.Name_Faculty, l.Id_Lectern, l.Name_Lectern, e.Surname FROM dbo.Lectern l JOIN dbo.Faculty f ON l.Id_Faculty = f.Id_Faculty
JOIN dbo.Specs s ON l.Id_Lectern = s.Id_Lectern
JOIN dbo.Employee e ON l.Id_Lectern = e.Id_Lectern
WHERE e.Position = 'зав. кафедрой'

--3.	Вывести в запросе для каждого сотрудника номер и фамилию его непосредственного руководителя. Для заведующих кафедрами поле руководителя оставить пустым.
SELECT e.Surname,
CASE e2.Surname
When e.Surname Then Null
Else e2.Surname
End As Руководитель
FROM dbo.Employee e JOIN dbo.Employee e2 ON e.Chief = e2.Id_Employee


--4.	Вывести список студентов, сдавших минимум два экзамена.
SELECT s.Surname_Student, COUNT(e.Id_Student) 'Кол-во сданных экзаменов' FROM dbo.Student s JOIN dbo.Exam e ON s.Id_Student = e.Id_Student
GROUP BY s.Surname_Student
HAVING COUNT(e.Id_Student) >= 2

--5.	Вывести список инженеров с зарплатой, меньшей 20000 руб.
SELECT e2.Surname, e2.Salary FROM dbo.Engineer e JOIN dbo.Employee e2 ON e.Id_Engineer = e2.Id_Employee
WHERE e2.Salary < 20000

--6.	Вывести список студентов, сдавших экзамены в заданной аудитории.
--т505
SELECT s.Surname_Student FROM dbo.Student s JOIN dbo.Exam e ON s.Id_Student = e.Id_Student
WHERE e.Auditory = 'т505'

--7.	Вывести из таблиц «Студент» и «Экзамен» учетные номера и фамилии студентов, а также количество сданных экзаменов и средний балл для каждого студента только для тех студентов, 
--у которых средний балл не меньше заданного (например, 4).
SELECT s.Id_Student, s.Surname_Student, COUNT(e.Id_Student) 'Сданные экзамены', AVG(e.Mark) 'Средний балл' FROM dbo.Student s JOIN dbo.Exam e 
ON s.Id_Student = e.Id_Student
GROUP BY s.Id_Student, s.Surname_Student
HAVING AVG(e.Mark) >= 4

--8.	Вывести список заведующих кафедрами и их зарплаты, и степень.
SELECT e.Surname, e.Salary, t.Degree From dbo.Head_Lectern hl JOIN dbo.Employee e ON hl.Id_HL = e.Id_Employee
JOIN dbo.Teacher t ON e.Id_Employee = t.Id_Teacher

--9.	Вывести список профессоров.
SELECT t.Id_Teacher, e.Surname FROM dbo.Teacher t JOIN dbo.Employee e ON t.Id_Teacher = e.Id_Employee
WHERE t.Grade = 'профессор'

--10.	Вывести название дисциплины, фамилию, должность и степень преподавателя, дату и место проведения экзаменов в хронологическом порядке в заданном интервале даты.
SELECT s.Name_Subject, e2.Surname, e2.Position, e.Date_Exam, e.Auditory FROM dbo.Exam e JOIN dbo.Subject s ON e.Id_Subject = s.Id_Subject JOIN dbo.Employee e2 ON e.Id_Employee = e2.Id_Employee
ORDER BY e.Date_Exam

--11.	Вывести фамилию преподавателей, принявших более трех экзаменов.
SELECT e2.Surname FROM dbo.Exam e JOIN dbo.Employee e2 ON e.Id_Employee = e2.Id_Employee
GROUP BY e2.Surname
Having count(e.Date_Exam) > 3


--12.	Вывести список студентов, не сдавших ни одного экзамена в указанной дате.
SELECT s.Surname_Student FROM dbo.Student s
EXCEPT
SELECT s.Surname_Student FROM dbo.Student s JOIN dbo.Exam e ON s.Id_Student = e.Id_Student
WHERE e.Date_Exam = '10.06.2015'

--ЛАБ 7
--1	Вывести объединенный результат выполнения запросов, которые выбирают страны с площадью меньше 500 кв. км и с площадью больше 5 млн. кв. км:
SELECT c.Name_Country, c.Square_Country from Country c
WHERE c.Square_Country < 500
UNION ALL
SELECT c.Name_Country, c.Square_Country from Country c
WHERE c.Square_Country > 5000000

--2 Вывести список стран с площадью больше 1 млн. кв. км, исключить страны с насе-лением меньше 100 млн. чел.:
SELECT c.Name_Country, c.Square_Country from Country c
WHERE c.Square_Country > 1000000
EXCEPT
SELECT c.Name_Country, c.Square_Country from Country c
WHERE c.Population < 100000000

--3	Вывести список стран с площадью меньше 500 кв. км и с населением меньше 100	тыс. чел.

SELECT c.Name_Country, c.Square_Country from Country c
WHERE c.Square_Country < 500
INTERSECT
SELECT c.Name_Country, c.Square_Country from Country c
WHERE c.Population < 100000


--ЛАБ 8
--1 Вывести список стран и процентное соотношение площади каждой из них к общей площади всех стран мира.
SELECT c.Name_Country, c.Square_Country, Round(Cast(c.Square_Country AS float) * 100/
(SELECT Sum(c.Square_Country) FROM dbo.Country c),3) AS Процент FROM dbo.Country c
GROUP BY c.Name_Country, c.Square_Country

--2. Вывести список стран мира, плотность населения которых больше, чем средняя плотность населения всех стран мира.
SELECT c.Name_Country, (c.Population/c.Square_Country) AS 'Плотность населения' FROM dbo.Country c
WHERE (c.Population/c.Square_Country) >= (SELECT AVG(c.Population/c.Square_Country) FROM dbo.Country c)

--3. С помощью подзапроса вывести список европейских стран, население которых меньше 5 млн. чел.
SELECT c.Name_Country FROM dbo.Country c
WHERE c.Continent = 'Европа' AND c.Population > 5000000

--4. Вывести список стран и процентное соотношение их площади к суммарной пло-щади той части мира, где они находятся.
SELECT c.Name_Country, c.Square_Country, c.Continent, Round(Cast(c.Square_Country AS float) * 100/
(SELECT Sum(c1.Square_Country) FROM dbo.Country c1
WHERE c1.Continent = c.Continent),3) AS Процент FROM dbo.Country c
GROUP BY c.Name_Country, c.Square_Country, c.Continent

--5. Вывести список стран мира, площадь которых больше, чем средняя площадь стран той части света, где они находятся.
SELECT c.Name_Country, c.Square_Country FROM dbo.Country c
WHERE c.Square_Country >= (SELECT AVG(c1.Square_Country) FROM dbo.Country c1
WHERE c1.Continent = c.Continent)

--6. Вывести список стран мира, которые находятся в тех частях света, средняя плот-ность населения которых превышает общемировую.
SELECT c.Name_Country FROM dbo.Country c
WHERE c.Continent IN (SELECT ccc.Continent FROM (
SELECT c.Continent, AVG(c.Population/c.Square_Country) AS Ass FROM dbo.Country c
GROUP BY c.Continent
HAVING AVG(c.Population/c.Square_Country) >
(SELECT AVG(c.Population/c.Square_Country) FROM dbo.Country c)) ccc)

--7.	Вывести список южноамериканских стран, в которых живет больше людей, чем в любой африканской стране.
SELECT c.Name_Country FROM dbo.Country c
WHERE c.Continent = 'Южная Америка' AND
c.Population > (SELECT MAX(c2.Population) FROM dbo.Country c2 WHERE c2.Continent = 'Африка')

--8.	Вывести список африканских стран, в которых живет больше людей, чем хотя бы в	одной южноамериканской стране.
SELECT c.Name_Country FROM dbo.Country c
WHERE c.Continent = 'Африка' AND
c.Population > (SELECT Min(c2.Population) FROM dbo.Country c2 WHERE c2.Continent = 'Южная Америка')

--9.	Если в Африке есть хотя бы одна страна, площадь которой больше 2 млн. кв. км, вывести список всех африканских стран.
SELECT c.Name_Country FROM dbo.Country c
WHERE c.Continent = 'Африка' AND EXISTS (SELECT c2.Square_Country from dbo.Country c2 
WHERE c2.Continent = 'Африка' AND c2.Square_Country > 2000000)

--10.	Вывести список стран той части света, где находится страна «Бутан».
SELECT c.Name_Country FROM dbo.Country c
WHERE c.Continent = (SELECT c2.Continent from dbo.Country c2 WHERE c2.Name_Country = 'Бутан')

--11.	Вывести список стран, население которых не превышает население страны «Бутан».
SELECT c.Name_Country FROM dbo.Country c
WHERE c.Population <= (SELECT c.Population FROM dbo.Country c WHERE c.Name_Country = 'Бутан')

--12.	Вывести название страны с наибольшим населением среди стран с наименьшей площадью на каждом континенте.
SELECT c.Name_Country FROM dbo.Country c
WHERE c.Population = (
SELECT MAX(c.Population) from dbo.Country c
WHERE c.Square_Country IN
(SELECT MIN(c.Square_Country) FROM dbo.Country c
GROUP BY c.Continent))

--ЛР9
--1.	Создать таблицу «Управление_ВашаФамилия». Определить основной ключ, иден-тификатор, значение по умолчанию
CREATE TABLE Управление_АлюсеваСадриев
(
ID int CONSTRAINT PK_Управление PRIMARY KEY IDENTITY,
Type nvarchar(50) CONSTRAINT DF_Вид DEFAULT 'Президентская республика'
)

--2.	Создать таблицу «Страны_ВашаФамилия». Определить основной ключ, разрешение / запрет на NULL, условие на вводимое значение.
CREATE TABLE Страны_АлюсеваСадриев
(
Ид_Страны int CONSTRAINT PK_Страны PRIMARY KEY IDENTITY,
Страна nvarchar(50) NOT NULL,
Столица nvarchar(50),
Часть_Света nvarchar(50),
Население int NOT NULL CONSTRAINT CK_Население CHECK (Население < 7888000),
Площадь nvarchar(50) CONSTRAINT CK_Площадь CHECK (Площадь < 149939),
Тип_Управление int CONSTRAINT FK_ТипУправления FOREIGN KEY REFERENCES Управление_АлюсеваСадриев(ID)
)

--3.	Создать таблицу «Цветы_ВашаФамилия». Определить основной ключ, значения столбца «ID» сделать уникальными, для столбца «Класс» установить значение по умолчанию «Двудольные».

CREATE TABLE Цветы_АлюсеваСадриев
(
Ид_Цветов int CONSTRAINT PK_Цветы PRIMARY KEY IDENTITY,
Название nvarchar(50),
Класс nvarchar(50) CONSTRAINT DF_Цветы DEFAULT 'Двудольные',
CONSTRAINT UQ_Цветы UNIQUE(Ид_Цветов)
)

--4.	Создать таблицу «Животные_ВашаФамилия». Определить основной ключ, значе-ния столбца «ID» сделать уникальными, для столбца «Отряд» установить значение по умол-чанию «Хищные».
CREATE TABLE Животные_АлюсеваСадриев
(
Ид_Животных int CONSTRAINT PK_Животные PRIMARY KEY IDENTITY,
Название nvarchar(50),
Отряд nvarchar(50) CONSTRAINT DF_Животные DEFAULT 'Хищные',
CONSTRAINT UQ_Животные UNIQUE(Ид_Животных)
)

--ЛАБ 10
CREATE TABLE Pupil
(
ID int CONSTRAINT PK_Pupil PRIMARY KEY,
Surname nvarchar(20) NOT NULL,
Subject nvarchar(20) NOT NULL,
School nvarchar(20) NOT NULL,
Balls decimal(5,2) CONSTRAINT CK_Balls_Between0_100 CHECK (Balls >= 0 AND Balls <= 100) NULL
)

--1 В таблицу «Ученики» внести новую запись для ученика школы № 18 Трошкова, оценка которого по химии неизвестна.
INSERT dbo.Pupil
VALUES
(11, 'Трошков', 'Химия', 'Школа №18', NULL)

--2.	В таблицу «Ученики» внести три строки.
INSERT dbo.Pupil
VALUES
(12, 'Иванов', 'Химия', 'Школа №11', 43),
(13, 'Петрова', 'Математика', 'Гимназия', 93),
(14, 'Сидорова', 'Физика', 'Лицей', 99.5)

--3.	В таблице «Ученики» изменить данные Трошкова, школу исправить на № 21, предмет на математику, а оценку на 56.
Update Pupil
SET School = 'Школа №21',
Subject = 'Математика',
Balls = 56
Where Surname = 'Трошков'

--4.	В таблице «Ученики» изменить данные всех учеников по химии, оценку увеличить на 10%, если она ниже 60 баллов.
Update Pupil
Set Balls = Balls * 1.1
Where Subject = 'Химия' AND Balls < 60

--5.	В таблице «Ученики» удалить данные всех учеников из школы №21.
Delete Pupil
Where School = 'Школа №21'

--6.	Создать таблицу «Гимназисты» и скопировать туда данные всех гимназистов, кроме тех, которые набрали меньше 60 баллов.
SELECT * INTO GymnasiumPupil from Pupil
Where School = 'Гимназия'

--7.	Очистить таблицу «Гимназисты».
Truncate TABLE GymnasiumPupil


--ЛАБ 11
--1.	Даны числа A и B. Найти и вывести их произведение.
Declare @A int = 6,  @B int = 9
Print Cast(@A as nvarchar) + ' * ' + cast(@B as nvarchar) + ' = ' + cast(@A*@B as nvarchar)

--2.	В таблице «Ученики» найти разницу между средними баллами лицеистов и гимназистов.
DECLARE @LiceyAVG decimal = 0, @GymnasiumAVG decimal = 0

select @LiceyAVG = AVG(p.Balls) from Pupil p
Where p.School = 'Лицей'
select @GymnasiumAVG = AVG(p.Balls) from Pupil p
Where p.School = 'Гимназия'

Print 'Средний балл лицеистов: ' + Cast(@LiceyAVG as nvarchar)
Print 'Средний балл гимназистов: ' + Cast(@GymnasiumAVG as nvarchar)
Print 'Разница: ' + Cast(@LiceyAVG-@GymnasiumAVG as nvarchar)

--3.	В таблице «Ученики» проверить на четность количество строк.
DECLARE @StrCount int;
SET @StrCount = (select count(ID) from Pupil)
If @StrCount % 2 = 0 
	Print 'Кол-во строк четное'
Else
	Print 'Кол-во строк нечетное'

--4.	Дано четырехзначное число. Вывести сумму его цифр.
DECLARE @Num int = 1235, @Sum int = 0, @Len int = 0
While @Len <= LEN(cast(@Num AS nvarchar))
begin
	set @Sum = @Sum + cast(substring(cast(@Num as nvarchar), @Len, 1) as int)
	set @Len = @Len + 1
end
Print @Sum

--5.	Даны случайные целые числа a, b и c. Найти наименьшее из них.
Declare @A int = Rand() * 100, @B int = Rand() * 100, @C int = Rand() * 100
Print Cast(@A as nvarchar) + ' ' + Cast(@B as nvarchar) + ' ' + Cast(@C as nvarchar)
IF @A < @B
	IF @A < @C Print @A
	ELSE Print @C
ELSE
	IF @B < @C Print @B
	ELSE Print @C

--6.	Дано случайное целое число a. Проверить, делится ли данное число на 11.
Declare @a int = Rand() * 100
If @a % 11 = 0 Print Cast(@a as nvarchar) + ' делится на 11'
Else Print Cast(@a as nvarchar) + ' не делится на 11'

--7.	Дано случайное целое число N (N < 1000). Если оно является степенью числа 3, то вывести «Да», если не является – вывести «Нет».
Declare @a int = Rand() * 1000, @N int
Set @N = @a
WHILE @N % 3 = 0
	SET @N = @N / 3
	IF @N = 1 PRINT Cast(@a as nvarchar) + ' является степенью 3'
	ELSE PRINT Cast(@a as nvarchar) + ' не является степенью 3'

--8.	Даны случайные целые числа a и b. Найти наименьший общий кратный (НОК).
Declare @a int = Rand() * 100,  @b int = Rand() * 100, @c int, @aNOK int, @bNOK int
PRINT '@a = ' + CAST(@a AS NVARCHAR) 
PRINT '@b = ' + CAST(@b AS NVARCHAR)
PRINT '@c = ' + CAST(@c AS NVARCHAR)
set @aNOK = @a
set @bNOK = @b
WHILE @aNOK != @bNOK
BEGIN
	IF @aNOK < @bNOK
	begin
		SET @c = @aNOK
		set @aNOK = @bNOK
		set @bNOK = @c
	end
	SET @aNOK = @aNOK - @bNOK
END
set @c = (@a*@b)/@aNOK
PRINT 'НОK = ' +CAST(@c AS NVARCHAR)

--9.	Даны два целых числа A и B (A<B). Найти сумму квадратов всех целых чисел от A до B включительно.
Declare @A int = 2, @B int = 5, @SUMMA int = 0
While @A <= @B
	begin
		SET @SUMMA = @SUMMA + SQUARE(@A)
		SET @A = @A + 1
	end
Print @SUMMA

--10.	Найти первое натуральное число, которое при делении на 2, 3, 4, 5, и 6 дает остаток 1, но делится на 7.
Declare @Number int = 0, @t int = 1
while @t = 1
begin
	If @Number % 2 = 1 AND @Number % 3 = 1 AND @Number % 4 = 1 AND @Number % 5 = 1 AND @Number % 6 = 1
		SET @t = 0
	ELSE SET @Number = @Number + 7
end
Print @Number

--11.	Вывести свою фамилию на экран столько раз, сколько в нем букв.
Declare @Surname nvarchar(14) = 'АлюсеваСадриев', @len int = 1
While @len <= len(@Surname)
begin
	Print @Surname
	set @len = @len + 1
end

--12.	Напишите код для вывода на экран с помощью цикла:
Declare @Name nvarchar(15) = 'Нижневартовск', @len int = 1
While @len <= Len(@Name)
begin
	Print Space((Len(@Name) - @Len)) + Reverse(Substring(@Name,2, @len-1)) + Substring(@Name, 1, @len)
	SET @len = @len + 1
end


-- ЛАБ 12
--1.	Напишите функцию для вывода названия страны с заданной столицей, и вызовите ее.
Create Function NameFromCapital(@Cap nvarchar(30))
Returns nvarchar(30)
AS
Begin
	Declare @Name nvarchar(30)
	Select @Name = c.Name_Country from Country c Where c.Capital = @Cap
	Return @Name
End

Select dbo.NameFromCapital('Минск')

--2.	Напишите функцию для перевода населения в млн. чел. и вызовите ее.
Create Function PopulationInMillion(@Id int)
returns int
as
begin
	declare @num int
	Select @num = c.Population/1000000 from Country c Where c.ID = @Id
	Return @num
end

Select c.Name_Country, c.Population, dbo.PopulationInMillion(c.ID) as 'Население в млн.чел.' from Country c

--3.	Напишите функцию для вычисления плотности населения заданной части света и вызовите ее.
Create Function PopOnSqr(@Continent nvarchar(30))
Returns int
as
begin
	declare @Pop int
	Select @Pop = c.Population/c.Square_Country from Country c Where c.Continent = @Continent
	return @Pop
end

Select c.Continent, dbo.PopOnSqr(c.Continent) as 'Плотность населения' from Country c
Group by c.Continent

--4.	Напишите функцию для поиска страны, третьей по населению и вызовите ее.
Create Function ThirdOnPopCountry()
returns nvarchar(30)
as
begin
	declare @Name nvarchar(30)
	Select @Name = c.Name_Country from Country c Order By c.Population desc Offset 2 Rows Fetch Next 1 Row only
	return @Name
end

Select dbo.ThirdOnPopCountry() as 'страна третья по населению'

--5.	Напишите функцию для поиска страны с максимальным населением в заданной ча-сти света и вызовите ее. 
--Если часть света не указана, выбрать Азию.
Create Function MaxPopOnContinent(@Continent nvarchar(30)='Азия')
returns nvarchar(30)
as
begin
	declare @Name nvarchar(30)
	Select  Top 1 @Name = c.Name_Country from Country c 
	Where c.Continent = @Continent 
	Order By c.Population desc
	return @Name
end

Select c.Continent, dbo.MaxPopOnContinent(c.Continent) as 'Страна с макс. населением' from Country c
Group by c.Continent

Select dbo.MaxPopOnContinent(Default) as 'Страна с макс. населением' 

--6.	Напишите функцию для замены букв в заданном слове от третьей до предпоследней на “тест” и примените ее для столицы страны.
Create Function TestZamena(@word nvarchar(30))
returns nvarchar(30)
as
begin
	declare @word2 nvarchar(30)
	set @word2 = substring(@word, 0, 3) + 'тест' + right(@word,2)
	return @word2
end

select dbo.TestZamena('тест')
--7.	Напишите функцию, которая возвращает количество стран, не содержащих в названии заданную букву.
create function CountryAmount(@Letter char(1))
returns int
as
begin
	declare @number int
	select @number = count(c.Name_Country) from Country c where CHARINDEX(@Letter, c.Name_Country) = 0
	return @number
end

select dbo.CountryAmount('а')

--8.	Напишите функцию для возврата списка стран с площадью меньше заданного числа и вызовите ее.
Create function CountryLessSqr(@sqr int)
returns table
	return (select c.Name_Country from Country c where c.Square_Country < @sqr)

select * from dbo.CountryLessSqr(500000)

--9.	Напишите функцию для возврата списка стран с населением в интервале заданных значений и вызовите ее.
Create function CountryBetweenPop(@popmin int, @popmax int)
returns table
	return (select c.Name_Country from Country c where c.Population between @popmin and @popmax)

select * from dbo.CountryBetweenPop(500000, 2000000)

--10.	Напишите функцию для возврата таблицы с названием континента и суммарным населением и вызовите ее.
Create function ContinentAndSumPop()
returns table
	return (select c.Continent, sum(c.Population) as Population from Country c Group by c.Continent)

select * from dbo.ContinentAndSumPop()

--11.	Напишите функцию IsPalindrom(P) целого типа, возвращающую 1, если целый параметр P (P > 0) является палиндромом, 
--и 0 в противном случае.
Create function IsPalindrom(@P int)
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

select dbo.IsPalindrom(123321)

--12.	Напишите функцию Quarter(x, y) целого типа, определяющую номер координатной четверти, содержащей точку с ненулевыми 
--вещественными координатами (x, y).
Create function Quarter(@x decimal, @y decimal)
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

select dbo.Quarter(-3.5, -7) as 'номер координатной четверти'

--13.	Напишите функцию IsPrime(N) целого типа, возвращающую 1, если целый параметр N (N > 1) является простым числом, 
--и 0 в противном случае.
Create function IsPrime(@N int)
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

select dbo.IsPrime(7) as 'простое ли число'

--14.	Напишите код для удаления созданных вами функций 
Drop Function dbo.IsPrime


--ЛАБ 13
--1.	Создайте представление, содержащее список африканских стран, население которых больше 10 млн. чел.,
--а площадь больше 500 тыс. кв. км, и используйте его.
Create View Lab13_1
as
select c.Name_Country from Country c Where c.Continent = 'Африка' and c.Population > 10000000 and c.Square_Country > 500000

Select * from Lab13_1

--2.	Создайте представление, содержащее список континентов, среднюю площадь стран, которые находятся на нем,
--среднюю плотность населения, и используйте его.
Create View Lab13_2
as
select c.Continent, avg(c.Square_Country) as 'Средняя площадь', avg(c.Population/c.Square_Country) as 'Средняя плотность' from Country c group by c.Continent

Select * from Lab13_2

--3.	Создайте представление, содержащее фамилии преподавателей, их должность, зва-ние, степень, место работы, количество их экзаменов,
--и используйте его.
Create View Lab13_3
as
select e.Surname, e.Position, t.Grade, t.Degree, e.Id_Lectern, count(e2.Date_Exam) as 'количество экзаменов'
from Employee e join Teacher t on t.Id_Teacher = e.Id_Employee join Exam e2 on e.Id_Employee = e2.Id_Employee
where e.Position = 'преподаватель'
group by e.Surname, e.Position, t.Grade, t.Degree, e.Id_Lectern

Select * from Lab13_3

--4.	Создайте табличную переменную, содержащую три столбца («Номер месяца», «Название месяца», «Количество дней»),
--заполните ее для текущего года, и используйте ее.
Declare @Table1 Table (MonthNum int, MonthTitle nvarchar(20), DayAmount int)

insert @Table1 Values 
(1, 'Январь', 31),
(2, 'Февраль', 28),
(3, 'Март', 31),
(4, 'Апрель', 30),
(5, 'Май', 31),
(6, 'Июнь', 30),
(7, 'Июль', 31),
(8, 'Август', 30),
(9, 'Сентябрь', 30),
(10, 'Октябрь', 31),
(11, 'Ноябрь', 30),
(12, 'Декабрь', 31)

select * from @Table1

--5.	Создайте табличную переменную, содержащую список стран, площадь которых в
--100	раз меньше, чем средняя площадь стран на континенте, где они находятся, и используйте ее.
Declare @Table2 Table (NameCountry nvarchar(30), SquareCountry int, ContinentCounry nvarchar(30))
Insert INTO @Table2
Select c.Name_Country, c.Square_Country, c.Continent from Country c Where c.Square_Country * 100 < 
(select AVG(cc.Square_Country) as AvgSqr from Country cc Where c.Continent = cc.Continent)

select * from @Table2

--6.	Создайте локальную временную таблицу, имеющую три столбца («Номер недели», «Количество экзаменов», «Количество студентов»),
--заполните и используйте ее.
Select DATENAME(WEEK, e.Date_Exam) as 'Номер недели', count(distinct e.Id_Subject) as 'Количество экзаменов',
count(distinct e.Id_Student) as 'Количество студентов' into #Table3 from Exam e
group by DATENAME(WEEK, e.Date_Exam)

Select * from #Table3

--7.	Создайте глобальную временную таблицу, содержащую название континентов, наибольшую и наименьшую площадь стран на них,
--заполните и используйте ее.
Select c.Continent, MAX(c.Square_Country) as 'Наибольшая площадь', MIN(c.Square_Country) as 'Наименьшая площадь' 
INTO ##Table4 from Country c
Group By c.Continent

Select * from ##Table4

--8.	С помощью обобщенных табличных выражений напишите запрос для вывода списка сотрудников, чьи зарплаты меньше,
--чем средняя зарплата по факультету, их зарплаты и назва-ние факультета.
WITH Table5 as
(Select AVG(ee.Salary) as 'Средняя зп', ff.Name_Faculty, ff.Id_Faculty from Employee ee join Lectern ll ON ll.Id_Lectern = ee.Id_Lectern JOIN Faculty ff ON ff.Id_Faculty = ll.Id_Faculty 
Group By ff.Id_Faculty, ff.Name_Faculty)

Select e.Surname, e.Salary, t.Name_Faculty from Employee e join Lectern l ON e.Id_Lectern = l.Id_Lectern 
JOIN Table5 t ON l.Id_Faculty = t.Id_Faculty
Where e.Salary < t.[Средняя зп]

--9.	Напишите команды для удаления всех созданных вами представлений.
 Drop View Lab13_1, Lab13_2, Lab13_3


 --ЛР14
-- 1.	Создайте курсор, содержащий отсортированные по баллам фамилии и баллы учеников, откройте его, выведите первую строку, закройте и освободите курсор.
DECLARE MyCursor CURSOR
FOR
SELECT
Surname, Balls
FROM
Pupil
ORDER BY
Balls

OPEN MyCursor
FETCH MyCursor
CLOSE MyCurso
DEALLOCATE MyCursor

--2.	Создайте курсор с прокруткой, содержащий список учеников, откройте его, выведите пятую, предыдущую, с конца четвертую, следующую, первую строку, закройте и освобо-дите курсор.
DECLARE MyCursor CURSOR SCROLL
FOR
SELECT *
FROM
Pupil

OPEN MyCursor
FETCH ABSOLUTE 5 FROM MyCursor
FETCH PRIOR FROM MyCursor
FETCH ABSOLUTE -4 FROM MyCursor
FETCH NEXT FROM MyCursor
FETCH FIRST FROM MyCursor

CLOSE MyCursor
DEALLOCATE MyCursor


--3.	Создайте курсор с прокруткой, содержащий список учеников, откройте его, выведите последнюю, шесть позиций назад находящуюся, четыре позиций вперед находящуюся строку, закройте и освободите курсор.
DECLARE MyCursor CURSOR SCROLL
FOR
	SELECT *
	FROM
		Pupil

OPEN MyCursor
FETCH LAST FROM MyCursor
FETCH RELATIVE -6 FROM MyCursor
FETCH RELATIVE 4 FROM MyCursor

CLOSE MyCursor
DEALLOCATE MyCursor

--4.	С помощью курсора, вычислите сумму баллов у учеников с наибольшим и наименьшим баллом.
DECLARE MyCursor CURSOR SCROLL
FOR
	SELECT
		Balls
	FROM
		Pupil
	Order by
		Balls

OPEN MyCursor
DECLARE @Cum float = 0,@Ball float
FETCH First FROM MyCursor INTO @Ball
Set @Cum = @Cum + @Ball
FETCH LAST FROM MyCursor INTO @Ball
Set @Cum = @Cum + @Ball
Print @Cum

CLOSE MyCursor
DEALLOCATE MyCursor

--5.	С помощью курсора, сгенерируйте строку вида «Ученики <список фамилий и названий предметов, разделенных запятыми> участвовали в олимпиаде».
DECLARE MyCursor CURSOR SCROLL FOR
	SELECT
		Surname, Subject
	FROm
		Pupil

DECLARE @S NVARCHAR(2000), @F NVARCHAR(50), @W NVARCHAR(50)
OPEN MyCursor
SET @S = 'Ученики'
FETCH NEXT FROM MyCursor INTO @F, @W
WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @S=@S+','+@F+' по предмету "'+@W+'"'
		FETCH NEXT FROM MyCursor INTO @F, @W
	END
SET @S = @S + ' участвовали на олимпиаде.'
PRINT @S

CLOSE MyCursor
DEALLOCATE MyCursor

--6.	Создайте курсор, содержащий список учеников, с его помощью выведите учеников с нечетной позицией.
DECLARE MyCursor CURSOR SCROLL
FOR
	SELECT *
	From Pupil

OPEN MyCursor
FETCH ABSOLUTE 1 FROM MyCursor
WHILE @@FETCH_STATUS = 0
	BEGIN
		FETCH RELATIVE 2 FROM MyCursor
	END

CLOSE MyCursor
DEALLOCATE MyCursor


--7.	Создайте курсор, содержащий отсортированный по убыванию баллов список учеников, откройте его, для каждого ученика выведите фамилию, предмет, школу, баллы и процентное соотношение баллов с предыдущим учеником.
DECLARE MyCursor CURSOR SCROLL
FOR
	SELECT *
	From Pupil
	Order by Balls Desc

OPEN MyCursor
DECLARE @ID int, @Sur nvarchar(30), @Sub nvarchar(30), @Scoo nvarchar(30), @B Float, @PerB float = 1
FETCH FIRST From MyCursor INTO @ID, @Sur, @Sub, @Scoo, @B
Set @PerB = @B
WHILE @@FETCH_STATUS = 0
	Begin
		Select 
		@ID AS ID, @Sur AS Фамилия, @Sub AS Предмет, @Scoo AS Школа, @B AS Балл, Concat(Round((@B/@PerB)*100, 2), ' %') AS Соотношение
		Set @PerB = @B
		Fetch next from MyCursor into  @ID, @Sur, @Sub, @Scoo, @B
	end
CLOSE MyCursor
DEALLOCATE MyCursor

--ЛР 15
--1.	Вывести список учеников и разницу между баллами ученика и максимальным баллом в каждой строке.
Select p.Surname, p.Balls, (MAX(p.Balls) OVER() - p.Balls) as Разница from Pupil p

--2.	Вывести список учеников и процентное соотношение к среднему баллу в каждой строке.
Select p.Surname, p.Balls, Concat(Round(p.Balls / AVG(p.Balls) OVER() *100, 2), ' %') as Соотношение from Pupil p

--3.	Вывести список учеников и минимальный балл в школе в каждой строке.
Select p.Surname, p.Balls, (MIN(p.Balls) Over(Partition by p.School Order by p.School)) as 'минимальный балл в школе' from Pupil p

--4.	Вывести список учеников и суммарный балл в школе в каждой строке, отсортировать по школам в оконной функции.
Select p.Surname, p.Balls, (SUM(p.Balls) Over(Partition by p.School Order by p.School)) as 'суммарный балл в школе' from Pupil p

--5.	Вывести список учеников и номер строки при сортировке по фамилиям в обратном алфавитном порядке.
Select
	ROW_NUMBER() Over(Order by p.Surname DESC) AS '№ строки', p.* From Pupil p

--6.	Вывести список учеников, номер строки внутри школы и количество учеников в школе при сортировке по баллам по убыванию.
 Select
	ROW_NUMBER() Over(Partition by p.School Order by p.Balls DESC) AS '№ строки', p.*,
	(Count(p.Balls) Over(Partition by p.School Order by p.School)) as 'кол-во учеников в школе'
	From Pupil p

--7.	Вывести список учеников и ранг по баллам.
SELECT RANK() OVER (ORDER BY p.Balls Desc) AS Ранк, p.* from Pupil p

--8.	Вывести список учеников и сжатый ранг по баллам. Результат отсортировать по фамилии в алфавитном порядке.
SELECT DENSE_RANK() Over(ORDER BY p.Balls Desc) AS Ранк, p.* from Pupil p
ORDER BY p.Surname

--9.	Вывести список учеников, распределенных по пяти группам по фамилии.
SELECT Ntile(5) Over(ORDER BY p.Surname Desc) AS Группа, p.* from Pupil p

--10.	Вывести список учеников, распределенных по трем группам по баллам внутри школы.
SELECT Ntile(3) Over(PARTITION BY p.School ORDER BY p.Balls) AS Группа, p.* from Pupil p

--11.	Вывести список учеников и разницу с баллами ученика, находящегося выше на три позиции при сортировке по возрастанию баллов.
Select p.Surname, p.Balls, p.Balls - LAG(p.Balls,3) OVER(ORDER BY p.Balls) as Разница from Pupil p

--12.	Вывести список учеников и разницу с баллами следующего ученика при сортировке по убыванию баллов, значение по умолчанию использовать 0.
 Select p.Surname, p.Balls, p.Balls - LEAD(p.Balls,1,0) OVER(ORDER BY p.Balls DESC) as Разница from Pupil p

 --ЛР16
-- 1.	Напишите запрос, который выводит максимальный балл учеников по школам, по каждому предмету по каждой школе и промежуточные итоги.
SELECT ISNULL(p.School, 'По школам') Школа, ISNULL(p.Subject, 'По всем предметам') Предмет, MAX(p.Balls) Балл from Pupil p GROUP BY p.School, p.Subject WITH ROLLUP

--2.	Напишите запрос, который выводит минимальный балл учеников по школам и по предметам, и промежуточные итоги.
SELECT ISNULL(p.School, 'По школам') Школа, ISNULL(p.Subject, 'По всем предметам') Предмет, MIN(p.Balls) Балл from Pupil p GROUP BY p.School, p.Subject WITH CUBE

--3.	Напишите запрос, который выводит средний балл учеников по школам и по предметам.
SELECT ISNULL(p.School, 'По школам') Школа, ISNULL(p.Subject, 'По всем предметам') Предмет, AVG(p.Balls) Балл from Pupil p GROUP BY Grouping SETS(p.School, p.Subject)
 
--4.	Напишите запрос, который выводит количество учеников по каждой школе по пред-метам и промежуточные итоги. NULL значения заменить на соответствующий текст.
SELECT ISNULL(p.School, 'По школам') Школа, ISNULL(p.Subject, 'По всем предметам') Предмет, COUNT(Surname) Колво from Pupil p GROUP BY ROLLUP(p.School, p.Subject)

--5.	Напишите запрос, который выводит суммарный балл учеников по школам и по пред-метам, и промежуточные итоги. 
--В итоговых строках NULL значения заменить на соответствующий текст в зависимости от группировки.
SELECT ISNULL(p.School, 'По школам') Школа, ISNULL(p.Subject, 'По всем предметам') Предмет, SUM(p.Balls) Сумма from Pupil p GROUP BY CUBE(p.School, p.Subject) 

--6.	Напишите запрос, который выводит максимальный балл учеников по школам и по предметам. 
--В итоговых строках NULL значения заменить на соответствующий текст в зави-симости от уровней группировки.
SELECT 
	CASE GROUPING_ID(p.Subject, p.School)
	WHEN 1 THEN 'Все школы'
	WHEN 3 THEN 'Итого'
	ELSE ''
END AS 'Итого',
ISNULL(p.School, '') Школа, ISNULL(p.Subject, '') Предмет, MAX(p.Balls) Максимум from Pupil p GROUP BY Cube(p.School, p.Subject) 

--7.	Напишите запрос, который выводит средний балл учеников по школам в столбцы.
SELECT 'Средний балл' AS [Средний балл по школам], [Школа №11],[Гимназия],[Лицей]
'Средний Балл' FROM (SELECT p.Balls, p.School from Pupil p) AS pp
PIVOT (Avg(pp.Balls) FOR School IN ([Школа №11],[Гимназия],[Лицей])) AS Pivot_Table

--8.	Напишите запрос, который выводит средний балл учеников по школам в столбцы и по предметам в строки.
SELECT Subject, [Школа №11],[Гимназия],[Лицей]
'Средний Балл' FROM (SELECT p.Subject, p.Balls, p.School from Pupil p) AS pp
PIVOT (Avg(pp.Balls) FOR School IN ([Школа №11],[Гимназия],[Лицей])) AS Pivot_Table

--9.	Напишите запрос, который выводит названия предметов, фамилии учеников и школы в один столбец.
SELECT Surname_Subject_School
FROM (
    SELECT Subject, Surname, School
    FROM Pupil
) AS Source
UNPIVOT (
    Surname_Subject_School FOR Attribute IN (Subject, Surname, School)
) unpivo

--ЛР17
--1.	Создайте и запустите динамический SQL-запрос, выбирающий первые N строк из заданной таблицы.
DECLARE @DSQL NVARCHAR(100), @TN NVARCHAR(50), @N int = 3
SET @TN = 'dbo.Pupil'
SET @DSQL = 'SELECT TOP ' + Cast(@N as nvarchar) + ' * FROM ' + @TN
EXECUTE (@DSQL)

--2.	Создайте и запустите динамический SQL-запрос, выбирающий все страны из таб-лицы «Страны», последняя буква названия которых расположена в заданном диапазоне.
Declare @L1 CHAR(1)
Declare @L2 CHAR(1)
Set @L1 = 'ш'
Set @L2 = 'я'

EXECUTE('Select * From Country WHERE Name_Country LIKE ''%_['+@L1+'-'+@L2+']''')

--3.	Создайте временную таблицу #Temp и добавьте к ней название столбцов таблицы «Страны». 
--Создайте курсор, который, построчно читая таблицу #Temp, выбирает каждый раз соответствующий столбец из таблицы «Страны».
CREATE TABLE #TEMP (TABLENAME NVARCHAR(50))

INSERT INTO #TEMP VALUES
('ID'),
('Name_Country'),
('Capital'),
('Square_Country'),
('Population'),
('Continent')


DECLARE TC CURSOR
FOR SELECT TABLENAME FROM #TEMP

OPEN TC
DECLARE @TN NVARCHAR(50)
FETCH FROM TC INTO @TN
WHILE @@FETCH_STATUS = 0
	BEGIN
		EXECUTE ('SELECT ' + @TN + ' FROM Country')
		FETCH FROM TC INTO @TN
	END

CLOSE TC
DEALLOCATE TC
DROP TABLE #TEMP

--4.	Создайте процедуру, которая принимает как параметр список столбцов, название таблицы и выбирает заданные столбцы из заданной таблицы.
Declare @NameTable nvarchar(50), @Col1 nvarchar(50), @Col2 nvarchar(50)
Set @NameTable = 'Country'
Set @Col1 = 'Name_Country'
Set @Col2 = 'Capital'

Exec('Select ' + @Col1 + ' ,' + @Col2 + ' From ' + @NameTable)

--5.	Создайте процедуру, принимающую как параметр список столбцов, название таблицы, название проверяемого столбца, знак сравнения, значение проверки и выбирающую за-данные столбцы из заданной таблицы в заданных условиях.
--Выбрать страны, с населением больше, чем 10 млн
Declare @NameTable nvarchar(50), @Col1 nvarchar(50), @Col2 nvarchar(50), @CheckChar varchar(3), @CheckValue int
Set @NameTable = 'Country'
Set @Col1 = 'Name_Country'
Set @Col2 = 'Population'
Set @CheckChar = '>'
Set @CheckValue = 10000000

Exec('Select ' + @Col1 + ' ,' + @Col2 + ' From ' + @NameTable +
' Where ' + @Col2 + ' ' + @CheckChar + ' ' + @CheckValue)

--6.	Выберите список европейских стран из таблицы «Страны» и экспортируйте в RAW формате XML.
Select * from Country where Continent = 'Европа' For XML RAW

--7.	Выберите список стран с населением больше 100 млн. чел. из таблицы «Страны» и экспортируйте в PATH формате XML.
Select * from Country Where Population > 100000000 For XML PATH

--8.	Выберите список учеников из школы «Лицей» из таблицы «Ученики» и экспорти-руйте в PATH формате JSON
SELECT * From Pupil Where School = 'Лицей' FOR JSON PATH