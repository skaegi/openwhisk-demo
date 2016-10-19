#OpenWhisk
wsk rule disable pipeline-to-slack
wsk rule delete pipeline-to-slack
wsk action delete stage-complete-sequence
wsk action delete transform
wsk trigger delete stage-complete

wsk rule disable trigger-pipeline
wsk rule delete trigger-pipeline
wsk action delete run-pipeline
wsk trigger delete repo-push

wsk rule disable issues-to-slack
wsk rule delete issues-to-slack
wsk action delete issues-sequence
wsk action delete slackissues
wsk trigger delete issues-hook

wsk package delete pipeline
wsk package delete slack
wsk package delete github
