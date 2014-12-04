import System.IO
import System.Exit
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.Spiral
import XMonad.Layout.ThreeColumns
import XMonad.Layout.SimpleFloat
import XMonad.Util.EZConfig(additionalKeys)

myLayout = avoidStruts (
        Tall 1 (3/100) (1/2) |||
        Mirror (Tall 1 (3/100) (1/2)) |||
        Full |||
        spiral (6/7)
    ) |||
    noBorders (fullscreenFull Full) |||
    simpleFloat

_mod = mod4Mask
toggleXMobarKey XConfig { XMonad.modMask = modMask } = (modMask, xK_b)
_config = defaultConfig {
    terminal = "/usr/bin/urxvt",
    modMask = _mod,
    normalBorderColor  = "#333333",
    focusedBorderColor = "#5882FA",
    layoutHook = smartBorders $ myLayout
} `additionalKeys`
  [ ((_mod, xK_o), spawn "chromium")
  , ((_mod .|. shiftMask, xK_apostrophe), kill)]

main = do
  config <- statusBar "xmobar ~/.xmonad/xmobar.hs" xmobarPP toggleXMobarKey _config
  xmonad config
