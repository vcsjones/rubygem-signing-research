#!/bin/bash

mkdir -p gems

while read gem_name; do
	mkdir -p ./gems/$gem_name
	pushd ./gems/$gem_name
	gem fetch $gem_name
	popd
done < gemlist.txt
