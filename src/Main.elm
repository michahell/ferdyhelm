module Main exposing (..)

import Dict exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)

import String exposing (..)

import Json.Encode as Json


--import Html.Attributes exposing (..)
--import Html.Events exposing (onClick)


main : Program Never
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type Player
 = Red
 | Blue
 | Yellow
 | Green

type alias Grid =
  Dict (Int, Int) GridSquare

type alias GridSquare =
  { player : Maybe Player
  , finish : Maybe Player
  }

type alias Model =
  { currentPlayer : Player
  , grid : Grid
  }

initialModel : Model
initialModel =
    let initialGrid =
      Dict.fromList [ ( (0, 0), { player = Just Red, finish = Nothing } ) ]
    in
      { currentPlayer = Red, grid = initialGrid }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )



-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


-- view : Model -> Html Msg
-- view model =
--     div []
--         [ text "Hello, world!"
--         , text (toString model)
--         ]


view : Model -> Html Msg
view model =
  let gridSquare = (get (0, 0) model.grid)
  in case gridSquare of
    Just gs -> viewSquare gs
    Nothing -> div [] []


viewSquare : GridSquare -> Html Msg
viewSquare gridSquare =
  div [
    property "className" (Json.string (join " " [ "playerColor" ++ (playerToColor gridSquare.player), "borderColor" ++ (playerToColor gridSquare.player)]))
  ]
    (case gridSquare.player of
      Just player -> [ text (toString player) ]
      Nothing -> []
    )
    --case gridSquare.finish of

playerToColor : Maybe Player -> String
playerToColor maybePlayer =
  case maybePlayer of
    Just Red -> "Red"
    Just Blue -> "Blue"
    Just Yellow -> "Yellow"
    Just Green -> "Green"
    Nothing -> "Black"





















--
