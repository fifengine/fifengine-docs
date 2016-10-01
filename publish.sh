#!/bin/sh

setup_git() {
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis CI"
}

commit_website_files() {
  git fetch origin
  git checkout -b gh-pages
  # remove all asciidoc (.adoc) source files
  git ls-files | grep '\.adoc$' | xargs git rm --cached
  # remove unneeded files
  git rm .gitattributes
  git rm .travis.yml
  git rm publish.sh
  # add & commit everything new
  git add --all
  git commit --message "Updated Documentation. [Travis build: $TRAVIS_BUILD_NUMBER] [skip ci]"
}

upload_files() {
  # make sure we have a the Github Token
  if [ -z $GH_TOKEN ]; then
    echo "Please set your Github token as secret GH_TOKEN env var."
    exit 1
  fi
  # git push
  git remote add origin-pages https://${GH_TOKEN}@github.com/fifengine/fifengine-docs > /dev/null 2>&1
  git push -f --set-upstream origin-pages gh-pages > /dev/null 2>&1
}

setup_git
commit_website_files
upload_files