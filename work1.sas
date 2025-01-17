libname home "/home/data/Harvard/king/ls3/covid/new/data/";
libname mc "/home/data/Harvard/Hwang/AAG_Constructs/2019/DATA/";
LIBNAME aagcons "/home/data/Harvard/king/aag_constructs/data2019/" ;
libname svy "/home/data/Harvard/Hwang/STARRSLS/";
*libname masha "/home/user/mpetukh/LS3/covid/data";
libname masha "/home/data/VARIABLES/STARRSLS_VARS/HARVARD/5_LSW3_Variables/DATA/weights/";
libname hdata "/home/data/Harvard/Hwang/STARRSLS/Separation/DATA/";
libname covid "/home/data/Harvard/Hwang/STARRSLS/AnalyticFiles_NEW/4a_LSW2_Covid_Variables/DATA/";
libname ls3y "/home/data/Harvard/Hwang/STARRSLS/AnalyticFiles_NEW/5_LSW3_variables/DATA/";
libname ls2y "/home/data/Harvard/Hwang/STARRSLS/AnalyticFiles_NEW/4_LSW2_Variables/DATA/";
*libname ls3 "/home/data/ArmySTARRS/LSW3/DataDelivery/Replicate 1-8/";
libname ls3 "/home/data/ArmySTARRS/LSW3/DataDelivery/Replicate 1-14/";

options nofmterr;
ods html file = "/home/data/Harvard/king/ls3/covid/new/tables/ctab/stacked_ls1_ls2_contents.html";
proc contents data=hdata.comp_at_survey_prels order=varnum; run;
ods html close;

data reg_at_survey;
	set hdata.comp_at_survey_prels;

	keep masterid reg_at_survey;
	label reg_at_survey = "Regular Army vs G/R at baseline STARRS survey";
	proc sort; by masterid;
run;

data weights;
	set masha.lsw3_weight_aasppds (in=a rename=(secluster=secluster2))
		masha.lsw3_weight_nss;

	if a then secluster=input(secluster2, 8.);
	drop secluster2;
	proc sort; by masterid;
run;

*depression and panic;
data ls3_outcomes_covid;
	set covid.covid_lsw3_diagnosis_1_14_allf;

	keep masterid ls3d5_covid_rupa30 ls3d5_covid_mde30;
	proc freq; tables ls3d5_covid_rupa30 ls3d5_covid_mde30 /missing;
	proc sort; by masterid;
run;
*GAD and PTSD;
data ls3_outcomes;
	set ls3y.lsw3_diagnosis_suicide;

	keep masterid ls3d5_gad30 ls3d5_pts30;
	proc sort; by masterid;
run;

*ls2 covid panic;
data ls2_outcomes_covid;
	set covid.ls2_newcovid_dx;

	keep masterid ls2_covid_rupa30 ;
	proc sort; by masterid;
run;
*ls2 mde GAD and PTSD;
data ls2_outcomes;
	set ls2y.lsw2_diagnosis;

	in_ls2=1;
	keep masterid ls2d5_mde30 ls2d5_gad30 ls2d5_pts30 in_ls2;
	proc sort; by masterid;
run;

