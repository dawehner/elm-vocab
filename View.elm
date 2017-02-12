module View exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Array exposing (Array)
import Dict exposing (Dict)
import Table
import Types exposing (..)
import Update exposing (Msg, Msg(..))


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
    table []
        [ thead []
            [ tr []
                [ th [] [ text "ID" ]
                , th [] [ text "Known" ]
                , th [] [ text "Unknown" ]
                ]
            ]
        , (tbody []
            (Dict.values (Dict.map viewStat model.stats))
          )
        ]


viewStat : Int -> Stat -> Html Msg
viewStat id stat =
    tr []
        [ td [] [ text (toString (id + 1)) ]
        , td [] [ text (toString stat.known) ]
        , td [] [ text (toString stat.unknown) ]
        ]
