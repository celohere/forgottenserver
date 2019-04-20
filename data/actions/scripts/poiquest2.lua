function onUse(cid, item, frompos, item2, topos)
gatepos = {x=359, y=450, z=9, stackpos=1}
getgate = getThingfromPos(gatepos)

if item.uid == 2556 and item.itemid == 1945 and getgate.itemid == 1304 then
doRemoveItem(getgate.uid,1)
doPlayerSendTextMessage(cid,22,"A stone was removed not too far away.")
doTransformItem(item.uid,item.itemid+1)
elseif item.uid == 2556 and item.itemid == 1946 and getgate.itemid == 0 then
doCreateItem(1304,1,gatepos)
doPlayerSendTextMessage(cid,22,"The stone was moved back not too far away.")
doTransformItem(item.uid,item.itemid-1)
else
doPlayerSendCancel(cid,"Sorry not possible.")
end
  return 1
  end