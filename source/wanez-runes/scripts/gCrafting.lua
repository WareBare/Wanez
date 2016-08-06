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
                aReplace[2] = (j <= 9) and '0'..j or j

                for k=0,9 do
                    aReplace[4] = '0'..k

                    local whileTrue = true
                    while(whileTrue)do
                        if(_player:HasItem(wanez.replace(tmpFile,aReplace),1,true))then
                            tracker = tracker + j * matMul
                            _player:TakeItem(wanez.replace(tmpFile,aReplace),1,true)
                        else
                            whileTrue = false
                        end
                    end
                end;
            end;
        end;

        UI.Notify(math.floor(tracker))

        return aActions;
    end
end
--
function wanez.Runes.crafting.useRune(argRuneType,argRuneId)
    local dbr = wanez.Runes._Data.Runes[argRuneType][argRuneId]
end
