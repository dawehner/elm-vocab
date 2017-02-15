module App.Types exposing (..)

import Array exposing (Array)
import Dict exposing (Dict)
import App.PageType exposing (Page)


type alias Card =
    { category : String
    , front : String
    , back : String
    }


type alias CardList =
    Array Card


type alias Stats =
    Dict Int Stat


type alias Stat =
    { known : Int
    , unknown : Int
    }
