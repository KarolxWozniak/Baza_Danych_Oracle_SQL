create or replace view ZYSK_ROK_SZCZEGOLY AS
select NAZWA_CZESCI as "Nazwa Czesci", MARKA_SAMOCHODU ||' '|| MODEL_SAMOCHODU as "Samochod", sum(LICZBA) as "Ilosc" ,sum(CENA_ZAKUPU) as "Zysk"
from CZESC cz, POZ_FAKTURY p_f, SAMOCHOD sam, FAKTURA fak
where cz.ID_CZESCI = p_f.ID_CZESCI and sam.ID_SAMOCHODU = cz.ID_SAMOCHODU and fak.ID_FAKTURY = p_f.ID_FAKTURY and 
(DATA_FAKTURY between '2016-01-01' and '2016-12-30')
group by NAZWA_CZESCI, MARKA_SAMOCHODU, MODEL_SAMOCHODU
order by NAZWA_CZESCI, MARKA_SAMOCHODU, MODEL_SAMOCHODU;

create or replace view SPRZED_ROK_SZCZEGOLY as
select IMIE ||' '|| NAZWISKO as "Klient", NAZWA_CZESCI as "Nazwa czesci", MARKA_SAMOCHODU ||' '|| MODEL_SAMOCHODU as "Samochod", LICZBA as "Ilosc",
sum(CENA_ZAKUPU) as "Cena", DATA_FAKTURY as "Data zakupu"
from POZ_FAKTURY p_f, CZESC cz, Faktura fa, SAMOCHOD sam, Klient kl
where fa.ID_FAKTURY = p_f.ID_FAKTURY and kl.ID_KLIENTA = fa.ID_KLIENTA and cz.ID_CZESCI = p_f.ID_CZESCI and sam.ID_SAMOCHODU = cz.ID_SAMOCHODU and
(DATA_FAKTURY between '2016-01-01' and '2016-12-30')
group by IMIE, NAZWISKO, NAZWA_CZESCI, MARKA_SAMOCHODU, MODEL_SAMOCHODU, LICZBA, DATA_FAKTURY
order by DATA_FAKTURY;

create or replace view SPRZED_ROK_OGOLNIE as
select distinct IMIE ||' '|| NAZWISKO as "Klient", WOJEWODZTWO as "Wojewodztwo", WARTOC_FAKTURY as "Cena", DATA_FAKTURY as "Data zakupu"
from POZ_FAKTURY p_f, CZESC cz, Faktura fa, SAMOCHOD sam, Klient kl, WOJEWODZTWO woj
where fa.ID_FAKTURY = p_f.ID_FAKTURY and kl.ID_KLIENTA = fa.ID_KLIENTA and cz.ID_CZESCI = p_f.ID_CZESCI and sam.ID_SAMOCHODU = cz.ID_SAMOCHODU and
woj.ID_WOJEWODZTWA = kl.ID_WOJEWODZTWA and
(DATA_FAKTURY between '2016-01-01' and '2016-12-30')
order by DATA_FAKTURY;

create or replace view TOP_FAKTURY as
select * from
(
  select distinct IMIE ||' '|| NAZWISKO as "Klient", WOJEWODZTWO as "Wojewodztwo", WARTOC_FAKTURY as "Cena", DATA_FAKTURY as "Data zakupu"
  from POZ_FAKTURY p_f, CZESC cz, Faktura fa, SAMOCHOD sam, Klient kl, WOJEWODZTWO woj
  where fa.ID_FAKTURY = p_f.ID_FAKTURY and kl.ID_KLIENTA = fa.ID_KLIENTA and cz.ID_CZESCI = p_f.ID_CZESCI and sam.ID_SAMOCHODU = cz.ID_SAMOCHODU and
  woj.ID_WOJEWODZTWA = kl.ID_WOJEWODZTWA and
  (DATA_FAKTURY between '2016-01-01' and '2016-12-30')
  order by WARTOC_FAKTURY desc
)
where rownum <= 3;

create or replace view WYKAZ_FAKTUR as
select distinct fa.ID_FAKTURY as "Numer faktury", DATA_FAKTURY as "Data faktury", round(WARTOC_FAKTURY / 1.23,2) as "Wartosc NETTO", WARTOC_FAKTURY as
"Wartosc BRUTTO", IMIE ||' '|| NAZWISKO as "Klient" 
from Faktura fa, Klient kl, POZ_FAKTURY p_f
where fa.ID_FAKTURY = p_f.ID_FAKTURY and kl.ID_KLIENTA = fa.ID_KLIENTA
order by fa.ID_FAKTURY;


create or replace view WYKAZ_CZESCI as
select  NAZWA_CZESCI as "Nazwa Czesci", MARKA_SAMOCHODU ||' '|| MODEL_SAMOCHODU as "Samochod", round(CENA_CZESCI/1.23,2) as "Cena NETTO", CENA_CZESCI as
"Cena BRUTTO" 
from CZESC cz,SAMOCHOD sam
where sam.ID_SAMOCHODU = cz.ID_SAMOCHODU
order by NAZWA_CZESCI, MARKA_SAMOCHODU;


create or replace view WYKAZ_KLIENTOW as
select IMIE ||' '|| NAZWISKO as "Klient", TELEFON as "Telefon", WOJEWODZTWO as "Wojewodztwo" 
from Klient kl, WOJEWODZTWO woj
where kl.ID_WOJEWODZTWA = woj.ID_WOJEWODZTWA
order by kl.ID_KLIENTA;
