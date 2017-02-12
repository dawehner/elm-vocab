module Types exposing (..)

import Array exposing (Array)
import Dict exposing (Dict)

-- Model

type alias Card =
    { category : String
    , front : String
    , back : String
    }


type alias VocabList =
    Array Card


type alias Model =
    { activeCard : Int
    , list : VocabList
    , stats : Stats
    }


type alias Stats =
    Dict Int Stat


type alias Stat =
    { known : Int
    , unknown : Int
    }

