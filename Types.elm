module Types exposing (..)

import Array exposing (Array)
import Dict exposing (Dict)

-- Model

type alias Model =
    { activeCard : Int
    , list : CardList
    , stats : Stats
    }

type alias Card =
    { category : String
    , front : String
    , back : String
    }

type alias CardList = Array Card



type alias Stats =
    Dict Int Stat


type alias Stat =
    { known : Int
    , unknown : Int
    }

