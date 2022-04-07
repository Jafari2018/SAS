*Setting the directory;
libname DT "C:\Users\behnaz.jafari1\Desktop\Dementia\Merging data\Data"; 
libname X XLSX "C:\Users\behnaz.jafari1\Desktop\Dementia\Merging data\Drug_ID.xlsx";

***************************************************************************************************************;
***************************************************************************************************************;
/*Elixhauser Dad**Elixhauser Dad**Elixhauser Dad**Elixhauser Dad**Elixhauser Dad**Elixhauser Dad**Elixhauser Dad***/
data DT.elix_dadclaims_0813(keep= PHN_ENC SEX AGE_CAT DOB DXCODE: HLTH_DX_ICD9X_CODE:);
set DT.Dad_5yrlb DT.Claims_5yrlb;
run;


/*Proc SQL;
  Create Table DT.elix_dadclaims_0813 as 
    Select a.*
    From DT.elix_dadclaims_0813 as a
    Where a.PHN_ENC in (select PHN_ENC from DT.PHN_listLB);
quit;*/

proc sort data=DT.elix_dadclaims_0813; 
by PHN_ENC; 
run;

proc sql;
create table DT.elix_dadclaims_0813 as
select *,count(PHN_ENC) as count
from DT.elix_dadclaims_0813
group by PHN_ENC;
quit;


data DT.elix_dadclaims_0813(drop=i DXC1-DXC25 HLTC:);
  set DT.elix_dadclaims_0813;
