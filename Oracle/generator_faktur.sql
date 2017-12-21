create or replace PROCEDURE DODAJ_FAKTURY(x IN NUMBER, y IN NUMBER) AS 
zmienna_gl number(4);
t_ilosc number(2);
t_data date;
t_klient number(5);
zmienna number(6);
iterator number(2);
dodaje number(3);
t_ile number(3);
t_cena number (7,2);
t_oferta number(5);
t_y number(3);
pom number(3);
t_suma number (7,2);
czas date;

begin
zmienna_gl := 0;

IF y = 0 THEN
  t_data := '2015-10-01';
ELSE
  t_data := sysdate;
END IF;

while zmienna_gl < x 
loop

  select sysdate into czas from dual;
  t_klient := 0;
  t_klient := FN_ID_KLIENTA();

  dodaje := round(dbms_random.value(1,10));
  t_data := t_data + dodaje;
  IF t_data > czas THEN 
    t_data := czas;
  END IF;

  insert into Faktura (ID_FAKTURY, DATA_FAKTURY, WARTOC_FAKTURY, ID_KLIENTA) 
  values
  (
    sek1.nextval,
    t_data,
    0,
    t_klient
  );

  t_ilosc := round(dbms_random.value(1,4));
  pom := sek1.currval;
  iterator := 0;

  while iterator < t_ilosc 
  loop
    iterator := iterator + 1;

    t_oferta := dbms_random.value(1,30);
    t_ile := round(dbms_random.value(1,11));

    t_cena := FN_CENA(t_oferta, t_ile);
    
    insert into POZ_FAKTURY
    values 
    (
      iterator,
      sek1.currval,
      t_ile,
      t_cena,
      t_oferta
    );
  end loop;

  t_suma := FN_SUMA_FAKTURY(sek1.currval, t_ilosc);

  update Faktura 
  set WARTOC_FAKTURY = t_suma
  where ID_FAKTURY = pom;

  zmienna_gl := zmienna_gl + 1;
end loop;
end;
/


call DODAJ_FAKTURY(70,0);


begin
    DBMS_SCHEDULER.CREATE_JOB (
            job_name => 'JOB_DODAJ_FAKTURY',
            job_type => 'PLSQL_BLOCK',
            job_action => 
            '
            begin
            DODAJ_FAKTURY(1,1);
            end;
            ',
            number_of_arguments => 0,
            start_date => systimestamp,
            repeat_interval => 'FREQ=MINUTELY;INTERVAL=5',
            end_date => NULL,
            enabled => TRUE,
            comments => 'Job tworzacy fakture co 5 minut');
end;
/ 