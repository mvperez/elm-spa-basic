module Page.About exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Page.PageContent as PC exposing (..)


aboutPage : PC.Page msg
aboutPage =
    { title = "About"
    , content = [ p [] [ text "About Page" ] ]
    }
