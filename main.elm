module Main exposing (..)

import Html exposing (Html)
import Init exposing (init)
import Update exposing (update)
import View exposing (view)
import Subscriptions exposing (subscriptions)


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