data ls3_milstatus;
	set ls3.starrslsw3_rep1_14_20220221;

	*LS3 military status;
	if milstatus in (1,2) then milstatus_ls3_cat=1;*active regular army;
	else if milstatus in (3,4,5) then milstatus_ls3_cat=2;*active duty G/R;
	else if milstatus in (6,7,8) then milstatus_ls3_cat=3;*inactive duty G/R;
	else if milstatus ge 9 then milstatus_ls3_cat=4;*separated/retired;
	*if missing go to LS2 survey;
		else if PL_W2Milstatus in (1,2) then milstatus_ls3_cat=1;*active regular army;
		else if PL_W2Milstatus in (3,4,5) then milstatus_ls3_cat=2;*active duty G/R;
		else if PL_W2Milstatus in (6,7,8) then milstatus_ls3_cat=3;*inactive duty G/R;
		else if PL_W2Milstatus ge 9 then milstatus_ls3_cat=4;*separated/retired;
	*if missing go to LS1 survey;
		else if PL_W1Milstatus in (1,2) then milstatus_ls3_cat=1;*active regular army;
		else if PL_W1Milstatus in (3,4,5) then milstatus_ls3_cat=2;*active duty G/R;
		else if PL_W1Milstatus in (6,7,8) then milstatus_ls3_cat=3;*inactive duty G/R;
		else if PL_W1Milstatus ge 9 then milstatus_ls3_cat=4;*separated/retired;
		else milstatus_ls3_cat=4;*set the n=1 missing to separated/retired;

	*ls2 military status;
	if PL_W2Milstatus in (1,2) then milstatus_ls2_cat=1;*active regular army;
		else if PL_W2Milstatus in (3,4,5) then milstatus_ls2_cat=2;*active duty G/R;
		else if PL_W2Milstatus in (6,7,8) then milstatus_ls2_cat=3;*inactive duty G/R;
		else if PL_W2Milstatus ge 9 then milstatus_ls2_cat=4;*separated/retired;
	*if missing go to LS1 survey;
		else if PL_W1Milstatus in (1,2) then milstatus_ls2_cat=1;*active regular army;
		else if PL_W1Milstatus in (3,4,5) then milstatus_ls2_cat=2;*active duty G/R;
		else if PL_W1Milstatus in (6,7,8) then milstatus_ls2_cat=3;*inactive duty G/R;
		else if PL_W1Milstatus ge 9 then milstatus_ls2_cat=4;*separated/retired;
		else milstatus_ls2_cat=4;*set the n=1 missing to separated/retired;

	array dummya (4) 3. milstatus_ls3_cat1-milstatus_ls3_cat4;
	do i=1 to 4;
		dummya(i)=0;
	end;
	dummya(milstatus_ls3_cat)=1;

	array dummyb (4) 3. milstatus_ls2_cat1-milstatus_ls2_cat4;
	do i=1 to 4;
		dummyb(i)=0;
	end;
	dummyb(milstatus_ls2_cat)=1;

	label 	milstatus_ls2_cat1 = "ls2 military status: active duty regular army"
			milstatus_ls2_cat2 = "ls2 military status: active duty guard/reserve"
			milstatus_ls2_cat3 = "ls2 military status: inactive duty guard/reserve"
			milstatus_ls2_cat4 = "ls2 military status: separated/retired"
			milstatus_ls3_cat1 = "LS3 military status: active duty regular army"
			milstatus_ls3_cat2 = "LS3 military status: active duty guard/reserve"
			milstatus_ls3_cat3 = "LS3 military status: inactive duty guard/reserve"
			milstatus_ls3_cat4 = "LS3 military status: separated/retired";
	keep 	masterid 
			milstatus_ls2_cat1-milstatus_ls2_cat4
			milstatus_ls3_cat1-milstatus_ls3_cat4;
	proc sort; by masterid;
run;

data ls2_mdx_scales;
	set hdata.ls2_surveydata;
	
	array axa(30) 	MD_WRSTDEP_A MD_WRSTDEP_c MD_WRSTDEP_d MD_WRSTDEP_e
					MD_P30DDep_a MD_p30ddep_c MD_p30ddep_d MD_p30ddep_e			
					GAD_WrstAnx_a GAD_WrstAnx_b GAD_WrstAnx_c GAD_WrstAnx_d GAD_WrstAnx_e
					GAD_P30DAnx_a GAD_p30danx_b GAD_p30danx_c GAD_p30danx_d GAD_p30danx_e
					PT_WRSTREACTIONS_A PT_WRSTREACTIONS_B PT_WRSTREACTIONS_C PT_WRSTREACTIONS_D PT_WRSTREACTIONS_G PT_WRSTREACTIONS_h
					PT_p30dreactbother_A PT_p30dreactbother_E PT_p30dreactbother_II PT_p30dreactbother_JJ PT_p30dreactbother_O PT_p30dreactbother_Q;
	do i=1 to 30;
		axa(i)=6-axa(i);
		if axa(i) lt 1 then axa(i)=.;
	end;

	*create scales;
	ls2_md4_30d=sum(MD_P30DDep_a, MD_p30ddep_c, MD_p30ddep_d, MD_p30ddep_e);
	ls2_gad5_30d=sum(GAD_P30DAnx_a, GAD_p30danx_b, GAD_p30danx_c, GAD_p30danx_d, GAD_p30danx_e);
	ls2_ptsd6_30d=sum(PT_p30dreactbother_A, PT_p30dreactbother_E, PT_p30dreactbother_II, PT_p30dreactbother_JJ, PT_p30dreactbother_O, PT_p30dreactbother_Q);

	in_ls2=1;
	keep 	masterid in_ls2
			ls2_md4_30d ls2_gad5_30d ls2_ptsd6_30d ;
	proc sort; by masterid;
