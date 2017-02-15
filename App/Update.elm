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


init : ( Model, Cmd Msg )
init =
    (update FetchCards initStatic)


initStatic : Model
initStatic =
    (Model -1 (Array.fromList []) Dict.empty MainPage)


updateStats : Int -> Bool -> Stats -> Stats
updateStats id known stats =
    let
        id2 =
            Debug.log "id" id

        oldStats =
            Debug.log "stats" stats

        oldStat =
            Maybe.withDefault (Stat 0 0) (Dict.get id stats)

        newStat =
            Debug.log "newStat"
                (case known of
                    True ->
                        { oldStat | known = oldStat.known + 1 }

                    False ->
                        { oldStat | unknown = oldStat.unknown + 1 }
                )
    in
        (Debug.log "updateStats" (Dict.insert id newStat stats))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CardKnown ->
            (update ChooseRandomCard { model | stats = updateStats model.activeCard True model.stats })

        CardNotKnown ->
            (update ChooseRandomCard { model | stats = updateStats model.activeCard False model.stats })

        ChooseRandomCard ->
            ( model, Random.generate SetCard (Random.int 0 (Array.length model.list)) )

        SetCard id ->
            ( { model | activeCard = id }, Cmd.none )

        FetchCards ->
            ( model, Http.send FetchCardsSucceed getCards )

        FetchCardsSucceed (Ok vocabs) ->
            (update ChooseRandomCard ({ model | list = vocabs }))

        FetchCardsSucceed (Err _) ->
            ( model, Cmd.none )

        SetActivePage page ->
            ( { model | activePage = page }, Cmd.none )

        -- @todo Figure out some debug capablity.
        FetchFail _ ->
            ( model, Cmd.none )
