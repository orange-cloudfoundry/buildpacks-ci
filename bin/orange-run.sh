#!/usr/bin/env bash

export LPASS_CONCOURSE_PRIVATE_FILE=${LPASS_CONCOURSE_PRIVATE_FILE:-"cw_vdr/concourse-private.yml"}
export LPASS_DEPLOYMENTS_BUILDPACKS_FILE=${LPASS_DEPLOYMENTS_BUILDPACKS_FILE:-"OrangeShare-Buildpacks/deployments-buildpacks.yml"}
export LPASS_REPOS_PRIVATE_KEYS_FILE=${LPASS_REPOS_PRIVATE_KEYS_FILE:-"OrangeShare-Buildpacks/buildpack-repos-private-keys.yml"}

export PIPELINE_PREFIX=${PIPELINE_PREFIX:-"buildpack-"}
export TARGET_NAME="concourse-cw"

bin/update-all-the-pipelines $*