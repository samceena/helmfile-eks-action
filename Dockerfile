FROM alpine:3.12

RUN apk add py-pip curl wget ca-certificates git bash jq cmake make git ca-certificates git bash curl jq

RUN pip install awscli

RUN curl -L -o /usr/bin/kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.18.9/2020-11-02/bin/linux/amd64/kubectl
RUN chmod +x /usr/bin/kubectl

RUN curl -o /usr/bin/aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.17.7/2020-07-08/bin/linux/amd64/aws-iam-authenticator
RUN chmod +x /usr/bin/aws-iam-authenticator

RUN wget https://get.helm.sh/helm-v3.5.3-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm 
RUN chmod +x /usr/local/bin/helm

# RUN wget https://github.com/roboll/helmfile/archive/refs/tags/v0.138.7.tar.gz -O - | tar -xzO helmfile 

# $ docker run --rm --net=host -v "${HOME}/.kube:/root/.kube" -v "${HOME}/.config/helm:/root/.config/helm" -v "${PWD}:/wd" --workdir /wd quay.io/roboll/helmfile:helm3-v0.135.0 helmfile sync

# RUN apk add --no-cache cmake make git ca-certificates git bash curl jq


RUN helm plugin install https://github.com/databus23/helm-diff --version 3.1.3 && \
    helm plugin install https://github.com/futuresimple/helm-secrets && \
    helm plugin install https://github.com/hypnoglow/helm-s3.git && \
    helm plugin install https://github.com/aslafy-z/helm-git.git 

RUN wget https://github.com/roboll/helmfile/releases/download/v0.138.7/helmfile_linux_amd64 && mv helmfile_linux_amd64 usr/local/bin/helmfile 
RUN chmod +x /usr/local/bin/helmfile

# RUN ["helm", "init", "--client-only", "--stable-repo-url", "https://charts.helm.sh/stable"]


# helm init --client-only --stable-repo-url https://charts.helm.sh/stable

# RUN wget https://github.com/roboll/helmfile/archive/refs/tags/v0.138.7.tar.gz -O - | tar -xzO helmfile > usr/local/bin/helmfile
# chmod +x /usr/local/bin/helmfile

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]:

# wget -c https://github.com/roboll/helmfile/archive/refs/tags/v0.138.7.tar.gz -O - | tar -xz -C /usr/local/bin/

# wget https://github.com/roboll/helmfile/releases/download/v0.138.7/helmfile_linux_amd64
# chmod a+x helmfile

