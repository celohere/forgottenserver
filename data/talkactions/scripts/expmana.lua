function onSay(player, words, param)
local p = player
local s = function(p, lv)
       local k = Game.getExperienceStage(lv)
       local st = p:getStamina()
         if st > 2400 then
           return k*1.5 .. " (stamina bonus)"
         elseif st < 1 then
           return 0 .. " (out of stamina)"
         elseif st < 841 then
           return k*0.5 .. " (stamina penalty)"
         else
           return k
         end
       end

   if words == "!exp" then
     local lv = p:getLevel()
     p:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You need " .. ((50 * lv^3) - (150 * lv^2) + (400 * lv)) / 3 - p:getExperience() .. " experience more, for " .. lv+1 .. " level.")
     p:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Current rate: x" .. s(p, lv))
     return false
   end
  p:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You have to spend " .. math.ceil((p:getVocation():getRequiredManaSpent(p:getBaseMagicLevel() + 1) - p:getManaSpent()) / configManager.getNumber(configKeys.RATE_MAGIC))  .. " mana more, for next magic level.")
return false
end