run;

data last_mc_predictor;
	set aagcons.mc_predictors;
	by masterid;
	if last.masterid then output;
	proc sort nodupkey; by masterid;
run;

data last_dx;
	set aagcons.admin_dx;
	by masterid;
	if last.masterid then output;
run;
*suicide attempt;
data last_sa;
	set aagcons.admin_sa;
	by masterid;
	if last.masterid then output;

	keep 	masterid
			suicide_attempt
			pm_mdr_e95_icd10_pd_v001
			suicide_ideation;
run;
*asmis;
data last_asmis;
	set aagcons.admin_asmis;
	by masterid;
	if last.masterid then output;
	proc sort nodupkey; by masterid;
run;
*crime;
data last_crime;
	set aagcons.admin_crime;
	by masterid;
	if last.masterid then output;
	proc sort nodupkey; by masterid;
run;
*damis;
data last_damis;
	set aagcons.admin_damis;
	by masterid;
	if last.masterid then output;
	proc sort nodupkey; by masterid;
run;
*edes;
data last_edes;
	set aagcons.admin_edes;
	by masterid;
	if last.masterid then output;
	proc sort nodupkey; by masterid;
run;
*mepcom;
data last_mepcom;
	set aagcons.admin_mepcom;
	by masterid;
	if last.masterid then output;
	proc sort nodupkey; by masterid;
run;
*payroll;
data last_payroll;
	set aagcons.admin_payroll;
	by masterid;
	if last.masterid then output;
	proc sort nodupkey; by masterid;
run;
*rx;
data last_rx;
	set aagcons.admin_rx;
	by masterid;
	if last.masterid then output;
	proc sort nodupkey; by masterid;
run;
*wounded warrior / warrior transition unit;
data last_ww;
	set aagcons.admin_ww;
	by masterid;
	if last.masterid then output;
	keep 	masterid 
			lt_ww lt_wtu in_ww in_wtu
			in_ww_12m in_wtu_12m
			ww_suicide_risk_score
			sum_nra
			ww_riskass_12m
			ww_suirisk_12m;
	proc sort nodupkey; by masterid;
run;
*polypharmacy;
data last_poly;
	set aagcons.apds_poly;
	by masterid;
	if last.masterid then output;
	proc sort nodupkey; by masterid;
run;
*severe injury;
data last_sevinj;
	set aagcons.apds_sevinj;
	by masterid;
	if last.masterid then output;
	proc sort nodupkey; by masterid;
run;
*weapons;
data last_weapons;
	set aagcons.weapons;
	by masterid;
	if last.masterid then output;
	proc sort nodupkey; by masterid;
run;
*MOS;
data last_mos;
	set aagcons.mos2019;
	by masterid;
	if last.masterid then output;
	keep masterid duty_moscat4;
	rename duty_moscat4=duty_moscat;
	proc sort nodupkey; by masterid;
run;
data last_mos;
	set last_mos;

	if duty_moscat eq . then delete;
	array dummya (4) 3. duty_moscat1-duty_moscat4;
	do i=1 to 4;
		dummya(i)=0;
	end;
	dummya(duty_moscat)=1;

	duty_moscat1_2=0;
	if duty_moscat in (1,2) then duty_moscat1_2=1;

	label 	duty_moscat1 = "MOS: direct combat arms"
			duty_moscat2 = "MOS: indirect combat arms"
			duty_moscat1_2 = "MOS: combat arms"
			duty_moscat3 = "MOS: combat support"
			duty_moscat4 = "MOS: combat service support";
	drop 	i duty_moscat;
run;

