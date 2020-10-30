epoch_time=$(date +%s000)
milliseconds_in_second=1000
milliseconds_in_minute=$(($milliseconds_in_second * 60))
milliseconds_in_hour=$(($milliseconds_in_minute * 60))
milliseconds_in_day=$(($milliseconds_in_hour * 24))
echo "milliseconds_in_minute: ${milliseconds_in_minute}"
echo "milliseconds_in_hour: ${milliseconds_in_hour}"
echo "milliseconds_in_day: ${milliseconds_in_day}"

log_group_name="/aws/events/all-events-01"
start_time=$(($epoch_time - $milliseconds_in_hour))
end_time="${epoch_time}"

resp=$(aws logs start-query \
    --log-group-name "${log_group_name}" \
    --start-time "${start_time}" \
    --end-time "${end_time}" \
    --query-string '
fields @timestamp, detail.eventSource, detail.eventName
| sort @timestamp desc
| limit 100
    ')

query_id=$(echo "${resp}" | jq --raw-output '.queryId')

echo "query_id: ${query_id}"

sleep_in_seconds=1

query_status=""

while [ "${query_status}" != "Complete" ]
do
    query_resp=$(aws logs get-query-results \
        --query-id "${query_id}")

    query_status=$(echo "${query_resp}" | jq --raw-output '.status')

    sleep $sleep_in_seconds
done

echo "${query_resp}" | jq '.'


