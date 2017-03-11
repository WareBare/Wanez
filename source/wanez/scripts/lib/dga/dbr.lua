--[[
Created by IntelliJ IDEA.
User: WareBare
Date: 1/31/2017
Time: 6:04 PM

Package: 
]]--

local function boxTrigger(argObjectId,argAction,argToken)
    local _player = Player.Get(argObjectId)
    if(argAction == 'onEnter') then
        _player:GiveToken(argToken)
    else
        if(_player:HasToken(argToken)) then
            _player:RemoveToken(argToken)
        end
    end
end


wanez.DGA.dbr = {
    onDieCommon = function(argObjectId)
        wanez.DGA.onDie(argObjectId,1)
    end;
    onDieChampion = function(argObjectId)
        wanez.DGA.onDie(argObjectId,2)
    end;
    onDieHero = function(argObjectId)
        wanez.DGA.onDie(argObjectId,3)
    end;
    onDieBossMini = function(argObjectId)
        wanez.DGA.onDie(argObjectId,4)
    end;
    onDieBossDefault = function(argObjectId)
        wanez.DGA.onDie(argObjectId,5)
    end;
    onDieNemesis = function(argObjectId)
        wanez.DGA.onDie(argObjectId,6)
    end;
    onDieBossChallenge = function(argObjectId)
        wanez.DGA.onDie(argObjectId,7)
    end;
    onDieBossRaid = function(argObjectId)
        wanez.DGA.onDie(argObjectId,8)
    end;
    onDieBossSpecial = function(argObjectId)
        wanez.DGA.onDie(argObjectId,9)
    end;
    onEnterTriggerSummonPortal = function(argObjectId)
        boxTrigger(argObjectId,'onEnter','WZ_DGA_ALLOW_PORTAL_DEFAULT')
        --boxTrigger(argObjectId,'onEnter','WZ_DGA_CHALLENGE_START')
        --UI.Notify(argObjectId)
    end;
    onLeaveTriggerSummonPortal = function(argObjectId)
        boxTrigger(argObjectId,'onLeave','WZ_DGA_ALLOW_PORTAL_DEFAULT')
        --boxTrigger(argObjectId,'onLeave','WZ_DGA_CHALLENGE_START')
    end;
    
    boxTrigger_02a = function(argObjectId)
        --UI.Notify('region trigger 2')
        wanez.DGA.boxTriggerRegion(argObjectId,2)
    end;
    boxTrigger_03a = function(argObjectId)
        --UI.Notify('region trigger 3')
        wanez.DGA.boxTriggerRegion(argObjectId,3)
    end;
    boxTrigger_04a = function(argObjectId)
        --UI.Notify('region trigger 4')
        wanez.DGA.boxTriggerRegion(argObjectId,4)
    end;
}
