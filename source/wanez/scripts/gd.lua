--[[
Created by IntelliJ IDEA.
User: WareBare
Date: 4/25/2017
Time: 2:32 PM

Package: 
]]--

wanez.gd = {};
local _cBase = wanez.cBase()

local entityNames = {
    'manticore',
    'spidergiant',
    'waspgiant',
    'slith',
    'vulture'
}
local aLetterEquiv = {'a','b','c','d','e','e','e','e','e','e','e','e','e','e','e','e'}
local timeSinceLastKill = Time.Now()
local killRating = 0
local aRewards = {1,2,5,10,25,25,25,25,25,25,25,25,25,25}
local usedProxy = {}
local createProxy = false
local _trigger = false
local aProxyToken = {
    [1] = "WZ_GD_ENEMY_COUNT_01",
    [2] = "WZ_GD_ENEMY_COUNT_02",
    [3] = "WZ_GD_ENEMY_COUNT_03"
}

local entityToDestroy = false
local coordsChester = false
function wanez.gd.setChesterCoords(argObjectId)
    local entity_ = Entity.Get(argObjectId)
    coordsChester = entity_:GetCoords()
    
    entityToDestroy = entity_;
end
local canCraftRunes = true
function wanez.gd.onAddToWorldCrafterGear(argObjectId)
    local dbr;
    if(canCraftRunes) then
        dbr = "mod_wanez/_gear/creatures/npcs/blacksmith_leveling0".._cBase:getFactionRank("USER14")..".dbr"
        canCraftRunes = false
    else
        dbr = "mod_wanez/_runes/creatures/npcs/blacksmith_runes001a.dbr"
        canCraftRunes = true
    end
    
    local crafter_ = Entity.Create( dbr )
    crafter_:SetCoords(coordsChester)
    
    entityToDestroy:Destroy()
    entityToDestroy = crafter_;
end

local function spawnPlanarInvader(argObjectId,argClassId)
    if(Game.GetLocalPlayer():HasToken("WZ_DGA_NO_PHASING") == false)then
        --UI.Notify("working spawn")
        local randomSpawnClass = aLetterEquiv[random(1,argClassId)]
        local randomEntityType = random(1,5)
        local enemyCoords = Entity.Get(argObjectId):GetCoords()
        if(random(1,100) <= 20) then
            --UI.Notify('should spawn')
            local newEnemy = Character.Create('mod_wanez/_campaign/creatures/enemies/phasing_'..entityNames[randomEntityType]..'_'..randomSpawnClass..'01.dbr',Game.GetAveragePlayerLevel() + argClassId,nil)
            newEnemy:SetCoords(enemyCoords)
            --UI.Notify('spawned Planar Invader')
        end
    end
end
function wanez.gd.spawnPlanarInvader(argObjectId,argClassId)
    --UI.Notify("working spawn global")
    spawnPlanarInvader(argObjectId,argClassId)
end

--- onDie events
local function onDieEntity(argObjectId,argClassId)
    
    --UI.Notify("working onDie")
    if(killRating == 0) then
        --math.randomseed(Time.Now());
    end
    if( (Time.Now() - timeSinceLastKill) <= 10000 ) then -- 10 seconds between kills or reset killRating
        killRating = killRating + aRewards[argClassId];
        --UI.Notify('add to Rating')
        if(killRating <= 25) then
            -- spawn common
            spawnPlanarInvader(argObjectId,1)
        elseif(killRating >= 25) then
            -- spawn champion
            spawnPlanarInvader(argObjectId,2)
        elseif(killRating >= 100) then
            -- spawn hero
            spawnPlanarInvader(argObjectId,3)
        elseif(killRating >= 300) then
            -- spawn nemesis
            spawnPlanarInvader(argObjectId,4)
        elseif(killRating >= 500) then
            -- spawn boss
            spawnPlanarInvader(argObjectId,5)
            UI.Notify("tagWzCampaingLua_SpawnBoss")
        end
    else
        --UI.Notify('reset Rating')
        killRating = aRewards[argClassId];
        math.randomseed(Time.Now());
        UI.Notify("tagWzCampaingLua_TimeHasRunOut")
    end
    
    timeSinceLastKill = Time.Now()
    --UI.Notify("working onDie")
end
function wanez.gd.onDieEntity(argObjectId,argClassId)
    --UI.Notify("working global")
    onDieEntity(argObjectId,argClassId)
end

--- move trigger to new location
function wanez.gd.proxyTriggerOnLeave()
    --UI.Notify('onLeave')
    _trigger:SetCoords(Game.GetLocalPlayer():GetCoords())
    --UI.Notify('move trigger')
