--[[
Created by IntelliJ IDEA.
User: WareBare
Date: 1/20/2017
Time: 4:54 PM


can be used from _cSettings, or any other instance
    static _activeArea => wanez.DGA.cBase:getArea()

requires: _cMission; _cEndless; _cChallenge; _cRaid
    protected areaId
    protected variationId
    protected questId
    protected taskId



SubMod: DGA
]]--
local _cSettings = wanez.DGA.cSettings()
--local _cMission = false
--local _cChallenge = false
--local _cRaid = false
local _cType = false
local _cBossRoom = wanez.DGA.area.cBossRoom()
local tokenPortalDefault = 'WZ_DGA_ALLOW_PORTAL_DEFAULT'
local portalOpener = false
local rewardId = 0
local nextAreaId = 0
--local mapTier = 0

local function devOnlyFn()
    if(wanez.isDev)then
        local player = Game.GetLocalPlayer()
        local playerCoords = player:GetCoords()
        local mainPath = 'mod_wanez/dev/'
        local godModeItems = {
            '0000_accessoryset_necklace',
            '0000_accessoryset_ring01',
            '0000_accessoryset_ring02',
            '0000_accessoryset_waist',
            '0000_armourset_feet',
            '0000_armourset_hands',
            '0000_armourset_head',
            '0000_armourset_legs',
            '0000_armourset_shoulders',
            '0000_armourset_torso',
            '0000_armourset_waist',
            '0000_weapon_scepter001',
            '0000_weapon_focus001'
        }
        for i=1,table.getn(godModeItems) do
            local newItem = Entity.Create(mainPath..godModeItems[i]..'.dbr')
            newItem:SetCoords(playerCoords)
        end
        player:GiveItem("mod_wanez/_dga/items/currency/a_001b.dbr",100,true)
        player:GiveItem("mod_wanez/currency/a_001b.dbr",100,true)
        player:GiveItem("mod_wanez/currency/b_001b.dbr",100,true)
    end
end

function wanez.DGA.useDGA_Scroll(argObjectId,argDifficultyGD,argTierDGA,argTypeDGA)
    _cScroll = wanez.cScroll({
        notify = "tagWzDGA_LuaNotify_usedScrollDGA_failure";
    },function(self)
        local aActions = {
            giveItems = "mod_wanez/_dga/items/scrolls/DGA_Scroll"..self:parseIntToString(argDifficultyGD,1).."_Tier"..self:parseIntToString(argTierDGA,2)..argTypeDGA..".dbr";
        }
        portalOpener = Game.GetLocalPlayer()
        local typeId = self:convertIndex(argTypeDGA)
        
        if(self:__getDifficultyID() ~= argDifficultyGD) then
            aActions.notify = "tagWzDGA_LuaNotify_Difficulty_failure"
        elseif(portalOpener:HasToken(tokenPortalDefault)) then
            _cSettings:resetArea()
            _cSettings:__setAffixes(portalOpener)
            local chooseArea = false
            --mapTier = argTierDGA
            
            --local _cType = false
            --- everything is fine, time to prepare the area
            -- check for raid
            if(typeId == 1) then
                _cType = wanez.DGA.type.cRaid()
                chooseArea = (nextAreaId >= 3001 and nextAreaId <= 4000) and nextAreaId or false
            elseif(typeId == 2) then
                _cType = wanez.DGA.type.cEndless()
                chooseArea = (nextAreaId >= 1001 and nextAreaId <= 2000) and nextAreaId or false
            end
        
            -- check for challenge
            if(_cType:hasQuest() == false and typeId == 1) then
                _cType = wanez.DGA.type.cChallenge()
                chooseArea = (nextAreaId >= 2001 and nextAreaId <= 3000) and nextAreaId or false
                _cType:resetReward()
            end
    
            -- check for mission
            if(_cType:hasQuest() == false and typeId == 1) then
                _cType = wanez.DGA.type.cMission()
                chooseArea = (nextAreaId >= 1 and nextAreaId <= 1000) and nextAreaId or false
            end
            
            -- grant mission or endless
            if(_cType:hasQuest() == false and typeId == 1) then
                _cType:newQuest()
            end
            _cType:nextArea(chooseArea)
            _cType:__setArea('Default',argTierDGA)
    
            -- open portal for mission
            _cSettings:openArea('FloorArea0000-00a',portalOpener,_cType)
    
            nextAreaId = 0
        
            aActions.notify = "tagWzDGA_LuaNotify_usedScrollDGA_success"
            -- giveBackItem while in developement
            if(argTierDGA ~= 0) then aActions.giveItems = false end
        elseif(self:__getDifficultyID() == 3 and self:__getDifficultyID() == argDifficultyGD) then
            portalOpener:GiveItem('mod_wanez/_dga/items/currency/a_001b.dbr',argTierDGA,true)
        
            aActions.notify = false
            -- giveBackItem while in developement
            if(argTierDGA ~= 0) then aActions.giveItems = false end
        end
        
        --UI.Notify(Entity.Get(argObjectId):GetName())
        
        return aActions
    end)
