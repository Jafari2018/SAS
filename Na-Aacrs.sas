*Setting the directory;
libname DT "C:\Users\behnaz.jafari1\Desktop\Dementia\Merging data\Data"; 
libname X XLSX "C:\Users\behnaz.jafari1\Desktop\Dementia\Merging data\Drug_ID.xlsx";
****************************************************************************************************************;
****************************************************************************************************************;
***************************************************************************************************************;
****************************************************************************************************************;
/*NACRS and AACRS;/*NACRS and AACRS;/*NACRS and AACRS;/*NACRS and AACRS;/*NACRS and AACRS;/*NACRS and AACRS;

/*NACRS;
/*Data cleaning
*changing dates format and adding D_name column*/
/*data DT.nacrs1018;
     set DT.nacrs1018;
	 rename GENDER=SEX;
	 label GENDER="SEX";
	 D_name="NACRS";
	 Date = put(BIRTHDATE,8.);
	 Date_VISDATE= put(VISIT_DATE,8.);
	 Date_DISDATE= put(DISP_DATE,8.);
	 DOB_new = input(strip(Date),YYMMDD8.);
	 VIS_new = input(strip(Date_VISDATE),YYMMDD8.);
	 DIS_new = input(strip(Date_DISDATE),YYMMDD8.);
	 char_PROVIDER_SVC1 = input(PROVIDER_SVC1, $5.);
	 char_PROVIDER_SVC2 = input(PROVIDER_SVC2, $5.);
	 char_PROVIDER_SVC3 = input(PROVIDER_SVC3, $5.);
	 char_PROVIDER_SVC4 = input(PROVIDER_SVC4, $5.);
	 char_PROVIDER_SVC5 = input(PROVIDER_SVC5, $5.);
	 char_PROVIDER_SVC6 = input(PROVIDER_SVC6, $5.);
	 char_PROVIDER_SVC7 = input(PROVIDER_SVC7, $5.);
	 char_PROVIDER_SVC8 = input(PROVIDER_SVC8, $5.);
	 format PROVIDER_SVC1 $5. PROVIDER_SVC2 $5. PROVIDER_SVC3 $5. PROVIDER_SVC4 $5. PROVIDER_SVC5 $5. PROVIDER_SVC6 $5. PROVIDER_SVC7 $5. PROVIDER_SVC8 $5.;
	 informat char_PROVIDER_SVC1 $5. char_PROVIDER_SVC2 $5. char_PROVIDER_SVC3 $5. char_PROVIDER_SVC4 $5. char_PROVIDER_SVC5 $5. char_PROVIDER_SVC6 $5. char_PROVIDER_SVC7 $5. char_PROVIDER_SVC8 $5.;
	 label PROVIDER_SVC1="PROVIDER_SVC1" PROVIDER_SVC2="PROVIDER_SVC2" PROVIDER_SVC3="PROVIDER_SVC3" PROVIDER_SVC4="PROVIDER_SVC4" PROVIDER_SVC5="PROVIDER_SVC5" PROVIDER_SVC6="PROVIDER_SVC6" PROVIDER_SVC7="PROVIDER_SVC7" PROVIDER_SVC8="PROVIDER_SVC8";
	 drop PROVIDER_SVC1 PROVIDER_SVC2 PROVIDER_SVC3 PROVIDER_SVC4 PROVIDER_SVC5 PROVIDER_SVC6 PROVIDER_SVC7 PROVIDER_SVC8;
	 rename char_PROVIDER_SVC1= PROVIDER_SVC1  char_PROVIDER_SVC2= PROVIDER_SVC2 char_PROVIDER_SVC3= PROVIDER_SVC3 char_PROVIDER_SVC4= PROVIDER_SVC4 char_PROVIDER_SVC5= PROVIDER_SVC5 char_PROVIDER_SVC6= PROVIDER_SVC6 char_PROVIDER_SVC7= PROVIDER_SVC7 char_PROVIDER_SVC8= PROVIDER_SVC8;
	 format DOB_new YYMMDDD10. VIS_new YYMMDDD10. DIS_new YYMMDDD10.;
	 label DOB_new="DOB";
	 label VIS_new="VIST_DATE";
	 label DIS_new="DISP_DATE";
	drop BIRTHDATE;
	drop Date;
	drop Date_VISDATE;
	drop Date_DISDATE;
	drop VISIT_DATE;
	drop DISP_DATE;
	rename DOB_new= DOB VIS_new= VISIT_DATE DIS_new= DISP_DATE;
run;*/

