# on rasta

# To quickly check if a run in an oldRuns dir on a NAS is on tape already
# 
# 1/ generate a list on the NAS
ssh clinical-nas-2 ls -1 oldRuns > clinical-nas-2-oldRuns

# 2/ check if those are on tape
while read -r LINE; do
   echo $LINE;
   
   find /mnt/hds/proj/bioinfo/ON_TAPE/ -name "${LINE}*" | grep '.*'; FOUND=$?;
   [[ $FOUND -eq 0 ]] && echo 'BACKED UP';
done < clinical-nas-oldRuns 
