local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
 setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_DRAWBLOOD)
 setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, 27)
 setCombatFormula(combat, COMBAT_FORMULA_SKILL, 0.3, 0, 0.6, 0)
 

function onCastSpell(cid, var)
return doCombat(cid, combat, var)
end  
