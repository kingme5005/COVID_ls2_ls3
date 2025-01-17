log using "O:\Harvard\king\ls3\covid\new\tables\make_ARD_stressors_ak052424.log", replace
use "O:\Harvard\king\ls3\covid\new\data\stressors_ARD_data.dta"

svyset secluster [pweight=weight_lsw3_norm], strata(sestrat) vce(robust) singleunit(centered)

*linear regression MV models


*hospitalization
quietly svy: poisson c7_cat5 i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat i.ls2_dx2plus_30 i.ls2d5_mde30 i.ls2d5_gad30 i.ls2d5_pts30 i.ls2_covid_rupa30, irr 
margins i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat i.ls2_dx2plus_30 i.ls2d5_mde30 i.ls2d5_gad30 i.ls2d5_pts30 i.ls2_covid_rupa30, atmeans
margins r.age_ls2_cat r.race_cat r.mast_pm_v002 r.non_hetero r.mhx_cat r.deployed_wot_num r.rank_cat r.ls2_milstatus2 r.years_since_cat r.ls2_dx2plus_30 r.ls2d5_mde30 r.ls2d5_gad30 r.ls2d5_pts30 r.ls2_covid_rupa30, atmeans
svy: regress c7_cat5 i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat i.ls2_dx2plus_30 i.ls2d5_mde30 i.ls2d5_gad30 i.ls2d5_pts30 i.ls2_covid_rupa30
testparm i.ls2_dx2plus_30 i.ls2d5_mde30 i.ls2d5_gad30 i.ls2d5_pts30 i.ls2_covid_rupa30
testparm i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat
testparm i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat

*lockdown
quietly svy: poisson c12_catb3 i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat i.ls2_dx2plus_30 i.ls2d5_mde30 i.ls2d5_gad30 i.ls2d5_pts30 i.ls2_covid_rupa30, irr 
margins i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat i.ls2_dx2plus_30 i.ls2d5_mde30 i.ls2d5_gad30 i.ls2d5_pts30 i.ls2_covid_rupa30, atmeans
margins r.age_ls2_cat r.race_cat r.mast_pm_v002 r.non_hetero r.mhx_cat r.deployed_wot_num r.rank_cat r.ls2_milstatus2 r.years_since_cat r.ls2_dx2plus_30 r.ls2d5_mde30 r.ls2d5_gad30 r.ls2d5_pts30 r.ls2_covid_rupa30, atmeans
svy: regress c12_catb3 i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat i.ls2_dx2plus_30 i.ls2d5_mde30 i.ls2d5_gad30 i.ls2d5_pts30 i.ls2_covid_rupa30
testparm i.ls2_dx2plus_30 i.ls2d5_mde30 i.ls2d5_gad30 i.ls2d5_pts30 i.ls2_covid_rupa30
testparm i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat
testparm i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat


*lost job
quietly svy: poisson c20 i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat i.ls2_dx2plus_30 i.ls2d5_mde30 i.ls2d5_gad30 i.ls2d5_pts30 i.ls2_covid_rupa30, irr 
margins i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat i.ls2_dx2plus_30 i.ls2d5_mde30 i.ls2d5_gad30 i.ls2d5_pts30 i.ls2_covid_rupa30, atmeans
margins r.age_ls2_cat r.race_cat r.mast_pm_v002 r.non_hetero r.mhx_cat r.deployed_wot_num r.rank_cat r.ls2_milstatus2 r.years_since_cat r.ls2_dx2plus_30 r.ls2d5_mde30 r.ls2d5_gad30 r.ls2d5_pts30 r.ls2_covid_rupa30, atmeans
svy: regress c20 i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat i.ls2_dx2plus_30 i.ls2d5_mde30 i.ls2d5_gad30 i.ls2d5_pts30 i.ls2_covid_rupa30
testparm i.ls2_dx2plus_30 i.ls2d5_mde30 i.ls2d5_gad30 i.ls2d5_pts30 i.ls2_covid_rupa30
testparm i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat
testparm i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat

