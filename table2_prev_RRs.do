log using "O:\Harvard\king\ls3\covid\new\tables\stressors_ARD_output.log", replace
use "O:\Harvard\king\ls3\covid\new\data\stressors_ARD_data.dta"

svyset secluster [pweight=weight_lsw3_norm], strata(sestrat) vce(robust) singleunit(centered)
*table p3;
vl create ls2_mdx = (ls2_dx1plus_30 ls2d5_mde30 ls2d5_gad30 ls2d5_pts30 ls2_covid_rupa30)
vl create ls2_demo = (race_cat mast_pm_v002 ls2_milstatus non_hetero ed_cat mhx_cat deployed_wot_num rank_cat)
vl substitute ls2_demo_cat = i.ls2_demo
vl create ls2_demo_cont = (active_years years_since_active)

*table2 prevalence models
svy: regress  dx1plus30_diff i.covid_stress_any
margins , atmeans
margins i.covid_stress_any, atmeans
margins r.covid_stress_any, atmeans

svy: regress  covid_mde30_diff i.covid_stress_any
margins , atmeans
margins i.covid_stress_any, atmeans
margins r.covid_stress_any, atmeans

svy: regress  gad30_diff i.covid_stress_any
margins , atmeans
margins i.covid_stress_any, atmeans
margins r.covid_stress_any, atmeans

svy: regress  pts30_diff i.covid_stress_any
margins , atmeans
margins i.covid_stress_any, atmeans
margins r.covid_stress_any, atmeans

svy: regress  covid_rupa30_diff i.covid_stress_any
margins , atmeans
margins i.covid_stress_any, atmeans
margins r.covid_stress_any, atmeans

*linear regression MV models
*demos
svy: regress  dx1plus30_diff i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat
margins i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat, atmeans
testparm i.age_ls2_cat
testparm i.mast_pm_v002
testparm i.non_hetero
testparm i.race_cat 
testparm i.mhx_cat 
testparm i.deployed_wot_num 
testparm i.rank_cat 
testparm i.ls2_milstatus2 
testparm i.years_since_cat

svy: regress  dx1plus30_diff  i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat i.ls2_dx1plus_30
margins i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat, atmeans
testparm i.age_ls2_cat
testparm i.mast_pm_v002
testparm i.non_hetero
testparm i.race_cat 
testparm i.mhx_cat 
testparm i.deployed_wot_num 
testparm i.rank_cat 
testparm i.ls2_milstatus2 
testparm i.years_since_cat

svy: regress  dx1plus30_diff i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat $ls2_mdx
margins i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat, atmeans
testparm i.age_ls2_cat
testparm i.mast_pm_v002
testparm i.non_hetero
testparm i.race_cat 
testparm i.mhx_cat 
testparm i.deployed_wot_num 
testparm i.rank_cat 
testparm i.ls2_milstatus2 
testparm i.years_since_cat

*stressors
svy: regress  dx1plus30_diff i.c7_cat5 i.c12_catb i.c17 i.c20 i.c21 i.c11_lovedone1b i.c11_other1b i.c9_hhold_cat3 i.c9_friend1b
margins i.c7_cat5 i.c12_catb i.c17 i.c20 i.c21 i.c11_lovedone1b i.c11_other1b i.c9_hhold_cat3 i.c9_friend1b, atmeans
testparm i.c7_cat5
testparm i.c12_catb
testparm i.c17
testparm i.c20
testparm i.c21
testparm i.c11_lovedone1b
testparm i.c11_other1b
testparm i.c9_hhold_cat3
testparm i.c9_friend1b

svy: regress  dx1plus30_diff i.c7_cat5 i.c12_catb i.c17 i.c20 i.c21 i.c11_lovedone1b i.c11_other1b i.c9_hhold_cat3 i.c9_friend1b i.ls2_dx1plus_30
margins i.c7_cat5 i.c12_catb i.c17 i.c20 i.c21 i.c11_lovedone1b i.c11_other1b i.c9_hhold_cat3 i.c9_friend1b, atmeans
testparm i.c7_cat5
testparm i.c12_catb
testparm i.c17
testparm i.c20
testparm i.c21
testparm i.c11_lovedone1b
testparm i.c11_other1b
testparm i.c9_hhold_cat3
testparm i.c9_friend1b

