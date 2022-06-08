FROM alpine:3.12

RUN apk add py-pip curl wget ca-certificates git bash jq cmake make git ca-certificates git bash curl jq

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install

RUN curl -L -o /usr/bin/kubectl https://s3.us-west-2.amazonaws.com/amazon-eks/1.21.2/2021-07-05/bin/linux/amd64/kubectl

RUN chmod +x /usr/bin/kubectl

RUN curl -L -o /usr/bin/aws-iam-authenticator https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v0.5.6/aws-iam-authenticator_0.5.6_linux_amd64
RUN chmod +x /usr/bin/aws-iam-authenticator

RUN wget https://get.helm.sh/helm-v3.9.0-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm
RUN chmod +x /usr/local/bin/helm

RUN helm plugin install https://github.com/databus23/helm-diff --version 3.1.3 && \
    helm plugin install https://github.com/futuresimple/helm-secrets && \
    helm plugin install https://github.com/hypnoglow/helm-s3.git && \
    helm plugin install https://github.com/aslafy-z/helm-git.git

RUN wget https://github.com/roboll/helmfile/releases/download/v0.144.0/helmfile_linux_amd64 && mv helmfile_linux_amd64 usr/local/bin/helmfile
RUN chmod +x /usr/local/bin/helmfile

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]:

