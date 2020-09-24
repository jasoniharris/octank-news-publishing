#!/usr/bin/env bash
######################################
# Author: Jason Harris
# Function: Validate publishable content and deploy to S3
# Pre Requisits: AWS CLI
#
#*************************************
# Ver * Who * Date * Comments
#*************************************
# 1.0 * JH * 13/05/20 * Initial Version

#Validate content files for syntax errors
if [[ "$1" == "develop" ]]
then
    echo "Running validation..."
    cd content
    files=`ls *.json`
    for file in $files
    do
      cat $files | jq
        if [ $? -ne 0 ]
        then
          echo "Content ${file} has failed validation. The build will now exit."
          exit 2
        fi
    done
fi

#Publish content to S3
if [[ "$1" == "master" ]]
then
    BUCKET="content-production-octank-news"
    aws s3 sync content s3://${BUCKET} --exclude '.DS_Store'
fi



