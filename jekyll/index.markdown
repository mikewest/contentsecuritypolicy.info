---
layout: default
---
If you run an even moderately valuable web site, you're under attack almost
constantly. You've taken every precaution, properly [validating user
input][inputvalidation], and contextually escaping everything you write out to
the page. However, your advisaries are clever and numerous, and your time and
attention are limited. You will slip up. A small hole will open. It will be
discovered and exploited. You will be sad. So it goes.

[inputvalidation]: https://www.owasp.org/index.php/Data_Validation

Or does it?

Protecting your site by setting a **Content Security Policy** will add
significant depth to your defenses, mitigating the risk of content injection
attacks by radically reducing their potential effect.

## Content Securawhat?

The central vulnerability that content-injection attacks rely upon is a
browser's inability to distinguish between content you've intentionally
included on a site, and content that's been maliciously injected. That is,
`<script>doSomethingUseful();</script>` looks exactly the same to a browser as
`<script>alert('xss');</script>` when included on a page. Content Security
Policy (CSP) gives you a way to teach the browser about the content you _mean_
to deliver, allowing it to block everything that doesn't match a simple set of
rules.

These rules are delivered via an especially creatively named HTTP header:
`Content-Security-Policy`. The policy consists of various directives that
dictate how a certain resource type should be handled, each separated by a
semicolon.  A few examples should make the broad syntax clear:

*   **SSL Only**: A developer wants to ensure that every page of her site _only_
    loads resources over secure channels. She can enforce this restriction by
    setting a policy that says "Only render or execute resources that are
    delivered over HTTPS." Translated into CSP, that reads:
    
        Content-Security-Policy: default-src https:

*   **Lockdown**: A bank wants to ensure that _only_ resources from its content
    delivery network load, and it's quite sure that it only uses JavaScript,
    CSS, and images (no plugins, no `XMLHttpRequest`, no web fonts, etc.). It
    would like a policy that says "Block all resources of all types, except for
    images, style, and script loaded from https://cdn.example.com." Translated
    to CSP, that reads:
    
        Content-Security-Policy:
            default-src 'none';
            img-src https://cdn.example.com;
            script-src https://cdn.example.com;
            style-src https://cdn.example.com</code></pre>

