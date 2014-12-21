# Author::  Christoph Kappel <unexist@dorfelite.net>
# Version:: $Id: data/subtle.rb,v 2978 2011/08/02 11:16:25 unexist $
# License:: GNU GPLv2
#
# = Subtle default configuration
#
# This file will be installed as default and can also be used as a starter for
# an own custom configuration file. The system wide config usually resides in
# +/etc/xdg/subtle+ and the user config in +HOME/.config/subtle+, both locations
# are dependent on the locations specified by +XDG_CONFIG_DIRS+ and
# +XDG_CONFIG_HOME+.
#

#
# == Options
#
# Following options change behaviour and sizes of the window manager:
#


#begin
#  require "#{ENV["HOME"]}/.dotfiles/configs/subtle/launcher.rb"
# Set fonts
#   Subtle::Contrib::Launcher.fonts = [
#                                      "xft:ohsnap:size=10"
#"-*-*-bold-*-*-*-14-*-*-*-*-*-*-*",
#"xft:Pragmata:pixelsize=9:antialias=true",
#                                     ]
#rescue LoadError => error
#  puts error
#end

# Window move/resize steps in pixel per keypress
set :step, 5

# Window screen border snapping
set :snap, 10

# Default starting gravity for windows. Comment out to use gravity of
# currently active client
set :gravity, :center

# Make transient windows urgent
set :urgent, true

# Honor resize size hints globally
set :resize, false

# Enable gravity tiling
set :tiling, false

# Font string either take from e.g. xfontsel or use xft
#set :font, "-*-*-medium-*-*-*-14-*-*-*-*-*-*-*"
#set :font, "xft:Cantarell-11"

# Separator between sublets
#set :separator, "  "

# Set the WM_NAME of subtle (Java quirk)
set :wmname, "LG3D"

#
# == Screen
#
# Generally subtle comes with two panels per screen, one on the top and one at
# the bottom. Each panel can be configured with different panel items and
# sublets screen wise. The default config uses top panel on the first screen
# only, it's up to the user to enable the bottom panel or disable either one
# or both.

# === Properties
#
# [*stipple*]    This property adds a stipple pattern to both screen panels.
#
#                Example: stipple "/stipple.xbm"
#                         stipple Subtlext::Icon.new("/stipple.xbm")
#
# [*top*]        This property adds a top panel to the screen.
#
#                Example: top [ :views, :title ]
#
# [*bottom*]     This property adds a bottom panel to the screen.
#
#                Example: bottom [ :views, :title ]

#
# Following items are available for the panels:
#
# [*:views*]     List of views with buttons
# [*:title*]     Title of the current active window
# [*:tray*]      Systray icons (Can be used only once)
# [*:keychain*]  Display current chain (Can be used only once)
# [*:sublets*]   Catch-all for installed sublets
# [*:sublet*]    Name of a sublet for direct placement
# [*:spacer*]    Variable spacer (free width / count of spacers)
# [*:center*]    Enclose items with :center to center them on the panel
# [*:separator*] Insert separator
#
# Empty panels are hidden.
#
# === Links
#
# http://subforge.org/projects/subtle/wiki/Multihead
# http://subforge.org/projects/subtle/wiki/Panel
#

screen 1 do
  top    [ :views,:separator,:title, :spacer,:tray,:sublets]
  #bottom [ :spacer, :tray]
end

# Example for a second screen:
#screen 2 do
#  top    [ :views, :title, :spacer ]
#  bottom [ ]
#end

#
# == Styles
#
# Styles define various properties of styleable items in a CSS-like syntax.
#
# If no background color is given no color will be set. This will ensure a
# custom background pixmap won't be overwritten.
#
# === Link
#
# http://subforge.org/projects/subtle/wiki/Styles

 # Style for all style elements
blue1  = "#1243e3"
blue2  = "#1d284f"

gray1  = "#b8b8b8"
gray2  = "#8f8f8f"
gray3  = "#202020"

