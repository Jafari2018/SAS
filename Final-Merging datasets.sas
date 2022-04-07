*Setting the directory;
libname DT "C:\Users\behnaz.jafari1\Desktop\Dementia\Merging data\Data"; 
libname X XLSX "C:\Users\behnaz.jafari1\Desktop\Dementia\Merging data\Drug_ID.xlsx";
proc format;
value Gender
	  0 = "Male"
	  1 = "Female";
value Age_cat_n
	0= "50-55"
	1= "56-60"
	2= "61-65"
	3= "66-70"
	4= "71-75"
	5= "76-80"
	6= "81-85"
	7= "86 and older";
run;

****************************************************************************************************************;
****************************************************************************************************************;
/* Final Cohort LB*/
data DT.cohort_FLB;
    merge DT.Cohort_acnacrslb DT.Cohort_Claimslb DT.Cohort_Dadlb DT.Cohort_pinlb;
	by PHN_ENC;
run;

PROC SORT DATA=DT.cohort_FLB
 OUT=DT.cohort_FLB;
 BY PHN_ENC;
RUN ;
/*keeping needed columns D_ is for DAD , C_ is for Claims, P_ is for PIN and A_ is for Acrs/Nacrs*/
/* for Frailty we had several conditions a-g, so the last letter _a..._g indicates the condition*/

data DT.cohort_FLB(keep= PHN_ENC DOB AGE_CAT SEX Cong_Heart_Failure Car_Arrh Valvular Pul_Circ 
Hyp_Uncom Hyp_com Paralysis Other_Neuro COPD Diabetes Hypothyr 
Kid_Dis Liv_Dis Pep_Ulcer HIV Lymphoma Meta_Cancer WO_Meta Rheum_Collagen Coagulopathy Obesity Weight_Loss 
Flu_Elect Anemia Alcoholism Drug_Abuse Psychoses Depression
Dyslipidemia Per_Vascular Sleep_Dis Atrial_Fib MI Urin_Inc Vis_Imp Hear_Imp Multi_Scler Head_Inj Parkinson
Fall_Injury Tobacco Delirium Stro C_total_GP C_total_neurolog C_total_internalmedicine
C_total_psychiatrists D_total_Psych D_total_non_Psych A_total_EVisit D_Frailty_b1 A_Frailty_b2 D_Frailty_b C_Frailty_b
D_Frailty_c D_Frailty_d D_Frailty_e D_Frailty_f C_Frailty_g);


if (D_Delirium=1 | C_Delirium=1) then Delirium=1;
else Delirium=0;

if(D_Cong_Heart_Failure=1 | C_Cong_Heart_Failure=1) then Cong_Heart_Failure=1;
else Cong_Heart_Failure=0;

if(D_Car_Arrh=1 | C_Car_Arrh=1) then Car_Arrh=1;
else Car_Arrh=0;

if(D_Valvular=1 | C_Valvular=1) then Valvular=1;
else Valvular=0;
 
if(D_Pul_Circ=1 | C_Pul_Circ=1) then Pul_Circ=1;
else Pul_Circ=0;


if(D_Hyp_Uncom =1 | C_Hyp_Uncom =1) then Hyp_Uncom=1;
else Hyp_Uncom=0;

if(D_Hyp_com =1 | C_Hyp_com =1) then Hyp_com=1;
else Hyp_com=0;

if(D_Paralysis =1 | C_Paralysis =1) then Paralysis=1;
else Paralysis=0;

if(D_Other_Neuro =1 | C_Other_Neuro =1) then Other_Neuro=1;
else Other_Neuro=0;

if(D_COPD =1 | C_COPD =1) then COPD=1;
else COPD=0;

if(D_Diabetes =1 | C_Diabetes =1) then Diabetes=1;
else Diabetes=0;

if(D_Hypothyr =1 | C_Hypothyr =1) then Hypothyr=1;
else Hypothyr=0;
  
if(D_Kid_Dis =1 | C_Kid_Dis =1) then Kid_Dis=1;
else Kid_Dis=0;

if(D_Liv_Dis =1 | C_Liv_Dis =1) then Liv_Dis=1;
else Liv_Dis=0;

if(D_Pep_Ulcer =1 | C_Pep_Ulcer =1) then Pep_Ulcer=1;
else Pep_Ulcer=0;

if(D_HIV =1 | C_HIV =1) then HIV=1;
else HIV=0;

if(D_Lymphoma =1 | C_Lymphoma =1) then Lymphoma=1;
else Lymphoma=0;
 
if(D_Meta_Cancer =1 | C_Meta_Cancer =1) then Meta_Cancer=1;
else Meta_Cancer=0;

if(D_WO_Meta =1 | C_WO_Meta =1) then WO_Meta=1;
else WO_Meta=0;

if(D_Rheum_Collagen =1 | C_Rheum_Collagen =1) then Rheum_Collagen=1;
else Rheum_Collagen=0;

if(D_Coagulopathy=1 | C_Coagulopathy=1) then Coagulopathy=1;
else Coagulopathy=0;

if(D_Obesity=1 | C_Obesity=1) then Obesity=1;
else Obesity=0;
 
if(D_Weight_Loss =1 | C_Weight_Loss =1) then Weight_Loss=1;
else Weight_Loss=0;

if(D_Flu_Elect =1 | C_Flu_Elect =1) then Flu_Elect=1;
else Flu_Elect=0;

if(D_Anemia =1 | C_Anemia =1) then Anemia=1;
else Anemia=0;

if(D_Alcoholism =1 | C_Alcoholism =1) then Alcoholism=1;
else Alcoholism=0;

if(D_Drug_Abuse =1 | C_Drug_Abuse =1) then Drug_Abuse=1;
else Drug_Abuse=0;

if(D_Psychoses =1 | C_Psychoses =1) then Psychoses=1;
else Psychoses=0;

if(D_Dyslipidemia =1 | C_Dyslipidemia =1) then Dyslipidemia=1;
else Dyslipidemia=0;

