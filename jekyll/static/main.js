document.addEventListener('DOMContentLoaded', function () {
  PR['registerLangHandler'](PR['createSimpleLexer']([], [
    [PR['PR_PUNCTUATION'], /;$/],
    [PR['PR_TYPE'], /(default|script|object|style|img|media|frame|font|connect|)-src/],
    [PR['PR_TYPE'], /(form-action|sandbox|script-nonce|plugin-types|frame-options|report-uri)(?:\s)/],
    [PR['PR_STRING'], /^'(?:[^']|'')*(?:')/],
    [PR['PR_KEYWORD'], /^[a-zA-Z-]+:[ \r\n]/],
    [PR['PR_PLAIN'], /^\w+/]
  ]), ['csp']);

  var codes = document.querySelectorAll('pre');
  for (var i = 0; i < codes.length; ++i) {
    codes[i].classList.add('prettyprint');
    if (!codes[i].className.match(/lang-/))
      codes[i].classList.add('lang-csp');
  }

  prettyPrint();
});