black1 = "#101010"

red1   = "#880000"
red2   = "#cc0000"

style :all do
  background  black1
  #font "-*-*-medium-*-*-*-14-*-*-*-*-*-*-*"
  font "xft:ohsnap:size=10"
  padding     0, 5
end

# Style for the views
style :views do
  # Style for the active views
  padding     0, 5,0,5
  font "xft:ohsnap:size=10"
  style :focus do
    foreground blue1
    background gray3
    border_bottom blue2,3
  end

  # Style for urgent window titles and views
  style :urgent do
    padding -1,5,0,5
    border_bottom  red1,3
    background gray3
    foreground red2
  end

  # Style for occupied views (views with clients)
  style :occupied do
    foreground  gray1
  end

  # Style for unoccupied views (views without clients)
  style :unoccupied do
    foreground  gray2
  end
end

# Style for sublets
style :sublets do
  foreground  gray2
end

# Style for separator
style :separator do
  foreground  blue2
  padding     0, 10, 0, 10
  separator ">>"
  font "-*-*-bold-*-*-*-14-*-*-*-*-*-*-*"
end

# Style for focus window title
style :title do
  padding     0, 5, 0, 5
  foreground  gray2
end

# Style for active/inactive windows
style :clients do
  margin      6, 0, 0, 6
  active      blue2,2
  inactive    gray3,2
  width       50
end

# Style for subtle 
style :subtle do
  margin      0, 0, 0, 0
  panel       black1
  background  gray3
  stipple     gray2
end

#
# == Gravities
#
# Gravities are predefined sizes a window can be set to. There are several ways
# to set a certain gravity, most convenient is to define a gravity via a tag or
# change them during runtime via grab. Subtler and subtlext can also modify
# gravities.
#
# A gravity consists of four values which are a percentage value of the screen
# size. The first two values are x and y starting at the center of the screen
# and he last two values are the width and height.
#
# === Example
#
# Following defines a gravity for a window with 100% width and height:
#
#   gravity :example, [ 0, 0, 100, 100 ]
#
# === Link
#
# http://subforge.org/projects/subtle/wiki/Gravity
#

# Top left
gravity :top_left,       [  0,  0, 50, 50]
gravity :top_left66,     [  0,  0, 50, 66]
gravity :top_left33,     [  0,  0, 50, 34]

# Top
gravity :top,            [  0,  0,100, 50]
gravity :top66,          [  0,  0,100, 66]
gravity :top33,          [  0,  0,100, 33]

# Top right
gravity :top_right,      [ 50,  0, 50, 50]
gravity :top_right66,    [ 50,  0, 50, 66]
gravity :top_right33,    [ 50,  0, 50, 33]

# Left
gravity :left,           [  0,  0, 50,100]
gravity :left66,         [  0,  0, 66,100]
gravity :left33,         [  0,  0, 33,100]

# Center
gravity :center,         [  0,  0,100,100]
gravity :center66,       [ 17, 17, 66, 66]
gravity :center33,       [ 33, 33, 33, 33]

# Right
gravity :right,          [ 50,  0, 50,100]
gravity :right66,        [ 33,  0, 67,100]
gravity :right33,        [ 66, 50, 34,100]

# Bottom left
gravity :bottom_left,    [  0, 50, 50, 50]
gravity :bottom_left66,  [  0, 33, 50, 66]
gravity :bottom_left33,  [  0, 66, 50, 33]

# Bottom
gravity :bottom,         [  0, 50,100, 50]
gravity :bottom66,       [  0, 34,100, 66]
gravity :bottom33,       [  0, 67,100, 33]

# Bottom right
gravity :bottom_right,   [ 50, 50, 50, 50]
gravity :bottom_right66, [ 50, 33, 50, 67]
gravity :bottom_right33, [ 50, 66, 50, 34]

# Pidgin
gravity :pidgin_main,    [ 80, 50, 20,100]
gravity :pidgin_conv,    [  0,  0, 80,100] #[ 15,  0, 65,100]
gravity :mail_main,      [  0,  0, 80,100]