if(D_Depression =1 | C_Depression=1) then Depression=1;
else Depression=0;

if(D_Per_Vascular =1 | C_Per_Vascular =1) then Per_Vascular=1;
else Per_Vascular=0;

if(D_Sleep_Dis=1 | C_Sleep_Dis=1) then Sleep_Dis=1;
else Sleep_Dis=0;

if(D_Atrial_Fib=1 | C_Atrial_Fib=1 | A_Atrial_Fib=1) then Atrial_Fib=1;
else Atrial_Fib=0;

if(D_MI=1 | C_MI=1) then MI=1;
else MI=0;
 
if(D_Urin_Inc=1 | C_Urin_Inc=1) then Urin_Inc=1;
else Urin_Inc=0;
 
if(D_Vis_Imp=1 | C_Vis_Imp=1) then Vis_Imp=1;
else Vis_Imp=0;

if(D_Hear_Imp=1 | C_Hear_Imp=1) then Hear_Imp=1;
else Hear_Imp=0; 

if(D_Multi_Scler =1 | C_Multi_Scler =1) then Multi_Scler =1;
else Multi_Scler =0; 

if(D_Stro =1 | C_Stro =1) then Stro=1;
else Stro =0; 

if(D_Head_Inj=1) then Head_Inj=1;
else Head_Inj=0;

if(D_Parkinson=1 | C_Parkinson=1 | P_Parkinson) then Parkinson=1;
else Parkinson=0; 

if(D_Fall_Injury =1 | A_Fall_Injury =1) then Fall_Injury=1;
else Fall_Injury =0; 

if(D_Tobacco =1 | C_Tobacco =1) then Tobacco=1;
else Tobacco =0; 
 
set DT.cohort_FLB;
run;

/* defining the final Frailty based on values in datasets DAD, Claims and Ac/Naccrs*/
data DT.cohort_FLB(Drop= D_Frailty_b1 A_Frailty_b2 D_Frailty_b C_Frailty_b ) ;
set DT.cohort_FLB;
If (D_Frailty_b1=1 | A_Frailty_b2=1 | D_Frailty_b=1 | C_Frailty_b=1) then Frailty_b=1;
else Frailty_b=0;
run;

/*Checking the condition if we have at least two conditions for frailty*/
data DT.cohort_FLB(Drop= Frailty_b D_Frailty_c D_Frailty_d D_Frailty_e D_Frailty_f C_Frailty_g S) ;
set DT.cohort_FLB;
S= Delirium+Frailty_b+D_Frailty_c+D_Frailty_d+D_Frailty_e+D_Frailty_f+C_Frailty_g;
If(S>=2) then Frailty=1;
else Frailty=0;
run;

/* calculating the total number of visits to specialists*/
Data DT.cohort_FLB(drop= A_total_EVisit D_total_Psych D_total_non_Psych C_total_GP C_total_neurolog C_total_internalmedicine
C_total_psychiatrists);
set DT.cohort_FLB;
total_EVisit=A_total_EVisit;
total_Psych=D_total_Psych;
total_non_Psych=D_total_non_Psych;
total_GP=C_total_GP;
total_neurolog=C_total_neurolog;
total_internalmedicine=C_total_internalmedicine;
total_psychiatrists=C_total_psychiatrists;
run;


****************************************************************************************************************;
****************************************************************************************************************;
/* Final Cohort LF*/
data DT.cohort_FLF;
    merge DT.Cohort_acnacrsLF DT.Cohort_ClaimsLF DT.Cohort_DadLF DT.Cohort_pinLF;
	by PHN_ENC;
run;

PROC SORT DATA=DT.cohort_FLF
 OUT=DT.cohort_FLF;
 BY PHN_ENC;
RUN ;

/*Check the dementia in Claims, DAD and PIN*/
data DT.cohort_FLF(Drop= C_Dementia D_Dementia P_Dementia );
set DT.cohort_FLF;
If (C_Dementia=1 | D_Dementia=1 | P_Dementia=1) then Dementia=1;
else Dementia=0;
run;

data DT.cohort_FLF(Drop= C_Dementia_Date D_Dementia_Date P_Dementia_Date ) ;
set DT.cohort_FLF;
format Dementia_Date YYMMDDD10.;
Dementia_Date=min(C_Dementia_Date, D_Dementia_Date, P_Dementia_Date);
run;

data DT.cohort_FLF;
set DT.cohort_FLF;
format Death_Date YYMMDDD10.;
Death_Date=.;
run;


DATA DT.Cohort_flf;
  SET DT.Cohort_flf;
  IF _N_ = 1 THEN DO;
  DECLARE HASH T(dataset: 'DT.Vs_death_5yrLF');
    T.definekey('PHN_ENC');
    T.definedata('Death_Date');
    T.definedone();
  END;
  IF T.find() >= 0;
RUN;

/*Defining min date among Dementia, Death and Hospitalization>90 for censoring time*/
Data DT.cohort_FLF;
set DT.cohort_FLF;
format Censoring_Date YYMMDDD10.;
format Event_type $35.;
If(min(Hosp90_date,Dementia_Date,Death_Date)=. | min(Hosp90_date,Dementia_Date,Death_Date)=0) then
do;
Censoring_Date='31MAR2018'D;
Event_type="End of the study";
end;
else do;
If (min(Hosp90_date,Dementia_Date,Death_Date)=Hosp90_date) then 
do;
Censoring_Date=Hosp90_date;
Event_type="Hospitalization more than 90 days";
end;
else If (min(Hosp90_date,Dementia_Date,Death_Date)=Dementia_date & Dementia=1) then 
do;
Censoring_Date=Dementia_date;
Event_type="Dementia";
end;
else If (min(Hosp90_date,Dementia_Date,Death_Date)=Death_Date & Death_Date~=.) then 
do;
Censoring_Date=Death_Date;
Event_type="Decease";
end;
end;
run;


