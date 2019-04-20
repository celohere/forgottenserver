function onUse(cid, item, frompos, item2, topos)
gatepos = {x=411, y=435, z=9, stackpos=1}
getgate = getThingfromPos(gatepos)

if item.uid == 1819 and item.itemid == 1945 and getgate.itemid == 0 then
doCreateItem(1386,1,gatepos)
doTransformItem(item.uid,item.itemid+1)
doPlayerSendTextMessage(cid,22,"A stair was created not too far away.")
elseif item.uid == 1819 and item.itemid == 1946 and getgate.itemid == 1386 then
doRemoveItem(getgate.uid,1)
doPlayerSendTextMessage(cid,22,"A stair disapeared not too far away.")
doTransformItem(item.uid,item.itemid-1)
else
doPlayerSendCancel(cid,"Sorry not possible.")
end
  return 1
  end
