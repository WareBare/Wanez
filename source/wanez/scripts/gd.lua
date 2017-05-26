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
    'slith',
    'spidergiant',
    'waspgiant',
    'vulture'
}
local aLetterEquiv = {'a','b','c','d','e','e','e','e','e','e','e','e','e','e','e','e'}
local timeSinceLastKill = Time.Now()
local killRating = 0
local aRewards = {1,2,5,10,25,25,25,25,25,25,25,25,25,25}
local aRewardsDifficultyMul = {1,1,1,2,2,3,3}
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

local function spawnPlanarInvader(argObjectId,argClassId,argDifficultyId)
    if(Game.GetLocalPlayer():HasToken("WZ_DGA_NO_PHASING") == false)then
        
        local difficultySpawn = wanez.DGA.aData.monsterPower.difficulties[argDifficultyId].entitySpawn or false
        
        local randomSpawnClass = aLetterEquiv[random(1,argClassId)]
        local randomEntityType = random(1,2)
        local enemyCoords = Entity.Get(argObjectId):GetCoords()
        if(random(1,100) <= 10 * argDifficultyId) then
            --UI.Notify('should spawn')
            local newEnemy = Character.Create('mod_wanez/_campaign/creatures/enemies/phasing_'..entityNames[randomEntityType]..'_'..randomSpawnClass..'01.dbr',Game.GetAveragePlayerLevel() + argClassId,nil)
            newEnemy:SetCoords(enemyCoords)
        
            if(difficultySpawn) then
                local newEnemy = Character.Create(difficultySpawn,Game.GetAveragePlayerLevel() + argClassId,nil)
                newEnemy:SetCoords(enemyCoords)
            end
            --UI.Notify("spawned Planar Invader: "..randomSpawnClass.." | ID: "..argClassId.." | KillRating: "..killRating)
        end
    end
end
function wanez.gd.spawnPlanarInvader(argObjectId,argClassId,argDifficultyId)
    --UI.Notify("working spawn global")
    --spawnPlanarInvader(argObjectId,argClassId,argDifficultyId)
end

local tokenPerId = {false,false,"WZ_GD_DIF_01","WZ_GD_DIF_02","WZ_GD_DIF_03","WZ_GD_DIF_04","WZ_GD_DIF_05"}
local function getDifficultyId()
    local newId = 1;
    local _player = Game.GetLocalPlayer()
    
    for id,token in pairs(tokenPerId) do
        if(_player:HasToken(token)) then
            newId = id;
        end
    end
    
    return newId;
end
--- onDie events
local function onDieEntity(argObjectId,argClassId,argDifficultyId)
    
    --local difficultyId = 1
    argDifficultyId = argDifficultyId or getDifficultyId()
    
    --UI.Notify("working onDie")
    
    if(Game.GetLocalPlayer():HasToken("WZ_DGA_NO_PHASING") == false)then
        if(killRating == 0) then
            --math.randomseed(Time.Now());
        end
        if( (Time.Now() - timeSinceLastKill) <= 10000 ) then -- 10 seconds between kills or reset killRating
            killRating = killRating + (aRewards[argClassId] * aRewardsDifficultyMul[argDifficultyId]);
            --UI.Notify('add to Rating')
            if(killRating <= 25) then
                -- spawn common
                spawnPlanarInvader(argObjectId,1,argDifficultyId)
            elseif(killRating <= 250) then
                -- spawn champion
                spawnPlanarInvader(argObjectId,2,argDifficultyId)
            elseif(killRating <= 1000) then
                -- spawn hero
                spawnPlanarInvader(argObjectId,3,argDifficultyId)
            elseif(killRating <= 2500) then
                -- spawn nemesis
                spawnPlanarInvader(argObjectId,4,argDifficultyId)
            else
                -- spawn boss
                spawnPlanarInvader(argObjectId,5,argDifficultyId)
                --UI.Notify("tagWzCampaingLua_SpawnBoss")
            end
        else
            --UI.Notify('reset Rating')
            if(killRating >= 250) then UI.Notify("tagWzCampaingLua_TimeHasRunOut") end;
            killRating = aRewards[argClassId] * aRewardsDifficultyMul[argDifficultyId];
            math.randomseed(Time.Now());
            
        end
        
        timeSinceLastKill = Time.Now()
    end
    --UI.Notify("working onDie")
end
function wanez.gd.onDieEntity(argObjectId,argClassId,argDifficultyId)
    --UI.Notify("working global")
    --UI.Notify(argDifficultyId)
    onDieEntity(argObjectId,argClassId,argDifficultyId)
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
        --UI.Notify('reset trigger')
    end
    
