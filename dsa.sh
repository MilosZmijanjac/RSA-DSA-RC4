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


echo "Enter prime number q"
read q

is_prime $q

if [[ $? -eq 0 ]]; then
  echo "not a prime"
  exit
fi

for i in {2..1000}
do
if [ "$(((i-1) %q))" == "0" ];then
if [ "$(is_prime $i; echo $?)" == "1" ]
then
p="$i"
break
fi
fi
done

for i in $( seq 2 $p)
do
if [ "$(((i**q)%p))" == "1" ]
then
g="$i"
break
fi
done

echo "Enter random number x"
read x

y="$(((g**x)%p))"

echo "PU={$p,$q,$g,$y}"
echo "PR={$p,$q,$g,$x}"

echo "Signing..."

echo "Enter random number k"
read k

r="$((((g**k)%p)%q))"

for j in {2..100}
do
if [ "$(((k*j)%q))" == "1" ]
then
i=$j
break
fi
done

echo "Enter hash value h"
read h

s="$(((i*(h+r*x))%q))"

echo "DS={$r,$s}"

echo "Verification..."

for j in {2..100}
do
if [ "$(((s*j)%q))" == "1" ]
then
w=$j
break
fi
done

u1="$(((h*w)%q))"
u2="$(((r*w)%q))"

v="$((((g**u1*y**u2)%p)%q))"

if [ "$r" == "$v" ]
then
echo "Signiture is verified"
else
echo "Signiture isn't verifed"
fi









