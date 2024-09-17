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
from qtile_extras.widget.decorations import RectDecoration
from colors import gruvbox_palette

mod       = "mod4"
terminal  = "kitty"
browser   = "librewolf"
fileman   = "thunar"
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
    Key([mod, "shift"], "c",   lazy.window.kill(), desc="Kill focused window"),

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

    # Screenshots
    Key([], "Print",          lazy.spawn("flameshot screen"), desc="Take a full screenshot"),
    Key([mod], "Print",       lazy.spawn("flameshot gui"), desc="Take a partial screenshot"),
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
    Group("1", layout='monadtall', label=''),
    Group("2", layout='monadtall', label='󰐹'),
    Group("3", layout='monadtall', label=''),
    Group("4", layout='tile',      label=''),
    Group("5", layout='max',       label=''),
    Group("6", layout='floating',  label=''),
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
        layout.Tile(
            border_width=1,
            margin=0,
            border_focus="#98971a",
            border_normal="#282828",
            ratio=0.5,
),
]

decoration_group = {
    "decorations": [
        RectDecoration(colour=gruvbox_palette["dark0"], radius=10, filled=True, group=True),
    ],
    "padding": 10,
}
widget_defaults = dict(
    font="JetBrainsMono NF Medium",
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()

left = ""
right = ""

screens = [
    Screen(
        top=bar.Bar(
            [
                #########################
                # Widget Configurations #
                #########################
                widget.CurrentLayoutIcon(
                    custom_icon_paths=[
                        os.path.expanduser("~/.config/qtile/icons")
                        ],
                    scale=0.6,
                    **decoration_group,
                    ),    
                widget.Spacer(
                    length=10,
                ),
                widget.GroupBox(
                    font="JetBrainsMono Nerd Font",
                    fontsize=14,
                    padding_x=8,
                    padding_y=-10,
                    rounded=False,
                    center_aligned=True,
                    disable_drag=True,
                    highlight_method="block",
                    block_highlight_text_color=gruvbox_palette["bright_yellow"],
                    active=gruvbox_palette["neutral_blue"],
                    inactive=gruvbox_palette["dark_green_hard"],
                    foreground=gruvbox_palette["dark2"],
                    border="#98971a",
                    **decoration_group,
                ),
                widget.Spacer(
                    length=10,
                ),

                widget.TaskList(
                    margin=-8,
                    icon_size=0,
                    fontsize=12,
                    borderwidth=1,
                    highlight_method="border",
                    title_width_method="uniform",
                    urgent_alert_method="border",
                    foreground=gruvbox_palette["light1"],
                    border=gruvbox_palette["light1"],
                    urgent_border=gruvbox_palette["neutral_red"],
                    txt_floating="󰋹 ",
                    txt_maximized=" ",
                    txt_minimized="󰈉 ",
                    **decoration_group
                ),
                widget.Spacer(
                    length=10,
                ),
                widget.CPU(
                    format=" {load_percent}%",
                    foreground=gruvbox_palette["neutral_aqua"],
                    **decoration_group
                ),
                widget.Memory(
                    format=" {MemUsed:.0f}{mm}",
                    foreground=gruvbox_palette["light_red"],
                    **decoration_group
                ),
                widget.Spacer(
                        length=10,
                        ),
                widget.Volume(
                        fmt="󰕾 {}",
                        volume_app='wpctl',
                        foreground=gruvbox_palette["bright_green"],
                        **decoration_group
                        ),
                widget.Spacer(
                    length=10,
                ),
                widget.Clock(
                    format="󰧰 %a %d/%m/%y 󰥔 %H:%M",
                    foreground=gruvbox_palette["bright_yellow"],
                    **decoration_group
                ),
                widget.Spacer(
                    length=10,
                ),
                widget.Systray(
                    icon_size=20,
                    fmt="{}",
                ),
            ],
            ######################
            # BAR CONFIGURATIONS #
            ######################
            25,
            margin=[6, 10, 6, 10],
            border_width=0,
            background="00000000"
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
        border_focus=gruvbox_palette["faded_blue"],
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
