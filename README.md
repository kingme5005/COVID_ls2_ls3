The SAS program work1.sas cleans the source LS2 and LS3 data to produce a single clean data file for all analyses. 

There are two separate SAS programs for producing tables 1 and 2 in the paper based on outputted data from work1.sas (Table1_demo.sas & Table2_prevalence.sas).

There is a single SAS program for producing table 3 estimates (make_stressors_ARD.sas).

There are 3 STATA programs for producing the Adjusted Risk Differences (ARDs) and 95% CI's in tables 4 & 5 while controlling for complex sampling design correction (RR_covid.do, ARD_regress_demo.do, ARD_regress_demo_covid.do).
The interactions reported in Table 5 are produced in the OLS_covid_intx.sas program.

Supplementary table 2 is produced by sas OLS_covid.sas SAS program.

Supplementary table 3 is produced by RR_covid.sas SAS program.

Supplementary table 4 is produced by the OLS_covid_mdx_stratified.sas SAS program.
