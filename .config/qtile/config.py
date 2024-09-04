# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
import os
import subprocess
from libqtile import bar, layout, qtile, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from pathlib import Path
from qtile_extras import widget
from qtile_extras.widget.decorations import PowerLineDecoration
from colors import gruvbox, gruv_mat

mod       = "mod4"
terminal  = "kitty"
browser   = "thorium-browser"
fileman   = "nemo"
rofi      = "rofi -show drun"
home = str(Path.home())


keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "left",  lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "right", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "down",  lazy.layout.down(), desc="Move focus down"),
    Key([mod], "up",    lazy.layout.up(), desc="Move focus up"),
    Key([mod], "tab", lazy.layout.next(), desc="Move window focus to other window"),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
   
      # Grow/shrink windows left/right. 
    # This is mainly for the 'monadtall' and 'monadwide' layouts
    # although it does also work in the 'bsp' and 'columns' layouts.
    Key([mod], "equal",
        lazy.layout.grow_left().when(layout=["bsp", "columns"]),
        lazy.layout.grow().when(layout=["monadtall", "monadwide"]),
        desc="Grow window to the left"
    ),
    Key([mod], "minus",
        lazy.layout.grow_right().when(layout=["bsp", "columns"]),
        lazy.layout.shrink().when(layout=["monadtall", "monadwide"]),
        desc="Grow window to the left"
    ),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"],"Return",lazy.layout.toggle_split(),desc="Toggle between split and unsplit sides of stack"),
    
    # Toggle between different layouts as defined below
    Key([mod], "Tab",          lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "space",            lazy.window.toggle_fullscreen(), desc="Toggle fullscreen on the focused window"),
    Key([mod], "t",            lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
    Key([mod, "shift"], "q",   lazy.window.kill(), desc="Kill focused window"),

    # Basic utils
    Key([mod, "shift"], "r",   lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r",            lazy.spawncmd(), desc="Spawn a command using a prompt widget"),

    # Application Binds
    Key([mod], "Return",     lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "p",          lazy.spawn(rofi), desc="Launch Rofi run launcher"),
    Key([mod], "b",          lazy.spawn(browser), desc="Launch browser"),
    Key([mod, "shift"], "f", lazy.spawn(fileman), desc="Launch file-manager"),
    Key([mod], "u",          lazy.spawn(home + "/.config/rofi/scripts/rofi-utils"), desc="Launch rofi utilities script"),

    # Volume Management

    Key([mod], "F3",          lazy.spawn(home + "/.config/scripts-common/volume.sh --pw-incvol"), desc="Increase Volume(Pipewire)"),
    Key([mod], "F1",          lazy.spawn(home + "/.config/scripts-common/volume.sh --pw-decvol"), desc="Decrease Volume(Pipewire)"),
    Key([mod], "F2",          lazy.spawn(home + "/.config/scripts-common/volume.sh --pw-mute"), desc="Mute Volume(Pipewire)"),

]

# Add key bindings to switch VTs in Wayland.
# We can't check qtile.core.name in default config as it is loaded before qtile is started
# We therefore defer the check until the key binding is run by using .when(func=...)
for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )


groups = [
    Group("1", layout='monadtall', label=''),
    Group("2", layout='monadtall', label=''),
    Group("3", layout='monadtall', label=''),
    Group("4", layout='max',       label=''),
    Group("5", layout='floating',  label=''),
]

