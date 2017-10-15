#!/bin/bash

cd ./gems

for dir in `find . ! -path . -type d`
do
	echo $dir
	pushd $dir
	gem spec *.gem cert_chain | ruby -ryaml -e 'doc = YAML.load_documents($stdin); unless doc[0].empty? then File.new("cert.cer", "w+b").write(doc) end'
	popd
done
