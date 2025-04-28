# A sway config designed for @sounddrill
## Keybindings
### 🔹 **App Launchers**
- **Mod + p** → Launch application menu (`$menu`)
- **Mod + Enter** → Launch terminal (`$term`)
- **Mod + u** → Launch utilities menu (`$utilsmenu`)
- **Mod + b** → Launch browser (`$browser`)
- **Mod + Shift + f** → Launch file manager (`$filemanager`)

---

### 🔉 **Volume Management**
- **Mod + F1** → Decrease volume (`$volume --pw-decvol`)
- **Mod + F2** → Mute (`$volume --pw-mute`)
- **Mod + F3** → Increase volume (`$volume --pw-incvol`)

---

### 📸 **Screenshot**
- **Print** → Fullscreen screenshot (`$screenshot -f`)
- **Mod + Print** → Selection screenshot (`$screenshot -s`)
- **Mod + Ctrl + Print** → Selection screenshot with 5s delay (`$screenshot -s5s`)

---

### 🪟 **Window Management**
# 🎛️ Sway Keybindings Configuration

## 🔍 Application Launchers
| Keybinding         | Action                         |
|--------------------|--------------------------------|
| `$mod + p`         | Launch menu (`$menu`)          |
| `$mod + Return`    | Launch terminal (`$term`)      |
| `$mod + u`         | Launch utilities menu (`$utilsmenu`) |
| `$mod + b`         | Launch browser (`$browser`)    |
| `$mod + Shift + f` | Launch file manager (`$filemanager`) |

---

## 🔊 Volume Controls
| Keybinding      | Action                          |
|-----------------|---------------------------------|
| `$mod + F1`     | Decrease volume (`--pw-decvol`) |
| `$mod + F2`     | Mute volume (`--pw-mute`)       |
| `$mod + F3`     | Increase volume (`--pw-incvol`) |

---

## 📸 Screenshot
| Keybinding              | Action                          |
|-------------------------|---------------------------------|
| `Print`                 | Full screenshot                 |
| `$mod + Print`          | Area screenshot                 |
| `$mod + Ctrl + Print`   | Area screenshot (5s delay)      |

---

## 🪟 Window Management
| Keybinding         | Action                                |
|--------------------|---------------------------------------|
| `$mod + Shift + c` | Kill focused window                   |
| `$mod + Shift + r` | Reload Sway config                    |
| `$mod + Shift + q` | Prompt to exit Sway                   |
| `$mod + a`         | Focus parent container                |
| `$mod + space`     | Toggle fullscreen                     |
| `$mod + t`         | Toggle floating/tiling mode           |
| `$mod + f`         | Swap focus between tiling/floating    |

---

## 🔁 Focus Movement
| Keybinding          | Action     |
|---------------------|------------|
| `$mod + h / Left`   | Focus left |
| `$mod + j / Down`   | Focus down |
| `$mod + k / Up`     | Focus up   |
| `$mod + l / Right`  | Focus right|

---

## ↔️ Move Window
| Keybinding              | Action     |
|-------------------------|------------|
| `$mod + Shift + h / Left`  | Move left  |
| `$mod + Shift + j / Down`  | Move down  |
| `$mod + Shift + k / Up`    | Move up    |
| `$mod + Shift + l / Right` | Move right |

---

## 📐 Resize Window
| Keybinding               | Action        |
|--------------------------|---------------|
| `$mod + Ctrl + h / Left`  | Shrink width  |
| `$mod + Ctrl + j / Down`  | Grow height   |
| `$mod + Ctrl + k / Up`    | Shrink height |
| `$mod + Ctrl + l / Right` | Grow width    |

---

## 🖥️ Workspaces
| Keybinding         | Action                        |
|--------------------|-------------------------------|
| `$mod + [1-10]`    | Switch to workspace number     |
| `$mod + tab`       | Next workspace                 |
| `$mod + Shift + tab` | Previous workspace           |
| `$mod + Shift + [1-10]` | Move window to workspace  |

---

## 🧱 Layouts
| Keybinding | Action          |
|------------|-----------------|
| `$mod + s` | Stacking layout |
| `$mod + w` | Tabbed layout   |
| `$mod + e` | Toggle split    |

---

## 📦 Scratchpads
| Keybinding         | Action                             |
|--------------------|------------------------------------|
| `$mod + Shift + -` | Move window to scratchpad          |
| `$mod + -`         | Show/hide next scratchpad window   |

---

## 🔧 Resize Mode
Enter with `$mod + r`, then:
| Keybinding          | Action             |
|---------------------|--------------------|
| Arrow Keys / hjkl   | Resize direction   |
| `Return` / `Escape` | Exit resize mode   |
