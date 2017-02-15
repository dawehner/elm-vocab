module App.Model exposing (Msg(..), Model)

import Http
import App.Types exposing (..)
import App.PageType exposing (Page)


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
    , activeSide : CardSide
    , list : CardList
    , stats : Stats
    , activePage : Page
    }
