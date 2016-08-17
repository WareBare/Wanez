--[[
Created by IntelliJ IDEA.
User: WareBare
Date: 8/5/2016
Time: 11:36 AM

Package: 
]]--

wanez.Runes.crafting = {}


function wanez.Runes.crafting.salvageCommon()
    wanez.scroll.fnCall = function()
        local aActions = {
            ['GiveItem']= 'mod_wanez/_runes/misc/scroll_salvage_common.dbr'
            --['Notify']='Salvaged stuff'
        }
        local _player = Game.GetLocalPlayer()
        local tracker = 0
        -- 1: PATH; 2: PREFIX; 3: TYPE; 4: SUFFIX
        local aTmpFiles = { '{1}a{2}_{3}0{4}.dbr', '{1}a{2}_{3}{4}.dbr', '{1}a0{2}_{3}{4}.dbr' }
        local tmpFile = ''
        local matMul = 1
        local aReplace = { '', '00', '', '000' }
        local itemFile = ''

        local aItems = wanez.Runes._Data.Items[1]

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
                        if(_player:HasItem(wanez.replace(tmpFile,aReplace),1,true))then
                            tracker = tracker + j * matMul * (wanez.RNG({1,20}) / 10 + 1)
                            _player:TakeItem(wanez.replace(tmpFile,aReplace),1,true)
                        else
                            whileTrue = false
                        end
                    end
                end;
            end;
        end;

        --- MI
        local aItems = wanez.Runes._Data.Items[2]
        for i=1,table.getn(aItems) do
            local whileTrue = true
            while(whileTrue)do
                if(_player:HasItem(aItems[i][1],1,true))then
                    tracker = tracker + aItems[i][2] * matMul * (wanez.RNG({1,20}) / 10 + 1)
                    _player:TakeItem(aItems[i][1],1,true)
                else
                    whileTrue = false
                end
            end
        end;

        _player:GiveItem('records/items/questitems/scrapmetal.dbr',tracker,true)
        --UI.Notify(math.floor(tracker))

        return aActions;
    end
end
--
local aStoneData = false
local runeType = false
local aRuneSequence = {}
--
local function getStoneDBR(argStoneSlot,argStoneType,argStoneSockets)
    if(argStoneSlot == nil)then
        argStoneSlot = aStoneData[1]
        argStoneType = aStoneData[2]
        argStoneSockets = aStoneData[3]
    end
    --- 1: PATH; 2: SLOT; 3: TYPE
    local tmpDBR = '{1}stone_{2}_{3}_{4}.dbr'
    local aReplaceDBR = {}
    aReplaceDBR[1] = 'mod_wanez/_runes/items/misc/'
    aReplaceDBR[2] = argStoneSlot
    aReplaceDBR[3] = (argStoneType) and argStoneType or 'generic'
    aReplaceDBR[4] = (argStoneSockets <= 9) and '0'..argStoneSockets or argStoneSockets
    -- GIVE ITEM
    --Game.GetLocalPlayer():GiveItem(wanez.replace(tmpDBR,aReplaceDBR),1,true)
    return wanez.replace(tmpDBR,aReplaceDBR);
end
local function genRunePath(argRuneType,argRuneId,argRuneTier)
    local pathRuneMateria = 'mod_wanez/_runes/items/materia/'
    local aRuneTypes = {'a','b','c','d','e'} -- Types: add a structure to runes
    local aRuneTiers = {'','a','b','c','d','e'} -- 1: Scroll; 2+: Components (Rarity)

    --- 1: PATH; 2: RuneType; 3: RuneID; 4: RuneTier
    local tmpDBR = '{1}rune{2}_{3}{4}.dbr'
    local aReplaceDBR = {}
    aReplaceDBR[1] = pathRuneMateria
    aReplaceDBR[2] = aRuneTypes[argRuneType]
    aReplaceDBR[3] = (argRuneId <= 9) and '00'..argRuneId or (argRuneId <= 99) and '0'..argRuneId or argRuneId
    aReplaceDBR[4] = aRuneTiers[argRuneTier]

    --local runePath_ = wanez.replace(tmpDBR,aReplaceDBR)

    return wanez.replace(tmpDBR,aReplaceDBR);
end
local function getRuneDBR(optRuneData)
    local _player = Game.GetLocalPlayer()
    local runeDBR = ''
    if(optRuneData == nil)then
        runeDBR = {}
        -- resetSequence result
        for i=1,table.getn(aRuneSequence) do
            --_player:GiveItem(genRunePath(runeType,aRuneSequence[i],1),1,false)
            table.insert(runeDBR,genRunePath(runeType,aRuneSequence[i],1))
        end;
        runeType = false
    else
        -- Rune used on its own
        local randTierChance = wanez.RNG({1,1000})
        local runeTier = 1 -- USABLE
        if(randTierChance <= 1 and optRuneData[3] >= 4)then -- LEGENDARY (0.1%)
            runeTier = 5
        elseif(randTierChance <= 10 and optRuneData[3] >= 3)then -- EPIC (1%)
            runeTier = 4
        elseif(randTierChance <= 100 and optRuneData[3] >= 2)then -- RARE (10%)
            runeTier = 3
        elseif(optRuneData[3] >= 1)then -- COMMON
            runeTier = 2
        end
        --_player:GiveItem(genRunePath(optRuneData[1],optRuneData[2],runeTier),1,false)
        runeDBR = genRunePath(optRuneData[1],optRuneData[2],runeTier)
    end

    return runeDBR;
