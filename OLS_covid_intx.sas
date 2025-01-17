libname home "/home/data/Harvard/king/ls3/covid/new/data/";
libname mc "/home/data/Harvard/Hwang/AAG_Constructs/2019/DATA/";
LIBNAME aagcons "/home/data/Harvard/king/aag_constructs/data2019/" ;
libname svy "/home/data/Harvard/Hwang/STARRSLS/preds_as_of_LS2/DATA/";


options nofmterr formdlim='-' mprint mlogic MINoperator;

data work2;
	set home.for_stata;


	race_cat=1;*white;
	if rblk eq 1 then race_cat=2;
	else if rhisp eq 1 then race_cat=3;
	else if rother eq 1 then race_cat=4;
	array dummyaa (4) 6. race_cat1-race_cat4;
	do i=1 to 4;
		dummyaa(i)=0;
	end;
	dummyaa(race_cat)=1;


	array dummyb (4) 6. ls2_milstatus1-ls2_milstatus4;
	do i=1 to 4;
		dummyb(i)=0;
	end;
	dummyb(ls2_milstatus)=1;
	ls2_milstatus2b=0;
	if ls2_milstatus in (2,3) then ls2_milstatus2b=1;

	array dummyc (4) 6. age_ls2_cat1-age_ls2_cat4;
	do i=1 to 4;
		dummyc(i)=0;
	end;
	dummyc(age_ls2_cat)=1;

	array dummyd (3) 6. mhx_cat1-mhx_cat3;
	do i=1 to 3;
		dummyd(i)=0;
	end;
	dummyd(mhx_cat)=1;

	array dummyf (3) 6. rank_cat1-rank_cat3;
	do i=1 to 3;
		dummyf(i)=0;
	end;
	dummyf(rank_cat)=1;

	array dummyg (4) 6. years_since_cat1-years_since_cat4;
	do i=1 to 4;
		dummyg(i)=0;
	end;
	dummyg(years_since_cat)=1;

	deployed_wot_numb=deployed_wot_num+1;
	array dummyh (3) 6. deployed_wot_num1-deployed_wot_num3;
	do i=1 to 3;
		dummyh(i)=0;
	end;
	dummyh(deployed_wot_numb)=1;


	outcome_1=dx1plus30_diff;
	outcome_2=covid_mde30_diff;
	outcome_3=gad30_diff;
	outcome_4=pts30_diff;
	outcome_5=covid_rupa30_diff;


	*interactions by covid stress;
	intxa2=age_ls2_cat2*covid_stress_any;
	intxa3=age_ls2_cat3*covid_stress_any;
	intxa4=age_ls2_cat4*covid_stress_any;

	intxb1=mast_pm_v002*covid_stress_any;
	
	intxc2=race_cat2*covid_stress_any;
	intxc3=race_cat3*covid_stress_any;
	intxc4=race_cat4*covid_stress_any;

	intxd1=non_hetero*covid_stress_any;
	
	intxf2=mhx_cat2*covid_stress_any;
	intxf3=mhx_cat3*covid_stress_any;

	intxg2=deployed_wot_num2*covid_stress_any;
	intxg3=deployed_wot_num3*covid_stress_any;

	intxh2=rank_cat2*covid_stress_any;
	intxh3=rank_cat3*covid_stress_any;

	intxj2=ls2_milstatus2b*covid_stress_any;
	intxj3=ls2_milstatus4*covid_stress_any;

	intxm2=years_since_cat2*covid_stress_any;
	intxm3=years_since_cat3*covid_stress_any;
	intxm4=years_since_cat4*covid_stress_any;

	*interactions by mental disorders;
	*any ls2 disorder;
	intxo1a2=age_ls2_cat2*ls2_dx1plus_30;
	intxo1a3=age_ls2_cat3*ls2_dx1plus_30;
	intxo1a4=age_ls2_cat4*ls2_dx1plus_30;

	intxo1b1=mast_pm_v002*ls2_dx1plus_30;
	
	intxo1c2=race_cat2*ls2_dx1plus_30;
	intxo1c3=race_cat3*ls2_dx1plus_30;
	intxo1c4=race_cat4*ls2_dx1plus_30;

	intxo1d1=non_hetero*ls2_dx1plus_30;
	
	intxo1f2=mhx_cat2*ls2_dx1plus_30;
	intxo1f3=mhx_cat3*ls2_dx1plus_30;

	intxo1g2=deployed_wot_num2*ls2_dx1plus_30;
	intxo1g3=deployed_wot_num3*ls2_dx1plus_30;

	intxo1h2=rank_cat2*ls2_dx1plus_30;
	intxo1h3=rank_cat3*ls2_dx1plus_30;

	intxo1j2=ls2_milstatus2b*ls2_dx1plus_30;
	intxo1j3=ls2_milstatus4*ls2_dx1plus_30;

	intxo1m2=years_since_cat2*ls2_dx1plus_30;
	intxo1m3=years_since_cat3*ls2_dx1plus_30;
	intxo1m4=years_since_cat4*ls2_dx1plus_30;

	intxo1p11= c7_cat5*ls2_dx1plus_30;
	intxo1p12= c12_catb3*ls2_dx1plus_30;
	intxo1p13= c20*ls2_dx1plus_30;
	intxo1p14= c11_lovedone1b*ls2_dx1plus_30;
	intxo1p15= c9_hhold_cat3*ls2_dx1plus_30;
	intxo1p16= c9_friend1b*ls2_dx1plus_30;

	*mde;
	intxo2a2=age_ls2_cat2*ls2d5_mde30;
	intxo2a3=age_ls2_cat3*ls2d5_mde30;
	intxo2a4=age_ls2_cat4*ls2d5_mde30;

	intxo2b1=mast_pm_v002*ls2d5_mde30;
	
	intxo2c2=race_cat2*ls2d5_mde30;
	intxo2c3=race_cat3*ls2d5_mde30;
	intxo2c4=race_cat4*ls2d5_mde30;

	intxo2d1=non_hetero*ls2d5_mde30;
	
	intxo2f2=mhx_cat2*ls2d5_mde30;
	intxo2f3=mhx_cat3*ls2d5_mde30;

	intxo2g2=deployed_wot_num2*ls2d5_mde30;
	intxo2g3=deployed_wot_num3*ls2d5_mde30;

	intxo2h2=rank_cat2*ls2d5_mde30;
	intxo2h3=rank_cat3*ls2d5_mde30;

	intxo2j2=ls2_milstatus2b*ls2d5_mde30;
	intxo2j3=ls2_milstatus4*ls2d5_mde30;

	intxo2m2=years_since_cat2*ls2d5_mde30;
	intxo2m3=years_since_cat3*ls2d5_mde30;
	intxo2m4=years_since_cat4*ls2d5_mde30;

	intxo2p11= c7_cat5*ls2d5_mde30;
	intxo2p12= c12_catb3*ls2d5_mde30;
	intxo2p13= c20*ls2d5_mde30;
	intxo2p14= c11_lovedone1b*ls2d5_mde30;
	intxo2p15= c9_hhold_cat3*ls2d5_mde30;
	intxo2p16= c9_friend1b*ls2d5_mde30;

	*gad;
	intxo3a2=age_ls2_cat2*ls2d5_gad30;
	intxo3a3=age_ls2_cat3*ls2d5_gad30;
	intxo3a4=age_ls2_cat4*ls2d5_gad30;

	intxo3b1=mast_pm_v002*ls2d5_gad30;
	
	intxo3c2=race_cat2*ls2d5_gad30;
	intxo3c3=race_cat3*ls2d5_gad30;
	intxo3c4=race_cat4*ls2d5_gad30;

	intxo3d1=non_hetero*ls2d5_gad30;
	
	intxo3f2=mhx_cat2*ls2d5_gad30;
	intxo3f3=mhx_cat3*ls2d5_gad30;

	intxo3g2=deployed_wot_num2*ls2d5_gad30;
	intxo3g3=deployed_wot_num3*ls2d5_gad30;

	intxo3h2=rank_cat2*ls2d5_gad30;
	intxo3h3=rank_cat3*ls2d5_gad30;

	intxo3j2=ls2_milstatus2b*ls2d5_gad30;
	intxo3j3=ls2_milstatus4*ls2d5_gad30;

	intxo3m2=years_since_cat2*ls2d5_gad30;
	intxo3m3=years_since_cat3*ls2d5_gad30;
	intxo3m4=years_since_cat4*ls2d5_gad30;

	intxo3p11= c7_cat5*ls2d5_pts30;
	intxo3p12= c12_catb3*ls2d5_pts30;
	intxo3p13= c20*ls2d5_pts30;
	intxo3p14= c11_lovedone1b*ls2d5_pts30;
	intxo3p15= c9_hhold_cat3*ls2d5_pts30;
	intxo3p16= c9_friend1b*ls2d5_pts30;

	*ptsd;
	intxo4a2=age_ls2_cat2*ls2d5_pts30;
	intxo4a3=age_ls2_cat3*ls2d5_pts30;
	intxo4a4=age_ls2_cat4*ls2d5_pts30;

	intxo4b1=mast_pm_v002*ls2d5_pts30;
	
	intxo4c2=race_cat2*ls2d5_pts30;
	intxo4c3=race_cat3*ls2d5_pts30;
	intxo4c4=race_cat4*ls2d5_pts30;

	intxo4d1=non_hetero*ls2d5_pts30;
	
	intxo4f2=mhx_cat2*ls2d5_pts30;
	intxo4f3=mhx_cat3*ls2d5_pts30;

	intxo4g2=deployed_wot_num2*ls2d5_pts30;
	intxo4g3=deployed_wot_num3*ls2d5_pts30;

	intxo4h2=rank_cat2*ls2d5_pts30;
	intxo4h3=rank_cat3*ls2d5_pts30;

	intxo4j2=ls2_milstatus2b*ls2d5_pts30;
	intxo4j3=ls2_milstatus4*ls2d5_pts30;

	intxo4m2=years_since_cat2*ls2d5_pts30;
	intxo4m3=years_since_cat3*ls2d5_pts30;
	intxo4m4=years_since_cat4*ls2d5_pts30;

	intxo4p11= c7_cat5*ls2d5_pts30;
	intxo4p12= c12_catb3*ls2d5_pts30;
	intxo4p13= c20*ls2d5_pts30;
	intxo4p14= c11_lovedone1b*ls2d5_pts30;
	intxo4p15= c9_hhold_cat3*ls2d5_pts30;
	intxo4p16= c9_friend1b*ls2d5_pts30;

	*panic;
	intxo5a2=age_ls2_cat2*ls2_covid_rupa30;
	intxo5a3=age_ls2_cat3*ls2_covid_rupa30;
	intxo5a4=age_ls2_cat4*ls2_covid_rupa30;

	intxo5b1=mast_pm_v002*ls2_covid_rupa30;
	
	intxo5c2=race_cat2*ls2_covid_rupa30;
	intxo5c3=race_cat3*ls2_covid_rupa30;
	intxo5c4=race_cat4*ls2_covid_rupa30;

	intxo5d1=non_hetero*ls2_covid_rupa30;
	
	intxo5f2=mhx_cat2*ls2_covid_rupa30;
	intxo5f3=mhx_cat3*ls2_covid_rupa30;

	intxo5g2=deployed_wot_num2*ls2_covid_rupa30;
	intxo5g3=deployed_wot_num3*ls2_covid_rupa30;

	intxo5h2=rank_cat2*ls2_covid_rupa30;
	intxo5h3=rank_cat3*ls2_covid_rupa30;

	intxo5j2=ls2_milstatus2b*ls2_covid_rupa30;
	intxo5j3=ls2_milstatus4*ls2_covid_rupa30;

	intxo5m2=years_since_cat2*ls2_covid_rupa30;
	intxo5m3=years_since_cat3*ls2_covid_rupa30;
	intxo5m4=years_since_cat4*ls2_covid_rupa30;

	intxo5p11= c7_cat5*ls2_covid_rupa30;
	intxo5p12= c12_catb3*ls2_covid_rupa30;
	intxo5p13= c20*ls2_covid_rupa30;
	intxo5p14= c11_lovedone1b*ls2_covid_rupa30;
	intxo5p15= c9_hhold_cat3*ls2_covid_rupa30;
	intxo5p16= c9_friend1b*ls2_covid_rupa30;



	*subgroup coded predictors;
	*mhx subgroup coded by ls2 disorder;
	if mhx_cat eq 1 then ls2mdx_mhx_cat=1; 
	ls2mdx1_mhx_cat23=0;
	if ls2_dx1plus_30 eq 1 then do;
		if mhx_cat in (2,3) then ls2mdx1_mhx_cat23=1;
		if mhx_cat eq 2 then ls2mdx_mhx_cat=2;
		if mhx_cat eq 3 then ls2mdx_mhx_cat=3;
	end;
	ls2mdx0_mhx_cat23=0;
	if ls2_dx1plus_30 eq 0 then do;
		if mhx_cat in (2,3) then ls2mdx0_mhx_cat23=1;
		if mhx_cat eq 2 then ls2mdx_mhx_cat=4;
		if mhx_cat eq 3 then ls2mdx_mhx_cat=5;
	end;
	array dummyz (5) 5. ls2mdx_mhx_cat1-ls2mdx_mhx_cat5;
	do i=1 to 5;
		dummyz(i)=0;
	end;
	dummyz(ls2mdx_mhx_cat)=1;

	*enlistment status subgroup coded by ls2 disorder;
	if ls2_milstatus eq 1 then ls2mdx_milstatus=1; 
	ls2mdx1_milstatus234=0;
	if ls2_dx1plus_30 eq 1 then do; 
		if ls2_milstatus in (2,3,4) then ls2mdx1_milstatus234=1;
		if ls2_milstatus in (2,3) then ls2mdx_milstatus=2;*inactive/active guard reserve;
		if ls2_milstatus eq 4 then ls2mdx_milstatus=3;
	end;
	ls2mdx0_milstatus234=0;
	if ls2_dx1plus_30 eq 0 then do;
		if ls2_milstatus in (2,3,4) then ls2mdx0_milstatus234=1;
		if ls2_milstatus in (2,3) then ls2mdx_milstatus=4;*inactive/active guard reserve;
		if ls2_milstatus eq 4 then ls2mdx_milstatus=5;
	end;
	array dummyzz (5) 5. ls2mdx_milstatus1-ls2mdx_milstatus5;
	do i=1 to 5;
		dummyzz(i)=0;
	end;
	dummyzz(ls2mdx_milstatus)=1;

	*c7 hosp & infection subgroup coded by ls2 disorder;
	if c7_cat5 eq 0 then ls2mdx_c7_cat5=1; 
	if c7_cat5 eq 1 then do; *inactive/active guard reserve;
		if ls2_dx1plus_30 eq 1 then ls2mdx_c7_cat5=2;
		if ls2_dx1plus_30 eq 0 then ls2mdx_c7_cat5=3;
	end;	
	array dummyzy (3) 5. ls2mdx_c7_cat5_1-ls2mdx_c7_cat5_3;
	do i=1 to 3;
		dummyzy(i)=0;
	end;
	dummyzy(ls2mdx_c7_cat5)=1;

	*c12 weeks lockdown subgroup coded by ls2 disorder;
	if c12_catb3 eq 0 then ls2mdx_c12_catb3=1; 
	if c12_catb3 eq 1 then do; *inactive/active guard reserve;
		if ls2_dx1plus_30 eq 1 then ls2mdx_c12_catb3=2;
		if ls2_dx1plus_30 eq 0 then ls2mdx_c12_catb3=3;
	end;	
	array dummyzx (3) 5. ls2mdx_c12_catb3_1-ls2mdx_c12_catb3_3;
	do i=1 to 3;
		dummyzx(i)=0;
	end;
	dummyzx(ls2mdx_c12_catb3)=1;

	*c20 lost job subgroup coded by ls2 disorder;
	if c20 eq 0 then ls2mdx_c20=1; 
	if c20 eq 1 then do; *inactive/active guard reserve;
		if ls2_dx1plus_30 eq 1 then ls2mdx_c20=2;
		if ls2_dx1plus_30 eq 0 then ls2mdx_c20=3;
	end;	
	array dummyzw (3) 5. ls2mdx_c20_1-ls2mdx_c20_3;
	do i=1 to 3;
		dummyzw(i)=0;
	end;
	dummyzw(ls2mdx_c20)=1;

	*c11 death of a loved one subgroup coded by ls2 disorder;
	if c11_lovedone1b eq 0 then ls2mdx_c11_lovedone1b=1; 
	if c11_lovedone1b eq 1 then do; *inactive/active guard reserve;
		if ls2_dx1plus_30 eq 1 then ls2mdx_c11_lovedone1b=2;
		if ls2_dx1plus_30 eq 0 then ls2mdx_c11_lovedone1b=3;
	end;	
	array dummyzv (3) 5. ls2mdx_c11_lovedone1b_1-ls2mdx_c11_lovedone1b_3;
	do i=1 to 3;
		dummyzv(i)=0;
	end;
	dummyzv(ls2mdx_c11_lovedone1b)=1;

	*c9 number of household members infected subgroup coded by ls2 disorder;
	if c9_hhold_cat3 eq 0 then ls2mdx_c9_hhold_cat3=1; 
	if c9_hhold_cat3 eq 1 then do; *inactive/active guard reserve;
		if ls2_dx1plus_30 eq 1 then ls2mdx_c9_hhold_cat3=2;
		if ls2_dx1plus_30 eq 0 then ls2mdx_c9_hhold_cat3=3;
	end;	
	array dummyzt (3) 5. ls2mdx_c9_hhold_cat3_1-ls2mdx_c9_hhold_cat3_3;
	do i=1 to 3;
		dummyzt(i)=0;
	end;
	dummyzt(ls2mdx_c9_hhold_cat3)=1;

	*c9 number of friends infected subgroup coded by ls2 disorder;
	if c9_friend1b eq 0 then ls2mdx_c9_friend1b=1; 
	if c9_friend1b eq 1 then do; *inactive/active guard reserve;
		if ls2_dx1plus_30 eq 1 then ls2mdx_c9_friend1b=2;
		if ls2_dx1plus_30 eq 0 then ls2mdx_c9_friend1b=3;
	end;	
	array dummyzs (3) 5. ls2mdx_c9_friend1b_1-ls2mdx_c9_friend1b_3;
	do i=1 to 3;
		dummyzs(i)=0;
	end;
	dummyzs(ls2mdx_c9_friend1b)=1;

	ls2_dx1plus_30no=1-ls2_dx1plus_30;
