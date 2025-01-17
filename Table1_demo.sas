libname home "/home/data/Harvard/king/ls3/covid/new/data/";
libname ls2 "/home/data/Harvard/king/ls2/first/data/" ;
libname master "/home/data/VARIABLES/APDS_VARS/AAGtoUM/Dec2019/";
LIBNAME hdata "/home/data/Harvard/Hwang/STARRSLS/Separation/DATA/";
libname ls3 "/home/data/ArmySTARRS/LSW3/DataDelivery/Replicate 1-14/";
options nofmterr formdlim="-" mlogic mprint;

data ls3_data;
	set ls3.starrslsw3_rep1_14_20220221;

	*ls2 status;
	if pl_w2milstatus in (1,2) then ls2_milstatus=1; *active duty;
	else if pl_w2milstatus in (3,5) then ls2_milstatus=2;*activated Reserve;
	else if pl_w2milstatus eq 4 then ls2_milstatus=3;*activated Guard;
	else if pl_w2milstatus in (6,8) then ls2_milstatus=4;*not active Reserve;
	else if pl_w2milstatus eq 7 then ls2_milstatus=5;*not active Guard;
	else if 9 le pl_w2milstatus le 14 then ls2_milstatus=6;*separated/retired;
	*go back to ls1 status for missings;
	else if pl_w1milstatus in (1,2) then ls2_milstatus=1; *active duty;
	else if pl_w1milstatus in (3,5) then ls2_milstatus=2;*activated Reserve;
	else if pl_w1milstatus eq 4 then ls2_milstatus=3;*activated Guard;
	else if pl_w1milstatus in (6,8) then ls2_milstatus=4;*not active Reserve;
	else if pl_w1milstatus eq 7 then ls2_milstatus=5;*not active Guard;
	else if 9 le pl_w1milstatus le 14 then ls2_milstatus=6;*separated/retired;

	ls2_milstatus2=ls2_milstatus;
	if ls2_milstatus eq 4 then ls2_milstatus2=2;*combine Reserve active vs not;
	if ls2_milstatus eq 5 then ls2_milstatus2=3;*combine Guard active vs not;

	keep masterid ls2_milstatus: ;
	proc sort; by masterid;
run;

*all observations and SA variables from LS2;
data ls2_data;
	set hdata.ls2_surveydata;

	date_ls2=mdy(input(substr(SurveyStartDate, 3, 2), 8.),input(substr(SurveyStartDate, 1, 2), 8.),input(substr(SurveyStartDate, 5, 4), 8.)); 

	non_hetero=0;
	if sn_orientation in (2,3) then non_hetero=1;

	*current marital status;
	if sn_maritalstatus eq 1 then mhx_cat=1;*currently married;
	if sn_maritalstatus eq 2 then mhx_cat=2;*never married;
	if sn_maritalstatus in (3,4,5) then mhx_cat=3;*previously married (divorced, separated, widowed);

	keep 	masterid 
			date_ls2 non_hetero mhx_cat;
	proc sort; by masterid;
run;

data master_constructs;
	merge 	master.MAST_CONSTRUCTS_aag_new_2019 (in=a)
			ls2_data (keep=masterid date_ls2);
	by masterid;
	if a;

	if year_month_key gt date_ls2 then delete;
	keep 		masterid year_month_key dob
				mast_pm_v301 mast_pm_v325
				mast_pm_v313
				mast_pm_v327
				mast_pm_v318
				mast_pm_v003 mast_pm_v004 mast_pm_v005 mast_pm_v006 mast_pm_v007 mast_pm_v008
				mast_pm_v010 			
				mast_pm_v017 mast_pm_v025
				mast_pm_v026 mast_pm_v027 mast_pm_v028 mast_pm_v029  mast_pm_v030 mast_pm_v035

				mast_pm_v036 mast_pm_v037 mast_pm_v038 mast_pm_v039
				mast_pm_v040 mast_pm_v041 mast_pm_v042 mast_pm_v043 mast_pm_v306
				mast_pm_v054 mast_pm_v055

				deer_pm_v001 deer_pm_v084 deer_pm_v083
				deer_pm_v113-deer_pm_v122 deer_pm_v096-deer_pm_v107
				mast_pm_v309
				deployed_wot;
	proc sort; by masterid year_month_key;
run;

*set to last month in master constructs before LS2;
*regular army;
data master_constructs1;
	set master_constructs (where=(mast_pm_v325>=1));
	by masterid;
	if last.masterid then output;
run;
*activated g/r;
data master_constructs2;
	set master_constructs (where=(mast_pm_v301=1));
	by masterid;
	if last.masterid then output;