*tapas;
data last_tapas;
	set aagcons.admin_tapas;
	by masterid;
	if last.masterid then output;
	proc sort nodupkey; by masterid;
run;


data survey_vars;

	merge  ls2y.lsw2_diagnosis (in=a)
			ls2y.lsw2_lttrauma
			ls2y.datingstatus_imputed_ls2
			ls2y.lsw2_tbi
			ls2y.lsw2_children
			ls2y.ls2_allmdxdata
			ls2_mdx_scales;
	by masterid;
	if a=1;

	if lsw2_total_att eq . then lsw2_total_att=0;*set missings to 0 for # attempts variable;

	keep 	masterid
			ls2d5_ad6 ls2d5_alc30 ls2d5_drg30
			/*ls2oa_mdelt ls2oa_ptslt ls2oa_gadlt*/ ls2d5_iedlt
			ls2d5_manialt ls2d5_bipolarIlt ls2d5_bipolarIIlt			
			ls2oa_pdlt
			ls2d5_hyplt;*
			lsoa_addlt lsoa_sublt lsoa_mania_broad_lt lsoa_iedlt cd_odd_scale 
			attempt_lt_lsw2 lsw2_total_att 
			plan_lt_lsw2 ideation_lt_lsw2
			any_tbi
			HE_P30DPainSeverity_ls2
			PT_StressAreas_A_ls2
			PT_StressAreas_B_ls2
			PT_StressAreas_C_ls2
			PT_StressAreas_D_ls2
			PT_StressAreas_F_ls2
			PT_StressAreas_H_ls2
			PT_StressAreas_I_ls2
			PT_StressAreas_QQ_ls2
			PT_StressAreas_J_ls2
			ce_pdied
ce_psd
ce_psuicide
ce_pprison
ce_juv
ce_foster
ce_pmental
ce_substance
ce_welfare
ce_homeless
ce_dangerous
ce_takecare
ce_neglect
ce_sharrassed
ce_insult
ce_hate
ce_emoabuse
ce_sexualabuse
ds_ls2_combatpatrol
ds_ls2_firerounds
ds_ls2_getwounded
ds_ls2_closecall
ds_ls2_enemydeath
ds_ls2_noncombatdeath
ds_ls2_allydeath
ds_ls2_savelife
ds_ls2_svillagedestroy
ds_ls2_exposesevere
ds_ls2_witnessviol
ds_ls2_physassualt
ds_ls2_sexassualt
ds_ls2_bullied
lte_ls2_physassualt
lte_ls2_sexsassualt
lte_ls2_physsex_assault
lte_ls2_illinjury
lte_ls2_disaster
lte_ls2_anyother
lte_ls2_loveonedeath
lte_ls2_witnessinj
lte_ls2_handledead
lte_ls2_exposed
lte_ls2_other
scale_borderline
scale_antisocial
scale_anger
scale_resilience
any_biochildren_LS2
any_stepchildren_LS2
any_children_LS2
sn_nonhetero
CA_BornUS_d
parentbornus_num
parented_cat
religiosity
rel_sum_fundamental
datingstatus

ls2_md4_30d ls2_gad5_30d ls2_ptsd6_30d

;
run;

/*;
proc stdize data=survey_vars out=survey_vars2 method=median reponly;
	var 	
 any_tbi ds_ls2_combatpatrol
			ds_ls2_firerounds
			ds_ls2_getwounded
			ds_ls2_closecall
			ds_ls2_enemydeath
			ds_ls2_noncombatdeath
			ds_ls2_allydeath
			ds_ls2_savelife
			ds_ls2_svillagedestroy
			ds_ls2_exposesevere
			ds_ls2_witnessviol
			ds_ls2_physassualt
			ds_ls2_sexassualt
			ds_ls2_bullied
			lte_ls2_physassualt
			lte_ls2_sexsassualt
			lte_ls2_physsex_assault
			lte_ls2_illinjury
			lte_ls2_disaster
			lte_ls2_anyother
			lte_ls2_loveonedeath
			lte_ls2_witnessinj
			lte_ls2_handledead
			lte_ls2_exposed
			lte_ls2_other;
*HE_P30DPainSeverity_ls2
			PT_StressAreas_A_ls2
			PT_StressAreas_B_ls2
			PT_StressAreas_C_ls2
			PT_StressAreas_D_ls2
			PT_StressAreas_F_ls2
			PT_StressAreas_H_ls2
			PT_StressAreas_I_ls2
			PT_StressAreas_QQ_ls2
			PT_StressAreas_J_ls2
			ce_pdied
ce_psd
ce_psuicide
ce_pprison
ce_juv
ce_foster
ce_pmental
ce_substance
ce_welfare
ce_homeless
ce_dangerous
ce_takecare
ce_neglect
ce_sharrassed
ce_insult
ce_hate
ce_emoabuse
ce_sexualabuse

			
			
			sn_nonhetero
			CA_BornUS_d
			parentbornus_num
			parented_cat
			religiosity
			rel_sum_fundamental
			datingstatus;
run;
*/*;