run;


%let age=age_ls2_cat2 age_ls2_cat3 age_ls2_cat4;
%let race=race_cat2 race_cat3 race_cat4;
%let mhx=mhx_cat2 mhx_cat3;
%let rank=rank_cat2 rank_cat3;
%let enlist=ls2_milstatus2b ls2_milstatus4;
%let years=years_since_cat2 years_since_cat3 years_since_cat4;
%let deploy= deployed_wot_num2 deployed_wot_num3;
%let intx_stress= 	intxa2 intxa3 intxa4 
					intxb1 
					intxc2 intxc3 intxc4
					intxd1
					intxf2 intxf3
					intxg2 intxg3
					intxh2 intxh3
					intxj2 intxj3
					intxm2 intxm3 intxm4;

%let intx_mdxo1= 	intxo1a2 intxo1a3 intxo1a4 
					intxo1b1 
					intxo1c2 intxo1c3 intxo1c4
					intxo1d1
					intxo1f2 intxo1f3
					intxo1g2 intxo1g3
					intxo1h2 intxo1h3
					intxo1j2 intxo1j3
					intxo1m2 intxo1m3 intxo1m4
					intxo1p11 intxo1p12 intxo1p13 intxo1p14 intxo1p15 intxo1p16;
%let intx_mdxo2= 	intxo2a2 intxo2a3 intxo2a4 
					intxo2b1 
					intxo2c2 intxo2c3 intxo2c4
					intxo2d1
					intxo2f2 intxo2f3
					intxo2g2 intxo2g3
					intxo2h2 intxo2h3
					intxo2j2 intxo2j3
					intxo2m2 intxo2m3 intxo2m4
					intxo2p11 intxo2p12 intxo2p13 intxo2p14 intxo2p15 intxo2p16;
