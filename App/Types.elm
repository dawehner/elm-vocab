module App.Types exposing (..)

import Array exposing (Array)
import Dict exposing (Dict)
import App.PageType exposing (Page)


type alias Card =
    { category : String
    , front : String
    , back : String
    }


type CardSide
    = Front
    | Back


type alias CardList =
    Array Card

emptyCardList = Array.fromList []


type alias Stats =
    Dict Int Stat


type alias Stat =
    { known : Int
    , unknown : Int
    }
