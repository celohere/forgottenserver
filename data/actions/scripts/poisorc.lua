function onUse(cid, item, frompos, item2, topos)
gatepos = {x=394, y=447, z=9, stackpos=1}
getgate = getThingfromPos(gatepos)

if item.uid == 6462 and item.itemid == 1945 and getgate.itemid == 3361 then
doRemoveItem(getgate.uid,1)
doPlayerSendTextMessage(cid,22,"A wall disapeared not too far away.")
doTransformItem(item.uid,item.itemid+1)
elseif item.uid == 6462 and item.itemid == 1946 and getgate.itemid == 0 then
doCreateItem(3361,1,gatepos)
doPlayerSendTextMessage(cid,22,"A wall appeared not too far away.")
doTransformItem(item.uid,item.itemid-1)
else
doPlayerSendCancel(cid,"Sorry not possible.")
end
  return 1
  end