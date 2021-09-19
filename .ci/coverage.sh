#! /bin/sh

echo "setting git configurations for commit."
git config --global user.email $EMAIL
git config --global user.name $USERNAME
git remote set-url origin https://$DEPLOY_TOKEN@github.com/Coders-Asylum/coders-asylum.github.io.git
git fetch --all

echo "Creating helper file"
helper_file  =  test/coverage_hepler_test.dart

echo "/// Helper file to find coverge make coverage tests for all dart files.\n" > $helper_file
echo "/// This file is created during every CI operation automaticaly, it is safe to delete.\n" > $helper_file
echo "// ignore_for_file: unused_import" >> $helper_file

#  These lines find all the .dart file used in the project and adds them into the import lines with the package name.
#  This ignores the .dart files created by flutter

find lib '!' -path 'generated*/*' '!' -name '*.g.dart' '!' -name '*.part.dart' '!' -name '*.freezed.dart' -name '*.dart' 
| cut -c4- | awk -v package=$1  package=$1 '{printf "import '\''package:%s%s'\'';\n", package, $1}' >> $helper_file
echo "\nvoid main(){}" >> $helper_file

flutter test --coverage

echo "cleaining files"
rm ./test/coverage_helper_test.dart

# check if changes are present in the current working branch
if ! git --git-dir="./.git" diff --quiet
then
  git add --all
  git commit --all -m "Coverage report generated on:$(date)"
  git push origin
  echo "Changes have been committed and pushed to origin"
fi

