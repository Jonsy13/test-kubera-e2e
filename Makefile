# Makefile for building litmus-e2e
# Reference Guide - https://www.gnu.org/software/make/manual/make.html


IS_DOCKER_INSTALLED = $(shell which docker >> /dev/null 2>&1; echo $$?)

# TESTPATH ?= /home/udit1/go/src/github.com/litmuschaos/litmus-e2e

.PHONY: install-kubera
install-kubera:

	@echo "-----------"
	@echo "Installing Kubera"
	@echo "-----------"
	@chmod 755 k8s_scripts/LitmusInstall.sh
	@k8s_scripts/LitmusInstall.sh


.PHONY: e2e-metrics
e2e-metrics:

	@echo "----------------------------"
	@echo "Pipeline Coverage Percentage"
	@echo "----------------------------"
	@sshpass -p ${portal_pass} ssh -o StrictHostKeyChecking=no ${portal_user}@${litmus_ip} -p ${port} -tt \
	 "export CI_JOB_ID=${CI_JOB_ID} && export CI_PIPELINE_ID=${CI_PIPELINE_ID} && cd $(TESTPATH) && bash metrics/e2e-metrics"

.PHONY: uninstall-portal
uninstall-portal:

	@echo "-----------"
	@echo "Uninstalling Litmus-Portal"
	@echo "-----------"
	@sshpass -p ${portal_pass} ssh -o StrictHostKeyChecking=no ${portal_user}@${litmus_ip} -p ${port} -tt \
	 "chmod 755 $(TESTPATH)/k8s_scripts/LitmusUninstall.sh"
	@sshpass -p ${portal_pass} ssh -o StrictHostKeyChecking=no ${portal_user}@${litmus_ip} -p ${port} -tt \
	 "$(TESTPATH)/k8s_scripts/LitmusUninstall.sh"

