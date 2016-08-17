--[[
Created by IntelliJ IDEA.
User: WareBare
Date: 8/4/2016
Time: 11:43 AM

Package: 
]]--

wanez.Runes.npc = {}

local function file_check(file_name)
    local file_found=io.open(file_name, "r")

    if file_found==nil then
        file_found=file_name .. " ... Error - File Not Found"
    else
        file_found=file_name .. " ... File Found"
    end
    return file_found
end

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
    aItems = {
        'mod_wanez/_runes/items/misc/stone_torso_generic_03.dbr',
        'mod_wanez/_runes/items/misc/stone_torso_heavy_03.dbr',
        'mod_wanez/_runes/items/materia/runea_001.dbr',
        'mod_wanez/_runes/items/materia/runea_002.dbr',
        'mod_wanez/_runes/items/materia/runea_003.dbr',
        'mod_wanez/_runes/items/materia/runea_004.dbr',
        'mod_wanez/_runes/items/materia/runea_005.dbr',
        'mod_wanez/_runes/items/materia/runea_006.dbr'
    }

    for i=1,table.getn(aItems) do
        dbr = aItems[i]
        if not(_player:HasItem(dbr,1,true))then
            _player:GiveItem(dbr,1,true)
        end
    end;
    --UI.Notify('items given!')
    _player:GiveItem('mod_wanez/_dga/items/misc/essence_002a.dbr',20,true)
end
