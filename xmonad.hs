import XMonad
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.Spiral
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Util.Run(spawnPipe)
import System.IO
import System.Exit

main = do
  xmproc <- spawnPipe "xmobar $HOME/.xmobarrc"
  xmonad $ defaultConfig
    { borderWidth = 3
    , normalBorderColor = curNormalBorderColor
    , focusedBorderColor = curFocusBorderColor
    , modMask = mod4Mask -- win_key
    , layoutHook = curLayout  --see curLayout
    , workspaces = curWorkspaces
    , terminal = curTerminal
    , logHook = dynamicLogWithPP $ xmobarPP {
          ppOutput =hPutStrLn xmproc
        , ppTitle = xmobarColor xmobarTitleColor "" . shorten 100
        , ppCurrent = xmobarColor xmobarCurrentWorkspaceColor ""
        , ppSep = " "
        }
    }

--BorderWidth definition
curBW = "3"

--Normal Border Colour definition
curNormalBorderColor = "#575454"

--Focusing Border Colour definition
curFocusBorderColor = "#4b088a"

--Layout definition
curLayout = avoidStruts (
  ThreeColMid 1 (3/100) (1/2) |||
  Tall 1 (3/100) (1/2) |||
  Mirror (Tall 1 (3/100) (1/2)))

--Workspaces definition
curWorkspaces = ["1:main","2:reading","3:monitoring","4:ssh","5","6","7","8","9"]

--terminal definition
curTerminal = "urxvt"

--Transparency
curTransp :: X ()
curTransp = fadeInactiveLogHook fadeAmount
  where fadeAmount = 0.7

--xmobar color codes
xmobarTitleColor = "#00FF00"
xmobarCurrentWorkspaceColor = "#FF0040"
