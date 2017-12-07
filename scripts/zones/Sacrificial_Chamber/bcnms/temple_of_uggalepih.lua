-----------------------------------
-- Area: Sacrificial Chamber
-- Name: Zilart Mission 4
-----------------------------------
package.loaded["scripts/zones/Sacrificial_Chamber/TextIDs"] = nil;
-------------------------------------

require("scripts/globals/titles");
require("scripts/globals/battlefield")
require("scripts/globals/keyitems");
require("scripts/globals/missions");
require("scripts/zones/Sacrificial_Chamber/TextIDs");

-- After registering the BCNM via bcnmRegister(bcnmid)
function onBattlefieldRegister(player,battlefield)
end;
function onBattlefieldTick(battlefield, tick)
    g_Battlefield.onBattlefieldTick(battlefield, tick)
end

-- Physically entering the BCNM via bcnmEnter(bcnmid)
function onBattlefieldEnter(player,battlefield)
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
        if (player:getCurrentMission(ZILART) == THE_TEMPLE_OF_UGGALEPIH) then
            player:startEvent(32001,battlefield:getArea(),clearTime,partySize,battlefield:getTimeInside(),1,battlefield:getLocalVar("[cs]bit"),0);
        else
            player:startEvent(32001,battlefield:getArea(),clearTime,partySize,battlefield:getTimeInside(),1,battlefield:getLocalVar("[cs]bit"),0);
        end
    elseif (leavecode == 4) then
        player:startEvent(32002);
    end

end;

function onEventUpdate(player,csid,option)
    -- print("bc update csid "..csid.." and option "..option);
end;

function onEventFinish(player,csid,option)
-- print("bc finish csid "..csid.." and option "..option);

    if (csid == 32001) then
        player:addTitle(BEARER_OF_THE_WISEWOMANS_HOPE);
        if (player:getCurrentMission(ZILART) == THE_TEMPLE_OF_UGGALEPIH) then
            player:startEvent(7);
        end
    elseif (csid == 7) then
        player:startEvent(8);
    elseif (csid == 8) then
        if (player:getCurrentMission(ZILART) == THE_TEMPLE_OF_UGGALEPIH) then
            player:delKeyItem(SACRIFICIAL_CHAMBER_KEY);
            player:addKeyItem(DARK_FRAGMENT);
            player:messageSpecial(KEYITEM_OBTAINED,DARK_FRAGMENT);
            player:completeMission(ZILART,THE_TEMPLE_OF_UGGALEPIH);
            player:addMission(ZILART,HEADSTONE_PILGRIMAGE);
        end
    end

end;