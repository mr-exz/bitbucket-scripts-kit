#!/usr/bin/env bash
BSK_SCRIPT_PATH=$(readlink -f $0)
BSK_BIN_PATH=$(dirname ${BSK_SCRIPT_PATH})
BSK_ROOT_PATH=$(dirname ${BSK_BIN_PATH})
BSK_LIB_PATH=${BSK_ROOT_PATH}/libs

# shellcheck source=../libs/01_log.sh
source ${BSK_LIB_PATH}/01_log.sh
# shellcheck source=../libs/02_bitbucket.sh
source ${BSK_LIB_PATH}/02_bitbucket.sh
# shellcheck source=../libs/03_gitlab.sh
source ${BSK_LIB_PATH}/03_gitlab.sh

#num_pages=$(gitlab_get_number_of_pages "https://gitlab.example.com" "secret-token")
log_info "Discovered pages: ${num_pages}"

log_info "Creating file with all git repos"
#file_name=$(gitlab_get_list_of_project "https://gitlab.example.com" "secret-token" ${num_pages})
log_info "Created file: ${file_name}"

log_info "Importing repositories"
#bitbucket_import_git_repository "https://bitbucket.example.com" "bitbucket-admin" "password" "GITLAB" ${file_name} "gitlab-admin" "password" "https://gitlab.example.com"

log_info "Deleting imported repositories"
#bitbucket_delete_all_git_repository_in_project "https://bitbucket.example.com" "bitbucket-admin" "password" "GITLAB"