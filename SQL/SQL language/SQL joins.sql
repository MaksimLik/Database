--Wyświetl nazwiska, etaty, numery zespołów i nazwy zespołów wszystkich pracowników. 
--Wynik uporządkuj wg nazwisk pracowników.
SELECT NAZWISKO, ETAT, ZESPOLY.ID_ZESP, NAZWA 
FROM PRACOWNICY, ZESPOLY 
WHERE PRACOWNICY.ID_ZESP = ZESPOLY.ID_ZESP 
ORDER BY NAZWISKO;

--Ogranicz wynik poprzedniego zapytania do tych pracowników, którzy pracują w zespołach 
--zlokalizowanych przy ul. Piotrowo 3a.
select p.nazwisko, p.etat, p.id_zesp, z.nazwa
from pracownicy p inner join zespoly z on p.id_zesp = z.id_zesp
where z.adres = 'PIOTROWO 3A'
order by p.nazwisko;

--Znajdź nazwiska, etaty i pensje podstawowe pracowników. Wyświetl również minimalne i 
--maksymalne pensje dla etatów, na których pracują pracownicy (użyj tabeli Etaty). Wynik 
--posortuj wg nazw etatów i nazwisk pracowników.
select p.nazwisko, p.etat, p.placa_pod, e.placa_min, e.placa_max
from pracownicy p inner join etaty e on p.etat = e.nazwa
order by p.nazwisko, p.etat; 

--Zmień poprzednie zapytanie w taki sposób, aby w zbiorze wynikowym pojawiła się kolumna 
--czy_pensja_ok. Ma w niej pojawić wartość „OK” jeśli płaca podstawowa pracownika zawiera 
--się w przedziale wyznaczonym przez płace: minimalną i maksymalną dla etatu, na którym 
--pracownik pracuje lub wartość „NIE” w przeciwnym wypadku.
select p.nazwisko, p.etat, p.placa_pod, e.placa_min, e.placa_max ,
case when e.placa_min <= p.placa_pod and p.placa_pod <= e.placa_max then 'OK' else 'NIE' end as czy_pensja_ok
from pracownicy p inner join etaty e on p.etat = e.nazwa
order by p.nazwisko, p.etat;

--Wykorzystaj dodaną w p. 4. kolumnę aby znaleźć pracowników, którzy zarabiają więcej lub 
--mniej niż to jest przewidziane dla etatów, na których pracują.
SELECT NAZWISKO, ETAT, PLACA_POD, PLACA_MIN, PLACA_MAX,
CASE
 WHEN PLACA_POD BETWEEN PLACA_MIN AND PLACA_MAX THEN 'OK'
 ELSE 'NIE'
 END AS CZY_PLACA_OK 
 FROM PRACOWNICY INNER JOIN ETATY ON PRACOWNICY.ETAT = ETATY.NAZWA
WHERE CASE
 WHEN PLACA_POD BETWEEN PLACA_MIN AND PLACA_MAX THEN 'OK'
 ELSE 'NIE'
 END IN ('NIE')
ORDER BY ETAT, NAZWISKO; 

--Dla każdego pracownika wyświetl jego nazwisko, płacę podstawową, etat, kategorię 
--płacową i widełki płacowe, w jakich mieści się pensja pracownika. Kategoria płacowa to 
--nazwa etatu (z tabeli Etaty), do którego pasuje płaca podstawowa pracownika (zawiera się w 
--przedziale płac dla etatu). Wynik posortuj wg nazwisk i kategorii płacowych pracowników.
SELECT NAZWISKO, PLACA_POD, PRACOWNICY.ETAT, 
CASE
 WHEN PLACA_POD BETWEEN PLACA_MIN AND PLACA_MAX THEN ETATY.NAZWA
 END AS KAT_PLAC,
CASE
 WHEN PLACA_POD BETWEEN PLACA_MIN AND PLACA_MAX THEN PLACA_MIN
 END AS PLACA_MIN,
CASE
 WHEN PLACA_POD BETWEEN PLACA_MIN AND PLACA_MAX THEN PLACA_MAX
 END AS PLACA_MAX
 FROM PRACOWNICY, ETATY
WHERE CASE
 WHEN PLACA_POD BETWEEN PLACA_MIN AND PLACA_MAX THEN ETATY.NAZWA
 END LIKE '%'
ORDER BY NAZWISKO, KAT_PLAC;
 
--Powyższy zbiór ogranicz do tych pracowników, których rzeczywiste zarobki odpowiadają 
--widełkom płacowym przewidzianym dla sekretarek. Wynik posortuj wg nazwisk 
--pracowników.
SELECT NAZWISKO, PLACA_POD, PRACOWNICY.ETAT, 
CASE
 WHEN PLACA_POD BETWEEN PLACA_MIN AND PLACA_MAX THEN ETATY.NAZWA
 END AS KAT_PLAC,
CASE
 WHEN PLACA_POD BETWEEN PLACA_MIN AND PLACA_MAX THEN PLACA_MIN
 END AS PLACA_MIN,
