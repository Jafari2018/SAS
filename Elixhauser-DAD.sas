*Setting the directory;
libname DT "C:\Users\behnaz.jafari1\Desktop\Dementia\Merging data\Data"; 
libname X XLSX "C:\Users\behnaz.jafari1\Desktop\Dementia\Merging data\Drug_ID.xlsx";

***************************************************************************************************************;
***************************************************************************************************************;
/*Elixhauser Dad**Elixhauser Dad**Elixhauser Dad**Elixhauser Dad**Elixhauser Dad**Elixhauser Dad**Elixhauser Dad***/
data DT.elix_dad0818(drop = INST: REGNO SECREGNO MAT_NB_CHT RES: PROVPHN PSYCH_STAT ADMITTIME ENTRYCODE ERDEPTTIME
DISTIME MPSUBSERV DXPREF: DXCLUST: AGE_ADMIT AGE_DISCH MCC CMG: RIW: ELOS ACUTE_DAYS ALC_DAYS ERDEPTDATE DXCLUST: 
TYP_DAYS IN_DAYS SA_DAYS PROC: CHARTNO);
set DT.Dad0818;
run;


DATA DT.elix_dad0818(rename=(BIRTHDATE=DOB));
	set DT.elix_dad0818;
RUN;

*changing dates format and adding D_name column;
data DT.elix_dad0818;
     set DT.elix_dad0818;
     label  DOB="DOB" DISP="DISPOSITION";
	 rename DISP=DISPOSITION;
	 D_name="DAD";
	 DOB_new = input(strip(DOB),YYMMDD8.);
	 format DOB_new YYMMDDD10.;
	 label DOB_new="DOB";
	drop DOB;
	rename DOB_new=DOB;
	ADMIT_new = input(strip(ADMITDATE),YYMMDD8.);
	format ADMIT_new YYMMDDD10.;
	 label ADMIT_new="ADMITDATE";
	drop ADMITDATE;
	rename ADMIT_new=ADMITDATE;
	DISDATE_new = input(strip(DISDATE),YYMMDD8.);
	format DISDATE_new YYMMDDD10.;
	 label DISDATE_new="DISDATE";
	drop DISDATE;
	rename DISDATE_new=DISDATE;
	DXCODE1= input(DXCODE1,$7.);
run;

Data DT.elix_dad0818;
length AGE_CAT $12;
   set DT.elix_dad0818;
	format AGE_CAT $12.;
   informat AGE_CAT $12.;
  where (substr(POSTCODE, 1, 1)="T" & DOB<='31MAR1963'D & strip(PHN_ENC)~= "000000000000");
	 If ('31MAR1958'D < DOB <= '31MAR1963'D) then AGE_CAT="50-55";
	 If ('31MAR1953'D < DOB <='31MAR1958'D) then AGE_CAT="56-60";
	 If ('31MAR1948'D < DOB <='31MAR1953'D) then AGE_CAT="66-70";
	 If ('31MAR1943'D < DOB <='31MAR1948'D) then AGE_CAT="70-75";
	 If ('31MAR1938'D < DOB <='31MAR1943'D) then AGE_CAT="76-80";
	 If ('31MAR1933'D < DOB <='31MAR1938'D) then AGE_CAT="80-85";
	 If (DOB <= '31MAR1933'D) then AGE_CAT="86 and older";
  run;


/*Creating 5 years look back*/
PROC SQL;
	create table DT.elix_dad0813 as
	select *
	from DT.elix_dad0818 as s1
	where '01APR2008'D <= ADMITDATE <= '31MAR2013'D;
QUIT;

Proc SQL;
  Create Table DT.elix_dad0813 as 
    Select a.*
    From DT.elix_dad0813 as a
    Where a.PHN_ENC in (select PHN_ENC from DT.PHN_listLB);
quit;


data DT.elix_dad0813(drop=i);
  set DT.elix_dad0813;