svy: regress  dx1plus30_diff i.c7_cat5 i.c12_catb i.c17 i.c20 i.c21 i.c11_lovedone1b i.c11_other1b i.c9_hhold_cat3 i.c9_friend1b $ls2_mdx
margins i.c7_cat5 i.c12_catb i.c17 i.c20 i.c21 i.c11_lovedone1b i.c11_other1b i.c9_hhold_cat3 i.c9_friend1b, atmeans
testparm i.c7_cat5
testparm i.c12_catb
testparm i.c17
testparm i.c20
testparm i.c21
testparm i.c11_lovedone1b
testparm i.c11_other1b
testparm i.c9_hhold_cat3
testparm i.c9_friend1b


*RR;
quietly svy: poisson ls3_dx1plus_30 i.c7_cat5 i.c12_catb i.c17 i.c20 i.c21 i.c11_lovedone1b i.c11_other1b i.c9_hhold_cat3 i.c9_friend1b, irr 
margins i.c7_cat5 i.c12_catb i.c17 i.c20 i.c21 i.c11_lovedone1b i.c11_other1b i.c9_hhold_cat3 i.c9_friend1b
margins r.c7_cat5, atmeans
margins r.c12_catb, atmeans
margins r.c17, atmeans
margins r.c20, atmeans
margins r.c21, atmeans
margins r.c11_lovedone1b, atmeans
margins r.c11_other1b, atmeans
margins r.c9_hhold_cat3, atmeans
margins r.c9_friend1b, atmeans





*mde;
*linear regression MV models
svy: regress covid_mde30_diff i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat
margins i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat, atmeans
testparm i.age_ls2_cat
testparm i.mast_pm_v002
testparm i.non_hetero
testparm i.race_cat 
testparm i.mhx_cat 
testparm i.deployed_wot_num 
testparm i.rank_cat 
testparm i.ls2_milstatus2 
testparm i.years_since_cat

svy: regress covid_mde30_diff  i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat i.ls2d5_mde30
margins i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat, atmeans
testparm i.age_ls2_cat
testparm i.mast_pm_v002
testparm i.non_hetero
testparm i.race_cat 
testparm i.mhx_cat 
testparm i.deployed_wot_num 
testparm i.rank_cat 
testparm i.ls2_milstatus2 
testparm i.years_since_cat

svy: regress covid_mde30_diff i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat $ls2_mdx
margins i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat, atmeans
testparm i.age_ls2_cat
testparm i.mast_pm_v002
testparm i.non_hetero
testparm i.race_cat 
testparm i.mhx_cat 
testparm i.deployed_wot_num 
testparm i.rank_cat 
testparm i.ls2_milstatus2 
testparm i.years_since_cat

*stressors
svy: regress  covid_mde30_diff i.c7_cat5 i.c12_catb i.c17 i.c20 i.c21 i.c11_lovedone1b i.c11_other1b i.c9_hhold_cat3 i.c9_friend1b
margins i.c7_cat5 i.c12_catb i.c17 i.c20 i.c21 i.c11_lovedone1b i.c11_other1b i.c9_hhold_cat3 i.c9_friend1b, atmeans
testparm i.c7_cat5
testparm i.c12_catb
testparm i.c17
testparm i.c20
testparm i.c21
testparm i.c11_lovedone1b
testparm i.c11_other1b
testparm i.c9_hhold_cat3
testparm i.c9_friend1b

svy: regress  covid_mde30_diff i.c7_cat5 i.c12_catb i.c17 i.c20 i.c21 i.c11_lovedone1b i.c11_other1b i.c9_hhold_cat3 i.c9_friend1b i.ls2d5_mde30
margins i.c7_cat5 i.c12_catb i.c17 i.c20 i.c21 i.c11_lovedone1b i.c11_other1b i.c9_hhold_cat3 i.c9_friend1b, atmeans
testparm i.c7_cat5
testparm i.c12_catb
testparm i.c17
testparm i.c20
testparm i.c21
testparm i.c11_lovedone1b
testparm i.c11_other1b
testparm i.c9_hhold_cat3
testparm i.c9_friend1b

svy: regress  covid_mde30_diff i.c7_cat5 i.c12_catb i.c17 i.c20 i.c21 i.c11_lovedone1b i.c11_other1b i.c9_hhold_cat3 i.c9_friend1b $ls2_mdx
margins i.c7_cat5 i.c12_catb i.c17 i.c20 i.c21 i.c11_lovedone1b i.c11_other1b i.c9_hhold_cat3 i.c9_friend1b, atmeans
testparm i.c7_cat5
testparm i.c12_catb
testparm i.c17
testparm i.c20
testparm i.c21
testparm i.c11_lovedone1b
testparm i.c11_other1b
testparm i.c9_hhold_cat3
testparm i.c9_friend1b

