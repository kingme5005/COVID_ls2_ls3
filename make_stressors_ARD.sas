libname home "/home/data/Harvard/king/ls3/covid/new/data/";
libname mc "/home/data/Harvard/Hwang/AAG_Constructs/2019/DATA/";
LIBNAME aagcons "/home/data/Harvard/king/aag_constructs/data2019/" ;
libname svy "/home/data/Harvard/Hwang/STARRSLS/preds_as_of_LS2/DATA/";


options nofmterr formdlim='-' mprint mlogic MINoperator;

%include "/home/data/Harvard/king/ls3/covid/new/code/Table1_demo.sas";

data work2;
	merge 	home.work1 	(in=a)
			work1 		(keep=	masterid 
								age_ls2_cat: mast_pm_v002 race_cat non_hetero ed_cat mhx_cat deployed_wot_num rank_cat ls2_milstatus: active_years years_since_active active_years_cat years_since_cat);
	by masterid;
	if a=1;

	
	ls3_dx1plus_30=0;
	if sum(ls3d5_covid_mde30, ls3d5_gad30, ls3d5_pts30, ls3d5_covid_rupa30) ge 1 then ls3_dx1plus_30=1;

	ls3_dxsum_30= sum(ls3d5_covid_mde30, ls3d5_gad30, ls3d5_pts30, ls3d5_covid_rupa30);

	ls2_dx1plus_30=0;
	if sum(ls2d5_mde30, ls2d5_gad30, ls2d5_pts30, ls2_covid_rupa30) ge 1 then ls2_dx1plus_30=1;

	ls2_dx2plus_30=0;
	if sum(ls2d5_mde30, ls2d5_gad30, ls2d5_pts30, ls2_covid_rupa30) ge 2 then ls2_dx2plus_30=1;

	*change scores for linear regression;
	dx1plus30_diff=ls3_dx1plus_30-ls2_dx1plus_30;
	covid_mde30_diff=ls3d5_covid_mde30-ls2d5_mde30;
	gad30_diff=ls3d5_gad30-ls2d5_gad30;
	pts30_diff=ls3d5_pts30-ls2d5_pts30;
	covid_rupa30_diff=ls3d5_covid_rupa30-ls2_covid_rupa30;

	race_cat=1;*white;
	if rblk eq 1 then race_cat=2;
	else if rhisp eq 1 then race_cat=3;
	else if rother eq 1 then race_cat=4;
	array dummyaa (4) 6. race_cat1-race_cat4;
	do i=1 to 4;
		dummyaa(i)=0;
	end;
	dummyaa(race_cat)=1;


	if sum(edcat1_n, edcat2_n,  edcat3_n) eq 3 then ed_cat=1;*GED or equivalent;
	else if sum(edcat2_n, edcat3_n) eq 2 then ed_cat=2;*HS diploma;
	else if sum(edcat1_n, edcat2_n,  edcat3_n) eq 0 then ed_cat=4;*college graduate;
	else ed_cat=3; *some college;
	array dummya (4) 6. ed_cat1-ed_cat4;
	do i=1 to 4;
		dummya(i)=0;
	end;
	dummya(ed_cat)=1;

	c7_cat=c7+1;
	if c7_cat ge 5 then c7_cat=5;
	array dummyc (5) 6. c7_cat1-c7_cat5;
	do i=1 to 5;
		dummyc(i)=0;
	end;
	dummyc(c7_cat)=1;	

	*weeks in lockdown;
	c12_1b=0;
	if c12 ge 1 then c12_1b=1;
	
	*death of a loved one;
	c11_lovedone=sum(c11_1_parent, c11_2_spouse, c11_3_child, c11_6_friend);
	c11_lovedone1b=0;
	if c11_lovedone ge 1 then c11_lovedone1b=1;
	c11_lovedone_cat=c11_lovedone+1;
	if c11_lovedone_cat ge 3 then c11_lovedone_cat=3;
	array dummyd (3) 6. c11_lovedone_cat1-c11_lovedone_cat3;
	do i=1 to 3;
		dummyd(i)=0;
	end;
	dummyd(c11_lovedone_cat)=1;

	*death of someone else in R's social network;
	c11_other=sum(c11_4_relative, c11_5_workmate, c11_7_other);
	c11_other1b=0;
	if c11_other ge 1 then c11_other1b=1;
	c11_other_cat=c11_other+1;
	if c11_other_cat ge 3 then c11_other_cat=3;
	array dummyf (3) 6. c11_other_cat1-c11_other_cat3;
	do i=1 to 3;
		dummyf(i)=0;
	end;
	dummyf(c11_other_cat)=1;

	*people in household infected;
	c9_hhold=c9_1_family;
	c9_hhold3=c9_hhold;
	if c9_hhold3 ge 3 then c9_hhold3=3;
	c9_hhold1b=0;
	if c9_hhold ge 1 then c9_hhold1b=1;
	c9_hhold_cat=c9_hhold+1;
	if c9_hhold_cat ge 3 then c9_hhold_cat=3;
	array dummyg (3) 6. c9_hhold_cat1-c9_hhold_cat3;
	do i=1 to 3;
		dummyg(i)=0;
	end;
	dummyg(c9_hhold_cat)=1;

	*friends infected;
	c9_friend=c9_4_friend;
	c9_friend5=c9_friend;
	if c9_friend5 ge 5 then c9_friend5=5;
	c9_friend1b=0;
	if c9_friend ge 1 then c9_friend1b=1;
	c9_friend_cat=c9_friend+1;
	if c9_friend_cat ge 3 then c9_friend_cat=3;
	array dummyh (3) 6. c9_friend_cat1-c9_friend_cat3;
	do i=1 to 3;
		dummyh(i)=0;
	end;
	dummyh(c9_friend_cat)=1;

	*other known people infected;
	c9_other=sum(c9_2_lovedone, c9_3_workmate, c9_5_other );
	c9_other1b=0;
	if c9_other ge 1 then c9_other1b=1;
	c9_other_cat=c9_other+1;
	if 4 le c9_other_cat le 7 then c9_other_cat=2;
	if c9_other_cat ge 8 then c9_other_cat=3;
	array dummym (3) 6. c9_other_cat1-c9_other_cat3;
	do i=1 to 3;
		dummym(i)=0;
	end;
	dummym(c9_other_cat)=1;

	*weeks in lockdown;

	_c12=c12+1;
	array dummyn (11) 6. c12_1-c12_11;
	do i=1 to 11;
	end;
	dummyn(_c12)=1;

	if c12 eq 0 then c12_cat=1;
	else if c12 le 4 then c12_cat=2;
	else if c12 le 8 then c12_cat=3;
	else c12_cat=4;
	array dummyp (4) 6. c12_cat1-c12_cat4;
	do i=1 to 4;
		dummyp(i)=0;
	end;
	dummyp(c12_cat)=1;
	c12_catb=c12_cat-1;
	if c12_catb le 1 then c12_catb=1;
	c12_catb3=0;
	if c12_catb eq 3 then c12_catb3=1;

	if c15 eq 0 then c15_cat=1;
	else if c15 le 7 then c15_cat=2;
	else if c15 le 14 then c15_cat=3;
	else if c15 le 21 then c15_cat=4;
	else c15_cat=5;
	array dummyq (5) 6. c15_cat1-c15_cat5;
	do i=1 to 5;
		dummyq(i)=0;
	end;
	dummyq(c15_cat)=1;

	*composite covid stress dummy variable;
	covid_stress_any=0;
	if c7_cat5 eq 1 then covid_stress_any=1;
	if c12_catb eq 3 then covid_stress_any=1;
	if c20 eq 1 then covid_stress_any=1;
	if c11_lovedone1b eq 1 then covid_stress_any=1;
	if c9_hhold_cat3 eq 1 then covid_stress_any=1;
	if c9_friend1b eq 1 then covid_stress_any=1;

	covid_stress_any0=1-covid_stress_any;


	