%let intx_mdxo3= 	intxo3a2 intxo3a3 intxo3a4 
					intxo3b1 
					intxo3c2 intxo3c3 intxo3c4
					intxo3d1
					intxo3f2 intxo3f3
					intxo3g2 intxo3g3
					intxo3h2 intxo3h3
					intxo3j2 intxo3j3
					intxo3m2 intxo3m3 intxo3m4
					intxo3p11 intxo3p12 intxo3p13 intxo3p14 intxo3p15 intxo3p16;
%let intx_mdxo4= 	intxo4a2 intxo4a3 intxo4a4 
					intxo4b1 
					intxo4c2 intxo4c3 intxo4c4
					intxo4d1
					intxo4f2 intxo4f3
					intxo4g2 intxo4g3
					intxo4h2 intxo4h3
					intxo4j2 intxo4j3
					intxo4m2 intxo4m3 intxo4m4
					intxo4p11 intxo4p12 intxo4p13 intxo4p14 intxo4p15 intxo4p16;
%let intx_mdxo5= 	intxo5a2 intxo5a3 intxo5a4 
					intxo5b1 
					intxo5c2 intxo5c3 intxo5c4
					intxo5d1
					intxo5f2 intxo5f3
					intxo5g2 intxo5g3
					intxo5h2 intxo5h3
					intxo5j2 intxo5j3
					intxo5m2 intxo5m3 intxo5m4
					intxo5p11 intxo5p12 intxo5p13 intxo5p14 intxo5p15 intxo5p16;