CASE
 WHEN PLACA_POD BETWEEN PLACA_MIN AND PLACA_MAX THEN PLACA_MAX
 END AS PLACA_MAX
 FROM PRACOWNICY, ETATY
WHERE CASE
 WHEN PLACA_POD BETWEEN PLACA_MIN AND PLACA_MAX THEN ETATY.NAZWA
 END IN ('%', 'SEKRETARKA')
ORDER BY NAZWISKO, KAT_PLAC; 

--Wyświetl nazwiska i numery pracowników wraz z numerami i nazwiskami ich szefów. Wynik 
--posortuj wg nazwisk pracowników. W zbiorze wynikowym mają się pojawić tylko ci 
--pracownicy, którzy mają szefów.
SELECT P.NAZWISKO AS PRACOWNIK, P.ID_PRAC, S.NAZWISKO AS SZEF, 
P.ID_SZEFA 
FROM PRACOWNICY P INNER JOIN PRACOWNICY S ON P.ID_SZEFA = S.ID_PRAC 
ORDER BY PRACOWNIK; 

--Wyświetl nazwiska i daty zatrudnienia pracowników, którzy zostali zatrudnieni nie później niż 
--10 lat po swoich przełożonych. Wynik uporządkuj wg dat zatrudnienia i nazwisk 
--pracowników.
SELECT P.NAZWISKO AS PRACOWNIK, P.ZATRUDNIONY AS PRAC_ZATRUDNIONY, 
S.NAZWISKO AS SZEF, S.ZATRUDNIONY, P.ID_SZEFA, EXTRACT(YEAR FROM
P.ZATRUDNIONY) - EXTRACT(YEAR FROM S.ZATRUDNIONY) AS LATA
FROM PRACOWNICY P INNER JOIN PRACOWNICY S ON P.ID_SZEFA = S.ID_PRAC 
WHERE EXTRACT(YEAR FROM P.ZATRUDNIONY) - EXTRACT(YEAR FROM
S.ZATRUDNIONY) < 10
ORDER BY PRAC_ZATRUDNIONY, PRACOWNIK; 

--Dla każdego zespołu, który zatrudnia pracowników, wyświetl liczbę zatrudnionych w nim 
--pracowników i ich średnią płacę podstawową. Wynik posortuj wg nazw zespołów.
SELECT NAZWA, COUNT(ID_PRAC) AS LICZBA, AVG(PLACA_POD) AS
SREDNIA_PLACA 
FROM PRACOWNICY P INNER JOIN ZESPOLY S ON P.ID_ZESP = S.ID_ZESP 
GROUP BY S.NAZWA
ORDER BY NAZWA;

--Poetykietuj zespoły w zależności od liczby zatrudnionych pracowników. Jeśli zespół 
--zatrudnia do dwóch pracowników, przydziel mu etykietę “mały”. Zespołom zatrudniającym od 
--3 do 6 pracowników, przydziel etykietę “średni”. Jeśli departament zatrudnia 7 i więcej 
--pracowników, powinien otrzymać etykietę “duży”. Pomiń departamenty bez pracowników.
SELECT NAZWA, 
CASE
 WHEN COUNT(ID_PRAC) <= 2 THEN 'mały'
 WHEN COUNT(ID_PRAC) BETWEEN 3 AND 6 THEN 'średni'
 WHEN COUNT(ID_PRAC) >= 7 THEN 'duży'
END AS ETYKIETA
FROM PRACOWNICY P INNER JOIN ZESPOLY S ON P.ID_ZESP = S.ID_ZESP 
GROUP BY S.NAZWA
ORDER BY NAZWA;

-- More complex tasks --

INSERT INTO pracownicy(id_prac, nazwisko) 
VALUES ((SELECT max(id_prac) + 1 FROM pracownicy), 'WOLNY');

--Następnie skonstruuj zapytanie, które wyświetli nazwiska, numery zespołów i nazwy zespołów 
--wszystkich pracowników. W zbiorze wynikowym mają pojawić się również pracownicy, którzy nie 
--należą do żadnego zespołu. Wynik uporządkuj wg nazwisk pracowników. 
select p.nazwisko, p.id_zesp, z.nazwa
from pracownicy p left outer join zespoly z on p.id_zesp = z.id_zesp
order by p.nazwisko;

--Tym razem wyświetl nazwy wszystkich zespołów. Jeśli w zespole pracują pracownicy, wyświetl ich 
--nazwiska. Dla zespołów, które nie mają pracowników, wyświetl tekst „brak pracowników”. 
--Uporządkuj wynik według nazw zespołów i nazwisk pracowników. 
select z.id_zesp, z.nazwa,
NVL(p.nazwisko, 'brak pracownikow') as Pracownik
from PRACOWNICY p right OUTER JOIN ZESPOLY z on p.ID_ZESP = z.ID_ZESP
ORDER BY z.NAZWA;

