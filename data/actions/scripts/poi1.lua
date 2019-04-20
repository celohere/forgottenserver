-- poi1 Quest --

function onUse(cid, item, frompos, item2, topos)
if item.uid == 2358 then
  queststatus = getPlayerStorageValue(cid,6132)
  if queststatus == -1 or queststatus == 0 then
   doPlayerSendTextMessage(cid,22,"You have found a soft boots.")
   item_uid = doPlayerAddItem(cid,6132,1)
   setPlayerStorageValue(cid,6132,1)

  else
   doPlayerSendTextMessage(cid,22,"it\'s empty.")
  end
else
  return 0
end
return 1
end

