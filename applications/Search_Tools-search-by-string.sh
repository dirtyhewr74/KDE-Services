#!/bin/bash

#################################################################
# For KDE-Services. 2011-2016.									#
# By Geovani Barzaga Rodriguez <igeo.cu@gmail.com>				#
#################################################################

PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/home/$USER/bin
TMP=/tmp/SearchByString

STRING=$(kdialog --icon=/usr/share/icons/hicolor/scalable/apps/ks-search-string.svgz --caption='Search by String' --inputbox='Enter String to Search' 2> /dev/null)

if [ "$?" != "0" ]; then
  exit 1
fi

DBUSREF=$(kdialog --icon=/usr/share/icons/hicolor/scalable/apps/ks-search-string.svgz --caption="Search by String" --progressbar "                                        " /ProgressDialog)
qdbus $DBUSREF setLabelText "Searching string ($STRING) on ${1##*/} directory recursively..."
egrep -r "$STRING" "$1"/* > $TMP
qdbus $DBUSREF close
kdialog --icon=/usr/share/icons/hicolor/scalable/apps/ks-search-string.svgz --caption="Search by String: $(cat $TMP|wc -l) matching entries with ($STRING)" \
               --textbox $TMP 900 300 2> /dev/null
rm -f $TMP

exit 0
