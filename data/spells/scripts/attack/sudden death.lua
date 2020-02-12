local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_DEATH)
function onGetFormulaValues(cid, level, maglevel)
	min = -(level * 3.88 + maglevel * 4.60)
	max = -(level * 4.24 + maglevel * 5.34)
	return min, max
end

setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(cid, var, isHotkey)
    local tile = Tile(var.getPosition(var))
    if tile and tile:getTopCreature() then
        return combat:execute(cid, var)
    end

    cid:sendCancelMessage("You can only use this rune on creatures.")
    cid:getPosition():sendMagicEffect(CONST_ME_POFF)
    return false
end
