log using "O:\Harvard\king\ls3\covid\new\tables\mv_final_ARD_output.log", replace
use "O:\Harvard\king\ls3\covid\new\data\stressors_ARD_data.dta"

svyset secluster [pweight=weight_lsw3_norm], strata(sestrat) vce(robust) singleunit(centered)
*table p3;
vl create ls2_mdx = (ls2_dx2plus_30 ls2d5_mde30 ls2d5_gad30 ls2d5_pts30 ls2_covid_rupa30)
vl create ls2_demo = (race_cat mast_pm_v002 ls2_milstatus non_hetero ed_cat mhx_cat deployed_wot_num rank_cat)
vl substitute ls2_demo_cat = i.ls2_demo
vl create ls2_demo_cont = (active_years years_since_active)


*mv3
svy: regress  dx1plus30_diff i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat $ls2_mdx 
margins i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat , atmeans
testparm i.age_ls2_cat
testparm i.mast_pm_v002
testparm i.non_hetero
testparm i.race_cat 
testparm i.mhx_cat 
testparm i.deployed_wot_num 
testparm i.rank_cat 
testparm i.ls2_milstatus2 
testparm i.years_since_cat


*mv4
svy: poisson  ls3_dx1plus_30 i.mast_pm_v002 $ls2_mdx, irr 
margins i.mast_pm_v002
svy: regress  dx1plus30_diff i.mast_pm_v002 $ls2_mdx 
svy: regress  ls3_dx1plus_30 i.mast_pm_v002 $ls2_mdx 
svy: regress  ls3_dx1plus_30 i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat $ls2_mdx i.c7_cat5 i.c12_catb3 i.c20 i.c11_lovedone1b i.c9_hhold_cat3 i.c9_friend1b

svy: regress  dx1plus30_diff i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat $ls2_mdx i.c7_cat5 i.c12_catb3 i.c20 i.c11_lovedone1b i.c9_hhold_cat3 i.c9_friend1b
margins i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat i.c7_cat5 i.c12_catb3 i.c20 i.c11_lovedone1b i.c9_hhold_cat3 i.c9_friend1b, atmeans
testparm i.age_ls2_cat
testparm i.mast_pm_v002
testparm i.non_hetero
testparm i.race_cat 
testparm i.mhx_cat 
testparm i.deployed_wot_num 
testparm i.rank_cat 
testparm i.ls2_milstatus2 
testparm i.years_since_cat
testparm i.c7_cat5
testparm i.c12_catb3
testparm i.c20
testparm i.c11_lovedone1b
testparm i.c9_hhold_cat3
testparm i.c9_friend1b
testparm i.c7_cat5 i.c12_catb3 i.c20 i.c11_lovedone1b i.c9_hhold_cat3 i.c9_friend1b



*mv5
svy, subpop(covid_stress_any0): regress  dx1plus30_diff i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat $ls2_mdx 
margins i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat, subpop(covid_stress_any0) atmeans
testparm i.age_ls2_cat
testparm i.mast_pm_v002
testparm i.non_hetero
testparm i.race_cat 
testparm i.mhx_cat 
testparm i.deployed_wot_num 
testparm i.rank_cat 
testparm i.ls2_milstatus2 
testparm i.years_since_cat

*mv6
svy, subpop(covid_stress_any): regress  dx1plus30_diff i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat $ls2_mdx i.c7_cat5 i.c12_catb3 i.c20 i.c11_lovedone1b i.c9_hhold_cat3 i.c9_friend1b
margins i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat i.c7_cat5 i.c12_catb3 i.c20 i.c11_lovedone1b i.c9_hhold_cat3 i.c9_friend1b, subpop(covid_stress_any) atmeans
testparm i.age_ls2_cat
testparm i.mast_pm_v002
testparm i.non_hetero
testparm i.race_cat 
testparm i.mhx_cat 
testparm i.deployed_wot_num 
testparm i.rank_cat 
testparm i.ls2_milstatus2 
testparm i.years_since_cat
testparm i.c7_cat5
testparm i.c12_catb3
testparm i.c20
testparm i.c11_lovedone1b
testparm i.c9_hhold_cat3
testparm i.c9_friend1b
testparm i.c7_cat5 i.c12_catb3 i.c20 i.c11_lovedone1b i.c9_hhold_cat3 i.c9_friend1b




*subgroup coded



*mde;
*linear regression MV models
*mv4
svy: regress  covid_mde30_diff i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat $ls2_mdx i.c7_cat5 i.c12_catb3 i.c20 i.c11_lovedone1b i.c9_hhold_cat3 i.c9_friend1b
margins i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat i.c7_cat5 i.c12_catb3 i.c20 i.c11_lovedone1b i.c9_hhold_cat3 i.c9_friend1b, atmeans
testparm i.age_ls2_cat
testparm i.mast_pm_v002
testparm i.non_hetero
testparm i.race_cat 
testparm i.mhx_cat 
testparm i.deployed_wot_num 
testparm i.rank_cat 
testparm i.ls2_milstatus2 
testparm i.years_since_cat
testparm i.c7_cat5
testparm i.c12_catb3
testparm i.c20
testparm i.c11_lovedone1b
testparm i.c9_hhold_cat3
testparm i.c9_friend1b
testparm i.c7_cat5 i.c12_catb3 i.c20 i.c11_lovedone1b i.c9_hhold_cat3 i.c9_friend1b

