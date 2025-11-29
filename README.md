# showkey

A simple terminal key visualizer for `keyd` that displays your recent keypresses in real-time.

## Features

- Shows the last 4 keypresses
- Clean, minimal interface
- Option to Filter out temporary/modifier keys you don't want to see
- Layout remapping support (display keys in Colemak-DH instead of QWERTY)

## Requirements

- `keyd` installed and running

## Installation

1. Save the script to a file (e.g., `showkey.sh`)
2. Make it executable:

   ```bash
   chmod +x showkey.sh
   ```

## Usage

Basic usage:

```bash
./showkey.sh
```

Ignore specific keys (useful for filtering out temporary keys like `f24`):

```bash
./showkey.sh --ignore f24
```

Ignore multiple keys:

```bash
./showkey.sh --ignore f24,leftcontrol,capslock
```

Display keys in Colemak-DH layout:

```bash
./showkey.sh --layout colemak_dh
```

Combine options:

```bash
./showkey.sh --layout colemak_dh --ignore f24
```

Press `Ctrl+C` to exit.

## Example

When you type keys, they'll appear like this:

```
   Recent keys:

   h
   e
   l
   l

   Press any key... (Ctrl+C to exit)
```

## License

MIT
