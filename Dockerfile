FROM alpine
# Metadata
LABEL org.label-schema.name="helm-kubectl-aws2" \
      org.label-schema.url="https://hub.docker.com/repository/docker/teochenglim/helm-kubectl-aws2" \

# Note: Latest version of kubectl may be found at:
# https://aur.archlinux.org/packages/kubectl-bin/
ENV KUBE_LATEST_VERSION="v1.21.1"
# Note: Latest version of helm may be found at:
# https://github.com/kubernetes/helm/releases
ENV HELM_VERSION="v3.6.0"

RUN apk add --no-cache ca-certificates bash git openssh curl \
    && wget -q https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && wget -q https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm

RUN apk -Uuv add groff less python3 py3-pip bash gettext jq
RUN pip3 install awscli
RUN rm /var/cache/apk/*

COPY eks.sh /root/
CMD bash
