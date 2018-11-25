# `elm-hash-routing`

A small wrapper around `Browser.application` that enables easy hash routing!

## The Basics

Before using this package, make sure you have a good idea of how
applications are structured in Elm. Here are some good resources:

* [The Official Guide][elm-guide]
* [`elm/browser`][elm/browser]

If you are already up to speed on these, then skip to the next section!

## Why Hash Routing?

In most cases, you should prefer not to use this package or use hash routing.
It's sort of a hack that allows us to let the client manage routing of the
application, since servers traditionally ignore the hash (or "fragment") in
a Url.

However, sometimes you may not have control of the server or it's routing logic.
A common example is a single page application on a static hosting service, like
Github pages. In cases like this, you can use `Browser.Hash.application` to keep
your Url parsing the same.

## Usage

First, install the package:

```sh
elm install mthadley/elm-hash-routing
```

You should write your URL parsing logic as if your application was **not** using hash
routing. Then, all you need to do is swap out your call to
`Browser.application` with `Browser.Hash.Application`:

``` elm
module Main exposing (main)

import App exposing (Model, Msg, init, subscriptions, update, view)
import Browser.Hash as Hash
import Router


main : Program () Model Msg
main =
    Hash.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = App.RouteChange << Router.parse
        , onUrlRequest = App.OnUrlRequest
        }
```

Now the `Url` that your `onUrlChange` messages recieve will appear as if you are
using server routing! The fragment is essentially moved to the `path` of the
`Url`, with some extra processing to make sure everything is consistent.

You'll still need to be mindful of any internal links you create in your
application. Make sure to prefix them with a `#`.

If you decide to migrate away from hash routing in the future, you just need to
switch back to `Browser.application`, and your url parsing can remain the same.

## Coming from Elm 0.18

This can be used to replace the behavior provided by [`parseHash`][parseHash] in
the [`evancz/url-parser`][evancz/url-parser] package. It was removed in Elm
`0.19`, however we can easily replicate hash routing in this package with the
tools provided in [`elm/browser`][elm/browser] and [`elm/url`][elm/url]!

[elm-guide]: https://guide.elm-lang.org/
[parseHash]: https://package.elm-lang.org/packages/evancz/url-parser/latest/UrlParser#parseHash
[elm/browser]: https://package.elm-lang.org/packages/elm/browser/latest/
[elm/url]: https://package.elm-lang.org/packages/elm/url/latest/
[evancz/url-parser]: https://package.elm-lang.org/packages/evancz/url-parser/latest/
