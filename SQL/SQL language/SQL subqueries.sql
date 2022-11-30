--Wyświetl nazwiska i etaty pracowników pracujących w tym samym zespole co pracownik o 
--nazwisku Brzeziński. Wynik uporządkuj wg nazwisk pracowników. 
select nazwisko, etat, id_zesp
from pracownicy
where id_zesp = (
SELECT id_zesp
from pracownicy
where NAZWISKO = 'BRZEZINSKI'
)
order by nazwisko


--Zmodyfikuj treść poprzedniego zapytania w taki sposób, aby zamiast identyfikatora zespołu pojawiła 
--się jego nazwa. 
select p.nazwisko, p.etat, z.nazwa
from pracownicy p join zespoly z on p.id_zesp = z.id_zesp
where p.id_zesp = (
select id_zesp
from pracownicy
where nazwisko = 'BRZEZINSKI'
)
order by p.nazwisko;


--Wyświetl najkrócej pracujących pracowników każdego zespołu. Uszereguj wyniki zgodnie 
--z kolejnością zatrudnienia. 
select nazwisko, zatrudniony, id_zesp
from pracownicy
where zatrudniony in (
select max(zatrudniony)
from pracownicy
group by id_zesp
)
order by zatrudniony;


--Wyświetl informacje o zespołach, które nie zatrudniają pracowników. 
select * from zespoly
where id_zesp not in (
select id_zesp from pracownicy where id_zesp is not null
)


--Wyświetl nazwiska tych profesorów, którzy wśród swoich podwładnych nie mają żadnych 
--stażystów. 
select nazwisko
from pracownicy
where etat = 'PROFESOR' and id_prac not in (
select id_szefa
from pracownicy
where etat = 'STAZYSTA'
)

select nazwisko from pracownicy 
where etat = 'PROFESOR' AND  ID_PRAC NOT IN (SELECT ID_SZEFA FROM PRACOWNICY WHERE ETAT = 'STAŻYSTA');



--Wyświetl numer zespołu wypłacającego miesięcznie swoim pracownikom najwięcej pieniędzy. 
SELECT id_zesp, SUM(placa_pod) as suma_plac 
FROM pracownicy
GROUP BY id_zesp HAVING SUM(placa_pod) =
(SELECT MAX(SUM(placa_pod)) FROM pracownicy
GROUP BY id_zesp);


--Znajdź zespoły zatrudniające więcej pracowników niż zespół ADMINISTRACJA. Wynik posortuj wg 
--nazw zespołów. 
select z.nazwa, count(*) as ilu_pracownikow
from pracownicy p inner join zespoly z on p.id_zesp = z.id_zesp
group by p.id_zesp, z.nazwa
having count(*) > (
select count(*)
from pracownicy p inner join zespoly z on p.id_zesp = z.id_zesp
group by z.id_zesp, z.nazwa
having z.nazwa = 'ADMINISTRACJA'
)


--Uzupełnij wynik poprzedniego zapytania o listę nazwisk pracowników na znalezionych etatach. 
select etat, listagg(nazwisko, ',') within group (order by nazwisko) as pracownicy
from pracownicy
group by etat
having count(*) = (
select max(count(*))
from pracownicy
group by etat
);

--Wyświetl informacje o zespołach, które nie zatrudniają pracowników. Rozwiązanie powinno 
--korzystać z podzapytania skorelowanego.
select z.id_zesp, z.nazwa, z.adres 
from zespoly z 
where not exists (select nazwisko from pracownicy where id_zesp=z.id_zesp)

--Wyświetl nazwiska i pensje pracowników którzy zarabiają co najmniej 75% pensji swojego szefa.
--Wynik uporządkuj wg nazwisk.
select p.nazwisko, p.placa_pod 
from pracownicy p 
where placa_pod>0.75*(select placa_pod from pracownicy where id_prac=p.id_szefa)


--Wyświetl nazwiska tych profesorów, którzy wśród swoich podwładnych nie mają żadnych 
--stażystów. Użyj podzapytania skorelowanego.
select p.nazwisko 
from pracownicy p 
where etat='PROFESOR' and p.id_prac <> all (select id_szefa from pracownicy where etat='STAZYSTA')

--Wyświetl nazwiska i pensje trzech najlepiej zarabiających pracowników. Uporządkuj ich zgodnie z 
--wartościami pensji w porządku malejącym. Zastosuj podzapytanie skorelowane.
select p.nazwisko, placa_pod 
from pracownicy p where (select count(*) 
from pracownicy 
where placa_pod>p.placa_pod)<3


--Wyświetl dla każdego roku liczbę zatrudnionych w nim pracowników. Wynik uporządkuj zgodnie z 
--malejącą liczbą zatrudnionych.
select distinct extract(year from p.zatrudniony) as rok, count(nazwisko) as liczba 
from pracownicy p group by extract(year from p.zatrudniony)


--Zmodyfikuj powyższe zapytanie w ten sposób, aby wyświetlać tylko rok, w którym przyjęto
--najwięcej pracowników.
select distinct extract(year from p.zatrudniony) as rok, count(nazwisko) as liczba 
from pracownicy p group by extract(year from p.zatrudniony) having (select max(count(nazwisko)) 
from pracownicy 
group by extract(year from zatrudniony))=count(nazwisko)


--Ogranicz poprzedni zbiór tylko do tych pracowników, którzy zarabiają więcej niż średnia w ich 
--zespole (czyli mających dodatnią wartość różnicy między ich płacą podstawową a średnią płacą w 
--ich zespole). Modyfikacji poddaj oba rozwiązania z poprzedniego punktu.
select * from (select nazwisko, placa_pod, placa_pod - (select avg(placa_pod) 
from pracownicy where id_zesp = p.id_zesp 
having avg(placa_pod) < p.placa_pod) roznica from pracownicy p) 
where roznica is not null 
order by nazwisko



