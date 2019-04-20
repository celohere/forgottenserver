function onUse(cid, item, frompos, item2, topos)
gatepos = {x=348, y=446, z=8, stackpos=1}
getgate = getThingfromPos(gatepos)
if item.uid == 2319 then
doTeleportThing(cid, gatepos)
doSendMagicEffect(gatepos, 10)
end
return 1
end