--Połącz wyniki dwóch poprzednich zapytań w jeden wynik. Dla pracowników pracujących w 
--zespołach wyświetl nazwisko pracownika i nazwę zespołu. Dla pracowników bez zespołów wyświetl 
--w miejscu nazwy zespołu tekst „brak zespołu”. Dla zespołów, które nie mają pracowników, wyświetl 
--tekst „brak pracowników”. Uporządkuj wynik według nazw zespołów i nazwisk pracowników. 
--Nazwiska pracowników bez zespołów powinny znaleźć się na końcu raportu, posortowane 
--w porządku rosnącym. 
select nvl(z.nazwa, 'brak zespolu') as zespol,
NVL(p.nazwisko, 'brak pracownikow') as Pracownik
from PRACOWNICY p full OUTER JOIN ZESPOLY z on p.ID_ZESP = z.ID_ZESP
ORDER BY z.NAZWA;

Dla każdego zespołu znajdź liczbę pracowników, których zatrudnia oraz sumę ich płac. W zbiorze 
wynikowym uwzględnij również zespoły bez pracowników. 
select z.nazwa, count(id_prac) as liczba_prac, SUM(p.placa_pod) as SUMA_PLAC
from pracownicy p right outer join zespoly z on p.id_zesp = z.id_zesp
group by z.nazwa
order by z.nazwa;

--Wyświetl nazwy zespołów, które nie zatrudniają pracowników. Wynik posortuj wg nazw zespołów. 
select z.nazwa
from pracownicy p right outer join zespoly z on p.id_zesp = z.id_zesp
where p.id_prac is NULL;

--Wyświetl nazwiska i numery pracowników wraz z numerami i nazwiskami ich szefów. Wynik 
--posortuj wg nazwisk pracowników. W zbiorze wynikowym mają się pojawić również ci pracownicy, 
--którzy nie mają szefów. 
select p.ID_PRAC,p.NAZWISKO as PRACOWNIK,s.ID_PRAC,s.NAZWISKO as SZEF
from PRACOWNICY p left outer join PRACOWNICY s ON p.ID_SZEFA=s.ID_PRAC;

--Dla każdego pracownika wyświetl liczbę jego bezpośrednich podwładnych. 
select s.NAZWISKO as SZEF, count(p.id_prac)
from PRACOWNICY p right outer join PRACOWNICY s ON p.ID_SZEFA=s.ID_PRAC
group by s.nazwisko
order by s.nazwisko;

--Wyświetl następujące informacje o każdym pracowniku: nazwisko, etat, płaca podstawowa, nazwa 
--zespołu, do którego należy oraz nazwisko szefa. Wynik uporządkuj wg nazwisk pracowników. Weź 
--pod uwagę, że pracownik może nie mieć szefa i może nie być zatrudniony w żadnym zespole. 
select p.nazwisko, p.etat, p.placa_pod, z.nazwa
from ETATY e right outer join PRACOWNICY p ON p.etat=e.nazwa
left outer join ZESPOLY z ON z.id_zesp = p.id_zesp
left outer join PRACOWNICY s ON p.id_szefa = s.id_prac;

--Wyświetl następujące informacje o każdym pracowniku: nazwisko, etat, płaca podstawowa, nazwa 
--zespołu, do którego należy oraz nazwisko szefa. Wynik uporządkuj wg nazwisk pracowników. Weź 
--pod uwagę, że pracownik może nie mieć szefa i może nie być zatrudniony w żadnym zespole. 
select p.nazwisko, z.nazwa
from PRACOWNICY p, ZESPOLY z;

--Policz, ile rekordów będzie zawierał iloczyn kartezjański trzech relacji: Etaty, Pracownicy i Zespoły
select count(*)
from PRACOWNICY p, ZESPOLY z, ETATY e;

--Wyświetl nazwy etatów, na które przyjęto pracowników zarówno w 1992 jak i 1993 roku. Wynik 
--posortuj wg nazw etatów. 
select etat
from PRACOWNICY p where extract(year from p.zatrudniony) = 1992
intersect
select etat
from PRACOWNICY p where extract(year from p.zatrudniony) = 1993;

--Wyświetl numer zespołu który nie zatrudnia żadnych pracowników. 
select z.id_zesp
from ZESPOLY z
minus
select p.id_zesp
from PRACOWNICY p;

--Zmień powyższe zapytanie w taki sposób, aby oprócz numeru poznać również nazwę zespołu bez 
--pracowników. 
select z.id_zesp, z.nazwa
from ZESPOLY z
minus
select id_zesp, z2.nazwa
from PRACOWNICY p natural join ZESPOLY z2;

--Wyświetl poniższy raport. Nie używaj wyrażenia CASE. 
select nazwisko, placa_pod, '<480'
from PRACOWNICY where placa_pod < 480
union
select nazwisko, placa_pod, '=480'
from PRACOWNICY where placa_pod = 480
union
select nazwisko, placa_pod, '>480'
from PRACOWNICY where placa_pod > 480;