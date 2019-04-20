function onUse(cid, item, frompos, item2, topos)
gatepos = {x=329, y=119, z=7, stackpos=255}
getgate = getThingfromPos(gatepos)

if item.uid == 9010 and item.itemid == 1945 and getgate.itemid == 0 then
doCreateItem(411,1,gatepos)
doTransformItem(item.uid,item.itemid+1)
doPlayerSendTextMessage(cid,22,"A Stair was created not too far away.")
elseif item.uid == 9010 and item.itemid == 1946 and getgate.itemid == 411 then
doRemoveItem(getgate.uid,2)
doPlayerSendTextMessage(cid,22,"A Stair was removed not too far away.")
doTransformItem(item.uid,item.itemid-2)
else
doPlayerSendCancel(cid,"Sorry not possible.")
end
  return 1
  end


