*Setting the directory;
libname DT "C:\Users\behnaz.jafari1\Desktop\Dementia\Merging data\Data"; 
libname X XLSX "C:\Users\behnaz.jafari1\Desktop\Dementia\Merging data\Drug_ID.xlsx";
****************************************************************************************************************;
****************************************************************************************************************;
*/Pampalon Index;*/Pampalon Index;*/Pampalon Index;*/Pampalon Index;*/Pampalon Index;*/Pampalon Index;*/Pampalon Index;

*/keeping needed variables;
Data DT.drpd_pmpl_idx0818;
set DT.pmpl_idx_0818;
 keep POSTAL_CODE FYE FactorMAT FactorSOC QuintMat QuintSoc pmono p_s_d_w p_alone income p_employed p_educatio collective coverage PHN_ENC;
run;


*Cleaning PHN;
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
