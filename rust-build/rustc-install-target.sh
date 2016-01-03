#!/bin/sh
TARGET=$1
VERSION=1.5.0
COMPONENT=rust-std-$VERSION-$TARGET
ARCHIVE=$COMPONENT.tar.gz

curl -#O http://static.rust-lang.org/dist/$ARCHIVE
tar -xzf $ARCHIVE
$COMPONENT/install.sh
