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

SELECT  *    
FROM    Orders
WHERE   Price IS NULL 

/*markdown
Выдает строки, где присутствует значение NULL. Чтобы наоборот их не выводить, необходимо написать "NOT NULL"
*/

/*markdown
Как зовут покупателей (Customers) из Лондона, имеющих факс?
*/

SELECT      ContactName
FROM        Customers
WHERE       City = 'London' 
AND         Fax IS NOT NULL

/*markdown
ORDER BY - Сортировка. Пишется в конце. Указывается критерий сортировки. Обычно это столбец. ПО умолчанию ведется по возрастанию. Если необходимо по убыванию, то указывается DESC, если нужна сортировка по возрастанию - ASC. Т.е. ORDER BY столбец ASC/DESC. Дополнительные критерии указывается через запятую. Также, столбец DESC, столбец ASC и т.д.
*/

/*markdown
Также, сортировка возможна по вычисленным столбцам:
*/

SELECT      Price
FROM        Customers
ORDER BY    Price * (1 + 0.18) ASC

/*markdown
Параметр TOP. Исключает повтроения и выдает топ ответов на запросы. Параметр указывается в скобках. Например, если необходимо в вывести топ 5, прописывается:
*/

SELECT TOP (5) UnitPrice
FROM           Products
ORDER BY       UnitPrice DESC

/*markdown
Если есть необходимость в выводе одинаковых строчек, которые равны строчкам из топа, то в параметр добавляется WITH TIES
*/

SELECT TOP (5) WITH TIES UnitPrice
FROM        Products
ORDER BY    UnitPrice DESC

/*markdown
В какую страну был оформлен последний заказ в 1997 году?
*/

SELECT TOP (1) WITH TIES ShipCountry
FROM        Orders
WHERE       Year(OrderDate) = 1997
ORDER BY    OrderDate DESK

/*markdown
Если необходимо убрать повторения из строк, в SELECT указывает DISTINCT
*/

/*markdown
В какие города оформлял заказы продавец 1 в 1997 году?
*/

SELECT DISTINCT ShipCity
FROM            Orders
WHERE           EmployeeID = 1 
AND             Year(OrderDate) = 1997

/*markdown
В какой товарной категории (номер) самый дорогой товар?
*/

SELECT TOP (1) WITH TIES CategoryID
FROM        Products
ORDER BY    UnitPrice DESC

/*markdown
Добавление строк в таблицу. INSERT INTO, где в скобках указываются названия столбцов, можно через запятую. Перед скобками указывается название таблицы. Затем пишется Values, где прописываются реальные значение строк.
*/

SELECT          * 
FROM            Authors
INSERT INTO     Authors (au_ID, au_FName, au_LName) 
VALUES          ('111-22-3333', 'Евгений','Онегин'),
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

SELECT      Month(OrderDate) 
FROM        Orders
WHERE       ShipCountry = 'Germany'
ORDER BY    OrderDate
*/ не понятно, правильно или нет

/*markdown
Какой продавец оформио первый заказ в Бразилию в 1997 году?
*/

SELECT  TOP (1) WITH TIES EmployeeID
FROM        Orders
WHERE       ShipCountry = 'Brazil'
AND         Year(OrderDate) = 1997
ORDER BY    OrderDate ASC

/*markdown
Агрегатные функции: AVG - среднее арифметическое, где в () указывается столбец. Max & Min - также в () указывается столбец. Sum () в скобках указывается столбец, который необходимо просуммировать. 
*/

/*markdown
Count - Count (*), где в * это вся таблица. Эта функция считает количество строк. В другом случае, записываем Count (столбец), где высчитываем значения всех не нулевых строк в указанном столбце.
*/

/*markdown
Сколько заказов оформлено в Германию в 1997?
*/

SELECT      Count(*)
FROM        Orders
WHERE       ShipCountry = 'Germany'
AND         Year(OrderDate) = 1997

/*markdown
Каких покупателей больше; с факсом или без?
*/

SELECT  Count(*)
FROM    Customers
WHERE   Fax IS NOT NULL

SELECT  Count(*)
FROM    Customers
WHERE   Fax IS NULL

SELECT  Count(Fax), Count(*) - Count(Fax)
FROM    Customers

/*markdown
Count (*) - Высчитывает все количества строк в таблице, в то время, как Count (столбец) - не нулевые значения. Соответственно, Из общего вычитаем не нулевые значения. При возвращении селекта - получает два ответа - у кого есть факс, у кого его нет.
*/