run;
data master_constructs;
	set master_constructs1
		master_constructs2;

	if mast_pm_v026 eq 1 or mast_pm_v027 eq 1 or mast_pm_v028 eq 1 then ed_cat=1;*GED or equivalent;
	if mast_pm_v029 eq 1 then ed_cat=2;*HS diploma;
	if mast_pm_v030 eq 1 then ed_cat=3;*some college;
	if mast_pm_v035 eq 1 then ed_cat=4;*college+;

	*admin marital status;
	mhx_catb=0;
	if deer_pm_v001 eq 1 then mhx_catb=1;*currently;
	else if deer_pm_v083 eq 1 then mhx_catb=2;*never;
	else if deer_pm_v084 eq 1 then mhx_catb=3;*previously;

	active_years=int(mast_pm_v313/12);

	keep 	masterid year_month_key
			dob ed_cat active_years mhx_catb;
	rename 	year_month_key=last_active_date_MC;
	proc sort nodupkey; by masterid;
run;


data work1;
	merge 	home.work1 (in=a)
			master_constructs
			ls2_data
			ls3_data;
	by masterid;
	if a=1;

run;

data work1;
	set 	work1;

	ls3_dx1plus_30=0;
	if sum(ls3d5_covid_mde30, ls3d5_gad30, ls3d5_pts30, ls3d5_covid_rupa30) ge 1 then ls3_dx1plus_30=1;

	ls3_dxsum_30= sum(ls3d5_covid_mde30, ls3d5_gad30, ls3d5_pts30, ls3d5_covid_rupa30);

	ls2_dx1plus_30=0;
	if sum(ls2d5_mde30, ls2d5_gad30, ls2d5_pts30, ls2_covid_rupa30) ge 1 then ls2_dx1plus_30=1;

	ls2_dx2plus_30=0;
	if sum(ls2d5_mde30, ls2d5_gad30, ls2d5_pts30, ls2_covid_rupa30) ge 2 then ls2_dx2plus_30=1;

	dx1plus30_diff=ls3_dx1plus_30-ls2_dx1plus_30;

	age_ls2=intck('year', dob, date_ls2);

	if rank_e1e4 eq 1 then rank_cat=1;
	else if rank_e1e9 eq 1 then rank_cat=2;
	else rank_cat=3;

	if active_years le 2 then active_years_cat=1;
	if active_years in (3,4,5) then active_years_cat=2;
	if 6 le active_years le 9 then active_years_cat=3;
	if active_years ge 10 then active_years_cat=4;

	*years since most recent active duty (as of LS2);
	if ls2_milstatus in (3,4) then years_since_active=intck('year', last_active_date_MC, date_ls2);
	if ls2_milstatus in (1,2) then years_since_active=0; *set active RA and activated G/R to zero;
	if years_since_active le 0 then years_since_cat=1;
	if years_since_active in (1,2) then years_since_cat=2;
	if years_since_active in (3,4) then years_since_cat=3;
	if years_since_active ge 5 then years_since_cat=4;

	

	if age_ls2 le 27 then age_ls2_cat=1;
	if 28 le age_ls2 le 31 then age_ls2_cat=2;
	if 32 le age_ls2 le 36 then age_ls2_cat=3;
	if age_ls2 ge 37 then age_ls2_cat=4;
	array dummyaa (4) 6. age_ls2_cat1-age_ls2_cat4;
	do i=1 to 4;
		dummyaa(i)=0;
	end;
	dummyaa(age_ls2_cat)=1;

	*race/ethnicity;	
	if rhisp eq 1 then race_cat=3;
	else if rblk eq 1 then race_cat=2;
	else if rother eq 1 then race_cat=4;
	else race_cat=1; *white;	
	
	*years of active service ;
	army_time=int(mast_pm_v318/12);
	if army_time le 2 then army_time_cat=1;*bottom code at 1;
	else if army_time le 5 then army_time_cat=2;
	else if army_time le 10 then army_time_cat=3;
	else army_time_cat=4;
	
	if deployed_wot_num ge 2 then deployed_wot_num=2;

	if mhx_cat eq . then mhx_cat=mhx_catb;*set missings to admin data;
	if ed_cat eq . then ed_cat=2;*set missings to HS diploma;
	proc sort; by ls2_milstatus2;