*RR
quietly svy: poisson ls3d5_covid_mde30 i.c7_cat5 i.c12_catb i.c17 i.c20 i.c21 i.c11_lovedone1b i.c11_other1b i.c9_hhold_cat3 i.c9_friend1b, irr 
margins i.c7_cat5 i.c12_catb i.c17 i.c20 i.c21 i.c11_lovedone1b i.c11_other1b i.c9_hhold_cat3 i.c9_friend1b
margins r.c7_cat5, atmeans
margins r.c12_catb, atmeans
margins r.c17, atmeans
margins r.c20, atmeans
margins r.c21, atmeans
margins r.c11_lovedone1b, atmeans
margins r.c11_other1b, atmeans
margins r.c9_hhold_cat3, atmeans
margins r.c9_friend1b, atmeans



*gad;
svy: regress gad30_diff i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat
margins i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat, atmeans
testparm i.age_ls2_cat
testparm i.mast_pm_v002
testparm i.non_hetero
testparm i.race_cat 
testparm i.mhx_cat 
testparm i.deployed_wot_num 
testparm i.rank_cat 
testparm i.ls2_milstatus2 
testparm i.years_since_cat

svy: regress gad30_diff  i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat i.ls2d5_gad30
margins i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat, atmeans
testparm i.age_ls2_cat
testparm i.mast_pm_v002
testparm i.non_hetero
testparm i.race_cat 
testparm i.mhx_cat 
testparm i.deployed_wot_num 
testparm i.rank_cat 
testparm i.ls2_milstatus2 
testparm i.years_since_cat

svy: regress gad30_diff i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat $ls2_mdx
margins i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat, atmeans
testparm i.age_ls2_cat
testparm i.mast_pm_v002
testparm i.non_hetero
testparm i.race_cat 
testparm i.mhx_cat 
testparm i.deployed_wot_num 
testparm i.rank_cat 
testparm i.ls2_milstatus2 
testparm i.years_since_cat

*stressors
svy: regress  gad30_diff i.c7_cat5 i.c12_catb i.c17 i.c20 i.c21 i.c11_lovedone1b i.c11_other1b i.c9_hhold_cat3 i.c9_friend1b
margins i.c7_cat5 i.c12_catb i.c17 i.c20 i.c21 i.c11_lovedone1b i.c11_other1b i.c9_hhold_cat3 i.c9_friend1b, atmeans
testparm i.c7_cat5
testparm i.c12_catb
testparm i.c17
testparm i.c20
testparm i.c21
testparm i.c11_lovedone1b
testparm i.c11_other1b
testparm i.c9_hhold_cat3
testparm i.c9_friend1b

svy: regress  gad30_diff i.c7_cat5 i.c12_catb i.c17 i.c20 i.c21 i.c11_lovedone1b i.c11_other1b i.c9_hhold_cat3 i.c9_friend1b i.ls2d5_gad30
margins i.c7_cat5 i.c12_catb i.c17 i.c20 i.c21 i.c11_lovedone1b i.c11_other1b i.c9_hhold_cat3 i.c9_friend1b, atmeans
testparm i.c7_cat5
testparm i.c12_catb
testparm i.c17
testparm i.c20
testparm i.c21
testparm i.c11_lovedone1b
testparm i.c11_other1b
testparm i.c9_hhold_cat3
testparm i.c9_friend1b

svy: regress  gad30_diff i.c7_cat5 i.c12_catb i.c17 i.c20 i.c21 i.c11_lovedone1b i.c11_other1b i.c9_hhold_cat3 i.c9_friend1b $ls2_mdx
margins i.c7_cat5 i.c12_catb i.c17 i.c20 i.c21 i.c11_lovedone1b i.c11_other1b i.c9_hhold_cat3 i.c9_friend1b, atmeans
testparm i.c7_cat5
testparm i.c12_catb
testparm i.c17
testparm i.c20
testparm i.c21
testparm i.c11_lovedone1b
testparm i.c11_other1b
testparm i.c9_hhold_cat3
testparm i.c9_friend1b

