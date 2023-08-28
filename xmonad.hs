import qualified Data.Map                     as M
import           Graphics.X11.ExtraTypes.XF86
import           XMonad
import           XMonad.Actions.SpawnOn
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.ManageDocks
import           XMonad.Layout.NoBorders
import           XMonad.Layout.Spacing
import           XMonad.Layout.ToggleLayouts
import qualified XMonad.StackSet              as W
import           XMonad.Util.Run
import           XMonad.Util.SpawnOnce

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((modm, xK_Return), spawn $ XMonad.terminal conf)
    , ((modm, xK_space), sendMessage NextLayout)
    , ((modm, xK_f), sendMessage (Toggle "Full"))
    , ((modm, xK_p), spawn "dmenu_run -fn 'FiraCode Nerd Font-11'")
    , ((modm, xK_r), spawn "xmonad --recompile; xmonad --restart")
    , ((modm, xK_q), kill)
    , ((modm, xK_j), windows W.focusDown)
    , ((modm, xK_k), windows W.focusUp)
    , ((modm, xK_m), windows W.focusMaster)
    , ((modm, xK_h), sendMessage Shrink)
    , ((modm, xK_l), sendMessage Expand)
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )
    , ((modm .|. shiftMask,               xK_m), windows W.swapMaster)
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)
    , ((0, xF86XK_AudioMute), spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
    , ((0, xF86XK_AudioLowerVolume), spawn "pactl set-sink-volume @DEFAULT_SINK@ -10%")
    , ((0, xF86XK_AudioRaiseVolume), spawn "pactl set-sink-volume @DEFAULT_SINK@ +10%")
    , ((0, xF86XK_MonBrightnessUp), spawn "lux -a 10%")
    , ((0, xF86XK_MonBrightnessDown), spawn "lux -s 10%")
    , ((mod1Mask, xK_Shift_L), spawn "togglelayout")
    -- , ((mod1Mask, xK_Shift_L), spawn "setxkbmap us")
    -- , ((xK_Shift_L, mod1Mask), spawn "setxkbmap bg phonetic")
    ]
    ++

    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
    ++
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_e, xK_w] [0..]
        , let shiftAndView i = W.view i . W.shift i
        , (f, m) <- [(W.view, 0), (shiftAndView, shiftMask)]]

myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster)),
     ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

myLayoutHook = avoidStruts $ spacing 1 (tiled ||| Full)
  where
    tiled = Tall nmaster delta ratio
    nmaster = 1
    ratio = 1 / 2
    delta = 1 / 100

main :: IO ()
main = do
  -- h <- spawnPipe "xmobar ~/.config/xmobar/xmobar.hs"
  xmonad $ docks def {
    modMask = mod4Mask,
    terminal = "kitty",
    clickJustFocuses = True,
    focusFollowsMouse = False,
    workspaces         = ["main"],
    borderWidth        = 2,
    normalBorderColor  = "#e6e1cf",
    focusedBorderColor = "#f19618",
    keys               = myKeys,
    mouseBindings      = myMouseBindings,
    layoutHook         = myLayoutHook,
    -- manageHook         = manageSpawn <+> myManageHook,
    -- handleEventHook    = myEventHook,
    -- logHook            = dynamicLogWithPP $ xmobarPP {
    --     ppOutput = hPutStrLn h,
    --     ppCurrent = \(ws) -> "<box type=Bottom mb=6 width=2>" ++ ws ++ "</box>",
    --     ppHiddenNoWindows = \(ws) -> ws,
    --     ppHidden = \(ws) -> ws,
    --     ppVisible =  \(ws) -> ws,
    --     ppTitle = \(t) -> t,
    --     ppSep = " ",
    --     ppOrder = \(ws:_:t) -> [ws] ++ t
    -- },
    startupHook = do
                        spawnOnce "picom &"
                        spawnOnce "xset s off &"
                        spawnOnce "xset s 0 0 &"
                        spawnOnce "xset -dpms &"
                        spawnOnce "setxkbmap -option ctrl:nocaps &"
                        spawnOnce "xsetroot -cursor_name left_ptr &"
                        spawnOnce "hsetroot -solid black &"
                        spawnOnce "xrandr --output DP-4 --mode 2560x1440 --rate 144"
                        spawnOnce "xrandr --output HDMI-0 --mode 2560x1440 --rate 144"
    }