/*data DT.clnd_nacrs1018;
set DT.nacrs1018;
If DISP_DATE="" then DISP_DATE=VISIT_DATE;
run;

*Cleaning DOB- Age 50 or older as of April 1, 2013 (April 1, 2013 is cohort entry date);
Data DT.clnd_nacrs1018;
 length AGE_CAT $12;
   set DT.clnd_nacrs1018;
   format AGE_CAT $12.;
   informat AGE_CAT $12.;
  where (DOB<='31MAR1963'D & strip(PHN_ENC)~= "000000000000");  
	 If ('31MAR1958'D < DOB <= '31MAR1963'D) then AGE_CAT="50-55";
	 If ('31MAR1953'D < DOB <='31MAR1958'D) then AGE_CAT="56-60";
	 If ('31MAR1948'D < DOB <='31MAR1953'D) then AGE_CAT="61-65";
	 If ('31MAR1943'D < DOB <='31MAR1948'D) then AGE_CAT="66-70";
	 If ('31MAR1938'D < DOB <='31MAR1943'D) then AGE_CAT="71-75";
	 If ('31MAR1933'D < DOB <='31MAR1938'D) then AGE_CAT="76-80";
	 If ('31MAR1928'D < DOB <='31MAR1933'D) then AGE_CAT="81-85";
	 If (DOB <= '31MAR1928'D) then AGE_CAT="86 and older";
  run;*/

/*Data DT.drpd_nacrs1018;
set DT.clnd_nacrs1018;
 keep POSTCODE SEX VISIT_DATE DISP_DATE PHN_ENC D_name DOB PROVIDER_SVC1 PROVIDER_SVC2 PROVIDER_SVC3 PROVIDER_SVC4 PROVIDER_SVC5 PROVIDER_SVC6 PROVIDER_SVC7 PROVIDER_SVC8 DXCODE: AGE_CAT;
run;*/

/*AACRS;
/*Data cleaning
*Changing dates format and adding D_name column*/

/*data DT.aacrs0810;
     set DT.aacrs0810;
	 D_name="AACRS";
	 Date = put(BIRTHDATE,8.);
	 Date_VISDATE= put(VISDATE,8.);
	 Date_DISDATE= put(DISDATE,8.);
	 DOB_new = input(strip(Date),YYMMDD8.);
	 VIS_new = input(strip(Date_VISDATE),YYMMDD8.);
	 DIS_new = input(strip(Date_DISDATE),YYMMDD8.);
	 format DOB_new YYMMDDD10. VIS_new YYMMDDD10. DIS_new YYMMDDD10.;
	 label DOB_new="DOB";
	 label VIS_new="VISDATE";
	 label DIS_new="DISDATE";
	drop BIRTHDATE;
	drop Date;
	drop Date_VISDATE;
	drop Date_DISDATE;
	drop DOB;
	drop VISDATE;
	drop DISDATE;
	rename DOB_new= DOB VIS_new= VISDATE DIS_new= DISDATE;
run;

*Cleaning DOB- Age 50 or older as of April 1, 2013 (April 1, 2013 is cohort entry date);
data DT.aacrs0810;
set DT.aacrs0810;
If DISDATE="" then DISDATE=VISDATE;
run;
Data DT.clnd_aacrs0810;
 length AGE_CAT $12;
   set DT.aacrs0810;
   format AGE_CAT $12.;
   informat AGE_CAT $12.;
  where (DOB<='31MAR1963'D & strip(PHN_ENC)~= "000000000000");
	 If ('31MAR1958'D < DOB <='31MAR1963'D) then AGE_CAT="50-55";
	 If ('31MAR1953'D < DOB <='31MAR1958'D) then AGE_CAT="56-60";
	 If ('31MAR1948'D < DOB <='31MAR1953'D) then AGE_CAT="66-70";
	 If ('31MAR1943'D < DOB <='31MAR1948'D) then AGE_CAT="70-75";
	 If ('31MAR1938'D < DOB <='31MAR1943'D) then AGE_CAT="76-80";
	 If ('31MAR1933'D < DOB <='31MAR1938'D) then AGE_CAT="80-85";
	 If (DOB <= '31MAR1933'D) then AGE_CAT="86 and older";
  run;
/* droping no needed variable and adding new variables */
/*data DT.drpd_aacrs0810;
set DT.clnd_aacrs0810;
PROVIDER_SVC1="99999";
PROVIDER_SVC2="99999";
PROVIDER_SVC3="99999";
PROVIDER_SVC4="99999";
PROVIDER_SVC5="99999";
PROVIDER_SVC6="99999";
PROVIDER_SVC7="99999";
PROVIDER_SVC8="99999";
run;*/

