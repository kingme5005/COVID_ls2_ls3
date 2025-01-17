libname home "/home/data/Harvard/king/ls3/covid/new/data/";
libname mc "/home/data/Harvard/Hwang/AAG_Constructs/2019/DATA/";
LIBNAME aagcons "/home/data/Harvard/king/aag_constructs/data2019/" ;
libname svy "/home/data/Harvard/Hwang/STARRSLS/preds_as_of_LS2/DATA/";


options nofmterr formdlim='-' mprint mlogic MINoperator;


data work1;
	set 	home.work1;

	ls3_dx1plus_30=0;
	if sum(ls3d5_covid_mde30, ls3d5_gad30, ls3d5_pts30, ls3d5_covid_rupa30) ge 1 then ls3_dx1plus_30=1;

	ls2_dx1plus_30=0;
	if sum(ls2d5_mde30, ls2d5_gad30, ls2d5_pts30, ls2_covid_rupa30) ge 1 then ls2_dx1plus_30=1;

	ls2_dx2plus_30=0;
	if sum(ls2d5_mde30, ls2d5_gad30, ls2d5_pts30, ls2_covid_rupa30) ge 2 then ls2_dx2plus_30=1;

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
run;


ods html file = "/home/data/Harvard/king/ls3/covid/new/tables/ctab/Table2_prevalence_ak031324.html";

proc surveyfreq data=work1 ; 
	weight weight_lsw3_norm;
	strata sestrat;
	cluster secluster;
	tables ls2_dx2plus_30;
	tables ls2_dx1plus_30*(c7_cat5 c12_catb3 c20 c11_lovedone1b c9_hhold_cat3 c9_friend1b)/row;
	tables covid_stress_any*(ls3d5_covid_mde30 ls3d5_gad30 ls3d5_pts30 ls3d5_covid_rupa30 ls3_dx1plus_30)/ row ;
	tables covid_stress_any*(ls2d5_mde30 ls2d5_gad30 ls2d5_pts30 ls2_covid_rupa30 ls2_dx1plus_30)/row  ;
	tables covid_stress_any*ls2d5_mde30*ls3d5_covid_mde30/row ;
	tables covid_stress_any*ls2d5_gad30*ls3d5_gad30/row ;
	tables covid_stress_any*ls2d5_pts30*ls3d5_pts30/ row ;
	tables covid_stress_any*ls2_covid_rupa30*ls3d5_covid_rupa30/row ;
	tables covid_stress_any*ls2_dx1plus_30*ls3_dx1plus_30/row  ;
	
run;
*mcnemar test;
proc freq data=work1 ; 
	weight weight_lsw3_norm;
	tables  covid_stress_any*ls3d5_covid_mde30 /agree   ;
	where ls2d5_mde30=1;
proc freq data=work1 ; 
	weight weight_lsw3_norm;
	tables  covid_stress_any*ls3d5_covid_mde30 /agree   ;
	where ls2d5_mde30=0;
proc freq data=work1 ; 
	weight weight_lsw3_norm;
	tables  covid_stress_any*ls3d5_gad30 /agree   ;
	where ls2d5_gad30=1;
proc freq data=work1 ; 
	weight weight_lsw3_norm;
	tables  covid_stress_any*ls3d5_gad30 /agree   ;
	where ls2d5_gad30=0;

	tables  ls2d5_gad30*ls3d5_gad30/agree ;
	tables  ls2d5_pts30*ls3d5_pts30/agree  ;
	tables   ls2_covid_rupa30*ls3d5_covid_rupa30/agree;
	tables ls2_dx1plus_30*ls3_dx1plus_30/agree ;
	where covid_stress_any=0;
run;
*mcnemar test;
proc freq data=work1 ; 
	weight weight_lsw3_norm;
	tables ls2d5_mde30*ls3d5_covid_mde30 /agree   ;
	tables  ls2d5_gad30*ls3d5_gad30/agree ;
	tables  ls2d5_pts30*ls3d5_pts30/agree  ;
	tables   ls2_covid_rupa30*ls3d5_covid_rupa30/agree;
	tables ls2_dx1plus_30*ls3_dx1plus_30/agree ;
	where covid_stress_any=0;
run;
proc freq data=work1 ; 
	weight weight_lsw3_norm;
	tables ls2d5_mde30*ls3d5_covid_mde30 /agree   ;
	tables  ls2d5_gad30*ls3d5_gad30/agree ;
	tables  ls2d5_pts30*ls3d5_pts30/agree  ;
	tables   ls2_covid_rupa30*ls3d5_covid_rupa30/agree;
	tables ls2_dx1plus_30*ls3_dx1plus_30/agree ;
	where covid_stress_any=1;
run;
ods html close;

