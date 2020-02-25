#!/usr/bin/env bash

set -x

grep -r -E "pylint. {0,1}disable\=" .; if [ $? -eq 0 ]; then echo "Can not run pylint scoring with any pylint warnings disabled, please remove them and try again" && false; else true; fi
(git --no-pager diff --name-only --diff-filter=M $TRAVIS_COMMIT_RANGE | grep -F ".py" || echo "$(basename "$PWD")") > $TRAVIS_HOME/before_files.txt
(git --no-pager diff --name-only --diff-filter=AM $TRAVIS_COMMIT_RANGE | grep -F ".py" || echo "$(basename "$PWD")") > $TRAVIS_HOME/after_files.txt
pylint --rcfile=.configs/pylintrc --jobs=0 --exit-zero $(< $TRAVIS_HOME/after_files.txt) > $TRAVIS_HOME/pylint_after_output.txt
git checkout $TRAVIS_BRANCH
pylint --rcfile=.configs/pylintrc --jobs=0 --exit-zero $(< $TRAVIS_HOME/before_files.txt) > $TRAVIS_HOME/pylint_before_output.txt

set -e

(
  grep -F "/10, -" $TRAVIS_HOME/pylint_before_output.txt ||
  grep -F "/10, +0.00" $TRAVIS_HOME/pylint_before_output.txt ||
  (
    echo "pylint score decreased, please try again after fixing some lint issues." &&
    cat $TRAVIS_HOME/pylint_after_output.txt &&
    grep -F "Your code has been rated at" $TRAVIS_HOME/pylint_before_output.txt | cut -f 2-7 -d " " && false
  )
)
