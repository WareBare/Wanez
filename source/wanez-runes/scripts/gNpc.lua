--[[
Created by IntelliJ IDEA.
User: WareBare
Date: 8/4/2016
Time: 11:43 AM

Package: 
]]--

wanez.Runes.npc = {}

function wanez.Runes.npc.summonNPC01()
    wanez.scroll.fnCall = function()
        local aActions = {
            ['GiveItem']= 'mod_wanez/_runes/misc/scroll_summon_npc01.dbr',
            ['Notify']='Summon Scribe'
        }
        return aActions;
    end
end;
function wanez.Runes.npc.summonNPC02()
    wanez.scroll.fnCall = function()
        local aActions = {
            ['GiveItem']= 'mod_wanez/_runes/misc/scroll_summon_npc02.dbr'
        }
        return aActions;
    end
end;

function wanez.Runes.npc.giveItems()
    local _player = Game.GetLocalPlayer()
    local aItems = {
        'mod_wanez/_runes/misc/scroll_summon_npc01.dbr',
        'mod_wanez/_runes/misc/scroll_summon_npc02.dbr',
        'mod_wanez/_runes/misc/scroll_salvage_common.dbr'
    }
    local dbr = false

    for i=1,table.getn(aItems) do
        dbr = aItems[i]
        if not(_player:HasItem(dbr,1,true))then _player:GiveItem(dbr,1,true);end;
    end;

    _player:GiveItem('records/items/gearweapons/caster/a02_scepter007.dbr',1,true)
    _player:GiveItem('records/items/gearweapons/shields/a04_shield01.dbr',1,true)
    _player:GiveItem('records/items/gearshoulders/a09_shoulder02.dbr',1,true)
    _player:GiveItem('records/items/gearaccessories/medals/a005_medal01.dbr',1,true)


end
