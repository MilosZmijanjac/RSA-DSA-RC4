#!bin/bash


echo "Enter key"
read key_string

IFS=' ' read -r -a key <<< "$key_string"

echo "Enter state vector lenght"
read s_lenght

for i in $( seq 0 $(($s_lenght-1)))
do
	s[$i]="$i"
done

j="0"

for i in $( seq 0 $(($s_lenght-1)))
do
echo "Round: $i"
j="$((( $j+${s[$i]}+${key[($i%${#key[@]})]})%$s_lenght))"

temp="${s[$i]}"
s[$i]="${s[$j]}"
s[$j]="$temp"
echo "${s[@]}"
done