/*markdown
При GROUP BY, в селект записывается только, почему происходит группировка, то есть SELECT & GROUP BY записывается тоже самое.
*/

SELECT      Type
FROM        Titlies
GROUP BY    Type

/*markdown
Сколько людей живет в каждом городе?
*/

SELECT      City, Count(*)
FROM        Customers
GROUP BY    City

/*markdown
Сколько заказов было оформлено в каждую страну?
*/

SELECT      ShipCountry, Count(*)
FROM        Orders
GROUP BY    ShipCountry

/*markdown
Сколько товаров в каждой товарной категории?
*/

SELECT      CategoryID, Count(*) AS Сумма товаров
FROM        Products
GROUP BY    CategoryID
ORDER BY    Сумма товаров DESC

/*markdown
В какую страну оформлено больше всего заказов?
*/

SELECT TOP (1) WITH TIES ShipCountry, Count(*) Количество заказов
FROM        Orders
GROUP BY    ShipCountry
ORDER BY    Количество заказов DESC

/*markdown
Какой продавец поставил рекорд по количеству заказов, оформленных в течение месяца в один и тот же город?
*/

SELECT TOP (1) WITH TIES EmployeesID, Count (*)
FROM        Orders
GROUP BY    EmployeesID, ShipCity, Year(OrderDate), Month(OrderDate)
ORDER BY    Count(*) DESC

/*markdown
В какой город первый продавец оформил больше всего заказов для одного клиента? 
*/

SELECT TOP (1) WITH TIES ShipCity, Count (*)
FROM        Orders
WHERE       EmpoyeeID = 1
GROUP BY    ShipCity, CustomerID
ORDER BY    Count (*) DESC 

/*markdown
Какой покупатель чаще всех обслуживался у одного и того же продавца?
*/

SELECT TOP (1) WITH TIES CustomerID --, EmployeeID, Count(*)
FROM        Orders
GROUP BY    CustomerID, EmployeesID
ORDER BY    Count (*) DESC 

/*markdown
Скольких французов обслужил каждый продавец?
*/

SELECT      EmployeesD, Count(DISTINCT CustomerID)
FROM        Orders
WHERE       ShipCountry = 'France'
GROUP BY    EmployeesID

/*markdown
Какой продавец обслужил больше всего городов в одной стране? *То, что необходимо посчитать, помещаем в Count
*/

SELECT TOP (1) WITH TIES EmpoyeeID, Count(DISTINCT ShipCity)
FROM        Orders
GROUP BY    EmpoyeeID, ShipCountry
ORDER BY    Count(DISTINCT ShipCity) DESC

/*markdown
Какой покупатель обслуживался у максимального количества продавцов?
*/

SELECT TOP (1) WITH TIES CustomerID, Count (DISTINCT EmployeeID)
FROM        Orders
GROUP BY    CustomerID, Year(OrderDate), Month(OrderDate)
ORDER BY    Count (DISTINCT EmployeeID) DESC

/*markdown
HAVING - Способ фильтрации для второй таблицы после агрегациии GROUP BY. 
*/

/*markdown
В каких городах прописано более 5 клиентов?
*/

SELECT      City, Count(*)
FROM        Customers
GROUP BY    City
HAVING      Count(*) > 5

/*markdown
Какие продавцы сумели обслужить больше пяти городов в одной стране?
*/

SELECT     DISTINCT EmployeeID, --Count(DISTINCT ShipCity)
FROM        Orders
GROUP BY    EmployeeID, ShipCountry
HAVING      Count(DISTINCT ShipCity) > 5

/*markdown
Стратегии объединения таблиц.
*/

/*markdown
1. INTERSECT (Пересечения *входит в А и Б)
2. UNION (ALL, DISTINCT) (Объединения * Или А, Или Б, или А и Б)
3. JOIN (CROSS, OUTER (LEFT, FULL, RIGHT), APPLY (CROSS, OUTER), INNER)
4. EXCEPT (Только А, или только Б)
5. Подзапрос (Простыея, связанные)
*/

/*markdown
UNION 
*/

/*markdown
Для объединения таблиц с помощью UNION, необходима одинаковая структра таблиц. 
ПРимер объединения таблиц.
*/

SELECT  FirstName + ' ' + LastName, City
FROM    Employees
    UNION
SELECT  ContactName, City
FROM    Customers
*ORDER BY

/*markdown
Сортировка осуществляется и прописывается после всех селектов и "объединений". 
*/

/*markdown
ПОДЗАПРОСЫ
*/

/*markdown
Сколько товаров в каждой категории?
*/