*mv5
svy, subpop(covid_stress_any0): regress  covid_mde30_diff i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat $ls2_mdx 
margins i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat, subpop(covid_stress_any0) atmeans
testparm i.age_ls2_cat
testparm i.mast_pm_v002
testparm i.non_hetero
testparm i.race_cat 
testparm i.mhx_cat 
testparm i.deployed_wot_num 
testparm i.rank_cat 
testparm i.ls2_milstatus2 
testparm i.years_since_cat

*mv6
svy, subpop(covid_stress_any): regress  covid_mde30_diff i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat $ls2_mdx i.c7_cat5 i.c12_catb3 i.c20 i.c11_lovedone1b i.c9_hhold_cat3 i.c9_friend1b
margins i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat i.c7_cat5 i.c12_catb3 i.c20 i.c11_lovedone1b i.c9_hhold_cat3 i.c9_friend1b, subpop(covid_stress_any) atmeans
testparm i.age_ls2_cat
testparm i.mast_pm_v002
testparm i.non_hetero
testparm i.race_cat 
testparm i.mhx_cat 
testparm i.deployed_wot_num 
testparm i.rank_cat 
testparm i.ls2_milstatus2 
testparm i.years_since_cat
testparm i.c7_cat5
testparm i.c12_catb3
testparm i.c20
testparm i.c11_lovedone1b
testparm i.c9_hhold_cat3
testparm i.c9_friend1b
testparm i.c7_cat5 i.c12_catb3 i.c20 i.c11_lovedone1b i.c9_hhold_cat3 i.c9_friend1b


*gad;
*mv4
svy: regress  gad30_diff i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat $ls2_mdx i.c7_cat5 i.c12_catb3 i.c20 i.c11_lovedone1b i.c9_hhold_cat3 i.c9_friend1b
margins i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat i.c7_cat5 i.c12_catb3 i.c20 i.c11_lovedone1b i.c9_hhold_cat3 i.c9_friend1b, atmeans
testparm i.age_ls2_cat
testparm i.mast_pm_v002
testparm i.non_hetero
testparm i.race_cat 
testparm i.mhx_cat 
testparm i.deployed_wot_num 
testparm i.rank_cat 
testparm i.ls2_milstatus2 
testparm i.years_since_cat
testparm i.c7_cat5
testparm i.c12_catb3
testparm i.c20
testparm i.c11_lovedone1b
testparm i.c9_hhold_cat3
testparm i.c9_friend1b
testparm i.c7_cat5 i.c12_catb3 i.c20 i.c11_lovedone1b i.c9_hhold_cat3 i.c9_friend1b

*mv5
svy, subpop(covid_stress_any0): regress  gad30_diff i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat $ls2_mdx 
margins i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat, subpop(covid_stress_any0) atmeans
testparm i.age_ls2_cat
testparm i.mast_pm_v002
testparm i.non_hetero
testparm i.race_cat 
testparm i.mhx_cat 
testparm i.deployed_wot_num 
testparm i.rank_cat 
testparm i.ls2_milstatus2 
testparm i.years_since_cat

*mv6
svy, subpop(covid_stress_any): regress  gad30_diff i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat $ls2_mdx i.c7_cat5 i.c12_catb3 i.c20 i.c11_lovedone1b i.c9_hhold_cat3 i.c9_friend1b
margins i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat i.c7_cat5 i.c12_catb3 i.c20 i.c11_lovedone1b i.c9_hhold_cat3 i.c9_friend1b, subpop(covid_stress_any) atmeans
testparm i.age_ls2_cat
testparm i.mast_pm_v002
testparm i.non_hetero
testparm i.race_cat 
testparm i.mhx_cat 
testparm i.deployed_wot_num 
testparm i.rank_cat 
testparm i.ls2_milstatus2 
testparm i.years_since_cat
testparm i.c7_cat5
testparm i.c12_catb3
testparm i.c20
testparm i.c11_lovedone1b
testparm i.c9_hhold_cat3
testparm i.c9_friend1b
testparm i.c7_cat5 i.c12_catb3 i.c20 i.c11_lovedone1b i.c9_hhold_cat3 i.c9_friend1b




