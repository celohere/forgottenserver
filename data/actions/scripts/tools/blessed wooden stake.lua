local skinning = {
  {monster = "Vampire",  corpse = 2956,  after = 2957,  skin = 5905, chance = 40 },
  {monster = "Demons",  corpse = 2916,  after = 2917,  skin = 5906, chance = 40 }
           }

function onUse(cid, item, fromPosition, itemEx, toPosition)
  for _, v in pairs(skinning) do
  if v.corpse == itemEx.itemid then
      local iEx = Item(itemEx.uid)
  if (math.random(1, 100) <= v.chance) then
  iEx:transform(v.after)
  toPosition:sendMagicEffect(CONST_ME_MAGIC_GREEN)
  Player(cid):addItem(v.skin, 1, true)
  else
  toPosition:sendMagicEffect(CONST_ME_BLOCKHIT)
  iEx:transform(v.after)
  end
  break
  end
  end

  return true
end