*death of a loved one
quietly svy: poisson c11_lovedone1b i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat i.ls2_dx2plus_30 i.ls2d5_mde30 i.ls2d5_gad30 i.ls2d5_pts30 i.ls2_covid_rupa30, irr 
margins i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat i.ls2_dx2plus_30 i.ls2d5_mde30 i.ls2d5_gad30 i.ls2d5_pts30 i.ls2_covid_rupa30, atmeans
margins r.age_ls2_cat r.race_cat r.mast_pm_v002 r.non_hetero r.mhx_cat r.deployed_wot_num r.rank_cat r.ls2_milstatus2 r.years_since_cat r.ls2_dx2plus_30 r.ls2d5_mde30 r.ls2d5_gad30 r.ls2d5_pts30 r.ls2_covid_rupa30, atmeans
svy: regress c11_lovedone1b i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat i.ls2_dx2plus_30 i.ls2d5_mde30 i.ls2d5_gad30 i.ls2d5_pts30 i.ls2_covid_rupa30
testparm i.ls2_dx2plus_30 i.ls2d5_mde30 i.ls2d5_gad30 i.ls2d5_pts30 i.ls2_covid_rupa30
testparm i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat
testparm i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat


*household members infected
quietly svy: poisson c9_hhold_cat3 i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat i.ls2_dx2plus_30 i.ls2d5_mde30 i.ls2d5_gad30 i.ls2d5_pts30 i.ls2_covid_rupa30, irr 
margins i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat i.ls2_dx2plus_30 i.ls2d5_mde30 i.ls2d5_gad30 i.ls2d5_pts30 i.ls2_covid_rupa30, atmeans
margins r.age_ls2_cat r.race_cat r.mast_pm_v002 r.non_hetero r.mhx_cat r.deployed_wot_num r.rank_cat r.ls2_milstatus2 r.years_since_cat r.ls2_dx2plus_30 r.ls2d5_mde30 r.ls2d5_gad30 r.ls2d5_pts30 r.ls2_covid_rupa30, atmeans
svy: regress c9_hhold_cat3 i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat i.ls2_dx2plus_30 i.ls2d5_mde30 i.ls2d5_gad30 i.ls2d5_pts30 i.ls2_covid_rupa30
testparm i.ls2_dx2plus_30 i.ls2d5_mde30 i.ls2d5_gad30 i.ls2d5_pts30 i.ls2_covid_rupa30
testparm i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat
testparm i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat


*friends infected
quietly svy: poisson c9_friend1b i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat i.ls2_dx2plus_30 i.ls2d5_mde30 i.ls2d5_gad30 i.ls2d5_pts30 i.ls2_covid_rupa30, irr 
margins i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat i.ls2_dx2plus_30 i.ls2d5_mde30 i.ls2d5_gad30 i.ls2d5_pts30 i.ls2_covid_rupa30, atmeans
margins r.age_ls2_cat r.race_cat r.mast_pm_v002 r.non_hetero r.mhx_cat r.deployed_wot_num r.rank_cat r.ls2_milstatus2 r.years_since_cat r.ls2_dx2plus_30 r.ls2d5_mde30 r.ls2d5_gad30 r.ls2d5_pts30 r.ls2_covid_rupa30, atmeans
svy: regress c9_friend1b i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat i.ls2_dx2plus_30 i.ls2d5_mde30 i.ls2d5_gad30 i.ls2d5_pts30 i.ls2_covid_rupa30
testparm i.ls2_dx2plus_30 i.ls2d5_mde30 i.ls2d5_gad30 i.ls2d5_pts30 i.ls2_covid_rupa30
testparm i.age_ls2_cat i.race_cat i.mast_pm_v002 i.non_hetero i.mhx_cat
testparm i.deployed_wot_num i.rank_cat i.ls2_milstatus2 i.years_since_cat

log close 