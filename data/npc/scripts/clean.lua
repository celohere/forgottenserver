local CLEAN_FREQUENCE = 21600 -- seconds
 
local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local cleanTimer = CLEAN_FREQUENCE / 2 -- onThink for npc is fired every 2 seconds
 
function onCreatureAppear(cid)          npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)       npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)  npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()
    cleanTimer = cleanTimer - 1
    if cleanTimer == 150 then
        broadcastMessage("Game map cleaning in 5 minutes.");
    elseif cleanTimer == 90 then
        broadcastMessage("Game map cleaning in 3 minutes.");
    elseif cleanTimer == 30 then
        broadcastMessage("Game map cleaning in 1 minute, please pick up your items!");
    elseif cleanTimer == 0 then
        cleanMap()
        cleanTimer = CLEAN_FREQUENCE / 2
    end
 
    npcHandler:onThink()
end
 
npcHandler:addModule(FocusModule:new())