*RR
quietly svy: poisson ls3d5_gad30 i.c7_cat5 i.c12_catb i.c17 i.c20 i.c21 i.c11_lovedone1b i.c11_other1b i.c9_hhold_cat3 i.c9_friend1b, irr 
margins i.c7_cat5 i.c12_catb i.c17 i.c20 i.c21 i.c11_lovedone1b i.c11_other1b i.c9_hhold_cat3 i.c9_friend1b
margins r.c7_cat5, atmeans
margins r.c12_catb, atmeans
margins r.c17, atmeans
margins r.c20, atmeans
margins r.c21, atmeans
margins r.c11_lovedone1b, atmeans
margins r.c11_other1b, atmeans
margins r.c9_hhold_cat3, atmeans
margins r.c9_friend1b, atmeans




*ptsd;
svy: regress pts30_diff i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat
margins i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat, atmeans
testparm i.age_ls2_cat
testparm i.mast_pm_v002
testparm i.non_hetero
testparm i.race_cat 
testparm i.mhx_cat 
testparm i.deployed_wot_num 
testparm i.rank_cat 
testparm i.ls2_milstatus2 
testparm i.years_since_cat

svy: regress pts30_diff i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat i.ls2d5_pts30
margins i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat, atmeans
testparm i.age_ls2_cat
testparm i.mast_pm_v002
testparm i.non_hetero
testparm i.race_cat 
testparm i.mhx_cat 
testparm i.deployed_wot_num 
testparm i.rank_cat 
testparm i.ls2_milstatus2 
testparm i.years_since_cat

svy: regress pts30_diff i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat  $ls2_mdx
margins i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat, atmeans
testparm i.age_ls2_cat
testparm i.mast_pm_v002
testparm i.non_hetero
testparm i.race_cat 
testparm i.mhx_cat 
testparm i.deployed_wot_num 
testparm i.rank_cat 
testparm i.ls2_milstatus2 
testparm i.years_since_cat

*stressors
svy: regress  pts30_diff i.c7_cat5 i.c12_catb i.c17 i.c20 i.c21 i.c11_lovedone1b i.c11_other1b i.c9_hhold_cat3 i.c9_friend1b
margins i.c7_cat5 i.c12_catb i.c17 i.c20 i.c21 i.c11_lovedone1b i.c11_other1b i.c9_hhold_cat3 i.c9_friend1b, atmeans
testparm i.c7_cat5
testparm i.c12_catb
testparm i.c17
testparm i.c20
testparm i.c21
testparm i.c11_lovedone1b
testparm i.c11_other1b
testparm i.c9_hhold_cat3
testparm i.c9_friend1b

svy: regress  pts30_diff i.c7_cat5 i.c12_catb i.c17 i.c20 i.c21 i.c11_lovedone1b i.c11_other1b i.c9_hhold_cat3 i.c9_friend1b i.ls2d5_pts30
margins i.c7_cat5 i.c12_catb i.c17 i.c20 i.c21 i.c11_lovedone1b i.c11_other1b i.c9_hhold_cat3 i.c9_friend1b, atmeans
testparm i.c7_cat5
testparm i.c12_catb
testparm i.c17
testparm i.c20
testparm i.c21
testparm i.c11_lovedone1b
testparm i.c11_other1b
testparm i.c9_hhold_cat3
testparm i.c9_friend1b

svy: regress  pts30_diff i.c7_cat5 i.c12_catb i.c17 i.c20 i.c21 i.c11_lovedone1b i.c11_other1b i.c9_hhold_cat3 i.c9_friend1b $ls2_mdx
margins i.c7_cat5 i.c12_catb i.c17 i.c20 i.c21 i.c11_lovedone1b i.c11_other1b i.c9_hhold_cat3 i.c9_friend1b, atmeans
testparm i.c7_cat5
testparm i.c12_catb
testparm i.c17
testparm i.c20
testparm i.c21
testparm i.c11_lovedone1b
testparm i.c11_other1b
testparm i.c9_hhold_cat3
testparm i.c9_friend1b

*RR
quietly svy: poisson ls3d5_pts30 i.c7_cat5 i.c12_catb i.c17 i.c20 i.c21 i.c11_lovedone1b i.c11_other1b i.c9_hhold_cat3 i.c9_friend1b, irr 
margins i.c7_cat5 i.c12_catb i.c17 i.c20 i.c21 i.c11_lovedone1b i.c11_other1b i.c9_hhold_cat3 i.c9_friend1b
margins r.c7_cat5, atmeans
margins r.c12_catb, atmeans
margins r.c17, atmeans
margins r.c20, atmeans
margins r.c21, atmeans
margins r.c11_lovedone1b, atmeans
margins r.c11_other1b, atmeans
margins r.c9_hhold_cat3, atmeans
margins r.c9_friend1b, atmeans



