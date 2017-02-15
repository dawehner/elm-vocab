module App.View exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Array exposing (Array)
import Dict exposing (Dict)
import App.Types exposing (..)
import App.Model exposing (Model, Msg, Msg(..))


viewCard : Card -> Html Msg
viewCard card =
    div []
        [ h1 [] [ text card.front ]
        , h2 [] [ text card.back ]
        ]


viewCardList model =
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
    if model.activeCard == -1 then
        (h1 [] [ text "no cards loaded yet" ])
    else
        viewCard (Maybe.withDefault (Card "" "card not found" "") (Array.get model.activeCard model.list))


viewStats : Model -> Html Msg
viewStats model =
    let
        viewSingleStat =
            viewStat model.list
    in
        div []
            [ h2 [] [ text "Stats" ]
            , table []
                [ thead []
                    [ tr []
                        [ th [] [ text "Card" ]
                        , th [] [ text "Known" ]
                        , th [] [ text "Unknown" ]
                        ]
                    ]
                , (tbody []
                    (Dict.values (Dict.map (viewStat model.list) model.stats))
                  )
                ]
            ]


viewStat cards id stat =
    case (Array.get id cards) of
        Nothing ->
            tr [] [ Html.text "Card not found" ]

        Just card ->
            (tr []
                [ td [] [ text card.front ]
                , td [] [ text (toString stat.known) ]
                , td [] [ text (toString stat.unknown) ]
                ]
            )
