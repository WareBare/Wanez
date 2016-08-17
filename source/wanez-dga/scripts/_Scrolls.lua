--[[
Created by IntelliJ IDEA.
User: WareBare
Date: 8/15/2016
Time: 2:20 AM

Package: 
]]--

wanez.dga._Scrolls = {};

function wanez.dga._Scrolls.usePortalHideout()
    wanez.scroll.fnCall = function()
        local aActions = {}

        aActions.GiveItem = 'mod_wanez/_dga/items/misc/scroll_portal_hideout.dbr'
        
        if(wanez.dga.Settings:getAreaID() > 0 and wanez.dga.Settings:getSpawnTrigger() == false) then
            wanez.dga.RiftHO:actionPortal()
        else
            aActions.Notify = "tagWaDGA_ScriptNotify_ScrollHideoutUnusable"
        end
        
        return aActions;
    end
end