end

function wanez.DGA.setPortalLoc(argObjectId,argTypePortal,argAreaId,argVariation,argRegionId)
    _cSettings:__addArea(argObjectId,argTypePortal,argAreaId,argVariation,argRegionId)
end
function wanez.DGA.setEntityLoc(argObjectId,argTypeEntity,argAreaId,argVariation,argRegionId)
    _cSettings:__addArea(argObjectId,argTypeEntity,argAreaId,argVariation,argRegionId)
end

function wanez.DGA.boxTriggerDefault(argObjectId)
    
    --_cSettings:getArea():spawnEntities(argObjectId)
    _cSettings:spawnEntities(argObjectId,_cBossRoom)
end
function wanez.DGA.boxTriggerBossRoom(argObjectId)
    --_cBossRoom:isNewArea()
    _cBossRoom:spawnEntities(argObjectId,_cType)
end
function wanez.DGA.regPortalBossRoom(argObjectId)
    --_cSettings:__addArea(argObjectId,'BossRoom',1,'a',1)
end
function wanez.DGA.regProxyBossRoom_Default(argObjectId)
    _cBossRoom:addEntityCoords(argObjectId,'Default',1)
end
function wanez.DGA.onEnterTriggerCampOnLoad(argObjectId)
    local _player = Player.Get(argObjectId)
    
    wanez.DGA.dbr.onLeaveTriggerSummonPortal(argObjectId)
    
    _player:GiveToken("WZ_DGA_CHALLENGE_COMPLETE")

    -- first load per difficulty
    if(_player:HasToken("DISMANTLING_UNLOCKED") == false)then
        _player:GiveToken("DISMANTLING_UNLOCKED")
        if(Game.GetGameDifficulty() == Game.Difficulty.Normal) then
            _player:UnlockFaction("USER14")
            _player:UnlockFaction("USER15")
            _player:wzHasItem("records/items/misc/inventorybag.dbr",5)
            _player:AdjustMoney(10000)
            _player:GiveItem("records/items/misc/potions/potion_healtha01.dbr",20,true)
        end
    end
    --_player:GiveItem("mod_wanez/_dga/items/scrolls/reward_scroll_a001.dbr",1,true)
    --wanez.DGA.dbr.onLeaveTriggerOrbConversion(argObjectId)
end
function wanez.DGA.onEnterTriggerMapMP(argObjectId)
    local _player = Player.Get(argObjectId)
    if(_player:HasToken("WZ_DGA_ALLOW_PORTAL_DEFAULT")) then
        _player:RemoveToken("WZ_DGA_ALLOW_PORTAL_DEFAULT")
    end
    if(_cType) then
        --- start challenge for the player entering
        if(_cType.TypeID == 3) then
            --UI.Notify("GiveToken: CHALLENGE START")
            --_player:RemoveToken("WZ_DGA_CHALLENGE_COMPLETE")
            for i=1,9 do
                _player:RemoveToken("WZ_DGA_CHALLENGE_FINISH_0"..i)
            end;
            _player:GiveToken("WZ_DGA_CHALLENGE_START")
        end
    end
end

--[[
-- Floor onAddToWorld to show portals in camp after using scroll
 ]]
function wanez.DGA.regFloorArea0000_00a(argObjectId) -- Encampment
    devOnlyFn()
    _cSettings:__addCoords(argObjectId,'FloorArea0000-00a')
end
function wanez.DGA.regFloorArea0000_00b(argObjectId) -- BossRoom
    _cSettings:__addCoords(argObjectId,'FloorArea0000-00b')
end

function wanez.DGA.onInteractPortalBack(argObjectId)
    --_cSettings:resetArea()
end
function wanez.DGA.onInteractPortalBossRoom(argObjectId)
    --QuestGlobalEvent("wzDGA_completeQuestType001")
end

function wanez.DGA.onInteractPortalDefault(argObjectId)
    _cSettings:getArea().cPortal:hidePortal()
end
function wanez.DGA.onInteractPortalChallenge(argObjectId)
    _cSettings:getArea().cPortal:hidePortal()
end

function wanez.DGA.crafterDGA(argObjectId)
    local entity_ = Entity.Get(argObjectId)
    
    local crafter_ = Entity.Create( (_cSettings:__getDifficultyID() == 3) and "mod_wanez/_dga/npcs/blacksmith_dga_ultimate.dbr" or "mod_wanez/_dga/npcs/blacksmith_dga_normal.dbr" )
    crafter_:SetCoords(entity_:GetCoords())
    
    --UI.Notify(wanez.fn.convertIndex(4))
    --wanez.DGA.cArea():Notify()
    --wanez.DGA.area.cArea()