/*  set up array for individual ELX group counters */
   array ELX_GRP (31) ELX_GRP_1 - ELX_GRP_31;
   array DC (25) $ DXC1-DXC25;
   array DT (25) $ DXT1-DXT25;
   /*input (DXC1-DXC25) (: $7.);
   input (DXT1-DXT25) (: $1.);*/

   DXC1=DXCODE1; DXC2=DXCODE2;DXC3=DXCODE3;DXC4=DXCODE4;DXC5=DXCODE5;DXC6=DXCODE6;DXC7=DXCODE7;DXC8=DXCODE8;
   DXC9=DXCODE9;DXC10=DXCODE10;DXC11=DXCODE11;DXC12=DXCODE12;DXC13=DXCODE13;DXC14=DXCODE14;DXC15=DXCODE15;
   DXC16=DXCODE16;DXC17=DXCODE17;DXC18=DXCODE18;DXC19=DXCODE19;DXC20=DXCODE20;DXC21=DXCODE21;DXC22=DXCODE22;
   DXC23=DXCODE23;DXC24=DXCODE24;DXC25=DXCODE25;
   DXT1=DXTYPE1; DXT2=DXTYPE2;DXT3=DXTYPE3;DXT4=DXTYPE4;DXT5=DXTYPE5;DXT6=DXTYPE6;DXT7=DXTYPE7;DXT8=DXTYPE8;
   DXT9=DXTYPE9;DXT10=DXTYPE10;DXT11=DXTYPE11;DXT12=DXTYPE12;DXT13=DXTYPE13;DXT14=DXTYPE14;DXT15=DXTYPE15;
   DXT16=DXTYPE16;DXT17=DXTYPE17;DXT18=DXTYPE18;DXT19=DXTYPE19;DXT20=DXTYPE20;DXT21=DXTYPE21;DXT22=DXTYPE22;
   DXT23=DXTYPE23;DXT24=DXTYPE24;DXT25=DXTYPE25;
   
   /*  initialize all ELX group counters to zero */
   do i = 1 to 31;
      ELX_GRP(i) = 0;
   end;

   /*  check each patient record for the diagnosis codes in each ELX group. */
   do i = 1 to dim(DC) UNTIL (strip(DC(i))=' ');   /* for each set of diagnoses codes */

   /*  skip diagnosis if diagnosis type = "2" */

      if DT(i) ^= '2' then DO;          /* identify Elixhauser groupings */

         /* Congestive Heart Failure */
         if  (strip(DC(i)) IN: ("I099", "I110", "I130", "I132", "I255", "I420", "I425","1426",
			"1427","1428","I429","P290")|substr(DC(i),1,3) in:("I50","I43")) then ELX_GRP_1 = 1;
            LABEL ELX_GRP_1='Congestive Heart Failure';

         /* Cardiac Arrhythmia */
         If(strip(DC(i))in:("I441", "I442", "I443", "I456", "I459", "R000", "R001","R008", "T821","Z450","Z950")|
			substr(DC(i),1,3) in:("I47","I48","I49")) then ELX_GRP_2 = 1;
            LABEL ELX_GRP_2='Cardiac Arrhythmia';

         /* Valvular Disease */
         if  (strip(DC(i))in:("A520", "I091", "I098", "Q230", "Q231","Q232", "Q233", "Z952","Z954")|
		 		substr(DC(i),1,3) in:("I05","I06","I07","I08","I34","I35","I36","I37","I38","I39"))
                  then ELX_GRP_3 = 1;
            LABEL ELX_GRP_3='Valvular Disease';

         /* Pulmonary Circulation Disorders */
         if  (strip(DC(i)) in:("I280"," I288", "I289")|substr(DC(i),1,3) in:("I26", "I27")) then ELX_GRP_4 = 1;
            LABEL ELX_GRP_4='Pulmonary Circulation Disorders';

         /* Peripheral Vascular Disorders */
         if  (strip(DC(i)) in:("I731", "I738", "I739", "I771", "I790", "I792", "K551","K558", "K559", "Z958", "Z959")|
		 		substr(DC(i),1,3) in:("I70", "I71"))
                  then ELX_GRP_5 = 1;
            LABEL ELX_GRP_5='Peripheral Vascular Disorders';

         /* Hypertension Uncomplicated */
         if  (substr(DC(i),1,3) in:("I10")) then ELX_GRP_6 = 1;
            LABEL ELX_GRP_6='Hypertension Uncomplicated';

         /* Hypertension Complicated */
         if  (substr(DC(i),1,3) in:("I11","I13","I15")) then ELX_GRP_7 = 1;
            LABEL ELX_GRP_7='Hypertension Complicated';

         /* Paralysis */
         if  (strip(DC(i)) in:("G041", "G114", "G801", "G802", "G830","G831","G832","G833","G834","G839")|
		 		substr(DC(i),1,3) in:("G81","G82"))
                  then ELX_GRP_8 = 1;
           LABEL ELX_GRP_8='Paralysis';

         /* Other Neurological Disorders */
         if (strip(DC(i)) in:("G254", "G255", "G312", "G318", "G319","G931","G934", "R470")|
			substr(DC(i),1,3) in:("G10","G11","G12","G13","G20","G21","G22","G32","G35","G36","G37","G40","G41","R56"))
			then ELX_GRP_9 = 1;
           LABEL ELX_GRP_9='Other Neurological Disorders';

         /* Chronic Pulmonary Disease */
         if (strip(DC(i))in:("I278", "I279", "J684", "J701", "J703")|substr(DC(i),1,3) in:("J40", "J41",
			"J42", "J43", "J44", "J45","J46", "J47", "J60","J61","J62","J63","J64","J65","J66","J67"))
			then ELX_GRP_10 = 1;
           LABEL ELX_GRP_10='Chronic Pulmonary Disease';

         /* Diabetes Uncomplicated */
         if (strip(DC(i))in:("E100", "E101", "E109","E110",
			"E111","E119", "E120", "E121", "E129","E130", "E131", "E139", "E140", "E141", "E149")) then ELX_GRP_11 = 1;
           LABEL ELX_GRP_11='Diabetes Uncomplicated';

         /* Diabetes Complicated */
         if (strip(DC(i))in:("E102", "E103", "E104","E105", "E106","E107", "E108","E112", "E113","E114", "E115",
			"E116","E117","E118","E122","E123","E124","E125","E126","E127","E128","E132","E133","E134","E135","E136",
			"E137","E138","E142","E143","E144","E145","E146","E147","E148")) then ELX_GRP_12 = 1;
           LABEL ELX_GRP_12='Diabetes Complicated';

         /* Hypothyroidism */
         if (strip(DC(i))in:("E890")|substr(DC(i),1,3) in:("E00","E01","E02","E03")) then ELX_GRP_13 = 1;
           LABEL ELX_GRP_13='Hypothyroidism';

         /* Renal Failure */
         if (strip(DC(i))in:("I120","I131", "N250", "Z490", "Z491", "Z492", "Z940", "Z992")|
			substr(DC(i),1,3) in:("N18", "N19"))then ELX_GRP_14 = 1;
           LABEL ELX_GRP_14='Renal Failure';

         /* Liver Disease */
         if (strip(DC(i))in:("I864", "I982","K711", "K713", "K714","K715", "K717",
			"K760","K762","K763","K764","K765","K766","K767","K768","K769","Z944")|
			substr(DC(i),1,3) in:("B18", "I85", "K70", "K72", "K73", "K74"))
                  then ELX_GRP_15 = 1;
           LABEL ELX_GRP_15='Liver Disease';

         /* Peptic Ulcer Disease excluding bleeding */
         if (strip(DC(i))in:("K257", "K259", "K267", "K269", "K277", "K279", "K287", "K289"))
                  then ELX_GRP_16 = 1;
           LABEL ELX_GRP_16='Peptic Ulcer Disease excluding bleeding';

         /* AIDS/HIV */
         if (substr(DC(i),1,3) in:("B20","B21","B22","B24")) then ELX_GRP_17 = 1;
           LABEL ELX_GRP_17='AIDS/HIV';

         /* Lymphoma */
         if (strip(DC(i))in:("C900","C902")|substr(DC(i),1,3) in:("C81","C82","C83","C84","C85","C88", "C96"))
		then ELX_GRP_18 = 1;
           LABEL ELX_GRP_18='Lymphoma';

         /* Metastatic Cancer */
         if (substr(DC(i),1,3) in:("C77", "C78", "C79", "C80")) then ELX_GRP_19 = 1;
           LABEL ELX_GRP_19='Metastatic Cancer';

         /* Solid Tumor without Metastasis */
         if (substr(DC(i),1,3) in:("C00", "C01","C02","C03","C04","C05","C05","C06","C07","C08","C09","C10",
			"C11","C12","C13","C14","C15","C16","C17","C18","C19","C20","C21","C22","C23","C24","C25","C26",
			"C30","C31","C32","C33","C34","C37","C38","C39","C40","C41","C43","C45","C46","C47","C48","C49",
			"C50","C51","C52","C53","C54","C55","C56","C57","C58","C60","C61","C62","C63","C64","C65","C66",
			"C67","C68","C69","C70","C71","C72","C73","C74","C75","C76","C97"))
                  then ELX_GRP_20 = 1;
           LABEL ELX_GRP_20='Solid Tumor without Metastasis';

         /* Rheumatoid Arthritis/collagen */
         if (strip(DC(i))in:("L940","L941","L943","M120","M123","M310","M311","M312","M313","M461","M468","M469")|
		 	substr(DC(i),1,3) in:("M05","M06","M08","M30","M32","M33","M34","M35","M45"))
			then ELX_GRP_21 = 1;
           LABEL ELX_GRP_21='Rheumatoid Arthritis/collagen';

         /* Coagulopathy */
         if (strip(DC(i))in:("D691","D693","D694","D695","D696")| 
			substr(DC(i),1,3) in:("D65","D66","D67","D68")) then ELX_GRP_22 = 1;
           LABEL ELX_GRP_22='Coagulopathy';

         /* Obesity */
         if (substr(DC(i),1,3) in:("E66")) then ELX_GRP_23 = 1;
           LABEL ELX_GRP_23='Obesity';

         /* Weight Loss */
         if (strip(DC(i))in:("R634")|
			substr(DC(i),1,3) in:("E40","E41","E42","E43","E44","E45","E46","R64"))then ELX_GRP_24 = 1;
           LABEL ELX_GRP_24='Weight Loss';

         /* Fluid and Electrolyte Disorders */
         if (strip(DC(i))in:("E222")|substr(DC(i),1,3) in:("E86","E87")) then ELX_GRP_25 = 1;
           LABEL ELX_GRP_25='Fluid and Electrolyte Disorders';

         /* Blood Loss Anemia */
         if (strip(DC(i))in:("D500")) then ELX_GRP_26 = 1;
           LABEL ELX_GRP_26='Blood Loss Anemia';

         /* Deficiency Anemia */
         if (strip(DC(i))in:("D508","D509")| substr(DC(i),1,3) in:("D51","D52","D53"))then ELX_GRP_27 = 1;
           LABEL ELX_GRP_27='Deficiency Anemia';

         /* Alcohol Abuse */
         if (strip(DC(i))in:("G621","I426","K292","K700","K703","K709","Z502","Z714","Z721")|
			substr(DC(i),1,3) in:("T51","F10","E52")) then ELX_GRP_28 = 1;
           LABEL ELX_GRP_28='Alcohol Abuse';

         /* Drug Abuse */
         if (strip(DC(i))in:("Z715","Z722")|
		 substr(DC(i),1,3) in:("F11","F12","F13","F14","F15","F16","F18","F19"))
                  then ELX_GRP_29 = 1;
           LABEL ELX_GRP_29='Drug Abuse';

         /* Psychoses */
         if (strip(DC(i))in:("F302","F312","F315")|
		 substr(DC(i),1,3) in:("F20","F22","F23","F24","F25","F28","F29"))
                  then ELX_GRP_30 = 1;
           LABEL ELX_GRP_30='Psychoses';

         /* Depression */
         if (strip(DC(i))in:("F204","F313","F314","F315","F341","F412","F432")|substr(DC(i),1,3) in:("F32","F33"))
			then ELX_GRP_31 = 1;
           LABEL ELX_GRP_31='Depression';
		   
   end;
