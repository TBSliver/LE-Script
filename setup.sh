#! /bin/sh

root_dir=`dirname $0`

echo "Installing Dependencies"

$root_dir/vendor/bin/carton install --deployment
