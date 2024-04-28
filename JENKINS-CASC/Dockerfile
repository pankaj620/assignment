
FROM jenkins/jenkins:latest

# Install Jenkins plugins using plugins.txt
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

# Copy the Jenkins configuration YAML file
COPY jenkins.yaml /usr/share/jenkins/ref/jenkins.yaml

# Set the Jenkins Configuration as Code (CasC) environment variable
ENV CASC_JENKINS_CONFIG=/usr/share/jenkins/ref/jenkins.yaml

# Running Jenkins
CMD ["jenkins", "-Djenkins.install.runSetupWizard=false"]
