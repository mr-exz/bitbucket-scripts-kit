#!/usr/bin/env bash

gitlab_get_number_of_pages(){
  local gitlab_url gitlab_token
  gitlab_url=${1}
  gitlab_token=${2}
  echo "$(curl -s -I "${gitlab_url}/api/v4/projects?private_token=${gitlab_token}&per_page=100" | grep x-total-pages | awk '{print $2}')"
}

gitlab_get_list_of_project() {
  local gitlab_url gitlab_token gitlab_total_number_of_pages tmp_file_name
  gitlab_url=${1}
  gitlab_token=${2}
  gitlab_total_number_of_pages=${3//[$'\n\r']/}
  tmp_file_name=$(mktemp)

  for page_number in $(seq 1 ${gitlab_total_number_of_pages}); do
	  curl -s "${gitlab_url}/api/v4/projects?private_token=${gitlab_token}&per_page=100&page=${page_number}" | jq -r '.[].http_url_to_repo' >> ${tmp_file_name}
  done

  echo "${tmp_file_name}"
}