-- Создание таблицы Departments
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL
);

-- Создание таблицы Roles
CREATE TABLE Roles (
    RoleID INT PRIMARY KEY,
    RoleName VARCHAR(100) NOT NULL
);

-- Создание таблицы Employees
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Position VARCHAR(100),
    ManagerID INT,
    DepartmentID INT,
    RoleID INT,
    FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID),
    FOREIGN KEY (RoleID) REFERENCES Roles(RoleID)
);

-- Создание таблицы Projects
CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100) NOT NULL,
    StartDate DATE,
    EndDate DATE,
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Создание таблицы Tasks
CREATE TABLE Tasks (
    TaskID INT PRIMARY KEY,
    TaskName VARCHAR(100) NOT NULL,
    AssignedTo INT,
    ProjectID INT,
    FOREIGN KEY (AssignedTo) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID)
);

-- Вставка данных в таблицу Departments
INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'Отдел продаж'),
(2, 'Отдел маркетинга'),
(3, 'IT-отдел'),
(4, 'Отдел разработки'),
(5, 'Отдел поддержки');

-- Вставка данных в таблицу Roles
INSERT INTO Roles (RoleID, RoleName) VALUES
(1, 'Менеджер'),
(2, 'Директор'),
(3, 'Генеральный директор'),
(4, 'Разработчик'),
(5, 'Специалист по поддержке'),
(6, 'Маркетолог');

-- Вставка данных в таблицу Employees
INSERT INTO Employees (EmployeeID, Name, Position, ManagerID, DepartmentID, RoleID) VALUES
(1, 'Иван Иванов', 'Генеральный директор', NULL, 1, 3),
(2, 'Петр Петров', 'Директор по продажам', 1, 1, 2),
(3, 'Светлана Светлова', 'Директор по маркетингу', 1, 2, 2),
(4, 'Алексей Алексеев', 'Менеджер по продажам', 2, 1, 1),
(5, 'Мария Мариева', 'Менеджер по маркетингу', 3, 2, 1),
(6, 'Андрей Андреев', 'Разработчик', 1, 4, 4),
(7, 'Елена Еленова', 'Специалист по поддержке', 1, 5, 5),
(8, 'Олег Олегов', 'Менеджер по продукту', 2, 1, 1),
(9, 'Татьяна Татеева', 'Маркетолог', 3, 2, 6),
(10, 'Николай Николаев', 'Разработчик', 6, 4, 4),
(11, 'Ирина Иринина', 'Разработчик', 6, 4, 4),
(12, 'Сергей Сергеев', 'Специалист по поддержке', 7, 5, 5),
(13, 'Кристина Кристинина', 'Менеджер по продажам', 4, 1, 1),
(14, 'Дмитрий Дмитриев', 'Маркетолог', 3, 2, 6),
(15, 'Виктор Викторов', 'Менеджер по продажам', 4, 1, 1),
(16, 'Анастасия Анастасиева', 'Специалист по поддержке', 7, 5, 5),
(17, 'Максим Максимов', 'Разработчик', 6, 4, 4),
(18, 'Людмила Людмилова', 'Специалист по маркетингу', 3, 2, 6),
(19, 'Наталья Натальева', 'Менеджер по продажам', 4, 1, 1),
(20, 'Александр Александров', 'Менеджер по маркетингу', 3, 2, 1),
(21, 'Галина Галина', 'Специалист по поддержке', 7, 5, 5),
(22, 'Павел Павлов', 'Разработчик', 6, 4, 4),
(23, 'Марина Маринина', 'Специалист по маркетингу', 3, 2, 6),
(24, 'Станислав Станиславов', 'Менеджер по продажам', 4, 1, 1),
(25, 'Екатерина Екатеринина', 'Специалист по поддержке', 7, 5, 5),
(26, 'Денис Денисов', 'Разработчик', 6, 4, 4),
(27, 'Ольга Ольгина', 'Маркетолог', 3, 2, 6),
(28, 'Игорь Игорев', 'Менеджер по продукту', 2, 1, 1),
(29, 'Анастасия Анастасиевна', 'Специалист по поддержке', 7, 5, 5),
(30, 'Валентин Валентинов', 'Разработчик', 6, 4, 4);

-- Вставка данных в таблицу Projects
INSERT INTO Projects (ProjectID, ProjectName, StartDate, EndDate, DepartmentID) VALUES
(1, 'Проект A', '2025-01-01', '2025-12-31', 1),
(2, 'Проект B', '2025-02-01', '2025-11-30', 2),
(3, 'Проект C', '2025-03-01', '2025-10-31', 4),
(4, 'Проект D', '2025-04-01', '2025-09-30', 5),
(5, 'Проект E', '2025-05-01', '2025-08-31', 3);

-- Вставка данных в таблицу Tasks
INSERT INTO Tasks (TaskID, TaskName, AssignedTo, ProjectID) VALUES
(1, 'Задача 1: Подготовка отчета по продажам', 4, 1),
(2, 'Задача 2: Анализ рынка', 9, 2),
(3, 'Задача 3: Разработка нового функционала', 10, 3),
(4, 'Задача 4: Поддержка клиентов', 12, 4),
(5, 'Задача 5: Создание рекламной кампании', 5, 2),
(6, 'Задача 6: Обновление документации', 6, 3),
(7, 'Задача 7: Проведение тренинга для сотрудников', 8, 1),
(8, 'Задача 8: Тестирование нового продукта', 11, 3),
(9, 'Задача 9: Ответы на запросы клиентов', 12, 4),
(10, 'Задача 10: Подготовка маркетинговых материалов', 9, 2),
(11, 'Задача 11: Интеграция с новым API', 10, 3),
(12, 'Задача 12: Настройка системы поддержки', 7, 5),
(13, 'Задача 13: Проведение анализа конкурентов', 9, 2),
(14, 'Задача 14: Создание презентации для клиентов', 4, 1),
(15, 'Задача 15: Обновление сайта', 6, 3);


