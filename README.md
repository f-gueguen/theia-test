# Theia IDE Deployment in Docker

This guide provides step-by-step instructions to deploy Theia IDE in a Docker container. The setup involves two main stages:

1. Pre-building Theia with a Docker image (Dockerfile.build) and extracting the build files.
1. Creating a new Docker image that contains the pre-built files, clones a Git repository, and runs Theia.

## Pre-requisites

Make sure you have the following installed on your machine:

- Docker
- Git

## Step 1: Pre-build Theia

### Build the Pre-build Image

```bash
docker build -t theia-build -f Dockerfile.build .
```

### Extract the Build Files

Create a temporary container from the build image and copy the files to the local machine:

```bash
docker create --name theia-temp theia-build
docker cp theia-temp:/home/theia ./built
docker rm -v theia-temp
```

## Step 2: Create the Final Image

### Build the Main Image

```bash
docker build -t theia-app .
```

## Step 3: Run the Container

You can now run a container from the theia-app image:

```bash
docker run -it -e GIT_REPO_URL=https://github.com/your-username/your-repo.git -p 3000:3000 theia-app
```

Replace the GIT_REPO_URL environment variable with your Git repository URL.

## Step 4: Access Theia

You can now access Theia IDE at http://localhost:3000.