data covid_stressors;
	*set masha.forr_obj;
	set ls3.starrslsw3_rep1_14_20220221;

** C3;
 if cvd_diagnosed = 1 then C3 = 1;else C3 = 0;
 ** C4;
 if cvd_testpositive = 1 then C4 = 1; else C4 = 0;
** Composite;
 if c3 = 1 or c4 = 1 then C3C4 = 1; else C3C4 = 0;
 label C3 = "Tested positive for COVID: 0-no,1-yes"
 C4 = "Diagnosed with COVID: 0-no,1-yes"
 C3C4 = "Either tested positive or diagnosed with COVID: 0-no,1-yes";
 ** C7 = covid tx ;
 * nmiss=3, imputed at 3=quarantine; 
i_C7=0 ;
if CVD_Checkpoint_04=.  and CVD_SymptomsTX <= .z then i_C7=1 ; 
if CVD_Checkpoint_04 ne . and CVD_SymptomsTX <= .z then C7=0 ; 
else C7= 6-CVD_SymptomsTx ; 
if CVD_SymptomsTX >=8 then c7=0;
if i_C7=1 then C7= 3 ; 
label 
 C7= "Covid Tx: 0=never had covid, 1=didnt get tx, 2=self tx, 3=quarantine, 4=hospitalized not intubated, 5=hospitalized and intubated" ;

** C9 = who was infected; 
 if 1 <= CVD_PplInfected_a <= 10 then C9_1_family = CVD_PplInfected_a;
 else if 10 < CVD_PplInfected_a < 999 then C9_1_family = 10;
 else if CVD_KnowOthers = 5 then C9_1_family = 1;
 else C9_1_family = 0; ** Impute to the median;

  if 1 <= CVD_PplInfected_b <= 10 then C9_2_lovedone = CVD_PplInfected_b;
 else if 10 < CVD_PplInfected_b < 999 then C9_2_lovedone = 10;
else if CVD_KnowOthers = 5 then C9_2_lovedone = 0;
else C9_2_lovedone = 1; ** Impute to the median;

 if 1 <= CVD_PplInfected_c <= 10 then C9_3_workmate = CVD_PplInfected_c;
 else if 10 < CVD_PplInfected_c < 999 then C9_3_workmate = 10;
 else if CVD_KnowOthers = 5 then C9_3_workmate = 0;
 else C9_3_workmate = 2; ** Impute to the median;

 if 1 <= CVD_PplInfected_d <= 10 then C9_4_friend = CVD_PplInfected_d;
 else if 10 < CVD_PplInfected_d < 999 then C9_4_friend = 10;
 else if CVD_KnowOthers = 5 then C9_4_friend = 0;
 else C9_4_friend = 0; ** Impute to the median;

 if 1 <= CVD_PplInfected_e <= 10 then C9_5_other = CVD_PplInfected_e;
 else if 10 < CVD_PplInfected_e < 999 then C9_5_other = 10;
 else if CVD_KnowOthers = 5 then C9_5_other = 0;
 else C9_5_other = 1; ** Impute to the median;

C9_6_relative = C9_1_family + C9_2_lovedone;
C9_7_close = C9_1_family + C9_2_lovedone + C9_3_workmate + C9_4_friend;
C9_8_all = C9_1_family + C9_2_lovedone + C9_3_workmate + C9_4_friend + C9_5_other;

