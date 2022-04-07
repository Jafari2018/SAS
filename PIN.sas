*Setting the directory;
libname DT "C:\Users\behnaz.jafari1\Desktop\Dementia\Merging data\Data"; 
libname X XLSX "C:\Users\behnaz.jafari1\Desktop\Dementia\Merging data\Drug_ID.xlsx";
***************************************************************************************************************;
*****************************************************************************************************************
*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;

/*data DT.drpd_pin0818(drop = PIN_DSPN_ID DSPN_ITEM_KEY DSPN_TIME DSPN_DTTM);
	set DT.Pin0818;
run;

DATA DT.drpd_pin0818(rename=(RCPT_DOB=DOB RCPT_GENDER_CD=SEX));
	set DT.drpd_pin0818;
RUN;

data DT.drpd_renamed_pin0818;
     set DT.drpd_pin0818;
	 label SEX="SEX";
	D_name="PIN";
	DOB_new = datepart(DOB);
	format DOB_new YYMMDDD10.;
	 label DOB_new="DOB";
	drop DOB;
	rename DOB_new=DOB;
	char_SEX = input(SEX, $1.);
	format char_SEX $1.;
	informat char_SEX $1.;
	label char_SEX="SEX";
	drop SEX;
	rename char_SEX=SEX;
	DSPN_new = datepart(DSPN_DATE);
	format DSPN_new YYMMDDD10.;
	 label DSPN_new="DSPN_DATE";
	drop DSPN_DATE;
	rename DSPN_new=DSPN_DATE;
run;

Data DT.clndDOB_drpd_renamed_pin0818;
length AGE_CAT $12;
   set DT.drpd_renamed_pin0818;
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
  run;

/* Adding DRUG_NAME to the pin dataset */
/*DATA DT.clndDOB_drpd_renamed_pin0818;
    set DT.clndDOB_drpd_renamed_pin0818;
	Length DRUG_NAME $20;
RUN;

/* Adding drug names based on the DRUG_ID*/
/*Data DT.clndDOB_drpd_renamed_pin0818;
	set DT.clndDOB_drpd_renamed_pin0818;
	if (DRUG_DIN="02328666" | DRUG_DIN="02328682" | DRUG_DIN="02397595" | DRUG_DIN="02397609" 
| DRUG_DIN="02428482" | DRUG_DIN="02428490" | DRUG_DIN="02362260" | DRUG_DIN="02362279" | DRUG_DIN="02402645" | DRUG_DIN="02402653" 
| DRUG_DIN="02404419" | DRUG_DIN="02404427" | DRUG_DIN="02232043" | DRUG_DIN="02232044" | DRUG_DIN="02322331" | DRUG_DIN="02322358" 
| DRUG_DIN="02340607" | DRUG_DIN="02340615" | DRUG_DIN="02359472" | DRUG_DIN="02359480" | DRUG_DIN="02381508" | DRUG_DIN="02381516" 
| DRUG_DIN="02400561" | DRUG_DIN="02400588" | DRUG_DIN="02402092" | DRUG_DIN="02402106" | DRUG_DIN="02412853" | DRUG_DIN="02412861" 
| DRUG_DIN="02426846" | DRUG_DIN="02426854" | DRUG_DIN="02416948" | DRUG_DIN="02416956" | DRUG_DIN="02426943" | DRUG_DIN="02426951" 
| DRUG_DIN="02439557" | DRUG_DIN="02439565") then DRUG_NAME="Donepezil";
	else if (DRUG_DIN="02293021" | DRUG_DIN="02293048" | DRUG_DIN="02293056" | DRUG_DIN="02425157"
| DRUG_DIN="02425165" | DRUG_DIN="02425173" | DRUG_DIN="02295229" | DRUG_DIN="02295237" | DRUG_DIN="02295245" | DRUG_DIN="02416573" 
| DRUG_DIN="02416581" | DRUG_DIN="02416603" | DRUG_DIN="02443015" | DRUG_DIN="02443023" | DRUG_DIN="02443031" | DRUG_DIN="02420821" 
| DRUG_DIN="02420848" | DRUG_DIN="02420856" | DRUG_DIN="02339439" | DRUG_DIN="02339447" | DRUG_DIN="02339455" | DRUG_DIN="02316943" 
| DRUG_DIN="02316951" | DRUG_DIN="02316978" | DRUG_DIN="02333376" | DRUG_DIN="02333384" | DRUG_DIN="02333392" | DRUG_DIN="02398370" 
| DRUG_DIN="02398389" | DRUG_DIN="02398397" | DRUG_DIN="02270773" | DRUG_DIN="02270781" | DRUG_DIN="02270803" | DRUG_DIN="02244298" 
| DRUG_DIN="02244299" | DRUG_DIN="02244300" | DRUG_DIN="02244302" | DRUG_DIN="82244299" | DRUG_DIN="82244300" | DRUG_DIN="02266717" 
| DRUG_DIN="02266725" | DRUG_DIN="02266733" | DRUG_DIN="02377950" | DRUG_DIN="02377969" | DRUG_DIN="02377977" | DRUG_DIN="02295229" 
| DRUG_DIN="02295237" | DRUG_DIN="02295245") then DRUG_NAME="Galantamine";
	else if (DRUG_DIN="02423537" | DRUG_DIN="02423529" | DRUG_DIN="02336715" | DRUG_DIN="02336723" | DRUG_DIN="02336731" 
| DRUG_DIN="02336758" | DRUG_DIN="02427567" | DRUG_DIN="02427575" | DRUG_DIN="02427583" | DRUG_DIN="02427591" | DRUG_DIN="02307685" 
| DRUG_DIN="02307693" | DRUG_DIN="02307707" | DRUG_DIN="02307715" | DRUG_DIN="02242115" | DRUG_DIN="02242116" | DRUG_DIN="02242117" 
| DRUG_DIN="02242118" | DRUG_DIN="02245240" | DRUG_DIN="82242115" | DRUG_DIN="82242116" | DRUG_DIN="02302853" | DRUG_DIN="02432803" 
| DRUG_DIN="02302845" | DRUG_DIN="02401614" | DRUG_DIN="02401622" | DRUG_DIN="02401630" | DRUG_DIN="02401649" | DRUG_DIN="02406985" 
| DRUG_DIN="02406993" | DRUG_DIN="02407000" | DRUG_DIN="02407019" | DRUG_DIN="02332809" | DRUG_DIN="02332817" | DRUG_DIN="02332825" 
| DRUG_DIN="02332833" | DRUG_DIN="02423413" | DRUG_DIN="02423421" | DRUG_DIN="02308169" | DRUG_DIN="02308177" | DRUG_DIN="02308185" 
| DRUG_DIN="02308193" | DRUG_DIN="02306034" | DRUG_DIN="02306042" | DRUG_DIN="02306050" | DRUG_DIN="02306069" | DRUG_DIN="02311283" 
| DRUG_DIN="02311291" | DRUG_DIN="02311305" | DRUG_DIN="02311313" | DRUG_DIN="02312492" | DRUG_DIN="02312506" | DRUG_DIN="02312514" 
| DRUG_DIN="02312522" | DRUG_DIN="02416999" | DRUG_DIN="02417006" | DRUG_DIN="02417014" | DRUG_DIN="02417022" | DRUG_DIN="02375729" 
| DRUG_DIN="02375737" | DRUG_DIN="02375745" | DRUG_DIN="02375753" | DRUG_DIN="02426307" | DRUG_DIN="02426293" | DRUG_DIN="02324563" 
| DRUG_DIN="02324571" | DRUG_DIN="02324598" | DRUG_DIN="02324601" | DRUG_DIN="02305984" | DRUG_DIN="02305992" | DRUG_DIN="02306018" 
| DRUG_DIN="02306026" | DRUG_DIN="02308622" | DRUG_DIN="02308630" | DRUG_DIN="02308649" | DRUG_DIN="02308657" | DRUG_DIN="02349116" 
| DRUG_DIN="02260638" | DRUG_DIN="02320908" | DRUG_DIN="02321130" | DRUG_DIN="02324059" | DRUG_DIN="02324067" | DRUG_DIN="02344807" 
| DRUG_DIN="02348950" | DRUG_DIN="02366487" | DRUG_DIN="02375532" | DRUG_DIN="02382830" | DRUG_DIN="02409887" | DRUG_DIN="02409895" 
| DRUG_DIN="02421364" | DRUG_DIN="02430371" | DRUG_DIN="02443082" | DRUG_DIN="02446049") then DRUG_NAME="Rivastigmine";
else if (DRUG_DIN="02349116" | DRUG_DIN="02260638" | DRUG_DIN="02320908" | DRUG_DIN="02321130" | DRUG_DIN="02324059" 
| DRUG_DIN="02324067" | DRUG_DIN="02344807" | DRUG_DIN="02348950" | DRUG_DIN="02366487" | DRUG_DIN="02375532" | DRUG_DIN="02382830" 
| DRUG_DIN="02409887" | DRUG_DIN="02409895" | DRUG_DIN="02421364" | DRUG_DIN="02430371" | DRUG_DIN="02443082" | DRUG_DIN="02446049") 
then DRUG_NAME="Memamntine";
else DRUG_NAME="NA";

run;


/*Creating 5 years look forward*/
/*PROC SQL;
	create table DT.PIN_5yrLF as
	select *
	from DT.clndDOB_drpd_renamed_pin0818 as s1
	where '01APR2013'D <= DSPN_DATE <= '31MAR2018'D;
QUIT;

PROC SQL;
delete from DT.PIN_5yrLF
where PHN_ENC in (SELECT PHN_ENC from DT.vs_death_5yrLB);
quit;

PROC SQL;
delete from DT.PIN_5yrLF
where PHN_ENC in (SELECT PHN_ENC from DT.palliative);
quit;

PROC SQL;
delete from DT.PIN_5yrLF
where PHN_ENC in (SELECT PHN_ENC from DT.Seizure);
quit;*/

