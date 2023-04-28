-- 1. Tworzy tabelę pracownik
CREATE TABLE pracownik (
	id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    salary DECIMAL(7,2) NOT NULL,
    date_of_birth DATE NOT NULL,
    position VARCHAR(20) NOT NULL
);

-- 2. Wstawia do tabeli 6 pracowników
INSERT INTO pracownik 
	(first_name, last_name, salary, date_of_birth, position) 
VALUES
	('Jan', 'Kowalski', 6500.00, '1980-10-09', 'manager'), 
	('Ewa', 'Nowak', 4500.00, '1982-02-03', 'secretary'), 
	('Adam', 'Zaremba', 5500.00, '1995-02-12', 'developer'), 
	('Ola', 'Nosowska', 8500.00, '1987-03-05', 'developer'), 
	('Piotr', 'Rybacki', 8500.00, '1998-02-01', 'tester'), 
	('Alicja', 'Szymanek', 3500.00, '1998-02-01', 'intern');
    
-- 3.Pobiera wszystkich pracowników i wyświetal ich w kolejności alfabetycznej po nazwisku     
SELECT * FROM pracownik ORDER BY last_name;

-- 4.Pobiera pracowników na wybranym stanowisku
SELECT * FROM pracownik WHERE position = 'developer';

-- 5.Pobiera pracowników, którzy mają co najmniej 30 lat
SELECT * FROM pracownik WHERE ABS(DATEDIFF(date_of_birth, CURDATE())) >= 10950;
SELECT * FROM pracownik WHERE YEAR(CURDATE()) - YEAR(date_of_birth) >= 30;

-- 6.Zwiększa wypłatę pracowników na wybranym stanowisku o 10%
UPDATE pracownik SET salary = salary + (salary * 10/100) WHERE position = 'developer';

-- 7. Pobiera najmłodszego pracownika
SELECT * FROM pracownik WHERE date_of_birth = (SELECT MAX(date_of_birth) AS date_of_birth FROM pracownik);

-- 8. Usuwa tabelę pracownik
DROP TABLE pracownik;

-- 9. Tworzy tabelę stanowisko
CREATE TABLE stanowisko (
	id INT PRIMARY KEY AUTO_INCREMENT,
    position VARCHAR(20) NOT NULL,
    description VARCHAR(2000) NOT NULL,
    salary DECIMAL(7,2) NOT NULL
);

-- 10. Tworzy tabelę adres
CREATE TABLE adres (
	id INT PRIMARY KEY AUTO_INCREMENT,
    street_name_and_no VARCHAR(30) NOT NULL,
    postcode VARCHAR(10) NOT NULL,
    city VARCHAR(30) NOT NULL
);

-- 11.Tworzy tabelę pracownik
CREATE TABLE pracownik (
	id INT PRIMARY KEY AUTO_INCREMENT,
	first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    stanowisko_id INT NOT NULL,
    adres_id INT NOT NULL,
    FOREIGN KEY (stanowisko_id) REFERENCES stanowisko (id),
    FOREIGN KEY (adres_id) REFERENCES adres (id)
);

-- 12. Dodaje dane testowe
INSERT INTO stanowisko
	(position, description, salary)
VALUES
	('manager', "oversees team members in a certain department to ensure it's performing effectively", 8500.00),
	('developer', "researching, designing, implementing, and managing software programs", 6500.00),
	('secretary', "professional who provides behind-the-scenes work for an office", 5500.00);

INSERT INTO adres
	(street_name_and_no, postcode, city)
VALUES
	('Wesoła 15', 26605, 'Radom'),
	('Poziomkowa 33', 43010, 'Opole'),
	('Wyzwolenia 79', 10950, 'Warszawa');
    
INSERT INTO pracownik
	(first_name, last_name, stanowisko_id, adres_id)
VALUES
	('Agata', 'Nowacka', 3, 1),
	('Tomasz', 'Wspaniały', 2, 3),
	('Edward', 'Godula', 1, 2);
    
-- 13. Pobiera pełne informacje o pracowniku
SELECT first_name, last_name, street_name_and_no, postcode, city, position FROM pracownik 
JOIN stanowisko ON pracownik.id = stanowisko.id
JOIN adres ON pracownik.id = adres.id;

-- 14. Oblicza sumę wypłat dla wszystkich pracowników
SELECT SUM(salary) 'Suma wypłat pracowników' FROM pracownik
JOIN stanowisko ON pracownik.stanowisko_id = stanowisko.id;

-- 15. Pobiera pracowników mieszkających w lokalizacji z kodem pocztowym 43010
SELECT first_name, last_name, postcode FROM pracownik
JOIN adres ON pracownik.id = adres.id WHERE postcode = '43010';