#Sylpheed
gravity :sylpheed_main,  [ 15,  0, 65,100]
gravity :sylpheed_fold,  [  0,  0, 15,100]

# Gimp
gravity :gimp_image,     [ 10,  0, 80,100]
gravity :gimp_toolbox,   [  0,  0, 10,100]
gravity :gimp_dock,      [ 90,  0, 10,100]

#mocp
gravity :mocp,           [ 10, 18, 80, 55]
gravity :ncmpcpp,        [ 15, 18, 70, 55]

#pidgin small convo
gravity :pidgin_small,   [ 80, 50, 20, 50]
gravity :video_small,    [ 68,  0, 32, 33]
gravity :video_small2,   [ 80,  0, 20, 21]

#pidgin small convo
gravity :bashrun,        [  0,  0, 20,  2]

#
# == Grabs
#
# Grabs are keyboard and mouse actions within subtle, every grab can be
# assigned either to a key and/or to a mouse button combination. A grab
# consists of a chain and an action.
#
# === Finding keys
#
# The best resource for getting the correct key names is
# */usr/include/X11/keysymdef.h*, but to make life easier here are some hints
# about it:
#
# * Numbers and letters keep their names, so *a* is *a* and *0* is *0*
# * Keypad keys need *KP_* as prefix, so *KP_1* is *1* on the keypad
# * Strip the *XK_* from the key names if looked up in
#   /usr/include/X11/keysymdef.h
# * Keys usually have meaningful english names
# * Modifier keys have special meaning (Alt (A), Control (C), Meta (M),
#   Shift (S), Super (W))
#
# === Chaining
#
# Chains are a combination of keys and modifiers to one or a list of keys
# and can be used in various ways to trigger an action. In subtle, there are
# two ways to define chains for grabs:
#
#   1. *Default*: Add modifiers to a key and use it for a grab
#
#      *Example*: grab "W-Return", "urxvt"
#
#   2. *Chain*: Define a list of grabs that need to be pressed in order
#
#      *Example*: grab "C-y Return", "urxvt"
#
# ==== Mouse buttons
#
# [*B1*] = Button1 (Left mouse button)
# [*B2*] = Button2 (Middle mouse button)
# [*B3*] = Button3 (Right mouse button)
# [*B4*] = Button4 (Mouse wheel up)
# [*B5*] = Button5 (Mouse wheel down)
#
# ==== Modifiers
#
# [*A*] = Alt key
# [*C*] = Control key
# [*M*] = Meta key
# [*S*] = Shift key
# [*W*] = Super (Windows) key
#
# === Action
#
# An action is something that happens when a grab is activated, this can be one
# of the following:
#
# [*symbol*] Run a subtle action
# [*string*] Start a certain program
# [*array*]  Cycle through gravities
# [*lambda*] Run a Ruby proc
#
# === Example
#
# This will create a grab that starts a urxvt when Alt+Enter are pressed:
#
#   grab "A-Return", "urxvt"
#   grab "C-a c",    "urxvt"
#
# === Link
#
# http://subforge.org/projects/subtle/wiki/Grabs
#

# Jump to view1, view2, ...
grab "W-S-1", :ViewJump1
grab "W-S-2", :ViewJump2
grab "W-S-3", :ViewJump3
grab "W-S-4", :ViewJump4
grab "W-S-5", :ViewJump5
grab "W-S-6", :ViewJump6
grab "W-S-7", :ViewJump7

# Switch current view
grab "W-1", :ViewSwitch1
grab "W-2", :ViewSwitch2
grab "W-3", :ViewSwitch3
grab "W-4", :ViewSwitch4
grab "W-5", :ViewSwitch5
grab "W-6", :ViewSwitch6
grab "W-7", :ViewSwitch7
grab "W-p", :ViewSwitch8

# Select next and prev view */
grab "A-Tab", :ViewNext
grab "A-S-Tab", :ViewPrev