run;
data home.for_stata;
	retain 	masterid weight_lsw3_norm sestrat secluster
			ls3_dx1plus_30 ls3d5_covid_mde30 ls3d5_gad30 ls3d5_pts30 ls3d5_covid_rupa30 ls3_dxsum_30
			c7_cat5 c12 c17 c20 c21 c11_lovedone1b c11_other c9_hhold3 c9_friend5;
	set work2;

	*keep 	masterid weight_lsw3_norm sestrat secluster
			ls3_dx1plus_30 ls3d5_covid_mde30 ls3d5_gad30 ls3d5_pts30 ls3d5_covid_rupa30 ls3_dxsum_30
			c7_cat5 c12_cat4 c17 c20 c21 c11_lovedone1b c11_other1b c9_hhold_cat3 c9_friend1b;
	proc contents order=varnum;
run;

PROC EXPORT DATA = home.for_stata
            OUTFILE = "/home/data/Harvard/king/ls3/covid/new/data/stressors_ARD_data.dta"
            DBMS = stata
            REPLACE;
run;

ods html file = "/home/data/Harvard/king/ls3/covid/new/tables/demo_table_ak031724.html";
*/*;
proc freq data=work2 ;*for missing cell variables;
	weight weight_lsw3_norm;
	tables mast_pm_v002*ls2_dx1plus_30*covid_stress_any*ls3_dx1plus_30;
run;
proc surveyfreq data=work2;
	weight weight_lsw3_norm;
	strata sestrat;
	cluster secluster;
	tables ls2_dx1plus_30*covid_stress_any*ls3_dx1plus_30/row col;
	where mast_pm_v002=0;
run;
proc surveyfreq data=work2;
	weight weight_lsw3_norm;
	strata sestrat;
	cluster secluster;
	tables ls2_dx1plus_30*covid_stress_any*ls3_dx1plus_30/row col;
	where mast_pm_v002=1;
run;
ods html close;

data ls2_stack;
	set work2;

	in_ls3=0;
	keep	masterid weight_lsw3_norm strata sestrat cluster secluster
			ls2d5_mde30 ls2d5_gad30 ls2d5_pts30 ls2_covid_rupa30 ls2_dx1plus_30
			in_ls3 covid_stress_any covid_stress_any0;
run;
data ls3_stack;
	set work2;

	in_ls3=1;
	keep	masterid weight_lsw3_norm strata sestrat cluster secluster
			ls3d5_covid_mde30 ls3d5_gad30 ls3d5_pts30 ls3d5_covid_rupa30 ls3_dx1plus_30
			in_ls3 covid_stress_any covid_stress_any0;
run;
data for_stata_stacked;
	set ls2_stack ls3_stack;

	mde30=sum(ls3d5_covid_mde30, ls2d5_mde30);
	gad30=sum(ls3d5_gad30, ls2d5_gad30);
	pts30=sum(ls3d5_pts30, ls2d5_pts30);
	rupa30=sum(ls3d5_covid_rupa30, ls2_covid_rupa30);
	dx1plus_30=sum(ls3_dx1plus_30, ls2_dx1plus_30);

	covid_stress_any_inls3=0;
	if covid_stress_any eq 1 then do;
		if in_ls3 eq 0 then covid_stress_any_inls3=1;
		if in_ls3 eq 1 then covid_stress_any_inls3=2;
	end;

	inls3_covid_stress_any=0;
	if in_ls3 eq 1 then do;
		if covid_stress_any eq 0 then inls3_covid_stress_any=1;
		if covid_stress_any eq 1 then inls3_covid_stress_any=2;
	end;
run;
PROC EXPORT DATA = for_stata_stacked
            OUTFILE = "/home/data/Harvard/king/ls3/covid/new/data/stacked_RR_SEs_data.dta"
            DBMS = stata
            REPLACE;
run;

endsas;
ods html file= "/home/data/Harvard/king/ls3/covid/new/tables/ctab/ctab_ak071522.html";
proc means data=work2 mean stderr STD min max;
	weight weight_lsw3_norm;
	var  c9_hhold3 c9_friend5 c7_cat1 c7_cat2 c7_cat3 c7_cat4 c7_cat5 c12 c14 c15 c11_11_relfriend c9_hhold c9_4_friend c9_hhold c9_hhold1b c9_friend c9_friend1b c9_other c9_other1b c11_lovedone c11_lovedone1b c11_other c11_other1b;
run;
proc surveyfreq data=work2 ;
	weight weight_lsw3_norm;
	strata sestrat;
	cluster secluster;
	tables c7_cat*ls3_dx1plus_30/row;
	tables c7_cat*ls2_dx1plus_30/row;
	tables c12 c12_cat c15 c15_cat c9_other c11_lovedone1b c11_other1b c9_hhold1b c9_friend1b c9_other1b;
	tables (c7_cat5 c12_catb c17 c20 c21 c11_lovedone1b c11_other1b c9_hhold_cat3 c9_friend1b )*ls3d5_covid_mde30 /row;
	tables (c7_cat5 c12_catb c17 c20 c21 c11_lovedone1b c11_other1b c9_hhold_cat3 c9_friend1b )*ls2d5_mde30 /row;
	tables (c7_cat5 c12_catb c17 c20 c21 c11_lovedone1b c11_other1b c9_hhold_cat3 c9_friend1b )*ls3d5_gad30 /row;
	tables (c7_cat5 c12_catb c17 c20 c21 c11_lovedone1b c11_other1b c9_hhold_cat3 c9_friend1b )*ls2d5_gad30 /row;
	tables (c7_cat5 c12_catb c17 c20 c21 c11_lovedone1b c11_other1b c9_hhold_cat3 c9_friend1b )*ls3d5_pts30 /row;
	tables (c7_cat5 c12_catb c17 c20 c21 c11_lovedone1b c11_other1b c9_hhold_cat3 c9_friend1b )*ls2d5_pts30 /row;
	tables (c7_cat5 c12_catb c17 c20 c21 c11_lovedone1b c11_other1b c9_hhold_cat3 c9_friend1b )*ls3d5_covid_rupa30 /row;
	tables (c7_cat5 c12_catb c17 c20 c21 c11_lovedone1b c11_other1b c9_hhold_cat3 c9_friend1b )*ls2_covid_rupa30 /row;
	tables (c7_cat5 c12_catb c17 c20 c21 c11_lovedone1b c11_other1b c9_hhold_cat3 c9_friend1b )*ls3_dx1plus_30 /row;
	tables (c7_cat5 c12_catb c17 c20 c21 c11_lovedone1b c11_other1b c9_hhold_cat3 c9_friend1b )*ls2_dx1plus_30 /row;

	tables (age_ls2_cat mast_pm_v002 race_cat non_hetero ed_cat mhx_cat deployed_wot_num rank_cat ls2_milstatus2 active_years_cat years_since_cat)*ls3d5_covid_mde30 /row;
	tables (age_ls2_cat mast_pm_v002 race_cat non_hetero ed_cat mhx_cat deployed_wot_num rank_cat ls2_milstatus2 active_years_cat years_since_cat)*ls2d5_mde30 /row;
	tables (age_ls2_cat mast_pm_v002 race_cat non_hetero ed_cat mhx_cat deployed_wot_num rank_cat ls2_milstatus2 active_years_cat years_since_cat)*ls3d5_gad30 /row;
	tables (age_ls2_cat mast_pm_v002 race_cat non_hetero ed_cat mhx_cat deployed_wot_num rank_cat ls2_milstatus2 active_years_cat years_since_cat)*ls2d5_gad30 /row;
	tables (age_ls2_cat mast_pm_v002 race_cat non_hetero ed_cat mhx_cat deployed_wot_num rank_cat ls2_milstatus2 active_years_cat years_since_cat)*ls3d5_pts30 /row;
	tables (age_ls2_cat mast_pm_v002 race_cat non_hetero ed_cat mhx_cat deployed_wot_num rank_cat ls2_milstatus2 active_years_cat years_since_cat)*ls2d5_pts30 /row;
	tables (age_ls2_cat mast_pm_v002 race_cat non_hetero ed_cat mhx_cat deployed_wot_num rank_cat ls2_milstatus2 active_years_cat years_since_cat)*ls3d5_covid_rupa30 /row;
	tables (age_ls2_cat mast_pm_v002 race_cat non_hetero ed_cat mhx_cat deployed_wot_num rank_cat ls2_milstatus2 active_years_cat years_since_cat)*ls2_covid_rupa30 /row;
	tables (age_ls2_cat mast_pm_v002 race_cat non_hetero ed_cat mhx_cat deployed_wot_num rank_cat ls2_milstatus2 active_years_cat years_since_cat)*ls3_dx1plus_30 /row;
	tables (age_ls2_cat mast_pm_v002 race_cat non_hetero ed_cat mhx_cat deployed_wot_num rank_cat ls2_milstatus2 active_years_cat years_since_cat)*ls2_dx1plus_30 /row;

		
run;
ods html close;



*/*total model;
%macro mv_models (outcome, num, numa) / mindelimiter=',';
proc genmod data=work2;
	 strata sestrat;
	 class masterid; 
	 weight weight_lsw3_norm;
	 model  &outcome  = 		
							%if &num=1 %then c7_cat2 c7_cat3 c7_cat4 c7_cat5;
							%if &num=2 %then c12 c12_1b;
							%if &num=3 %then c14 c15;
							%if &num=4 %then c17;
							%if &num=5 %then c20;
							%if &num=6 %then c21;
							%if &num=7 %then c11_lovedone;
							%if &num=8 %then c11_lovedone1b;
							%if &num=9 %then c11_other;
							%if &num=10 %then c11_other1b;
							%if &num=11 %then c11_other_cat2 c11_other_cat3;
							%if &num=12 %then c9_hhold;
							%if &num=13 %then c9_hhold1b;
							%if &num=14 %then c9_hhold_cat2 c9_hhold_cat3;
							%if &num=15 %then c9_friend;
							%if &num=16 %then c9_friend1b;
							%if &num=17 %then c9_friend_cat2 c9_friend_cat3;
							%if &num=18 %then c9_other;
							%if &num=19 %then c9_other1b;
							%if &num=20 %then c9_other_cat2 c9_other_cat3;
							%if &num=21 %then c17 c21 c11_lovedone1b c11_other c9_friend c9_other;
							%if &num=22 %then c11_lovedone_cat2 c11_lovedone_cat3;
							%if &num=23 %then c7_cat5 c12 c17 c20 c21 c11_lovedone1b c11_other c9_hhold3 c9_friend5;
							%if &num=24 %then c11_lovedone1b c11_lovedone_cat3;
							%if &num=25 %then c9_hhold1b c9_hhold_cat3;
							%if &num=26 %then c9_friend1b c9_friend_cat3;
							%if &num=27 %then c9_hhold3;
							%if &num=28 %then c9_friend5;
							%if &num=29 %then c12_2 c12_3 c12_4 c12_5 c12_6 c12_7 c12_8 c12_9 c12_10 c12_11 ;
							%if &num=30 %then c12_cat2 c12_cat3 c12_cat4  ;
							%if &num=31 %then c15_cat2 c15_cat3 c15_cat4 c15_cat5 ;
							
							
							
									 /dist=poisson link=log;	 	
	 repeated subject=masterid / type=unstr;
	 
	 
	 %if &num = 1 %then %do; 
		 contrast 'var4' c7_cat2 1, c7_cat3 1 , c7_cat4 1, c7_cat5 1 / wald;		
	 %end;
	 %if &num = 2 %then %do; 
		 contrast 'var2' c12 1, c12_1b 1 / wald;		
	 %end;
	 %if &num = 3 %then %do; 
		 contrast 'var2' c14 1, c15 1 / wald;		
	 %end;
	 %if &num = 4 %then %do; 
		 contrast 'var1' c17 1 / wald;		
	 %end;
	 %if &num = 5 %then %do; 
		 contrast 'var1' c20 1 / wald;		
	 %end;
	 %if &num = 6 %then %do; 
		 contrast 'var1' c21 1 / wald;		
	 %end;
	 %if &num = 7 %then %do; 
		 contrast 'var1' c11_lovedone 1 / wald;		
	 %end;
	 %if &num in 8,23 %then %do; 
		 contrast 'var1' c11_lovedone1b 1 / wald;		
	 %end;
	 %if &num = 9 %then %do; 
		 contrast 'var1' c11_other 1 / wald;		
	 %end;
	 %if &num = 10 %then %do; 
		 contrast 'var1' c11_other1b 1 / wald;		
	 %end;
	 %if &num = 11 %then %do; 
		 contrast 'var2' c11_other_cat2 1, c11_other_cat3 1 / wald;		
	 %end;
	 %if &num = 12 %then %do; 
		 contrast 'var1' c9_hhold 1 / wald;		
	 %end;
	 %if &num = 13 %then %do; 
		 contrast 'var1' c9_hhold1b 1 / wald;		
	 %end;
	 %if &num = 14 %then %do; 
		 contrast 'var2' c9_hhold_cat2 1, c9_hhold_cat3 1 / wald;		
	 %end;
	 %if &num = 15 %then %do; 
		 contrast 'var1' c9_friend 1 / wald;		
	 %end;
	 %if &num = 16 %then %do; 
		 contrast 'var1' c9_friend1b 1 / wald;		
	 %end;
	 %if &num = 17 %then %do; 
		 contrast 'var2' c9_friend_cat2 1, c9_friend_cat3 1 / wald;		
	 %end;
	 %if &num = 18 %then %do; 
		 contrast 'var1' c9_other 1 / wald;		
	 %end;
	 %if &num = 19 %then %do; 
		 contrast 'var1' c9_other1b 1 / wald;		
	 %end;
	 %if &num = 20 %then %do; 
		 contrast 'var1' c9_other_cat2 1, c9_other_cat3 1 / wald;		
	 %end;
	 %if &num = 21 %then %do; 
		 contrast 'var6' c17 1, c21 1, c11_lovedone1b 1, c11_other 1, c9_friend 1, c9_other 1 / wald;		
	 %end;
	 %if &num = 22 %then %do; 
		 contrast 'var2' c11_lovedone_cat2 1, c11_lovedone_cat3 1 / wald;		
	 %end;
	 %if &num = 24 %then %do; 
		 contrast 'var2' c11_lovedone1b 1, c11_lovedone_cat3 1 / wald;		
	 %end;
	 %if &num = 25 %then %do; 
		 contrast 'var4' c9_hhold1b 1, c9_hhold_cat3 1 / wald;		
	 %end;
	 %if &num = 26 %then %do; 
		 contrast 'var4' c9_friend1b 1, c9_friend_cat3 1 / wald;		
	 %end;
	 %if &num = 27 %then %do; 
		 contrast 'var1' c9_hhold3 1 / wald;		
	 %end;
	 %if &num = 28 %then %do; 
		 contrast 'var1' c9_friend5 1 / wald;		
	 %end;
	 %if &num = 29 %then %do; 
		 contrast 'var9' c12_2 1, c12_3 1, c12_4 1, c12_5 1, c12_6 1, c12_7 1, c12_8 1, c12_9 1, c12_10 1, c12_11 1 / wald;		
	 %end;
	 %if &num = 30 %then %do; 
		 contrast 'var3' c12_cat2 1, c12_cat3 1, c12_cat4 1 / wald;		
	 %end;
	 %if &num = 31 %then %do; 
		 contrast 'var3' c15_cat2 1, c15_cat3 1, c15_cat4 1, c15_cat5 1 / wald;		
	 %end;


	 
	 
	 ods output  GeeEmpPest=home.a
				 contrasts=home.d
				 convergencestatus=home.c;
