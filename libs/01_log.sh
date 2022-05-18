#!/usr/bin/env bash

log_warning(){
  local timestamp
  timestamp=$(date -u "+%Y-%m-%d %H:%M:%S")
  echo "${timestamp} WARNING: ${*}"
}

log_error(){
  local timestamp
  timestamp=$(date -u "+%Y-%m-%d %H:%M:%S")
  echo "${timestamp} ERROR: ${*}"
}

log_info(){
  local timestamp
  timestamp=$(date -u "+%Y-%m-%d %H:%M:%S")
  echo "${timestamp} INFO: ${*}"
}