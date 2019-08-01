module Page.PageContent exposing (..)

import Html exposing (..)

type alias Page msg =
    { title : String
    , content : List (Html msg)
    }