label C9_1_family = "C9 COVID someone living with infected"
C9_2_lovedone = "C9 COVID loved ones infected"
C9_3_workmate = "C9 COVID coworkers infected"
C9_4_friend = "C9 COVID friends infected"
C9_5_other = "C9 COVID others infected"
C9_6_relative = "C9 COVID relatives infected"
C9_7_close = "C9 COVID friends or family infected"
C9_8_all = "C9 COVID all known infected"
;

** C11 = who died; 
 array _died[7] CVD_WhoDied_1 - CVD_WhoDied_7 ; 
  do i = 1 to 7 ; 
   if _died[i]=1 then C11_1_parent=1 ; 
   if _died[i]=2 then C11_2_spouse=1 ; 
   if _died[i]=3 then C11_3_child =1 ; 
   if _died[i]=4 then C11_4_relative=1 ; 
   if _died[i]=5 then C11_5_workmate=1 ; 
   if _died[i]=6 then C11_6_friend=1 ; 
   if _died[i]=7 then C11_7_other=1 ; 
 end ; 
 drop i ; 

 if C11_0_none=. then C11_0_none=0 ; 
 if C11_1_parent=. then C11_1_parent=0 ; 
 if C11_2_spouse=. then C11_2_spouse=0 ;
 if C11_3_child=. then C11_3_child=0 ; 
 if C11_4_relative=. then C11_4_relative=0  ; 
 if C11_5_workmate=. then C11_5_workmate=0 ; 
 if C11_6_friend=. then C11_6_friend=0 ; 
 if C11_7_other=. then C11_7_other=0 ; 

  C11_n = sum(C11_1_parent, C11_2_spouse, C11_3_child, C11_4_relative, C11_5_workmate, C11_6_friend, C11_7_other) ; 

if CVD_Checkpoint_05=2 OR CVD_Checkpoint_06=2 OR CVD_Checkpoint_07=1 and CVD_WhoDied_1=. then
   C11_0_none = 1 ; 
 else if CVD_Checkpoint_07=2 and CVD_WhoDied_1 <= .z then i_C11=1 ;
 if i_C11=. then i_C11=0 ; 
label  i_C11= "C11 imputed, Covid who died" ; 

if i_C11=1 and C11_n=0 then do ; C11_7_other=1 ; C11_n=1 ; end ; 

  C11_8_spschild = sum(C11_2_spouse, C11_3_child) ; 
  C11_9_closerel = sum(C11_1_parent, C11_2_spouse, C11_3_child) ; 
  C11_10_relative = sum(C11_1_parent, C11_2_spouse, C11_3_child, C11_4_relative) ; 
  C11_11_relfriend = sum(C11_1_parent, C11_2_spouse, C11_3_child, C11_4_relative, C11_5_workmate, C11_6_friend) ; 


label 
 C11_0_none = "C11 Covid no one Died: 0=No, 1=Yes" 
 C11_1_parent = "C11 Covid Parent Died: 0=No, 1=Yes" 
 C11_2_spouse = "C11 Covid spouse Died: 0=No, 1=Yes" 
 C11_3_child = "C11 Covid child Died: 0=No, 1=Yes" 
 C11_4_relative = "C11 Covid close relative Died: 0=No, 1=Yes" 
 C11_5_workmate = "C11 Covid workmate Died: 0=No, 1=Yes" 
 C11_6_friend = "C11 Covid close friend Died: 0=No, 1=Yes" 
 C11_7_other = "C11 Covid other Died: 0=No, 1=Yes" 
 C11_8_spschild = "C11 Covid spouse or child died: 0-2"
 C11_9_closerel = "C11 Covid parent,spouse or child died: 0-3"
 C11_10_relative = "C11 Covid relative died: 0-4"
 C11_11_relfriend = "C11 Covid relative or friend died: 0-6";

if CVD_lockdown in (.,99,.D,.R) then C12 = 6; ** Impute to the median;
else if CVD_lockdown > 10 then C12 = 10;
else C12 = CVD_lockdown;

label C12 = "C12 Weeks in lockdown";

if CVD_quarantine = 1 or CVD_symptomsTX = 3 or 0 < CVD_NumQuarantine < 999 then C14 = 1; else C14 = 0;
label C14 = "C14 was quarantined, 0-no,1-yes";

