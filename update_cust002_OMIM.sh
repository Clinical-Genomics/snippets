#!/bin/bash

cd ~/git/GeneLists/
for LIST in ~/git/cust002/cust*txt; do
  echo $LIST;
  ALL='';
  PANELS=( $( python scripts/get_panels.py $LIST ) );
  for PANEL in ${PANELS[@]}; do
    if [[ $PANEL == 'FullList' ]]; then continue; fi;
    ALL="$ALL -d $PANEL";
  done;
  python -m scripts.merge_lists ~/git/cust002/cust002-OMIM.txt $LIST $ALL > ${LIST}-merge;
  python -m scripts.fetch_info --verbose ${LIST}-merge ${LIST}-complete;
done