/*Data DT.drpd_aacrs0810;
set DT.drpd_aacrs0810;
label  DISDATE="DISP_DATE" VISDATE="VISIT_DATE";
rename DISDATE=DISP_DATE VISDATE=VISIT_DATE;
run;

data DT.drpd_aacrs0810;
set DT.drpd_aacrs0810;
keep POSTCODE SEX VISIT_DATE DISP_DATE PHN_ENC D_name DOB PROVIDER_SVC1 PROVIDER_SVC2 PROVIDER_SVC3 PROVIDER_SVC4 PROVIDER_SVC5 PROVIDER_SVC6 PROVIDER_SVC7 PROVIDER_SVC8 DXCODE: AGE_CAT;
run;*/

/*Concatenating AACRS and NACRS*/
/*data DT.ac_nacrs0818;
set DT.drpd_aacrs0810 DT.drpd_nacrs1018 ;
run;*/



/*Creating 5 years look_back*/
/*PROC SQL;
	create table DT.ac_nacrs_5yrLB as
	select *
	from DT.ac_nacrs0818 as s1
	where '01APR2008'D <= VISIT_DATE <= '31MAR2013'D;

QUIT;

/*Delete records that have death records in vs_death_5yrLB*/
/*PROC SQL;
delete from DT.ac_nacrs_5yrLB
where PHN_ENC in (SELECT PHN_ENC from DT.vs_death_5yrLB);
quit;

/* Exclusion criteria for Palliative care: PROVIDER_SVC [1-8] = 00121*/
/*Data DT.ac_nacrs_palliative;
set DT.ac_nacrs_5yrLB;
where (strip(PROVIDER_SVC1)= "00121"|strip(PROVIDER_SVC2)= "00121"|strip(PROVIDER_SVC3)= "00121"| 
strip(PROVIDER_SVC4)= "00121" | strip(PROVIDER_SVC5)= "00121"| strip(PROVIDER_SVC6)= "00121"|
strip(PROVIDER_SVC7)= "00121"| strip(PROVIDER_SVC8)= "00121");
run;

PROC SORT DATA=DT.ac_nacrs_palliative
 OUT=DT.ac_nacrs_palliative
 NODUPKEY ;
 BY PHN_ENC;
RUN ;

PROC SQL;
delete from DT.ac_nacrs_5yrLB
where PHN_ENC in (SELECT PHN_ENC from DT.palliative);
quit;


PROC SQL;
delete from DT.ac_nacrs_5yrLB
where PHN_ENC in (SELECT PHN_ENC from DT.Seizure);
quit;


/*Creating 5 years look_forward*/
/*PROC SQL;
	create table DT.ac_nacrs_5yrLF as
	select *
	from DT.ac_nacrs0818 as s1
	where '01APR2013'D <= VISIT_DATE <= '31MAR2018'D;
QUIT;

/*Delete records that have death records in vs_death_5yrLB*/
/*PROC SQL;
delete from DT.ac_nacrs_5yrLF
where PHN_ENC in (SELECT PHN_ENC from DT.vs_death_5yrLB);
quit;

PROC SQL;
delete from DT.ac_nacrs_5yrLF
where PHN_ENC in (SELECT PHN_ENC from DT.ac_nacrs_palliative);
quit;

***************************************************************************************************************;
****************************************************************************************************************;
/*NACRS and AACRS;/*NACRS and AACRS;/*NACRS and AACRS;/*NACRS and AACRS;/*NACRS and AACRS;/*NACRS and AACRS;

/*Frailty status at the time of cohort entry - b.2 At least 2 visits in the past year in Nacrs/ Accrs*/

proc sort data=DT.ac_nacrs_5yrLB; 
by PHN_ENC; 
run;

proc sort 
data=DT.Dad_5yrLB; 
by PHN_ENC; 
run;

PROC SQL;
	create table DT.ED_acnars as
	select *
	from DT.ac_nacrs_5yrLB as s1
	where '01APR2012'D <= VISIT_DATE <= '31MAR2013'D;
QUIT;

PROC SORT data=DT.ED_acnars;
  BY PHN_ENC DESCENDING VISIT_DATE;
RUN;

