/*eslint-env browser */
function main(params) {
  var text = "[" + params.issue.title + "]" + "(" + params.issue.url + ")";
	return {
		text: text
	};
}