if C14 = 0 then C15 = 0;
else if CVD_NumQuarantine in (.,999,.D,.R) then C15 = 14; **Impute to the mean if yes quarantine;
else if CVD_NumQuarantine = 0 then C15 = 1; ** 7 people said yes quarantine but 0 days. Assign 1 day;
else if 0 < CVD_NumQuarantine <= 30 then C15 = CVD_NumQuarantine;
else if CVD_NumQuarantine > 30 then C15 = 30;

label C15 = "C15 days in quarantine";

 if CVD_LoseHealthCare=1 then C17=1 ; else C17 = 0;

label 
 C17= "Covid Lost HealthCare: 0=No, 1=Yes"  ; 

 if CVD_LaidOff=1 then C20=1 ; else C20 = 0;

label 
 C20= "Covid Lost job or Laid off: 0=No, 1=Yes"; 

 if CVD_Activated=1 then C21=1; else C21 = 0; 
  
label 
 C21= "Covid Activated: 0=No, 1=Yes" ; 

*** Composite 0-7 variable **;

comp_0_7 = sum(C3C4=1,C9_7_close = 0,C11_11_relfriend = 0,C15 >= 7,C17=1,C20=1,C21=1);

label comp_0_7 = "sum(C3C4=1,C9_7_close = 0,C11_11_relfriend = 0,C15 >= 7,C17=1,C20=1,C21=1)";

drop C11_0_none C11_n;

	keep 	masterid
			c3 c4 c3c4
			c7 c12 c14 c15 c17 c20 c21 c11_: c9_: comp_0_7;
	proc sort; by masterid;
run;

*sample is complete ls2 and ls3 surveys;
data home_work1;
	merge 	ls3_outcomes (in=a)
			ls3_outcomes_covid
			ls2_outcomes (in=b )
			ls2_outcomes_covid;
	by masterid;
	if a=1;

	if b < 1 then delete;*restrict to completed LS3 and LS2 surveys;

	keep 	masterid 
			ls3d5_covid_mde30 ls3d5_gad30 ls3d5_pts30 ls3d5_covid_rupa30
			ls2d5_mde30 ls2d5_gad30 ls2d5_pts30 ls2_covid_rupa30;
run;
data home.work1;*home_work2;
	*retain	ls2d5_mde30 ls2d5_gad30 ls2d5_pts30 ls2_covid_rupa30 ls2_dx2plus_30
			ls2_md4_30d ls2_gad5_30d ls2_ptsd6_30d;

	merge 	home_work1 (in=a )
			covid_stressors		
			last_asmis
			last_crime
			last_damis
			last_dx
			last_edes
			last_mepcom
			last_payroll
			last_rx
			last_sa
			last_ww
			last_poly			
			last_sevinj
			last_mc_predictor (in=b)
			last_mos
			last_weapons
			last_tapas
			survey_vars
			ls3_milstatus
			reg_at_survey
			weights;
	by masterid;
	if a;

	if a and not b then flag=1;
	if flag eq 1 then delete; *drop n=1 respondent who is missing on all predictors;
	drop ventile covid_stress_: flag;
run;

endsas;
/*;
proc standard data=home_work2 out=home_work3 mean=0 std=1;
weight weight_lsw3_norm;
var C_Z_ACHIEVEMENT
C_Z_DOMINANCE
C_Z_EVENTEMPER
C_Z_INTELEFF
C_Z_OPTIMISM
C_Z_PHYSICAL
C_TCOMP_ADAPTATION_TOPS_RENORMED
C_TCOMP_WILLDO_TOPS_RENORMED
ls2_md4_30d
ls2_gad5_30d
ls2_ptsd6_30d
cd_odd_scale
scale_borderline
scale_antisocial
scale_anger
scale_resilience

;
proc stdize data=home_work3 out=home_work4 reponly missing=0;
var C_Z_ACHIEVEMENT
C_Z_DOMINANCE
C_Z_EVENTEMPER
C_Z_INTELEFF
C_Z_OPTIMISM
C_Z_PHYSICAL
C_TCOMP_ADAPTATION_TOPS_RENORMED
C_TCOMP_WILLDO_TOPS_RENORMED
ls2_md4_30d
ls2_gad5_30d
ls2_ptsd6_30d
cd_odd_scale
scale_borderline
scale_antisocial
scale_anger
scale_resilience

;
run;
/*;
data new_covid_stress;
	set masha.covid_stress_091422;

	covid_stress_cat=covid_stress_low;
	if covid_stress_med eq 1 then covid_stress_cat=covid_stress_med+1;
	if covid_stress_high eq 1 then covid_stress_cat=covid_stress_high+2;

	proc sort; by masterid;
run;
*/*;


