#!/bin/bash
#SBATCH --time=72:00:00
#SBATCH --mem=20G

SECONDS=0

echo "Arguments: " $1 $2 $3
#echo "Writing..."
srun ./write $1 $2 $3
duration=$SECONDS
echo "Writing duration [s]: " $duration
#echo "Reading..."
srun ./read $2
duration=$(($SECONDS-$duration))
echo "Reading duration [s]: " $duration
echo "Total duration [s]: " $SECONDS
#echo "Finished"