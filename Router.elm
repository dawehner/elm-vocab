module Router exposing (delta2url, location2messages)

import RouteUrl exposing (HistoryEntry(..), UrlChange)
import PageType exposing (..)
import Types exposing (Model)
import Update exposing (..)
import UrlParser exposing (..)
import Navigation exposing (Location)


delta2url : Model -> Model -> Maybe UrlChange
delta2url prev current =
    case current.activePage of
        MainPage ->
            Just <| UrlChange NewEntry "#/"

        Stats ->
            Just <| UrlChange NewEntry "#/stats"


location2messages : Location -> List Msg
location2messages location =
    case UrlParser.parseHash parseUrl location of
        Just msgs ->
            [ msgs ]

        Nothing ->
            []


parseUrl : Parser (Msg -> c) c
parseUrl =
    oneOf
        [ map (SetActivePage MainPage) (s "")
        , map (SetActivePage Stats) (s "stats")
        ]