/*  set up array for individual ELX group counters */
   array ELX_GRP (29) ELX_GRP_1 - ELX_GRP_29;
   array DC (25) $ DXC1-DXC25;
   array HD (3) $ HLTC1 - HLTC3;
   /*end_rec=count;*/

   DXC1=DXCODE1; DXC2=DXCODE2;DXC3=DXCODE3;DXC4=DXCODE4;DXC5=DXCODE5;DXC6=DXCODE6;DXC7=DXCODE7;DXC8=DXCODE8;
   DXC9=DXCODE9;DXC10=DXCODE10;DXC11=DXCODE11;DXC12=DXCODE12;DXC13=DXCODE13;DXC14=DXCODE14;DXC15=DXCODE15;
   DXC16=DXCODE16;DXC17=DXCODE17;DXC18=DXCODE18;DXC19=DXCODE19;DXC20=DXCODE20;DXC21=DXCODE21;DXC22=DXCODE22;
   DXC23=DXCODE23;DXC24=DXCODE24;DXC25=DXCODE25;
   HLTC1=HLTH_DX_ICD9X_CODE_1; HLTC2=HLTH_DX_ICD9X_CODE_2; HLTC3=HLTH_DX_ICD9X_CODE_3;
   
   /*  initialize all ELX group counters to zero */
   do i = 1 to 29;
      ELX_GRP(i) = 0;
   end;

   /*  check each patient record for the diagnosis codes in each ELX group. */
   do i = 1 to dim(DC) UNTIL (strip(DC(i))=' ');   /* for each set of diagnoses codes */

         /* Congestive Heart Failure */
         if  (strip(DC(i)) IN: ("I099", "I110", "I130", "I132", "I255", "I420", "I425","1426",
			"1427","1428","I429","P290")|substr(DC(i),1,3) in:("I50","I43")) then ELX_GRP_1 = 1;
            LABEL ELX_GRP_1='Congestive Heart Failure';

         /* Cardiac Arrhythmia */
         If(strip(DC(i))in:("I441", "I442", "I443", "I456", "I459", "R000", "R001","R008", "T821","Z450","Z950")|
			substr(DC(i),1,3) in:("I47","I48","I49")) then ELX_GRP_2 = 1;
            LABEL ELX_GRP_2='Cardiac Arrhythmia';

         /* Valvular Disease */
         if  (strip(DC(i))in:("A520", "I091", "I098", "Q230", "Q231","Q232", "Q233", "Z952","Z953","Z954")|
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
         if  (strip(DC(i)) in:("G041","G801", "G802", "G830","G831","G832","G833","G834","G839")|
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

         /* Diabetes  */
         if (strip(DC(i))in:("E100", "E101", "E109","E110",
			"E111","E119", "E120", "E121", "E129","E130", "E131", "E139", "E140", "E141", "E149","E102",
			"E103", "E104","E105", "E106","E107", "E108","E112", "E113","E114", "E115","E116","E117","E118",
			"E122","E123","E124","E125","E126","E127","E128","E132","E133","E134","E135","E136",
			"E137","E138","E142","E143","E144","E145","E146","E147","E148")) then ELX_GRP_11 = 1;
           LABEL ELX_GRP_11='Diabetes';


         /* Hypothyroidism */
         if (strip(DC(i))in:("E890")|substr(DC(i),1,3) in:("E00","E01","E02","E03")) then ELX_GRP_12 = 1;
           LABEL ELX_GRP_12='Hypothyroidism';

         /* Renal Failure */
         if (strip(DC(i))in:("I120","I131", "N250", "Z490", "Z491", "Z492", "Z940", "Z992")|
			substr(DC(i),1,3) in:("N18", "N19"))then ELX_GRP_13 = 1;
           LABEL ELX_GRP_13='Renal Failure';

         /* Liver Disease */
         if (strip(DC(i))in:("I864", "I982","K711", "K713", "K714","K715", "K717",
			"K760","K762","K763","K764","K765","K766","K767","K768","K769","Z944")|
			substr(DC(i),1,3) in:("B18", "I85", "K70", "K72", "K73", "K74"))
                  then ELX_GRP_14 = 1;
           LABEL ELX_GRP_14='Liver Disease';

         /* Peptic Ulcer Disease excluding bleeding */
         if (strip(DC(i))in:("K257", "K259", "K267", "K269", "K277", "K279", "K287", "K289"))
                  then ELX_GRP_15 = 1;
           LABEL ELX_GRP_15='Peptic Ulcer Disease excluding bleeding';

         /* AIDS/HIV */
         if (substr(DC(i),1,3) in:("B20","B21","B22","B24")) then ELX_GRP_16 = 1;
           LABEL ELX_GRP_16='AIDS/HIV';

         /* Lymphoma */
         if (strip(DC(i))in:("C900","C902")|substr(DC(i),1,3) in:("C81","C82","C83","C84","C85","C88", "C96"))
		then ELX_GRP_17 = 1;
           LABEL ELX_GRP_17='Lymphoma';

         /* Metastatic Cancer */
         if (substr(DC(i),1,3) in:("C77", "C78", "C79", "C80")) then ELX_GRP_18 = 1;
           LABEL ELX_GRP_18='Metastatic Cancer';

         /* Solid Tumor without Metastasis */
         if (substr(DC(i),1,3) in:("C00", "C01","C02","C03","C04","C05","C05","C06","C07","C08","C09","C10",
			"C11","C12","C13","C14","C15","C16","C17","C18","C19","C20","C21","C22","C23","C24","C25","C26",
			"C30","C31","C32","C33","C34","C37","C38","C39","C40","C41","C43","C45","C46","C47","C48","C49",
			"C50","C51","C52","C53","C54","C55","C56","C57","C58","C60","C61","C62","C63","C64","C65","C66",
			"C67","C68","C69","C70","C71","C72","C73","C74","C75","C76","C97"))
                  then ELX_GRP_19 = 1;
           LABEL ELX_GRP_19='Solid Tumor without Metastasis';

         /* Rheumatoid Arthritis/collagen */
         if (strip(DC(i))in:("L940","L941","L943","M120","M123","M310","M311","M312","M313","M461","M468","M469")|
		 	substr(DC(i),1,3) in:("M05","M06","M08","M30","M32","M33","M34","M35","M45"))
			then ELX_GRP_20 = 1;
           LABEL ELX_GRP_20='Rheumatoid Arthritis/collagen';

         /* Coagulopathy */
         if (strip(DC(i))in:("D691","D693","D694","D695","D696")| 
			substr(DC(i),1,3) in:("D65","D66","D67","D68")) then ELX_GRP_21 = 1;
           LABEL ELX_GRP_21='Coagulopathy';

         /* Obesity */
         if (substr(DC(i),1,3) in:("E66")) then ELX_GRP_22 = 1;
           LABEL ELX_GRP_22='Obesity';

         /* Weight Loss */
         if (strip(DC(i))in:("R634")|
			substr(DC(i),1,3) in:("E40","E41","E42","E43","E44","E45","E46","R64"))then ELX_GRP_23 = 1;
           LABEL ELX_GRP_23='Weight Loss';

         /* Fluid and Electrolyte Disorders */
         if (strip(DC(i))in:("E222")|substr(DC(i),1,3) in:("E86","E87")) then ELX_GRP_24 = 1;
           LABEL ELX_GRP_24='Fluid and Electrolyte Disorders';

         /* Anemia */
         if (strip(DC(i))in:("D500","D508","D509")| substr(DC(i),1,3) in:("D51","D52","D53")) then ELX_GRP_25 = 1;
           LABEL ELX_GRP_25='Anemia';

       

         /* Alcohol Abuse */
         if (strip(DC(i))in:("G621","I426","K292","K700","K703","K709","Z502","Z714","Z721")|
			substr(DC(i),1,3) in:("T51","F10","E52")) then ELX_GRP_26 = 1;
           LABEL ELX_GRP_26='Alcohol Abuse';

         /* Drug Abuse */
         if (strip(DC(i))in:("Z715","Z722")|
		 substr(DC(i),1,3) in:("F11","F12","F13","F14","F15","F16","F18","F19"))
                  then ELX_GRP_27 = 1;
           LABEL ELX_GRP_27='Drug Abuse';

         /* Psychoses */
         if (strip(DC(i))in:("F302","F312","F315")|
		 substr(DC(i),1,3) in:("F20","F22","F23","F24","F25","F28","F29"))
                  then ELX_GRP_28 = 1;
           LABEL ELX_GRP_28='Psychoses';

         /* Depression */
         if (strip(DC(i))in:("F204","F313","F314","F315","F341","F412","F432")|substr(DC(i),1,3) in:("F32","F33"))
			then ELX_GRP_29 = 1;
           LABEL ELX_GRP_29='Depression';		   
end;

do i = 1 to dim(HD) UNTIL (strip(HD(i))=' ');/* for each set of diagnoses codes */

         /* Congestive Heart Failure */
         if  (substr(HD(i),1,3) IN: ("398","402","425","428")) then ELX_GRP_1 = 1;
            LABEL ELX_GRP_1='Congestive Heart Failure';

         /* Cardiac Arrhythmia */
         If(substr(HD(i),1,3) IN: ('426','427')) then ELX_GRP_2 = 1;
            LABEL ELX_GRP_2='Cardiac Arrhythmia';

         /* Valvular Disease */
         if  (substr(HD(i),1,3)in:('394','395','396','397','424','746'))
                  then ELX_GRP_3 = 1;
            LABEL ELX_GRP_3='Valvular Disease';

         /* Pulmonary Circulation Disorders */
         if  (substr(HD(i),1,3) in:('415','416','417')) then ELX_GRP_4 = 1;
            LABEL ELX_GRP_4='Pulmonary Circulation Disorders';

         /* Peripheral Vascular Disorders */
         if  (substr(HD(i),1,3) in:('440','441','443','447','557'))
                  then ELX_GRP_5 = 1;
            LABEL ELX_GRP_5='Peripheral Vascular Disorders';

         /* Hypertension Uncomplicated */
         if  (substr(HD(i),1,3) in:("401")) then ELX_GRP_6 = 1;
            LABEL ELX_GRP_6='Hypertension Uncomplicated';

         /* Hypertension Complicated */
         if  (substr(HD(i),1,3) in:('402','403','404','405')) then ELX_GRP_7 = 1;
            LABEL ELX_GRP_7='Hypertension Complicated';

         /* Paralysis */
         if  (substr(HD(i),1,3) in:('334','342','343','344'))
                  then ELX_GRP_8 = 1;
           LABEL ELX_GRP_8='Paralysis';

         /* Other Neurological Disorders */
         if (substr(HD(i),1,3) in:('331','332','333','334','335','336','340','341','345','348'))
			then ELX_GRP_9 = 1;
           LABEL ELX_GRP_9='Other Neurological Disorders';

         /* Chronic Pulmonary Disease */
         if (substr(HD(i),1,3)in:('416','490','491','492','493','494','495','496','500','501','502','503','504','505'))
			then ELX_GRP_10 = 1;
           LABEL ELX_GRP_10='Chronic Pulmonary Disease';

         /* Diabetes  */
         if (substr(HD(i),1,3)in:("250")) then ELX_GRP_11 = 1;
           LABEL ELX_GRP_11='Diabetes';


         /* Hypothyroidism */
         if (substr(HD(i),1,3)in:('240','243','244','246')) then ELX_GRP_12 = 1;
           LABEL ELX_GRP_12='Hypothyroidism';

         /* Renal Failure */
         if (substr(HD(i),1,3)in:('403','585','586','588','V56'))then ELX_GRP_13 = 1;
           LABEL ELX_GRP_13='Renal Failure';

         /* Liver Disease */
         if (substr(HD(i),1,3)in:('070','456','570','571','572','573'))
                  then ELX_GRP_14 = 1;
           LABEL ELX_GRP_14='Liver Disease';

         /* Peptic Ulcer Disease excluding bleeding */
         if (substr(HD(i),1,3)in:('531','532','533','534'))
                  then ELX_GRP_15 = 1;
           LABEL ELX_GRP_15='Peptic Ulcer Disease excluding bleeding';

         /* AIDS/HIV */
         if (substr(HD(i),1,3) in:('042','043','044')) then ELX_GRP_16 = 1;
           LABEL ELX_GRP_16='AIDS/HIV';

         /* Lymphoma */
         if (substr(HD(i),1,3)in:('200','201','202','203'))
		then ELX_GRP_17 = 1;
           LABEL ELX_GRP_17='Lymphoma';

         /* Metastatic Cancer */
         if (substr(HD(i),1,3) in:('196','197','198','199')) then ELX_GRP_18 = 1;
           LABEL ELX_GRP_18='Metastatic Cancer';

         /* Solid Tumor without Metastasis */
         if (substr(HD(i),1,3) in:('140','141','142','143','144','145','146','147','148','149','150','151','152','153','154','155','156','157','158','159', '160','161','162','163','164','165','166','167','168','169', '170','171','172','174','175','176','177','178','179','180', '181', '182','183','184','185','186','187','188','189','190','191','192','193','194','195'))
                  then ELX_GRP_19 = 1;
           LABEL ELX_GRP_19='Solid Tumor without Metastasis';

         /* Rheumatoid Arthritis/collagen */
         if (substr(HD(i),1,3)in:('446','701','710','711','714','719','720','725','728'))
			then ELX_GRP_20 = 1;
           LABEL ELX_GRP_20='Rheumatoid Arthritis/collagen';

         /* Coagulopathy */
         if (substr(HD(i),1,3)in:('286','287')) then ELX_GRP_21 = 1;
           LABEL ELX_GRP_21='Coagulopathy';

         /* Obesity */
         if (substr(HD(i),1,3) in:('278')) then ELX_GRP_22 = 1;
           LABEL ELX_GRP_22='Obesity';

         /* Weight Loss */
         if (substr(HD(i),1,3)in:('260','261','262','263'))then ELX_GRP_23 = 1;
           LABEL ELX_GRP_23='Weight Loss';

         /* Fluid and Electrolyte Disorders */
         if (substr(HD(i),1,3)in:('276')) then ELX_GRP_24 = 1;
           LABEL ELX_GRP_24='Fluid and Electrolyte Disorders';

         /* Anemia */
         if (substr(HD(i),1,3)in:('280','281')) then ELX_GRP_25 = 1;
           LABEL ELX_GRP_25='Anemia';


         /* Alcohol Abuse */
         if (substr(HD(i),1,3)in:('291','303','980')) then ELX_GRP_26 = 1;
           LABEL ELX_GRP_26='Alcohol Abuse';

         /* Drug Abuse */
         if (substr(HD(i),1,3)in:('292','304','305'))
                  then ELX_GRP_27 = 1;
           LABEL ELX_GRP_27='Drug Abuse';

         /* Psychoses */
         if (substr(HD(i),1,3)in:('293','295','297','298'))
                  then ELX_GRP_28 = 1;
           LABEL ELX_GRP_28='Psychoses';

         /* Depression */
         if (substr(HD(i),1,3)in:('296','300','309','311'))
			then ELX_GRP_29 = 1;
           LABEL ELX_GRP_29='Depression';		
end;
run;

PROC SQL;
CREATE Table DT.elix_dadclaims_0813 as   
(SELECT *, max(ELX_GRP_29) as max_ELX_GRP_29, max(ELX_GRP_28) as max_ELX_GRP_28,max(ELX_GRP_27) as max_ELX_GRP_27,
max(ELX_GRP_26) as max_ELX_GRP_26,max(ELX_GRP_25) as max_ELX_GRP_25,max(ELX_GRP_24) as max_ELX_GRP_24,
max(ELX_GRP_23) as max_ELX_GRP_23,max(ELX_GRP_22) as max_ELX_GRP_22,max(ELX_GRP_21) as max_ELX_GRP_21,
max(ELX_GRP_20) as max_ELX_GRP_20,max(ELX_GRP_19) as max_ELX_GRP_19,max(ELX_GRP_18) as max_ELX_GRP_18,
max(ELX_GRP_17) as max_ELX_GRP_17,max(ELX_GRP_16) as max_ELX_GRP_16,max(ELX_GRP_15) as max_ELX_GRP_15,
max(ELX_GRP_14) as max_ELX_GRP_14,max(ELX_GRP_13) as max_ELX_GRP_13,max(ELX_GRP_12) as max_ELX_GRP_12,
max(ELX_GRP_11) as max_ELX_GRP_11,max(ELX_GRP_10) as max_ELX_GRP_10,max(ELX_GRP_9) as max_ELX_GRP_9,
max(ELX_GRP_8) as max_ELX_GRP_8,max(ELX_GRP_7) as max_ELX_GRP_7,max(ELX_GRP_6) as max_ELX_GRP_6,
max(ELX_GRP_5) as max_ELX_GRP_5,max(ELX_GRP_4) as max_ELX_GRP_4,max(ELX_GRP_3) as max_ELX_GRP_3,
max(ELX_GRP_2) as max_ELX_GRP_2,max(ELX_GRP_1) as max_ELX_GRP_1
from DT.elix_dadclaims_0813
group by PHN_ENC);
quit; 

Data DT.elix_dadclaims_0813(drop=max_ELX_GRP_1 max_ELX_GRP_2 max_ELX_GRP_3 max_ELX_GRP_4 max_ELX_GRP_5
max_ELX_GRP_6 max_ELX_GRP_7 max_ELX_GRP_8 max_ELX_GRP_9 max_ELX_GRP_10 max_ELX_GRP_11 max_ELX_GRP_12
max_ELX_GRP_13 max_ELX_GRP_14 max_ELX_GRP_15 max_ELX_GRP_16 max_ELX_GRP_17 max_ELX_GRP_18 max_ELX_GRP_19 max_ELX_GRP_20
max_ELX_GRP_21 max_ELX_GRP_22 max_ELX_GRP_23 max_ELX_GRP_24 max_ELX_GRP_25 max_ELX_GRP_26 max_ELX_GRP_27 
max_ELX_GRP_28 max_ELX_GRP_29);
set DT.elix_dadclaims_0813;
ELX_GRP_1=max_ELX_GRP_1;
ELX_GRP_2=max_ELX_GRP_2;
ELX_GRP_3=max_ELX_GRP_3;
ELX_GRP_4=max_ELX_GRP_4;
ELX_GRP_5=max_ELX_GRP_5;
ELX_GRP_6=max_ELX_GRP_6;
ELX_GRP_7=max_ELX_GRP_7;
ELX_GRP_8=max_ELX_GRP_8;
ELX_GRP_9=max_ELX_GRP_9;
ELX_GRP_10=max_ELX_GRP_10;
ELX_GRP_11=max_ELX_GRP_11;
ELX_GRP_12=max_ELX_GRP_12;
ELX_GRP_13=max_ELX_GRP_13;
ELX_GRP_14=max_ELX_GRP_14;
ELX_GRP_15=max_ELX_GRP_15;
ELX_GRP_16=max_ELX_GRP_16;
ELX_GRP_17=max_ELX_GRP_17;
ELX_GRP_18=max_ELX_GRP_18;
ELX_GRP_19=max_ELX_GRP_19;
ELX_GRP_20=max_ELX_GRP_20;
ELX_GRP_21=max_ELX_GRP_21;
ELX_GRP_22=max_ELX_GRP_22;
ELX_GRP_23=max_ELX_GRP_23;
ELX_GRP_24=max_ELX_GRP_24;
ELX_GRP_25=max_ELX_GRP_25;
ELX_GRP_26=max_ELX_GRP_26;
ELX_GRP_27=max_ELX_GRP_27; 
ELX_GRP_28=max_ELX_GRP_28;
ELX_GRP_29=max_ELX_GRP_29;
run;




Data DT.elix_dadclaims_0813;
set DT.elix_dadclaims_0813;

/*Calculating Elixhauser Index*/

   TOT_GRP = ELX_GRP_1  + ELX_GRP_2  +  ELX_GRP_3  +  ELX_GRP_4  +  ELX_GRP_5  +  ELX_GRP_6  +  ELX_GRP_7  +
             ELX_GRP_8  + ELX_GRP_9  +  ELX_GRP_10 +  ELX_GRP_11 +  ELX_GRP_12 +  ELX_GRP_13 +  ELX_GRP_14 +
             ELX_GRP_15 + ELX_GRP_16 +  ELX_GRP_17 +  ELX_GRP_18 +  ELX_GRP_19 +  ELX_GRP_20 +  ELX_GRP_21 +
             ELX_GRP_22 + ELX_GRP_23 +  ELX_GRP_24 +  ELX_GRP_25 +  ELX_GRP_26 +  ELX_GRP_27 +  ELX_GRP_28 +
             ELX_GRP_29;

/*Weighted Elixhauser index based on Nicolas R. Thompson and Carl van Walraven papaers*/

	Weighted_Elixhauser= (7*ELX_GRP_1  + 5*ELX_GRP_2  -  ELX_GRP_3  +  4*ELX_GRP_4  +  2*ELX_GRP_5  +  0*ELX_GRP_6  +  0*ELX_GRP_7  +
             7*ELX_GRP_8  + 6*ELX_GRP_9  +  3*ELX_GRP_10 +  0*ELX_GRP_11 +  0*ELX_GRP_12 +  5*ELX_GRP_13 +
             11*ELX_GRP_14 + 0*ELX_GRP_15 +  0*ELX_GRP_16 +  9*ELX_GRP_17 +  12*ELX_GRP_18 +  4*ELX_GRP_19 +  0*ELX_GRP_20 +
             3*ELX_GRP_21 - 4*ELX_GRP_22 +  6*ELX_GRP_23 +  5*ELX_GRP_24 -  2*ELX_GRP_25 +  0*ELX_GRP_26 -
             7*ELX_GRP_27 + 0*ELX_GRP_28 -  3*ELX_GRP_29);
     LABEL TOT_GRP ='Total Elixhauser Groups per record- range(1 to 29)';
	 LABEL Weighted_Elixhauser='Weighted Elixhauser Index- range(-17 to +89)';

run;



PROC SORT DATA=DT.elix_dadclaims_0813
 OUT=DT.elix_dadclaims_0813
 NODUPKEY ;
 BY PHN_ENC;
 run;
