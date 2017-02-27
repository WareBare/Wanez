# Changelog #
You can also check out an [online changelog](http://wanez.de/gd/mod/updates).

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
  