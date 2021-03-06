#!/usr/bin/env bash
echo ""
echo "#####################################################################################"
echo ""
echo "Installation manual: https://kubernetes.io/ru/docs/tasks/tools/install-kubectl/#%D1%83%D1%81%D1%82%D0%B0%D0%BD%D0%BE%D0%B2%D0%BA%D0%B0-kubectl-%D0%B2-linux"
echo ""
echo "binary file can be installed like that: (copy+paste should be enough)"
echo ""
echo "curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl"
echo "chmod +x ./kubectl"
echo "sudo mv ./kubectl /usr/local/bin/kubectl"
echo ""
echo "Check everything is working fine:"
echo "kubectl version --client"
echo ""
echo "#####################################################################################"
