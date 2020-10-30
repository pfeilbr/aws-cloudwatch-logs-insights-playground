# aws-cloudwatch-logs-insights-playground

learn [CloudWatch Logs Insights](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/AnalyzingLogData.html)

## Running Example Query via AWS CLI

see [`main.sh`](main.sh)

```sh
# run script containing query
./main.sh
# OR
# re-run on change
make dev
```

## Example Queries

```
fields @timestamp, detail.eventSource, detail.eventName, @message
| sort @timestamp desc
| limit 100


fields @timestamp, detail.eventSource, detail.eventName, @message
| filter detail.eventSource = "logs.amazonaws.com"
| sort @timestamp desc
| limit 100


fields @timestamp, detail.requestParameters.bucketName, detail.eventSource, detail.eventName, @message
| filter detail.eventSource like /s3.amazonaws.com/
| sort @timestamp desc
| limit 100
```

## Resources

* [CloudWatch Logs Insights Query Syntax](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CWL_QuerySyntax.html)
* [Sample Queries - Amazon CloudWatch Logs](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CWL_QuerySyntax-examples.html)