/*********************************************************************************************************************/
****************************************************************************************************************;
****************************************************************************************************************;
*/Pampalon Index;*/Pampalon Index;*/Pampalon Index;*/Pampalon Index;*/Pampalon Index;*/Pampalon Index;*/Pampalon Index;

*/keeping needed variables;
Data DT.drpd_pmpl_idx0818;
set DT.pmpl_idx_0818;
 keep POSTAL_CODE FYE FactorMAT FactorSOC QuintMat QuintSoc pmono p_s_d_w p_alone income p_employed p_educatio collective coverage PHN_ENC;
run;


*/Cleaning PHN;
Data DT.clnd_drpd_pmpl_idx0818;
   set DT.drpd_pmpl_idx0818;
  where ((PHN_ENC)~= "000000000000" & strip(PHN_ENC)~="" & length(strip(PHN_ENC))=12);
  run;


/*keep records in Pampalon index file that have PHN_ENC records in LB*/
Proc SQL;
  Create Table DT.Final_pampalon As
    Select t1.*
    From DT.clnd_drpd_pmpl_idx0818 t1
    Where t1.PHN_ENC in (select PHN_ENC from DT.all_phn);
quit;

/*Finding the index from Fiscal year 2012 and later*/
Proc SQL;
  Create Table DT.Final_pampalon As
    Select t1.*
    From DT.Final_pampalon t1
    Where FYE<=2012;
quit;

PROC SQL;
CREATE Table DT.Final2012_pampalon as   
SELECT *, max(FYE) as max_year
from DT.Final_pampalon
group by PHN_ENC;
quit; 

PROC SQL;
CREATE Table DT.Final2012_pampalon as   
SELECT *
from DT.Final2012_pampalon
where (FYE=max_year)
group by PHN_ENC;
quit; 

Data DT.Final2012_pampalon(drop=max_year);
set DT.Final2012_pampalon;
run;


PROC SORT DATA=DT.Final2012_pampalon
 OUT=DT.Final2012_pampalon
 NODUPKEY ;
 BY PHN_ENC;
 run;

Data DT.Cohort_flb;
set DT.Cohort_flb;
format POSTAL_CODE $6. FactorMAT BEST12. FactorSOC BEST12. QuintMat BEST12. QuintSoc BEST12. FYE 5.;
run;
/*Updating pampalon variables in final look back dataset*/

DATA DT.Cohort_flb;
  SET DT.Cohort_flb;
  IF _N_ = 1 THEN DO;
  DECLARE HASH T(dataset: 'DT.Final2012_pampalon');
    T.definekey('PHN_ENC');
    T.definedata('POSTAL_CODE', 'FactorMAT', 'FactorSOC', 'QuintMat', 'QuintSoc','FYE');
    T.definedone();
  END;
  IF T.find() >= 0;
RUN;

/******************************************************************************************************************/
/*Weighted and unweighted Elixhauser Indices***************************************************************/
DATA DT.Cohort_flb;
set DT.Cohort_flb;
format Weighted_Elixhauser BEST12. TOT_GRP BEST12.;
run;

/*Updating Look Back dataset with values from Elixhauser index dataset*/

DATA DT.Cohort_flb;
  SET DT.Cohort_flb;
  IF _N_ = 1 THEN DO;
  DECLARE HASH T(dataset: 'DT.Elix_dadclaims_0813');
    T.definekey('PHN_ENC');
    T.definedata('Weighted_Elixhauser', 'TOT_GRP');
    T.definedone();
  END;
  IF T.find() >= 0;
  Label TOT_GRP= 'Total Elixhauser Groups per record- range(1 to 29)';
  Label Weighted_Elixhauser= 'Weighted Elixhauser Index- range(-17 to +89)';
RUN;


DATA DT.Cohort_flb;
  SET DT.Cohort_flb;
format Age BEST12.;
Age= intck( 'year', DOB, '31MAR2013'D);
run;


/* Creating table of individuals who are in LB but not in LF*/
proc sql;
CREATE Table DT.not_inLf as   
SELECT * from DT.Cohort_flb
where PHN_ENC not in (select PHN_ENC from DT.Cohort_flf);
quit;


/********************************************************************************************************************/
/*Summary*/

PROC CONTENTS DATA=DT.Cohort_flb;
RUN;

Proc univariate data=DT.Cohort_flb;
class AGE_CAT;
    var Age;
run;

proc freq data=DT.Cohort_flb;
table Age_CAT;
run;

Proc univariate data=DT.not_inLf;
class AGE_CAT;
    var Age;
run;

proc freq data=DT.not_inLf;
table Age_CAT;
run;

proc freq data=DT.Cohort_flb;
table SEX;
run;

proc freq data=DT.not_inLf;
table SEX;
run;

proc means data=DT.Cohort_flb N mean median STD Q1 Q3 QRANGE;
    var FactorMAT;
run;

proc means data=DT.not_inLf N mean median STD Q1 Q3 QRANGE;
    var FactorMAT;
run;

proc means data=DT.Cohort_flb N mean median STD Q1 Q3 QRANGE;
    var FactorSOC;
run;

proc means data=DT.not_inLf N mean median STD Q1 Q3 QRANGE;
    var FactorSOC;
run;

proc means data=DT.Cohort_flb N mean median STD Q1 Q3 QRANGE;
    var QuintMat;
run;

proc means data=DT.not_inLf N mean median STD Q1 Q3 QRANGE;
    var QuintMat;
run;

proc means data=DT.Cohort_flb N mean median STD Q1 Q3 QRANGE;
    var QuintSOC;
run;

proc means data=DT.not_inLf N mean median STD Q1 Q3 QRANGE;
    var QuintSOC;
run;

proc means data=DT.Cohort_flb N mean median STD Q1 Q3 QRANGE;
    var TOT_GRP;
run;

proc means data=DT.not_inLf N mean median STD Q1 Q3 QRANGE;
    var TOT_GRP;
run;

proc freq data=DT.Cohort_flb;
    table TOT_GRP;
run;

