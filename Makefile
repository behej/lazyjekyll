all: build

build:
	bundle exec jekyll build

watch:
	bundle exec jekyll serve -l
