#!/bin/bash

JUPDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
JOBIDFILE="$JUPDIR/.jupyter_jobid"
IPFILE="$JUPDIR/.jupyter_ipaddr"
INSTFILE="$JUPDIR/.jupyter_instance_type"

JOBID=$(head -n 1 $JOBIDFILE)
INSTANCETYPE=$(head -n 1 $INSTFILE)

echo "--Deleting the job"

if [ $INSTANCETYPE == '1' ]; then
	echo "Stopping PBS job $JOBID"
	qdel $JOBID
	rm $JOBIDFILE
elif [ $INSTANCETYPE == '3' ]; then
	echo "Stopping the remote jupyter instance: PID = $JOBID"
	kill $JOBID
	rm $JOBIDFILE
else
	echo "Stopping slurm job $JOBID"
	scancel $JOBID
	rm $JOBIDFILE
fi
