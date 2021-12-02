# Протестированно на Ubuntu 20.04

`git clone https://github.com/stratnevpy/werf-guide-app.git`

`cd werf-guide-app/local`

`./install.sh`

`./setup-infra.sh`

`./deploy-app.sh`

`kubectl -n local get po`

Navigate to http://test.application.local/