## cor_analysis           : builds Correlates of Risk analyses
cor_analysis: 
	$(MAKE) -k -C cor_tabular all
	$(MAKE) -k -C cor_coxph all
#	$(MAKE) -k -C cor_graphical all
#	$(MAKE) -k -C cor_threshold all
	$(MAKE) -k -C cor_nonlinear all
# 	$(MAKE) -k -C cop_mediation all
# 	$(MAKE) -k -C cor_surrogates all
#	$(MAKE) -k -C cor_nonpar all

## cor_analysis_noclean           : builds Correlates of Risk analyses
cor_analysis_noclean: 
	$(MAKE) -k -C cor_tabular all
	$(MAKE) -k -C cor_coxph cor_coxph
#	$(MAKE) -k -C cor_graphical figs
#	$(MAKE) -k -C cor_threshold allbutclean
	$(MAKE) -k -C cor_nonlinear cor_nonlinear
# 	$(MAKE) -k -C cop_mediation all
# 	$(MAKE) -k -C cor_surrogates all
#	$(MAKE) -k -C cor_nonpar all

## cor_report             : builds the CoVPN correlates of risk report
cor_report: cor_analysis
	bash ./_build.sh cor

## cop_analysis           : builds Correlates of Protection analyses
cop_analysis: 
#	$(MAKE) -k -C cop_prinstrat all
#	$(MAKE) -k -C cop_controlled all
	$(MAKE) -k -C cop_stochastic all
	$(MAKE) -k -C cop_mediation all

## cop_report             : builds the CoVPN correlates of protection report
cop_report: cop_analysis
	bash ./_build.sh cop

check_clean_data: make_clean_data
	Rscript data_clean/make_clean_dat_check.R
## help_checks            : see a list of checks that are run on the data during cleaning
help_tests: data_clean/make_clean_dat_check.R 
	@echo "\nTests on the clean data: \n"
	@sed -n 's/^##//p' data_clean/make_clean_dat_check.R
	@echo "\n"

## style                  : re-styles the codebase for consistent formatting
style:
	Rscript -e "styler::style_dir(filetype = 'rmd')"

## type 'make help' to show all make commands
help: Makefile
	@sed -n 's/^##//p' $<

.PHONY: style help cor_report cor_analysis
