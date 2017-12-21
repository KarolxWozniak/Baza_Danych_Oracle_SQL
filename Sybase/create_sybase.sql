CREATE TABLE WOJEWODZTWO
  (
    ID_WOJEWODZTWA numeric (5) NOT NULL ,
    WOJEWODZTWO    varchar (50) NOT NULL,
        Primary key (ID_WOJEWODZTWA)
  ) ;

CREATE TABLE SAMOCHOD
  (
    ID_SAMOCHODU numeric (5) NOT NULL ,
    MARKA_SAMOCHODU        varchar (25) NOT NULL,
    MODEL_SAMOCHODU     varchar (25) NOT NULL,
        Primary Key (ID_SAMOCHODU)
  ) ;

CREATE TABLE CZESC
  (
    ID_CZESCI    numeric (5) NOT NULL ,
    NAZWA_CZESCI varchar (50) NOT NULL ,
    CENA_CZESCI  numeric (10,2) NOT NULL ,
    ID_SAMOCHODU numeric (5) NOT NULL,
        Primary key (ID_CZESCI),
        Foreign key ID_SAMOCHODU references SAMOCHOD (ID_SAMOCHODU)
  ) ;

CREATE TABLE Klient
  (
    ID_KLIENTA     numeric (5) NOT NULL ,
    IMIE           varchar (50) NOT NULL ,
    NAZWISKO       varchar (50) NOT NULL ,
    TELEFON        numeric (12) NOT NULL ,
    ID_WOJEWODZTWA numeric (5) NOT NULL,
        Primary key (ID_KLIENTA),
        Foreign key ID_WOJEWODZTWA references WOJEWODZTWO (ID_WOJEWODZTWA)
  ) ;

CREATE TABLE Faktura
  (
    ID_FAKTURY     numeric (5) NOT NULL ,
    DATA_FAKTURY   DATE NOT NULL ,
    WARTOC_FAKTURY numeric (10,2) NOT NULL ,
    ID_KLIENTA     numeric (5) NOT NULL,
        Primary key (ID_FAKTURY),
        Foreign key ID_KLIENTA references Klient (ID_KLIENTA)
  ) ;

CREATE TABLE POZ_FAKTURY
  (
    POZYCJA     numeric (5) NOT NULL ,
    ID_FAKTURY  numeric (5) NOT NULL ,
    LICZBA      numeric (5) NOT NULL ,
    CENA_ZAKUPU numeric (10,2) NOT NULL ,
    ID_CZESCI   numeric (5) NOT NULL,
        Primary key (POZYCJA, ID_FAKTURY),
        Foreign key ID_FAKTURY references Faktura (ID_FAKTURY),
        Foreign key ID_CZESCI references CZESC (ID_CZESCI)
  ) ;

create sequence seq_ID_WOJ start with 1 increment by 1;
create sequence seq_ID_SAMOCHOD start with 1 increment by 1;
create sequence seq_ID_CZESC start with 1 increment by 1;
create sequence seq_ID_Klient1 start with 1 increment by 1;
create sequence seq_ID_Faktura1 start with 1 increment by 1;
create sequence seq_ID_POZ_FAK start with 1 increment by 1;