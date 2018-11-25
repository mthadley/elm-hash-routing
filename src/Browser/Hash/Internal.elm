module Browser.Hash.Internal exposing
    ( fixPathQuery
    , pathFromFragment
    , updateUrl
    )

import Url exposing (Url)


updateUrl : Url -> Url
updateUrl =
    fixPathQuery << pathFromFragment


pathFromFragment : Url -> Url
pathFromFragment url =
    { url | path = Maybe.withDefault "" url.fragment, fragment = Nothing }


fixPathQuery : Url -> Url
fixPathQuery url =
    let
        ( newPath, newQuery ) =
            case String.split "?" url.path of
                path :: query :: _ ->
                    ( path, Just query )

                _ ->
                    ( url.path, url.query )
    in
    { url | path = newPath, query = newQuery }
