--Action by fakezin--
function onUse(cid, item, fromPosition, item2, topos)

 

rand = math.random(1, 4)

if rand == 1 then

doRemoveItem(item.uid,1)

doPlayerAddItem(cid,2006,10)

doSendMagicEffect(fromPosition, CONST_ME_MAGIC_RED)

doPlayerSendTextMessage(cid, 22, "Has transformed into Blood")

 

elseif rand == 2 then

doRemoveItem(item.uid,1)

doPlayerAddItem(cid,2006,2)

doSendMagicEffect(fromPosition, CONST_ME_MAGIC_RED)

doPlayerSendTextMessage(cid, 22, "Has transformed into Life Fluid")

 

elseif rand == 3 then

doRemoveItem(item.uid,1)

doPlayerAddItem(cid,2006,7)

doSendMagicEffect(fromPosition, CONST_ME_MAGIC_RED)

doPlayerSendTextMessage(cid, 22, "Has transformed into Mana Fluid")

 

elseif rand == 4 then

doRemoveItem(item.uid,1)

doPlayerAddItem(cid,2006,4)

doSendMagicEffect(fromPosition, CONST_ME_MAGIC_RED)

doPlayerSendTextMessage(cid, 22, "Has transformed into Slime")

 

end

end
