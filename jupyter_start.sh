#!/bin/sh

# Removing the temporary files (temperr contains the IP Address)
JUPDIR="/home/g.samarth/jupyter-compute-node"
rm $JUPDIR/juperr
rm $JUPDIR/jupout
touch $JUPDIR/juperr
touch $JUPDIR/jupout

# Submitting job to run jupyter notebook
JOBIDFULL=`qsub $JUPDIR/jupyter_start.pbs`
JOBIDFILE="$JUPDIR/jupyter_nb_jobid"
IPFILE="$JUPDIR/jupyter_nb_ipaddr"

echo -n "Initializing Jupyter notebook ..."
while ! [ -s $JUPDIR/juperr ]; do
#    echo "`ls -artlh $JUPDIR/juperr`"
    echo -n ".."
    sleep 2
done

sleep 5
echo "Jupyter notebook started"
# echo "`ls -artlh $JUPDIR/juperr`"
# Getting the jobID and the ipaddress of node
JOBID=`echo $JOBIDFULL | awk -F. '{print $1}'`
IPADDR=`awk '/http/ {print $4}' $JUPDIR/juperr | cut -c 8- | sed 's/.$//' | rev | cut -c 6- | rev`

# Writing jobID in file (to be able to delete job later)
echo "$JOBID" > $JOBIDFILE
echo "$IPADDR" > $IPFILE
echo "jobID = $JOBID"
echo "IPaddr = $IPADDR"
