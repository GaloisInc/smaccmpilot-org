STACK_FLAGS ?=

SMACCMPILOT_ORG_EXEC = stack build $(STACK_FLAGS) --exec 'smaccmpilot-org $(1)'

default: build

.PHONY: build preview deploy clean
build:
	$(call SMACCMPILOT_ORG_EXEC,build)

preview: build
	$(call SMACCMPILOT_ORG_EXEC,preview)

deploy:
	$(call SMACCMPILOT_ORG_EXEC,deploy)

clean:
	$(call SMACCMPILOT_ORG_EXEC,clean)
