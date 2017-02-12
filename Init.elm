module Init exposing (init)

import Array exposing (Array)
import Dict exposing (Dict)

import Types exposing (..)
import Update exposing (update)
import Update exposing (update, Msg(..))

init : ( Model, Cmd Msg )
init =
    (update FetchCards initStatic)


initStatic =
    (Model 0 (Array.fromList []) Dict.empty)
