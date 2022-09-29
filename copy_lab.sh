#!/bin/bash

SECRET_KEY="adam-lab.pem"
PUBLIC_DNS="ubuntu@ec2-3-125-51-254.eu-central-1.compute.amazonaws.com"

scp -i $SECRET_KEY -r ./EC2 $PUBLIC_DNS:~/
# scp -i $SECRET_KEY -r ./ToxicTypo $PUBLIC_DNS:~/
ssh -i $SECRET_KEY $PUBLIC_DNS
