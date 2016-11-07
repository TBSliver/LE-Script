#! /bin/sh

root_dir=`dirname $0`

echo "Installing Dependencies"

$root_dir/vendor/bin/cpanm -L local --quiet --installdeps $root_dir