***************************************************************************************************************;
*****************************************************************************************************************
*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;

/*Data DT.PIN_5yrLF;
set DT.PIN_5yrLF;
Dementia=0;
if (strip(DRUG_NAME)in:("Donepezil","Galantamine","Rivastigmine","Memantine")) then Dementia=1;
run;*/




/******************************************************************************************************************/
/*Creating 5 years look_back*/
/*PROC SQL;
	create table DT.PIN_5yrLB as
	select *
	from DT.clndDOB_drpd_renamed_pin0818 as s1
	where '01APR2008'D <= DSPN_DATE <= '31MAR2013'D;

QUIT;

PROC SQL;
delete from DT.PIN_5yrLB
where PHN_ENC in (SELECT PHN_ENC from DT.vs_death_5yrLB);
quit;

PROC SQL;
delete from DT.PIN_5yrLB
where PHN_ENC in (SELECT PHN_ENC from DT.palliative);
quit;

PROC SQL;
delete from DT.PIN_5yrLB
where PHN_ENC in (SELECT PHN_ENC from DT.Seizure);
quit;



/* Applying Exclusion Criteria */
/*Exclusion of Dementia cases base on the medicine patients use */
/*Data DT.PIN_5yrLB;
set DT.PIN_5yrLB;
if (strip(DRUG_NAME)in:("Donepezil","Galantamine","Rivastigmine","Memantine")) then DELETE;
run;


PROC SORT DATA=DT.PIN_5yrLB
 OUT=DT.Num_obs_pinlb
 NODUPKEY ;
 BY PHN_ENC;
RUN ;


/*cleaning datasets from missing data and checking the SEX values, there is just one "O" record

DATA DT.PIN_5yrLB;
  SET DT.PIN_5yrLB;
  where (DOB~=.);
RUN;

DATA DT.PIN_5yrLF;
  SET DT.PIN_5yrLF;
  where (DOB~=.);
RUN;

DATA DT.PIN_5yrLB;
  SET DT.PIN_5yrLB;
  where (SEX="M" | SEX="F");
RUN;

DATA DT.PIN_5yrLF;
  SET DT.PIN_5yrLF;
  where (SEX="M" | SEX="F");
RUN;



/********************************************************************************************************************
*****************************************************************************************************************
*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*Pin;*/

