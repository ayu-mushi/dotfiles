--
-- xmonad example config file.
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--

import XMonad
import Data.Monoid
import System.Exit
import System.Cmd(system)

import System.IO
import Control.Concurrent (forkIO, MVar, readMVar, newMVar, modifyMVar, modifyMVar_, putMVar, threadDelay)
import XMonad.Hooks.DynamicLog hiding (def)
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops (ewmh, ewmhDesktopsStartup, ewmhDesktopsLogHook, ewmhDesktopsEventHook)
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.Cursor (xC_pirate, setDefaultCursor, xC_arrow)
import XMonad.Config.Xfce (xfceConfig)
import XMonad.Config.Gnome (gnomeConfig)
import qualified XMonad.StackSet as W
import XMonad.Actions.SpawnOn (spawnOn)
--import ViewDoc (toggleSaveState, launchDocuments, colorSaved)

import Control.Monad (void, when)
import qualified Data.Map        as M

import XMonad.Util.EZConfig (additionalKeysP, additionalKeys)
import Graphics.X11.ExtraTypes.XF86 (xF86XK_AudioMute, xF86XK_MonBrightnessDown, xF86XK_MonBrightnessUp)


import XMonad.Hooks.UrgencyHook (UrgencyHook(urgencyHook), withUrgencyHook)
import XMonad.Util.NamedWindows
import XMonad.Util.Run


-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "urxvt"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
--
myBorderWidth   = 1

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod4Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
myWorkspaces = ["w3m", "browser", "code", "doc", "music" ] ++ map show [6..8] ++ ["trash"]
--
--myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#dddddd"
myFocusedBorderColor = "#ff0000"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys isInConc conf@(XConfig {XMonad.modMask = modm}) = M.fromList $ let windows_frzabl = myWindows isInConc in

    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
    , ((0, xF86XK_MonBrightnessUp), spawn "light -A 1") -- #define XF86XK_MonBrightnessUp   0x1008FF02  /* Monitor/panel brightness */ -- https://github.com/haikarainen/light
    , ((0, xF86XK_MonBrightnessDown), spawn "light -U 1") -- #define XF86XK_MonBrightnessDown 0x1008FF03  /* Monitor/panel brightness */
    , ((0, xF86XK_AudioMute), spawn "amixer -q -D pulse sset Master toggle") -- #define XF86XK_AudioMute	0x1008FF12   /* Mute sound from the system */
    , ((modm, xK_Print), spawn "gnome-screenshot --area") -- xK_Print does not work.
    --, ((modm, 0xFF61), spawn "gnome-screenshot --area")
    , ((modm, xK_d), spawn "emacs")
    , ((modm, xK_e), spawn "emacs")
    --, ((modm, xK_s), toggleSaveState)
    , ((modm, xK_s), io $ do
        i <- readMVar isInConc
        when (not i) $ do
          modifyMVar_ isInConc $ \x -> return True
          forkIO $ do threadDelay (60 * 10^6)
                      modifyMVar_ isInConc $ \x -> return False
          return ()
      )
    --, ((modm .|. shiftMask, xK_s), launchDocuments)
    , ((modm, xK_f), spawn "x-www-browser")
    , ((modm, xK_a), spawn "krita")
    , ((modm, xK_v), spawn "gvim")
    , ((modm .|. shiftMask, xK_a), spawn "atom")
    -- logout
    , ((modm .|. shiftMask, xK_q), spawn "gnome-session-save --logout-dialog -gui")
    -- change window manager from XMonad to xfw4
    , ((modm .|. controlMask, xK_q), (io $ forkIO $ void $ system ("sleep 2s && xfwm4 &")) >> (io $ exitWith ExitSuccess))
    , ((modm .|. shiftMask, xK_m), spawn "mendeleydesktop")
    -- launch dmenu
    , ((modm,               xK_p     ), spawn "dmenu_run")

    -- launch gmrun
    , ((modm .|. shiftMask, xK_p     ), spawn "gmrun")

    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)
    , ((modm .|. shiftMask, xK_t), spawn "nautilus ~") -- or Thunar

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    , ((modm              , xK_b     ), sendMessage ToggleStruts)


    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")

    -- Run xmessage with a summary of the default keybindings (useful for beginners)
    , ((modm .|. shiftMask, xK_slash ), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows_frzabl $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++
    -- shiftの場合はfrzableじゃなくていいんだけど…

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows_frzabl . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> {-focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster-} return ()))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    -- DISABLED: because it is annoying to me...
    {-, ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))-}

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = tiled ||| Mirror tiled ||| Full
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    --, className =? "Gimp"           --> doFloat
    , (role =? "gimp-toolbox" <||> role =? "gimp-image-window") --> (ask >>= doF . W.sink)
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
    , resource  =? "stalonetray"       --> doIgnore
    ]
  where role = stringProperty "WM_WINDOW_ROLE"

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
--myEventHook = mempty

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
--myLogHook = return ()

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook :: X ()
myStartupHook = do
  setDefaultCursor xC_arrow -- デフォルトのカーソルを普通の矢印にする
  return ()

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main = do
  myStatusBar <- spawnPipe "xmobar"
  isInConc <- newMVar False
  xmonad $
    withUrgencyHook LibNotifyUrgencyHook $
      defaults isInConc $
        dynamicLogWithPP $
          xmobarPP { ppOutput = hPutStrLn myStatusBar}

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--

