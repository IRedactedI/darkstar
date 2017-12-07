-----------------------------------
-- Area: Riverne Site #B01
-- Name: Storms of Fate
-- !pos 299 -123 345 146
-----------------------------------
package.loaded["scripts/zones/Riverne-Site_B01/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/missions");
require("scripts/zones/Riverne-Site_B01/TextIDs");
require("scripts/globals/quests");
require("scripts/globals/status");
require("scripts/globals/bcnm");
require("scripts/globals/battlefield")
-----------------------------------

function onBattlefieldTick(battlefield, tick)
    g_Battlefield.onBattlefieldTick(battlefield, tick)
end

-- After registering the BCNM via bcnmRegister(bcnmid)
function onBattlefieldRegister(player,battlefield)
end;

-- Physically entering the BCNM via bcnmEnter(bcnmid)
function onBattlefieldEnter(player,battlefield)
    player:delStatusEffect(EFFECT_LEVEL_RESTRICTION); -- can't be capped at 50 for this fight !
end;

-- Leaving the BCNM by every mean possible, given by the LeaveCode
-- 1=Select Exit on circle
-- 2=Winning the BC
-- 3=Disconnected or warped out
-- 4=Losing the BC
-- via bcnmLeave(1) or bcnmLeave(2). LeaveCodes 3 and 4 are called
-- from the core when a player disconnects or the time limit is up, etc

function onBattlefieldLeave(player,battlefield,leavecode)
-- print("leave code "..leavecode);

    if leavecode == 2 then -- play end CS. Need time and battle id for record keeping + storage
        local name, clearTime, partySize = battlefield:getRecord()
        if (player:getQuestStatus(JEUNO,STORMS_OF_FATE) == QUEST_COMPLETED) then
            player:startEvent(32001,battlefield:getArea(),clearTime,partySize,battlefield:getTimeInside(),1,battlefield:getLocalVar("[cs]bit"),1);
        else
            player:startEvent(32001,battlefield:getArea(),clearTime,partySize,battlefield:getTimeInside(),1,battlefield:getLocalVar("[cs]bit"),0);
        end
    elseif (leavecode == 4) then
        player:startEvent(32002);
    end

    if (ENABLE_COP_ZONE_CAP == 1) then -- restore level cap on exit if the setting is enabled
        player:addStatusEffect(EFFECT_LEVEL_RESTRICTION, 50, 0, 0);
    end;
end;

function onEventUpdate(player,csid,option)
-- print("bc update csid "..csid.." and option "..option);
end;

function onEventFinish(player,csid,option)
-- print("bc finish csid "..csid.." and option "..option);

    if (csid == 32001) then
        if (player:getQuestStatus(JEUNO,STORMS_OF_FATE) == QUEST_ACCEPTED and player:getVar('StormsOfFate') == 2) then
            player:addKeyItem(WHISPER_OF_THE_WYRMKING);
            player:messageSpecial(KEYITEM_OBTAINED,WHISPER_OF_THE_WYRMKING);
            player:setVar('StormsOfFate',3);
            player:addTitle(CONQUEROR_OF_FATE);
            if (ENABLE_COP_ZONE_CAP == 1) then -- restore level cap on exit if the setting is enabled
                player:addStatusEffect(EFFECT_LEVEL_RESTRICTION, 50, 0, 0);
            end;
        end
    end

end;