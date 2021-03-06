---
layout: directive
directive: script-src
---

The `script-src` directive is the most important directive in Content Security
Policy: it controls a page's execution of script, providing you with the ability
to block an attacker's attempt to inject untrusted code into your pages. Like
the {% directive style-src %} directive, `script-src` accepts a whitelist of
origins which should be allowed to provide JavaScript for a page, and also
accepts special keyword values to control the use of inline script.

### Examples

If you only load JavaScript from your own origin, set `script-src`'s value to
`'self'`:

    Content-Security-Policy: script-src 'self'

Many sites load JavaScript over a content delivery network of some sort. If
you're using, say, `https://cdn.example.com`, you'd set the following policy:

    Content-Security-Policy:
        script-src https://cdn.example.com

That policy would allow you to load your own script, but what about all those
third-party widgets you'd love to include on your site? If you accept the risk
associated with loading and executing code from a third-party site, then you can
add its origin to the list of accepted sources of script. Let's say you wanted
to include the Google +1 button, and Twitter's Tweet button on a page. You'll
need to whitelist `https://api.google.com` for the former, and
`https://platform.twitter.com` for the latter:

    Content-Security-Policy:
        script-src https://cdn.example.com
                   https://api.google.com
                   https://platform.twitter.com

Note that some of these services also use frames to contain portions of the
interface they inject into your page. You'll need to ensure that the
{% directive frame-src %} directive is set accordingly.

Finally, let's assume that you have _really_ good reasons for requiring inline
script and `eval()` in order to make some page work correctly. You'll need to
whitelist `'unsafe-inline'` and `'unsafe-eval'` respectively:

    Content-Security-Policy:
        script-src https://cdn.example.com
                   'unsafe-inline'
                   'unsafe-eval'

Please don't ever do this.

### Usage Recommendations

First and foremost, avoid whitelisting inline script. Blocking inline script is
the single biggest security win that you get by applying a Content Security
Policy. Allowing inline script by whitelisting `'unsafe-inline'` is a terrible
idea, and guts much of the protection that Content Security Policy offers.

This means that you'll need to move blocks of inline script in existing
applications out into external files. For example, an example HTML document
containing the following code:

    <script>
      function doStuff() {
        // AMAZINGNESS!
      }
    </script>
    <a href="javascript:doStuff()">Click!</a>
    <button onclick="doStuff()">Click!</button>
{:data-filename="example.html"}
{: .lang-html}

has three distinct instances of inline JavaScript. The script block is obvious,
less so are the `javascript:` URL in the link and the inline event handler
(`onclick`) on the button. Each of these can be trivially rewritten to avoid
inlining. That might look something like:

    <script src="example.js"></script>
    <a href="javascript:doStuff();" id="link1">
        Click me!</a>
    <button onclick="doStuff();" id="button1">
        Click me!</button>
{:data-filename="example.html"}
{: .lang-html}

    function doStuff() {
      // [AMAZINGNESS GOES HERE]
    }

    // Once the document's DOM is ready, attach event
    // listeners to the relevant elements.
    document.addEventListener('DOMContentLoaded',
        function () {
          document.querySelector('#link1')
                  .addEventListener('click', doStuff);
          document.querySelector('#button1')
                  .addEventListener('click', doStuff);
        });
{:data-filename="example.js"}
{: .lang-js}
