# gitlab-sonar-scanner

## Using in your gitlab projects

Add the next stage to your `.gitlab-ci.yml`.

```yaml
stages:
- analysis

sonarqube:
  stage: analysis
  image: ciricihq/gitlab-sonar-scanner
  dependencies:
  - test
  variables:
    SONAR_URL: "http://your-gocd-server:9000"
    SONAR_PROJECT_KEY: "your-project-key"
    SONAR_PROJECT_NAME: "$CI_PROJECT_NAME"
    SONAR_PROJECT_VERSION: "$CI_BUILD_ID"
    SONAR_ANALYSIS_MODE: "issues"
  script:
  - /usr/bin/sonar-scanner-run.sh
```

You should have analysed the project by hand before to create it in your sonarqube server.

## Available environment variables

Can be checked in the official documentation: https://docs.sonarqube.org/display/SONARQUBE43/Analysis+Parameters

- SONAR__URL
- SONAR_PROJECT_VERSION
- SONAR_DEBUG
- SONAR_SOURCES
- SONAR_PROFILE
- SONAR_LANGUAGE
- SONAR_PROJECT_NAME
- SONAR_BRANCH
- SONAR_ANALYSIS_MODE

### sonar-gitlab specific

- SONAR_GITLAB_PROJECT_ID: The unique id, path with namespace, name with namespace, web url, ssh url or http url of the current project that GitLab.
- CI_BUILD_REF
- CI_BUILD_REF_NAME
