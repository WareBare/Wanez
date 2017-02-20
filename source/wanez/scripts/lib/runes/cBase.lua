--[[
Created by IntelliJ IDEA.
User: WareBare
Date: 2/18/2017
Time: 6:20 AM

Package: 
]]--

function wanez.Runes.cBase()
    local _parent = wanez.cBase()
    
    local class = {
        __constructor = function(self)
            --UI.Notify("cSettings instance")
        end;
    }
    
    setmetatable(class,{__index = _parent})
    class:__constructor()
    return class
end