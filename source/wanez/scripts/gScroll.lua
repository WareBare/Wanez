--[[
Created by IntelliJ IDEA.
User: WareBare
Date: 8/4/2016
Time: 5:19 AM

Package: wanez
]]--

wanez.scroll = {}
wanez.scroll.fnCall = false

function wanez.scroll.entityOnDie()
    --local aActions = wanez.scroll._Functions[wanez.scroll.fnIndex]()
    local aActions = wanez.scroll.fnCall()
    local _player = Game.GetLocalPlayer()

    if(aActions.GiveItem ~= nil)then
        wanez.giveItems(aActions.GiveItem)
    end
    if(aActions.Notify ~= nil)then
        UI.Notify(aActions.Notify)
    end
    --giveBackScroll(aActions.GiveItem)
end
