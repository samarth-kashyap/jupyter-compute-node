#!/bin/sh

# Reading jobID from file
JOBIDFILE="/home/samarth/jupyterComputeNode/jupyter_nb_jobid"
JOBID=$(head -n 1 $JOBIDFILE)

echo "--Deleting the job"
qdel $JOBID
rm $JOBIDFILE
