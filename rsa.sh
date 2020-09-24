#!bin/bash

function is_prime(){
    if [[ $1 -eq 2 ]] || [[ $1 -eq 3 ]]; then
        return 1  # prime
    fi
    if [[ $(($1 % 2)) -eq 0 ]] || [[ $(($1 % 3)) -eq 0 ]]; then
        return 0  # not a prime
    fi
    i=5; w=2
    while [[ $((i * i)) -le $1 ]]; do
        if [[ $(($1 % i)) -eq 0 ]]; then
            return 0  # not a prime
        fi
        i=$((i + w))
        w=$((6 - w))
    done
    return 1  # prime
}

gcd() (
    ! (( $1 % $2 )) && echo $2 || gcd $2 $(( $1 % $2 ))
)

echo "Unesite p:"
read p

is_prime $p

if [[ $? -eq 0 ]]; then
  echo "not a prime"
  exit
fi

echo "Unesite q:"
read q

is_prime $q

if [[ $? -eq 0 ]]; then
  echo "not a prime"
  exit
fi

n="$(($p*$q))"

ro="$((($p-1)*($q-1)))"

for i in $(seq 2 $(($ro-1)))
do
	if [ "$(gcd $i $ro)" == "1" ]
	then
	e="$i"
	break
	fi
done

for i in {1..100000}
do
	m="$((($i*$e)%$ro))"
	if [ "$m" == "1" ]
	then
	d="$i"
	break
	fi
done

echo "Public key PU={$e,$n}"
echo "Private key PR={$d,$n}"







