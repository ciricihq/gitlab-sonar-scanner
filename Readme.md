gitlab-sonar-scanner
====================

[![pulls][docker hub svg]][docker hub]

Container to be used with [sonar gitlab plugin][].

Using it in your gitlab projects
--------------------------------

Add the next stage to your `.gitlab-ci.yml`.

~~~yaml
stages:
- analysis

sonarqube:
  stage: analysis
  image: ciricihq/gitlab-sonar-scanner
  variables:
    SONAR_URL: http://your.sonarqube.server
    SONAR_ANALYSIS_MODE: issues
  script:
  - gitlab-sonar-scanner
~~~

Remember to also create a `sonar-project.properties` file:

~~~conf
sonar.projectKey=your-project-key
sonar.exclusions=node_modules/**,coverage/**

sonar.sources=.

sonar.gitlab.project_id=git@your-git-repo.git
~~~

Before running the analysis stage you should ensure to have the project created
in your sonarqube + having it configured to use the gitlab plugin (specifying the
gitlab repo url).

You also need to give developer permissions to the user that will comment in gitlab.

### Sending the data to sonar

The previous stage will play along the gitlab plugin to publish all the coments
in it, but if you wanna send the analysis reports to sonar, you should change two
things:

~~~yaml
stages:
- analysis

sonarqube-reports:
  stage: analysis
  image: ciricihq/gitlab-sonar-scanner
  variables:
    SONAR_URL: http://your.sonarqube.server
    SONAR_ANALYSIS_MODE: publish
  script:
  - gitlab-sonar-scanner
~~~

Note how we've changed from `issues` to `publish` in `SONAR_ANALYSIS_MODE`.

### Full .gitlab-ci.yaml with preview + publish

~~~yaml
stages:
- analysis

sonarqube:
  stage: analysis
  image: ciricihq/gitlab-sonar-scanner
  variables:
    SONAR_URL: http://your.sonarqube.server
    SONAR_ANALYSIS_MODE: issues
  script:
  - sonar-gitlab-scanner

sonarqube-reports:
  stage: analysis
  image: ciricihq/gitlab-sonar-scanner
  variables:
    SONAR_URL: http://your.sonarqube.server
    SONAR_ANALYSIS_MODE: publish
  script:
  - sonar-gitlab-scanner
~~~

Available environment variables
-------------------------------

Can be checked in the official documentation: https://docs.sonarqube.org/display/SONARQUBE43/Analysis+Parameters

- `SONAR_URL`
- `SONAR_PROJECT_VERSION`
- `SONAR_DEBUG`
- `SONAR_SOURCES`
- `SONAR_PROFILE`
- `SONAR_LANGUAGE`
- `SONAR_PROJECT_NAME`
- `SONAR_BRANCH`
- `SONAR_ANALYSIS_MODE`

### sonar-gitlab specific

- `SONAR_GITLAB_PROJECT_ID`: The unique id, path with namespace, name with namespace,
  web url, ssh url or http url of the current project that GitLab.
- `CI_BUILD_REF`: See [ci/variables][variables]
- `CI_BUILD_REF_NAME`: See [ci/variables][variables]

### Defining custom sonar-scanner options

You can pass any additional option to the `gitlab-sonar-scanner` binnary, if needed:

~~~yaml
sonarqube-reports:
  image: ciricihq/gitlab-sonar-scanner
  variables:
    SONAR_URL: http://your.sonarqube.server
    SONAR_ANALYSIS_MODE: publish
  script:
  - sonar-gitlab-scanner -Dsonar.custom.param=whatever -Dsonar.custom.param2=whichever
~~~


LICENSE
=======

All the code contained in this repository is licensed under a GNU-GPLv3 license.

Copyright Alvarium.io 2017-2018.

See [LICENSE][] for more details

[sonar gitlab plugin]: https://github.com/gabrie-allaigre/sonar-gitlab-plugin
[variables]: https://docs.gitlab.com/ce/ci/variables
[docker hub]: https://hub.docker.com/r/ciricihq/gitlab-sonar-scanner
[LICENSE]: ./LICENSE

[docker hub svg]: https://img.shields.io/docker/pulls/ciricihq/gitlab-sonar-scanner.svg
