--[[
Created by IntelliJ IDEA.
User: WareBare
Date: 2/21/2017
Time: 7:02 PM

Package: 
]]--

function wanez.Runes.cSequence(argType,argSlot,argSockets)
    local _parent = wanez.Runes.cBase()

    local gearType;
    local gearSlot;
    local numberSockets;

    local class = {
        __constructor = function(self)
            --UI.Notify("cSettings instance")
        end;
    }
    
    setmetatable(class,{__index = _parent})
    class:__constructor()
    return class
end