/*Parkinson Disease
Two prescriptions for anti-Parkinson medications, at least one of the scripts and one of the diagnostic codes
must be within two years of each other; prescriptions must be consecutive, defined as the second being
within 180 days of the first*/

Proc sort data=DT.Pin_5yrlb;
by PHN_ENC DSPN_DATE;
run;

data DT.Pin_5yrlb;
set DT.Pin_5yrlb;
Parkinson=0;
format PHN_ENC $15.;
format SE_START_DATE DDMMYY10.;
run;

data DT.Park_pin(Keep= PHN_ENC DSPN_DATE PREV_DATE DATE_DIF1);
  set DT.Pin_5yrlb;
  by PHN_ENC;
  array x(*) DATE_DIF1 PREV_DATE;
  DATE_DIF1=DIF1(DSPN_DATE);
  PREV_DATE= lag(DSPN_DATE);
  format PREV_DATE YYMMDDD10.;
  /* Reset COUNT at the start of each new BY-Group */
  If first.PHN_ENC=1 then DATE_DIF1="" ;
  If first.PHN_ENC=1 then PREV_DATE="" ;
  /*if first.RCPT_ULI then SE_START_DATE_DIF1="" */   
run;

data DT.Park_pin;
  set DT.Park_pin; 
if DATE_DIF1 >180 then delete;
run;

data DT.Park_pin;
  set DT.Park_pin; 
if (DATE_DIF1=0 | DATE_DIF1="") then delete;
run;


