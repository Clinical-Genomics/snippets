# On rasta:

cd DEMUX
for d in *; do
    d_short=${d%%.*};
    echo $d_short;

    find /mnt/hds/proj/bioinfo/ON_TAPE/ -name "*${d_short}*" | grep '.*'; exists=$?;

    if [[ $exists -eq 0 ]]; then
        echo 'BACKED UP';
    fi;
done
