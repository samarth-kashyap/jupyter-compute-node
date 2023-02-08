#!/bin/bash

# Removing the temporary files (temperr contains the IP Address)
JUPDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
echo "Jupyter directory = $JUPDIR"
cd ~/


while [ -s $JUPDIR/juperr ]; do
	rm $JUPDIR/juperr
done

while [ -s $JUPDIR/jupout ]; do
	rm $JUPDIR/jupout
done

touch $JUPDIR/juperr
touch $JUPDIR/jupout
JOBIDFILE="$JUPDIR/.jupyter_jobid"
IPFILE="$JUPDIR/.jupyter_ipaddr"
INSTFILE="$JUPDIR/.jupyter_instance_type"

echo "Choose jupyter lab instance type:"
echo "[1] compute cluster (PBS script)"
echo "[2] compute cluster (slurm script)"
echo "[3] remote instance (desktop)"
echo "-------------------------------------"
read INSTANCETYPE

if [ $INSTANCETYPE == '1' ]; then
	echo "Running jupyter on compute cluster (PBS)"
	# Submitting PBS job to run jupyter notebook
	JOBIDFULL=`qsub $JUPDIR/jupyter_start.pbs`
elif [ $INSTANCETYPE == '3' ]; then
	echo "Running remote jupyter instance on desktop"
	JOBIDFULL=`bash $JUPDIR/remote_jupyter.sh`
else
	echo "Running jupyter instance on compute cluster (slurm)"
	echo "Instance type not found"
	exit 1
fi

echo -n "Initializing Jupyter notebook ..."
while ! [ -s $JUPDIR/juperr ]; do
    echo -n ".."
    sleep 2
done

sleep 5
echo "Jupyter notebook started"
JOBID=`echo $JOBIDFULL | awk -F. '{print $1}'`
IPADDR=`awk '/http/ {print $4}' $JUPDIR/juperr | cut -c 8- | sed 's/.$//' | rev | cut -c 6- | rev`

# Writing jobID in file (to be able to delete job later)
echo "$JOBID" > $JOBIDFILE
echo "$IPADDR" > $IPFILE
echo "$INSTANCETYPE" > $INSTFILE
echo "jobID = $JOBID"
echo "IPaddr = $IPADDR"
