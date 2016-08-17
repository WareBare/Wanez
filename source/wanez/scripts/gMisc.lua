--[[
Created by IntelliJ IDEA.
User: WareBare
Date: 8/4/2016
Time: 5:18 AM

Package: Wanez
]]--


-- Wanez RNG with chances
function wanez.RNG(optRange,argChance)
    optRange[1] = optRange[1] or 1
    optRange[2] = optRange[2] or 100
    local rand = math.random(optRange[1],optRange[2])
    if(argChance ~= nil)then
        if(tonumber(argChance))then
            rand = (rand <= argChance) and true or false
        elseif(type(argChance) == "table")then
            local totalChances = table.getn(argChance)
            local curChance = 0
            local retRand = 0
            for i=1,totalChances do
                curChance = curChance + argChance[i]
                if(rand <= curChance)then
                    if(retRand == 0)then retRand = i;end;
                    --i = totalChances + 1
                end
            end
            rand = retRand
        end
    end;

    return rand
end
-- argFaction: String Faction
function wanez.getFactionRank(argFaction)
    local factionRating = Game.GetLocalPlayer():GetFaction(argFaction)
    local FactionRank = 0
    if(factionRating >= 25000)then FactionRank = 4
    elseif(factionRating <= -20000 or factionRating >= 10000)then FactionRank = 3
    elseif(factionRating <= -8000 or factionRating >= 5000)then FactionRank = 2
    elseif(factionRating <= -1500 or factionRating >= 1500)then FactionRank = 1 end

    return FactionRank;
end
function wanez.giveItems(optItems,argUnique) -- TODO: argUnique
    local argUnique = argUnique or false
    local _player = Game.GetLocalPlayer()
    if(type(optItems) == 'table')then
        for i=1,table.getn(optItems) do
            _player:GiveItem(optItems[i],1,true)
        end;
    else
        _player:GiveItem(optItems,1,true)
    end
end

-- argSubject: String to replace
-- optReplacements: array - key: int search; value: string replacement
function wanez.replace(argSubject,optReplacements)
    local newStr_ = argSubject

    for i=1,table.getn(optReplacements) do
        newStr_ = newStr_:gsub('{'..i..'}',optReplacements[i])
    end;


    return tostring(newStr_);
end
