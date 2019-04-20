--function by Armageddom--
function onStepIn(cid, item, frompos, item2, topos) 

playerpos = getPlayerPosition(cid) 
novapos = {x=254, y=279, z=8} 
msg = "Você foi teleportado para Pits of Inferno."

if item.uid == 8045 then 

getThingfromPos(playerpos) 
doSendMagicEffect(playerpos,2) 
doTeleportThing(cid,novapos) 
doSendMagicEffect(novapos,10) 
doPlayerSendTextMessage(cid, 22, msg)
end 
end