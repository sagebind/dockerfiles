#!/bin/sh
COMPONENT=rust-$1
ARCHIVE=$COMPONENT.tar.gz

curl -#O http://static.rust-lang.org/dist/$ARCHIVE \
    && tar -xzf $ARCHIVE \
    && sh $COMPONENT/install.sh \
    && rm $ARCHIVE \
    && rm -rf $COMPONENT
