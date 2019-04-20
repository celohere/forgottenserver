function onUse(cid, item, frompos, item2, topos)

playerpos = getPlayerPosition(cid)
novapos = {x=294, y=480, z=11}

if getPlayerStorageValue(cid,1234561) == -1 or getPlayerStorageValue(cid,1234562) == -1 or getPlayerStorageValue(cid,1234563) == -1 or getPlayerStorageValue(cid,1234564) == -1 or getPlayerStorageValue(cid,1234565) == -1 then
  doPlayerSendTextMessage(cid,22,'The door seems to be sealed against unwanted intruders.')
else
  doTransformItem(item.uid,item.itemid)
getThingfromPos(playerpos) 
doTeleportThing(cid,novapos)

end
return 1
end
