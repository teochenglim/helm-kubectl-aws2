#!/bin/bash -e
docker build . -t teochenglim/helm-kubectl-aws2
docker push teochenglim/helm-kubectl-aws2
