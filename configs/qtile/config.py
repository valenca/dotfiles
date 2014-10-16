from libqtile.config import Key, Screen, Group, Drag, Click, Match
from libqtile.command import lazy
from libqtile import layout, bar, widget

sup = "mod4"
alt = "mod1"

keys = [
    # Switch between windows in current stack pane
    Key([sup], "Down"  , lazy.layout.down()       ),
    Key([sup], "Up"    , lazy.layout.up()         ),
    Key([sup], "Left"  , lazy.layout.left()       ),
    Key([sup], "Right" , lazy.layout.right()      ),
    Key([sup], "plus"  , lazy.layout.grow()       ),
    Key([sup], "l"     , lazy.layout.next()       ),
    Key([sup], "r"     , lazy.layout.previous()   ),
    Key([sup], "minus" , lazy.layout.shrink()     ),
    Key([sup], "Return", lazy.layout.shuffle_up() ),

    # Move windows up or down in current stack

    # Switch window focus to other pane(s) of stack
    #Key([sup], "space",lazy.layout.next()),

    # Swap panes of split stack
    #Key([sup, "shift"], "space",lazy.layout.rotate()),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([sup, "shift"], "Return",
        lazy.layout.toggle_split()
    ),

    # Toggle between different layouts as defined below
    Key([sup], "Tab", lazy.nextlayout()),
    Key([sup], "w", lazy.window.kill()),

    Key([sup, "control"], "r", lazy.restart()),
    Key([sup, "control"], "q", lazy.shutdown()),

    Key([alt], "F2", lazy.spawncmd("")),
    Key([alt], "F4", lazy.window.kill()),

	Key([sup],"t",lazy.spawn("urxvt")),
	Key([sup],"f",lazy.spawn("google-chrome-unstable")),
	Key([sup],"e",lazy.spawn("emacs")),
	Key([sup],"m",lazy.spawn("urxvt -name mocp -background black -foreground white -e mocp")),

	Key([],"F2",lazy.spawn("xbacklight -dec 10")),
	Key([],"F3",lazy.spawn("xbacklight -inc 10")),
	Key([],"F6",lazy.spawn("amixer -q set Master toggle")),
	Key([],"F7",lazy.spawn("amixer set Master 5%- unmute")),
	Key([],"F8",lazy.spawn("amixer set Master 5%+ unmute")),	
]

#matches
m_default = Match(wm_class=["Thunar"],title=["MATLAB R013a"])
m_music   = Match(title=["mocp"])
m_browser = Match(wm_class=["Google-chrome-unstable|Firefox"])
m_terms   = Match(wm_class=["URxvt|XTerm"])
m_editor  = Match(title=["emacs|[g]?vim|gedit|subl[ime]?"])
m_pidgin  = Match(wm_class=["Pidgin"])

l_pidginl=layout.Slice(side="right",width=300,wname="pidgin",role="buddy_list",
fallback=layout.Slice(side="left",width=1298,wname="pidgin",role="conversation",
fallback=layout.Max()))

groups = [
	Group("arch",
		  matches=[m_music],
		  layouts=[layout.Stack(num_stacks=1,margin=200,border_focus="#336699")]),
	Group("terminal",
		  matches=[m_terms,m_editor],
		  layouts=[layout.MonadTall(border_width=1,border_focus="#336699"),layout.Max()]),
	Group("internet",
		  matches=[m_browser]),
	Group("messages",
		  matches=[m_pidgin],
		  #layouts=[layout.MonadTall(border_width=1,border_focus="#336699",border_normal="#333333")]),
		  layouts=[l_pidginl]),
	Group("extra",
		  matches=[m_default],
		  init=False,
		  layouts=[layout.MonadTall(border_width=1,border_focus="#336699"),layout.Max()])
]

for i,g in enumerate(groups):
	keys.extend([
		Key([sup],str(i+1),lazy.group[g.name].toscreen()),
		Key([sup,"shift"],str(i+1),lazy.window.togroup(g.name)),
	])

layouts = [
    layout.Max(),
    layout.Stack(num_stacks=2),
	layout.MonadTall()
]

widget_defaults = dict(
    font='ohsnap',
    fontsize=10,
    padding=0,
)

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
					borderwidth=1,
					active="#999999",
					this_current_screen_border="#336699"
				),
                widget.TextBox(" >> ", 
							   name="default",
							   foreground="#336699"
				),
                widget.WindowName(foreground="#555555"),
                widget.Prompt(),
                widget.Systray(),
                widget.Clock(format='%I:%M'), #'%Y-%m-%d %a %I:%M %p'
            ],
            20,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([sup], "Button1", lazy.window.set_position_floating(),
        start=lazy.window.get_position()),
    Drag([sup], "Button3", lazy.window.set_size_floating(),
        start=lazy.window.get_size()),
    Click([sup], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(auto_float_types=["notification","toolbar","splash","dialog"])
auto_fullscreen = True
wmname = "LG3D"
