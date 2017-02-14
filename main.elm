module Main exposing (..)

import Html exposing (Html)
import Update exposing (update, init)
import View exposing (view)
import App.Subscriptions exposing (subscriptions)
import RouteUrl
import App.Router exposing (..)


main =
    RouteUrl.program
        { delta2url = delta2url
        , location2messages = location2messages
        , init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