# Move mouse to screen1, screen2, ...
grab "W-A-1", :ScreenJump1
grab "W-A-2", :ScreenJump2

# Force reload of config and sublets
grab "W-C-r", :SubtleReload

# Force restart of subtle
grab "W-C-S-r", :SubtleRestart

# Quit subtle
grab "W-C-q", :SubtleQuit

# Move current window
grab "W-B1", :WindowMove

# Resize current window
grab "W-B3", :WindowResize

# Toggle floating mode of window
grab "W-u", :WindowFloat

# Toggle fullscreen mode of window
grab "W-space", :WindowFull

# Toggle sticky mode of window (will be visible on all views)
grab "W-s", :WindowStick

# Toggle zaphod mode of window (will span across all screens)
grab "W-equal", :WindowZaphod

# Raise window
grab "W-r", :WindowRaise

# Lower window
grab "W-l", :WindowLower

# Select next windows
grab "W-Left",  :WindowLeft
grab "W-Down",  :WindowDown
grab "W-Up",    :WindowUp
grab "W-Right", :WindowRight

grab "W-a", :WindowLeft
grab "W-d", :WindowRight

# Kill current window
#grab "W-S-k", :WindowKill
grab "A-F4", :WindowKill
grab "A-XF86Display", :WindowKill

# Lock Screen
grab "C-A-l", "slock"

# Fn shortcuts
grab "XF86AudioMute", "amixer -q set Master toggle"
grab "XF86AudioLowerVolume","amixer set Master 5%- unmute"
grab "XF86AudioRaiseVolume","amixer set Master 5%+ unmute"
grab "XF86MonBrightnessDown","xbacklight -dec 10"
grab "XF86MonBrightnessUp","xbacklight -inc 10"

# Fn-off shortcuts
grab "F6", "amixer -q set Master toggle"
grab "F7","amixer set Master 5%- unmute"
grab "F8","amixer set Master 5%+ unmute"
grab "F2","xbacklight -dec 10"
grab "F3","xbacklight -inc 10"

# Exec programs
grab "W-t", "urxvt"
grab "W-f", "chromium"
#grab "W-f", "firefox"
grab "W-e", "emacs"
grab "W-m", "urxvt -name mocp -background black -foreground white -e mocp"
grab "W-n", "urxvt -name ncmpcpp -background black -foreground white -e ncmpcpp"
#grab "A-F2", "dmenu_run  -hist ~/.dmenu.hist -l 5"
grab "A-F2", "dmenu_run -l 5 -hist ~/.dmenu.hist -fn \"ohsnap:size=12\" -nf \"" + gray1 + "\" -nb \"" + black1 + "\" -sb \"" + gray3 + "\" -sf \""+blue1+"\""
#grab "A-F2", "dmenu_run -w 210 -h 18 -l 5 -fn \"ohsnap:size=12\" -nf \"" + gray1 + "\" -nb \"" + black1 + "\" -sb \"" + gray3 + "\" -sf \""+blue1+"\""
#grab "A-F2", "bashrun2 smart"
#grab "A-F2" do  Subtle::Contrib::Launcher.run; end

grab "A-XF86MonBrightnessDown", "bashrun2 smart"
grab "W-F5", "pkill pidgin && pidgin"

# Cycle between given gravities
#grab "W-KP_7", [ :top_left,     :top_left66,     :top_left33     ]
#grab "W-KP_8", [ :top,          :top66,          :top33          ]
#grab "W-KP_9", [ :top_right,    :top_right66,    :top_right33    ]
#grab "W-KP_4", [ :left,         :left66,         :left33         ]
#grab "W-KP_5", [ :center,       :center66,       :center33       ]
#grab "W-KP_6", [ :right,        :right66,        :right33        ]
#grab "W-KP_1", [ :bottom_left,  :bottom_left66,  :bottom_left33  ]
#grab "W-KP_2", [ :bottom,       :bottom66,       :bottom33       ]
#grab "W-KP_3", [ :bottom_right, :bottom_right66, :bottom_right33 ]

