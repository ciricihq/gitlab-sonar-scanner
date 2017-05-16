#!/bin/sh

URL=$SONAR_URL
SONAR_TOKEN=$SONAR_TOKEN

if [ -z "$SONAR_PROJECT_KEY" ]; then
  echo "Undefined \"projectKey\"" && exit 1
else
  COMMAND="sonar-scanner -Dsonar.host.url=\"$URL\" -Dsonar.projectKey=\"$SONAR_PROJECT_KEY\""

  if [ ! -z "$SONAR_PROJECT_VERSION" ]; then
    COMMAND="$COMMAND -Dsonar.projectVersion=\"$SONAR_PROJECT_VERSION\""
  fi
  
  if [ ! -z "$SONAR_DEBUG" ]; then
    COMMAND="$COMMAND -X"
  fi

  if [ ! -z "$SONAR_SOURCES" ]; then
    COMMAND="$COMMAND -Dsonar.sources=\"$SONAR_SOURCES\""
  fi

  if [ ! -z "$SONAR_PROFILE" ]; then
    COMMAND="$COMMAND -Dsonar.profile=\"$SONAR_PROFILE\""
  fi
  
  if [ ! -z "$SONAR_GITLAB_PROJECT_ID" ]; then
    COMMAND="$COMMAND -Dsonar.gitlab.project_id=\"$SONAR_GITLAB_PROJECT_ID\""
  fi

  if [ ! -z "$SONAR_LANGUAGE" ]; then
    COMMAND="$COMMAND -Dsonar.language=\"$SONAR_LANGUAGE\""
  fi
  
  if [ ! -z "$SONAR_ENCODING" ]; then
    COMMAND="$COMMAND -Dsonar.sourceEncoding=\"$SONAR_ENCODING\""
  fi

  if [ ! -z "$SONAR_PROJECT_NAME" ]; then
    COMMAND="$COMMAND -Dsonar.projectName=\"$SONAR_PROJECT_NAME\""
  fi
  if [ ! -z $CI_BUILD_REF ]; then
    COMMAND="$COMMAND -Dsonar.gitlab.commit_sha=\"$CI_BUILD_REF\""
  fi
  if [ ! -z $CI_BUILD_REF_NAME ]; then
    COMMAND="$COMMAND -Dsonar.gitlab.ref_name=\"$CI_BUILD_REF_NAME\""
  fi
  if [ ! -z $SONAR_BRANCH ]; then
    COMMAND="$COMMAND -Dsonar.branch=\"$SONAR_BRANCH\""
  fi
  if [ ! -z $SONAR_ANALYSIS_MODE ]; then
    COMMAND="$COMMAND -Dsonar.analysis.mode=\"$SONAR_ANALYSIS_MODE\""
    if [ $SONAR_ANALYSIS_MODE="preview" ]; then
      COMMAND="$COMMAND -Dsonar.issuesReport.console.enable=true"
    fi
  fi

  eval $COMMAND
fi