proc freq data=DT.not_inLf;
    table TOT_GRP;
run;


proc freq data=DT.Cohort_flb;
    table Car_Arrh Valvular Pul_Circ Hyp_Uncom Hyp_com Paralysis Other_Neuro COPD Diabetes Hypothyr 
Kid_Dis Liv_Dis Pep_Ulcer HIV Lymphoma Meta_Cancer WO_Meta Rheum_Collagen Coagulopathy Obesity Weight_Loss 
Flu_Elect Anemia Alcoholism Drug_Abuse Psychoses Depression
Dyslipidemia Per_Vascular Sleep_Dis Atrial_Fib MI Urin_Inc Vis_Imp Hear_Imp Multi_Scler Head_Inj Parkinson
Fall_Injury Tobacco Stro Frailty;
run;

proc freq data=DT.Cohort_flb;
    table total_EVisit total_Psych total_non_Psych total_GP total_neurolog total_internalmedicine total_psychiatrists;
run;

proc means data=DT.Cohort_flb mean STD NMISS;
    var total_EVisit total_Psych total_non_Psych total_GP total_neurolog total_internalmedicine total_psychiatrists;
run;

proc freq data=DT.not_inLf;
    table total_EVisit total_Psych total_non_Psych total_GP total_neurolog total_internalmedicine total_psychiatrists;
run;

proc means data=DT.not_inLf mean STD NMISS;
    var total_EVisit total_Psych total_non_Psych total_GP total_neurolog total_internalmedicine total_psychiatrists;
run;

/* Adding Death_Date from VS_death_5yrLF dataset to not_inLF dataset*/

data DT.not_inLf;
set DT.not_inLf;
format Death_Date YYMMDDD10.;
Death_Date=.;
run;


DATA DT.not_inLf;
  SET DT.not_inLf;
  IF _N_ = 1 THEN DO;
  DECLARE HASH T(dataset: 'DT.Vs_death_5yrLF');
    T.definekey('PHN_ENC');
    T.definedata('Death_Date');
    T.definedone();
  END;
  IF T.find() >= 0;
RUN;

DATA DT.not_inLf (Keep= Death_Date AGE_CAT SEX PHN_ENC DOB) ;
  SET DT.not_inLf;
RUN;

/* Adding variable Records to indicate if there is any records of claims dad or pin for the participant or not*/
proc format;
value Records
	  0 = "No Records"
	  1 = "Records exist";
run;

data DT.not_inLf (drop=Event_Type);
set DT.not_inLf;
run;

data DT.not_inLf;
set DT.not_inLf;
format Dementia_Date YYMMDDD10.;
format Hosp90_date YYMMDDD10.;
format Censoring_Date YYMMDDD10.;
format Event_type $35.;
Dementia_Date=.;
Hosp90_date=.;
Dementia=0;
Records="No Records";
If Death_Date~=. then do;
Censoring_Date=Death_Date;
Event_type="Decease";
end;
else do;
Censoring_Date='31MAR2018'D;
Event_type="End of the study";
end;
run;

Data DT.Cohort_flf;
Set DT.Cohort_flf;
Records = "Records exist";
run;

/*Merging not_inLf and Cohort_flf  datasets to creat equal records in LB and LF cohort datasets*/
DATA DT.Cohort_flf;
    set DT.Cohort_flf DT.not_inLf;
RUN;

PROC SORT DATA=DT.Cohort_flf
 OUT=DT.Cohort_flf;
 BY PHN_ENC;
RUN ;


/********************************************************************************************************************/
/*Calculating the duration to event from April 1, 2013 until censoring date*/

Data DT.cohort_FLF;
set DT.cohort_FLF;
Lof=(Censoring_Date-'01APR2013'D)+1;
label Lof="Length of followup (days)";
run;

/* ploting histogram or non-parametric distribution function*/
title1 "Distribution of Length of followup (days) among participants with dementia";
proc univariate data = DT.cohort_FLF(where=(Event_type="Dementia"));
var Lof;
histogram Lof / kernel;
run;


/*Plotting CDF*/
title1 "CDF of followup (days) among participants with dementia";
proc univariate data = DT.cohort_FLF(where=(Event_type="Dementia"));
var Lof;
cdfplot Lof;
run;


Data DT.cohort_FLF;
set DT.cohort_FLF;
If Event_type="Hospitalization more than 90 days" then Hospital_90=1;
else Hospital_90=0;
run;

Data DT.cohort_FLF;
set DT.cohort_FLF;
If Event_type="Dementia" then event_n=1;
If Event_type="Decease" then event_n=2;
If Event_type="Hospitalization more than 90 days" then event_n=3;
If Event_type="End of the study" then event_n=4;
run;


Data DT.cohort_FLF;
set DT.cohort_FLF;
If Event_type="Decease" then Decease=1;
else Decease=0;
run;


/*Plotting survival function*/
/*title1 "Survival function for participants with dementia event";
proc lifetest data=DT.cohort_FLF plots=survival(nocensor atrisk) Outsurv=DT.A;
time Lof*Dementia(0);
run; 

title1 "Survival function for participants with dementia event";
proc lifetest data=DT.cohort_FLF plots=survival(nocensor atrisk) notable;
time Lof*Dementia(0);
run; */



/*Merge LB and LF cohort datasets*/

data DT.coh_FLF_T(Drop= SEX AGE_CAT);
set DT.cohort_FLF;
If SEX="M" then Gender=0;
else Gender=1;
If AGE_CAT="50-55" then Age_cat_n=0;
If AGE_CAT="56-60" then Age_cat_n=1;
If AGE_CAT="61-65" then Age_cat_n=2;
If AGE_CAT="66-70" then Age_cat_n=3;
If AGE_CAT="71-75" then Age_cat_n=4;
If AGE_CAT="76-80" then Age_cat_n=5;
If AGE_CAT="81-85" then Age_cat_n=6;
If AGE_CAT="86 and older" then Age_cat_n=7;
run;


proc format;
value Gender
	  0 = "Male"
	  1 = "Female";