# In case no numpad is available e.g. on notebooks
grab "C-A-Left",  [ :center,       :left,           :left66,        :left33]
grab "C-A-Right", [ :right,        :right66,        :right33        ]
grab "C-A-Up",    [ :top_right,    :top_right66,    :top_right33    ]
grab "C-A-Down",  [ :bottom_right, :bottom_right66, :bottom_right33 ]
grab "C-W-Up",    [ :video_small,  :video_small2,   :top_right      ]
grab "C-W-Down",  [ :top_right,    :video_small2,   :video_small    ]

#grab "W-s", [ :center,       :center66,       :center33       ]
#grab "W-d", [ :right,        :right66,        :right33        ]
#
# QUERTZ
#grab "W-y", [ :bottom_left,  :bottom_left66,  :bottom_left33  ]
#
# QWERTY
#grab "W-z", [ :bottom_left,  :bottom_left66,  :bottom_left33  ]
#
#grab "W-x", [ :bottom,       :bottom66,       :bottom33       ]
#grab "W-c", [ :bottom_right, :bottom_right66, :bottom_right33 ]


# Run Ruby lambdas
grab "S-F2" do |c|
  puts c.name
end

grab "S-F3" do
  puts Subtlext::VERSION
end

#
# == Tags
#
# Tags are generally used in subtle for placement of windows. This placement is
# strict, that means that - aside from other tiling window managers - windows
# must have a matching tag to be on a certain view. This also includes that
# windows that are started on a certain view will not automatically be placed
# there.
#
# There are to ways to define a tag:
#
# === Simple
#
# The simple way just needs a name and a regular expression to just handle the
# placement:
#
# Example:
#
#  tag "terms", "terms"
#
# === Extended
#
# Additionally tags can do a lot more then just control the placement - they
# also have properties than can define and control some aspects of a window
# like the default gravity or the default screen per view.
#
# Example:
#
#  tag "terms" do
#    match   "xterm|[u]?rxvt"
#    gravity :center
#  end
#
# === Default
#
# Whenever a window has no tag it will get the default tag and be placed on the
# default view. The default view can either be set by the user with adding the
# default tag to a view by choice or otherwise the first defined view will be
# chosen automatically.
#
# === Properties
#
# [*borderless*] This property enables the borderless mode for tagged clients.
#
#                Example: borderless true
#                Links:    http://subforge.org/projects/subtle/wiki/Tagging#Borderless
#                          http://subforge.org/projects/subtle/wiki/Clients#Borderless
#
# [*fixed*]      This property enables the fixed mode for tagged clients.
#
#                Example: fixed true
#                Links:   http://subforge.org/projects/subtle/wiki/Tagging#Fixed
#                         http://subforge.org/projects/subtle/wiki/Clients#Fixed
#
# [*float*]      This property enables the float mode for tagged clients.
#
#                Example: float true
#                Links:   http://subforge.org/projects/subtle/wiki/Tagging#Float
#                         http://subforge.org/projects/subtle/wiki/Clients#Float
#
# [*full*]       This property enables the fullscreen mode for tagged clients.
#
#                Example: full true
#                Links:   http://subforge.org/projects/subtle/wiki/Tagging#Fullscreen
#                         http://subforge.org/projects/subtle/wiki/Clients#Fullscreen
#
# [*geometry*]   This property sets a certain geometry as well as floating mode
#                to the tagged client, but only on views that have this tag too.
#                It expects an array with x, y, width and height values whereas
#                width and height must be >0.
#
#                Example: geometry [100, 100, 50, 50]
#                Link:    http://subforge.org/projects/subtle/wiki/Tagging#Geometry
#
# [*gravity*]    This property sets a certain to gravity to the tagged client,
#                but only on views that have this tag too.
#
#                Example: gravity :center
#                Link:    http://subforge.org/projects/subtle/wiki/Tagging#Gravity
#
# [*match*]      This property adds matching patterns to a tag, a tag can have
#                more than one. Matching works either via plaintext, regex
#                (see man regex(7)) or window id. Per default tags will only
#                match the WM_NAME and the WM_CLASS portion of a client, this
#                can be changed with following possible values:
#
#                [*:name*]      Match the WM_NAME
#                [*:instance*]  Match the first (instance) part from WM_CLASS
#                [*:class*]     Match the second (class) part from WM_CLASS
#                [*:role*]      Match the window role
#                [*:type*]      Match the window type
#
#                Examples: match instance: "urxvt"
#                          match [:role, :class] => "test"
#                          match "[xa]+term"
#                Link:     http://subforge.org/projects/subtle/wiki/Tagging#Match
#
# [*position*]   Similar to the geometry property, this property just sets the
#                x/y coordinates of the tagged client, but only on views that
#                have this tag, too. It expects an array with x and y values.
#
#                Example: position [ 10, 10 ]
#                Link:    http://subforge.org/projects/subtle/wiki/Tagging#Position
#
# [*resize*]     This property enables the float mode for tagged clients.
#
#                Example: resize true
#                Links:   http://subforge.org/projects/subtle/wiki/Tagging#Resize
#                         http://subforge.org/projects/subtle/wiki/Clients#Resize
#
# [*stick*]      This property enables the float mode for tagged clients.
#
#                Example: stick true
#                Links:   http://subforge.org/projects/subtle/wiki/Tagging#Stick
#                         http://subforge.org/projects/subtle/wiki/Clients#Stick
#
# [*type*]       This property sets the tagged client to be treated as a specific
#                window type though as the window sets the type itself. Following
#                types are possible:
#
#                [*:desktop*]  Treat as desktop window (_NET_WM_WINDOW_TYPE_DESKTOP)
#                              Link: http://subforge.org/projects/subtle/wiki/Clients#Desktop
#                [*:dock*]     Treat as dock window (_NET_WM_WINDOW_TYPE_DOCK)
#                              Link: http://subforge.org/projects/subtle/wiki/Clients#Dock
#                [*:toolbar*]  Treat as toolbar windows (_NET_WM_WINDOW_TYPE_TOOLBAR)
#                              Link: http://subforge.org/projects/subtle/wiki/Clients#Toolbar
#                [*:splash*]   Treat as splash window (_NET_WM_WINDOW_TYPE_SPLASH)
#                              Link: http://subforge.org/projects/subtle/wiki/Clients#Splash
#                [*:dialog*]   Treat as dialog window (_NET_WM_WINDOW_TYPE_DIALOG)
#                              Link: http://subforge.org/projects/subtle/wiki/Clients#Dialog
#
#                Example: type :desktop
#                Link:    http://subforge.org/projects/subtle/wiki/Tagging#Type
#
# [*urgent*]     This property enables the urgent mode for tagged clients.
#
#                Example: stick true
#                Links:   http://subforge.org/projects/subtle/wiki/Tagging#Stick
#                         http://subforge.org/projects/subtle/wiki/Clients#Urgent
#
# [*zaphod*]     This property enables the zaphod mode for tagged clients.
#
#                Example: zaphod true
#                Links:   http://subforge.org/projects/subtle/wiki/Tagging#Zaphod
#                         http://subforge.org/projects/subtle/wiki/Clients#Zaphod
#
#
# === Link
#
# http://subforge.org/projects/subtle/wiki/Tagging
#

