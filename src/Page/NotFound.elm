module Page.NotFound exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Page.PageContent as PC exposing (..)


notFoundPage : PC.Page msg
notFoundPage =
    { title = "Not Found"
    , content = [ p [] [ text "Sorry, can not find the page." ] ]
    }
