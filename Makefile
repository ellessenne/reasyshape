.PHONY: deploy

deploy:
	@R --quiet -e "rsconnect::deployApp(appDir = 'inst/application/', appName = 'reasyshape', appTitle = 'Reshape Your Data Interactively')"
