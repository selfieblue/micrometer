################################################################################
# Actual Runtime Image
################################################################################

# From Custom Base Image
FROM openjdk:8-jre-alpine3.9

# For TomcatRoot
VOLUME /tmp

# Create
RUN mkdir -p /apps/appservice

# Copy over the built application
COPY  target/*.jar /apps/appservice/micrometer-0.0.1-SNAPSHOT.jar

# CMD for JAVA ARGS - hardcoded as ${HOME_DIRECTORY} as CMD cannot resolves var with exec format
CMD ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/apps/appservice/micrometer-0.0.1-SNAPSHOT.jar"]