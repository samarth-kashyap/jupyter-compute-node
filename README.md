## Jupyter notebook on compute node
This script allows the creation of a jupyter notebook server on a compute node of a cluster or a remoted desktop. The server can then be accessed through port forwarding.

### Setting up
Before running the jupyter notebook on a compute node, the first step is to configure the jupyter notebook to run jupyter without opening the browser.
Follow the steps [here](https://jupyter-server.readthedocs.io/en/latest/operators/public-server.html) to generate the notebook configuration file and set a password to the notebook. 

Edit the `~/.jupyter/jupyter_notebook_config.py` file and add the following lines.
```
c.NotebookApp.allow_remote_access = True
c.NotebookApp.ip = '0.0.0.0'
c.NotebookApp.open_browser = False
c.NotebookApp.port = 8879
c.NotebookApp.password = u'sha1:52ccaeeff1e4:99a66eiasdfasdfadsfad6ea290asdfsdfee8974dadsf2f66'
```
The `allow_remote_access` flag lets you access the notebook remotely. The `ip` flag forces the notebook to run on the local IP address of the machine. 
Setting the `open_browser` flag to `False` ensures that the notebook is not opened remotely and only the kernels are being run. 
The `port` is set to `8879`. This can be changed according to convenience. 
Note that `password` needs to be replaced with the hased value of your own password as described in the "setting up" section.

### Starting the notebook server
Run the script `jpstart.sh` using
```./jpstart.sh```
to start the Jupyter notebook. The script prints out the IP address on which jupyter notebook is being run. The script prompts you to choose the type of notebook instance. 
1. Running on compute cluster using PBS
2. Running on compute cluster using slurm
3. Running on a remote desktop
Currently only options 1 and 3 are supported. Option 2 will be added in the future. Once the option is selected, the notebook should start and the script prints out the IP address of the notebook server as
```IPaddr = a.b.c.d```


### Accessing on local computer

Note down the IP address (a.b.c.d) and open the terminal on your computer. Port forward using
``` ssh -N -n -L 127.0.0.1:8889:a.b.c.d:8879 username@hostname &```

Port forwarding is now setup. Open the browser and go to http://127.0.0.1:8889/lab and you should get a password prompt for the jupyter notebook!

### Killing the notebook
To kill the notebook, login to your cluster/remote computer. `cd` to the `jupyter-compute-node` directory and run `./jpkill.sh`.
