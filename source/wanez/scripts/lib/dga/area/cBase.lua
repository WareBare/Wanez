--[[
Created by IntelliJ IDEA.
User: WareBare
Date: 1/23/2017
Time: 7:27 PM

Package: area
Requires: wanez.DGA.area.cPortal()
]]--

local _areaOwner = false
--- spawnBossRaid => true
---
local specialSpawn = {}

local aTypeIdToBossType = {5,7,7,8}
local aEnemies = wanez.data.gEnemies
local aNameToId = wanez.data.gNameToId
--local aDataBase = wanez.DGA.aData

function wanez.DGA.area.cBase(argRegionId,argAreaId,optData)
    local _parent = wanez.DGA.cBase()
    --local cVariation = wanez.DGA.cVariation()
    --setmetatable(cBase,{ __index = cVariation })
    optData = optData or wanez.DGA.aData

    --- :addPortal(argObjectId,argType), :getPortal()
    local aPortals = {}
    local aEntityCoords = {}
    local aEntities = {}
    local timeEntityIni = false
    local allowNewEntityCoords = true
    local allowSpawn = true
    local baseRegion = argRegionId
    local curRegion = 1
    local areaId = argAreaId
    local aDataArea = {}
    local mpTypeId = 1
    local aDataMP = {} --- { Difficulty; Type; isUber }
    local areaTier = 0
    local monsterLevel = 1
    local areaLvL = false
    local tryCount = 0

    local _cType = false

    local class = {
        cPortal = false;
        aMods = {};
        __constructor = function(self)
            --UI.Notify("AreaID: "..self.areaId.." | Variation: ")
            self:isNewArea()
            --self:setDataArea()
            --- Inhabitants
            aDataArea.Inhabitants = aEnemies.aPacks[aNameToId.Enemies[optData.Inhabitants[areaId]]]
        end;
        setDataArea = function(self,argMpTypeId)
            aDataArea.bossSpawn = (argMpTypeId == 1 and wanez.DGA.aData.bossSpawn[areaId]) and wanez.DGA.aData.bossSpawn[areaId]..".dbr" or self:RNG({
                --aData = (specialSpawn.spawnBossRaid) and aEnemies.aBossRaid or aEnemies['a'..wanez.DGA.aData.monsterClassifications[aTypeIdToBossType[argMpTypeId]]]
                aData = aEnemies.aBossChallenge
            })
        
            aDataArea.entityTypes = wanez.DGA.aData.entityTypes[argMpTypeId]
            aDataArea.containers = wanez.DGA.aData.containers[argMpTypeId]
    
            local enemyTypes = wanez.DGA.aData.enemyTypes[argMpTypeId]
            aDataArea.areaSettings = enemyTypes
            local enemyData = enemyTypes
            enemyData.aClassChance = {
                100 - enemyTypes.championChance[self:__getDifficultyID()] - enemyTypes.heroChance[self:__getDifficultyID()],
                enemyTypes.championChance[self:__getDifficultyID()],
                enemyTypes.heroChance[self:__getDifficultyID()]
            }
            enemyData.aClassCount = {
                enemyTypes.commonCount[self:__getDifficultyID()],
                enemyTypes.championCount[self:__getDifficultyID()],
                enemyTypes.heroCount[self:__getDifficultyID()]
            }
            
            aDataArea.spawnData = {
                Enemy = enemyData
            }
            
            --aDataArea
        end;
        
        addSpecialSpawn = function(self,optData)
            optData = optData or {}
            
            for key,value in pairs(optData) do
                specialSpawn[key] = value
            end;
        end;
        
        -- used on boxTrigger (spawn)
        isNewArea = function(self,argMpTypeId,argTier,argAreaLvL)
            curRegion = curRegion or baseRegion
            allowSpawn = true
            mpTypeId = argMpTypeId or mpTypeId
            areaLvL = argAreaLvL or self:convertTier(argTier)
            areaTier = self:convertLvL(argTier)
            tryCount = 0
    
            self:setMonsterLevel()
        end;
        
        convertTier = function(self,argTier)
            argTier = argTier or areaTier
            --- calculate new monster level
            local mul = argTier / 5
            local mulFloor = math.floor(mul)
            local mulRemain = (mul - mulFloor) / 0.2
            local lvlInc = 0
    
            for i=0,mulFloor do
                lvlInc = lvlInc + (i * 5)
            end;
            return lvlInc + (mulRemain * (mulFloor + 1))
        end;
        convertLvL = function(self,argTier,argLvL)
            argTier = argTier or areaTier
            argLvL = argLvL or areaLvL
            
            while( self:convertTier(argTier) < argLvL ) do
                argTier = argTier + 1
            end;
            
            return argTier
        end;
        
        setMonsterLevel = function(self,argTier)
            --[[
            argTier = argTier or areaTier
            --- calculate new monster level
            local mul = argTier / 5
            local mulFloor = math.floor(mul)
            local mulRemain = (mul - mulFloor) / 0.2
            local lvlInc = 0
    
            for i=0,mulFloor do
                lvlInc = lvlInc + (i * 5)
            end;
            lvlInc = lvlInc + (mulRemain * (mulFloor + 1))
            ]]
            monsterLevel = Game.GetAveragePlayerLevel() + areaLvL
        end;
        
        setAffixData = function(self)
            local aAffixes = wanez.DGA.aData.affixEvents
            local tempData
            
            for affixType,aData in pairs(aAffixes) do
                self.aMods[affixType] = {}
                for typeId,data in pairs(aData) do
                    for index,values in pairs(data) do
                        if(self:__hasAffix(values[1])) then
                            tempData = self.aMods[affixType][typeId] or 0
                            self.aMods[affixType][typeId] = tempData + values[2]
                        end
                    end;
                end;
            end;
            
        end;
        setDropMul = function(self)
            self:__setDropMul(aDataMP)
        end;
        
        -- used on opening portal on useScroll
        __setAreaOwnwer = function(self,argPlayer,_argType,argTier)
            argPlayer = argPlayer or Game.GetLocalPlayer()
    
            mpTypeId = _argType.TypeID
            curRegion = baseRegion
            --areaTier = argTier or 0
            --- Set DGA-Affixes
            self.incCount = {}
            self.incChances = {}
            self.aMods = {}
            self:setAffixData()
            
            --UI.Notify("New MonsterLevel: "..monsterLevel)
            if(curRegion == 1) then
                specialSpawn = {}
            
                _areaOwner = argPlayer
                _cType = _argType
                aDataMP = self:getMonsterPower(argPlayer,mpTypeId)
                for key,value in pairs(aPortals) do
                    value.isCasual = (aDataMP.difficulty.ID == 1) and true or false
                end;
                if(argPlayer:HasToken('WZ_DGA_COMPLETE_UBER')) then argPlayer:RemoveToken('WZ_DGA_COMPLETE_UBER') end
            end
            --- set data dependant on MonsterPower or Tier
            self:setDataArea(mpTypeId)
            self:setDropMul()
        end;
        __getAreaOwner = function(self)
            return _areaOwner
        end;
        setAreaId = function(self,argAreaId)
            areaId = argAreaId
        end;
        returnMonsterPower = function(self)
            return aDataMP
        end;
        getAreaProperties = function(self)
            return {
                _cType = _cType;
                areaTier = areaTier;
                _areaOwner = _areaOwner;
                areaId = areaId;
                aDataMP = aDataMP;
                --allowSpawn = allowSpawn;
            }
        end;
    
        getTier = function(self)
            return areaTier
        end;
        getAreaLvL = function(self)
            return areaLvL
        end;
        
        setPortal = function(self,argTypePortal)
            self.cPortal = aPortals[argTypePortal]
        end;
        
        --- ini portals (from camp[default] or bossRoom[challenge])
        addPortal = function(self,argObjectId,argType)
            aPortals[argType] = aPortals[argType] or wanez.DGA.area.cPortal(argObjectId)
        end;
        --- ini proxies, to get spawn coords (default, ...)
        addEntityCoords = function(self,argObjectId,argType,argRegionId)
            -- check if region has generated coords yet and set allowNewEntityCoords to true if not
            if(aEntityCoords[argRegionId] == nil) then
                aEntityCoords[argRegionId] = {}
                --allowNewEntityCoords = true
                timeEntityIni = Time.Now()
            end
            -- if allowed add coords for entities
        -- todo add time to check if allowed to add new proxies
            if( (Time.Now() - timeEntityIni) <= 5000) then -- allowNewEntityCoords
                aEntityCoords[argRegionId][argType] = aEntityCoords[argRegionId][argType] or {}
                table.insert(aEntityCoords[argRegionId][argType], Entity.Get(argObjectId):GetCoords())
                timeEntityIni = Time.Now()
            else
                --UI.Notify("Dont Add Entities: "..argType)
            end
        end;
        
        --- trigger inside area
        spawnEntities = function(self,argObjectPlayer,iBossRoom,argType,argRegionId)
            iBossRoom = iBossRoom or false
            --allowNewEntityCoords = false
            --local tempProxy = false
            --- remove token to summon Portal if player has one
            --local tokenPortalDefault = 'WZ_DGA_ALLOW_PORTAL_DEFAULT'
            --local _player = Player.Get(argObjectPlayer) or Game.GetLocalPlayer()
            
            
            
            -- todo
            if(allowSpawn) then
                tryCount = tryCount + 1
            
                self:removeEntities()
                --UI.Notify("Trigger: start spawn")
                local _tempProxy = false
                local usedCoords = {}
            
                local incSpawnChance = self.aMods.entityChances.proxies or 0
                local spawnChance = aDataArea.areaSettings.useProxies + incSpawnChance
                
                --UI.Notify(tostring(spawnChance))
                --UI.Notify("ProxyCount: "..table.getn(aEntityCoords[curRegion].Default))
                if(self.areaType == "BossRoom") then
                    local bossCoords = self:RNG({
                        aData = aEntityCoords[curRegion].Default
                    })
        
                    _tempProxy = wanez.DGA.entity.cEnemy()
                    _tempProxy:setDataEntity(aDataMP,monsterLevel)
        
                    if(iBossRoom) then
                        if( iBossRoom:spawnBoss() )then
                            _tempProxy:createEntities(bossCoords,aDataArea.bossSpawn,aTypeIdToBossType[mpTypeId])
                        else
                            _tempProxy:createEntities(bossCoords,self:RNG({aData = aEnemies.aBossMini}),4)
                        end
                        table.insert(aEntities,_tempProxy)
                    end
                    usedCoords[bossCoords] = true
                else
                    --- set BossRoom Data
                    iBossRoom:prepBossRoom({
                        _cType = _cType;
                        areaTier = areaTier;
                        _areaOwner = _areaOwner;
                        areaId = areaId;
                        areaLvL = areaLvL;
                        --allowSpawn = allowSpawn;
                    })
                    --UI.Notify("Trigger: has set bossroom data")
                end
                
            
                for key,entityCoords in pairs(aEntityCoords[curRegion].Default) do
                    --UI.Notify("Trigger: start spawn")
                    -- add instance to the list
                    if(self:RNG({
                        aChances = spawnChance
                    }) and usedCoords[entityCoords] ~= true) then
                        table.insert(aEntities,self:rollEntities(entityCoords))
                    end
                    
                end;
            
                allowSpawn = false
                UI.Notify("Trigger finished on Try: "..tryCount)
            end
            
        end;
        
        removeEntities = function(self)
            for key,_cProxy in pairs(aEntities) do
    
                _cProxy:destoryEntities()
                
            end;
            aEntities = {}
        end;
        
        genEntityDbr = function(self,argEntityClassId,optEntityPool)
            local randomMin = {4,3,1}
            local aEnemiesToSpawn = {}
            local incCount = self.aMods.enemyCount[argEntityClassId] or 0
            --local incCount = 0
            
            local entityCount = self:RNG({
                randomMin = randomMin[argEntityClassId] + incCount or 1;
                randomMax = aDataArea.spawnData.Enemy.aClassCount[argEntityClassId] + incCount
            })
            
            for i=1,entityCount do
                table.insert(aEnemiesToSpawn,self:RNG({
                    aData = optEntityPool[wanez.DGA.aData.monsterClassifications[argEntityClassId]]
                }))
            end;
            
            return aEnemiesToSpawn
        end;
        
        rollEntities = function(self,argEntityCoords)
            local _tempProxy = false
            local aEntityPool = false
            local aEntitiesToSpawn = false
            local entityClass = false
            --local isHero = false
            --local entityCount = 0
            --local randomMin = {4,3,1}
            --UI.Notify("rollEntities: start creation")
            -- todo type of entity to spawn (Enemy; Container; NPC)
            local entityType = self:RNG({
                aDataRatio = aDataArea.entityTypes
            })
            --UI.Notify("rollEntities: start creation")
            if(entityType == "Enemy") then
                --UI.Notify("rollEntities: Enemy")
                _tempProxy = wanez.DGA.entity.cEnemy()
                _tempProxy:setDataEntity(aDataMP,monsterLevel)
                aEntityPool = self:RNG({
                    aData = aEnemies.aPacks;
                    --returnArrayValue = false
                })
                
                -- inhabitant or random enemies
                if(self.areaType ~= "BossRoom") then
                    if(self:RNG({
                        aChances = aDataArea.spawnData.Enemy.inhabitantChance
                    }))then
                        aEntityPool = aDataArea.Inhabitants
                    end
                end
                
                
                --- enemy Classification
                entityClass = self:RNG({aChances = aDataArea.spawnData.Enemy.aClassChance})
                -- special case for Heroes
                if(entityClass == 3) then
                    if(aDataArea.areaSettings.heroReq <= monsterLevel) then
                        _tempProxy:createEntities(argEntityCoords,self:genEntityDbr(entityClass,aEntityPool),entityClass)
                    end
                    entityClass = 1
                end
            
            elseif(entityType == "Container") then
                --UI.Notify("rollEntities: Container")
                aEntitiesToSpawn = self:RNG({
                    aDataRatio = aDataArea.containers
                })
                --UI.Notify("rollEntities: "..aEntitiesToSpawn)
                _tempProxy = wanez.DGA.entity.cContainer()
                _tempProxy:setDataEntity(aDataMP,monsterLevel)
            
                entityClass = 1
                --[[
            elseif(entityType == "Anomaly") then
                _tempProxy = wanez.DGA.entity.cEnemy()
                _tempProxy:setDataEntity(aDataMP,monsterLevel)
    
                aEntityPool
                ]]
            end
    
            
            
            --_tempProxy:createEntities(argEntityCoords,aEnemiesToSpawn,entityClass)
            _tempProxy:createEntities(argEntityCoords,aEntitiesToSpawn or self:genEntityDbr(entityClass,aEntityPool),entityClass)
            --UI.Notify("rollEntities: finish creation")
            
            return _tempProxy
        end;
        --[[
        openArea = function(self,argCoordsPortal,argPlayer)
            
        end;
        ]]
    }
    
    setmetatable(class,{ __index = _parent })
    class:__constructor()
    return class
end

