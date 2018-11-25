module Browser.Hash exposing (application)

{-| Check out the README for more a more in depth explanation of why
this package exists. Otherwise, skip down [`application`](#application) to
get started.

@docs application

-}

import Browser exposing (Document, UrlRequest)
import Browser.Hash.Internal exposing (updateUrl)
import Browser.Navigation exposing (Key)
import Url exposing (Url)


{-| A replacement for [`Browser.application`][browser-application] that
will automatically process your hash-based Url's into ones that will work
out of the box with the standard parsing logic of [`Url.Parser`][urlparser].

It's usage is the same as [`Browser.application`][browser-application]:

    import Browser.Hash as Hash

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

[browser-application]: https://package.elm-lang.org/packages/elm/browser/latest/Browser#application
[urlparser]: https://package.elm-lang.org/packages/elm/url/latest/Url-Parser

-}
application :
    { init : flags -> Url -> Key -> ( model, Cmd msg )
    , view : model -> Document msg
    , update : msg -> model -> ( model, Cmd msg )
    , subscriptions : model -> Sub msg
    , onUrlRequest : UrlRequest -> msg
    , onUrlChange : Url -> msg
    }
    -> Program flags model msg
application config =
    Browser.application
        { init = \flags url key -> config.init flags (updateUrl url) key
        , view = config.view
        , update = config.update
        , subscriptions = config.subscriptions
        , onUrlRequest = config.onUrlRequest
        , onUrlChange = config.onUrlChange << updateUrl
        }