# Simple tags


tag "browser" do
  match "opera|firefox|chrom[e|ium]|navigator|plugin-container"
  match "Google-chrome-unstable"
end

tag "editor" do
  match "emacs|[g]?vim|gedit|subl[ime]?"
  match :name =>"Fig*|fig*|Python*|python*"
end



tag "extra" do 
  match "nautilus|thunar"
end
tag "torrent" do
  match "transmission-gtk|deluge"
end
tag "pdf" do 
  match "evince|mirage|zathura|comix"
end

#Separate console based apps from consoles
tag "terms" do
  match :instance =>"[u]?rxvt|xterm"
end

tag "mocp" do
  match :instance =>"mocp"
  match :class =>"mocp"
  gravity :mocp
  fixed true 
end

tag "ncmpcpp" do
  match :instance =>"ncmpcpp"
  match :class =>"ncmpcpp"
  gravity :ncmpcpp
  fixed true
end

tag "chat" do
  match "pidgin|empathy|finch"
  dialog true
  #urgent false
end

tag "menu" do
  match "bashrun[2]?"
  gravity :bashrun
  fixed true
  stick true
  urgent true
  borderless true
end


tag "video_small" do
  match "vlc"
  gravity :video_small
  stick true
end

tag "video" do
  match "vlc"
  gravity :center
