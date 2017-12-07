-----------------------------------
-- Name: Mission 9-2 SANDO
-----------------------------------
package.loaded["scripts/zones/Qubia_arena/TextIDs"] = nil;
-------------------------------------

require("scripts/globals/keyitems");
require("scripts/globals/missions");
require("scripts/zones/QuBia_Arena/TextIDs");
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
end;

-- Leaving the BCNM by every mean possible, given by the LeaveCode
-- 1=Select Exit on circle
-- 2=Winning the BC
-- 3=Disconnected or warped out
-- 4=Losing the BC
-- via bcnmLeave(1) or bcnmLeave(2). LeaveCodes 3 and 4 are called
-- from the core when a player disconnects or the time limit is up, etc

function onBattlefieldLeave(player,battlefield,leavecode)
    --print("leave code "..leavecode);
    local currentMission = player:getCurrentMission(SANDORIA);
    if leavecode == 2 then
        local name, clearTime, partySize = battlefield:getRecord()
        --printf("win");
        if (currentMission == THE_HEIR_TO_THE_LIGHT)    then
            player:startEvent(32001,battlefield:getArea(),clearTime,partySize,battlefield:getTimeInside(),1,battlefield:getLocalVar("[cs]bit"),0);
        else
            player:startEvent(32001,battlefield:getArea(),clearTime,partySize,battlefield:getTimeInside(),1,battlefield:getLocalVar("[cs]bit"),1);
        end
    elseif (leavecode == 4) then
        player:startEvent(32002);
    end
end;

function onEventUpdate(player,csid,option)
    --print("bc update csid "..csid.." and option "..option);
end;

function onEventFinish(player,csid,option)
    --print("bc finish csid "..csid.." and option "..option);
    local currentMission = player:getCurrentMission(SANDORIA);
    local MissionStatus = player:getVar("MissionStatus");

    if (csid == 32001) then
        if (currentMission == THE_HEIR_TO_THE_LIGHT and MissionStatus == 3)    then
            player:setVar("MissionStatus",4);
        end
    end
end;