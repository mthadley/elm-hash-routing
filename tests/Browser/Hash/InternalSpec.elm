module Browser.Hash.InternalSpec exposing (suite)

import Browser.Hash.Internal exposing (pathFromFragment)
import Expect
import Test exposing (..)
import Url


suite : Test
suite =
    describe "Browser.Hash.Internal"
        [ describe "pathFromFragment"
            [ test "it should move the fragment to the path" <|
                \() ->
                    let
                        url =
                            "https://foo.io#some/path"
                                |> Url.fromString
                                |> pathFromFragment
                    in
                    Expect.all url
                        [ .fragment >> Expect.equal Nothing
                        , .path >> Expect.equal "some/path"
                        ]
            ]
        ]