%macro mv_models (outcome, num, numa) / mindelimiter=',';
proc surveyreg data=work2;
	weight weight_lsw3_norm;
	strata sestrat;
	cluster secluster;
	
	model  outcome_&numa.  = 	
								%if &numa=1 %then ls2_dx1plus_30 ;
								%if &numa=2 %then ls2d5_mde30 ;
								%if &numa=3 %then ls2d5_gad30 ;
								%if &numa=4 %then ls2d5_pts30 ;
								%if &numa=5 %then ls2_covid_rupa30 ;
								%if &num in 1,2,3 %then &age mast_pm_v002 &race non_hetero &mhx &deploy &rank &enlist &years ;
								%if &num in 1,2,3 %then c7_cat5 c12_catb3 c20 c11_lovedone1b c9_hhold_cat3 c9_friend1b;
								%if &num=2 %then &intx_stress ;
								%if &num=3 %then &&intx_mdxo&numa. ;
								%if &num=4 %then 	&age mast_pm_v002 &race non_hetero 
													ls2mdx_mhx_cat2 ls2mdx_mhx_cat3 ls2mdx_mhx_cat4 ls2mdx_mhx_cat5
													&deploy &rank 
													ls2mdx_milstatus2 ls2mdx_milstatus3 ls2mdx_milstatus4 ls2mdx_milstatus5
													&years
													ls2mdx_c7_cat5_2 ls2mdx_c7_cat5_3
													ls2mdx_c12_catb3_2 ls2mdx_c12_catb3_3
													ls2mdx_c20_2 ls2mdx_c20_3 
													ls2mdx_c11_lovedone1b_2 ls2mdx_c11_lovedone1b_3
													ls2mdx_c9_hhold_cat3_2 ls2mdx_c9_hhold_cat3_3 
													ls2mdx_c9_friend1b_2 ls2mdx_c9_friend1b_3;	
								%if &num=5 %then 	&age mast_pm_v002 &race non_hetero 
													ls2mdx1_mhx_cat23 ls2mdx_mhx_cat3 ls2mdx0_mhx_cat23 ls2mdx_mhx_cat5
													&deploy &rank 
													ls2mdx1_milstatus234 ls2mdx_milstatus3 ls2mdx0_milstatus234 ls2mdx_milstatus5
													&years
													c7_cat5 ls2mdx_c7_cat5_3
													c12_catb3 ls2mdx_c12_catb3_3
													c20 ls2mdx_c20_3 
													c11_lovedone1b ls2mdx_c11_lovedone1b_3
													c9_hhold_cat3 ls2mdx_c9_hhold_cat3_3 
													c9_friend1b ls2mdx_c9_friend1b_3;	

								
								
								
								;
	%if &num in 1,2,3 %then %do;
		contrast 'age3' age_ls2_cat2 1 , age_ls2_cat3 1 , age_ls2_cat4 1 ;
		contrast 'sexf1' mast_pm_v002 1 ;
		contrast 'race3' race_cat2 1 , race_cat3 1 , race_cat4 1 ;
		contrast 'nonh1' non_hetero 1 ;
		contrast 'mhx2' mhx_cat2 1 , mhx_cat3 1  ;
		contrast 'depl2' deployed_wot_num2 1, deployed_wot_num3 1 ;
		contrast 'rank2' rank_cat2 1 , rank_cat3 1 ;
		contrast 'enl2' ls2_milstatus2b 1, ls2_milstatus4 1 ;
		contrast 'year3' years_since_cat2 1 , years_since_cat3 1 , years_since_cat4 1 ;
		contrast 'c7' c7_cat5 1;
		contrast 'c12' c12_catb3 1;
		contrast 'c20' c20 1;
		contrast 'c11' c11_lovedone1b 1;
		contrast 'c9hh' c9_hhold_cat3 1;
		contrast 'c9f' c9_friend1b 1;
		contrast 'c6' c7_cat5 1, c12_catb3 1, c20 1, c11_lovedone1b 1, c9_hhold_cat3 1, c9_friend1b 1;
	%end;
	%if &num=2 %then %do;
		contrast 'Xage3' intxa2 1 , intxa3 1 , intxa4 1 ;
		contrast 'Xsexf1' intxb1 1 ;
		contrast 'Xrace3' intxc2 1 , intxc3 1 , intxc4 1  ;
		contrast 'Xnonh1' intxd1 1 ;
		contrast 'Xmhx2' intxf2 1 , intxf3 1 ;
		contrast 'Xdepl2' intxg2 1 , intxg3 1 ;
		contrast 'Xrank2' intxh2 1 , intxh3 1 ;
		contrast 'Xenl2' intxj2 1 , intxj3 1 ;
		contrast 'Xyear3' intxm2 1 , intxm3 1, intxm4 1 ;
	%end;
	%if &num=3 %then %do;
		%if &numa=1 %then %do;
			contrast 'Xage3' intxo1a2 1 , intxo1a3 1 , intxo1a4 1 ;
			contrast 'Xsexf1' intxo1b1 1 ;
			contrast 'Xrace3' intxo1c2 1 , intxo1c3 1 , intxo1c4 1  ;
			contrast 'Xnonh1' intxo1d1 1 ;
			contrast 'Xmhx2' intxo1f2 1 , intxo1f3 1 ;
			contrast 'Xdepl2' intxo1g2 1 , intxo1g3 1 ;
			contrast 'Xrank2' intxo1h2 1 , intxo1h3 1 ;
			contrast 'Xenl2' intxo1j2 1 , intxo1j3 1 ;
			contrast 'Xyear3' intxo1m2 1 , intxo1m3 1, intxo1m4 1 ;
			contrast 'X1mdx' intxo1p11 1 ;
			contrast 'X2mdx' intxo1p12 1 ;
			contrast 'X3mdx' intxo1p13 1 ;
			contrast 'X4mdx' intxo1p14 1 ;
			contrast 'X5mdx' intxo1p15 1 ;
			contrast 'X6mdx' intxo1p16 1 ;
			contrast 'Xmdx6' intxo1p11 1, intxo1p12 1, intxo1p13 1, intxo1p14 1, intxo1p15 1, intxo1p16 1 ;
		%end;
		%if &numa=2 %then %do;
			contrast 'Xage3' intxo2a2 1 , intxo2a3 1 , intxo2a4 1 ;
			contrast 'Xsexf1' intxo2b1 1 ;
			contrast 'Xrace3' intxo2c2 1 , intxo2c3 1 , intxo2c4 1  ;
			contrast 'Xnonh1' intxo2d1 1 ;
			contrast 'Xmhx2' intxo2f2 1 , intxo2f3 1 ;
			contrast 'Xdepl2' intxo2g2 1 , intxo2g3 1 ;
			contrast 'Xrank2' intxo2h2 1 , intxo2h3 1 ;
			contrast 'Xenl2' intxo2j2 1 , intxo2j3 1 ;
			contrast 'Xyear3' intxo2m2 1 , intxo2m3 1, intxo2m4 1 ;
			contrast 'X1mdx' intxo2p11 1 ;
			contrast 'X2mdx' intxo2p12 1 ;
			contrast 'X3mdx' intxo2p13 1 ;
			contrast 'X4mdx' intxo2p14 1 ;
			contrast 'X5mdx' intxo2p15 1 ;
			contrast 'X6mdx' intxo2p16 1 ;
			contrast 'Xmdx6' intxo2p11 1, intxo2p12 1, intxo2p13 1, intxo2p14 1, intxo2p15 1, intxo2p16 1 ;
		%end;
		%if &numa=3 %then %do;
			contrast 'Xage3' intxo3a2 1 , intxo3a3 1 , intxo3a4 1 ;
			contrast 'Xsexf1' intxo3b1 1 ;
			contrast 'Xrace3' intxo3c2 1 , intxo3c3 1 , intxo3c4 1  ;
			contrast 'Xnonh1' intxo3d1 1 ;
			contrast 'Xmhx2' intxo3f2 1 , intxo3f3 1 ;
			contrast 'Xdepl2' intxo3g2 1 , intxo3g3 1 ;
			contrast 'Xrank2' intxo3h2 1 , intxo3h3 1 ;
			contrast 'Xenl2' intxo3j2 1 , intxo3j3 1 ;
			contrast 'Xyear3' intxo3m2 1 , intxo3m3 1, intxo3m4 1 ;
			contrast 'X1mdx' intxo3p11 1 ;
			contrast 'X2mdx' intxo3p12 1 ;
			contrast 'X3mdx' intxo3p13 1 ;
			contrast 'X4mdx' intxo3p14 1 ;
			contrast 'X5mdx' intxo3p15 1 ;
			contrast 'X6mdx' intxo3p16 1 ;
			contrast 'Xmdx6' intxo3p11 1, intxo3p12 1, intxo3p13 1, intxo3p14 1, intxo3p15 1, intxo3p16 1 ;
		%end;
		%if &numa=4 %then %do;
			contrast 'Xage3' intxo4a2 1 , intxo4a3 1 , intxo4a4 1 ;
			contrast 'Xsexf1' intxo4b1 1 ;
			contrast 'Xrace3' intxo4c2 1 , intxo4c3 1 , intxo4c4 1  ;
			contrast 'Xnonh1' intxo4d1 1 ;
			contrast 'Xmhx2' intxo4f2 1 , intxo4f3 1 ;
			contrast 'Xdepl2' intxo4g2 1 , intxo4g3 1 ;
			contrast 'Xrank2' intxo4h2 1 , intxo4h3 1 ;
			contrast 'Xenl2' intxo4j2 1 , intxo4j3 1 ;
			contrast 'Xyear3' intxo4m2 1 , intxo4m3 1, intxo4m4 1 ;
			contrast 'X1mdx' intxo4p11 1 ;
			contrast 'X2mdx' intxo4p12 1 ;
			contrast 'X3mdx' intxo4p13 1 ;
			contrast 'X4mdx' intxo4p14 1 ;
			contrast 'X5mdx' intxo4p15 1 ;
			contrast 'X6mdx' intxo4p16 1 ;
			contrast 'Xmdx6' intxo4p11 1, intxo4p12 1, intxo4p13 1, intxo4p14 1, intxo4p15 1, intxo4p16 1 ;
		%end;
		%if &numa=5 %then %do;
			contrast 'Xage3' intxo5a2 1 , intxo5a3 1 , intxo5a4 1 ;
			contrast 'Xsexf1' intxo5b1 1 ;
			contrast 'Xrace3' intxo5c2 1 , intxo5c3 1 , intxo5c4 1  ;
			contrast 'Xnonh1' intxo5d1 1 ;
			contrast 'Xmhx2' intxo5f2 1 , intxo5f3 1 ;
			contrast 'Xdepl2' intxo5g2 1 , intxo5g3 1 ;
			contrast 'Xrank2' intxo5h2 1 , intxo5h3 1 ;
			contrast 'Xenl2' intxo5j2 1 , intxo5j3 1 ;
			contrast 'Xyear3' intxo5m2 1 , intxo5m3 1, intxo5m4 1 ;
			contrast 'X1mdx' intxo5p11 1 ;
			contrast 'X2mdx' intxo5p12 1 ;
			contrast 'X3mdx' intxo5p13 1 ;
			contrast 'X4mdx' intxo5p14 1 ;
			contrast 'X5mdx' intxo5p15 1 ;
			contrast 'X6mdx' intxo5p16 1 ;
			contrast 'Xmdx6' intxo5p11 1, intxo5p12 1, intxo5p13 1, intxo5p14 1, intxo5p15 1, intxo5p16 1 ;
		%end;
	%end;
	%if &num=4 %then %do;
		contrast 'age3' age_ls2_cat2 1 , age_ls2_cat3 1 , age_ls2_cat4 1 ;
		contrast 'sexf1' mast_pm_v002 1 ;
		contrast 'race3' race_cat2 1 , race_cat3 1 , race_cat4 1 ;
		contrast 'nonh1' non_hetero 1 ;
		contrast 'depl2' deployed_wot_num2 1, deployed_wot_num3 1 ;
		contrast 'rank2' rank_cat2 1 , rank_cat3 1 ;
		contrast 'year3' years_since_cat2 1 , years_since_cat3 1 , years_since_cat4 1 ;
		contrast 'mhx2yes' ls2mdx_mhx_cat2 1, ls2mdx_mhx_cat3 1;
		contrast 'mhx3no' ls2mdx_mhx_cat4 1, ls2mdx_mhx_cat5 1;
		contrast 'mil2byes' ls2mdx_milstatus2 1, ls2mdx_milstatus3 1;
		contrast 'mil4no' ls2mdx_milstatus4 1, ls2mdx_milstatus5 1;	
		contrast 'c7yes' ls2mdx_c7_cat5_2 1;
		contrast 'c7no' ls2mdx_c7_cat5_3 1;
		contrast 'c12yes' ls2mdx_c12_catb3_2 1;
		contrast 'c12no' ls2mdx_c12_catb3_3 1;
		contrast 'c20yes' ls2mdx_c20_2 1;
		contrast 'c20no' ls2mdx_c20_3 1;
		contrast 'c11yes' ls2mdx_c11_lovedone1b_2 1;
		contrast 'c11no' ls2mdx_c11_lovedone1b_3 1;
		contrast 'c9hhyes' ls2mdx_c9_hhold_cat3_2 1;
		contrast 'c9hhno' ls2mdx_c9_hhold_cat3_3 1;
		contrast 'c9fyes' ls2mdx_c9_friend1b_2 1;
		contrast 'c9fno' ls2mdx_c9_friend1b_3 1;
		contrast 'cyes6' ls2mdx_c7_cat5_2 1, ls2mdx_c12_catb3_2 1, ls2mdx_c20_2 1, ls2mdx_c11_lovedone1b_2 1, ls2mdx_c9_hhold_cat3_2 1, ls2mdx_c9_friend1b_2 1;
		contrast 'cno6' ls2mdx_c7_cat5_3 1, ls2mdx_c12_catb3_3 1, ls2mdx_c20_3 1, ls2mdx_c11_lovedone1b_3 1, ls2mdx_c9_hhold_cat3_3 1, ls2mdx_c9_friend1b_3 1;
	%end;
	%if &num=5 %then %do;
		contrast 'age3' age_ls2_cat2 1 , age_ls2_cat3 1 , age_ls2_cat4 1 ;
		contrast 'sexf1' mast_pm_v002 1 ;
		contrast 'race3' race_cat2 1 , race_cat3 1 , race_cat4 1 ;
		contrast 'nonh1' non_hetero 1 ;
		contrast 'depl2' deployed_wot_num2 1, deployed_wot_num3 1 ;
		contrast 'rank2' rank_cat2 1 , rank_cat3 1 ;
		contrast 'year3' years_since_cat2 1 , years_since_cat3 1 , years_since_cat4 1 ;
		contrast 'mhx2yes' ls2mdx_mhx_cat3 1;
		contrast 'mhx3no' ls2mdx_mhx_cat5 1;
		contrast 'mil2byes' ls2mdx_milstatus3 1;
		contrast 'mil4no' ls2mdx_milstatus5 1;	
		contrast 'c7no' ls2mdx_c7_cat5_3 1;
		contrast 'c12no' ls2mdx_c12_catb3_3 1;
		contrast 'c20no' ls2mdx_c20_3 1;
		contrast 'c11no' ls2mdx_c11_lovedone1b_3 1;
		contrast 'c9hhno' ls2mdx_c9_hhold_cat3_3 1;
		contrast 'c9fno' ls2mdx_c9_friend1b_3 1;
		contrast 'cyes6' ls2mdx_c7_cat5_2 1, ls2mdx_c12_catb3_2 1, ls2mdx_c20_2 1, ls2mdx_c11_lovedone1b_2 1, ls2mdx_c9_hhold_cat3_2 1, ls2mdx_c9_friend1b_2 1;
		contrast 'cno6' ls2mdx_c7_cat5_3 1, ls2mdx_c12_catb3_3 1, ls2mdx_c20_3 1, ls2mdx_c11_lovedone1b_3 1, ls2mdx_c9_hhold_cat3_3 1, ls2mdx_c9_friend1b_3 1;
	%end;
	 
													  
													 
													  
													 ;	
	 ods output parameterestimates=a
				 contrasts=b;
