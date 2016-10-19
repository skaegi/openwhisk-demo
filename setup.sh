#OpenWhisk
##Bind Packages
wsk package bind /whisk.system/github github --param username skaegi --param repository starfighter-whisk --param accessToken $GH_TOK
wsk package bind /whisk.system/slack slack --param url "$SLACK_WH" --param username "Lord British" --param channel "#sk-test-whisk"
wsk package bind /orion_sk/pipeline pipeline -p api "devops-api.ng.bluemix.net" -p auth "$(cf oauth-token)" -p pipelineId 64a17e06-5312-4316-9a01-8bc264c552e6 -p proxy "https://pipeline-webhook-proxy.mybluemix.net"

## Wire GitHub to Pipeline
wsk trigger create repo-push --feed github/webhook --param events push
wsk action create run-pipeline --sequence pipeline/run
wsk rule create trigger-pipeline repo-push run-pipeline

## Wire Pipeline to Slack
wsk trigger create stage-complete --feed pipeline/hook
wsk action create transform transform.js
wsk action create stage-complete-sequence --sequence transform,slack/post
wsk rule create pipeline-to-slack stage-complete stage-complete-sequence

## Wire GitHub Issues to Slack
wsk trigger create issues-hook --feed github/webhook --param events issues
wsk action create slackissues slackissues.js
wsk action create issues-sequence --sequence slackissues,slack/post
wsk rule create issues-to-slack issues-hook issues-sequence

