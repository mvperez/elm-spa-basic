module Page.Home exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Page.PageContent as PC exposing (..)


homePage : PC.Page msg
homePage =
    { title = "Home"
    , content = [ p [] [ text "Home Page" ] ]
    }