module App.Model exposing (Msg(..), Model)

import Http
import Types exposing (..)
import PageType exposing (Page)

type Msg
    = CardKnown
    | CardNotKnown
    | ChooseRandomCard
    | SetCard Int
      -- Fetch vocabs
    | FetchCards
    | FetchCardsSucceed (Result Http.Error CardList)
    | FetchFail Http.Error
    | SetActivePage Page

type alias Model =
    { activeCard : Int
    , list : CardList
    , stats : Stats
    , activePage : Page
    }
