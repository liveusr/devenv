# run this script in bg: while true; do $HOME/.fetch_rate.sh; sleep 60; done &

tmp_file=".rate.tmp"
out_file=".rate"

declare -a tag_str=("Remitly Express" "f1smo2ix" "Remitly Economy" "f1smo2ix")

tag_id=0
tag_found=false
i=0
j=0

echo -n " fetching..." > $out_file
wget -q https://www.remitly.com/us/en/india -O $tmp_file

echo -n " reading..." > $out_file
while read -n1 c; do
    if [ "$c" == "${tag_str[$tag_id]:$i:1}" ] || (( i == 7 )); then
        i=$((i+1))
        if [ $i == ${#tag_str[$tag_id]} ]; then
            if (( tag_id == 1 )); then echo -n " " > $out_file; fi
            if (( tag_id%2 )); then tag_found=true; fi
            tag_id=$((tag_id+1))
            i=0
        fi
    else
        i=0
    fi

    if $tag_found; then
        if (( j >= 4 )); then echo -n $c >> $out_file; fi
        j=$((j+1))
        if (( j == 9 )); then
            if (( tag_id == 2 )); then echo -n " " >> $out_file; fi
            tag_found=false
            j=0
        fi
    fi

    if (( tag_id == 4 )) && ! $tag_found; then break; fi
done < $tmp_file

echo "" >> $out_file
rm -f $tmp_file
