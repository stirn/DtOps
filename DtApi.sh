#!/bin/bash

# Define a function to upload the BOM file and retrieve the processing token
post_bom() {
  local dt_api_key="$1"
  local project_name="$2"
  local filename="$3"
  local url="$dt_url/api/v1/bom"
  local curl_params=(
    -s
    -X
    'POST'
    "$url"
    -H "X-Api-Key: $dt_api_key"
    -H "Content-Type:multipart/form-data"
    -F projectName=$project_name
    -F autoCreate=true
    -F bom=@$filename
  )
  local response=$(curl "${curl_params[@]}")
  echo "$response"
}

# Define a function to poll for the processing status of the BOM file
get_bom_token_status() {
  local dt_api_key="$1"
  local token="$2"
  local url="$dt_url/api/v1/bom/token/$token"
  declare -i poll_counter=0
  local curl_params=(
    -s
    -X
    'GET'
    "$url"
    -H "X-Api-Key: $dt_api_key"
    -H "accept: application/json"
  )
  while true; do
    [[ "$poll_counter" -gt 300 ]] && echo "--- Something went wrong - dtrack could not finish processing in 5 minutes" && exit 1
    local response=$(curl "${curl_params[@]}")
    local processing=$(echo "$response" | jq -r '.processing')
    [[ "$processing" == "false" ]] && break || sleep 1 && poll_counter=${poll_counter}+1
  done
}

# Define a function to retrieve the project metrics
get_project_metrics() {
  local dt_api_key="$1"
  local project_uuid="$2"
  local url="$dt_url/api/v1/metrics/project/$project_uuid/current"
  local curl_params=(
    -s
    -X
    'GET'
    "$url"
    -H "X-Api-Key: $dt_api_key"
    -H "accept: application/json"
  )
  local response=$(curl "${curl_params[@]}")
  echo "$response"
}

get_project() {
  local uri="$1/api/v1/project"
  local api_key="$2"
  local curl_params=(
    -s
    -X
    'GET'
    "$uri"
    -H "X-Api-Key: $api_key"
    -H "accept: application/json"
  )
  local response=$(curl "${curl_params[@]}")
  echo "$response" | jq '.' | jq -c --argjson indent 4 'walk(if type == "object" or type == "array" then . else . end)')
}

get_project_lookup() {
  local dt_api_key="$1"
  local project_name="$2"
  local url="$dt_url/api/v1/project/lookup?name=$project_name"
  local curl_params=(
    -s
    -X
    'GET'
    "$url"
    -H "X-Api-Key: $dt_api_key"
    -H "accept: application/json"
  )
  local response=$(curl "${curl_params[@]}")
  echo "$response"
}