SELECT  CategoryID, CategoryName,
        (
            SELECT  Count (*)
            FROM    Products
            WHERE   CategoryID = Categories.CategoryID
        )
FROM    Categories

/*markdown
Categories.CategoryID - Название таблицы.Название столбца
*/

/*markdown
Сколько заказов сделал каждый продавец?
*/

SELECT  FirstName + ' ' + LastName , 
        (
            SELECT  Count(*)
            FROM    Orders
            WHERE   EmployeeID = Employees.EmployeeID
        )
FROM    Employees

/*markdown
Сколько заказов сделал каждый покупатель в 1997 году?
*/

SELECT  ContactName, 
        (
            SELECT  Count(*)
            FROM    Orders
            WHERE   Year(OrderDate) = 1997
                AND CustomerID = Customers.CustomerID
        )
FROM    Customers

/*markdown
Посчитать выручку с каждого товара.
*/

SELECT  ProductName, 
        (
            SELECT  Round(Sum(UnitPrice * Quantity * (1-Discount)),2)
            FROM    [Order Details]
            WHERE   ProductID = Products.ProductID
        )
FROM    Products

/*markdown
Какие продавцы обслужили нескольких клиентов из одного города?
*/

SELECT      DISTINCT EmployeeID --, Count(DISTINCT CustomerID)
FROM        Orders
GROUP BY    EmployeeID, ShipCity
HAVING      Count(DISTINCT CustomerID) > 1

/*markdown
На каких товарах компания недополучила из-за скидок больше 1000?
*/

SELECT  ProductName
FROM    Products
WHERE       (
                SELECT  Sum (UnitPrice * Quantity * Discount)
                FROM    [Order Details]
                WHERE   ProductID = Products.ProductID
            ) > 1000
ORDER BY    (
                SELECT  Sum (UnitPrice * Quantity * Discount)
                FROM    [Order Details]
                WHERE   ProductID = Products.ProductID
            ) DESC 

/*markdown
Как зовут покупателя, который сделал больше всех заказов в 1997 году?
*/

SELECT      TOP (1) WITH TIES ContactName
FROM        Customers
ORDER BY    (
                SELECT  Count(*)
                FROM    Orders
                WHERE   CustomerID = Customers.CustomerID
                        Year (OrderDate) = 1997
            ) DESC

/*markdown
С каким городом работало больше всего продавцов-торговых представителей?
*/

SELECT  ShipCity, Sum (Num)
FROM    (
            SELECT  ShipCity, 
                    (
                        SELECT  Count(*)
                        FROM    Employees
                        WHERE   EmployeeID = Orders.EmployeeID
                                AND Title = 'Sales Representative'
                )    AS Num
            FROM    Orders
        ) MyTable
GROUP BY  ShipCity
ORDER BY  Sum (Num) DESC

/*markdown
Как зовут продавцов, которые в 1997 году работали как минимум с 10-ю странами?
*/

SELECT      FirstName + ' ' + LastName
FROM        Employees
WHERE       (
                SELECT  Count (DISTINCT ShipCountry)
                FROM    Orders
                WHERE   EmployeeID = Employees.EmployeeID
                        AND Year (OrderDate) = 1997
            ) > 10

/*markdown
Чтобы подзапрос был записан в разделе FROM, он должен удволетворять 3-м показателям.
*/

/*markdown
1. Не должна присутствовать сортировка.
2. Все cтолбцы, которые запихивают в подзапрос, должны быть названы (проименованы), поскольку подзапрос "прикидывается" таблицей.
3. Селект, который является подзапросом - должен иметь название - AS MyTable.
*/

/*markdown
Какие продавцы в 1997 году поработали более чем с 50 разными товарами?
*/

--Мое решение
SELECT  EmployeeID, 
        (
            SELECT  Count (DISTINCT ProductID)
            FROM    [Order Details]
            WHERE   Count (DISTINCT ProductID) > 50
        )
FROM    Orders
WHERE   Year (OrderDate) = 1997

--Верное решение
SELECT  FirstName + ' ' + LastName
FROM    Employees
WHERE   (
            SELECT  Count (DISTINCT ProductID)
            FROM    [Order Details]
            WHERE   OrderID IN (
                                    SELECT  OrderID
                                    FROM    Orders
                                    WHERE   EmployeeID = Employees.EmployeeID
                                            AND Year (OrderDate) = 1997
                                )
        ) > 50

/*markdown
Какие продавцы в 1997 году более чем  5000 штук товаров?
*/

