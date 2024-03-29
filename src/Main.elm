module Main exposing (Model, Msg(..), init, main, subscriptions, update, view, viewLink)

import Browser
import Browser.Navigation as Nav
import Debug exposing (log)
import Html exposing (..)
import Html.Attributes exposing (..)
import Page.About as About
import Page.Home as Home
import Page.NotFound as NotFound
import Page.PageContent exposing (..)
import Url
import Url.Parser as UP exposing ((</>), Parser, int, map, oneOf, parse, s, string)



-- MAIN


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = UrlChanged
        , onUrlRequest = UrlRequested
        }



-- MODEL


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    , route : Route
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    ( { key = key, url = url, route = urlToRoute url }, Cmd.none )


type Route
    = Home
    | About
    | NotFound


routeParser : UP.Parser (Route -> a) a
routeParser =
    UP.oneOf
        [ UP.map Home UP.top
        , UP.map About (UP.s "about")
        ]


urlToRoute : Url.Url -> Route
urlToRoute url =
    url
        |> UP.parse routeParser
        |> Maybe.withDefault NotFound



-- UPDATE


type Msg
    = UrlRequested Browser.UrlRequest
    | UrlChanged Url.Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlRequested urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            ( { model | url = url, route = urlToRoute url }
            , Cmd.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


type alias Page msg =
    { title : String
    , content : List (Html msg)
    }


view : Model -> Browser.Document Msg
view model =
    let
        page =
            case model.route of
                Home ->
                    Home.homePage

                About ->
                    About.aboutPage

                NotFound ->
                    NotFound.notFoundPage
    in
    { title = "Simple SPA"
    , body =
        [ text "The current URL is: "
        , b [] [ text (Url.toString model.url) ]
        , ul []
            [ viewLink "/" "home"
            , viewLink "/about" "about"
            ]
        ]
            ++ page.content
    }


viewLink : String -> String -> Html msg
viewLink path pathText =
    li [] [ a [ href path ] [ text pathText ] ]
