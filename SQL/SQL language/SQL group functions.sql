Wyświetl najniższą i najwyższą pensję w firmie. Wyświetl informację o różnicy dzielącej 
najlepiej i najgorzej zarabiających pracowników.
SELECT MIN(PLACA_POD) AS P_MINIMUM, MAX(PLACA_POD) AS P_MAKSIMUM, 
MAX(PLACA_POD) - MIN(PLACA_POD) AS ROZNICA FROM PRACOWNICY;

Wyświetl średnie pensje dla wszystkich etatów. Wyniki uporządkuj wg malejącej średniej 
pensji.
SELECT ETAT, AVG(PLACA_POD) AS SREDNIA FROM PRACOWNICY 
GROUP BY ETAT
ORDER BY SREDNIA DESC;

Wyświetl liczbę profesorów zatrudnionych w Instytucie
SELECT COUNT(ETAT) AS PROFESOROWIE FROM PRACOWNICY WHERE ETAT 
LIKE 'PROFESOR';

Znajdź sumaryczne miesięczne płace dla każdego zespołu. Nie zapomnij o płacach 
dodatkowych.
SELECT ID_ZESP, SUM(NVL(PLACA_POD,0) + NVL(PLACA_DOD,0)) AS
SUMARYCZNE_PLACE FROM PRACOWNICY GROUP BY ID_ZESP ORDER BY
ID_ZESP;

Zmodyfikuj zapytanie z zadania poprzedniego w taki sposób, aby jego wynikiem była 
sumaryczna miesięczna płaca w zespole, który wypłaca swoim pracownikom najwięcej 
pieniędzy.
SELECT MAX(SUM(NVL(PLACA_POD,0) + NVL(PLACA_DOD,0))) AS
SUMARYCZNE_PLACE FROM PRACOWNICY GROUP BY ID_ZESP;

Dla każdego pracownika, który posiada podwładnych, wyświetl pensję najgorzej 
zarabiającego podwładnego. Wyniki uporządkuj wg malejącej pensji.
SELECT ID_SZEFA, MIN(PLACA_POD) AS MINIMALNA FROM PRACOWNICY WHERE
ID_SZEFA IS NOT NULL GROUP BY ID_SZEFA ORDER BY MINIMALNA DESC;

Wyświetl numery zespołów wraz z liczbą pracowników w każdym zespole. Wyniki 
uporządkuj wg malejącej liczby pracowników.
SELECT ID_ZESP, COUNT(ID_PRAC) AS ILU_PRACUJE FROM PRACOWNICY GROUP 
BY ID_ZESP ORDER BY ILU_PRACUJE DESC;

Zmodyfikuj zapytanie z zadania poprzedniego, aby wyświetlić numery tylko tych zespołów, 
które zatrudniają więcej niż 3 pracowników.
SELECT ID_ZESP, COUNT(ID_PRAC) AS ILU_PRACUJE FROM PRACOWNICY GROUP 
BY ID_ZESP HAVING COUNT(ID_PRAC) > 3 ORDER BY ILU_PRACUJE DESC;

Sprawdź, czy identyfikatory pracowników są unikalne. Wyświetl zdublowane wartości 
identyfikatorów.
SELECT COUNT(ID_PRAC) FROM PRACOWNICY GROUP BY ID_PRAC HAVING 
COUNT(ID_PRAC) > 1;

Wyświetl średnie pensje wypłacane w ramach poszczególnych etatów i liczbę zatrudnionych 
na danym etacie. Pomiń pracowników zatrudnionych po 1990 roku.
SELECT ETAT, AVG(PLACA_POD), COUNT(ETAT) FROM PRACOWNICY WHERE
EXTRACT(YEAR FROM ZATRUDNIONY) < 1990 GROUP BY ETAT ORDER BY ETAT;

Zbuduj zapytanie, które wyświetli średnie i maksymalne pensje asystentów i profesorów w 
poszczególnych zespołach (weź pod uwagę zarówno płace podstawowe jak i dodatkowe). 
Dokonaj zaokrąglenia pensji do wartości całkowitych. Wynik zapytania posortuj wg 
identyfikatorów zespołów i nazw etatów.
SELECT ID_ZESP, 
 ETAT, 
 AVG(ROUND(NVL(PLACA_POD,0) + NVL(PLACA_DOD,0), 0)) AS SREDNIA, 
 MAX(ROUND(NVL(PLACA_POD,0) + NVL(PLACA_DOD,0), 0)) AS MAKSYMALNA
FROM PRACOWNICY 
WHERE etat in ('PROFESOR', 'ASYSTENT')
GROUP BY ID_ZESP, etat
ORDER BY ID_ZESP, ETAT;

Zbuduj zapytanie, które wyświetli, ilu pracowników zostało zatrudnionych w poszczególnych 
latach. Wynik posortuj rosnąco ze względu na rok zatrudnienia.
SELECT TO_CHAR(EXTRACT(YEAR FROM ZATRUDNIONY)) AS ROK, 
COUNT(ID_PRAC) FROM PRACOWNICY GROUP BY EXTRACT(YEAR FROM
ZATRUDNIONY) ORDER BY ROK;

Zbuduj zapytanie, które policzy liczbę liter w nazwiskach pracowników i wyświetli liczbę 
nazwisk z daną liczbą liter. Wynik zapytania posortuj rosnąco wg liczby liter w nazwiskach.
SELECT LENGTH(NAZWISKO) AS "ILE_LITER", COUNT(NAZWISKO) AS
"W_ILU_NAZWISKACH" FROM PRACOWNICY GROUP BY LENGTH(NAZWISKO) 
ORDER BY LENGTH(NAZWISKO);

Zbuduj zapytanie, które wyliczy, ilu pracowników w swoim nazwisku posiada chociaż jedną 
literę „a” lub „A”.
SELECT COUNT(NAZWISKO) AS "ILE NAZWISK Z A" FROM PRACOWNICY WHERE
NAZWISKO LIKE '%A%' OR NAZWISKO LIKE '%a%'; 

Zmień poprzednie zapytanie w taki sposób, aby oprócz kolumny, pokazującej ilu 
pracowników w swoim nazwisku posiada chociaż jedną literę „a” lub „A”, pojawiła się 
kolumna pokazująca liczbę pracowników z chociaż jedną literą „e” lub „E” w nazwisku.
SELECT
 COUNT(CASE WHEN INSTR(NAZWISKO, 'A', 1, 1) > 0 THEN 1 ELSE NULL END) AS
"ILE NAZWISK Z A",
 COUNT(CASE WHEN INSTR(NAZWISKO, 'E', 1, 1) > 0 THEN 1 ELSE NULL END) AS
"ILE NAZWISK Z E"
FROM PRACOWNICY;

Dla każdego zespołu wyświetl jego identyfikator, sumę płac pracowników w nim 
zatrudnionych oraz listę pracowników w formie: nazwisko:podstawowa płaca pracownika. 
Dane pracowników na liście mają zostać oddzielone średnikami. Wynik posortuj wg 
identyfikatorów zespołów.
SELECT ID_ZESP, SUM(PLACA_POD) AS SUMA,
LISTAGG(NAZWISKO||':'||PLACA_POD, ';') 
WITHIN GROUP (ORDER BY NAZWISKO) AS PRACOWNICY 
FROM PRACOWNICY 
GROUP BY ID_ZESP 
ORDER BY ID_ZESP;
