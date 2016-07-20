module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.App as App
import String


-- model


type alias Model =
    { counter : Int
    , input : Int
    , error : Maybe String
    }


initModel : Model
initModel =
    -- Model 0 0 Nothing
    { counter = 0
    , input = 0
    , error = Nothing
    }



-- update


type Msg
    = AddCalorie
    | RemoveCalorie
    | Clear
    | Input String


update : Msg -> Model -> Model
update msg model =
    case msg of
        AddCalorie ->
            { model
                | counter = model.counter + model.input
                , input = 0
            }

        RemoveCalorie ->
            { model
                | counter = model.counter - model.input
                , input = 0
            }

        Clear ->
            initModel

        Input val ->
            case String.toInt val of
                Ok input ->
                    { model
                        | input = input
                        , error = Nothing
                    }

                Err err ->
                    { model
                        | input = 0
                        , error = Just err
                    }



-- view


view : Model -> Html Msg
view model =
    div []
        [ h3 []
            [ text (("Total ") ++ (toString model.counter)) ]
        , input
            [ type' "text"
            , onInput Input
            , value
                (if model.input == 0 then
                    ""
                 else
                    toString model.input
                )
            ]
            []
        , div [] [ text (Maybe.withDefault "" model.error) ]
        , button
            [ type' "button"
            , onClick AddCalorie
            ]
            [ text "Add" ]
        , button
            [ type' "button"
            , onClick RemoveCalorie
            ]
            [ text "Remove" ]
        , button
            [ type' "button"
            , onClick Clear
            ]
            [ text "Clear" ]
        , p [] [ text (toString model) ]
        ]


main : Program Never
main =
    App.beginnerProgram
        { model = initModel
        , view = view
        , update = update
        }