run;

data a;
	set home.a ;
	length parm $ 25;
	if substr(parm,1,4) eq "Inte" then delete;
	if Probz lt .05 then star="*";
	riskratioest=exp(estimate);
	lowercl=exp(lowercl);
	uppercl=exp(uppercl);
	rr=compress(trim(put(riskratioest,6.2))||star);
	ci=compress("("||trim(put(lowercl,6.2))||"-"||trim(put(uppercl,6.2))||")");

	format riskratioest oddsr6.2 lowercl oddsr6.2 uppercl oddsr6.2;
	rename parm=variable;
run;

data ac;
	merge a home.c;
	rename status=df;
run;

data d;
	length contrast $ 25 ;
	set home.d ;	
	if probchisq lt .05 then star="*";
	if probchisq lt .05 then ci=put(probchisq,5.3);
	if probchisq ge .05 then ci=put(probchisq,5.2);
	if probchisq lt .001 then ci="<.001";
	rr=compress(trim(put(chisq,5.1))||star);
	rename contrast=variable;
run;


%if &numa>1 %then %do;
data outstat&numa._&num.;
	retain variable rr ci df;
	set ac d;

	keep variable rr ci df; 
	rename 	rr=rr&numa
			ci=ci&numa 
			df=df&numa;
run;
%end;
%if &numa=1 %then %do;
data outstat&numa._&num.;
	retain model variable rr ci df;
	set ac d;
	model=&num.;
	keep model variable rr ci df;
