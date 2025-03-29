-- Создание таблицы Classes
CREATE TABLE Classes (
    class VARCHAR(100) NOT NULL,
    type ENUM('Racing', 'Street') NOT NULL,
    country VARCHAR(100) NOT NULL,
    numDoors INT NOT NULL,
    engineSize DECIMAL(3, 1) NOT NULL, -- размер двигателя в литрах
    weight INT NOT NULL,                -- вес автомобиля в килограммах
    PRIMARY KEY (class)
);

-- Создание таблицы Cars
CREATE TABLE Cars (
    name VARCHAR(100) NOT NULL,
    class VARCHAR(100) NOT NULL,
    year INT NOT NULL,
    PRIMARY KEY (name),
    FOREIGN KEY (class) REFERENCES Classes(class)
);

-- Создание таблицы Races
CREATE TABLE Races (
    name VARCHAR(100) NOT NULL,
    date DATE NOT NULL,
    PRIMARY KEY (name)
);

-- Создание таблицы Results
CREATE TABLE Results (
    car VARCHAR(100) NOT NULL,
    race VARCHAR(100) NOT NULL,
    position INT NOT NULL,
    PRIMARY KEY (car, race),
    FOREIGN KEY (car) REFERENCES Cars(name),
    FOREIGN KEY (race) REFERENCES Races(name)
);

-- Вставка данных в таблицу Classes
INSERT INTO Classes (class, type, country, numDoors, engineSize, weight) VALUES
('SportsCar', 'Racing', 'USA', 2, 3.5, 1500),
('Sedan', 'Street', 'Germany', 4, 2.0, 1200),
('SUV', 'Street', 'Japan', 4, 2.5, 1800),
('Hatchback', 'Street', 'France', 5, 1.6, 1100),
('Convertible', 'Racing', 'Italy', 2, 3.0, 1300),
('Coupe', 'Street', 'USA', 2, 2.5, 1400),
('Luxury Sedan', 'Street', 'Germany', 4, 3.0, 1600),
('Pickup', 'Street', 'USA', 2, 2.8, 2000);

-- Вставка данных в таблицу Cars
INSERT INTO Cars (name, class, year) VALUES
('Ford Mustang', 'SportsCar', 2020),
('BMW 3 Series', 'Sedan', 2019),
('Toyota RAV4', 'SUV', 2021),
('Renault Clio', 'Hatchback', 2020),
('Ferrari 488', 'Convertible', 2019),
('Chevrolet Camaro', 'Coupe', 2021),
('Mercedes-Benz S-Class', 'Luxury Sedan', 2022),
('Ford F-150', 'Pickup', 2021),
('Audi A4', 'Sedan', 2018),
('Nissan Rogue', 'SUV', 2020);

-- Вставка данных в таблицу Races
INSERT INTO Races (name, date) VALUES
('Indy 500', '2023-05-28'),
('Le Mans', '2023-06-10'),
('Monaco Grand Prix', '2023-05-28'),
('Daytona 500', '2023-02-19'),
('Spa 24 Hours', '2023-07-29'),
('Bathurst 1000', '2023-10-08'),
('Nürburgring 24 Hours', '2023-06-17'),
('Pikes Peak International Hill Climb', '2023-06-25');

-- Вставка данных в таблицу Results
INSERT INTO Results (car, race, position) VALUES
('Ford Mustang', 'Indy 500', 1),
('BMW 3 Series', 'Le Mans', 3),
('Toyota RAV4', 'Monaco Grand Prix', 2),
('Renault Clio', 'Daytona 500', 5),
('Ferrari 488', 'Le Mans', 1),
('Chevrolet Camaro', 'Monaco Grand Prix', 4),
('Mercedes-Benz S-Class', 'Spa 24 Hours', 2),
('Ford F-150', 'Bathurst 1000', 6),
('Audi A4', 'Nürburgring 24 Hours', 8),
('Nissan Rogue', 'Pikes Peak International Hill Climb', 3);

/*
Задача 1

Условие

Определить, какие автомобили из каждого класса имеют наименьшую среднюю позицию в гонках, 
и вывести информацию о каждом таком автомобиле для данного класса, включая его класс, 
среднюю позицию и количество гонок, в которых он участвовал. 
Также отсортировать результаты по средней позиции.
*/
WITH positions AS (
	SELECT
		name AS car_name,
		class AS car_class,
		Results.position AS position,
		race
	FROM
		Cars
	LEFT JOIN 
		Results
	ON
		Cars.name = Results.car
	),
	
	average_positions AS (
	SELECT
		car_name,
		car_class,
		ROUND(AVG(position)/COUNT(race), 4) AS average_position,
		COUNT(race) AS race_count
	FROM
		positions 
	GROUP BY
		car_name
	),
	
	min_avg_per_class AS (
	    SELECT car_class, MIN(average_position) AS min_avg_position
	    FROM average_positions
	    GROUP BY car_class
)

SELECT 
	ap.car_name, 
	ap.car_class, 
	ap.average_position, 
	ap.race_count
FROM average_positions ap
JOIN 
	min_avg_per_class mpc
ON 
  ap.car_class = mpc.car_class AND ap.average_position = mpc.min_avg_position
ORDER BY ap.average_position;
	
	
	
/*
Задача 2

Условие

Определить автомобиль, который имеет наименьшую среднюю позицию в гонках среди всех автомобилей, 
и вывести информацию об этом автомобиле, включая его класс, среднюю позицию, количество гонок, в которых он участвовал, 
и страну производства класса автомобиля. 
Если несколько автомобилей имеют одинаковую наименьшую среднюю позицию, выбрать один из них по алфавиту (по имени автомобиля).
 */	