/******************Claim*******************************************/
data Claims_5yrLB;
set DT.Claims_5yrLB;
Parkinson=0;
format PHN_ENC $15.;
format SE_START_DATE YYMMDDD10.;
run;

PROC SQL;
	create table DT.Parkinson_Claims_1 as
	select PHN_ENC, SE_START_DATE, Parkinson
	from Claims_5yrLB as s1
	where (strip(HLTH_DX_ICD9X_CODE_1)="332"|
	strip(HLTH_DX_ICD9X_CODE_2)="332"|
	strip(HLTH_DX_ICD9X_CODE_3)="332");
QUIT;

PROC SORT data=DT.Parkinson_Claims_1;
  BY PHN_ENC SE_START_DATE;
  run;

data DT.Parkinson_Claims_1(Keep= PHN_ENC SE_START_DATE PREV_DATE DATE_DIF1);
  set DT.Parkinson_Claims_1;
  by PHN_ENC;
  array x(*) DATE_DIF1 PREV_DATE;
  DATE_DIF1=DIF1(SE_START_DATE);
  PREV_DATE= lag(SE_START_DATE);
  format PREV_DATE YYMMDDD10.;
  If first.PHN_ENC=1 then DATE_DIF1="" ;
  If first.PHN_ENC=1 then PREV_DATE="" ;
  /*if first.RCPT_ULI then SE_START_DATE_DIF1="" */   
run;

data DT.Parkinson_Claims_11;
  set DT.Parkinson_Claims_1; 
if (DATE_DIF1=0) then delete;
run;

PROC SQL;
CREATE Table DT.Park_pin_1 as   
(SELECT * 
from DT.Park_pin
where PHN_ENC in (SELECT PHN_ENC from DT.Parkinson_Claims_11));
quit; 

PROC SQL;
CREATE Table DT.Parkinson_Claims_11 as   
(SELECT PHN_ENC, SE_START_DATE 
from DT.Parkinson_Claims_11
where PHN_ENC in (SELECT PHN_ENC from DT.Park_pin_1));
quit; 


PROC SQL;
create table DT.Park_Pin_CLAIM as
select * from DT.Park_pin_1 a
join DT.Parkinson_Claims_11 b
on a.PHN_ENC=b.PHN_ENC;
Quit;

Data DT.Park_Pin_CLAIM;
set DT.Park_Pin_CLAIM;
RETAIN flag;
If(ABS(DSPN_DATE-SE_START_DATE)<=365 | ABS(PREV_DATE-SE_START_DATE)<=365) then Parkinson=1;
else Parkinson=0;
run;

Data DT.Park_Pin_CLAIM;
set DT.Park_Pin_CLAIM;
where Parkinson=1;
run;

PROC SORT DATA=DT.Park_Pin_CLAIM
 OUT=DT.Park_Pin_CLAIM
 NODUPKEY ;
 BY PHN_ENC;
 run;


 DATA DT.Pin_5yrlb(drop= SE_START_DATE);
  SET DT.Pin_5yrlb;
  IF _N_ = 1 THEN DO;
  DECLARE HASH T(dataset: 'DT.Park_Pin_CLAIM');
    T.definekey('PHN_ENC');
    T.definedata('Parkinson');
    T.definedone();
  END;
  IF T.find() >= 0;
RUN;


/**********************************************************************************************************************/
/*5-Year look forward**************************************************************************************************/
Proc SQL;
  Create Table DT.PIN_5yrLF as 
    Select a.*
    From DT.PIN_5yrLF as a
    Where a.PHN_ENC in (select PHN_ENC from DT.PHN_listLB)
  ;
quit;


data DT.PIN_5yrLF;
set DT.PIN_5yrLF;
Dementia=0;
format Dementia_date YYMMDDD10.;
run;

Data DT.Dementia_PIN_LF;
	set DT.PIN_5yrLF;
	where (strip(DRUG_NAME)in:("Donepezil","Galantamine","Rivastigmine","Memantine"));
run;


Proc sort data=DT.Dementia_PIN_LF;
by PHN_ENC DSPN_DATE;
run;

PROC SQL;
CREATE Table DT.Temp_PIN_LF as   
SELECT *, min(DSPN_DATE)  as min_date
from DT.Dementia_PIN_LF
group by PHN_ENC;
quit; 

data DT.Temp_PIN_LF(Drop= min_date);
set DT.Temp_PIN_LF;
format min_date YYMMDDD10.;
Dementia_Date= min_date;
run;


PROC SORT DATA=DT.Temp_PIN_LF
 OUT=DT.Temp_PIN_LF
 NODUPKEY ;
 BY PHN_ENC;
 run;

 data DT.Temp_PIN_LF;
 set DT.Temp_PIN_LF;
 Dementia=1;
 run;

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