end

function wanez.DGA.useReward_Scroll(argObjectId,argTier,argType)
    _cScroll = wanez.cScroll({
        notify = "tagWzDGA_LuaNotify_usedReward_Scroll";
    },function(self)
        --[[
        local itemDbr = "mod_wanez/_dga/items/scrolls/reward_scroll_"..argType..self:parseIntToString(argTier,2)..".dbr"
        local aActions = {
            giveItems = itemDbr;
        }
        ]]
        local aActions;
        
        return aActions
    end)
end
function wanez.DGA.useArea_Scroll(argObjectId,argAreaId)
    _cScroll = wanez.cScroll({
        notify = "tagWzDGA_LuaNotify_usedReward_Scroll";
    },function(self)
        --[[
        local itemDbr = "mod_wanez/_dga/items/scrolls/area_scroll_"..self:parseIntToString(argAreaId,3)..".dbr"
        local aActions = {
            giveItems = itemDbr;
        }
        ]]
        local aActions = {
            notify = "tagWzDGA_AreasNext_"..self:parseIntToString(argAreaId,3)
        }
    
        nextAreaId = argAreaId
        
        return aActions
    end)
end

local endlessNPC = false -- declare endlessNPC to later destroy it when the portal is being created
function wanez.DGA.openNextEndless(argObjectId,argInc)
    -- open next portal
    _cType:setQuestArea(1,true)
    _cType:__setArea('Challenge',_cBossRoom:getTier(),_cBossRoom:getAreaLvL() + argInc)
    _cSettings:openArea('FloorArea0000-00b',portalOpener,_cType)
    
    -- destroy endlessNPC, he isnt required anymore
    endlessNPC:Destroy()
    endlessNPC = false
end

function wanez.DGA.onDie(argObjectId,argClassId)
    local _enemy = Entity.Get(argObjectId)
    local typeId = _cType.TypeID or 1
    
    --- REWARD SYSTEM
    if(typeId == 2) then
        if(argClassId == 7) then
            --UI.Notify("Endless still needs work, but here is a Portal")
            --_cType:setQuestArea(1,true)
            --_cType:__setArea('Challenge',_cBossRoom:getTier(),_cBossRoom:getAreaLvL())
            --_cSettings:openArea('FloorArea0000-00b',portalOpener,_cType)
            -- spawn Endless NPC
            if(endlessNPC == false)then
                endlessNPC = Entity.Create("mod_wanez/_dga/npcs/endless_a001.dbr")
                endlessNPC:SetCoords(_cSettings:__getCoords("FloorArea0000-00b"))
                UI.Notify("tagWzDGA_LuaNotify_BossRoomEndlessNPC")
            end
        end
    end
    if(typeId == 3)then
        rewardId = _cType:reward001(argClassId)
        QuestGlobalEvent("wzDGA_questType003_Finish")
        if(argClassId == 4) then
            _cType:setQuestArea(1,true)
            _cType:__setArea('Challenge',_cBossRoom:getTier(),_cBossRoom:getAreaLvL())
            _cSettings:openArea('FloorArea0000-00b',portalOpener,_cType)
            UI.Notify("tagWzDGA_LuaNotify_BossRoomChallengeNPC")
        end
        if(argClassId == 7)then
            QuestGlobalEvent("wzDGA_completeQuestType003")
        end
    end
    
    --- DROP & LOOT
    local _cDrop = wanez.DGA.cDrop()
    _cDrop:__iniClass(argObjectId,argClassId) -- ,typeId,portalOpener
    _cDrop:__dropLoot()
end

--- functions using local var to set data for MP fn call
local toSetAffix = false
function wanez.DGA.useDGA_Affix(argObjectId,argType,argAffix)
    _cScroll = wanez.cScroll({
        notify = "tagWzDGA_LuaNotify_usedDGA_Affix";
    },function(self)
        --[[
        local itemDbr = "mod_wanez/_dga/items/affixes/"..argType..self:parseIntToString(argAffix,2)..".dbr"
        local aActions = {
            giveItems = itemDbr;
        }
        ]]
        local aActions;
        
        local aData = wanez.DGA.aData.affixes[self:convertIndex(argType)]
        local aQuests = aData.quests[argAffix]
        local _player = Game.GetLocalPlayer()
    
        if(_player:GetQuestState(aQuests[1]) == QuestState.InProgress) then
            UI.Notify("Has Quest Already")
            --aActions.giveItems = itemDbr
        else
            toSetAffix = {self:convertIndex(argType),argAffix }
            QuestGlobalEvent("wzDGA_grantAffix")
        end
        
        return aActions
    end)