proc sql;
create table DT.ED_acnars as
select *,count(PHN_ENC) as ED_acnars
from DT.ED_acnars
group by PHN_ENC;
quit;

PROC SORT DATA=DT.ED_acnars
 OUT=DT.ED_acnars
 NODUPKEY ;
 BY PHN_ENC;
RUN ;

data DT.ED_acnars;
  set DT.ED_acnars;
  where ED_acnars>=2;
run;

data DT.ED_acnars;
set DT.ED_acnars;
Frailty_b2=1;
run;

PROC SORT DATA=DT.ED_acnars
 OUT=DT.ED_acnars
 NODUPKEY ;
 BY PHN_ENC;
RUN ;
Data DT.ac_nacrs_5yrLB;
set DT.ac_nacrs_5yrLB;
Frailty_b2=0;
run;


DATA DT.ac_nacrs_5yrLB;
  SET DT.ac_nacrs_5yrLB;
  IF _N_ = 1 THEN DO;
  DECLARE HASH T(dataset: 'DT.ED_acnars');
    T.definekey('PHN_ENC');
    T.definedata('Frailty_b2');
    T.definedone();
  END;
  IF T.find() >= 0;
RUN;



/*Atrial Fibrillation: NACRS (DXCODE1-10): I47, I48  */
Data DT.ac_nacrs_5yrLB;
set DT.ac_nacrs_5yrLB;
if(strip(DXCODE1)in:('I47','I48')|strip(DXCODE2)in:('I47','I48')|strip(DXCODE3)in:('I47','I48')
|strip(DXCODE4)in:('I47','I48')|strip(DXCODE5)in:('I47','I48')|strip(DXCODE6)in:('I47','I48')
|strip(DXCODE7)in:('I47','I48')|strip(DXCODE8)in:('I47','I48')|strip(DXCODE9)in:('I47','I48')
|strip(DXCODE10)in:('I47','I48')) 
then Atrial_Fib=1; else Atrial_Fib=0;
run;

PROC SQL;
CREATE Table DT.ac_nacrs_5yrLB as   
(SELECT *, max(Atrial_Fib) as max
from DT.ac_nacrs_5yrLB
group by PHN_ENC);
quit; 

Data DT.ac_nacrs_5yrLB(drop=max);
set DT.ac_nacrs_5yrLB;
Atrial_Fib=max;
run;


/*Fall- related injury
Using emergency visit (NACRS) with DXCODE1-10 or hospitalization (DAD) with DXCODE1-25 
o	W01,W10, W11, W12, W13, W06-W08, W09.01-W09.05, W09.08, W09.09, W14-W17, W00, W02.00-W02.05, W02.08, W03, W04, 
W05.00-W05.04, W05.08, W05.09, W18, W19*/

