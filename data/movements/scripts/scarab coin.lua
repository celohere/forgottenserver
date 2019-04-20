function onAddItem(moveitem, tileitem, pos) 
beforepos = {x=348,y=448,z=7,stackpos=253} 
before = getThingfromPos(beforepos) 
telepos = {x=348,y=446,z=8} 
apos = {x=348,y=447,z=8} 
if moveitem.itemid == 1903 then 
if pos.x == apos.x and pos.y == apos.y and pos.z == apos.z then 
if before.itemid > 0 then 
doTeleportThing(before.uid,telepos) 
doSendMagicEffect(beforepos,12) 
doSendMagicEffect(telepos,10) 
doSendMagicEffect(pos,15)  
doRemoveItem(moveitem.uid,moveitem.type) 
else 
doSendMagicEffect(pos,15) 
doRemoveItem(moveitem.uid,moveitem.type) 
end 
end 
end 
return 1 
end