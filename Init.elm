module Init exposing (init)

import Array exposing (Array)
import Dict exposing (Dict)

import Types exposing (..)
import Update exposing (update)
import Update exposing (update, Msg(..))

init : ( Model, Cmd Msg )
init =
    update ChooseRandomCard initStatic


initStatic =
    Model 0
        (Array.fromList
            [ (Card "relationship" "to break up" "to end a romantic relationship")
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
        )
        (Dict.empty)