end
--- checks if sequence is an inscription
-- give the correct items to the player
-- specific to wanez.Runes.crafting.useRune()
local function getInscriptionDBR()
    local aActions = {}
    aActions.Notify = 'tagWaRunes_SequenceFailed'

    local aPosIns = {}
    local aIns = wanez.Runes._Data.Inscriptions[runeType]
    local nextCheck = true
    local isGeneric = aStoneData[2] or 'generic'
    for i=1,table.getn(aIns) do
        if(aIns[i].Stone[1] ~= aStoneData[1])then
            nextCheck = false
        end
        if(nextCheck and aStoneData[2])then
            if(aStoneData[2] ~= aIns[i].Stone[2])then nextCheck = false;end;
        end
        if(nextCheck and table.getn(aIns[i].Runes) == aStoneData[3])then
            -- sockets and rune check
            for j=1,table.getn(aRuneSequence) do
                if(aRuneSequence[j] ~= aIns[i].Runes[j])then
                    nextCheck = false
                end
            end;
        end

        -- add inscription ID to array if nothing interrupted the checks
        if(nextCheck)then table.insert(aPosIns,i);end;
        nextCheck = true -- reset check var
    end;

    -- determine which inscription to use
    local inscriptionCount = table.getn(aPosIns)
    local pathIns = 'mod_wanez/_runes/items/enchants/'
    --local inscriptionDBR_ = false
    local InscriptionID = 0
    -- get inscription FileName
    if(inscriptionCount > 1)then
        -- multiple insciptions are possible with the current sequence
        local sumRatio = 0
        local aRatios = {}
        for i=1,inscriptionCount do
            sumRatio = sumRatio + aIns[aPosIns[i]].Ratio
            table.insert(aRatios,aIns[aPosIns[i]].Ratio)
        end;
        InscriptionID = aPosIns[wanez.RNG({1,sumRatio},aRatios)]
    elseif(inscriptionCount == 1)then
        -- only one inscription possible with the current sequence
        InscriptionID = aPosIns[1]
    end
    --
    if(InscriptionID ~= 0)then
        local tierLetter = {'a','b','c','d','e'}
        local insTier = 1 -- COMMON
        if(aStoneData[2])then -- only perform chance check if stone wasnt generic
            local randTierChance = wanez.RNG({1,1000})
            if(randTierChance <= 1 and aIns[InscriptionID].Tiers >= 4)then -- LEGENDARY (0.1%)
            insTier = 4
            elseif(randTierChance <= 10 and aIns[InscriptionID].Tiers >= 3)then -- EPIC (1%)
            insTier = 3
            elseif(randTierChance <= 100 and aIns[InscriptionID].Tiers >= 2)then -- RARE (10%)
            insTier = 2
            end
        end
        aActions.GiveItem = pathIns..wanez.replace(aIns[InscriptionID].FileName,{tierLetter[insTier]})..'.dbr'
        if(aIns[InscriptionID].Tiers == insTier)then
            aActions.Notify = 'tagWaRunes_SequenceSuccessMax'
        else
            aActions.Notify = 'tagWaRunes_SequenceSuccess'
        end
    end

    return aActions;
end
-- NPC
function wanez.Runes.crafting.resetSequence()
    if(aStoneData)then
        wanez.giveItems(getStoneDBR()) -- give back stone
        wanez.giveItems(getRuneDBR()) -- give back runes
        aStoneData = false -- reset stone data
        runeType = false -- reset runes type
        aRuneSequence = {} -- reset runeSequence
    else
        UI.Notify('tagWaRunesMsg_NoSequence')
    end
end
-- ITEM
function wanez.Runes.crafting.startSequence(argStoneSlot,argStoneType,argStoneSockets)
    wanez.scroll.fnCall = function()
        local aActions = {}
        --
        if(aStoneData)then
            aActions.GiveItem = getStoneDBR(argStoneSlot,argStoneType,argStoneSockets)
            --getStoneDBR(argStoneSlot,argStoneType,argStoneSockets)
            aActions.Notify('tagWaRunesMsg_SequenceInProgress')
        else
            -- set aBaseItem
            aStoneData = {argStoneSlot,argStoneType,argStoneSockets }
            aActions.Notify('tagWaRunesMsg_SequenceStarted')
        end

        return aActions;
    end;
end
-- ITEM
local defaultSeed = false
function wanez.Runes.crafting.useRune(argRuneType,argRuneId,argUpgradeCount)
    wanez.scroll.fnCall = function()
        local aActions = {}

        if not(defaultSeed)then -- set new seed if this is the first time using a rune in a session
            math.randomseed(Time.Now())
        end
        if(wanez.RNG({1,10},1))then -- randomized new seed, to avoid a new seed with every rune use
            math.randomseed(Time.Now())
        end

        if(aStoneData)then -- sequence has been started
            -- check if runeType is set and set it if not
            if not(runeType)then runeType = argRuneType;end;
            -- check if it is the same runeType
            if(runeType == argRuneType)then
                -- add to sequence (same runeType)
                table.insert(aRuneSequence,argRuneId)
                -- check if all sockets are filled
                if(table.getn(aRuneSequence) == aStoneData[3])then
                    aActions = getInscriptionDBR()
                    --wanez.Runes.crafting.resetSequence() -- dev: will give back the used items
                    aStoneData = false -- reset stone data
                    runeType = false -- reset runes type
                    aRuneSequence = {} -- reset runeSequence
                end;
            else
                -- give back rune scroll (different runeType)
                aActions.GiveItem = getRuneDBR({argRuneType,argRuneId,0})
                --table.insert(aActions.GiveItem,getRuneDBR({argRuneType,argRuneId,0}))
            end
        else -- no sequence
            -- give back rune as a component
            aActions.GiveItem = getRuneDBR({argRuneType,argRuneId,argUpgradeCount})
            --table.insert(aActions.GiveItem,getRuneDBR({argRuneType,argRuneId,argUpgradeCount}))
        end

        return aActions;
    end;
end
