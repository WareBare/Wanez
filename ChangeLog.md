# Changelog #
You can also check out an [online changelog](http://wanez.de/gd/mod/updates).

## v0.5.0 - Beta #10b ##
### DGA ###
#### Areas ####
* Boss Room changes to make it easier on the eyes

#### Minor Features ####
* You are now able to kill a zombie near the water to complete the difficulty you are in, this way it won't change back to  Normal if you were in Ultimate before
  * I have also added two guards in case the zombie finds its way into the camp
  * I decided to go that way, because it doesn't really change anything for custom game since you can do any difficulty at any time

#### Bug Fixes ####
* water color in marshes fixed

## v0.5.0 - Beta #10 ##
### DGA ###
#### Tech ####
* spawning is now done location by location, rather than everything in one action
* the reason for this change are new maps
* as a nice little side-effect, loading times have been reduced
* I need some feedback regarding this change
  * does it feel weird?
  * does it lag?
  * does it crash?

#### Areas ####
* changed the number of possible spawn locations to be the same for each map
  * the purpose of this change is to balance DGA-Scroll drops and Affix outcome, the idea is for every map to be equal in terms of loot, this way you can do the area you prefer without thinking about game advantages.
  * some exceptions for smaller maps, as they would have too much density (I may have to increase their size in the future).
  * certain larger maps may seem too easy with this change, if this is the case I may have to block certain parts to increase monster density.
  * different Monster Density isn't necessarily a bad thing
* New Regular Maps
  * Beach
  * Marshes
  * Tropical Island
  * Mountain Ledge
* all Regular Maps are once again part of the Random DGA-Pool
* move Portals inside the Boss Room/Arena

#### Minor Features ####
* you can now buy Area-Scrolls at a Faction Merchant (requires Friendly)
  * Area-Scroll crafting is still possible at the Blacksmith, but the creation cost has been reduced to 1 (from 1000)
  * the reason for adding them to a vendor is to be able to buy a specific Area-Scroll now that there are coming more and more new areas

### Grim Dawn Version v1.0.0.9 ###
#### Minor Updates ####
* some monsters have been updated to reflect the Crowd Control Resistance changes in 1.0.0.9
* Runes have been updated to reflect the change in 1.0.0.9

## v0.5.0 - Beta #09 ##
### DGA ###
#### Areas ####
* some visual changes to "Mine" and renamed to "Abandoned Mine"
* Island of Woe [by hawk4me] has been added back into the Mod
  * the scroll is available at the merchant for a limited time
  * this area is currently not part of the random map pools, due to possible issues
  * it's a multi-region map, you can go back and forth as you like (this is different to the previous versions, due to the Lua overhaul in v0.5)

#### Minor Features ####
* The message "A Portal has been opened" has been removed
* Exp Usables have been increased (x5)
* Drop-Rate of Souls increased by 66%
* Drop-Rate of Essences reduced by 33%
* new Medal at the Merchant, it will reduce your energy regen by -1000, the reason for this item is to ease the use of Exp/Devotion Usables. You just have to use a skill (default attack works, too) or have some Energy reserved and your energy is drained until you take it off again.
* Chest weights for DGA-Orbs and DGA-Affixes have benn adjusted
* individual DGA-Affixes (II) Icons have been added

### Runic Inscriptions ###
#### Minor Features ####
* Exp for Rune Lore has been increased to 10000 to make them more interesting while leveling

### Gifts & Treasures ###
#### Minor Features ####
* Chance to roll Experience Gain Implicit increased (it's leveling gear after all)
* Removed "Leveling" from crafting Tags to make it fit better into the window

## v0.5.0 - Beta #08 ##
### DGA ###
#### Shrines ####
* changed Shrines
  * Shrine of Fleeting - 50% Movement Speed; 20% Projectile Speed
* new Shrines
  * Shrine of the Giant - 25% Health; 25% Energy
  * Shrine of Trollblood - 25% Health Regeneration; 15 Health Regeneration; 25% Energy Regeneration; 10 Energy Regeneration
  * Shrine of Precision - 100 Offensive Ability; 25% Offensive Ability
  * Shrine of Avoidance - 100 Defensive Ability; 25% Defensive Ability
  * Shrine of Protection - 25% Armor; 25% Absorption
  * Shrine of Power - +500% All Damage
  * Shrine of Resistance - +5 to all Maximum Resistances
  * Shrine of Force - 50% reduced reflective damage taken

#### Affixes ####
* Affix drop-chance increases have been reduced
* Affixes to add entities have been adjusted
  * additional Champion spawns increased to +4 (from +2)
  * additional Hero spawns increased to +2 (from +1)
* new Affix Type buffing enemies has been added (they are all using the same icon, I wanted to release it before spending time on making individual ones)
  * Onslaught: 25% Run Speed, Attack Speed, Casting Speed
  * Monster Health: 25% Monster Health
  * Monster Damage: 25% Monster Damage
  * Monster Regen: 25% Monster Regen
  * Monster Offensive Ability: 25% Monster Offensive Ability
  * Monster Defensive Ability: 25% Monster Defensive Ability

#### Minor Features ####
* Empty Faction Merchant removed and added a Merchant selling potions
  * as a result increased the amount of Iron Bits the player receives on first log in to 3000 and the player won't receive potions anymore
* Nemesis spawn chances have been increased (Hostile | Despised | Hated | Nemesis)
  * Regular DGA (Mission, Endless): 0% | 25% | 75% | 300%
  * Challenge DGA: 0% | 100% | 200% | 400%

#### Major Features ####
* Rune Lore can be found from bookstands and they will drop 0-2 random pages (+1 for every player in your party).

#### Bug Fixes ####
* two Shrines have been fixed, as they were not casting their buff
* Using an Affix Scroll of an Affix you already have now returns the Scroll

### Runic Inscriptions ###
#### Minor Features ####
* 3 new Inscriptions have been added
* Tag: Foot Armor changed to Boots

#### Major Features ####
* Lore Pages can be found to give a hint on how to create a new Inscription
  * There is a total of 107 different Pages
* new NPC explaining how Runes and Inscriptions work
  * NPC can give the first set of Lore Pages as an example

#### Bug Fixes ####
* Generic Stones still required 500 Scraps to be crafted, this is now reduced correctly to 50 Scraps

### Gifts & Treasures ###
#### Bug Fixes ####
* Dagger model has been fixed
* Dagger class has been changed from sword to dagger (it will now show up under Implements)
* Sword model has been fixed

## v0.5.0 - Beta #07 ##
### DGA ###
#### Factions ####
* trying out a few changes to reputation gain (for DGA Factions).
* you can gain Reputation by killing a pack (not individual monsters)
* reputation will now have a chance roll.
  * a chance of 25% will either give +0 Reputation or +1.
  * a chance of 250 will either give +2 Reputation or +3.
* Reputation Chance can be increased by:
  * Reputation gain can be increased with higher Tiers (+5% per Tier).
  * Reputation gain is increased until reaching rank 1, this will enable Nemesis spawns sooner.
  * Reputation gain is significantly slower towards the end.

#### Shrines ####
* Shrine duration now depends on Faction Rank (Planes-Shifter)
  * You gain +1 minute to the duration of shrines for every Faction Rank
  * Shrine duration starts at 1 minute
  * the current maximum duration of Shrines is 5 minutes
* one new Shrine has been added and Shrine of Speed has been split into two new shrines both of which have been renamed
  * Shrine of Fleeting: Increases Movement (50%)
  * Shrine of Celerity: Attack and Casting Speed (25%)
  * Shrine of Quickening: Cooldown Reduction, Mana Cost Reduction (25%)
  * Renamed Shrine of Experience to Shrine of Enlightenment
  * Icons will be changed when I have the time for it, just made some changes to the existing ones to see a difference

#### Major Features ####
* You can now craft usables granting you either experience or devotion, they come in 3 different Tiers
  * 1 DGA-Orb:   Experience Usable - 1000 | 10000 | 50000
  * 10 DGA-Orbs: Experience Usable - 10000 | 100000 | 500000
  * 15 DGA-Orbs:   Devotion Usable - 1 | 3 | 5
  * They can only be used when you are not at maximum Energy
  * Only the Normal/Elite Blacksmith has these usables, since you will likely use them in those difficulties and it keeps the Ultimate Blacksmith clean
  * they are tradable and can be placed in your transfer stash
* The option to get Devotion Points or Experience has been removed from the Ghost's Conversation (due to the addition of usables)

#### Minor Features ####
* a Riftgate has been added to return to the Encampment (this cannot be used to get back into the map/rift)
* chests will now spawn more frequently, but some of them have less loot
* Trainings Dummies have been added to the Encampment
* The Ghost has been moved a little farther away from the spawn point to prevent accidentally clicking on him

#### Bug Fixes ####
* Endless portal to the next area sometimes disappeared
* Sometimes going to Torture Chamber would not spawn any monsters
* Nemesis spawn caused an issue if the chance roll was 0

## v0.5.0 - Beta #06 ##
### DGA ###
#### Shrines & Pylons ####
* Shrines can now spawn in maps, they are as rare as chests and their effects last 10min
* added two shrines:
  * Shrine of Experience (150% Exp)
  * Shrine of Speed (50% Movement Speed, 25% Attack Speed, 25% Casting Speed)
* it is very likely balancing will result in reduced duration

### Gifts & Treasures ###
#### Properties ####
* several % All Damage mods have been reduced
* belts flat regen have been changed to regen %
* various small adjustments

#### Items ####
* Medals have been added

## v0.5.0 - Beta #05 ##
### DGA ###
#### Maps ####
* fixed various map related issues

#### Enemies ####
* fixed two more missing tags
  * tagEnemyZombieTrollHalfB01=Zombie Mistborn Hunter
  * tagEnemyZombieTrollHalfC01=Zombie Mistborn Warrior

### Gifts & Treasures ###
#### Weapons ####
* fix to weapon attack speed, every weapon had 1.25 (default value) due to an issue with the generation tool and negative numbers
* weapon rework - I only placed some random values and a pretty bad scaling on them, to get it done asap, I have taken a closer look now
  * Weapon Damage has been increased across the board ()
  * Ranged weapons received a buff (always felt a little underwhelming to me, Im gonna test it out if they're too strong now)
  * Scepters now have magical base dmg and their respective increases(this includes DoT increases)
  * total speed (implicit) on some weapons has been changed to bonus physical damage
  * increases (implicit) on two-handed weapons has been doubled to make up for the loss in an off hand
  * one-handed weapons have received a 30% damage buff (compared to vanilla values)

#### Variations ####
* Scepter Physical Damage Increase has been replaced with high Total Damage value

#### Properties ####
* rebalance and multiple changes
  * little more love for pets
  * lowered regen values and merged some of them
  * much higher change to get total damage
  * new total damage affix with double value, but low chance

## v0.5.0 - Beta #04 ##
### DGA ###
#### General ####
* Uber mode has been added and can be activated with a scroll crafted at the Blacksmith
* Rewards (Orbs) are now affected by affixes and Character Level
  * A result of that is increased cost to craft affixes and challenge scrolls

#### Drop-Rates ####
* Slightly increased Essence & Soul base drop rates, but added monster classification multiplier. resulting in:
  * common and champion have a lower chance as before
  * heroes have the same chance as before
  * regular bosses have a higher chance as before
  * challenge/endless bosses have a much higher chance
  * nemesis will have a much higher chance than they would have before
  * the average is about the same as before, but with affixes adding bosses or nemesis much better

#### Affixes ####
* Twinned Affix (spawn additional boss) has been fixed
* adjusted chances
* new icons

#### Entities ####
* Nemesis can now spawn, they have a different chance depending on the rank and DGA-Type
  * Mission/Endless: 0% - 10% - 33% - 100%
  * Challenge: 0% - 50% - 100% - 150%
  * You have the option to disable Nemesis spawns at the friendly Ghost
* Nemesis DGA-Affix can be used to increase the number of Nemesis spawned
  * disabled Nemesis spawns don't affect Affixes, you will still spawn additional Nemesis
* Maximum Monster Level is 50 + Tier increases
  * Normal: 50 - Tier 15 on Normal still goes up to 80
  * Elite: 55 - Tier 15 on Elite still goes up to 85
* Champions now require Monster Level 10 to spawn

### Runic Inscriptions ###
#### Blacksmith ####
* cost for Generic Stones have been divided by 10

### Gifts & Treasures ###
#### Blacksmith ####
* It is now possible to craft a random relic for 5/15/25 Planar Scraps

#### Properties ####
* + to All Skills Blacksmith Bonus has replaced cooldown reduction (for pets) prefix
  * +All Skills is now a Prefix (5% chance)
  * mana reg % has taken the place of +All Skill in the Blacksmith Bonuses Pool
* Affix Chances have been rebalanced
* Affixes will roll values in a smaller range (Deviation from 40% to 30%)
* resistances have been reduced by 20%
* exp increases have been increased by 50%

*Note that they are still being balanced and changed frequently, yet another reason why there are currently no new endgame items*

## v0.5.0 - Beta #03 ##
### DGA ###
#### Essence & Souls ####
* Soul drop-rate x3
* Essence drop-rate x3

#### Enemies ####
* added two enemy tags
  * tagEnemyZombieTrollHalfCasterB01=Zombie Mistborn Shaman
  * tagEnemyZombieTrollHalfA01=Zombie Mistborn Brute

#### Quest ####
* added different rewards for steps 2 and 3 (exp for normal/elite, reputation for ultimate)

### Gifts & Treasures ###
#### Properties ####
* Attack Speed, Cast Speed and Movement Speed were using the wrong field
  