value Age_cat_n
	0= "50-55"
	1= "56-60"
	2= "61-65"
	3= "66-70"
	4= "71-75"
	5= "76-80"
	6= "81-85"
	7= "86 and older";
run;

data DT.coh_FLF_T;
set DT.coh_FLF_T;
format Gender Gender.;
format Age_cat_n Age_cat_n.;
run;

data DT.cohort_All;
merge DT.coh_FLF_T DT.Cohort_flb;
by PHN_ENC;
run;


/*Data exploration Pearson's correlations*/
/*
proc corr data = DT.cohort_All plots=matrix(histogram);
var Lof Gender Age_cat_n Dementia Hospital_90 Car_Arrh Valvular Pul_Circ Hyp_Uncom 
Hyp_com Paralysis Other_Neuro COPD Diabetes Hypothyr Kid_Dis Liv_Dis Pep_Ulcer HIV 
Lymphoma Meta_Cancer WO_Meta Rheum_Collagen Coagulopathy Obesity Weight_Loss 
Flu_Elect Anemia Alcoholism Drug_Abuse Psychoses Depression Dyslipidemia Per_Vascular
Sleep_Dis Atrial_Fib MI Urin_Inc Vis_Imp Hear_Imp Multi_Scler Head_Inj Parkinson
Fall_Injury Tobacco Stro Frailty total_EVisit total_Psych total_non_Psych total_GP 
total_neurolog total_internalmedicine total_psychiatrists FactorMAT FactorSOC QuintMat
QuintSoc TOT_GRP Weighted_Elixhauser;
run;*/



data DT.cohort_All;
set DT.cohort_All;
label Records= "Is there any records in DAD/Claims/Pin/Narcs/Acrs?";
label Hospital_90=" Hospitalization more than 90 days";
label DOB= "Date of birth";
label Death_Date= "Date of Death";
label Dementia_Date= "Date for Dementia Diagnosis";
label Hosp90_date= "Date for hospitalization>90 days";
label AGE_CAT= "Age category";
label event_n= "Event code number(1-4)";
label FYE="Fiscal Year End for pampalon indices";
run;

/**************************************************************************************************/
/******************************Survival Analysis***************************************************/
/*Cox model*/
/***************************************************************************************************/

/*Sex*/
proc phreg data = DT.cohort_All;
class Gender;
model Lof*event_n(2,3,4)= Gender /risklimits;
run;


/*Age*/
proc phreg data = DT.cohort_All;
model Lof*event_n(2,3,4)= Age /risklimits;
run;


/*Age_Cat_n*/
data  DT.cohort_All_age;
set DT.cohort_All;
If AGE_Cat_n=0 then age5055=1; else age5055=0;
If AGE_Cat_n=1 then age5660=1; else age5660=0;
If AGE_Cat_n=2 then age6165=1; else age6165=0;
If AGE_Cat_n=3 then age6670=1; else age6670=0;
If AGE_Cat_n=4 then age7175=1; else age7175=0;
If AGE_Cat_n=5 then age7680=1; else age7680=0;
If AGE_Cat_n=6 then age8185=1; else age8185=0;
If AGE_Cat_n=7 then age86older=1; else age86older=0;
run;

/******************************/
data DT.cohort_All;
set DT.cohort_All;
label AGE_Cat_n= "Age Category (0-7)";
run;

proc phreg data = DT.cohort_All;
class AGE_Cat_n (ref="50-55");
model Lof*event_n(2,3,4)= AGE_Cat_n /risklimits;
run;

proc phreg data = DT.cohort_All_age;
class age5055;
model Lof*event_n(2,3,4)= age5660 age6165 age6670 age7175 age7680 age8185 age86older /risklimits;
run;

/******************************/

/*TOT_GRP*/
data DT.cohort_All;
set DT.cohort_All;
label TOT_GRP= "Total Elixhauser Groups per record- range(1 to 29)";
run;

proc phreg data = DT.cohort_All;
model Lof*event_n(2,3,4) = TOT_GRP/risklimits;
run;


data  DT.cohort_All_Tot_GRP;
set DT.cohort_All;
If TOT_GRP=0 then GRP_0=1; else GRP_0=0;
If TOT_GRP=1 then GRP_1=1; else GRP_1=0;
If TOT_GRP=2 then GRP_2=1; else GRP_2=0;
If TOT_GRP=3 then GRP_3=1; else GRP_3=0;
If TOT_GRP=4 then GRP_4=1; else GRP_4=0;
If TOT_GRP>=5 then GRP_5over=1; else GRP_5over=0;
where TOT_GRP~=.;
run;

proc phreg data = DT.cohort_All_Tot_GRP;
class GRP_0;
model Lof*event_n(2,3,4)= GRP_1 GRP_2 GRP_3 GRP_4 GRP_5over /risklimits;
run;


/*Weighted Elixhauser*/
proc phreg data = DT.cohort_All;
model Lof*event_n(2,3,4) = Weighted_Elixhauser/risklimits;
run;


data  DT.cohort_All_Tot_GRP;
set DT.cohort_All;
If Weighted_Elixhauser<=-4 then W_Elx_less_m4=1; else W_Elx_less_m4=0;
If Weighted_Elixhauser=-3 then W_Elx_m3=1; else W_Elx_m3=0;
If Weighted_Elixhauser=-2 then W_Elx_m2=1; else W_Elx_m2=0;
If Weighted_Elixhauser=-1 then W_Elx_m1=1; else W_Elx_m1=0;
If Weighted_Elixhauser=0 then W_Elx_0=1; else W_Elx_0=0;
If Weighted_Elixhauser=1 then W_Elx1=1; else W_Elx1=0;
If Weighted_Elixhauser=2 then W_Elx2=1; else W_Elx2=0;
If Weighted_Elixhauser=3 then W_Elx3=1; else W_Elx3=0;
If Weighted_Elixhauser>=4 then W_Elx_greater4=1; else W_Elx_greater4=0;
where Weighted_Elixhauser~=.;
run;

