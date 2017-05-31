#!/bin/sh

if [ -z "$SONAR_URL" ]; then
  echo "Undefined \"SONAR_URL\" env" && exit 1
fi

URL=$SONAR_URL

COMMAND="sonar-scanner -Dsonar.host.url=$URL"

if [ ! -z "$SONAR_TOKEN" ]; then
  COMMAND="$COMMAND -Dsonar.login=$SONAR_TOKEN"
fi

if [ ! -z "$SONAR_PROJECT_VERSION" ]; then
  COMMAND="$COMMAND -Dsonar.projectVersion=$SONAR_PROJECT_VERSION"
fi

if [ ! -z "$SONAR_DEBUG" ]; then
  COMMAND="$COMMAND -X"
fi

if [ ! -z "$SONAR_SOURCES" ]; then
  COMMAND="$COMMAND -Dsonar.sources=$SONAR_SOURCES"
fi

if [ ! -z "$SONAR_PROFILE" ]; then
  COMMAND="$COMMAND -Dsonar.profile=$SONAR_PROFILE"
fi

if [ ! -z "$SONAR_GITLAB_PROJECT_ID" ]; then
  COMMAND="$COMMAND -Dsonar.gitlab.project_id=$SONAR_GITLAB_PROJECT_ID"
fi

if [ ! -z "$SONAR_LANGUAGE" ]; then
  COMMAND="$COMMAND -Dsonar.language=$SONAR_LANGUAGE"
fi

if [ ! -z "$SONAR_ENCODING" ]; then
  COMMAND="$COMMAND -Dsonar.sourceEncoding=$SONAR_ENCODING"
fi

if [ ! -z $CI_BUILD_REF ]; then
  COMMAND="$COMMAND -Dsonar.gitlab.commit_sha=$CI_BUILD_REF"
fi

if [ ! -z $CI_BUILD_REF_NAME ]; then
  COMMAND="$COMMAND -Dsonar.gitlab.ref_name=$CI_BUILD_REF_NAME"
fi

if [ ! -z $SONAR_BRANCH ]; then
  COMMAND="$COMMAND -Dsonar.branch=$SONAR_BRANCH"
fi

# `analysis by default
if [ ! -z $SONAR_ANALYSIS_MODE ]; then
  COMMAND="$COMMAND -Dsonar.analysis.mode=$SONAR_ANALYSIS_MODE"
  if [ $SONAR_ANALYSIS_MODE="preview" ]; then
    COMMAND="$COMMAND -Dsonar.issuesReport.console.enable=true"
  fi
fi

$COMMAND