end

tag "mail" do
  match "thunderbird|geary"
  gravity :mail_main
  fixed true
end

tag "sylph_main" do
  match "sylpheed"
  match :role => "main_window"
  gravity :sylpheed_main
  urgent true
  fixed true
end

tag "sylph_fold" do
  match "folder_view"
  gravity :sylpheed_fold
  urgent true
  fixed true
end

tag "pidgin_small" do
  match :role =>"conversation"
  match :role =>"app"
  match :role =>"chat"
  gravity :pidgin_small
  stick true
  fixed true
end

tag "pidgin_conv" do
  match :role =>"conversation"
  match :role =>"chat"
  gravity :pidgin_conv
  fixed true
end

tag "pidgin_main" do
  match :role =>"buddy_list"
  match :role =>"contact_list"
  gravity :pidgin_main
  fixed true
end

tag "hangs" do
#  match :role =>"app"
  stick true
end

#Placement
tag "fixed" do
  geometry [ 10, 10, 100, 100 ]
  stick    true
end

tag "resize" do
  match  "sakura|gvim"
  resize true
end

tag "gravity" do
  gravity :center
end

#Modes
tag "stick" do
  match "mplayer"
  float true
  stick true
end

tag "float" do
  match "display"
  float true
end

# Gimp
tag "gimp_image" do
  match   :role => "gimp-image-window"
  gravity :gimp_image
  fixed true
end

tag "gimp_toolbox" do
  match   :role => "gimp-toolbox$"
  gravity :gimp_toolbox
  fixed true
end

tag "gimp_dock" do
  match   :role => "gimp-dock"
  gravity :gimp_dock
  fixed true
end


#
# == Views
#
# Views are the virtual desktops in subtle, they show all windows that share a
# tag with them. Windows that have no tag will be visible on the default view
# which is the view with the default tag or the first defined view when this
# tag isn't set.
#
# Like tags views can be defined in two ways:
#
# === Simple
#
# The simple way is exactly the same as for tags:
#
# Example:
#
#   view "terms", "terms"
#
# === Extended
#
# The extended way for views is also similar to the tags, but with fewer
# properties.
#
# Example:
#
#  view "terms" do
#    match "terms"
#    icon  "/usr/share/icons/icon.xbm"
#  end
#
# === Properties
#
# [*match*]      This property adds a matching pattern to a view. Matching
#                works either via plaintext or regex (see man regex(7)) and
#                applies to names of tags.
#
#                Example: match "terms"
#
# [*dynamic*]    This property hides unoccupied views, views that display no
#                windows.
#
#                Example: dynamic true
#
# [*icon*]       This property adds an icon in front of the view name. The
#                icon can either be path to an icon or an instance of
#                Subtlext::Icon.
#
#                Example: icon "/usr/share/icons/icon.xbm"
#                         icon Subtlext::Icon.new("/usr/share/icons/icon.xbm")
#
# [*icon_only*]  This property hides the view name from the view buttons, just
#                the icon will be visible.
#
#                Example: icon_only true
#
#
# === Link
#
# http://subforge.org/projects/subtle/wiki/Tagging
#