DATA DT.PIN_5yrLF;
  SET DT.PIN_5yrLF;
  IF _N_ = 1 THEN DO;
  DECLARE HASH T(dataset: 'DT.Temp_PIN_LF');
    T.definekey('PHN_ENC');
    T.definedata('Dementia', 'Dementia_Date');
    T.definedone();
  END;
  IF T.find() >= 0;
RUN;

/* Cleaning datasets*/
DATA DT.PIN_5yrLB;
  SET DT.PIN_5yrLB;
  where (DOB~=.);
RUN;

DATA DT.PIN_5yrLF;
  SET DT.PIN_5yrLF;
  where (DOB~=.);
RUN;

DATA DT.PIN_5yrLB;
  SET DT.PIN_5yrLB;
  where (SEX="M" | SEX="F");
RUN;

DATA DT.PIN_5yrLF;
  SET DT.PIN_5yrLF;
  where (SEX="M" | SEX="F");
RUN;

/*Age categy*/
Data DT.PIN_5yrLB;
   set DT.PIN_5yrLB;  
	 If ('31MAR1958'D < DOB <= '31MAR1963'D) then AGE_CAT="50-55";
	 If ('31MAR1953'D < DOB <='31MAR1958'D) then AGE_CAT="56-60";
	 If ('31MAR1948'D < DOB <='31MAR1953'D) then AGE_CAT="61-65";
	 If ('31MAR1943'D < DOB <='31MAR1948'D) then AGE_CAT="66-70";
	 If ('31MAR1938'D < DOB <='31MAR1943'D) then AGE_CAT="71-75";
	 If ('31MAR1933'D < DOB <='31MAR1938'D) then AGE_CAT="76-80";
	 If ('31MAR1928'D < DOB <='31MAR1933'D) then AGE_CAT="81-85";
	 If (DOB <= '31MAR1928'D) then AGE_CAT="86 and older";
  run;

Data DT.PIN_5yrLF;
   set DT.PIN_5yrLF;  
	 If ('31MAR1958'D < DOB <= '31MAR1963'D) then AGE_CAT="50-55";
	 If ('31MAR1953'D < DOB <='31MAR1958'D) then AGE_CAT="56-60";
	 If ('31MAR1948'D < DOB <='31MAR1953'D) then AGE_CAT="61-65";
	 If ('31MAR1943'D < DOB <='31MAR1948'D) then AGE_CAT="66-70";
	 If ('31MAR1938'D < DOB <='31MAR1943'D) then AGE_CAT="71-75";
	 If ('31MAR1933'D < DOB <='31MAR1938'D) then AGE_CAT="76-80";
	 If ('31MAR1928'D < DOB <='31MAR1933'D) then AGE_CAT="81-85";
	 If (DOB <= '31MAR1928'D) then AGE_CAT="86 and older";
  run;

/***********************************************************************************************************************/
/*Cohort****************************************************************************************************************/
******************************************************************************************************************;
/* PIN- cohort- LB */
data DT.cohort_PinLB (keep = PHN_ENC DOB  AGE_CAT SEX Parkinson);
	set DT.Pin_5yrlb;
	run;
PROC SORT DATA=DT.cohort_PinLB
 OUT=DT.cohort_PinLB
 NODUPKEY ;
 BY PHN_ENC;
RUN ;


Data DT.cohort_PinLB (drop=Parkinson);

set DT.cohort_PinLB;
P_Parkinson= Parkinson;
run;

PROC SORT DATA=DT.cohort_PinLB
 OUT=DT.cohort_PinLB
 NODUPKEY ;
 BY PHN_ENC;
RUN ;


******************************************************************************************************************;
/* PIN- cohort- LF */
Proc SQL;
  Create Table DT.PIN_5yrLF as 
    Select a.*
    From DT.PIN_5yrLF as a
    Where a.PHN_ENC in (select PHN_ENC from DT.PHN_listLB)
  ;
quit;

data DT.cohort_PINLF (keep = PHN_ENC DOB AGE_CAT SEX Dementia Dementia_Date);
	set DT.PIN_5yrLF;
	run;

proc sql;
create table DT.cohort_PINLF as
select Distinct PHN_ENC, DOB, AGE_CAT, SEX, Dementia as P_Dementia, Dementia_Date as P_Dementia_Date
from DT.cohort_PINLF
group by PHN_ENC;
quit;

PROC SORT DATA=DT.cohort_PINLF
 OUT=DT.cohort_PINLF
 NODUPKEY ;
 BY PHN_ENC;
RUN ;