proc phreg data = DT.cohort_All_Tot_GRP;
class W_Elx_less_m4;
model Lof*event_n(2,3,4)= W_Elx_m3 W_Elx_m2 W_Elx_m1 W_Elx_0 W_Elx1 W_Elx2 W_Elx3 W_Elx_greater4 /risklimits;
run;

/*total_EVisit: Total number of unplanned emergency department visits*/

data DT.cohort_All;
set DT.cohort_All;
label total_EVisit= "Total number of unplanned emergency department visits";
run;

data  cohort_All_total_EVisit;
set DT.cohort_All;
If total_EVisit>0 then EVisit_more1=1;
Else EVisit_more1=0;
where total_EVisit~=.;
run;

proc phreg data = cohort_All_total_EVisit;
model Lof*event_n(2,3,4) = EVisit_more1/risklimits;
run;


/*total_Psych*/

data DT.cohort_All;
set DT.cohort_All;
label total_Psych= "Total number hospitalizations to psychiatric facility";
run;

data  cohort_All_Psych;
set DT.cohort_All;
If total_Psych>0 then total_Psych_more1=1;
Else total_Psych_more1=0;
where total_Psych~=.;
run;


proc phreg data = cohort_All_Psych;
model Lof*event_n(2,3,4) = total_Psych_more1/risklimits;
run;



/*total_non_Psych*/

data DT.cohort_All;
set DT.cohort_All;
label total_non_Psych= "Total number hospitalizations to non-psychiatric facility ";
run;

data  cohort_All_total_nonPsych;
set DT.cohort_All;
If total_non_Psych>0 then total_nonPsych_more1=1;
Else total_nonPsych_more1=0;
where total_non_Psych~=.;
run;

proc phreg data = cohort_All_total_nonPsych;
model Lof*event_n(2,3,4) = total_nonPsych_more1/risklimits;
run;


/*total_neurolog*/

data DT.cohort_All;
set DT.cohort_All;
label total_neurolog= "Total number of visits by neurologists";
run;


data  cohort_All_total_neurolog;
set DT.cohort_All;
If total_neurolog>0 then total_neurolog_more1=1;
Else total_neurolog_more1=0;
where total_neurolog~=.;
run;

proc phreg data = cohort_All_total_neurolog;
model Lof*event_n(2,3,4) = total_neurolog_more1/risklimits;
run;


/*total_internalmedicine*/

data DT.cohort_All;
set DT.cohort_All;
label total_internalmedicine= "Total number of visits by general internal medicine or internal medicine specialists";
run;

data cohort_total_internalmedicine;
set DT.cohort_All;
If total_internalmedicine>0 then internalmedicine_more1=1;
Else internalmedicine_more1=0;
where total_internalmedicine~=.;
run;

proc phreg data = cohort_total_internalmedicine;
model Lof*event_n(2,3,4) = internalmedicine_more1/risklimits;
run;

/*total_psychiatrists*/

data DT.cohort_All;
set DT.cohort_All;
label total_psychiatrists= "Total number of visits by psychiatrists";
run;

data cohort_total_psychiatrists;
set DT.cohort_All;
If total_psychiatrists>0 then psychiatrists_more1=1;
Else psychiatrists_more1=0;
where total_psychiatrists~=.;
run;

proc phreg data = cohort_total_psychiatrists;
model Lof*event_n(2,3,4) = psychiatrists_more1/risklimits;
run;

/*total_GP*/
data DT.cohort_All;
set DT.cohort_All;
label total_GP= "Total number of family physician visits ";
run;

data cohort_total_GP;
set DT.cohort_All;
If total_GP>0 then GP_more1=1;
Else GP_more1=0;
where total_GP~=.;
run;

proc phreg data = cohort_total_GP;
model Lof*event_n(2,3,4) = GP_more1/risklimits;
run;


/*FactorMAT*/

data DT.cohort_All;
set DT.cohort_All;
label FactorMAT= "Material deprivation score";
run;

proc phreg data = DT.cohort_All;
model Lof*event_n(2,3,4) = FactorMAT/risklimits;
run;

/*FactorSOC*/

data DT.cohort_All;
set DT.cohort_All;
label FactorSOC= "Social deprivation score";
run;

proc phreg data = DT.cohort_All;
model Lof*event_n(2,3,4) = FactorSOC/risklimits;
run;


/*QuintMat*/
data DT.cohort_All;
set DT.cohort_All;
label QuintMat= "Material deprivation index";
run;

proc phreg data = DT.cohort_All;
class QuintMat (ref="0");
model Lof*event_n(2,3,4) = QuintMat/risklimits;
run;


/*QuintSoc*/
data DT.cohort_All;
set DT.cohort_All;
label QuintSoc= "Social deprivation index";
run;

proc phreg data = DT.cohort_All;
class QuintSoc (ref="0");
model Lof*event_n(2,3,4) = QuintSoc/risklimits;
run;


/*****************Cox model for Medical/ Mental Health Diagnoses**************************/
/*Delirium*/
proc phreg data = DT.cohort_All;
class Delirium;
model Lof*event_n(2,3,4)= Delirium /risklimits;
run;

/*Congestive Heart Failure*/
data DT.cohort_All;
set DT.cohort_All;
label Cong_Heart_Failure= "Congestive Heart Failure";
run;

proc phreg data = DT.cohort_All;
class Cong_Heart_Failure;
model Lof*event_n(2,3,4)= Cong_Heart_Failure /risklimits;
run;


/*Cardiac Arrhythmia*/
data DT.cohort_All;
set DT.cohort_All;
label Car_Arrh= "Cardiac Arrhythmia";
run;

proc phreg data = DT.cohort_All;
class Car_Arrh;
model Lof*event_n(2,3,4)= Car_Arrh /risklimits;
run;


/*Valvular disease*/
data DT.cohort_All;
set DT.cohort_All;
label Valvular= "Valvular disease";
run;

