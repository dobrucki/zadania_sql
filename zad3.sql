use test1_dobrucki;

create table osoby
(
    nr_osoby int not null identity (1, 1),
    imie     varchar(40),
    nazwisko varchar(40),
    adres    varchar(500),
    wiek     int,
    PRIMARY KEY (nr_osoby)
);

select count(*)
from osoby;

insert into osoby (imie, nazwisko, adres, wiek)
values ('Baba', 'Jaga', 'Domek z Piernika 100', 154);

select *
from osoby;

select count(*)
from osoby;

create table dzieci
(
    nr_dziecka int not null identity (100, 1),
    nr_osoby   int,
    imie       varchar(40),
    primary key (nr_dziecka),
    foreign key (nr_osoby) references osoby (nr_osoby)
);

insert into dzieci (nr_osoby, imie)
values ((select nr_osoby from osoby where imie = 'Baba' and nazwisko = 'Jaga'), 'Jaś');

insert into dzieci (nr_osoby, imie)
values ((select nr_osoby from osoby where imie = 'Baba' and nazwisko = 'Jaga'), 'Małgosia');

alter table osoby
    add data_wpisu datetime not null default (getdate());

insert into osoby (imie, nazwisko, adres, wiek)
values ('Matka', 'Chrzestna', 'Wróżkolandia', 105);

set identity_insert dzieci ON;

insert into dzieci (nr_dziecka, nr_osoby, imie)
values (10, (select nr_osoby from osoby where imie = 'Matka' and nazwisko = 'Chrzestna'), 'Kopciuszek');

set identity_insert dzieci OFF;

alter table osoby
    with nocheck add constraint wiekc check (wiek <= 100);

insert into osoby(imie, nazwisko, adres, wiek)
values ('Mirek', 'Kudra', 'Zelów 13', 99);

set identity_insert dzieci ON;