end

function wanez.gd.cloneProxy(argObjectId)
    
    local difficultyId = getDifficultyId()
    local _proxy = Entity.Get(argObjectId)
    local difficultySpawn = wanez.DGA.aData.monsterPower.difficulties[difficultyId].entitySpawn or false
    
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
        if(difficultySpawn) then
            local newEnemy = Entity.Create(difficultySpawn)
            newEnemy:SetCoords(_proxy:GetCoords())
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
    
    local _player = Game.GetLocalPlayer()
    local aRep = {0,0,1,3,5}
    local iRep = aRep[argClassId]
    
    _player:GiveFaction("USER14",iRep)
    _player:GiveFaction("USER15",iRep * -1)
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


--- Salvage Common Items
local aSalvageCommon = {
    {'records/items/gearweapons/axe1h/','axe',1,0.25},
    {'records/items/gearweapons/swords1h/','sword',1,0.25},
    {'records/items/gearweapons/blunt1h/','blunt',1,0.25},
    {'records/items/gearweapons/melee2h/','axe2h',1,0.5},
    {'records/items/gearweapons/melee2h/','sword2h',1,0.5},
    {'records/items/gearweapons/melee2h/','blunt2h',1,0.5},
    {'records/items/gearweapons/guns1h/','gun1h',1,0.25},
    {'records/items/gearweapons/guns2h/','gun2h',1,0.5},
    {'records/items/gearweapons/caster/','scepter',1,0.25},
    {'records/items/gearweapons/caster/','dagger',1,0.25},
    {'records/items/gearweapons/shields/','shield',2,0.25},
    {'records/items/gearweapons/focus/','focus',2,0.25},
    
    {'records/items/geartorso/','torso',1,0.5},
    --{'records/items/gearweapons/geartorso/','torso','{1}a{2}_{3}0{4}b.dbr'},
    {'records/items/gearshoulders/','shoulder',2,0.25},
    {'records/items/gearlegs/','legs',2,0.5},
    {'records/items/gearhead/','head',1,0.25},
    {'records/items/gearhands/','hands',2,0.25},
    {'records/items/gearfeet/','feet',2,0.25},
    
    {'records/items/gearaccessories/medals/','medal',3,0.1},
    {'records/items/gearaccessories/necklaces/','necklace',2,0.1},
    {'records/items/gearaccessories/rings/','ring',3,0.1},
    {'records/items/gearaccessories/waist/','waist',1,0.1}

}
local aSalvageMI = {
    -- Common 1H Axe
    {'records/items/gearweapons/axe1h/b001_axe.dbr',1},
    {'records/items/gearweapons/axe1h/b001b_axe.dbr',2},
    {'records/items/gearweapons/axe1h/b001c_axe.dbr',3},
    {'records/items/gearweapons/axe1h/b001d_axe.dbr',4},
    {'records/items/gearweapons/axe1h/b004a_axe.dbr',1},
    {'records/items/gearweapons/axe1h/b004b_axe.dbr',2},
    {'records/items/gearweapons/axe1h/b004c_axe.dbr',3},
    {'records/items/gearweapons/axe1h/b004d_axe.dbr',4},
    
    -- Common 1H Blunt
    {'records/items/gearweapons/blunt1h/b004_blunt.dbr',1},
    {'records/items/gearweapons/blunt1h/b004b_blunt.dbr',2},
    {'records/items/gearweapons/blunt1h/b004c_blunt.dbr',3},
    {'records/items/gearweapons/blunt1h/b004d_blunt.dbr',4},
    {'records/items/gearweapons/blunt1h/b012a_blunt.dbr',1},
    {'records/items/gearweapons/blunt1h/b012b_blunt.dbr',2},
    {'records/items/gearweapons/blunt1h/b012c_blunt.dbr',3},
    {'records/items/gearweapons/blunt1h/b012d_blunt.dbr',4},
    
    -- Common Caster
    {'records/items/gearweapons/caster/b008a_dagger.dbr',1},
    {'records/items/gearweapons/caster/b008b_dagger.dbr',2},
    {'records/items/gearweapons/caster/b008c_dagger.dbr',3},
    {'records/items/gearweapons/caster/b008d_dagger.dbr',4},
    {'records/items/gearweapons/caster/b010a_dagger.dbr',1},
    {'records/items/gearweapons/caster/b010b_dagger.dbr',2},
    {'records/items/gearweapons/caster/b010c_dagger.dbr',3},
    {'records/items/gearweapons/caster/b010d_dagger.dbr',4},
    {'records/items/gearweapons/caster/b010e_dagger.dbr',5},
    {'records/items/gearweapons/caster/b012a_scepter.dbr',1},
    {'records/items/gearweapons/caster/b012b_scepter.dbr',2},
    {'records/items/gearweapons/caster/b012c_scepter.dbr',3},
    {'records/items/gearweapons/caster/b012d_scepter.dbr',4},
    {'records/items/gearweapons/caster/b012e_scepter.dbr',5},
    
    -- Common 1H Gun
    {'records/items/gearweapons/guns1h/b004a_gun1h.dbr',1},
    {'records/items/gearweapons/guns1h/b004b_gun1h.dbr',2},
    {'records/items/gearweapons/guns1h/b004c_gun1h.dbr',3},
    
    -- Common 2H Gun
    {'records/items/gearweapons/guns2h/b001_gun2h.dbr',1},
    {'records/items/gearweapons/guns2h/b001b_gun2h.dbr',2},
    {'records/items/gearweapons/guns2h/b001c_gun2h.dbr',3},
    {'records/items/gearweapons/guns2h/b001d_gun2h.dbr',4},
    {'records/items/gearweapons/guns2h/b006a_gun2h.dbr',1},
    {'records/items/gearweapons/guns2h/b006b_gun2h.dbr',2},
    {'records/items/gearweapons/guns2h/b006c_gun2h.dbr',3},
    {'records/items/gearweapons/guns2h/b006d_gun2h.dbr',4},
    {'records/items/gearweapons/guns2h/b009a_gun2h.dbr',1},
    {'records/items/gearweapons/guns2h/b009b_gun2h.dbr',2},
    {'records/items/gearweapons/guns2h/b009c_gun2h.dbr',3},
    {'records/items/gearweapons/guns2h/b009d_gun2h.dbr',4},
    
    -- Common 2H Melee
    {'records/items/gearweapons/melee2h/b001a_blunt2h.dbr',1},
    {'records/items/gearweapons/melee2h/b001b_blunt2h.dbr',2},
    {'records/items/gearweapons/melee2h/b001c_blunt2h.dbr',3},
    {'records/items/gearweapons/melee2h/b001d_blunt2h.dbr',4},
    {'records/items/gearweapons/melee2h/b007a_axe2h.dbr',1},
    {'records/items/gearweapons/melee2h/b007b_axe2h.dbr',2},
    {'records/items/gearweapons/melee2h/b007c_axe2h.dbr',3},
    {'records/items/gearweapons/melee2h/b007d_axe2h.dbr',4},
    
    -- Common Shield
    {'records/items/gearweapons/shields/b002_shield.dbr',1},
    {'records/items/gearweapons/shields/b002b_shield.dbr',2},
    {'records/items/gearweapons/shields/b002c_shield.dbr',3},
    {'records/items/gearweapons/shields/b002d_shield.dbr',4},
    {'records/items/gearweapons/shields/b007a_shield.dbr',1},
    {'records/items/gearweapons/shields/b007b_shield.dbr',2},
    {'records/items/gearweapons/shields/b007c_shield.dbr',3},
    {'records/items/gearweapons/shields/b007d_shield.dbr',4},
    {'records/items/gearweapons/shields/b009a_shield.dbr',1},
    {'records/items/gearweapons/shields/b009b_shield.dbr',2},
    {'records/items/gearweapons/shields/b009c_shield.dbr',3},
    {'records/items/gearweapons/shields/b009d_shield.dbr',4},
    {'records/items/gearweapons/shields/b011a_shield.dbr',1},
    {'records/items/gearweapons/shields/b011b_shield.dbr',2},
    {'records/items/gearweapons/shields/b011c_shield.dbr',3},
    {'records/items/gearweapons/shields/b011d_shield.dbr',4},
    
    -- Common 1H Sword
    {'records/items/gearweapons/swords1h/b002_sword.dbr',1},
    {'records/items/gearweapons/swords1h/b002b_sword.dbr',2},
    {'records/items/gearweapons/swords1h/b002c_sword.dbr',3},
    {'records/items/gearweapons/swords1h/b002d_sword.dbr',4},
    {'records/items/gearweapons/swords1h/b009a_sword.dbr',1},
    {'records/items/gearweapons/swords1h/b009b_sword.dbr',2},
    {'records/items/gearweapons/swords1h/b009c_sword.dbr',3},
    {'records/items/gearweapons/swords1h/b009d_sword.dbr',4},
    {'records/items/gearweapons/swords1h/b011a_sword.dbr',1},
    {'records/items/gearweapons/swords1h/b011b_sword.dbr',2},
    {'records/items/gearweapons/swords1h/b011c_sword.dbr',3},
    {'records/items/gearweapons/swords1h/b011d_sword.dbr',4},
    
    -- Common FOCUS
    {'records/items/gearweapons/focus/b008a_focus.dbr',1},
    {'records/items/gearweapons/focus/b008b_focus.dbr',2},
    {'records/items/gearweapons/focus/b008c_focus.dbr',3},
    {'records/items/gearweapons/focus/b008d_focus.dbr',4},
    {'records/items/gearweapons/focus/b010a_focus.dbr',1},
    {'records/items/gearweapons/focus/b010b_focus.dbr',2},
    {'records/items/gearweapons/focus/b010c_focus.dbr',3},
    {'records/items/gearweapons/focus/b010d_focus.dbr',4},
    {'records/items/gearweapons/focus/b010e_focus.dbr',5},
    {'records/items/gearweapons/focus/b012a_focus.dbr',1},
    {'records/items/gearweapons/focus/b012b_focus.dbr',2},
    {'records/items/gearweapons/focus/b012c_focus.dbr',3},
    {'records/items/gearweapons/focus/b012d_focus.dbr',4},
    {'records/items/gearweapons/focus/b014a_focus.dbr',1},
    {'records/items/gearweapons/focus/b014b_focus.dbr',2},
    {'records/items/gearweapons/focus/b014c_focus.dbr',3},
    {'records/items/gearweapons/focus/b014d_focus.dbr',4},
    {'records/items/gearweapons/focus/b014e_focus.dbr',5},
    {'records/items/gearweapons/focus/b016a_focus.dbr',1},
    {'records/items/gearweapons/focus/b016b_focus.dbr',2},
    {'records/items/gearweapons/focus/b016c_focus.dbr',3},
    {'records/items/gearweapons/focus/b016d_focus.dbr',4},
    {'records/items/gearweapons/focus/b016e_focus.dbr',5},
    {'records/items/gearweapons/focus/b018a_focus.dbr',1},
    {'records/items/gearweapons/focus/b018b_focus.dbr',2},
    {'records/items/gearweapons/focus/b018c_focus.dbr',3},
    {'records/items/gearweapons/focus/b018d_focus.dbr',4},
    {'records/items/gearweapons/focus/b018e_focus.dbr',5},
    {'records/items/gearweapons/focus/b020a_focus.dbr',1},
    {'records/items/gearweapons/focus/b020b_focus.dbr',2},
    {'records/items/gearweapons/focus/b020c_focus.dbr',3},
    {'records/items/gearweapons/focus/b020d_focus.dbr',4},
    {'records/items/gearweapons/focus/b020e_focus.dbr',5},
    {'records/items/gearweapons/focus/b022a_focus.dbr',1},
    {'records/items/gearweapons/focus/b022b_focus.dbr',2},
    {'records/items/gearweapons/focus/b022c_focus.dbr',3},
    {'records/items/gearweapons/focus/b022d_focus.dbr',4},
    {'records/items/gearweapons/focus/b022e_focus.dbr',5},
    
    -- Common Head
    {'records/items/gearhead/b001_head.dbr',1},
    {'records/items/gearhead/b001b_head.dbr',2},
    {'records/items/gearhead/b001c_head.dbr',3},
    {'records/items/gearhead/b001d_head.dbr',4},
    {'records/items/gearhead/b003_head.dbr',1},
    {'records/items/gearhead/b003b_head.dbr',2},
    {'records/items/gearhead/b003c_head.dbr',3},
    {'records/items/gearhead/b003d_head.dbr',4},
    {'records/items/gearhead/b005_head.dbr',1},
    {'records/items/gearhead/b005b_head.dbr',2},
    {'records/items/gearhead/b005c_head.dbr',3},
    {'records/items/gearhead/b005d_head.dbr',4},
    {'records/items/gearhead/b011a_head.dbr',1},
    {'records/items/gearhead/b011b_head.dbr',2},
    {'records/items/gearhead/b011c_head.dbr',3},
    {'records/items/gearhead/b013a_head.dbr',1},
    {'records/items/gearhead/b013b_head.dbr',2},
    {'records/items/gearhead/b013c_head.dbr',3},
    {'records/items/gearhead/b013d_head.dbr',4},
    
    -- Common Shoulders
    {'records/items/gearshoulders/b001_shoulder.dbr',1},
    {'records/items/gearshoulders/b001b_shoulder.dbr',2},
    {'records/items/gearshoulders/b001c_shoulder.dbr',3},
    {'records/items/gearshoulders/b001d_shoulder.dbr',4},
    {'records/items/gearshoulders/b003_shoulder.dbr',1},
    {'records/items/gearshoulders/b003b_shoulder.dbr',2},
    {'records/items/gearshoulders/b003c_shoulder.dbr',3},
    {'records/items/gearshoulders/b003d_shoulder.dbr',4},
    {'records/items/gearshoulders/b005_shoulder.dbr',1},
    {'records/items/gearshoulders/b005b_shoulder.dbr',2},
    {'records/items/gearshoulders/b005c_shoulder.dbr',3},
    {'records/items/gearshoulders/b005d_shoulder.dbr',4},
    {'records/items/gearshoulders/b008a_shoulder.dbr',1},
    {'records/items/gearshoulders/b008b_shoulder.dbr',2},
    {'records/items/gearshoulders/b008c_shoulder.dbr',3},
    {'records/items/gearshoulders/b010a_shoulder.dbr',1},
    {'records/items/gearshoulders/b010b_shoulder.dbr',2},
    {'records/items/gearshoulders/b010c_shoulder.dbr',3},
    {'records/items/gearshoulders/b012a_shoulder.dbr',1},
    {'records/items/gearshoulders/b012b_shoulder.dbr',2},
    {'records/items/gearshoulders/b012c_shoulder.dbr',3},
    {'records/items/gearshoulders/b012d_shoulder.dbr',4},
    
    -- Common Toros
    {'records/items/geartorso/b001_torso.dbr',1},
    {'records/items/geartorso/b001b_torso.dbr',2},
    {'records/items/geartorso/b001c_torso.dbr',3},
    {'records/items/geartorso/b001d_torso.dbr',4},
    {'records/items/geartorso/b006a_torso.dbr',1},
    {'records/items/geartorso/b006b_torso.dbr',2},
    {'records/items/geartorso/b006c_torso.dbr',3},
    {'records/items/geartorso/b008a_torso.dbr',1},
    {'records/items/geartorso/b008b_torso.dbr',2},
    {'records/items/geartorso/b008c_torso.dbr',3},
    {'records/items/geartorso/b010a_torso.dbr',1},
    {'records/items/geartorso/b010b_torso.dbr',2},
    {'records/items/geartorso/b010c_torso.dbr',3},
    {'records/items/geartorso/b010d_torso.dbr',4},
}

