---
layout: directive
directive: default-src
---

The `default-src` directive, as you might imagine, defines a default source list
that some other directives will fall back onto if they're not explicitly
specified. Setting a default source list will force the browser to enforce all
of the following directives, using their value if present in the policy, or the
value of `default-src` if they're absent:

* {% directive connect-src %}
* {% directive font-src %}
* {% directive frame-src %}
* {% directive img-src %}
* {% directive media-src %}
* {% directive object-src %}
* {% directive script-src %}
* {% directive style-src %}

### Examples

If `default-src` is the only directive present, then the directives listed above
will all use it as their value. That is, a website can ensure that resources
only load from its own origin by setting the following policy:

    Content-Security-Policy: default-src 'self'

`img-src` isn't listed in the policy, so it uses the default source list. Ditto
for the other directives listed above.

---

When other directives are present, they override the default completely for a
specific resource type. For example, given :

    Content-Security-Policy: default-src 'self'
                             img-src https://example.com

The default source list contains `'self'`, meaning that only the current page's
origin is whitelisted. The list of allowed image sources contains
`https://example.com`, so we can load images from that origin. Note that there's
no funky inheritance: `'self'` isn't listed explicitly in `img-src`, so it's not
an acceptable source of images.

### Usage Recommendations

The most secure way to roll out a Content Security Policy is to begin by setting
`default-src`'s value to `'none'`. This locks down the page you're protecting,
ensuring that resources won't load unless you explicitly whitelist them. As an
example, look at the policy set for this very page:

    Content-Security-Policy:
        default-src 'none';
        img-src 'self';
        script-src 'self';
        style-src 'self'

We begin by locking things down, and then allow only images, script, and style,
loaded only from this website's origin. Directives that aren't specified
(`object-src`, for instance) fall back to the `default-src` source list, and
are blocked. We highly recommend you do the same.
