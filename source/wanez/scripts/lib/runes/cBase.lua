--[[
Created by IntelliJ IDEA.
User: WareBare
Date: 2/18/2017
Time: 6:20 AM

Package: 
]]--

local gInscriptions = wanez.data.gInscriptions

function wanez.Runes.cBase()
    local _parent = wanez.cBase()

    local runeType = false
    local aInscriptions = false
    
    
    local class = {
        __constructor = function(self)
        end;
        __setInscriptionsData = function(self,argRuneType,argOverride)
            argOverride = argOverride or false
            if(aInscriptions == false or argOverride == true) then aInscriptions = gInscriptions[argRuneType] end
        end;
        __getInscriptionsData = function(self)
            return aInscriptions
        end;
        __setRuneType = function(self,argRuneType,argOverride)
            local isSameType = true
            if(runeType == false or argOverride == true) then
                runeType = argRuneType
                aInscriptions = self:__setInscriptionsData(runeType)
            end
            if(runeType ~= argRuneType) then isSameType = false end
            
            return isSameType
        end;
    }
    
    setmetatable(class,{__index = _parent})
    class:__constructor()
    return class
end
