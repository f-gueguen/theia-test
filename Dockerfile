# Use an official node runtime as a parent image
FROM node:16.20-alpine

# Missing dependencies
RUN apk --no-cache add libsecret-dev libx11-dev libxkbfile-dev
RUN apk --no-cache add git
#RUN apk --no-cache add libc6-compat gcompat
#RUN apt-get update && apt-get install libsecret-1-dev libx11-dev libxkbfile-dev -y

# Set working directory to /home/theia
WORKDIR /home/theia

# Copy the pre-built Theia from the host into the Docker image
COPY built /home/theia
COPY theia/package.json /home/theia

# Set working directory to /home/workspace
WORKDIR /home/workspace

# Script to clone git repo and run Theia
COPY startup-script.sh /startup-script.sh
RUN chmod +x /startup-script.sh

# Make port 3000 available
EXPOSE 3000

# Run script on container launch
CMD [ "sh",  "/startup-script.sh" ]
