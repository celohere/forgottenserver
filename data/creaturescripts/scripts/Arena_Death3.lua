function onLogin(cid)
cid:registerEvent("Arena_Death3")
return true
end
 
local arena = {
     from = {x=2341, y=2711, z=12}, -- left top corner of  arena
     to = {x=2348, y=2717, z=12}, -- right bottom corner of  arena
     temple = { x = 2344, y = 2708, z = 11 } -- change it to exit pos
 
	 }
	 
	 
	 
function onPrepareDeath(cid, killer)
    if isInRange(getPlayerPosition(cid), arena.from,arena.to) then
        if isPlayer(cid) then

            cid:sendTextMessage(MESSAGE_STATUS_WARNING,"[PVP Arena]: You have been defeated by " .. getCreatureName(killer,cid) .. ". You sux.")
            Player(cid):addHealth(Player(cid):getMaxHealth())
            Player(cid):teleportTo(arena.temple, true)
            Player(killer):sendTextMessage(MESSAGE_STATUS_WARNING,"[PVP Arena]: You have defeated " .. getCreatureName(cid,killer) .. ". You are the best Fighter.")
            Player(killer):addHealth(Player(cid):getMaxHealth())
		    Player(killer):teleportTo(arena.temple, true)
            return false
        end
    end
   return true
end
 
function isInRange(pos, fromPos, toPos)
   return pos.x >= fromPos.x and pos.y >= fromPos.y and pos.z >= fromPos.z and pos.x <= toPos.x and pos.y <= toPos.y and pos.z <= toPos.z
end