end;

/*Calculating Elixhauser Index*/

   TOT_GRP = ELX_GRP_1  + ELX_GRP_2  +  ELX_GRP_3  +  ELX_GRP_4  +  ELX_GRP_5  +  ELX_GRP_6  +  ELX_GRP_7  +
             ELX_GRP_8  + ELX_GRP_9  +  ELX_GRP_10 +  ELX_GRP_11 +  ELX_GRP_12 +  ELX_GRP_13 +  ELX_GRP_14 +
             ELX_GRP_15 + ELX_GRP_16 +  ELX_GRP_17 +  ELX_GRP_18 +  ELX_GRP_19 +  ELX_GRP_20 +  ELX_GRP_21 +
             ELX_GRP_22 + ELX_GRP_23 +  ELX_GRP_24 +  ELX_GRP_25 +  ELX_GRP_26 +  ELX_GRP_27 +  ELX_GRP_28 +
             ELX_GRP_29 + ELX_GRP_30 +  ELX_GRP_31;

/*Weighted Elixhauser index based on Nicolas R. Thompson and Carl van Walraven papaers*/

	Weighted_Elixhauser= (7*ELX_GRP_1  + 5*ELX_GRP_2  -  ELX_GRP_3  +  4*ELX_GRP_4  +  2*ELX_GRP_5  +  0*ELX_GRP_6  +  0*ELX_GRP_7  +
             7*ELX_GRP_8  + 6*ELX_GRP_9  +  3*ELX_GRP_10 +  0*ELX_GRP_11 +  0*ELX_GRP_12 +  0*ELX_GRP_13 +  5*ELX_GRP_14 +
             11*ELX_GRP_15 + 0*ELX_GRP_16 +  0*ELX_GRP_17 +  9*ELX_GRP_18 +  12*ELX_GRP_19 +  4*ELX_GRP_20 +  0*ELX_GRP_21 +
             3*ELX_GRP_22 - 4*ELX_GRP_23 +  6*ELX_GRP_24 +  5*ELX_GRP_25 -  2*ELX_GRP_26 -  2*ELX_GRP_27 +  0*ELX_GRP_28 -
             7*ELX_GRP_29 + 0*ELX_GRP_30 -  3*ELX_GRP_31);
     LABEL TOT_GRP ='Total Elixhauser Groups per record- range(1 to 31)';
	 LABEL Weighted_Elixhauser='Weighted Elixhauser Index- range(-19 to +89)';

run;


PROC SQL;
CREATE Table DT.elix_dad0813 as   
(SELECT *, max(TOT_GRP) as max_Elixhauser_Ind, min(TOT_GRP) as min_Elixhauser_Ind,
round(mean(TOT_GRP)) as mean_Elixhauser_Ind, max(Weighted_Elixhauser) as max_Weighted_Elixhauser,
min(Weighted_Elixhauser) as min_Weighted_Elixhauser
from DT.elix_dad0813
group by PHN_ENC);
quit; 


PROC SORT DATA=DT.elix_dad0813
 OUT=DT.Elixhauser_0813
 NODUPKEY ;
 BY PHN_ENC;
 run;
