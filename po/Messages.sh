#!/bin/sh

BASEDIR=".."
XMLFILE="index.html.in"
PODIR=`pwd`

cd ${BASEDIR}

echo "Extracting messages"

intltool-extract --type=gettext/xml ${XMLFILE}
xgettext -a ${XMLFILE}.h -o ${PODIR}/index.pot

echo "Done extracting messages"

cd ${PODIR}

echo "Merging translations"

catalogs=`find . -name '*.po'`

for cat in $catalogs; do
	echo $cat
	msgmerge -o $cat.new $cat index.pot
	mv $cat.new $cat
done

echo "Done merging translations"

cd ${BASEDIR}

echo "Cleaning up"

rm ${XMLFILE}.h

echo "Done"
