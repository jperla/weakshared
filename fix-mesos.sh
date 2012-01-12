#!/usr/bin/env bash
DEPLOY_DIR=`dirname "$0"`
DEPLOY_DIR=`cd "$DEPLOY_DIR"; pwd`

$DEPLOY_DIR/stop-mesos

sleep 1

$DEPLOY_DIR/start-mesos


