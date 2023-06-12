#!/bin/sh

PARAM=$1
#echo PARAM=$1

#echo "Test pour Nora et Chloé !"
if [ $PARAM -eq 1 ]
then
	echo "NORA"
elif [ $PARAM -eq 2 ] || [ $PARAM -eq 5 ]
then
	echo "CHLOE"
else
	echo "Maman et Papa"
fi