*panic demo models;
svy: regress covid_rupa30_diff i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat
margins i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat, atmeans
testparm i.age_ls2_cat
testparm i.mast_pm_v002
testparm i.non_hetero
testparm i.race_cat 
testparm i.mhx_cat 
testparm i.deployed_wot_num 
testparm i.rank_cat 
testparm i.ls2_milstatus2 
testparm i.years_since_cat

svy: regress covid_rupa30_diff i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat i.ls2_covid_rupa30
margins i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat, atmeans
testparm i.age_ls2_cat 
testparm i.mast_pm_v002
testparm i.race_cat 
testparm i.non_hetero
testparm i.mhx_cat 
testparm i.deployed_wot_num 
testparm i.rank_cat 
testparm i.ls2_milstatus2 
testparm i.years_since_cat

svy: regress covid_rupa30_diff i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat $ls2_mdx
margins i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat, atmeans
testparm i.age_ls2_cat 
testparm i.mast_pm_v002
testparm i.race_cat 
testparm i.non_hetero
testparm i.mhx_cat 
testparm i.deployed_wot_num 
testparm i.rank_cat 
testparm i.ls2_milstatus2 
testparm i.years_since_cat

*stressors
svy: regress  covid_rupa30_diff i.c7_cat5 i.c12_catb i.c17 i.c20 i.c21 i.c11_lovedone1b i.c11_other1b i.c9_hhold_cat3 i.c9_friend1b
margins i.c7_cat5 i.c12_catb i.c17 i.c20 i.c21 i.c11_lovedone1b i.c11_other1b i.c9_hhold_cat3 i.c9_friend1b, atmeans
testparm i.c7_cat5
testparm i.c12_catb
testparm i.c17
testparm i.c20
testparm i.c21
testparm i.c11_lovedone1b
testparm i.c11_other1b
testparm i.c9_hhold_cat3
testparm i.c9_friend1b

svy: regress  covid_rupa30_diff i.c7_cat5 i.c12_catb i.c17 i.c20 i.c21 i.c11_lovedone1b i.c11_other1b i.c9_hhold_cat3 i.c9_friend1b i.ls2_covid_rupa30
margins i.c7_cat5 i.c12_catb i.c17 i.c20 i.c21 i.c11_lovedone1b i.c11_other1b i.c9_hhold_cat3 i.c9_friend1b, atmeans
testparm i.c7_cat5
testparm i.c12_catb
testparm i.c17
testparm i.c20
testparm i.c21
testparm i.c11_lovedone1b
testparm i.c11_other1b
testparm i.c9_hhold_cat3
testparm i.c9_friend1b

svy: regress  covid_rupa30_diff i.c7_cat5 i.c12_catb i.c17 i.c20 i.c21 i.c11_lovedone1b i.c11_other1b i.c9_hhold_cat3 i.c9_friend1b $ls2_mdx
margins i.c7_cat5 i.c12_catb i.c17 i.c20 i.c21 i.c11_lovedone1b i.c11_other1b i.c9_hhold_cat3 i.c9_friend1b, atmeans
testparm i.c7_cat5
testparm i.c12_catb
testparm i.c17
testparm i.c20
testparm i.c21
testparm i.c11_lovedone1b
testparm i.c11_other1b
testparm i.c9_hhold_cat3
testparm i.c9_friend1b

*RR
quietly svy: poisson ls3d5_covid_rupa30 i.c7_cat5 i.c12_catb i.c17 i.c20 i.c21 i.c11_lovedone1b i.c11_other1b i.c9_hhold_cat3 i.c9_friend1b, irr 
margins i.c7_cat5 i.c12_catb i.c17 i.c20 i.c21 i.c11_lovedone1b i.c11_other1b i.c9_hhold_cat3 i.c9_friend1b
margins r.c7_cat5, atmeans
margins r.c12_catb, atmeans
margins r.c17, atmeans
margins r.c20, atmeans
margins r.c21, atmeans
margins r.c11_lovedone1b, atmeans
margins r.c11_other1b, atmeans
margins r.c9_hhold_cat3, atmeans
margins r.c9_friend1b, atmeans


log close


