use biblioteka;


create table wydawnictwa (
    id int not null primary key identity(1, 1),
    nazwa varchar(50),
    miasto varchar(50),
    telefon varchar(15)
);

create table ksiazki (
    sygn varchar(5) not null primary key,
    id_wyd int foreign key references wydawnictwa(id),
    tytul varchar(40) not null,
    cena smallmoney not null,
    constraint cena_check check (cena > 0),
    strony int not null,
    constraint strony_check check (strony > 0),
    gatunek varchar(40),
    constraint gatunek_check
        check (gatunek in ('powieść', 'powieść historyczna', 'dla dzieci', 'kryminał',
                                    'powieść science fiction', 'książka naukowa'))
);

create table pracownicy (
    id int not null primary key identity(1, 1),
    nazwisko varchar(40) not null,
    imie varchar(40) not null,
    data_ur smalldatetime not null,
    data_zatr smalldatetime not null,
    constraint data_zatr_check check (data_ur < data_zatr)
);

create table czytelnicy (
    id char(5) not null primary key,
    constraint id_check check (id like '[A-Z][A-Z][0-9][0-9][0-9]'),
    nazwisko varchar(15) not null,
    imie varchar(15) not null,
    pesel varchar(11) not null,
    constraint pesel_check check (pesel like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
    data_ur smalldatetime not null,
    plec varchar(1) not null,
    constraint plec_check check (plec like '[KM]'),
    telefon varchar(15)
);

create table wypozyczenia (
    id_w int not null primary key identity(1, 1),
    sygn varchar(5) foreign key references ksiazki(sygn),
    id_cz char(5) foreign key references czytelnicy(id),
    id_p int foreign key references pracownicy(id),
    data_w datetime not null,
    data_z datetime,
    constraint data_check check (data_w < data_z),
    kara smallmoney default 0,
    constraint kara_check check (kara >= 0)
);

alter table pracownicy
add plec char(1),
constraint plec_check_p check (plec like '[KM]');

alter table czytelnicy
add unique (pesel);

alter table wypozyczenia
add unique (sygn, data_w);

select concat(czytelnicy.nazwisko, ' ', czytelnicy.imie) as dane,
       ksiazki.tytul,
       wypozyczenia.data_w,
       wypozyczenia.data_z
into wypoz_lato
from wypozyczenia, czytelnicy, ksiazki
where wypozyczenia.id_cz = czytelnicy.id
      and wypozyczenia.sygn = ksiazki.sygn
      and datepart(month, wypozyczenia.data_w) in (6, 7, 8)
order by data_w;