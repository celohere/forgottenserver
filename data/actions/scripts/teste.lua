--action by Wallaby for OT 7.6--

-- Variaveis usadas:

-- nplayer?pos  = para onde o player sera teletransportado.
--

function onUse(cid, item, frompos, item2, topos)
if item.uid == 9999 then
if item.itemid == 1847 then

  nplayer1pos = {x=744, y=925, z=7}

  doTeleportThing(cid,nplayer1pos)

  doSendMagicEffect(nplayer1pos,10)

  doSendMagicEffect(topos,6)

  doSendMagicEffect(frompos,6)

end
end
return 1
end