SELECT      EmployeeID, SUM(Total)
FROM        (
                SELECT  EmployeeID,
                    (
                            SELECT  SUM (Quantity)
                            FROM    [Order Details]
                            WHERE   OrderID = Orders.OrderID
                        ) AS Total
                FROM    Orders
                WHERE   Year (OrderDate) = 1997
            ) AS MyTable
GROUP BY    EmployeeID    
HAVING      SUm (Total) > 5000

/*markdown
Сколько денег заработал каждый продавец?
*/

SELECT  FirstName + ' ' + LastName,
        (
            SELECT  Sum(UnitPrice * Quantity * (1 - Discount))
            FROM    [Order Details]
            WHERE   OrderID IN (
                                    SELECT  OrderID
                                    FROM    Orders
                                    WHERE   EmployeeID = Employees.EmployeeID
                                )
        )
FROM    Employees

/*markdown
Сколько денег мы заработали на каждой категории? (Вывести название категории и деньги)
*/

SELECT  CategoryName, 
        (
            SELECT  Sum(UnitPrice * Quantity * (1 - Discount))
            FROM    [Order Details]
            WHERE   ProductID IN (
                                    SELECT  ProductID
                                    FROM    Products
                                    WHERE   CategoryID = Categories.CategoryID
            )
        )
FROM    Categories

/*markdown
Каким товаром заинтересовалось больше всего покупателей? (Вывести Название товара, CustomerID)
*/

-- Мое решение
SELECT  ProductName, 
        (
            SELECT  CustomerID
            FROM    Orders
            WHERE   OrderID IN (
                                    SELECT  OrderID
                                    FROM    [Order Details]
                                    WHERE   ProductID = Products.ProductID
                                )
        )
FROM    Products

-- Верное решение/ Не посчитала покупателей, а также нет сортировки
SELECT      TOP (1) WITH TIES ProductName
FROM        Products
ORDER BY    (
                SELECT  Count (DISTINCT CustomerID)
                FROM    Orders 
                WHERE   OrderID IN (
                                        SELECT  OrderID
                                        FROM    [Order Details]
                                        WHERE   ProductID = Products.ProductID
                                    )
            )

/*markdown
Итог по ПОДЗАПРОСАМ

1. Список чего я хочу получить в конце? -> пишем внешний селект к таблице, содержащий этот список.
2. Как только сталкиваемся с нехваткой чего-то, спрашиваем: "В какой таблице лежит то, чего нам сейчас не хватает?" -> Пишем вложенный запрос к этой таблице
*/

/*markdown
Какой покупатель в 1997 потратил больше всех денег на напитки ("Beverages")? (CustomerID)
*/

-- Мое решение/Супер неверно сделала
SELECT          TOP (1) WITH TIES ContactName
FROM            Customers
ORDER BY                (
                                SELECT  CatedoryName
                                FROM    Categories
                                WHERE   CategoryID IN (
                                                        SELECT ProductID
                                                        FROM   Products 
                                                        WHERE  ProductID IN (
                                                                                SELECT  Sum(UnitPrice * Quantity * (1 - Discount))
                                                                                FROM    [Order Details]
                                                                                WHERE   OrderID IN (
                                                                                                                SELECT  OrderID
                                                                                                                FROM    Orders
                                                                                                                WHERE   Year (OrderDate) = 1997
                                                                                                                        AND CustomerID = Customers.CustomerID
                                                                                                        )
                                                                                )
                                                        ) 
                                        AND CatedoryName = 'Beverages'
                        ) DESC

-- Верное решение
SELECT      TOP (1) WITH TIES ContactName
FROM        Customers
ORDER BY    (
                SELECT  Sum(UnitPrice * Quantity * (1 - Discount))
                FROM    [Order Details]
                                        SELECT ProductID
                                        FROM   Products 
                                        WHERE  CategoryID = (
                                                                SELECT  CategoryID
                                                                FROM    Categories
                                                                WHERE   CatedoryName = 'Beverages'
                                                             )
                                                                AND OrderID IN (
                                                                                    SELECT  OrderID
                                                                                    FROM    Orders
                                                                                    WHERE   Year (OrderDate) = 1997
                                                                                    AND CustomerID = Customers.CustomerID
                                                                                )
                                        )
                ) DESC

/*markdown
JOIN

CROSS JOIN (Перемножение таблиц). ВСе возможные сочетания строк из двух таблиц.

*/

SELECT  *
FROM    Categories

SELECT  *
FROM    Employees

-- Для успешного CROSS JOIN, пишется так

SELECT  *
FROM    Categories CROSS JOIN Employees