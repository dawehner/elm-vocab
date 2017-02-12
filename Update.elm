module Update exposing (..)

import Debug
import Dict exposing (Dict)
import Random
import Array exposing (Array)

import Types exposing (..)

type Msg
    = CardKnown
    | CardNotKnown
    | ChooseRandomCard
    | SetCard Int


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

