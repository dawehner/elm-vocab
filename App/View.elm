module App.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Array exposing (Array)
import Dict exposing (Dict)
import App.Types exposing (..)
import App.Model exposing (Model, Msg, Msg(..))
import App.PageType exposing (..)
import RemoteData exposing (..)


viewCard : Card -> Html Msg
viewCard card =
    div []
        [ h1 [] [ text card.front ]
        , h2 [ class "blur" ] [ text card.back ]
        ]


viewCardList model =
    div [] (Array.toList (Array.map viewCard model))


view model =
    div []
        [ viewNavigation
        , (case model.activePage of
            MainPage ->
                viewApp model

            Stats ->
                viewStats model
          )
        ]


viewApp model =
    div []
        [ viewActiveCard model
        , button [ onClick CardKnown ] [ text "✅" ]
        , button [ onClick CardNotKnown ] [ text "❗️" ]
        ]


viewNavigation =
    ul []
        [ li [] [ a [ onClick <| SetActivePage MainPage ] [ text "Train" ] ]
        , li [] [ a [ onClick <| SetActivePage Stats ] [ text "Stats" ] ]
        ]


viewActiveCard model =
  case model.list of 
    NotAsked -> text "Not asked yet"
    Loading -> text "Loading"
    Failure err -> text ("Error: " ++ toString err)
    Success cards ->
        case model.activeCard of
          Just activeCard -> viewCard (Maybe.withDefault (Card "" "card not found" "") (Array.get activeCard cards))
          Nothing -> text "no active card"


viewStats : Model -> Html Msg
viewStats model =
    case model.list of
      NotAsked -> text "Initialising"
      Loading -> text "Loading"
      Failure err -> text ("Error: " ++ toString err)
      Success cards ->
          let
              viewSingleStat = viewStat cards
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
                          (Dict.values (Dict.map (viewStat cards) model.stats))
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
