#! /bin/sh

mkdir -p ./test/coverage/report/
touch ./test/coverage/coverage_hepler_test.dart
helper_file=./test/coverage/coverage_hepler_test.dart

printf "/// Helper file to find coverge make coverage tests for all dart files.\n" >> $helper_file
printf "/// This file is created during every CI operation automaticaly, it is safe to delete.\n\n" >> $helper_file
printf "//ignore_for_file: unused_import\n" >> $helper_file

#  These lines find all the .dart file used in the project and adds them into the import lines with the package name.
#  This ignores the .dart files created by flutter

find lib '!' -path 'generated*/*' '!' -name '*.g.dart' '!' -name '*.part.dart' '!' -name '*.freezed.dart' -name '*.dart' | cut -c4- | awk -v package=web '{printf "import '\''package:%s%s'\'';\n", package, $1}' >> $helper_file

printf "\nvoid main(){}\n" >> $helper_file

flutter test --pub --null-assertions --coverage --coverage-path "test/coverage/report/lcov.info"


