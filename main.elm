module Main exposing (..)

import Debug
import Html exposing (Html)
import Html.Events exposing (onClick)
import Task
import Array exposing (Array)
import Dict exposing (Dict)     
import Random

-- Model

type alias Card =
    {
      category : String
    , front : String
    , back : String
    }


type alias VocabList = Array Card

type alias Model = {
    activeCard: Int
   , list: VocabList
   , stats: Stats
  }

type alias Stats = Dict Int Stat

type alias Stat = {
   known: Int
  , unknown: Int
}

init : ( Model, Cmd Msg )
init = update ChooseRandomCard initStatic
initStatic =
  Model 0
    ( Array.fromList [ (Card "relationship" "to break up" "to end a romantic relationship")
      , (Card "relationship" "to drift apart" "to become less close to someone")
      , (Card "relationship" "to break up" "to end a romantic relationship")
      , (Card "relationship" "to drift apart" "to become less close to someone")
      , (Card "relationship" "to enjoy someone’s company" "to like spending time with someone")
      , (Card "relationship" "to fall for" "to fall in love")
      , (Card "relationship" "to fall head over heels in love" "to start to love someone a lot")
      , (Card "relationship" "to fall out with" "to have a disagreement and stop being friends")
      , (Card "relationship" "to get on like a house on fire" "to like someone’s company very much indeed")
      , (Card "relationship" "to get on well with" "to understand someone and enjoy similar interests")
      , (Card "relationship" "to get to know" "to begin to know someone")
      , (Card "relationship" "to go back years" "to have known someone for a long time")
      , (Card "relationship" "to have a lot in common" "to share similar interests")
      , (Card "relationship" "to have ups and downs" "to have good and bad times")
      , (Card "relationship" "a healthy relationship" "a good, positive relationship")
      , (Card "relationship" "to hit it off" "to quickly become good friends with")
      , (Card "relationship" "to be in a relationship" "to be romantically involved with someone")
      , (Card "relationship" "to be just good friends" "to not be romantically involved")
      , (Card "relationship" "to keep in touch with" "to keep in contact with")
      , (Card "relationship" "to lose touch with" "to not see or hear from someone any longer")
      , (Card "relationship" "love at first sight" "to fall in love immediately you meet someone")
      , (Card "relationship" "to pop the question" "to ask someone to marry you")
      , (Card "relationship" "to see eye to eye" "to agree on a subject")
      , (Card "relationship" "to settle down" "to give up the single life and start a family")
      , (Card "relationship" "to strike up a relationship" " to begin a friendship")
      , (Card "relationship" "to tie the knot" "to get married")
      , (Card "relationship" "to be well matched" "to be similar to")
      , (Card "relationship" "to work at a relationship" "to try to maintain a positive relationship with someone")
      ]
    ) (Dict.empty)



-- Update


type Msg
    = CardKnown | CardNotKnown | ChooseRandomCard | SetCard Int

updateStats : Int -> Bool -> Stats -> Stats
updateStats id known stats =
  let
      id2 = Debug.log "id" id
      oldStats = Debug.log "stats" stats

      oldStat =
        Maybe.withDefault (Stat 0 0) (Dict.get id stats)

      newStat =
        Debug.log "newStat" (case known of
          True -> {oldStat | known = oldStat.known + 1}
          False -> {oldStat | unknown = oldStat.unknown + 1})

  in (Debug.log "updateStats" (Dict.insert id newStat stats))

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    CardKnown -> (update ChooseRandomCard { model | stats = updateStats model.activeCard True model.stats})
    CardNotKnown -> (update ChooseRandomCard { model | stats = updateStats model.activeCard False model.stats})
    ChooseRandomCard -> (model, Random.generate SetCard (Random.int 0 (Array.length model.list)))
    SetCard id -> ({ model | activeCard = id}, Cmd.none)


-- Subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


-- View

viewCard : Card -> Html Msg
viewCard card =
    Html.div []
        [ Html.h1 [] [ Html.text card.front ]
        , Html.h2 [] [ Html.text card.back ]
        ]


viewVocabList model =
    Html.div [] (Array.toList (Array.map viewCard model))

view model = viewApp model

viewApp model = Html.div [] [
  viewActiveCard model,
  Html.button [ onClick CardKnown ] [ Html.text "✅" ],
  Html.button [ onClick CardNotKnown ] [ Html.text "❗️" ],
  viewStats model
  ]

viewActiveCard model
  = viewCard (Maybe.withDefault (Card "" "card not found" "") (Array.get model.activeCard model.list))

viewStats : Model -> Html Msg
viewStats model
  = Html.div [] 
  (Dict.values (Dict.map viewStat model.stats))

viewStat : Int -> Stat -> Html Msg
viewStat id stat = Html.div [] [
  Html.text "Known: ", Html.text (toString stat.known)
  , Html.text "Unknown: ", Html.text (toString stat.unknown)
  ]


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