for i in groups:
    keys.extend(
        [
            # mod + group number = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod + shift + group number = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod + shift + group number = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

layout_theme = {"border_width": 2,
                "margin": 13,
                "border_focus": "#98971a",
                "border_normal": "#282828"
                } 
layouts = [
        layout.MonadTall(**layout_theme),
        layout.Max(),
        layout.Floating(),
]

arrow_powerlineRight = {
    "decorations": [
        PowerLineDecoration(
            path="arrow_right",
            size=8,
        )
    ]
}
arrow_powerlineLeft = {
    "decorations": [
        PowerLineDecoration(
            path="arrow_left",
            size=8,
        )
    ]
}
rounded_powerlineRight = {
    "decorations": [
        PowerLineDecoration(
            path="rounded_right",
            size=8,
        )
    ]
}
rounded_powerlineLeft = {
    "decorations": [
        PowerLineDecoration(
            path="rouded_left",
            size=8,
        )
    ]
}
slash_powerlineRight = {
    "decorations": [
        PowerLineDecoration(
            path="forward_slash",
            size=8,
        )
    ]
}
slash_powerlineLeft = {
    "decorations": [
        PowerLineDecoration(
            path="back_slash",
            size=8,
        )
    ]
}

widget_defaults = dict(
    font="JetBrainsMono NF Medium",
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                #########################
                # Widget Configurations #
                #########################
                widget.Spacer(
                    length=1,
                    background=gruvbox["yellow"],
                    **arrow_powerlineLeft,
                ),
                widget.GroupBox(
                    font="JetBrainsMono Nerd Font",
                    fontsize=15,
                    padding_x=8,
                    padding_y=5,
                    rounded=False,
                    center_aligned=True,
                    disable_drag=True,
                    borderwidth=3,
                    highlight_method="line",
                    active=gruvbox["cream"],
                    inactive=gruvbox["blue-alt"],
                    highlight_color=gruvbox["dark-grey"],
                    this_current_screen_border=gruvbox["yellow"],
                    this_screen_border=gruv_mat["disabled"],
                    other_screen_border=gruv_mat["red"],
                    other_current_screen_border=gruv_mat["red"],
                    background=gruvbox["dark-grey"],
                    foreground=gruv_mat["disabled"],
                    **arrow_powerlineLeft,
                ),
                widget.TaskList(
                    margin=-2,
                    icon_size=0,
                    fontsize=13,
                    borderwidth=1,
                    rounded=True,
                    highlight_method="block",
                    title_width_method="uniform",
                    urgent_alert_methond="border",
                    foreground=gruv_mat["black"],
                    background=gruvbox["cream"],
                    border=gruvbox["cream"],
                    urgent_border=gruv_mat["red-alt"],
                    txt_floating=" ",
                    txt_maximized=" ",
                    txt_minimized=" ",
                ),
                widget.Spacer(
                    length=1,
                    background=gruvbox["cream"],
                    **rounded_powerlineRight,
                ),
                widget.CPU(
                    padding=5,
                    format="  {freq_current}GHz {load_percent}%",
                    foreground=gruvbox["cream"],
                    background=gruvbox["dark-grey"],
                    **slash_powerlineRight,
                ),
                widget.Memory(
                    padding=5,
                    format="󰈀 {MemUsed:.0f}{mm}",
                    background=gruvbox["cream"],
                    foreground=gruvbox["dark-grey"],
                    **slash_powerlineRight,
                ),
                widget.Clock(
                    padding=5,
                    format="  %a %d %b %H:%M:%S",
                    foreground=gruvbox["yellow"],
                    background=gruvbox["dark-grey"],
                    **slash_powerlineRight,
                ),
                widget.Volume(
                    fmt="󰕾 {}",
                    volume_app='wpctl',
                    foreground=gruvbox["dark"],
                    background=gruvbox["yellow"],
                    padding=10,
                    **slash_powerlineRight,
                ),
                widget.Systray(
                    padding=7,
                    icon_size=15,
                ),
                widget.CurrentLayoutIcon(
                    padding=5,
                    scale=0.8,
                ),
            ],
            ######################
            # BAR CONGIGURATIONS #
            ######################
            20,
            margin=[6, 10, 6, 10],
            border_width=[0, 0, 0, 0],
            background=gruv_mat["dark"],
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# xcursor theme (string or None) and size (integer) for Wayland backend
wl_xcursor_theme = None
wl_xcursor_size = 24

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.Popen([home])

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
