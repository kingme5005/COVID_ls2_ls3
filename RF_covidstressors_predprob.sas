libname home "/home/data/Harvard/king/ls3/covid/new/data/";
libname mc "/home/data/Harvard/Hwang/AAG_Constructs/2019/DATA/";
LIBNAME aagcons "/home/data/Harvard/king/aag_constructs/data2019/" ;
libname svy "/home/data/Harvard/Hwang/STARRSLS/preds_as_of_LS2/DATA/";


options nofmterr formdlim='-' mprint mlogic MINoperator;

PROC IMPORT OUT= _o1
            DATAFILE= "/home/data/Harvard/king/ls3/covid/new/data/ranger_cv_pred_prob_dx1plus.csv"
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
PROC IMPORT OUT= _o2
            DATAFILE= "/home/data/Harvard/king/ls3/covid/new/data/ranger_cv_pred_prob_mde.csv"
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
PROC IMPORT OUT= _o3
            DATAFILE= "/home/data/Harvard/king/ls3/covid/new/data/ranger_cv_pred_prob_gad.csv"
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
PROC IMPORT OUT= _o4
            DATAFILE= "/home/data/Harvard/king/ls3/covid/new/data/ranger_cv_pred_prob_ptsd.csv"
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
PROC IMPORT OUT= _o5
            DATAFILE= "/home/data/Harvard/king/ls3/covid/new/data/ranger_cv_pred_prob_panic.csv"
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
PROC IMPORT OUT= _o6
            DATAFILE= "/home/data/Harvard/king/ls3/covid/new/data/ranger_cv_pred_prob_dxsum.csv"
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

data work1;
	merge 	home.work1
			_o1 (rename=(SL_ranger_2000_3_15_All= cv_pred_prob_dx1plus))
			_o2 (rename=(SL_ranger_2000_3_15_All= cv_pred_prob_mde))
			_o3 (rename=(SL_ranger_2000_3_15_All= cv_pred_prob_gad))
			_o4 (rename=(SL_ranger_2000_3_15_All= cv_pred_prob_ptsd))
			_o5 (rename=(SL_ranger_2000_3_15_All= cv_pred_prob_panic))
			_o6 (rename=(SL_ranger_2000_3_15_All= cv_pred_prob_dxsum));
	by masterid;

	ls3_dx1plus_30=0;
	if sum(ls3d5_covid_mde30, ls3d5_gad30, ls3d5_pts30, ls3d5_covid_rupa30) ge 1 then ls3_dx1plus_30=1;

	cv_pred_prob_dx1plus_z=cv_pred_prob_dx1plus;
	cv_pred_prob_mde_z=cv_pred_prob_mde;
	cv_pred_prob_gad_z=cv_pred_prob_gad;
	cv_pred_prob_ptsd_z=cv_pred_prob_ptsd;
	cv_pred_prob_panic_z=cv_pred_prob_panic;
	cv_pred_prob_dxsum_z=cv_pred_prob_dxsum;

run;

proc standard data=work1 out=work2 mean=0 std=1;
	weight weight_lsw3_norm;
	var cv_pred_prob_dx1plus_z cv_pred_prob_mde_z cv_pred_prob_gad_z cv_pred_prob_ptsd_z cv_pred_prob_panic_z cv_pred_prob_dxsum_z;
run;

PROC EXPORT DATA = work2
            OUTFILE = "/home/data/Harvard/king/ls3/covid/new/data/stressors_pp.dta"
            DBMS = stata
            REPLACE;
run;

ods html file = "/home/data/Harvard/king/ls3/covid/new/tables/ctab/RF_predprob_ak031324.html";
proc corr data=work2 ;
	weight weight_lsw3_norm;
	var cv_pred_prob_dx1plus_z cv_pred_prob_mde_z cv_pred_prob_gad_z cv_pred_prob_ptsd_z cv_pred_prob_panic_z;
run;
proc means data=work2 mean std p25 p75 maxdec=3; 
	weight weight_lsw3_norm;
	var cv_pred_prob_dx1plus_z cv_pred_prob_dx1plus
		cv_pred_prob_mde_z cv_pred_prob_mde
		cv_pred_prob_gad_z cv_pred_prob_gad
		cv_pred_prob_ptsd_z cv_pred_prob_ptsd
		cv_pred_prob_panic_z cv_pred_prob_panic
		cv_pred_prob_dxsum_z cv_pred_prob_dxsum;
run;
proc surveymeans data=work2 mean stderr  min max ; 
	weight weight_lsw3_norm;
	strata sestrat;
	cluster secluster;
	var cv_pred_prob_dx1plus_z cv_pred_prob_dx1plus
		cv_pred_prob_mde_z cv_pred_prob_mde
		cv_pred_prob_gad_z cv_pred_prob_gad
		cv_pred_prob_ptsd_z cv_pred_prob_ptsd
		cv_pred_prob_panic_z cv_pred_prob_panic
		cv_pred_prob_dxsum_z cv_pred_prob_dxsum;
run;
ods html close;