end
--- create new proxies
function wanez.gd.proxyTriggerOnInside()
    --UI.Notify()
    local noProxyCreated = true
    --UI.Notify('onInside')
    
    if(createProxy) then
        for key,value in pairs(createProxy) do
            --UI.Notify('onInside - create')
            if(value and noProxyCreated) then
                local _proxy = Proxy.Get(key)
                local dbr = _proxy:GetName()
                local newDBR = dbr:gsub(".dbr","_clone.dbr")
                local _newProxy = false;
                
                for number,token in pairs(aProxyToken) do
                    if(Game.GetLocalPlayer():HasToken(token)) then
                        for i=1,number do
                            _newProxy = Proxy.Create(newDBR)
                            _newProxy:SetCoords(_proxy:GetCoords())
                            --createProxy[key] = value + 1
                        end;
                        
                    end
                end;
            
                if(_newProxy == false) then
                    _proxy:Run()
                    --createProxy[key] = false
                else
                    if(Game.GetLocalPlayer():HasToken("WZ_GD_ENEMY_COUNT_0"..value)) then createProxy[key] = false;end;
                end
                createProxy[key] = false
                noProxyCreated = false
                usedProxy[key] = true
            end
        end;
    
        if(noProxyCreated)then
            createProxy = false
            --UI.Notify('reset trigger')
            --if(_trigger) then _trigger:Destroy() end
            --_trigger = false;
            --wanez.gd.proxyTriggerOnLeave()
        end
    end
    
    if(noProxyCreated) then
        --if(_trigger) then _trigger:Destroy() end
        --_trigger = false;
        wanez.gd.proxyTriggerOnLeave()
        UI.Notify('reset trigger')
    end
    
end

function wanez.gd.cloneProxy(argObjectId)
    
    local _proxy = Entity.Get(argObjectId)
    
    if usedProxy[argObjectId] ~= true then
        local dbr = _proxy:GetName()
        local newDBR = dbr:gsub(".dbr","_clone.dbr")
    
        if(Game.GetLocalPlayer():HasToken("WZ_GD_ENEMY_COUNT_02")) then
            local newProxy = Entity.Create(newDBR)
            newProxy:SetCoords(_proxy:GetCoords())
        end
        if(Game.GetLocalPlayer():HasToken("WZ_GD_ENEMY_COUNT_03")) then
            local newProxy = Entity.Create(newDBR)
            newProxy:SetCoords(_proxy:GetCoords())
        end
    
        usedProxy[argObjectId] = true
    end
    
    --if(_trigger == false)then
        --_trigger = Entity.Create("records/proxies/trigger_proxy.dbr")
        --_trigger:SetCoords(Game.GetLocalPlayer():GetCoords())
        --UI.Notify('createTrigger')
    --end
    
    --if usedProxy[argObjectId] ~= true then
        --createProxy = createProxy or {}
        --createProxy[argObjectId] = 0
        --UI.Notify('cloneProxy')
        
        --UI.Notify('Proxy trigger is working');
        --UI.Notify(dbr); -- :gsub('.dbr','_clone.dbr')
        --UI.Notify(newDBR);
        --_proxy:Run();
    
        
        --_proxy:Destroy()
        --UI.Notify('Proxy trigger is working');
    
        --usedProxy[argObjectId] = true
    --end
end

function wanez.gd.clonedProxy(argObjectId)
    --local _proxy = Proxy.Get(argObjectId)
    
    --_proxy:Destroy();
    --UI.Notify('Cloned Proxy trigger is working')
end


--- DBR Hooks
function wanez.gd.onDieCommon(argObjectId)
    onDieEntity(argObjectId,1);
end
function wanez.gd.onDieChampion(argObjectId)
    onDieEntity(argObjectId,2);
end
function wanez.gd.onDieHero(argObjectId)
    onDieEntity(argObjectId,3);
end
function wanez.gd.onDieQuest(argObjectId)
    onDieEntity(argObjectId,4);
end
function wanez.gd.onDieBoss(argObjectId)
    onDieEntity(argObjectId,5);
end

local function onDieBeast(argObjectId,argClassId)
    -- todo
    -- rune drops
    -- artifact scroll drops
    -- artifact base item drops
end

function wanez.gd.onDieCommonBeast(argObjectId)
    onDieBeast(argObjectId,1)
end
function wanez.gd.onDieChampionBeast(argObjectId)
    onDieBeast(argObjectId,2)
end
function wanez.gd.onDieHeroBeast(argObjectId)
    onDieBeast(argObjectId,3)
end
function wanez.gd.onDieNemesisBeast(argObjectId)
    onDieBeast(argObjectId,4)
end
function wanez.gd.onDieBossBeast(argObjectId)
    onDieBeast(argObjectId,5)
end
