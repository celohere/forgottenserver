-- poi4 Quest --

function onUse(cid, item, frompos, item2, topos)
if item.uid == 5791 then
  queststatus = getPlayerStorageValue(cid,5791)
  if queststatus == -1 or queststatus == 0 then
   doPlayerSendTextMessage(cid,22,"You have found a stuffed dragon.")
   item_uid = doPlayerAddItem(cid,5791,1)
   setPlayerStorageValue(cid,5791,1)

  else
   doPlayerSendTextMessage(cid,22,"it\'s empty.")
  end
else
  return 0
end
return 1
end

