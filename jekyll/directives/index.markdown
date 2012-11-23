---
layout: default
title: Directives
categories: directives
---

A page's Content Security Policy is defined via a set of directives. The entire
set is briefly defined below, click through each to get (lots) more detail:

<pre><code>Content-Security-Policy:

  {% directive default-src %} [Sets a default source list, which
               other directives might use as a
               fallback];

  {% directive script-src %}  [Whitelists trusted sources of
               script, and governs use of `eval()`
               and inline script];

  {% directive object-src %}  [Whitelists trusted plugin content];

  {% directive style-src %}   [Whitelisted CSS sources, and
               controls use of inline style];

  {% directive img-src %}     [Whitelists image sources];

  {% directive media-src %}   [Whitelists video/audio sources, and
               associated data (e.g. `track`)];

  {% directive frame-src %}   [Which origins can the current page
               include in a frame?];

  {% directive font-src %}    [Whitelisted web font sources];

  {% directive connect-src %} [Which endpoints can script connect
               to via XHR, WebSockets, and etc?];

  {% directive sandbox %}     [Applies sandboxing flags to the
               current page];

  {% directive report-uri %}  [Where should violation reports
               be delivered?]
</code></pre>
