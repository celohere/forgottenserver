local combat = Combat()
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ENERGY)
combat:setParameter(COMBAT_PARAM_CREATEITEM, ITEM_WILDGROWTH)

local time = 40

local function countDown(cid, position, time)
    local player = Player(cid)
    if not player or time == 0 then
        return
    end
      
    player:say(time, TALKTYPE_MONSTER_SAY, false, 0, position)
    addEvent(countDown, 1000, cid, position, time - 1)
end

function onCastSpell(creature, variant, isHotkey)
    countDown(creature.uid, Variant.getPosition(variant), 40)
	return combat:execute(creature, variant)
end
