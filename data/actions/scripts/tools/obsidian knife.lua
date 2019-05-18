function onUse(cid, item, fromPosition, itemEx, toPosition)
   local player = Player(cid)
   
   local skinning =    {
               {monster = "Killer Caiman",        corpse = 11431, after = 11432,    skin = 11429,    chance = 40,    storage = false, special = false, WaitTime = false, achievement = false},
               {monster = "Dragon",            corpse = 3104,    after = 3105,    skin = 5877,    chance = 40,    storage = false, special = false, WaitTime = false, achievement = false},
               {monster = "Dragon Lord",          corpse = 2881,   after = 2882,    skin = 5948,    chance = 40,    storage = false, special = false, WaitTime = false, achievement = false},             
               {monster = "Bonebeast",          corpse = 3031,   after = 3032,    skin = 5925,    chance = 40,    storage = false, special = false, WaitTime = false, achievement = false},
               {monster = "Behemoth",            corpse = 2931,   after = 2932,    skin = 5893,    chance = 40,    storage = false, special = false, WaitTime = false, achievement = false},
               {monster = "Lizard Sentinel",        corpse = 4259,   after = 4260,    skin = 5876,    chance = 40,    storage = false, special = false, WaitTime = false, achievement = false},
               {monster = "Lizard Templar",        corpse = 4256,    after = 4257,    skin = 5876,    chance = 40,    storage = false, special = false, WaitTime = false, achievement = false},   
               {monster = "Lizard Snakecharmer",      corpse = 4262,   after = 4263,    skin = 5876,    chance = 40,    storage = false, special = false, WaitTime = false, achievement = false},
               {monster = "Minotaur",            corpse = 3090,   after = 3091,    skin = 5878,    chance = 40,    storage = false, special = false, WaitTime = false, achievement = false},
               {monster = "Minotaur Archer",        corpse = 2871,   after = 2872,    skin = 5878,    chance = 40,    storage = false, special = false, WaitTime = false, achievement = false},
               {monster = "Minotaur Mage",        corpse = 2866,   after = 2867,    skin = 5878,    chance = 40,    storage = false, special = false, WaitTime = false, achievement = false},
               {monster = "Minotaur Guard",        corpse = 2876,   after = 2877,    skin = 5878,    chance = 40,    storage = false, special = false, WaitTime = false, achievement = false},
   
   
             }
               
             
             
       for k, v in pairs(skinning) do   
         if (v.corpse == itemEx.itemid) then
         local iEx = Item(itemEx.uid)
           if (v.skin ~= false) and (v.special == false) then
             if v.after ~= false then
               iEx:transform(v.after)
             else
               if (v.storage ~= false) then
                 if player:getStorageValue(v.storage) == 1 then
                   return false
                 end                 
                 player:setStorageValue(v.storage, 1)
               end   
             end
               
             if math.random(1, 100) <= v.chance then
               toPosition:sendMagicEffect(CONST_ME_MAGIC_GREEN)
               player:addItem(v.skin, 1, true)   
             else
               toPosition:sendMagicEffect(CONST_ME_BLOCKHIT)
             end   
           elseif ((v.skin == false) and (v.special == false) and (v.after ~= false)) then
             
             if math.random(1, 100) <= v.chance then
               iEx:transform(v.after)
               toPosition:sendMagicEffect(CONST_ME_MAGIC_GREEN)
             else
               toPosition:sendMagicEffect(CONST_ME_BLOCKHIT)
               iEx:remove(1, true)
             end       
           elseif ((v.skin == false) and (v.special == true)) then   
             for id, value in pairs(especial) do
               if tostring(id):lower() == tostring(v.monster):lower() then
                 if (player:getStorageValue(v.storage) - os.time() <= 0) then
                   local time = os.time() + ( v.WaitTime )
                   player:setStorageValue(v.storage, time)   
                     local rewards = {}
                       rewards.id = id
                         for inf, it in pairs(value) do
                           rewards[inf] = it
                         end   
                       local RandomItem = rewards[math.random(1, #rewards)]     
         
                       player:addItem(RandomItem.itemid, RandomItem.Count, true)   
                       player:say("You found a " .. RandomItem.itemname .. ".", TALKTYPE_ORANGE_1)                   
                 else
                   player:say("You already used your knife on the corpse.", TALKTYPE_ORANGE_1)
                   return false
                 end                
               end
             end

           end
           break
       end
     end

   return true
end