run;
%end;


%mend mv_models;
%macro loop;
%do i=1 %to 31;
	%mv_models(outcome=ls3_dx1plus_30, numa=1, num=&i)
	%mv_models(outcome=ls3d5_covid_mde30, numa=2, num=&i)
	%mv_models(outcome=ls3d5_gad30, numa=3, num=&i)
	%mv_models(outcome=ls3d5_pts30, numa=4, num=&i)
	%mv_models(outcome=ls3d5_covid_rupa30, numa=5, num=&i)
%end;
%mend loop;
%loop;

%macro make_table(numa);
data outstat&numa.;
	set outstat&numa._1-outstat&numa._31;
run;
%mend make_table;
%macro loopb;
%do i=1 %to 5;
	%make_table(numa=&i)
%end;
%mend loopb;
%loopb

data outstat;
	retain variable;
	merge outstat1-outstat5;
run;


ods html file = "/home/data/Harvard/king/ls3/covid/new/tables/models/RR_covid_ak022824.html";
proc print data=outstat; run;
ods html close;


endsas;
data data_for_rpart;
	retain 	masterid weight_lsw3_norm
			ls3_dx1plus_30 ls3d5_covid_mde30 ls3d5_gad30 ls3d5_pts30 ls3_covid_rupa30
			c7cat
			c12 c12_1b
			c14 c15
			c17
			c20
			c21
			c11_lovedone_cat 
			c11_other_cat
			c9_hhold_cat
			c9_friend_cat
			c9_other;
	set work2;

	keep 	masterid weight_lsw3_norm
			ls3_dx1plus_30 ls3d5_covid_mde30 ls3d5_gad30 ls3d5_pts30 ls3_covid_rupa30
			c7cat
			c12 c12_1b
			c14 c15
			c17
			c20
			c21
			c11_lovedone_cat 
			c11_other_cat
			c9_hhold_cat
			c9_friend_cat
			c9_other;
run;

ods html file = "/home/data/Harvard/king/ls3/covid/tables/ctab/rpart_data_contents.html";
proc contents data=data_for_rpart order=varnum; run;
ods html close;

PROC EXPORT DATA =data_for_rpart
            OUTFILE = "/home/data/Harvard/king/ls3/covid/data/ls3_coviditems_Rpart.csv"
            DBMS = CSV
            REPLACE;
run;