function wanez.gd.salvageCommon()
    local _player = Game.GetLocalPlayer()
    local tracker = 0
    -- 1: PATH; 2: PREFIX; 3: TYPE; 4: SUFFIX
    local aTmpFiles = { '{1}a{2}_{3}0{4}.dbr', '{1}a{2}_{3}{4}.dbr', '{1}a0{2}_{3}{4}.dbr' }
    local tmpFile = ''
    local matMul = 1
    local aReplace = { '', '00', '', '000' }
    local itemFile = ''
    --local aItems = wanez.Runes._Data.Items[1]
    local aItems = aSalvageCommon
    
    for i=1,table.getn(aItems) do
        aReplace[1] = aItems[i][1]
        aReplace[3] = aItems[i][2]
        tmpFile = aTmpFiles[aItems[i][3]]
        matMul = aItems[i][4]
        
        for j=0,12 do
            aReplace[2] = (j <= 9) and '0'..j or tostring(j)
            
            for k=0,9 do
                aReplace[4] = '0'..k
                
                local whileTrue = true
                while(whileTrue)do
                    if(_player:HasItem(_cBase:str_replace(tmpFile,aReplace),1,true))then
                        tracker = tracker + j * matMul + 1 -- * (random(1,20) / 10 + 1)
                        _player:TakeItem(_cBase:str_replace(tmpFile,aReplace),1,true)
                    else
                        whileTrue = false
                    end
                end
            end;
        end;
    end;
    
    --- MI
    local aItems = aSalvageMI
    for i=1,table.getn(aItems) do
        local whileTrue = true
        while(whileTrue)do
            if(_player:HasItem(aItems[i][1],1,true))then
                tracker = tracker + aItems[i][2] -- * (random(1,20) / 10 + 1)
                _player:TakeItem(aItems[i][1],1,true)
            else
                whileTrue = false
            end
        end
    end;
    
    _player:GiveItem('records/items/questitems/scrapmetal.dbr',tracker,true)
end


