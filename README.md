## Jupyter notebook on compute node
This script allows the creation of a jupyter notebook on a compute node. The server can then be accessed through port forwarding.

Before running the jupyter notebook on a compute node, the first step is to configure the jupyter notebook to run jupyter without opening the browser.
Follow the steps here to generate the notebook configuration file and set a password to the notebook. [https://jupyter-notebook.readthedocs.io/en/stable/public_server.html]

Edit the `jupyter_notebook_config.py` file and add the following lines.
Note: Replace the last line with the hash of your own password as mentioned in the link above.

```
c.NotebookApp.allow_remote_access = True
c.NotebookApp.ip = '0.0.0.0'
c.NotebookApp.open_browser = False
c.NotebookApp.port = 8879
c.NotebookApp.password = u'sha1:52ccaeeff1e4:99a66eiasdfasdfadsfad6ea290asdfsdfee8974dadsf2f66'
```
Run the script `jupyter_start.sh` using
```./jupyter.sh```
to start the Jupyter notebook. The script prints out the IP address on which jupyter notebook is being run. The default port can be set up in the jupyter configuration file.
