module View exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Array exposing (Array)
import Dict exposing (Dict)

import Types exposing (..)
import Update exposing (Msg, Msg(..))

viewCard : Card -> Html Msg
viewCard card =
    div []
        [ h1 [] [ text card.front ]
        , h2 [] [ text card.back ]
        ]


viewVocabList model =
    div [] (Array.toList (Array.map viewCard model))


view model =
    viewApp model


viewApp model =
    div []
        [ viewActiveCard model
        , button [ onClick CardKnown ] [ text "✅" ]
        , button [ onClick CardNotKnown ] [ text "❗️" ]
        , viewStats model
        ]


viewActiveCard model =
    viewCard (Maybe.withDefault (Card "" "card not found" "") (Array.get model.activeCard model.list))


viewStats : Model -> Html Msg
viewStats model =
    div []
        (Dict.values (Dict.map viewStat model.stats))


viewStat : Int -> Stat -> Html Msg
viewStat id stat =
    div []
        [ text "Known: "
        , text (toString stat.known)
        , text "Unknown: "
        , text (toString stat.unknown)
        ]
