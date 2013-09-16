all: *.js *.html

*.js: *.coffee
	coffee -bc *.coffee

*.html: index.jade
	jade --pretty *.jade