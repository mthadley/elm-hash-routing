module Browser.Hash.InternalSpec exposing (suite)

import Browser.Hash.Internal exposing (fixPathQuery, pathFromFragment, updateUrl)
import Expect
import Test exposing (..)
import Url


suite : Test
suite =
    describe "Browser.Hash.Internal"
        [ describe "pathFromFragment"
            [ test "moves the fragment to the path" <|
                \() ->
                    let
                        maybeUrl =
                            "https://foo.io#some/path"
                                |> Url.fromString
                                |> Maybe.map pathFromFragment
                    in
                    case maybeUrl of
                        Nothing ->
                            Expect.fail "Should be a valid URL!"

                        Just url ->
                            Expect.all
                                [ .fragment >> Expect.equal Nothing
                                , .path >> Expect.equal "some/path"
                                ]
                                url
            ]
        , describe "fixPathQuery"
            [ test "moves the query out of the path" <|
                \() ->
                    let
                        addQuery url =
                            { url | path = url.path ++ "?foo=bar" }

                        maybeUrl =
                            "https://foo.io/home"
                                |> Url.fromString
                                |> Maybe.map (fixPathQuery << addQuery)
                    in
                    case maybeUrl of
                        Nothing ->
                            Expect.fail "Should be a valid URL!"

                        Just url ->
                            Expect.all
                                [ .fragment >> Expect.equal Nothing
                                , .path >> Expect.equal "/home"
                                , .query >> Expect.equal (Just "foo=bar")
                                ]
                                url
            ]
        , describe "updateUrl"
            [ test "moves the fragment to the path and query " <|
                \() ->
                    let
                        maybeUrl =
                            "https://foo.io#some/path?foo=bar"
                                |> Url.fromString
                                |> Maybe.map updateUrl
                    in
                    case maybeUrl of
                        Nothing ->
                            Expect.fail "Should be a valid URL!"

                        Just url ->
                            Expect.all
                                [ .fragment >> Expect.equal Nothing
                                , .path >> Expect.equal "some/path"
                                , .query >> Expect.equal (Just "foo=bar")
                                ]
                                url
            ]
        ]
