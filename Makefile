# Makefile for building litmus-e2e
# Reference Guide - https://www.gnu.org/software/make/manual/make.html


IS_DOCKER_INSTALLED = $(shell which docker >> /dev/null 2>&1; echo $$?)

.PHONY: kubera-install
kubera-install:

	@echo "-----------"
	@echo "Installing Kubera"
	@echo "-----------"
	@chmod 755 k8s_scripts/install.sh
	@k8s_scripts/install.sh

.PHONY: cypress-install
cypress-install:

	@echo "-----------"
	@echo "Installing Cypress"
	@echo "-----------"
	@cd Cypress && npm ci --prefer-offline


.PHONY: e2e-metrics
e2e-metrics:

	@echo "-----------"
	@echo "Pipeline Coverage Percentage"
	@echo "-----------"
	@chmod 755 metrics/e2e-metrics.sh
	@metrics/e2e-metrics.sh