run;


data a;
	length parameter $ 25 se $ 10;
	set a;	
	if index(parameter, "Intercept") > 0 then delete;
	*if index(parameter, "ls2d5") > 0 then delete;
	*if index(parameter, "ls2_covid") > 0 then delete;
	*if index(parameter, "ls2_dx") > 0 then delete;
	*if index(parameter, "intx") > 0 then delete;

	if probt lt .05 then star="*";
	est=100*estimate;	
	ard=compress(trim(put(est,6.1))||star);
	stderr=100*stderr;
	se=put(stderr,6.1);
	p=put(probt,5.3);
	if probt lt .001 then pf="<.001";
run;

data b;
	length contrastlabel $ 25 se $ 10;
	set b ;	
	if probf lt .05 then star="*";
	
	se=put(probf,10.5);
	
	
	chisq=fvalue*numdf;
	ard=compress(trim(put(chisq,5.1))||star);
	rename contrastlabel=parameter;
run;

data ab;
	set a b;
run;

data outstat&numa._&num.;
	retain model parameter est stderr ard se numdf;
	set ab;
	model=&num.;
	keep model parameter est stderr ard se numdf; 
	rename 	est=est&numa
			stderr=stderr&numa 
			ard=ard&numa 
			se=se&numa 
			numdf=numdf&numa;
