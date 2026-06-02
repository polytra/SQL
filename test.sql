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