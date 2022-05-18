#!/usr/bin/env bash


bitbucket_import_git_repository() {
  local bitbucket_url bitbucket_user bitbucket_password bitbucket_project file_with_repos repo_name gitlab_user gitlab_password repo_prefix repo_url_tmp task_status
  bitbucket_url=${1}
  bitbucket_user=${2}
  bitbucket_password=${3}
  bitbucket_project=${4}
  file_with_repos=${5}
  gitlab_user=${6}
  gitlab_password=${7}
  repo_prefix=${8}

  for repo_url in $(cat ${file_with_repos}); do
    repo_url_tmp=${repo_url#"$repo_prefix/"}
    repo_name=$(echo ${repo_url_tmp} | sed -e "s/.git$//" | sed 's/\//-/g')
    task_status=$(curl -u "${bitbucket_user}:${bitbucket_password}" -s "${bitbucket_url}/rest/importer/latest/projects/${bitbucket_project}/import/repos" \
    -s \
    -X 'POST' \
    -H 'Content-Type: application/json' \
    --data-binary "{\"source\":{\"url\":\"${repo_url}\",\"type\":\"GIT\",\"error\":null,\"name\":\"${repo_name}\"},\"externalRepositories\":[{\"cloneUrl\":\"${repo_url}\",\"name\":\"${repo_name}\",\"description\":\"Imported from ${repo_name}\",\"scmId\":\"git\"}],\"owner\":\"\",\"credential\":{\"username\":\"${gitlab_user}\",\"password\":\"${gitlab_password}\",\"error\":null}}" | jq -r '.tasks[].state')

    log_info "Import ${repo_url} to Bitbucket:${bitbucket_url} in project:${bitbucket_project} repository name:${repo_name} task status:${task_status}"
  done
}

bitbucket_delete_all_git_repository_in_project(){
  local bitbucket_url bitbucket_user bitbucket_password bitbucket_project repo_name message
  bitbucket_url=${1}
  bitbucket_user=${2}
  bitbucket_password=${3}
  bitbucket_project=${4}

  for repo_name in $(curl -s -u "${bitbucket_user}:${bitbucket_password}" "${bitbucket_url}/rest/api/1.0/projects/${bitbucket_project}/repos?limit=10000" | jq -r ".values[].slug" | sort); do
	  message=`curl -s -X DELETE -u "${bitbucket_user}:${bitbucket_password}" "${bitbucket_url}/rest/api/1.0/projects/${bitbucket_project}/repos/$repo_name" | jq -r ".message"`
	  log_info "Repositroey ${repo_name} deleted from server:${bitbucket_url} project:${bitbucket_project} response:${message}"
  done;
}