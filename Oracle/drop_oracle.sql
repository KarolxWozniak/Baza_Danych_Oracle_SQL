
drop TABLE POZ_FAKTURY CASCADE CONSTRAINTS;
drop TABLE Faktura CASCADE CONSTRAINTS;
drop TABLE CZESC CASCADE CONSTRAINTS;
drop TABLE Klient CASCADE CONSTRAINTS;
drop TABLE SAMOCHOD CASCADE CONSTRAINTS;
drop TABLE WOJEWODZTWO CASCADE CONSTRAINTS;

drop sequence sek1;
drop sequence seq_ID_WOJ;
drop sequence seq_ID_SAMOCHOD;
drop sequence seq_ID_CZESC;
drop sequence seq_ID_Klient;

drop function FN_ID_KLIENTA;
drop function FN_SUMA_FAKTURY;
drop function FN_CENA;

drop procedure DODAJ_FAKTURY;

drop view ZYSK_ROK_SZCZEGOLY;
drop view SPRZED_ROK_SZCZEGOLY;
drop view SPRZED_ROK_OGOLNIE;
drop view TOP_FAKTURY;
drop view WYKAZ_FAKTUR;
drop view WYKAZ_CZESCI;
drop view WYKAZ_KLIENTOW;

begin
dbms_scheduler.drop_job (job_name => 'JOB_DODAJ_FAKTURY');
end;