#iconpath = "/home/valenca/.icons/subtle"

view "arch" do
  #icon Subtlext::Icon.new("#{iconpath}/simple1/arch2.xbm")
  #icon_only true
  match "mocp|ncmpcpp"
end


view "terminal" do
  match "terms|editor"
  #icon Subtlext::Icon.new("#{iconpath}/simple1/terminal.xbm")
  #icon_only true
end
    
view "internet" do
  match "browser"
  #icon Subtlext::Icon.new("#{iconpath}/simple1/world.xbm")
  #icon_only true
end

view "messages" do
  match "chat|pidgin_main|pidgin_conv|mail|sylph_main|sylph_fold|hangouts"
  #icon Subtlext::Icon.new("#{iconpath}/simple1/balloon.xbm")
  #icon_only true
end

view "extra" do
  match "extra|default|video"
  #icon Subtlext::Icon.new("#{iconpath}/simple1/box_plus.xbm")
  #icon_only true
  dynamic true
end

view "torrent" do
  match "torrent"
  #icon Subtlext::Icon.new("#{iconpath}/simple1/box_plus.xbm")
  #icon_only true
  dynamic true
end

view "gimp" do
  match "gimp_.*"
  #icon Subtlext::Icon.new("#{iconpath}/simple1/pencil.xbm")
  dynamic true
end

view "pdf" do
  match "pdf"
  dynamic true
end

#view "dev", "editor"
#view "gimp",  "gimp_.*"

#
# == Sublets
#
# Sublets are Ruby scripts that provide data for the panel and can be managed
# with the sur script that comes with subtle.
#
# === Example
#
#  sur install clock
#  sur uninstall clock
#  sur list
#
# === Configuration
#
# All sublets have a set of configuration values that can be changed directly
# from the config of subtle.
#
# There are three default properties, that can be be changed for every sublet:
#
# [*interval*]    Update interval of the sublet
# [*foreground*]  Default foreground color
# [*background*]  Default background color
#
# sur can also give a brief overview about properties:
#
# === Example
#
#   sur config clock
#
# The syntax of the sublet configuration is similar to other configuration
# options in subtle:

sublet :clock2 do
  interval 1
  foreground    gray1 
  time_format   "%H:%M"
  #time_format  "%l:%M %p"
  date_format   ""
end


#sublet :volume do
#  interval 60
#  step 5
#end

#sublet :battery do
#  interval      30
#  colors 10 => "#ff0000", 30 => "#fff000"
#  path "/sys/class/power_supply/"
#  color_text    true
#end

#  === Link
#
# http://subforge.org/projects/subtle/wiki/Sublets
#

#
# == Hooks
#
# And finally hooks are a way to bind Ruby scripts to a certain event.
#
# Following hooks exist so far:
#
# [*:client_create*]    Called whenever a window is created
# [*:client_configure*] Called whenever a window is configured
# [*:client_focus*]     Called whenever a window gets focus
# [*:client_kill*]      Called whenever a window is killed
#
# [*:tag_create*]       Called whenever a tag is created
# [*:tag_kill*]         Called whenever a tag is killed

#
# [*:view_create*]      Called whenever a view is created
# [*:view_configure*]   Called whenever a view is configured
# [*:view_jump*]        Called whenever the view is switched
# [*:view_kill*]        Called whenever a view is killed
#
# [*:tile*]             Called on whenever tiling would be needed
# [*:reload*]           Called on reload
# [*:start*]            Called on start
# [*:exit*]             Called on exit
#
# === Example
#
# This hook will print the name of the window that gets the focus:
#
#   on :client_focus do |c|
#     puts c.name
#   end
#
# === Link
#
# http://subforge.org/projects/subtle/wiki/Hooks
#

on :reload do 
  system("feh --bg-fill ~/Dropbox/.omni/wallpapers/active/*")
end

on :start do
  system("feh --bg-fill ~/Dropbox/.omni/wallpapers/active/*")
end
