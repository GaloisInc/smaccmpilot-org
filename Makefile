SMACCMPILOT_ORG_EXEC?=./.cabal-sandbox/bin/smaccmpilot-org

default: build

.cabal-sandbox:
	@cabal sandbox init

.PHONY: smaccmpilot-org
smaccmpilot-org: .cabal-sandbox site.hs Sidebar.hs
	@cabal install
	$(SMACCMPILOT_ORG_EXEC) clean

build: smaccmpilot-org
	$(SMACCMPILOT_ORG_EXEC) build

preview: build
	$(SMACCMPILOT_ORG_EXEC) preview

deploy:
	$(SMACCMPILOT_ORG_EXEC) deploy

clean:
	-$(SMACCMPILOT_ORG_EXEC) clean

clean-sandbox: clean
	-rm -rf cabal.sandbox.config .cabal-sandbox
