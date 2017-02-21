module App.Model exposing (Msg(..), Model)

import Http
import App.Types exposing (..)
import App.PageType exposing (Page)
import RemoteData exposing (WebData)


type Msg
    = CardKnown
    | CardNotKnown
    | ChooseRandomCard
    | SetCard Int
    | FetchCards
    | CardsResponse (WebData CardList)
    | SetActivePage Page


type alias Model =
    { activeCard : Int
    , activeSide : CardSide
    , list : WebData CardList
    , stats : Stats
    , activePage : Page
    }
