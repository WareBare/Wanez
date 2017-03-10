# WanezMod v0.5.0 - For GrimDawn #

Unofficial Mod for Grim Dawn. This is the full Mod's source with all of its SubMods. Right now WanezMod is literally just DGA and some additional stuff, but in the future it will have everything in it I am working on (DGA, Masteries, Items, etc.), everything will be available in this mod as some kind of Compilation.

Every part has its own Version, this probably makes it confusing, but I believe it's the best way for others to keep track of updates of the parts they wish to use. If you are just here for Runic Inscriptions than there is no reason to update if the latest version of WanezMod doesn't have an Update for Runic Inscriptions. 

You can check out the Section 'For Modders' to get more information on what you need. You should also check out [my Website for this mod](http://wanez.de/gd/mod/features) to get more information.

`In Progress` You will have to download the full source and use the Mod-Splitter Tool to get the parts you want.

---
## Dynamically Generated Areas ##
### Introduction ###
#### General ####
Entering the game will give you access to everything the dismantle NPC has to offer and in addition normal will give you all inventory bags.

#### Multiplayer ####
In any previous version lots of issues occured in Multiplayer, v0.5 is going to change that as it's fully compatible with Multiplayer!

#### OMEGA MOD removal ####
From the start the plan was to make a mod that can be merged easily with any other mod. Having a complex mod with many files is not going to make it easier for others who only want the source of my mod, so I decided to remove it. Since the source is now available, it's pretty easy to merge it yourself.

In addition my mod will have different ways to improve your character and adding other mods to it will make it more difficult to balance properly.

What this means to you (as a non-DAIL player), if you have any OMEGA items on you, you should place them in your transfer-stash or they will disappear, unless you have merged the mods yourself.


*The guard dbr is in the world and will show up either as the vanilla guard or OMEGA NPC depending on it being merged or not*

### DGA-Items ###
#### General ####
Any item not used anymore is exchanged when you first login for the new ones coming with v0.5, if you don't want that - you can place them in your stash (at least in the non-DAIL version) and they are removed entirely with v1.0.
* Components and Keys will turn into DGA-Orbs
* DGA Essences will turn into DGA-Orbs
* Better DGA items such as Uber Materials will turn into Planar-Orbs
* (Artifact-) Currency will turn into Planar-Scraps
* Souls will turn into Planar-Souls
Anything remaining after this with a "Circle and Cross Icon" can be reported and I'll add it with the next version to be converted.

The goal with these changes is to reduce the amount of different items you have to collect in DGA and give the player more control over what the player wants to do with it.

Some things don't require much to be crafted or at least no specific item, but because it does require something or it won't show up at the blacksmith, you can craft items marked as free with potions.

Starting with v0.5 you'll have the option of enemies having vanilla Loot Tables or the new DGA Loot Tables, certain DGA-Items won't be able to drop in Vanilla-Mode.


*DGA-Items are moved directly into your inventory*

#### DGA-Scrolls ####
* *Replacing the previously known Tier-Components and Tier-Keys*
* DGA-Scrolls will drop directly, there is no need to craft them
* two different kinds of DGA-Scrolls are available
  * Regular (can open Mission, Challenge and Raid DGA)
  * Endless (can open Endless DGA)
* Some of them can be crafted, removing the requirement to find them
  * Tier 0 for Regular Scrolls and Endless Scrolls can be crafted at the Blacksmith
  * Tier 1-15 in Normal/Elite for Regular Scrolls can be crafted at the Blacksmith
* using a DGA-Scroll inside the Summoning-Circle will open a Portal to the new Area
  * using a Scroll will randomly choose the Area it leads to
  * it is possible to predetermine the Area chosen by using a different Scroll
* Ultimate only: using the Scroll outside the Summoning-Circle will give the player a DGA-Orb
* Drop-Rates
  * Rather than each Enemy being able to drop DGA-Scrolls, you need to kill the entire pack to get the chance on a Drop
  * Common Enemy Packs cannot drop DGA Scrolls
  * Champion Enemy Packs can drop Tier +0 DGA Scrolls
  * Heroes/Mini-Bosses can drop Tier +1 DGA Scrolls
  * Bosses/Nemesis can drop Tier +2 DGA Scrolls
  * Any lower Tier DGA-Scroll can drop
  * *eg. Killing a Hero Pack in a Tier 9 DGA has the chance of dropping DGA-Scrolls between Tier 1 and 10*

#### Area-Scroll ####
* You can set the Area for the next DGA-Scroll you are using
* This information will not last until the next session
* When you set an Area, but don't have the quest or use the right scroll that can lead to it, the Area-Scroll was wasted as the value is reset with every DGA-Scroll use
  * Using a Scroll leading to an Area exclusive to Endless and not using an Endless DGA Scroll will reset that value and it's lost

#### DGA-Orb ####
DGA-Orbs can be obtained by using regular DGA-Scrolls outside the Summoning-Circle for Portals and only in Ultimate, this way you can use lower Tiers to create DGA-Orbs required to craft a variety of DGA-Items:
* Uber-Scrolls to gain access to Uber Mode
* Quest-Scrolls (eg. for Challenges)
* Affix-Scrolls

The number of DGA-Orbs you get depends on the DGA Scrolls's Tier:
  * Tier 1 will give you 1 DGA-Orb
  * Tier 10 will give you 10 DGA-Orbs
  * ...

You can also get DGA-Orbs in Normal/Elite by completing DGA-Type Quests (Missions, Endless, Challenge, Raids) or by finding a chest in any Difficulty.

*Orbs are crafting items and therefore not tradable or placable in your transfer stash*


#### Souls & Essences ####
* You can only find them with Default/Vanilla-Mode disabled and they come in three different power levels:
  * Lesser Souls & Essences (starting in Normal/Elite)
  * (Medium) Souls & Essences (starting in Ultimate)
  * `Greater Souls & Essences (starting in Raids with v0.6)`
* They can be used to buy:
  * Vanilla Materials (such as Scraps, Blood, etc ...)
  * Vanilla Components
  * new Materials used for new Items (Gifts & Treasures)
  * upgrading new Items
* Souls can be obtained by killing any enemy, while Essences can only be obtained from more powerful enemies
* They are tradable and can be placed inside your transfer stash

### DGA Types ###
#### General ####
DGA-Tiers do not increase DGA-Scroll Drop-Rates, only DGA-Difficulties and DGA-Affixes do, but DGA-Tiers increase the Drop-Rate of Souls, Essences and Orbs.

Difficulties Normal and Elite don't require you to find an item to open a portal, you can craft Tiers 1 to 15 at the Blacksmith for Iron Bits and a Potion. Normal and Elite also stop increasing their Monster Level at 60. The difference between the two difficulties is that you will receive more Iron Bits/Orbs in Elite and Quests will grant much more XP than in Normal. Ultimate requires you to find DGA-Scrolls to access higher DGA-Tiers and only Tier 0 can be crafted at the Blacksmith.

#### DGA Tiers ####
* Tiers will increase Monster Level by:
  * 1 additional Monster Level for Tiers 1 - 5
  * 2 additional Monster Levels for Tiers 6 - 10
  * 3 additional Monster Levels for Tiers 11 - 15
  * this adds up to +30 Monster Level at Tier 15 (rather than the previous +15 at Tier 15)
  * and +105 Monster Level at Tier 30.
  * Endless DGA work a little different, but more about that later
* All difficulties now have 30 Tiers available and Normal/Elite doesn't require drops to craft the higher Tiers
* 3% more Essences/Souls/Orbs per Tier
* Tiers have no influence on DGA-Scroll Drop-Rates

#### Mission ####
* Using a regular DGA-Scroll will grant you a random Mission if you don't have an active Challenge or Raid
* The Area will be opened for the DGA-Type you are having the Quest for at the time of using your DGA-Scroll
* You can obtain Mission Orbs on Ultimate

#### Endless ####
Endless will not follow the regular DGA-Tier mechanics, but instead increase Monster Level by one with every round. Whether you want to increase the Monster Level or not can be decided at the end.


* Defeating Endless Boss can result in giving you an "Endless DGA-Scroll" of the Tier Range you are in
  * Monster Level 7 will give you an "Endless DGA Scroll (T 6)" (ML 19 would be T12)
* Using the Scroll will open the Portal for that Tier (and the lowest Monster Level for that Tier)
* For the time being you can get scrolls up to Tier 30 (ML +105... good luck getting there I guess)
* You can obtain Endless Orbs on Ultimate

#### Challenge ####
* Challenges have stronger monster than Missions and Endless
* You can craft a Quest-Scroll at the Blacksmith for DGA-Orbs
* To avoid confusion only the Blacksmith in Ultimate can make them for you, but they are usable in any difficulty
  * Because Challenges are balanced around Ultimate and you can finish them faster in Ultimate than in Normal/Elite, they have caused more frustration to newer players than joy
* Challenges will either use regular maps (used by missions) or a new map (created for that Challenge)
* You can obtain Challenge Orbs on Ultimate


*The old "Special: Rift" is now a Challenge*

#### Raid (coming with v0.6) ####
* `Only available in Ultimate Difficulty`
* `Type-Orbs are used to craft Raid-Quests`
  * `Mission-Orb + Endless-Orb = Challenge-Orb`
  * `Mission-Orbs can be converted to Endless-Orbs and Endless to Mission`
  * `Challenge-Orbs are used directly to craft Raid Quest-Scrolls and the amount required may vary`
* `You will also need DGA-Orbs`
* `The Portal can be opened by using a regular DGA-Scroll while having an active Raid Quest`

#### Uber ####
* Uber will show up as a Quest and is removed when you open the next Portal.
* Uber Quest-Scrolls can be crafted at the Blacksmith for DGA-Orbs
* Challenges and Raids require more DGA-Orbs than Missions/Endless

#### Bosses ####
The Boss can be found in a new Area, this allows me to add more features in the future and makes certain DGA-Types less prone to bugs. Inside that room you will find the Boss and a Portal back to the Encampment. The old Portal Scrolls have been removed as well, so if you want to get out of an Area you need to get to the Boss Room and use the Portal in there.

Endless and Challenges will use this room to show you the Portal for your next area after you have killed a Boss (Endless) or Mini-Boss (Challenge). The Portal back to the camp is also available.

### DGA-Affixes ###
#### General ####
It is possible to make DGA more challenging and increase Drop-Rates - you may have as many as you like or you can afford.

#### Details ####
DGA-Affixes will show up as quests and are being removed when you use a scroll to open the portal, therefore it will only affect the area the scroll was used for.

Quests are granted by a Scroll and it is possible to craft a random scroll at the Blacksmith or to find them.

#### Drop-Rate ####
The following items are being affected by drop-rate increases from DGA Affixes:
* DGA Scrolls - if you want to reach higher tiers or sustain that tier you should probably use DGA-Affixes
* Souls & Essences

Increases are being added up and multiplied with the base drop-rate (eg. Base Drop-Rate of a DGA Scroll could be 5% and you have three different affixes giving 10%/25%/30%, this will result in 5% * 65% = 8.25%)

#### `new` Affix Types ####
* Type (I): Increase Monster Count
* Type (II): Buff Monsters

### Enemies ###
#### General ####
I added enemies to the tool's functionality, this means I can change data across all files or pick a certain file to change values easily, also every time there is a new Grim Dawn update I can update them aswell. This results in more features that would have been tedious and not worth the time. It also means more customization options for players and up to date enemy files.

#### Loot & Drop ####
You can choose to play a "Vanilla-Mode", it means monsters will have their vanilla Loot Tables with their vanilla Drop-Rates (or any changes made to vanilla files from other Mods). This Mode is only available in Normal DGA-Difficulty. If you just want a different endgame experience to vanilla areas, you can choose "Vanilla-Mode" and you will get the same items and nothing that would enable any of the new features (eg. Gifts & Treasures).

*I am giving the option of removing worthless items, because I cant just remove them from the ground, you would have to start a new Session if you are doing the same area multiple times and this is defeating the purpose of this Mod.*


Any other DGA-Difficulty will ignore "Vanilla-Mode" and use the DGA Loot Tables and Drop-Rates, if "Vanilla-Mode" is going to be more popular and requested to be part of more DGA-Difficulties I will make it happen, the reason why I don't, is because it will increase the file size for no good reason. Vanilla Legendaries are still dropping in every DGA-Difficulty and the only thing missing are rares, but instead monsters are dropping Souls & Essence which can be used to buy Scraps, Components and other Vanilla Crafting Materials.

#### Nemesis ####
* They are dropping a Destructible Orb like Heroes and Bosses (in Vanilla).

#### Mini Boss ####
* A Mini Boss is basically a quest monster marked as a Hero from the main campaign
* `they will now spawn a different Destructible Orb on death than Heroes and have increased stats (with v0.5.x)`
* Their purpose in DGA is to trigger several new events

### Monster Power ###
#### Introduction ####
Starting with v0.5 you will have the option of making monsters more powerful and certain DGA-Types will inherently have stronger monsters. I'm starting with increasing Enemy Defense and Enemy Offense equally, this may change over time.


*200% Monster Power = 2x Damage/Defense*

*Reflect has not been adjusted, so keep an eye out for it*

#### Difficulties ####
Im going to start with 4 different difficulties, I believe this is enough for now. I don't want to go completely crazy from the start.
* Casual
  * Portal will stay until a new one is opened (you may re-enter the map when you die)
  * 10% less DGA Scrolls
  * 100% Power Level
* Normal
  * 100% Power Level
* Hard
  * 20% more DGA Scrolls
  * 125% Power Level
* Elite
  * 50% more DGA Scrolls
  * 150% Power Level


*Vanilla-Mode is only playable in Normal DGA-Difficulty*

*Power Level describes how hard monsters are in comparison to vanilla monsters*

#### Modes ####
Having just two here is plenty, since it doubles the possible choices for the player.
* Standard/Normal/Default (call it what you like)
  * Standard is the Default, as long as you don't have Uber active (via Quest) this is what you get
  * as a result, it doesn't increase drop rates or Monster Power
* Uber
  * 100% more DGA Scrolls
  * 100% more Power Level

#### Inherited Monster Power ####
The different types will have three different levels of power for monsters, you cannot influence this part, it is what it is depending on the DGA Type you are doing. Inherited Monster Power does not increase DGA-Scroll drop-rates.
* Mission & Endless are the same when it comes to monsters
  * doesn't increase drop rates or Monster Power
* Challenges will spawn stronger monsters
  * 20% increased Power Level
* Raids will spawn even stronger monsters than challenges
  * 66% increased Power Level

#### Conclusion ####
You can choose between
* Standard - Casual/Normal/Hard/Elite - Mission & Endless
  * Monster Power - 100%/100%/125%/150%
* Uber - Casual/Normal/Hard/Elite - Mission & Endless
  * Monster Power - 200%/200%/250%/300%

#### Examples ####
* Standard - Normal - Mission
  * Monster Power: 100%
* Standard - Elite - Mission
  * Monster Power: 150%
  * +50% DGA Scrolls
* Uber - Normal - Mission
  * Monster Power: 200%
  * +100% DGA Scrolls
* Uber - Normal - Challenge
  * Monster Power: 240%
  * +100% DGA Scrolls
* Standard - Normal - Raid
  * Monster Power: 166%
* Uber - Elite - Raid
  * Monster Power: 498%
  * +200% DGA Scrolls
  * I hope none is able to actually do this or I have to add more Difficulties


*And lets not forget the different Tiers, increasing Monster Level. Tier 15 (+30 to Monster Level) Uber Raid on Elite sounds rough*

### Shrines & Pylons ###
#### General ####
* An Obelisk that grants a buff to the player and party members around
* Duration may vary depending on your Reputation with the Planes-Shifters

#### `updated` Shrines ####
* Shrine effects last 1 minute
  * up to 5 minutes at revered
* Current Shrines in the Mod
  * Shrine of Enlightenment (150% Exp)
  * Shrine of Fleeting (50% Movement Speed)
  * Shrine of Celerity (25% Attack Speed, 25% Casting Speed)
  * Shrine of Quickening (25% Cooldown Reduction, 25% Mana Cost Reduction)
  * Shrine of the Giant - 25% Health; 25% Energy
  * Shrine of Trollblood - 25% Health Regeneration; 15 Health Regeneration; 25% Energy Regeneration; 10 Energy Regeneration
  * Shrine of Precision - 100 Offensive Ability; 25% Offensive Ability
  * Shrine of Avoidance - 100 Defensive Ability; 25% Defensive Ability
  * Shrine of Protection - 25% Armor; 25% Absorption
  * Shrine of Power - +500% All Damage
  * Shrine of Resistance - +5 to all Maximum Resistances
  * Shrine of Force - 50% reduced reflective damage taken

## Factions ##
### DGA-Factions ###
#### Planar Invaders ####
* Hostile Faction
* Spawns Nemesis in DGA

#### Planes-Shifters ####
* Friendly Faction
* `Access to Bounty-Table in DGA (moved to v0.5.x)`

## Runic Inscriptions ##
### General ###
#### Introduction ####
* Runic Inscriptions come in different sets
* Runes of the same Set can be combined to create Inscriptions
* New Items: "Equipment-Stones", "Rune-Scrolls", "Rune-Components", "Inscriptions", ...

#### Runes ####
* Different Rarities (or Tiers)
* Two different types of runes (Scrolls & Components)
* Rune-Scrolls
  * Usable Item (Scroll) to create "Rune-Components" and "Inscriptions"
  * Can be crafted at the Blacksmith or found
* Rune-Components
  * Component
  * Come in different tiers

#### Stones ####
* Usable Item (Scroll)
* Craftable at the Blacksmith
* `White items can be salvaged into Scraps with a new item or at the NPC (amount depends on Item Level) [with v0.5.x]`
* Stones can be crafted with scraps
* Stones have Rune-Sockets and since Inscriptions are inheriting the consumed Runes' stats, the more sockets a stone has the harder it is to obtain it

#### Inscriptions ####
* Augments
* Different Rarities (or Tiers)
* require a Stone and a Runic-Sequence to be created

#### Runic Sets ####
This has nothing to do with set bonuses, it simply means these are different types of runes. Only Runes from the same set can be used to create an Inscription
* Runic Combination (removed)
* Runic Empowerment
  * Craftable at a Blacksmith
  * Aether Crystals can be used with a Component to make a Rune
  * The Rune inherits all properties from the Component with increased values (basically the same Component for a higher level)
  * 5 Different Tiers are available (Required Levels: 75, 77, 79, 81, 83)
* `Runic Creation (with v0.5.x)`
  * `No Crafting required, need to find the Rune-Scroll directly`
  * `No Base Components, the Rune has entirely new stats and its signature skill`
  * `The Rune-Scroll can only be obtained in DGA`

#### Runic-Sequence ####
A quick Tutorial on "How to create an Inscription"
* Use an Equipment-Stone to initiate a new Sequence
* You can choose between two different Stones
  * if you are not sure what weapon is possible you can use a Generic Weapon Stone *this cannot result in Tiers higher than 1*
  * if you know exactly what weapon it is, you can use a Specific Weapon Stone (eg. 1H Axe Stone) *this can result in the highest Tier available for that Inscription*
* Use a Rune-Scroll to add Runes to the Sequence
* Use more Rune-Scrolls to add more Runes to the Sequence
* once the number of Runes [used] matches the number of Sockets [of the Stone] it will either fail or succeed in creating an Inscription
  * It will only succeed if the Runes were used in the correct order

#### `new` Lore ####
* You can find Lore Pages to help you figure out the Sequence used to create an Inscription
* They drop from Bookstands
* They also grant Experience like Lore from the Main Campaign

## Gifts & Treasures ##
### New Items ###
#### Planar Essences & Planar Souls ####
Already mentioned in the DGA Section, but they are still relevant here, because you can only exchange them for something useful at the Blacksmith for Gifts & Treasures. You can buy a variety of Vanilla Materials/Components with them and new items used to craft new Items.

#### Planar Scraps ####
* Crafted from
  * Scraps
  * Planar Essence
  * Planar Soul
* Used for
  * Leveling-Gear
  * `Upgrading Planar Sets [v0.5.x]`
  * `Upgrading Artifact dropping in DGA [v0.5.x]`

### Leveling Gear ###
#### How To Obtain ####
* Planar Souls and Planar Essences can be used to get Planar-Scraps
* Craftable at the Blacksmith

#### What Is Special About It ####
* New pool of Affixes (similar to other ARPGs)
  * Prefix with 1-3 Random properties
  * Suffix with 1-3 Random properties
* Has a new pool of Blacksmith bonuses
* Base item has a useful property
  * eg. Gloves could roll Cast Speed or Attack Speed
* Variations
  * higher armor with a physique requirement
  * lower armor with a spirit requirement
  * weapons with different attack-speed and min/max damage rolls
  * accessories with different rolls useful to different builds (eg. cooldown reduction)
  * a variety of pet-bonuses

*this is still the first version of them, they'll be adjusted depending on the feedback*

#### The Goal ####
* Good rolls should be fairly easy to obtain in lower levels, but more difficult in higher levels
* the first character will have trouble getting these items right away, but farming essences/souls with a higher level character will make leveling alternate characters easier
* no need to hoard anything, you can easily craft good enough gear if you have the souls/essences for it

### Planar Sets (with v0.5.x) ###
#### Why The Delay ####
Still unsure how the player can obtain them and all other details about them. Instead of changing it later when everyone has gotten them in an easier/harder way I prefer to delay it until I have these things figured out, but its not going to be that long, probably somewhere between v0.5.2 and v0.5.4.

### Artifacts (with v0.5.x) ###
#### Why The Delay ####
I know every little detail on how I want them to work, but it is still work for at least two weeks and the last update for DGA has been such a long time ago, that I decided to work on Artifacts after that. You'll probably see them somewhere between v0.5.2 and v0.5.6.

## For Modders ##
### Database ###
The directories currency, scroll and faction are used globally, so you'll need those as well as the directory with the _ (underscore) prefix. However some items may not be able to drop/craftable unless you add them to vanilla or your own LootTables/Blacksmiths.

### Source ###
With the exception of Tags, everything is inside the "wanez" directory.

*This is all for now, I'll eventually write a full tutorial on this.*

## Credits ##
### Contributors ###
#### alexei ####
* reworked old maps
  * Canyon
  * Forest: Hills
  * Dungeon
* new Regular Maps
  * Planes of Agony

#### Zaknafein ####
* Regular Maps
  * Bone Pit Sanctuary
  * King Temple
  * Inferno
  * Torture Chamber

#### hawk4me ####
* Regular Maps
  * Island of Woe

#### `updated` Special Thanks To ####
* PrincessLuna for providing a solution to "de-spawn" monsters, when I started this project
* The ones alpha testing v0.5.0 for Multiplayer
* AlienFromBeyond for having the idea of adding "Rune Lore" to help figure out unknown Inscriptions

### Graphics ###
#### Bitmaps ####
* various Icons made by {Lorc;Delapouite}. Available on [http://game-icons.net](http://game-icons.net "Link to the Site") - I have made some changes to them (I will list all changes and the name of the items using it later)

### Mods Included ###
#### Stasher v5 ####
* Started by rorschachrev and using an updated version by tt300

#### Good-looking MOD ####
* by Grim Dawg
* The NPC is in the Planes-Shifters Encampment