-- def = defaultConfig
defaults isInConc mLH = gnomeConfig {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys isInConc,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = avoidStruts myLayout,
        manageHook         = myManageHook,
        --handleEventHook    = ewmhDesktopsEventHook,
        logHook            = mLH, -- >> colorSaved,
        startupHook        = myStartupHook -- >> ewmhDesktopsStartup
    }
    `additionalKeysP`
    [
    -- screen shot.
    ("<PrtSc>", spawn "gnome-screenshot --area")
    , ("<Pause>", spawn "gnome-screenshot --area")
    -- adjust backlight
    --, ("<F6>", spawn "light -U 1") -- https://github.com/haikarainen/light
    --, ("<F7>", spawn "light -A 1")
    --, ("<F1>", spawn "amixer -q -D pulse sset Master toggle")
    ]

-- | Finally, a copy of the default bindings in simple textual tabular format.
help :: String
help = unlines ["The default modifier key is 'alt'. Default keybindings:",
    "",
    "-- launching and killing programs",
    "mod-Shift-Enter  Launch xterminal",
    "mod-p            Launch dmenu",
    "mod-Shift-p      Launch gmrun",
    "mod-Shift-c      Close/kill the focused window",
    "mod-Space        Rotate through the available layout algorithms",
    "mod-Shift-Space  Reset the layouts on the current workSpace to default",
    "mod-n            Resize/refresh viewed windows to the correct size",
    "",
    "-- move focus up or down the window stack",
    "mod-Tab        Move focus to the next window",
    "mod-Shift-Tab  Move focus to the previous window",
    "mod-j          Move focus to the next window",
    "mod-k          Move focus to the previous window",
    "mod-m          Move focus to the master window",
    "",
    "-- modifying the window order",
    "mod-Return   Swap the focused window and the master window",
    "mod-Shift-j  Swap the focused window with the next window",
    "mod-Shift-k  Swap the focused window with the previous window",
    "",
    "-- resizing the master/slave ratio",
    "mod-h  Shrink the master area",
    "mod-l  Expand the master area",
    "",
    "-- floating layer support",
    "mod-t  Push window back into tiling; unfloat and re-tile it",
    "",
    "-- increase or decrease number of windows in the master area",
    "mod-comma  (mod-,)   Increment the number of windows in the master area",
    "mod-period (mod-.)   Deincrement the number of windows in the master area",
    "",
    "-- quit, or restart",
    "mod-Shift-q  Quit xmonad",
    "mod-q        Restart xmonad",
    "mod-[1..9]   Switch to workSpace N",
    "",
    "-- Workspaces & screens",
    "mod-Shift-[1..9]   Move client to workspace N",
    "mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3",
    "mod-Shift-{w,e,r}  Move client to screen 1, 2, or 3",
    "",
    "-- Mouse bindings: default actions bound to mouse events",
    "mod-button1  Set the window to floating mode and move by dragging",
    "mod-button2  Raise the window to the top of the stack",
    "mod-button3  Set the window to floating mode and resize by dragging"]

-- bindable version of `windows`
-- MVar
myWindows :: MVar Bool -> (WindowSet -> WindowSet) -> X ()
myWindows v f = do
  isInConc <- io $ readMVar v
  when (not isInConc) $ windows f


data LibNotifyUrgencyHook = LibNotifyUrgencyHook deriving (Read, Show)

instance UrgencyHook LibNotifyUrgencyHook where
  urgencyHook LibNotifyUrgencyHook w = do
    name <- getName w
    Just idx <- fmap (W.findTag w) $ gets windowset

    safeSpawn "notify-send" [show name, "workspace " ++ idx]
