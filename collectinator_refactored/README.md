# Collectinator - ElvUI Compatible Version

A Wrath of the Lich King (3.3.3/3.3.5) collection tracker addon for World of Warcraft, refactored for ElvUI compatibility.

## Features

- **Companion Pets Tracker**: Scan and track all mini-pets in the game
- **Mount Collection**: Track all mounts available to your character
- **Title Tracker**: Keep track of all titles you've earned and those you're missing
- **Tabard Collection**: Track your tabard collection
- **Fun Items**: Track various fun collectible items
- **ElvUI Integration**: Optional skinning when ElvUI is detected
- **Standalone Operation**: Works perfectly without ElvUI

## Requirements

- World of Warcraft: Wrath of the Lich King (3.3.3 or 3.3.5 - Ascension WoW compatible)
- **Required Libraries** (via CurseForge/Twitch or WowInterface):
  - Ace3 (AceAddon-3.0, AceConsole-3.0, AceEvent-3.0, AceDB-3.0, AceLocale-3.0)
  - LibBabble-Boss-3.0
  - LibBabble-Faction-3.0
  - LibBabble-Zone-3.0
- **Optional**:
  - ElvUI (for enhanced skinning)
  - PetListPlus (for additional pet list features)
  - TipTac (for tooltip styling)

## Installation

### Manual Installation

1. Download the latest release
2. Extract the `Collectinator` folder into your `World of Warcraft/_retail_/Interface/AddOns/` directory
3. Ensure all required libraries are installed in your AddOns folder
4. Launch World of Warcraft

### Using a Client (CurseForge/Twitch)

1. Open your client
2. Search for "Collectinator"
3. Click Install
4. The client will automatically download required dependencies

## Usage

### Opening Collectinator

- Type `/collectinator` or `/col` in chat
- Click the scan button on the Companion frame

### Scan Button Functions

The scan button on the Companion frame has multiple functions:

- **Left Click**: Perform a standard scan
- **Shift + Left Click**: Generate a text dump of your collection
- **Alt + Shift + Left Click**: Scan only pets (Warcraft Pets mode)
- **Alt + Left Click**: Clear map waypoints

### Features

- **Filtering**: Extensive filtering options by:
  - Faction (Alliance/Horde)
  - Known/Unknown status
  - Acquisition method (Vendor, Quest, Drop, Crafted, etc.)
  - Expansion (Original, BC, WotLK)
  - Rarity (Common to Artifact)
  - Profession requirements
  - Reputation requirements
  - Binding type (BoE, BoP, BoA)

- **Exclusion List**: Right-click items to exclude them from your tracking
- **Map Integration**: Shows collectible locations on the world map
- **Tooltips**: Detailed information about how to obtain each collectible

## ElvUI Integration

When ElvUI is detected, Collectinator will automatically:

- Apply ElvUI-style skins to all frames
- Use ElvUI's color scheme
- Match ElvUI's font settings
- Integrate with ElvUI's tooltip styling

No configuration needed - it works automatically!

## Configuration

Access configuration through:
- The options button in the Collectinator window
- `/collectinator config` command

### Display Options

- Font size adjustment
- Tooltip scale
- Tooltip position (Spell/Acquire info)
- Include filtered/excluded items display
- Auto-scan map feature

## Troubleshooting

### Missing Libraries Error

If you see errors about missing libraries, ensure you have installed:
- Ace3 suite
- LibBabble libraries (Boss, Faction, Zone)

These are typically auto-downloaded by CurseForge/Twitch clients.

### ElvUI Skins Not Applying

- Ensure ElvUI is enabled
- Check that ElvUI loads before Collectinator
- Try reloading UI (`/reload`)

### Scan Button Not Visible

- Make sure you're on the Companion/Pet frame
- The button appears on the right side near the close button

## Ascension WoW Compatibility

This version is specifically tested and compatible with:
- Ascension WoW (Wrath 3.3.5)
- Interface version: 30300
- All collectibles from Vanilla through WotLK

## Credits

- **Original Author**: Ackis
- **Contributors**: Torhal, Pompachomp
- **ElvUI Refactor**: Community effort for ElvUI compatibility
- **Libraries**: Ace3 team, LibBabble team

## License

This project is licensed under the MIT License - see LICENSE.txt for details.

## Support

- **Issues**: Report bugs on the GitHub repository
- **Discussions**: Join the community discussions for help
- **Donations**: Support development through CurseForge donations

## Version History

### 2.0.0-ElvUI
- Complete refactor for ElvUI compatibility
- Optional ElvUI skinning module
- Updated for Ascension WoW (3.3.5)
- Improved performance and memory usage
- Enhanced filter system
- Better error handling

### 1.0.4 (Original)
- Initial release with comprehensive collection tracking
