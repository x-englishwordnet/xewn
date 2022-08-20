#!/bin/bash

function count_data()
{
  local file="$1"
  local c=$(egrep -c '^[0-9]{8}' ${file})
  echo $c
}

function count_indexes()
{
  local file="$1"
  local c=$(egrep -c '^[^ ]+' ${file})
  echo $c
}

function count_senses()
{
  local file="$1"
  local c=$(egrep -c '^[^ ]+' ${file})
  echo $c
}

for dir in $*; do
  echo "${dir}"
  t=
  echo -n "data    "
  for pos in noun verb adj adv; do
    file="${dir}/data.${pos}"
    c=$(count_data "$file")
    echo -n "${pos}: ${c} "
    t=$(($t + $c))
  done
  echo "total: ${t}"

  t=
  echo -n "index  "
  for pos in noun verb adj adv; do
    file="${dir}/index.${pos}"
    c=$(count_indexes "$file")
    echo -n " ${pos}: ${c}"
    t=$(($t + $c))
  done
  echo " total: ${t}"

  file="${dir}/index.sense"
  c=$(count_senses "$file")
  echo "senses: ${c}"
  echo
done