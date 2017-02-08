FROM jenkinsci/jnlp-slave
MAINTAINER Ross Kukulinski <ross@kukulinski.com>

ENV CLOUDSDK_CORE_DISABLE_PROMPTS 1
ENV PATH /opt/google-cloud-sdk/bin:$PATH

USER root

RUN apt-get update -y && apt-get install -qq -y --no-install-recommends jq make && apt-get clean
RUN curl https://sdk.cloud.google.com | bash && mv google-cloud-sdk /opt
RUN gcloud components install kubectl
# Disable updater check for the whole installation.
# Users won't be bugged with notifications to update to the latest version of gcloud.
RUN gcloud config set --installation component_manager/disable_update_check true

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y nodejs
RUN npm install -g k8s-scripts@3.2.2