run;
/*;
data outstat&numa._&num.;
	retain model parameter ard se numdf;
	set ab;
	model=&num.;
	keep model parameter ard se numdf; 
	rename 	ard=ard&numa
			se=se&numa 
			numdf=numdf&numa;
run;
*/*;

%mend mv_models;
%macro loop;
%do i=1 %to 5;
	%mv_models( numa=1, num=&i)
	%mv_models( numa=2, num=&i)
	%mv_models( numa=3, num=&i)
	%mv_models( numa=4, num=&i)
	%mv_models( numa=5, num=&i)
%end;
%mend loop;
%loop;

%macro make_table(numa);
data outstat&numa.;
	set outstat&numa._1-outstat&numa._5;
run;
%mend make_table;
%macro loopb;
%do i=1 %to 5;
	%make_table(numa=&i)
%end;
%mend loopb;
%loopb

data outstat;
	retain model parameter;
	merge outstat1-outstat5;
run;

*/*d-fdr correction (benjamini and yekutieli);
*model 2;
data fdr_input;
	set outstat1_2 (in=a)
		outstat2_2 (in=b)
		outstat3_2 (in=c)
		outstat4_2 (in=d)
		outstat5_2 (in=f);

	if substr(parameter,1,1) ne "X" then delete;

	raw_p=sum(of se1-se5);
	if a=1 then outcome=1;
	if b=1 then outcome=2;
	if c=1 then outcome=3;
	if d=1 then outcome=4;
	if f=1 then outcome=5;
	keep outcome model parameter raw_p;*must have raw_p variable as inpurt for proc multtest;
run;
proc multtest inpvalues(raw_p)=fdr_input dfdr out=fdr_output;
	*test raw_p;
	*ods output pvalues=home.fdr_output;
run; 

data fdr_output2;
	merge fdr_input fdr_output;
	keep outcome model dfdr_p;
run;

data fdr_outstat_m2;
	retain 	model;
	merge 	fdr_output2 (where=(outcome=1) rename=(dfdr_p=pval_fdr_o1))
			fdr_output2 (where=(outcome=2) rename=(dfdr_p=pval_fdr_o2))
			fdr_output2 (where=(outcome=3) rename=(dfdr_p=pval_fdr_o3))
			fdr_output2 (where=(outcome=4) rename=(dfdr_p=pval_fdr_o4))
			fdr_output2 (where=(outcome=5) rename=(dfdr_p=pval_fdr_o5));
run;
*model 3a-demographic and army career characteristics;
data fdr_input;
	set outstat1_3 (in=a)
		outstat2_3 (in=b)
		outstat3_3 (in=c)
		outstat4_3 (in=d)
		outstat5_3 (in=f);

	if substr(parameter,1,1) ne "X" then delete;
	if substr(parameter,2,1) in ("1", "2", "3", "4", "5", "6") then delete;

	raw_p=sum(of se1-se5);
	if a=1 then outcome=1;
	if b=1 then outcome=2;
	if c=1 then outcome=3;
	if d=1 then outcome=4;
	if f=1 then outcome=5;
	keep outcome model parameter raw_p;*must have raw_p variable as inpurt for proc multtest;
run;
proc multtest inpvalues(raw_p)=fdr_input dfdr out=fdr_output;
	*test fisher(raw_p);
	*ods output pvalues=fdr_output;
run; 
data fdr_output2;
	merge fdr_input fdr_output;
	keep outcome model dfdr_p;
run;
data fdr_outstat_m3a;
	retain 	model;
	merge 	fdr_output2 (where=(outcome=1) rename=(dfdr_p=pval_fdr_o1))
			fdr_output2 (where=(outcome=2) rename=(dfdr_p=pval_fdr_o2))
			fdr_output2 (where=(outcome=3) rename=(dfdr_p=pval_fdr_o3))
			fdr_output2 (where=(outcome=4) rename=(dfdr_p=pval_fdr_o4))
			fdr_output2 (where=(outcome=5) rename=(dfdr_p=pval_fdr_o5));
run;
*model 3b-mdx and stressor interactions;
data fdr_input;
	set outstat1_3 (in=a)
		outstat2_3 (in=b)
		outstat3_3 (in=c)
		outstat4_3 (in=d)
		outstat5_3 (in=f);

	if substr(parameter,1,1) ne "X" then delete;
	if substr(parameter,2,1) not in ("1", "2", "3", "4", "5", "6") then delete;

	raw_p=sum(of se1-se5);
	if a=1 then outcome=1;
	if b=1 then outcome=2;
	if c=1 then outcome=3;
	if d=1 then outcome=4;
	if f=1 then outcome=5;
	keep outcome model parameter raw_p;*must have raw_p variable as inpurt for proc multtest;
run;
proc multtest inpvalues(raw_p)=fdr_input dfdr out=fdr_output;
	*test fisher(raw_p);
	*ods output pvalues=fdr_output;
run; 
data fdr_output2;
	merge fdr_input fdr_output;
	keep outcome model dfdr_p;
run;
data fdr_outstat_m3b;
	retain 	model;
	merge 	fdr_output2 (where=(outcome=1) rename=(dfdr_p=pval_fdr_o1))
			fdr_output2 (where=(outcome=2) rename=(dfdr_p=pval_fdr_o2))
			fdr_output2 (where=(outcome=3) rename=(dfdr_p=pval_fdr_o3))
			fdr_output2 (where=(outcome=4) rename=(dfdr_p=pval_fdr_o4))
			fdr_output2 (where=(outcome=5) rename=(dfdr_p=pval_fdr_o5));
run;
*/*;
ods html file = "/home/data/Harvard/king/ls3/covid/new/tables/models/ARD_covid_ak042524.html";
proc print data=outstat;run;
proc print data=fdr_outstat_m2;
proc print data=fdr_outstat_m3a;
proc print data=fdr_outstat_m3b;run;

