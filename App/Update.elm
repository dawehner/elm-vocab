module App.Update exposing (update, init)

import Debug
import Dict exposing (Dict)
import Random
import Array exposing (Array)
import Task exposing (perform)
import Http
import App.Types exposing (..)
import App.TypesHttp exposing (..)
import App.PageType exposing (..)
import App.Model exposing (..)
import RemoteData exposing (..)


init : ( Model, Cmd Msg )
init =
    (update FetchCards initStatic)

getCards =
    Http.get "data/cards.js" cardListDecoder
      |> RemoteData.sendRequest
      |> Cmd.map CardsResponse

initStatic : Model
initStatic =
    { activeCard = Nothing
    , activeSide = Front
    , list = NotAsked
    , stats = Dict.empty
    , activePage = MainPage
    }


updateStats : Int -> Bool -> Stats -> Stats
updateStats id known stats =
    let
        oldStat =
            Maybe.withDefault (Stat 0 0) (Dict.get id stats)

        newStat =
                (case known of
                    True ->
                        { oldStat | known = oldStat.known + 1 }

                    False ->
                        { oldStat | unknown = oldStat.unknown + 1 }
                )
    in
        Dict.insert id newStat stats

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CardKnown ->
          case model.activeCard of
            Just activeCard -> (update ChooseRandomCard { model | stats = updateStats activeCard True model.stats })
            Nothing -> (model, Cmd.none)

        CardNotKnown ->
          case model.activeCard of
            Just activeCard -> (update ChooseRandomCard { model | stats = updateStats activeCard False model.stats })
            Nothing -> (model, Cmd.none)

        ChooseRandomCard ->
            case model.list of
              Success cards -> ( model, Random.generate SetCard (Random.int 0 (Array.length cards)) )
              --- Is doing nothing otherwise the right approach?
              _ -> ( model, Cmd.none)

        SetCard id ->
            ( { model | activeCard = Just id }, Cmd.none )

        FetchCards ->
            ( model, getCards )

        CardsResponse response ->
            (update ChooseRandomCard ({ model | list = response }))

        SetActivePage page ->
            ( { model | activePage = page }, Cmd.none )
