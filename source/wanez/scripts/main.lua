--[[

Wanez - MOD

table ('namespace'):
wanez.x.y
when x starts with upper-case its a submod of wanez - still requires the main wanez package (wanez.Runes)
when x start with lower-case its a package inside the main wanez package (wanez.scroll)
only classes and array files are using their prefix, packages are a simple lower-case and global function files are considered packages (wanez.scroll._Functions; wanez.scroll.events)

files starting with:
_ - customizable file of the package/mod; has most of the data and settings arrays
p - Package; loads package files (pScroll -> /scroll/x.lua)
g - collection of global function, often the lua hook in dbr or conversations
c - class

submod files are loaded inside the main.lua of the submod

@author: WareBare (warebare89@gmail.com)
@version: 0.1.0

Updated: 08/04/2016

]]

wanez = {}
wanez.isDev = false

--- LOAD FILES
Script.Load("wanez/scripts/data.lua");
Script.Load("wanez/scripts/_Settings.lua");
Script.Load("wanez/scripts/_Data.lua");
Script.Load("wanez/scripts/gMisc.lua");
Script.Load("wanez/scripts/gScroll.lua");

--- LOAD SUB-MODS
Script.Load("wanez-runes/scripts/main.lua");
Script.Load("wanez-dga/scripts/main.lua");