run;
/*
data obs1;
	set work1 (obs=1);
	weightstacked=.05; attempt_12m_lsw_cat=2;
	rank_s=2;mhx_cat=2;edcat_s=3;race_cat=4; 
run;

data work2;
	set work1 obs1;
run;
*/
ods html file = "/home/data/Harvard/king/ls3/covid/new/tables/demo_table_ak031724.html";
*/*;
proc freq data=work1 ;*for missing cell variables;

	tables ls2_milstatus*ls2_milstatus2;
proc freq data=work1 ;*for missing cell variables;
	weight weight_lsw3_norm;
	tables ls2_dx1plus_30*ls3_dx1plus_30;
	tables ls2d5_mde30*ls3d5_covid_mde30;
	tables ls2d5_gad30*ls3d5_gad30;
	tables ls2d5_pts30*ls3d5_pts30;
	tables ls2_covid_rupa30*ls3d5_covid_rupa30;
	by ls2_milstatus2;

proc freq data=work1 ;*for missing cell variables;
	weight weight_lsw3_norm;
	tables mast_pm_v002*ls2_dx1plus_30*ls3_dx1plus_30;
	tables mast_pm_v002*ls3_dx1plus_30*ls2_dx1plus_30;	
	tables ls2_dx1plus_30*mast_pm_v002*ls3_dx1plus_30;
	tables ls2_dx1plus_30*ls3_dx1plus_30*mast_pm_v002;
	tables ls3_dx1plus_30*mast_pm_v002*ls2_dx1plus_30;
	tables ls3_dx1plus_30*ls2_dx1plus_30*mast_pm_v002;
	tables mast_pm_v002*dx1plus30_diff;
	tables ls2_dx1plus_30*mast_pm_v002*dx1plus30_diff;
	
	tables mast_pm_v002*ls2_dx1plus_30;
	tables mast_pm_v002*ls3_dx1plus_30;
run;
proc surveyfreq data=work1;
	weight weight_lsw3_norm;
	strata sestrat;
	cluster secluster;
	tables mast_pm_v002*ls2_dx1plus_30*ls3_dx1plus_30;
proc means data=work1 mean stderr min max maxdec=4;
	weight weight_lsw3_norm;
	var dx1plus30_diff;
	class mast_pm_v002;
run;
proc means data=work1 mean stderr min max maxdec=4;
	weight weight_lsw3_norm;
	var dx1plus30_diff;
	class mast_pm_v002 ls2_dx1plus_30;
run;
proc means data=work1 mean stderr min max maxdec=4;
	weight weight_lsw3_norm;
	var dx1plus30_diff;
	class ls2_dx1plus_30 mast_pm_v002 ;
run;
proc means data=work1 mean stderr min max maxdec=4;
	weight weight_lsw3_norm;
	var age_ls2 active_years years_since_active;
run;
proc means data=work1 median p25 p75;
	weight weight_lsw3_norm;
	var age_ls2 active_years years_since_active;
	class ls2_milstatus2;
run;

proc surveyfreq data=work1 missing;*for missing cell variables;
	weight weight_lsw3_norm;
	strata sestrat;
	cluster secluster;
	tables age_ls2_cat;
	tables mast_pm_v002;	
	tables race_cat;
	tables non_hetero;
	tables ed_cat;
	tables mhx_cat;
	tables deployed_wot_num;
	tables rank_cat;
	tables ls2_milstatus;
	tables active_years_cat;
	tables years_since_cat;

run;
proc surveyfreq data=work1 missing;*for missing cell variables;
	weight weight_lsw3_norm;
	strata sestrat;
	cluster secluster;
	tables ls2_milstatus2*age_ls2_cat/ row wchisq;
	tables ls2_milstatus2*mast_pm_v002/ row wchisq;	
	tables ls2_milstatus2*race_cat/ row wchisq;
	tables ls2_milstatus2*non_hetero/ row wchisq;
	tables ls2_milstatus2*ed_cat/ row wchisq;
	tables ls2_milstatus2*mhx_cat/ row wchisq;
	tables ls2_milstatus2*deployed_wot_num/ row wchisq;
	tables ls2_milstatus2*rank_cat/ row wchisq;
	tables ls2_milstatus2*ls2_milstatus/ row wchisq;
	tables ls2_milstatus2*active_years_cat/ row wchisq;
	tables ls2_milstatus2*years_since_cat/ row wchisq;


run;
proc surveyfreq data=work1 missing;*for missing cell variables;
	weight weight_lsw3_norm;
	strata sestrat;
	cluster secluster;	
	tables ls2_milstatus2*years_since_cat/ row wchisq;
	where ls2_milstatus2 in (2,3);
run;
/*;
proc surveyfreq data=work1;*for missing cell variables;
	weight weight_lsw3_norm;
	strata sestrat;
	cluster secu;
	table age_ls2; 
	tables aas_ppds*age_cat/ row cl wchisq;
	tables aas_ppds*mast_pm_v002/ row cl wchisq;
	
	tables aas_ppds*race_cat/ row cl wchisq;
	tables aas_ppds*ed_cat/ row cl wchisq;
	tables aas_ppds*mhx_cat/ row cl wchisq;
	tables aas_ppds*rank_cat/ row cl wchisq;
	tables aas_ppds*army_time_cat/ row cl wchisq;
	tables aas_ppds*command_cat/ row cl wchisq;
run;
/*;
proc surveyfreq data=work1;*for missing cell variables;
	tables aas_ppds*mast_pm_v002/ row cl wchisq;
	tables aas_ppds*age_cat/ row cl wchisq;
	tables aas_ppds*race_cat/ row cl wchisq;
	tables aas_ppds*ed_cat/ row cl wchisq;
	tables aas_ppds*mhx_cat/ row cl wchisq;
	tables aas_ppds*rank_cat/ row cl wchisq;
	tables aas_ppds*army_time_cat/ row cl wchisq;
	tables aas_ppds*command_cat/ row cl wchisq;
run;
*/*;
ods html close;

