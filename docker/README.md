# Docker images
This folder contains useful Docker images for this project

## Jekyll agent
Docker image based on alpine including Jekyll and all required ruby dependencies.

This image can be used as a Jenkins agent to run Jekyll build steps.

Build the image with following command:
```sh
docker build -t jekyll:1.0 .
```
