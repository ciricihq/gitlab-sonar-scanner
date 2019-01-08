FROM openjdk:8-jdk-alpine
## Based on this example http://stackoverflow.com/a/40612088/865222
ENV SONAR_SCANNER_VERSION 3.2.0.1227

RUN apk add --no-cache wget nodejs && \
    wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip && \
    unzip sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip && \
    apk del wget && \
    ln -s /sonar-scanner-${SONAR_SCANNER_VERSION}-linux/bin/sonar-scanner /usr/bin/sonar-scanner && \
    ln -s /usr/bin/sonar-scanner-run.sh /bin/gitlab-sonar-scanner

COPY sonar-scanner-run.sh /usr/bin
