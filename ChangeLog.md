# Update [v0.5 BETA](https://drive.google.com/open?id=0B60LM8tknl39QW1ibk9SSFdXem8)


## General ##
* Chance and Tier equation for Bounty-Token adjusted (T5 doubles the chance, T10 triples it => Base Chance + Tier / 5 * Base Chance)
* Info about chances: A chance of 200% will give you a guaranteed 2 Bounty-Token (same with Enemy-Souls)
* added DAIL merchant pot support to Hero and MiniBoss kills
* Various tag changes
* Usable Item changes due to the fact I figured out a way to only use 1 Skill Slot for them


## New Features ##
* Runes and Runic Inscriptions


## Runes and Runic Inscriptions ##
* NPC
  + A new NPC "Rune-Scribe" can give you the item "Salvage Items (Common)" and scrolls to summon him and the Blacksmith
  + The new item "Salvage Items (Common)" will salvage every common item in your inventory and give you parts to craft an "Equipment-Stone" used to make "Runic Inscriptions"
  + The "Rune-Scribe" has information about the different things you can do and how they work

* Runes
  * Crafted at a Blacksmith from components - you will get a usable Rune
  * Using the usable Rune on its own will give you a "Rune-Component" you can use in your items
  * Using the usable Rune in combination with an "Equipment-Stone" is part of the "Runic-Inscription" process and only has a chance at giving you the "Rune-Component"

* Runic Inscriptions
  * using the "Equipment-Stone" will start the process of "Runic Inscription"
  * "Equipment-Stone" have different amounts of Rune-Sockets once the limit is reached the runes will be merged into a "Runic Inscription", but only if it is the correct combination and sequence of Runes and "Equipment-Stone" with the correct amount of Sockets
  * Example: when the Runic Inscription requires: 1H Axe-Stone (3Socket) + Rune B + Rune A + Rune C - it will only create that Runic Inscription with that Rune Sequence and that Equipment-Stone
  * An alternative to specific Equipment-Stones is to use the stone for its Category: Weapon-Stone for Daggers, Axes etc

* Greater Runes & Greater Runic Inscriptions
  * Greater Runes & Greater Runic Inscriptions have higher stats and maybe even an additional stat
  * Greater Runes can be created by using the usable Rune directly, but it is not guaranteed to get one, you will most likely get a normal Rune
  * Greater Runic Inscriptions can only be created by using the specific "Equipment-Stone" (using a 1H Axe-Stone rather than a Weapon-Stone), however you only have a chance to get a Greater Runic Inscription, you will likely get a normal Runic Inscription


## Bug Fixes ##
* DGA Affixes Obelisk will now check if the player has the required items


## For other Modders ##
* Runes and Runic Inscriptions will have a standalone source release... soon