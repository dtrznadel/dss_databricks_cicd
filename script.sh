export DATABRICKS_HOST='to be filled'
export DATABRICKS_TOKEN="to be filled"
export job_id=$(databricks jobs list -o json | jq --arg datasetName "sample_job" '.[] | select(.settings.name == $datasetName)' | jq '.job_id')
JOBS_FOLDER_PATH="/mnt/host/c/repo/Data-Science-Training"
jq -n --argjson job_id "$job_id" '{"job_id": $job_id, "new_settings": input}' < "$JOBS_FOLDER_PATH/sample_job.json" > "$JOBS_FOLDER_PATH/sample_job_update.json"
response=$(databricks jobs reset --json @"$JOBS_FOLDER_PATH/sample_job_update.json" --output json)
echo " this is the response $response"