-- poi4 Quest --

function onUse(cid, item, frompos, item2, topos)
if item.uid == 1900 then
  queststatus = getPlayerStorageValue(cid,1900)
  if queststatus == -1 or queststatus == 0 then
   doPlayerSendTextMessage(cid,22,"You have found a backpack of holding.")
   item_uid = doPlayerAddItem(cid,2365,1)
   setPlayerStorageValue(cid,1900,1)

  else
   doPlayerSendTextMessage(cid,22,"it\'s empty.")
  end
else
  return 0
end
return 1
end