*ptsd;
*mv4
svy: regress  pts30_diff i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat $ls2_mdx i.c7_cat5 i.c12_catb3 i.c20 i.c11_lovedone1b i.c9_hhold_cat3 i.c9_friend1b
margins i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat i.c7_cat5 i.c12_catb3 i.c20 i.c11_lovedone1b i.c9_hhold_cat3 i.c9_friend1b, atmeans
testparm i.age_ls2_cat
testparm i.mast_pm_v002
testparm i.non_hetero
testparm i.race_cat 
testparm i.mhx_cat 
testparm i.deployed_wot_num 
testparm i.rank_cat 
testparm i.ls2_milstatus2 
testparm i.years_since_cat
testparm i.c7_cat5
testparm i.c12_catb3
testparm i.c20
testparm i.c11_lovedone1b
testparm i.c9_hhold_cat3
testparm i.c9_friend1b
testparm i.c7_cat5 i.c12_catb3 i.c20 i.c11_lovedone1b i.c9_hhold_cat3 i.c9_friend1b

*mv5
svy, subpop(covid_stress_any0): regress  pts30_diff i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat $ls2_mdx 
margins i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat, subpop(covid_stress_any0) atmeans
testparm i.age_ls2_cat
testparm i.mast_pm_v002
testparm i.non_hetero
testparm i.race_cat 
testparm i.mhx_cat 
testparm i.deployed_wot_num 
testparm i.rank_cat 
testparm i.ls2_milstatus2 
testparm i.years_since_cat

*mv6
svy, subpop(covid_stress_any): regress  pts30_diff i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat $ls2_mdx i.c7_cat5 i.c12_catb3 i.c20 i.c11_lovedone1b i.c9_hhold_cat3 i.c9_friend1b
margins i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat i.c7_cat5 i.c12_catb3 i.c20 i.c11_lovedone1b i.c9_hhold_cat3 i.c9_friend1b, subpop(covid_stress_any) atmeans
testparm i.age_ls2_cat
testparm i.mast_pm_v002
testparm i.non_hetero
testparm i.race_cat 
testparm i.mhx_cat 
testparm i.deployed_wot_num 
testparm i.rank_cat 
testparm i.ls2_milstatus2 
testparm i.years_since_cat
testparm i.c7_cat5
testparm i.c12_catb3
testparm i.c20
testparm i.c11_lovedone1b
testparm i.c9_hhold_cat3
testparm i.c9_friend1b
testparm i.c7_cat5 i.c12_catb3 i.c20 i.c11_lovedone1b i.c9_hhold_cat3 i.c9_friend1b



*panic demo models;
*mv4
svy: regress  covid_rupa30_diff i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat $ls2_mdx i.c7_cat5 i.c12_catb3 i.c20 i.c11_lovedone1b i.c9_hhold_cat3 i.c9_friend1b
margins i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat i.c7_cat5 i.c12_catb3 i.c20 i.c11_lovedone1b i.c9_hhold_cat3 i.c9_friend1b, atmeans
testparm i.age_ls2_cat
testparm i.mast_pm_v002
testparm i.non_hetero
testparm i.race_cat 
testparm i.mhx_cat 
testparm i.deployed_wot_num 
testparm i.rank_cat 
testparm i.ls2_milstatus2 
testparm i.years_since_cat
testparm i.c7_cat5
testparm i.c12_catb3
testparm i.c20
testparm i.c11_lovedone1b
testparm i.c9_hhold_cat3
testparm i.c9_friend1b
testparm i.c7_cat5 i.c12_catb3 i.c20 i.c11_lovedone1b i.c9_hhold_cat3 i.c9_friend1b

*mv5
svy, subpop(covid_stress_any0): regress  covid_rupa30_diff i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat $ls2_mdx 
margins i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat, subpop(covid_stress_any0) atmeans
testparm i.age_ls2_cat
testparm i.mast_pm_v002
testparm i.non_hetero
testparm i.race_cat 
testparm i.mhx_cat 
testparm i.deployed_wot_num 
testparm i.rank_cat 
testparm i.ls2_milstatus2 
testparm i.years_since_cat

*mv6
svy, subpop(covid_stress_any): regress  covid_rupa30_diff i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat $ls2_mdx i.c7_cat5 i.c12_catb3 i.c20 i.c11_lovedone1b i.c9_hhold_cat3 i.c9_friend1b
margins i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat i.c7_cat5 i.c12_catb3 i.c20 i.c11_lovedone1b i.c9_hhold_cat3 i.c9_friend1b, subpop(covid_stress_any) atmeans
testparm i.age_ls2_cat
testparm i.mast_pm_v002
testparm i.non_hetero
testparm i.race_cat 
testparm i.mhx_cat 
testparm i.deployed_wot_num 
testparm i.rank_cat 
testparm i.ls2_milstatus2 
testparm i.years_since_cat
testparm i.c7_cat5
testparm i.c12_catb3
testparm i.c20
testparm i.c11_lovedone1b
testparm i.c9_hhold_cat3
testparm i.c9_friend1b
testparm i.c7_cat5 i.c12_catb3 i.c20 i.c11_lovedone1b i.c9_hhold_cat3 i.c9_friend1b


log close