end

local questData = false
function wanez.DGA.useQuest_Scroll(argQuestId,argType)
    _cScroll = wanez.cScroll({
        notify = "tagWzDGA_LuaNotify_usedDGA_QuestScroll_failure";
    },function(self)
        --[[
        local itemDbr = "mod_wanez/_dga/items/scrolls/quest_type"..self:parseIntToString(argQuestId,2)..argType..".dbr"
        local aActions = {
            giveItems = itemDbr;
        }
        ]]
        local aActions;
        
        local typeId = self:convertIndex(argType)
        local aTypes = {
            "cMission",
            "cEndless",
            "cChallenge",
            "cRaid"
        }
    
        local _cQuest = wanez.DGA.type[aTypes[typeId]]()
        
        if(_cQuest:hasQuest()) then
            --UI.Notify("useQuest_Scroll: hasQuest()")
            aActions.notify = "tagWzDGA_LuaNotify_usedDGA_QuestScroll_hasAlready"..self:parseIntToString(typeId,2)
        else
            questData = argQuestId
            QuestGlobalEvent("wzDGA_grantQuestType"..self:parseIntToString(typeId,2))
            aActions.notify = "tagWzDGA_LuaNotify_usedDGA_QuestScroll_success"
        end
    
        questData = false
    
        return aActions
    end)
end


--- Global Events, addition to QuestGlobalEvent()
local addToClientQuestTable = {
    wzDGA_grantQuestType001 = function()
        RemoveTokenFromLocalPlayer("WZ_DGA_MISSION_COMPLETE")
        local _cQuest = wanez.DGA.type.cMission()
        _cQuest:startQuest()
    end;
    wzDGA_completeQuestType001 = function()
        GiveTokenToLocalPlayer("WZ_DGA_MISSION_COMPLETE")
        local _cDrop = wanez.DGA.cDrop()
        _cDrop:giveOrb(2)
    end;
    wzDGA_cancelQuestType001 = function()
        GiveTokenToLocalPlayer("WZ_DGA_MISSION_COMPLETE")
    end;
    wzDGA_completeQuestType002 = function()
        GiveTokenToLocalPlayer("WZ_DGA_ENDLESS_COMPLETE")
        local _cDrop = wanez.DGA.cDrop()
        _cDrop:giveOrb(2)
    end;
    wzDGA_grantQuestType003 = function()
        RemoveTokenFromLocalPlayer("WZ_DGA_CHALLENGE_START")
        RemoveTokenFromLocalPlayer("WZ_DGA_CHALLENGE_COMPLETE")
        local _cQuest = wanez.DGA.type.cChallenge()
        --UI.Notify("QuestID: "..questData[1].." | TaskID: "..questData[2][1])
        _cQuest:startQuest(questData)
    end;
    wzDGA_completeQuestType003 = function()
        GiveTokenToLocalPlayer("WZ_DGA_CHALLENGE_COMPLETE")
        local _cDrop = wanez.DGA.cDrop()
        _cDrop:giveOrb(2)
    end;
    wzDGA_completeAffixes = function()
        local aData = wanez.DGA.aData.affixes
        for index,value in pairs(aData) do
            GiveTokenToLocalPlayer(value.token)
        end;
    end;
    wzDGA_grantAffix = function()
        if(toSetAffix ~= false)then
            -- declare var
            local aData = wanez.DGA.aData.affixes[toSetAffix[1]]
            local aQuests = aData.quests[toSetAffix[2]]
            local _player = Game.GetLocalPlayer()
            
            -- remove Token and GrantQuest
            RemoveTokenFromLocalPlayer(aData.token)
            if(_player:GetQuestState(aQuests[1]) ~= QuestState.InProgress) then
                _player:GrantQuest(aQuests[1],aQuests[2][1])
            end
            
        end
    end;
    
    wzDGA_setDifficulty00 = function()
        RemoveTokenFromLocalPlayer("WZ_DGA_MP_DIFFICULTY_00")
    end;
    
    
    wzDGA_questType003_Finish = function()
        if(rewardId ~= 0)then
            GiveTokenToLocalPlayer("WZ_DGA_CHALLENGE_FINISH_"..rewardId)
        end
    end;
    
    wzDGA_dropCurrencySoul = function()
        local _cDrop = wanez.DGA.cDrop()
        _cDrop:dropCurrency('soul')
    end;
    wzDGA_dropCurrencyEssence = function()
        local _cDrop = wanez.DGA.cDrop()
        _cDrop:dropCurrency('essence')
    end;
    wzDGA_dropPlanarOrb = function()
        local _cDrop = wanez.DGA.cDrop()
        _cDrop:giveOrb(2)
    end;
}

table.insert(wanez.MP,addToClientQuestTable)