/*
Задача 1

Условие

Найти всех сотрудников, подчиняющихся Ивану Иванову (с EmployeeID = 1), включая их подчиненных и подчиненных подчиненных. Для каждого сотрудника вывести следующую информацию:

    EmployeeID: идентификатор сотрудника.
    Имя сотрудника.
    ManagerID: Идентификатор менеджера.
    Название отдела, к которому он принадлежит.
    Название роли, которую он занимает.
    Название проектов, к которым он относится (если есть, конкатенированные в одном столбце через запятую).
    Название задач, назначенных этому сотруднику (если есть, конкатенированные в одном столбце через запятую).
    Если у сотрудника нет назначенных проектов или задач, отобразить NULL.

Требования:

    Рекурсивно извлечь всех подчиненных сотрудников Ивана Иванова и их подчиненных.
    Для каждого сотрудника отобразить информацию из всех таблиц.
    Результаты должны быть отсортированы по имени сотрудника.
    Решение задачи должно представлять из себя один sql-запрос и задействовать ключевое слово RECURSIVE.

*/


WITH RECURSIVE employee_hierarchy AS (
	SELECT 
		EmployeeID, 
		Name AS EmployeeName,
		ManagerID,
		DepartmentID,
		RoleID
		
	FROM
		Employees
	WHERE
		ManagerID = 1 OR ManagerID IS NULL
		
	UNION
	
	SELECT
		e.EmployeeID, 
		e.Name AS EmployeeName,
		e.ManagerID,
		e.DepartmentID,
		e.RoleID
	FROM
		Employees e
	JOIN employee_hierarchy eh
		ON e.ManagerID = eh.EmployeeID
)

SELECT 
	EmployeeID,
	EmployeeName,
	ManagerID,
	DepartmentName,
	RoleName,
    GROUP_CONCAT(DISTINCT Projects.ProjectName ORDER BY Projects.ProjectName SEPARATOR ', ') AS ProjectName,
    GROUP_CONCAT(DISTINCT Tasks.TaskName ORDER BY Tasks.TaskName SEPARATOR ', ') AS TaskNames
FROM 
	employee_hierarchy eh
LEFT JOIN
	Departments
ON
	Departments.DepartmentID = eh.DepartmentID
LEFT JOIN
	Tasks
ON
	eh.EmployeeID = Tasks.AssignedTo
LEFT JOIN
	Roles
ON
	Roles.RoleID = eh.RoleID
LEFT JOIN
	Projects
ON
	Departments.DepartmentID = Projects.DepartmentID
GROUP BY
    eh.EmployeeID, eh.EmployeeName, eh.ManagerID, Departments.DepartmentName, Roles.RoleName
ORDER BY 
	EmployeeName;


/*
Задача 2

Условие

Найти всех сотрудников, подчиняющихся Ивану Иванову с EmployeeID = 1, включая их подчиненных и подчиненных подчиненных. Для каждого сотрудника вывести следующую информацию:

    EmployeeID: идентификатор сотрудника.
    Имя сотрудника.
    Идентификатор менеджера.
    Название отдела, к которому он принадлежит.
    Название роли, которую он занимает.
    Название проектов, к которым он относится (если есть, конкатенированные в одном столбце).
    Название задач, назначенных этому сотруднику (если есть, конкатенированные в одном столбце).
    Общее количество задач, назначенных этому сотруднику.
    Общее количество подчиненных у каждого сотрудника (не включая подчиненных их подчиненных).
    Если у сотрудника нет назначенных проектов или задач, отобразить NULL.
*/
WITH RECURSIVE employee_hierarchy AS (
	SELECT 
		EmployeeID, 
		Name AS EmployeeName,
		ManagerID,
		DepartmentID,
		RoleID
		
	FROM
		Employees
	WHERE
		ManagerID = 1 OR ManagerID IS NULL
		
	UNION
	
	SELECT
		e.EmployeeID, 
		e.Name AS EmployeeName,
		e.ManagerID,
		e.DepartmentID,
		e.RoleID
	FROM
		Employees e
	JOIN employee_hierarchy eh
		ON e.ManagerID = eh.EmployeeID
)

SELECT 
	EmployeeID,
	EmployeeName,
	ManagerID,
	DepartmentName,
	RoleName,
    GROUP_CONCAT(DISTINCT Projects.ProjectName ORDER BY Projects.ProjectName SEPARATOR ', ') AS ProjectName,
    GROUP_CONCAT(DISTINCT Tasks.TaskName ORDER BY Tasks.TaskName SEPARATOR ', ') AS TaskNames,
    COUNT(DISTINCT Tasks.TaskName) AS TotalTasks,
    (SELECT COUNT(*) FROM Employees e WHERE e.ManagerID = eh.EmployeeID) AS TotalSubordinates
FROM 
	employee_hierarchy eh
LEFT JOIN
	Departments
ON
	Departments.DepartmentID = eh.DepartmentID
LEFT JOIN
	Tasks
ON
	eh.EmployeeID = Tasks.AssignedTo
LEFT JOIN
	Roles
ON
	Roles.RoleID = eh.RoleID
LEFT JOIN
	Projects
ON
	Departments.DepartmentID = Projects.DepartmentID
GROUP BY
    eh.EmployeeID, eh.EmployeeName, eh.ManagerID, Departments.DepartmentName, Roles.RoleName
ORDER BY 
	EmployeeName;
