use test_pracownicy;

select nazwisko, placa from pracownicy;

select nazwisko, (placa / 30) as dniowka
from pracownicy;

select nazwisko, (placa * 12) as roczna
from pracownicy;

select min(placa) from pracownicy;

select nazwisko, stanowisko, placa
from pracownicy
where placa = (select min(placa) from pracownicy);

select nazwisko, stanowisko, placa
from pracownicy
where placa < (select avg(placa) from pracownicy);

select nazwa, (select count(*) from pracownicy where dzialy.id_dzialu = pracownicy.id_dzialu) as liczbaPracownikow
from dzialy;

-- 9
select concat(pracownicy.nazwisko, ' ', dzialy.nazwa) as nazwisko_dzial
from pracownicy, dzialy
where pracownicy.id_dzialu = dzialy.id_dzialu;

-- 10
select dzialy.nazwa as dzial,
       pracownicy.stanowisko as etat,
       count(pracownicy.stanowisko) as liczba_praownikow
from dzialy, pracownicy
where pracownicy.id_dzialu = dzialy.id_dzialu
group by nazwa, stanowisko;

-- 11
select pracownicy.nazwisko, dzialy.nazwa, stanowiska.placa_min, stanowiska.placa_max
from pracownicy, dzialy, stanowiska
where placa_min > 1500 and placa_max < 3500 and pracownicy.stanowisko = stanowiska.stanowisko and pracownicy.id_dzialu = dzialy.id_dzialu;

-- 12
select pracownicy.nazwisko, pracownicy.placa
from pracownicy
where pracownicy.placa > (select max(placa) from pracownicy where id_dzialu = 30);

-- 13