Data DT.ac_nacrs_5yrLB;
set DT.ac_nacrs_5yrLB;
if (strip(DXCODE1)in:("W0901","W0902","W0903","W0904","W0905","W0908","W0909","W0200","W0201","W0202","W0203","W0204","W0205","W0208","W0500","W0501","W0502","W0503","W0504","W0508","W0509")|
strip(DXCODE2)in: ("W0901","W0902","W0903","W0904","W0905","W0908","W0909","W0200","W0201","W0202","W0203","W0204","W0205","W0208","W0500","W0501","W0502","W0503","W0504","W0508","W0509")|
strip(DXCODE3) in:("W0901","W0902","W0903","W0904","W0905","W0908","W0909","W0200","W0201","W0202","W0203","W0204","W0205","W0208","W0500","W0501","W0502","W0503","W0504","W0508","W0509")|
strip(DXCODE4) in:("W0901","W0902","W0903","W0904","W0905","W0908","W0909","W0200","W0201","W0202","W0203","W0204","W0205","W0208","W0500","W0501","W0502","W0503","W0504","W0508","W0509")|
strip(DXCODE5) in:("W0901","W0902","W0903","W0904","W0905","W0908","W0909","W0200","W0201","W0202","W0203","W0204","W0205","W0208","W0500","W0501","W0502","W0503","W0504","W0508","W0509")|
strip(DXCODE6) in:("W0901","W0902","W0903","W0904","W0905","W0908","W0909","W0200","W0201","W0202","W0203","W0204","W0205","W0208","W0500","W0501","W0502","W0503","W0504","W0508","W0509")|
strip(DXCODE7) in:("W0901","W0902","W0903","W0904","W0905","W0908","W0909","W0200","W0201","W0202","W0203","W0204","W0205","W0208","W0500","W0501","W0502","W0503","W0504","W0508","W0509")|
strip(DXCODE8) in:("W0901","W0902","W0903","W0904","W0905","W0908","W0909","W0200","W0201","W0202","W0203","W0204","W0205","W0208","W0500","W0501","W0502","W0503","W0504","W0508","W0509")|
strip(DXCODE9) in:("W0901","W0902","W0903","W0904","W0905","W0908","W0909","W0200","W0201","W0202","W0203","W0204","W0205","W0208","W0500","W0501","W0502","W0503","W0504","W0508","W0509")|
strip(DXCODE10) in:("W0901","W0902","W0903","W0904","W0905","W0908","W0909","W0200","W0201","W0202","W0203","W0204","W0205","W0208","W0500","W0501","W0502","W0503","W0504","W0508","W0509")|
substr(DXCODE1,1,3) in:("W01","W10","W11","W12","W13","W06","W07","W08","W14","W15","W16","W17","W00","W03","W04","W18","W19")|
substr(DXCODE2,1,3) in:("W01","W10","W11","W12","W13","W06","W07","W08","W14","W15","W16","W17","W00","W03","W04","W18","W19")|
substr(DXCODE3,1,3) in:("W01","W10","W11","W12","W13","W06","W07","W08","W14","W15","W16","W17","W00","W03","W04","W18","W19")|
substr(DXCODE4,1,3) in:("W01","W10","W11","W12","W13","W06","W07","W08","W14","W15","W16","W17","W00","W03","W04","W18","W19")|
substr(DXCODE5,1,3) in:("W01","W10","W11","W12","W13","W06","W07","W08","W14","W15","W16","W17","W00","W03","W04","W18","W19")|
substr(DXCODE6,1,3) in:("W01","W10","W11","W12","W13","W06","W07","W08","W14","W15","W16","W17","W00","W03","W04","W18","W19")|
substr(DXCODE7,1,3) in:("W01","W10","W11","W12","W13","W06","W07","W08","W14","W15","W16","W17","W00","W03","W04","W18","W19")|
substr(DXCODE8,1,3) in:("W01","W10","W11","W12","W13","W06","W07","W08","W14","W15","W16","W17","W00","W03","W04","W18","W19")|
substr(DXCODE9,1,3) in:("W01","W10","W11","W12","W13","W06","W07","W08","W14","W15","W16","W17","W00","W03","W04","W18","W19")|
substr(DXCODE10,1,3) in:("W01","W10","W11","W12","W13","W06","W07","W08","W14","W15","W16","W17","W00","W03","W04","W18","W19")) 
then Fall_Injury=1; else Fall_Injury=0;
run;

PROC SQL;
CREATE Table DT.ac_nacrs_5yrLB as   
(SELECT *, max(Fall_Injury) as max
from DT.ac_nacrs_5yrLB
group by PHN_ENC);
quit; 

Data DT.ac_nacrs_5yrLB(drop=max);
set DT.ac_nacrs_5yrLB;
Fall_Injury=max;
run;


/*5- Health Service Utilization (within 1-year preceding cohort entry)- 
Number of unplanned emergency department visits (CIHI-NACRS)*/

Data DT.ac_nacrs_5yrLB;
set DT.ac_nacrs_5yrLB;
total_EVisit=0;
run;

PROC SQL;
	create table DT.one_year_proceding as
	select *
	from DT.ac_nacrs_5yrLB as s1
	where '01APR2012'D <= DISP_DATE <= '31MAR2013'D;
QUIT;

Data DT.one_year_proceding (drop=total_EVisit);
set DT.one_year_proceding;
run;


PROC SORT data=DT.one_year_proceding;
  BY PHN_ENC DESCENDING DISP_DATE;
RUN;

proc sql;
create table DT.EmergencyVisit_Nacrs as
select *,count(PHN_ENC) as total_EVisit
from DT.one_year_proceding
group by PHN_ENC;
quit;

PROC SORT DATA=DT.EmergencyVisit_Nacrs
 OUT=DT.EmergencyVisit_Nacrs
 NODUPKEY ;
 BY PHN_ENC;
RUN ;



DATA DT.ac_nacrs_5yrLB; 
/*length total_Emergency_Visit 8;*/
set DT.ac_nacrs_5yrLB;
  IF _N_ = 1 THEN DO;
  DECLARE HASH T(dataset: 'DT.EmergencyVisit_Nacrs');
    T.definekey('PHN_ENC');
    T.definedata('total_EVisit');
    T.definedone();
  END;
  IF T.find() >= 0;