data home_work1;
	merge 	new_covid_stress 
			home_work1 (in=a)
			;
	by masterid;
	if a=1;
run;
*/*;
data home.work1;
	*retain masterid covid_stress_: ventile; 
	set home_work2;


	if suicide_attempt eq . then suicide_attempt=0;
 	if suicide_ideation eq . then suicide_ideation=0;

	in_aas=0; if last_survey eq "AAS" then in_aas=1;
	in_nss=0; if last_survey eq "NSS" then in_nss=1;
	in_ppds=0; if last_survey eq "PPDS" then in_ppds=1;

	
	array dummya (6) 3. datingstatus1-datingstatus6;
	do i=1 to 6;
		dummya(i)=0;
	end;
	dummya(datingstatus)=1;

	drop 	DATE_FINAL
			lastdate
			stoploss_type1
stoploss_type2
			datingstatus i
			ls2d5_ad6
ls2d5_alc30
ls2d5_drg30
ls2d5_iedlt
ls2d5_manialt
ls2d5_bipolarIlt
ls2oa_pdlt
ls2d5_bipolarIIlt
ls2d5_hyplt
lsoa_addlt
lsoa_sublt
lsoa_mania_broad_lt
lsoa_iedlt
milstatus_ls3_cat1
milstatus_ls3_cat2
milstatus_ls3_cat3
milstatus_ls3_cat4
	;
	label 	datingstatus1= "married"
			datingstatus2= "serious committed relationship - like being married but not"
			datingstatus3= "engaged"
			datingstatus4= "steadily dating 1 person"
			datingstatus5= "dating 2+ people; nothing steady"
			datingstatus6= "not dating";
run;


ods html file= "/home/data/Harvard/king/ls3/covid/tables/ctab/ls3_covid_MACF_contents.html";
proc means data=home.work1 mean min max nmiss;	
proc contents data=home.work1 order=varnum; 
run;
ods html close;

PROC EXPORT DATA =home.work1
            OUTFILE = "/home/data/Harvard/king/ls3/covid/data/ls3_covid_MACF.csv"
            DBMS = CSV
            REPLACE;
run;

/*;
data home_work2;
	set home.work1;
	if covid_stress_cat eq 3 then delete;
run;

PROC EXPORT DATA =home_work2
            OUTFILE = "/home/data/Harvard/king/ls3/covid/data/ls3_covid_SACF1.csv"
            DBMS = CSV
            REPLACE;
run;


*splitting the low-medium sample into 70/30 samples;
proc surveyselect data=home.work1 method=sys samprate=.7
	seed=456 out=train_sample70;
	strata ls3_dx1plus_30;
	control weight_lsw3_norm;
run;


proc sort data=home.work1; by masterid; run;
proc sort data=train_sample70; by masterid; run;
data test_sample30;
	merge 	home.work1 (in=a)
			train_sample70 (keep=masterid in=b);
	by masterid;
	if a and not b;
run;
ods html file= "/home/data/Harvard/king/ls3/covid/tables/ctab/ls3_covid_SACF1_train_contents.html";
proc contents data=train_sample70 order=varnum; run;
ods html close;
PROC EXPORT DATA =train_sample70
            OUTFILE = "/home/data/Harvard/king/ls3/covid/data/ls3_covid_SACF1_train70.csv"
            DBMS = CSV
            REPLACE;
run;
PROC EXPORT DATA =test_sample30
            OUTFILE = "/home/data/Harvard/king/ls3/covid/data/ls3_covid_SACF1_test30.csv"
            DBMS = CSV
            REPLACE;
run;
*/*;

