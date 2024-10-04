#!/bin/bash
APP_VERSION=$1
echo "app version: $APP_VERSION"
yum install python3.12-devel python3.12-pip -y
pip3.12 install ansible ansible-core==2.16 botocore boto3
cd /tmp
ansible-pull -U https://github.com/nishalkdevops-practice/ansible-roboshop-roles-tf.git -e component=catalogue -e app_version=$APP_VERSION -e env=$ENVIRONMENT main.yaml