WITH cars_info AS (
	SELECT
		Cars.name AS car_name,
		Cars.class AS car_class,
		ROUND(AVG(Results.position), 4) AS average_position,
		COUNT(race) AS race_count,
		Classes.country AS car_country
		
	FROM
		Cars
	LEFT JOIN 
		Results
	ON
		Cars.name = Results.car
	LEFT JOIN 
		Classes
	ON
		Cars.class = Classes.class
	GROUP BY
		car_name
)
SELECT 
	*
FROM 
	cars_info
ORDER BY average_position, car_name
LIMIT 1

	
/*
Задача 3

Условие

Определить классы автомобилей, которые имеют наименьшую среднюю позицию в гонках, 
и вывести информацию о каждом автомобиле из этих классов, включая его имя, среднюю позицию, количество гонок,
в которых он участвовал, страну производства класса автомобиля, а также общее количество гонок, 
в которых участвовали автомобили этих классов. 
Если несколько классов имеют одинаковую среднюю позицию, выбрать все из них.
*/	
	
WITH cars_info AS (
	SELECT
		Cars.name AS car_name,
		Cars.class AS car_class,
		ROUND(AVG(Results.position), 4) AS average_position,
		COUNT(race) AS race_count,
		Classes.country AS car_country
	FROM
		Cars
	LEFT JOIN 
		Results
	ON
		Cars.name = Results.car
	LEFT JOIN 
		Classes
	ON
		Cars.class = Classes.class
	GROUP BY
		car_name
),
races_by_class AS (
	SELECT
		car_class,
		SUM(race_count) AS total_races
	FROM
		cars_info
	GROUP BY
		car_class
)
SELECT 
	car_name,
	cars_info.car_class,
	average_position,
	race_count,
	car_country,
	total_races
FROM 
	cars_info
LEFT JOIN
	races_by_class
ON
	cars_info.car_class = races_by_class.car_class
WHERE 
	average_position = (SELECT MIN(average_position) FROM cars_info);


/*
Задача 4

Условие

Определить, какие автомобили имеют среднюю позицию лучше (меньше) средней позиции всех автомобилей 
в своем классе (то есть автомобилей в классе должно быть минимум два, чтобы выбрать один из них). 
Вывести информацию об этих автомобилях, включая их имя, класс, среднюю позицию, количество гонок, 
в которых они участвовали, и страну производства класса автомобиля. 
Также отсортировать результаты по классу и затем по средней позиции в порядке возрастания.
*/
	

WITH cars_info AS (
	SELECT
		Cars.name AS car_name,
		Cars.class AS car_class,
		ROUND(AVG(Results.position), 4) AS average_position,
		COUNT(race) AS race_count,
		Classes.country AS car_country
	FROM
		Cars
	LEFT JOIN 
		Results
	ON
		Cars.name = Results.car
	LEFT JOIN 
		Classes
	ON
		Cars.class = Classes.class
	GROUP BY
		car_name
	
),
-- Классы с количеством автомобилей более одного и средней позицией по классу
car_classes AS (
	SELECT
		car_class AS car_class_many,
		AVG(average_position) AS class_average_position
	FROM
		cars_info
	GROUP BY
		car_class
	HAVING
		COUNT(car_class) > 1
) 

SELECT 
	car_name,
	car_class,
	average_position,
	race_count,
	car_country
FROM
	cars_info
LEFT JOIN
	car_classes
ON
	cars_info.car_class = car_classes.car_class_many
WHERE
	car_class_many IS NOT NULL AND average_position < class_average_position;
	
/*
Задача 5

Условие

Определить, какие классы автомобилей имеют наибольшее количество автомобилей с низкой средней позицией (больше 3.0) 
и вывести информацию о каждом автомобиле из этих классов, 
включая его имя, класс, среднюю позицию, количество гонок, в которых он участвовал, страну производства класса автомобиля,
а также общее количество гонок для каждого класса. 
Отсортировать результаты по количеству автомобилей с низкой средней позицией.
*/	
	
WITH cars_info AS (
	SELECT
		Cars.name AS car_name,
		Cars.class AS car_class,
		ROUND(AVG(Results.position), 4) AS average_position,
		COUNT(race) AS race_count,
		Classes.country AS car_country
	FROM
		Cars
	LEFT JOIN 
		Results
	ON
		Cars.name = Results.car
	LEFT JOIN 
		Classes
	ON
		Cars.class = Classes.class
	GROUP BY
		car_name, car_class
),
slow_cars AS (
    SELECT 
        car_name,
        car_class,
        average_position,
        race_count
    FROM cars_info 
    WHERE average_position > 3.0
),
class_races AS (
    SELECT 
        cars_info.car_class AS car_class,
        COUNT(Results.race) AS total_races
    FROM cars_info
    JOIN Results ON cars_info.car_name = Results.car
    GROUP BY cars_info.car_class
),
slow_car_classes AS (
	SELECT
		car_class AS car_class,
		COUNT(race_count) AS low_position_count
	FROM
		slow_cars
	GROUP BY
		car_class
) 
SELECT 
	slow_cars.car_name,
	slow_cars.car_class,
	slow_cars.average_position,
	slow_cars.race_count,
	car_country,
	total_races,
	low_position_count
FROM 
	slow_cars
JOIN
	cars_info
ON
	slow_cars.car_name = cars_info.car_name
JOIN
	slow_car_classes
ON
	cars_info.car_class = slow_car_classes.car_class
JOIN
	class_races
ON
	cars_info.car_class = class_races.car_class
ORDER BY low_position_count DESC, average_position DESC;