ods html close;




endsas;
data a;
	set a ;
	
	
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


data outstat_o&numa._m&num. ;
	set probs (where=(sample_test=1));
run;

%mend predprob;
%macro loop;
%do i=1 %to 2;
	%predprob(outcome=ls3_dx1plus_30, numa=1, num=&i)
	%predprob(outcome=ls3d5_covid_mde30, numa=2, num=&i)
	%predprob(outcome=ls3d5_gad30, numa=3, num=&i)
	%predprob(outcome=ls3d5_pts30, numa=4, num=&i)
	%predprob(outcome=ls3_covid_rupa30, numa=5, num=&i)
%end;
%mend loop;
%loop

%macro merge_data(numa)
data outstat_o&numa.;
	merge 	outstat_o&numa._m1
			outstat_o&numa._m2 (keep=pp_o&numa._m2);
run;
%mend;

endsas;
%macro mv_models (outcome, num, numa) / mindelimiter=',';
proc genmod data= outstat_o&numa._m&num. ;
	 class masterid; 
	 weight weight_lsw3_norm;
	 model  &outcome  = 		
							%if &num=1 %then pp;
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
							%if &num=20 %then c17 c21 c11_lovedone1b c11_other c9_friend c9_other;
							

							in_aas in_nss in_ppds
							mast_pm_v010 mast_pm_v002
							rblk rhisp rother
							ed_cat2 ed_cat3 ed_cat4
							milstatus_ls3_cat2 milstatus_ls3_cat3 milstatus_ls3_cat4
							deer_pm_v084 deer_pm_v083
							ls2d5_mde30 ls2d5_gad30 ls2d5_pts30 ls2_covid_rupa30 ls2_dx2plus_30
							ls2_md4_30d ls2_gad5_30d ls2_ptsd6_30d
							
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
	 %if &num = 8 %then %do; 
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
		 contrast 'var6' c17 1, c21 1, c11_lovedone1b 1, c11_other 1, c9_friend 1, c9_other 1 / wald;		
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

proc means data=outstat_o1_m2; var predprob; class sample_test; run;
