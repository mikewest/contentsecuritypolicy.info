---
layout: directive
directive: default-src
---

The `connect-src` directive defines a list of targets to which you can connect
via the various script interfaces that browsers make available:
[`XMLHttpRequest`][xhr], [`WebSocket`][ws], and [`EventSource`][es] are all
effected. If other similar script interfaces are invented in the future, you
should expect them to fall under `connect-src`'s purview.

[xhr]: http://www.w3.org/TR/XMLHttpRequest/
[ws]: http://dev.w3.org/html5/websockets/
[es]: http://dev.w3.org/html5/eventsource/

### Examples

Setting the value of the `connect-src` directive to `'none'` in your policy will
block all connections to all servers, rendering `XMLHttpRequest` and other such
script interfaces useless:

    Content-Security-Policy: connect-src 'none'

Setting the value to a set of origins will ensure that script interfaces can
only connect to those origins you specifically whitelist. For instance, here
we'll limit connections to `api.example.com` over HTTPS:

    Content-Security-Policy:
        connect-src https://api.example.com

If you'd like to create a WebSocket connection to `api.example.com`, you'll also
need to whitelist the `ws:` or `wss:` (much preferred!) scheme, as appropriate:

    Content-Security-Policy:
        connect-src https://api.example.com
                    wss://api.example.com

### Usage Recommendations

If your site doesn't make use of JavaScript to grab data from various APIs, then
setting a `connect-src` of `'none'` will protect you against a potential vector
of attack. If you do make use of `WebSocket` or other script interfaces in order
to build a more rich and interactive experience for your users, do make sure to
lock `connect-src` down to those sources of data that you're actually making
use of.
