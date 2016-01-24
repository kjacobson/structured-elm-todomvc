module Todo where

import Html exposing (..)
import Signal exposing (Signal, Address)
import Action.Main exposing (..)
import Action.Task exposing (..)
import Model.Main exposing (Model)
import View.Main exposing (view)
import Action.Main exposing (actions)
import Update.Main exposing (model)

main : Signal Html
main =
  Signal.map (view actions.address) (model getStorage)

port focus : Signal String
port focus =
    let needsFocus act =
            case act of
              ActionForTask id (Editing bool) -> bool
              _ -> False

        toSelector act =
            case act of
              ActionForTask id (Editing _) -> "#todo-" ++ toString id
              _ -> ""
    in
        actions.signal
          |> Signal.filter needsFocus (ActionForTask 0 (Editing True))
          |> Signal.map toSelector

port getStorage : Maybe Model

port setStorage : Signal Model
port setStorage = model getStorage
