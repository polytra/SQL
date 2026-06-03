/*markdown
# Тестовый пример подключения к бд
здесь у тебя будет базовый пример как подключаться к бд и как работать с этой утилитой
*/

/*markdown
![alt text](./image-1.png) \
это твоя база данных postgresql
проверь что справа от тест надпись "Connected"
если нет, подключись 
*/

/*markdown
## Создание блока с SQL или блока описания
![](image.png) \

По центру этого блокнота у тебя есть вохможность добавить блоки. 
* Code - блок с sql
* Markdown - блок описания



для блока описания, чтобы подтвердить блок в конце справа нажимай галку  \
![alt text](image-2.png)
\


для блока кода чтобы его выполнить в конце слева нажимай треугольник  \
![alt text](image-3.png)
\
*/

/*markdown
## Создание БД

пример кода ниже показывает как создать таблицу в БД
*/

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users (name) VALUES 
('Алексей'),
('Мария'),
('Иван');

/*markdown
## Сохранение результатов

когда решишь что урок закончен - ОБЯЗАТЕЛЬНО сохрани и выгрузи этот блокнов в GIT

### Как выгрузить в git

1) Открываем в левой панели расширение для гита 

![alt text](image-4.png)

2)  придумываем комментарий и вбиваем его в message, затем нажимаем commit 

![alt text](image-5.png)

3) подтверждаем выгрузку




*/

/*markdown
1. Покажите продавцов (Employees), живущих в Лондоне
*/

SELECT *
FROM Employees
WHERE City = 'London'

/*markdown
Если требуется вывести полные столбцы с именами и фамилиями, и если в БД имеются такие столбцы,но имена и фамилии разибты на разные,то решение выглядит так:
*/

SELECT FirstName + ' ' + LastName AS Name 
FROM Employees
WHERE City = 'London'

/*markdown
Если требуется вывести год,месяц, день, то 
*/

SELECT Year(GetDate())
SELECT Month(GetDate())
SELECT Day(GetDate())

/*markdown
Для возвращения из таблицы времени до часа, минуты, секунды, то есть DatePart, где два параметра. Первый - какой "Кусок будем вырезать", Второй - GetDate
*/

SELECT DatePart (hour,GetDate())
SELECT DatePart (minute,GetDate())
SELECT DatePart (second,GetDate())

/*markdown
Расстояние между датами прописывается как. Три параметра: Единица измерения, то есть день, месяц, год. Второй и третий параметры - расстояние, т.е. даты. 
*/

SELECT DateDiff(day, '01.01.2026', GetDate())

/*markdown
И команда DateAdd, которая убавляет и прибавляет от (к) заданной даты. Первый параметр - единица измерения, что прибавлять/убавлять, второй параметр - сколько, третий параметр - необходимая дата
*/

SELECT DateAdd(hour, 100, GetDate())

/*markdown
Ищем заказы на необходимую дату:
*Универсальный формат для записывания даты - 20161013, то есть 13 октября 2016 года. Без точек и запятых. В ковычках - ''.
Либо указываем оператора DateFromParts (год, месяц, день)
*/

SELECT *
FROM Orders
WHERE OrderDate = DateFromParts (2016,10,13)

SELECT 1+1 AS Сумма

/*markdown
Какик заказы были сделаны весной 1997 году?
*/

SELECT * 
FROM Employees
WHERE Year (OrderDate) = 1997
AND (Month(OrderDate) = 3 OR Month(OrderDate) = 4 OR Month(OrderDate) = 5)

/*markdown
Решение верное, но избыточность кода присутствует. Поэтому необходимо упрощение строки с параметром WHERE =>
*/

SELECT * 
FROM Employees
WHERE Year (OrderDate) = 1997 
AND Month (OrderDate) BETWEEN 3 AND 5

/*markdown
Параметр BETWEEN обозначает интервал между. Либо параметр IN. В скобках перечисляем необходимые значения. В данном случае, если бы были зимние месяцы, то (12,1,2)
*/

SELECT * 
FROM Employees
WHERE Year (OrderDate) = 1997 
AND Month (OrderDate) IN (3,4,5)

/*markdown
Для обхода ячеек и строк со значением "NULL", используется оператор IS. Например:
*/

SELECT *
FROM Orders
WHERE Price IS NULL 

/*markdown
Выдает строки, где присутствует значение NULL. Чтобы наоборот их не выводить, необходимо написать "NOT NULL"
*/

/*markdown
Как зовут покупателей (Customers) из Лондона, имеющих факс?
*/

SELECT ContactName
FROM Customers
WHERE City = 'London' 
AND Fax IS NOT NULL