proc phreg data = DT.cohort_All;
class Valvular;
model Lof*event_n(2,3,4)= Valvular /risklimits;
run;

/*Pulmonary Circulation Disorders*/
data DT.cohort_All;
set DT.cohort_All;
label Pul_Circ= "Pulmonary Circulation Disorders";
run;

proc phreg data = DT.cohort_All;
class Pul_Circ;
model Lof*event_n(2,3,4)= Pul_Circ /risklimits;
run;


/*Peripheral Vascular Disorders*/
data DT.cohort_All;
set DT.cohort_All;
label Per_Vascular= "Peripheral Vascular Disorders";
run;

proc phreg data = DT.cohort_All;
class Per_Vascular;
model Lof*event_n(2,3,4)= Per_Vascular /risklimits;
run;


/*Hypertension, Uncomplicated*/
data DT.cohort_All;
set DT.cohort_All;
label Hyp_Uncom= "Hypertension, Uncomplicated";
run;

proc phreg data = DT.cohort_All;
class Hyp_Uncom;
model Lof*event_n(2,3,4)= Hyp_Uncom /risklimits;
run;

/*Hypertension, Complicated*/
data DT.cohort_All;
set DT.cohort_All;
label Hyp_com= "Hypertension, Complicated";
run;

proc phreg data = DT.cohort_All;
class Hyp_com;
model Lof*event_n(2,3,4)= Hyp_com /risklimits;
run;


/*Paralysis*/
data DT.cohort_All;
set DT.cohort_All;
label Paralysis= "Paralysis";
run;

proc phreg data = DT.cohort_All;
class Paralysis;
model Lof*event_n(2,3,4)= Paralysis /risklimits;
run;


/*Other Neurological Disorders*/
data DT.cohort_All;
set DT.cohort_All;
label Other_Neuro= "Other Neurological Disorders";
run;

proc phreg data = DT.cohort_All;
class Other_Neuro;
model Lof*event_n(2,3,4)= Other_Neuro /risklimits;
run;



/*Chronic Obstructive Pulmonary Disease/ COPD*/
data DT.cohort_All;
set DT.cohort_All;
label COPD= "Chronic Obstructive Pulmonary Disease/ COPD";
run;

proc phreg data = DT.cohort_All;
class COPD;
model Lof*event_n(2,3,4)= COPD /risklimits;
run;


/*Diabetes Mellitus */
data DT.cohort_All;
set DT.cohort_All;
label Diabetes= "Diabetes Mellitus ";
run;

proc phreg data = DT.cohort_All;
class Diabetes;
model Lof*event_n(2,3,4)= Diabetes /risklimits;
run;


/*Hypothyroidism */
data DT.cohort_All;
set DT.cohort_All;
label Hypothyr= "Hypothyroidism";
run;

proc phreg data = DT.cohort_All;
class Hypothyr;
model Lof*event_n(2,3,4)= Hypothyr /risklimits;
run;


/*Renal Failure / Kidney Disease*/
data DT.cohort_All;
set DT.cohort_All;
label Kid_Dis= "Renal Failure / Kidney Disease";
run;

proc phreg data = DT.cohort_All;
class Kid_Dis;
model Lof*event_n(2,3,4)= Kid_Dis /risklimits;
run;


/*Liver Disease*/
data DT.cohort_All;
set DT.cohort_All;
label Liv_Dis= "Liver Disease";
run;

proc phreg data = DT.cohort_All;
class Liv_Dis;
model Lof*event_n(2,3,4)= Liv_Dis /risklimits;
run;


/*Peptic Ulcer Disease Excluding Bleeding*/
data DT.cohort_All;
set DT.cohort_All;
label Pep_Ulcer= "Peptic Ulcer Disease Excluding Bleeding";
run;

proc phreg data = DT.cohort_All;
class Pep_Ulcer;
model Lof*event_n(2,3,4)= Pep_Ulcer /risklimits;
run;


/*AIDS/HIV*/
data DT.cohort_All;
set DT.cohort_All;
label HIV= "AIDS/HIV";
run;

proc phreg data = DT.cohort_All;
class HIV;
model Lof*event_n(2,3,4)= HIV /risklimits;
run;


/*Lymphoma*/
data DT.cohort_All;
set DT.cohort_All;
label Lymphoma= "Lymphoma";
run;

proc phreg data = DT.cohort_All;
class Lymphoma;
model Lof*event_n(2,3,4)= Lymphoma /risklimits;
run;


/*Metastatic Cancer*/
data DT.cohort_All;
set DT.cohort_All;
label Meta_Cancer= "Metastatic Cancer";
run;

proc phreg data = DT.cohort_All;
class Meta_Cancer;
model Lof*event_n(2,3,4)= Meta_Cancer /risklimits;
run;


/*Solid Tumor Without Metastasis*/
data DT.cohort_All;
set DT.cohort_All;
label WO_Meta= "Solid Tumor Without Metastasis";
run;

proc phreg data = DT.cohort_All;
class WO_Meta;
model Lof*event_n(2,3,4)= WO_Meta /risklimits;
run;



/*Rheumatoid arthritis/ Collagen Vascular Diseases*/
data DT.cohort_All;
set DT.cohort_All;
label Rheum_Collagen= "Rheumatoid arthritis/ Collagen Vascular Diseases";
run;

proc phreg data = DT.cohort_All;
class Rheum_Collagen;
model Lof*event_n(2,3,4)= Rheum_Collagen /risklimits;
run;


/*Coagulopathy*/
data DT.cohort_All;
set DT.cohort_All;
label Coagulopathy= "Coagulopathy";
run;

proc phreg data = DT.cohort_All;
class Coagulopathy;
model Lof*event_n(2,3,4)= Coagulopathy /risklimits;
run;


/*Obesity*/
data DT.cohort_All;
set DT.cohort_All;
label Obesity= "Obesity";
run;

proc phreg data = DT.cohort_All;
class Obesity;
model Lof*event_n(2,3,4)= Obesity /risklimits;
run;


