# on thalamus

# after we upgrade from clinstatdb 2.0.0 to 2.0.1, we can check the stats files between old DB and new DB

cd DEMUX/
for d in 1504*XX/ 1505*XX/ 1506*XX/ 1507*XX/ 1508*XX/ 1509*XX/; do
	e=${d%.*};
	if [[ $e == *"SN7001301"* || $e == *"SN7001298"* ]]; then
		continue;
	fi;

	echo $e;

	for s in `( cd ${e}; ls stats-* )`; do
		diffcount=`comm -13 <(sort ${e}/${s}) <(sort ${e}/Unaligned*/${s}.re) | wc -l`;
		if [[ $diffcount > 1 ]]; then
			echo "   ${s} DIFF";
		fi;
	done;
done 