RUN;

/*Cleaning datasets*/
DATA DT.ac_nacrs_5yrLB;
  SET DT.ac_nacrs_5yrLB;
  where (DOB~=.);
RUN;

DATA DT.ac_nacrs_5yrLF;
  SET DT.ac_nacrs_5yrLF;
  where (DOB~=.);
RUN;

DATA DT.ac_nacrs_5yrLB;
  SET DT.ac_nacrs_5yrLB;
  where (SEX="M" | SEX="F");
RUN;

DATA DT.ac_nacrs_5yrLF;
  SET DT.ac_nacrs_5yrLF;
  where (SEX="M" | SEX="F");
RUN;

/*Age category*/
Data DT.ac_nacrs_5yrLB;
   set DT.ac_nacrs_5yrLB;  
	 If ('31MAR1958'D < DOB <= '31MAR1963'D) then AGE_CAT="50-55";
	 If ('31MAR1953'D < DOB <='31MAR1958'D) then AGE_CAT="56-60";
	 If ('31MAR1948'D < DOB <='31MAR1953'D) then AGE_CAT="61-65";
	 If ('31MAR1943'D < DOB <='31MAR1948'D) then AGE_CAT="66-70";
	 If ('31MAR1938'D < DOB <='31MAR1943'D) then AGE_CAT="71-75";
	 If ('31MAR1933'D < DOB <='31MAR1938'D) then AGE_CAT="76-80";
	 If ('31MAR1928'D < DOB <='31MAR1933'D) then AGE_CAT="81-85";
	 If (DOB <= '31MAR1928'D) then AGE_CAT="86 and older";
  run;

Data DT.ac_nacrs_5yrLF;
   set DT.ac_nacrs_5yrLF;  
	 If ('31MAR1958'D < DOB <= '31MAR1963'D) then AGE_CAT="50-55";
	 If ('31MAR1953'D < DOB <='31MAR1958'D) then AGE_CAT="56-60";
	 If ('31MAR1948'D < DOB <='31MAR1953'D) then AGE_CAT="61-65";
	 If ('31MAR1943'D < DOB <='31MAR1948'D) then AGE_CAT="66-70";
	 If ('31MAR1938'D < DOB <='31MAR1943'D) then AGE_CAT="71-75";
	 If ('31MAR1933'D < DOB <='31MAR1938'D) then AGE_CAT="76-80";
	 If ('31MAR1928'D < DOB <='31MAR1933'D) then AGE_CAT="81-85";
	 If (DOB <= '31MAR1928'D) then AGE_CAT="86 and older";
  run;



***************************************************************************************************************;
/***********************************************************************************************************************/
/*Cohort****************************************************************************************************************/
/* Ac_nacrs- cohort- LB*/
data DT.cohort_acnacrsLB (keep = PHN_ENC DOB  AGE_CAT SEX Frailty_b2 Atrial_Fib Fall_Injury total_EVisit);
	set DT.ac_nacrs_5yrLB;
	run;

PROC SORT DATA=DT.cohort_acnacrsLB
 OUT=DT.cohort_acnacrsLB
 NODUPKEY ;
 BY PHN_ENC;
RUN ;


Data DT.cohort_acnacrsLB (drop=Frailty_b2 Atrial_Fib Fall_Injury total_EVisit);

set DT.cohort_acnacrsLB;
A_Frailty_b2= Frailty_b2;
A_Atrial_Fib= Atrial_Fib;
A_Fall_Injury=Fall_Injury;
A_total_EVisit=total_EVisit;
run;

PROC SORT DATA=DT.cohort_acnacrsLB
 OUT=DT.cohort_acnacrsLB
 NODUPKEY ;
 BY PHN_ENC;
RUN ;



/********************************************************************************************************************/
/* Ac_nacrs- cohort- LF*/
Proc SQL;
  Create Table DT.ac_nacrs_5yrLF as 
    Select a.*
    From DT.ac_nacrs_5yrLF as a
    Where a.PHN_ENC in (select PHN_ENC from DT.PHN_listLB);
quit;


data DT.cohort_acnacrsLF (keep = PHN_ENC DOB AGE_CAT SEX);
	set DT.ac_nacrs_5yrLF;
	run;


PROC SORT DATA=DT.cohort_acnacrsLF
 OUT=DT.cohort_acnacrsLF
 NODUPKEY ;
 BY PHN_ENC;
RUN ;
