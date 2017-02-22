--[[
Created by IntelliJ IDEA.
User: WareBare
Date: 2/21/2017
Time: 6:56 PM

Package: 
]]--

local _cSequence = false

---
-- called when a stone (scroll) is used - will start a new sequence for runes to be added
-- @param argType (str) - accessory, armor, weapon1h, weapon2h
-- @param argSlot (str) - ring, amulet, ...
-- @param argSockets (int) - number of sockets
--
function wanez.Runes.startSequence(argType,argSlot,argSockets)
    _cScroll = wanez.cScroll({
        notify = "tagWzRunes_LuaNotify_startSequence_failure";
    },
        function(self)
        local aActions = {
            giveItems = "mod_wanez/_runes/items/stones/stone_"..argType.."_"..argSlot..self:parseIntToString(argSockets,1)..".dbr";
        };
        
        if(_cSequence == false)then
            _cSequence = wanez.Runes.cSequence(argType,argSlot,argSockets)
        end
        
        return aActions
    end)
end

---
-- called when a rune (scroll) is used, the rune will be added to an existing sequence or if no sequence is set return the rune itself with stats
-- @param argRuneType (str) - RuneA, RuneB
-- @param argRuneId (int) - rune ID
-- @param argRuneMaxTier (int) - max Tier the rune can roll
--
function wanez.Runes.useRune(argRuneType,argRuneId,argRuneMaxTier)
    _cScroll = wanez.cScroll({
        notify = "tagWzRunes_LuaNotify_useRune_failure";
    },
        function(self)
        local aActions = {
            giveItems = "mod_wanez/_runes/items/materia/"..argRuneType.."_"..self:parseIntToString(argRuneId,2)..".dbr";
        };
        
        if(_cSequence)then
            -- sequence is set, try to create an inscription
        else
            -- no sequence is set, return a rune (comp) with random tier
            local aTiers = {}
            for i=1,argRuneMaxTier do
                table.insert(aTiers,wanez.Runes.aData.tierWeights[i])
            end
            local tierLetter = self:RNG({
                aDataRatio = aTiers
            })
            aActions.giveItems = "mod_wanez/_runes/items/materia/"..argRuneType.."_"..self:parseIntToString(argRuneId,2)..tierLetter..".dbr"
            aActions.notify = "tagWzRunes_LuaNotify_useRune_Tier"..tierLetter.."_success"
        end
    
        return aActions
    end)
end
