--Dla każdego pracownika wygeneruj kod składający się z dwóch pierwszych liter jego etatu i jego numeru 
--identyfikacyjnego.
select nazwisko, substr(etat, 1, 2) || id_prac as kod 
from pracownicy;

--Dla każdego pracownika wygeneruj kod składający się z dwóch pierwszych liter jego etatu i jego numeru 
--identyfikacyjnego.
select nazwisko, translate(nazwisko, 'KLM', 'XXX') as wojna 
from pracownicy;

--Wyświetl nazwiska pracowników którzy posiadają literę „L” w pierwszej połowie swojego nazwiska. 
select nazwisko 
from pracownicy where instr(substr(nazwisko, 1, length(nazwisko) / 2), 'L', 1, 1) > 0;

--Wyświetl nazwiska i płace pracowników powiększone o 15% i zaokrąglone do liczb całkowitych. 
select nazwisko, round(placa_pod * 1.15) as podwyzka 
from pracownicy;

--Każdy pracownik odłożył 20% swoich miesięcznych zarobków na 10-letnią lokatę oprocentowaną 10% w skali roku i 
--kapitalizowaną co roku. Wyświetl informację o tym, jaki zysk będzie miał każdy pracownik po zamknięciu lokaty.  
select nazwisko, placa_pod, placa_pod * 0.2 "INWESTYCJA" , placa_pod * 0.2 * POWER(1.1,10) "KAPITAL", placa_pod * 0.2 * POWER(1.1,10) - placa_pod * 0.2 "ZYSK" 
from pracownicy;

--Policz, jaki staż miał każdy pracownik 1 stycznia 2000 roku. 
select nazwisko, to_char(zatrudniony,'YY/DD/MM') as zatrudni, extract(year 
from (date '2000-01-01' - zatrudniony) year to month) as staz_w_2000 
from pracownicy;

--Wyświetl poniższe informacje o datach przyjęcia pracowników zespołu 20. 
select nazwisko, to_char(zatrudniony,'MONTH, DD YYYY') as data_zatrudnienia 
from pracownicy 
where id_zesp = 20;

--Sprawdź, jaki mamy dziś dzień tygodnia. 
select to_char(current_date, 'DAY') as dzien from dual;

--Przyjmij, że Mielżyńskiego i Strzelecka należą do dzielnicy Stare Miasto, Piotrowo należy do dzielnicy Nowe Miasto a 
--Włodkowica należy do dzielnicy Grunwald. Wyświetl poniższy raport (skorzystaj z wyrażenia CASE). 
select nazwa, adres,
        case(nazwa)
                when 'PIOTROWO'   then 'NOWE MIASTO'
                when 'WLODKOWICA' then 'GRUNWALD'
                else 'STARE MIASTO'
        end as dzielnica from zespoly;

--Dla każdego pracownika wyświetl informację o tym, czy jego pensja jest mniejsza niż, równa lub większa niż 480 
--złotych.
select nazwisko, placa_pod,
        case
                when placa_pod < 480 then 'mniej'
                when placa_pod = 480 then 'ta sama'
                else 'więcej'
        end as placa_pod from pracownicy