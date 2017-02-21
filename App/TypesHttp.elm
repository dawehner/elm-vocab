module App.TypesHttp exposing (cardDecoder, cardListDecoder)

import App.Types exposing (..)
import Http
import Json.Decode exposing (..)


cardDecoder : Decoder Card
cardDecoder =
    map3 Card
        (field "category" string)
        (field "front" string)
        (field "back" string)


cardListDecoder =
    (list cardDecoder)
