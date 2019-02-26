FROM openjdk:8-jdk-alpine

ENV SONAR_SCANNER_VERSION 3.3.0.1492

COPY sonar-scanner-run.sh /usr/bin

ADD https://bintray.com/sonarsource/SonarQube/download_file?file_path=org%2Fsonarsource%2Fscanner%2Fcli%2Fsonar-scanner-cli%2F${SONAR_SCANNER_VERSION}%2Fsonar-scanner-cli-${SONAR_SCANNER_VERSION}.zip /usr/bin/sonar-scanner

RUN apk add --no-cache nodejs && \
    ln -s /usr/bin/sonar-scanner-run.sh /bin/gitlab-sonar-scanner
