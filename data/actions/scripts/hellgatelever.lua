function onUse(cid, item, frompos, item2, topos)
gatepos = {x=71, y=260, z=7, stackpos=1}
getgate = getThingfromPos(gatepos)

if item.uid == 5044 and item.itemid == 1945 and getgate.itemid == 1498 then
doRemoveItem(getgate.uid,1)
doTransformItem(item.uid,item.itemid+1)
doPlayerSendTextMessage(cid,22,"A magic wall disapeared not too far away.")
elseif item.uid == 5044 and item.itemid == 1946 and getgate.itemid == 0 then
doCreateItem(1498,1,gatepos)
doPlayerSendTextMessage(cid,22,"A magic wall was created not too far away.")
doTransformItem(item.uid,item.itemid-1)
else
doPlayerSendCancel(cid,"Sorry not possible.")
end
  return 1
  end
