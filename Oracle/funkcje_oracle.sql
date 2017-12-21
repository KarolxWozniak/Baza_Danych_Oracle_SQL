create or replace FUNCTION FN_ID_KLIENTA RETURN NUMBER AS 
t_id number(3);
zmienna number(3);
BEGIN
select count (*) into zmienna from Klient;
t_id := round(dbms_random.value(1,zmienna));
  RETURN t_id;
END FN_ID_KLIENTA;
/
----------------------------------------------
create or replace FUNCTION FN_SUMA_FAKTURY  (id_fak IN NUMBER, l_poz IN NUMBER) RETURN NUMBER AS 
t_id number(3);
t_l_p number (3);
pom number(3);
koszt_zak number (7,2);
suma number (7,2);
BEGIN
t_id := id_fak;
t_l_p := l_poz;
pom := 0;
suma := 0;

for ii in 1..t_l_p
loop
pom := pom +1;
select CENA_ZAKUPU into koszt_zak from POZ_FAKTURY
where ID_FAKTURY = t_id and POZYCJA = pom;
suma := suma + koszt_zak;
end loop;
  RETURN suma;
END FN_SUMA_FAKTURY;
/
-----------------------------------------------
create or replace FUNCTION FN_CENA  (id_cz IN NUMBER, ilosc IN NUMBER) RETURN NUMBER AS 
suma number(7,2);
cena number(6,2);
t_id_cz number(3);
t_ilosc number (2);
BEGIN
t_id_cz := id_cz;
t_ilosc := ilosc;
suma := 0;

select CENA_CZESCI into cena from CZESC
where ID_CZESCI = t_id_cz;
suma := suma + (cena * t_ilosc); 

 RETURN suma;
END FN_CENA;
/