/*markdown
ORDER BY - Сортировка. Пишется в конце. Указывается критерий сортировки. Обычно это столбец. ПО умолчанию ведется по возрастанию. Если необходимо по убыванию, то указывается DESC, если нужна сортировка по возрастанию - ASC. Т.е. ORDER BY столбец ASC/DESC. Дополнительные критерии указывается через запятую. Также, столбец DESC, столбец ASC и т.д.
*/

/*markdown
Также, сортировка возможна по вычисленным столбцам:
*/

SELECT Price
FROM Customers
ORDER BY Price * (1 + 0.18) ASC

/*markdown
Параметр TOP. Исключает повтроения и выдает топ ответов на запросы. Параметр указывается в скобках. Например, если необходимо в вывести топ 5, прописывается:
*/

SELECT TOP (5) UnitPrice
FROM Products
ORDER BY UnitPrice DESC

/*markdown
Если есть необходимость в выводе одинаковых строчек, которые равны строчкам из топа, то в параметр добавляется WITH TIES
*/

SELECT TOP (5) WITH TIES UnitPrice
FROM Products
ORDER BY UnitPrice DESC

/*markdown
В какую страну был оформлен последний заказ в 1997 году?
*/

SELECT TOP (1) WITH TIES ShipCountry
FROM Orders
WHERE Year(OrderDate) = 1997
ORDER BY OrderDate DESK

/*markdown
Если необходимо убрать повторения из строк, в SELECT указывает DISTINCT
*/

/*markdown
В какие города оформлял заказы продавец 1 в 1997 году?
*/

SELECT DISTINCT ShipCity
FROM Orders
WHERE EmployeeID = 1 
AND Year(OrderDate) = 1997

/*markdown
В какой товарной категории (номер) самый дорогой товар?
*/

SELECT TOP (1) WITH TIES CategoryID
FROM Products
ORDER BY UnitPrice DESC

/*markdown
Добавление строк в таблицу. INSERT INTO, где в скобках указываются названия столбцов, можно через запятую. Перед скобками указывается название таблицы. Затем пишется Values, где прописываются реальные значение строк.
*/

SELECT * 
FROM Authors
INSERT INTO Authors (au_ID, au_FName, au_LName) 
VALUES ('111-22-3333', 'Евгений','Онегин'),
('111-22-3334', 'Владимир','Ленский')

/*markdown
UPDATE - Название таблицы, которую необходимо поменять, SET - Название столбца = значение на которое нужно поменять в ковычках ''. Чтобы не было изменения всех строк, необходимо применение параметра WHERE.
*/

UPDATE Authors
SET City = 'Волхв',
WHERE City IN ('Москва')

/*markdown
DELETE и название таблицы + WHERE, чтобы не удалить все таблицу, а только строчки.
*/

DELETE 
FROM Authors
WHERE City = 'Волхв'

/*markdown
В какие месяцы оформлялись заказы в Германию?
*/

SELECT Month(OrderDate) 
FROM Orders
WHERE ShipCountry = 'Germany'
ORDER BY OrderDate
*/ не понятно, правильно или нет

/*markdown
Какой продавец оформио первый заказ в Бразилию в 1997 году?
*/

SELECT  TOP (1) WITH TIES EmployeeID
FROM Orders
WHERE ShipCountry = 'Brazil'
AND Year(OrderDate) = 1997
ORDER BY OrderDate ASC

/*markdown
Агрегатные функции: AVG - среднее арифметическое, где в () указывается столбец. Max & Min - также в () указывается столбец. Sum () в скобках указывается столбец, который необходимо просуммировать. 
*/

/*markdown
Count - Count (*), где в * это вся таблица. Эта функция считает количество строк. В другом случае, записываем Count (столбец), где высчитываем значения всех не нулевых строк в указанном столбце.
*/

/*markdown
Сколько заказов оформлено в Германию в 1997?
*/

SELECT  Count(*)
FROM Orders
WHERE ShipCountry = 'Germany'
AND Year(OrderDate) = 1997

/*markdown
Каких покупателей больше; с факсом или без?
*/

SELECT Count(*)
FROM Customers
WHERE Fax IS NOT NULL

SELECT Count(*)
FROM Customers
WHERE Fax IS NULL

SELECT Count(Fax), Count(*) - Count(Fax)
FROM Customers

/*markdown
Count (*) - Высчитывает все количества строк в таблице, в то время, как Count (столбец) - не нулевые значения. Соответственно, Из общего вычитаем не нулевые значения. При возвращении селекта - получает два ответа - у кого есть факс, у кого его нет.
*/