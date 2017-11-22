#!/usr/bin/env bash

handle_gradle_errors() {
    local log_file="$1"
    local header="Failed to run Gradle!"
    local previousVersion="You can also try reverting to the previous version of the buildpack by running:
$ heroku buildpacks:set https://github.com/heroku/heroku-buildpack-gradle#previous-version"

    local footer="Thanks, GoodRain"

    if grep -qi "Task 'stage' not found in root project" "$log_file"; then
        error "${header}
It looks like your project does not contain a 'stage' task, which we needs in order
to build your app. Our Dev Center article on preparing a Gradle application for goodrain
describes how to create this task:
http://doc.goodrain.com/usage/181925

If you're stilling having trouble, please submit a ticket so we can help:
http://t.goodrain.com/

${footer}"

    elif grep -qi "Could not find or load main class org.gradle.wrapper.GradleWrapperMain" "$log_file"; then
        error "${header}
It looks like you don't have a gradle-wrapper.jar file checked into your Git repo.
Heroku needs this JAR file in order to run Gradle.  Our Dev Center article on preparing
a Gradle application for goodrain describes how to fix this:
http://doc.goodrain.com/usage/181925

If you're stilling having trouble, please submit a ticket so we can help:
http://t.goodrain.com/

${footer}"
    else
        error "${header}
We're sorry this build is failing. If you can't find the issue in application
code, please submit a ticket so we can help: http://t.goodrain.com/

${footer}"
    fi
}
