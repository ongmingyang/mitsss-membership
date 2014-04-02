#!/bin/sh

echo "INFO: This script transfers membership from a mailman list (source) to a moira list (target)"
echo
echo "Note: You need to first create a moira list on"
echo "http://listmaker.mit.edu"
echo
read -p "Name of source list? " source
read -p "Name of target list? " target

add consult
mmblanche $source > /tmp/addresses.txt
blanche $target -f /tmp/addresses.txt

echo
echo "done."
