--Wyświetl całość informacji z relacji ZESPOLY. Wynik posortuj rosnąco wg identyfikatorów 
--zespołów:
SELECT * FROM ZESPOLY
ORDER BY ID_ZESP;

--Wyświetl całość informacji z relacji PRACOWNICY. Wynik posortuj rosnąco wg 
--identyfikatorów pracowników.
SELECT * FROM PRACOWNICY
ORDER BY ID_PRAC;

--Wyświetl nazwiska i roczne dochody (dwunastokrotność płacy podstawowej) pracowników. 
--Zmień nazwę kolumny z roczną płacą jak przedstawiono poniżej. Posortuj dane rosnąco wg 
--nazwisk pracowników.
SELECT NAZWISKO, PLACA_POD * 12 FROM PRACOWNICY
ORDER BY NAZWISKO;

--Wyświetl nazwiska pracowników, nazwy etatów na których pracują oraz sumaryczne 
--miesięczne dochody pracowników (z uwzględnieniem płac dodatkowych). Zmień nazwę 
--kolumny z zarobkami jak przedstawiono poniżej. Dane posortuj malejąco wg miesięcznych 
--zarobków.
SELECT NAZWISKO, ETAT, NVL(PLACA_POD,0) + NVL(PLACA_DOD,0) AS 
MIESIECZNE_ZAROBKI FROM PRACOWNICY
ORDER BY MIESIECZNE_ZAROBKI DESC;

--Wyświetl całość informacji o zespołach sortując wynik rosnąco według nazw zespołów
SELECT * FROM ZESPOLY ORDER BY NAZWA;

--Wyświetl listę etatów (bez duplikatów) na których zatrudnieni są pracownicy Instytutu
SELECT UNIQUE ETAT FROM PRACOWNICY ORDER BY ETAT;

--Wyświetl wszystkie informacje o asystentach pracujących w Instytucie. Wynik posortuj wg 
--nazwisk pracowników.
SELECT * FROM PRACOWNICY WHERE ETAT = 'ASYSTENT' ORDER BY NAZWISKO;

--Wyświetl poniższe dane o pracownikach zespołów 30 i 40 w kolejności malejących 
--zarobków.
SELECT ID_PRAC, NAZWISKO, ETAT, PLACA_POD, ID_ZESP FROM PRACOWNICY 
WHERE ID_ZESP = 30 OR ID_ZESP = 40 ORDER BY PLACA_POD DESC;

--Wyświetl dane o pracownikach których płace podstawowe mieszczą się w przedziale 300 do 
--800 zł. Wynik posortuj rosnąco wg nazwisk pracowników.
SELECT NAZWISKO, ID_ZESP, PLACA_POD FROM PRACOWNICY WHERE 
PLACA_POD BETWEEN 300 AND 800 ORDER BY NAZWISKO;

--Wyświetl poniższe informacje o pracownikach, których nazwisko kończy się na „SKI”
SELECT NAZWISKO, ETAT, ID_ZESP FROM PRACOWNICY WHERE NAZWISKO LIKE 
'%SKI';

--Wyświetl poniższe informacje o tych pracownikach, którzy zarabiają powyżej 1000 złotych i 
--posiadają szefa.
SELECT NAZWISKO, ID_ZESP, PLACA_POD FROM PRACOWNICY WHERE 
PLACA_POD > 1000 AND ID_SZEFA LIKE '%';

--Wyświetl nazwiska i identyfikatory zespołów pracowników zatrudnionych w zespole nr 20, 
--których nazwisko zaczyna się na „M” lub kończy na „SKI”. Wynik posortuj wg nazwisk.
SELECT NAZWISKO, ID_ZESP FROM PRACOWNICY 
WHERE ID_ZESP LIKE '20' AND (NAZWISKO LIKE 'M%' OR NAZWISKO LIKE '%SKI')
ORDER BY NAZWISKO;

--Wyświetl nazwiska, etaty i stawki godzinowe tych pracowników, którzy nie są ani adiunktami 
--ani asystentami ani stażystami i którzy nie zarabiają w przedziale od 400 do 800 złotych. 
--Wyniki uszereguj według stawek godzinowych pracowników (przyjmij 20-dniowy miesiąc 
--pracy i 8- godzinny dzień pracy). Wynik posortuj wg wartości stawek w porządku rosnącym.
SELECT NAZWISKO, ETAT, (NVL(PLACA_POD,0))/160 AS STAWKA FROM 
PRACOWNICY
WHERE ETAT NOT LIKE 'STAZYSTA' AND ETAT NOT LIKE 'ASYSTENT' AND ETAT NOT 
LIKE 'ADIUNKT' AND PLACA_POD NOT BETWEEN 400 AND 800 
ORDER BY STAWKA;

--Wyświetl nazwiska, etaty i stawki godzinowe tych pracowników, którzy nie są ani adiunktami 
--ani asystentami ani stażystami i którzy nie zarabiają w przedziale od 400 do 800 złotych. 
--Wyniki uszereguj według stawek godzinowych pracowników (przyjmij 20-dniowy miesiąc 
--pracy i 8- godzinny dzień pracy). Wynik posortuj wg wartości stawek w porządku rosnącym.
SELECT NAZWISKO, ETAT, NVL(PLACA_POD,0), NVL(PLACA_DOD,0) FROM 
PRACOWNICY
WHERE (NVL(PLACA_POD,0) + NVL(PLACA_DOD,0)) > 1000 
ORDER BY ETAT, NAZWISKO;

--Wyświetl poniższe informacje o profesorach, wyniki uporządkuj według malejących płac (nie 
--zwracaj uwagi na format prezentacji daty).
SELECT (NAZWISKO|| ' PRACUJE OD '||ZATRUDNIONY|| ' I ZARABIA '||PLACA_POD) AS 
PROFESOROWIE FROM PRACOWNICY
WHERE ETAT LIKE 'PROFESOR'
ORDER BY PLACA_POD DESC;
