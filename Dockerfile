FROM openjdk:8-jdk-alpine
ENV SONAR_SCANNER_VERSION 3.2.0.1227
ENV TZ=Europe/Paris
COPY sonar-scanner-run.sh /usr/bin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    apk add --no-cache wget nodejs && \
    wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}.zip && \
    apk del wget && \
    unzip sonar-scanner-cli-${SONAR_SCANNER_VERSION} && \
    rm -rf sonar-scanner-cli-${SONAR_SCANNER_VERSION}.zip /var/cache/apk/* && \
    cd /usr/bin && ln -s /sonar-scanner-${SONAR_SCANNER_VERSION}/bin/sonar-scanner sonar-scanner && \
    ln -s /usr/bin/sonar-scanner-run.sh /bin/gitlab-sonar-scanner
CMD ["/bin/gitlab-sonar-scanner"]
