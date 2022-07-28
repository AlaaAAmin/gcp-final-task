# GCP GKE project

## Description

- This project was made for GCP course.
- It is a simple reload counter made using tornado the python framework and redis hosted on GKE.

## Steps

- Cloned the app code from https://github.com/atefhares/DevOps-Challenge-Demo-Code
- Created a Dockerfile for the image  
![](pics/dockerfile.png "The dockerfile")
- Created .dockerignore file to ignore unimportant files from getting containerized  
![](pics/ignore.png ".dockerignore")  
- Created run.sh the startup script in the docker image  
![](pics/run.png "run script")
- Built the image `docker image build -t reload-count-tornado-py-app:v1.0.2alpine .`
- Tagged the image `docker tag reload-count-tornado-py-app:v1.0.1alpine gcr.io/versatile-bolt-354107/reload-count-tornado-py-app:v1.0.1alpine`
- pushed the image to GCR `docker push gcr.io/versatile-bolt-354107/reload-count-tornado-py-app:v1.0.1alpine`
![](pics/gcr.png "The image in GCR")
- made a terraform project by running `terraform init` after creating the provider code
- wrote the rest of the infrastructure code.
- run `terraform apply`

## Requirments

1. Terraform

## Author

[Alaa A. Amin](https://www.linkedin.com/in/alaaamin-swe/)