/*Weight Loss*/
data DT.cohort_All;
set DT.cohort_All;
label Weight_Loss= "Weight Loss";
run;

proc phreg data = DT.cohort_All;
class Weight_Loss;
model Lof*event_n(2,3,4)= Weight_Loss /risklimits;
run;



/*Fluid and Electrolyte Disorders*/
data DT.cohort_All;
set DT.cohort_All;
label Flu_Elect= "Fluid and Electrolyte Disorders";
run;

proc phreg data = DT.cohort_All;
class Flu_Elect;
model Lof*event_n(2,3,4)= Flu_Elect /risklimits;
run;


/*Anemia*/
data DT.cohort_All;
set DT.cohort_All;
label Anemia= "Anemia";
run;

proc phreg data = DT.cohort_All;
class Anemia;
model Lof*event_n(2,3,4)= Anemia /risklimits;
run;



/*Alcoholism/ Alcohol abuse*/
data DT.cohort_All;
set DT.cohort_All;
label Alcoholism= "Alcoholism/ Alcohol abuse";
run;

proc phreg data = DT.cohort_All;
class Alcoholism;
model Lof*event_n(2,3,4)= Alcoholism /risklimits;
run;



/*Drug Abuse*/
data DT.cohort_All;
set DT.cohort_All;
label Drug_Abuse= "Drug Abuse";
run;

proc phreg data = DT.cohort_All;
class Drug_Abuse;
model Lof*event_n(2,3,4)= Drug_Abuse /risklimits;
run;


/*Psychoses/ Schizophrenia/ Psychotic Disorders*/
data DT.cohort_All;
set DT.cohort_All;
label Psychoses= "Psychoses/ Schizophrenia/ Psychotic Disorders";
run;

proc phreg data = DT.cohort_All;
class Psychoses;
model Lof*event_n(2,3,4)= Psychoses /risklimits;
run;


/*Dyslipidemia*/
data DT.cohort_All;
set DT.cohort_All;
label Dyslipidemia= "Dyslipidemia";
run;

proc phreg data = DT.cohort_All;
class Dyslipidemia;
model Lof*event_n(2,3,4)= Dyslipidemia /risklimits;
run;


/*Depression/ Mood Disorders*/
data DT.cohort_All;
set DT.cohort_All;
label Depression= "Depression/ Mood Disorders";
run;

proc phreg data = DT.cohort_All;
class Depression;
model Lof*event_n(2,3,4)= Depression /risklimits;
run;


/*Sleep Disorders*/
data DT.cohort_All;
set DT.cohort_All;
label Sleep_Dis= "Sleep Disorders";
run;

proc phreg data = DT.cohort_All;
class Sleep_Dis;
model Lof*event_n(2,3,4)= Sleep_Dis /risklimits;
run;


/************Atrial Fibrillation just labeling*********************/
data DT.cohort_All;
set DT.cohort_All;
label Atrial_Fib= "Atrial Fibrillation";
run;
/**************************************************/
/*Ischemic Heart Disease/ MI (angina, myocardial infarction)*/
data DT.cohort_All;
set DT.cohort_All;
label MI= "Ischemic Heart Disease/ MI (angina, myocardial infarction)";
run;

proc phreg data = DT.cohort_All;
class MI;
model Lof*event_n(2,3,4)= MI /risklimits;
run;


/*Urinary Incontinence*/
data DT.cohort_All;
set DT.cohort_All;
label Urin_Inc= "Urinary Incontinence";
run;

proc phreg data = DT.cohort_All;
class Urin_Inc;
model Lof*event_n(2,3,4)= Urin_Inc /risklimits;
run;

/*Visual Impairment*/
data DT.cohort_All;
set DT.cohort_All;
label Vis_Imp= "Visual Impairment";
run;

proc phreg data = DT.cohort_All;
class Vis_Imp;
model Lof*event_n(2,3,4)= Vis_Imp /risklimits;
run;


/*Hearing Impairment*/
data DT.cohort_All;
set DT.cohort_All;
label Hear_Imp= "Hearing Impairment";
run;

proc phreg data = DT.cohort_All;
class Hear_Imp;
model Lof*event_n(2,3,4)= Hear_Imp /risklimits;
run;


/*Multiple Sclerosis*/
data DT.cohort_All;
set DT.cohort_All;
label Multi_Scler= "Multiple Sclerosis";
run;

proc phreg data = DT.cohort_All;
class Multi_Scler;
model Lof*event_n(2,3,4)= Multi_Scler /risklimits;
run;


/*Stroke*/
data DT.cohort_All;
set DT.cohort_All;
label Stro= "Stroke";
run;

proc phreg data = DT.cohort_All;
class Stro;
model Lof*event_n(2,3,4)= Stro /risklimits;
run;


/*Traumatic Brain Injury/ Head Injury*/
data DT.cohort_All;
set DT.cohort_All;
label Head_Inj= "Traumatic Brain Injury/ Head Injury";
run;

proc phreg data = DT.cohort_All;
class Head_Inj;
model Lof*event_n(2,3,4)= Head_Inj /risklimits;
run;


/*Parkinson’s Disease*/
data DT.cohort_All;
set DT.cohort_All;
label Parkinson= "Parkinson’s Disease ";
run;

proc phreg data = DT.cohort_All;
class Parkinson;
model Lof*event_n(2,3,4)= Parkinson /risklimits;
run;

/*Fall- related injury*/
data DT.cohort_All;
set DT.cohort_All;
label Fall_Injury= "Fall- related injury";
run;

proc phreg data = DT.cohort_All;
class Fall_Injury;
model Lof*event_n(2,3,4)= Fall_Injury /risklimits;
run;


/*Tobacco Use*/
data DT.cohort_All;
set DT.cohort_All;
label Tobacco= "Tobacco Use";
run;

proc phreg data = DT.cohort_All;
class Tobacco;
model Lof*event_n(2,3,4)= Tobacco /risklimits;
run;


