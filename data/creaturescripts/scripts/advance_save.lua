local config = {
	heal = true,
	save = true,
	effect = false
}

function onAdvance(player, skill, oldLevel, newLevel)
	if skill ~= SKILL_LEVEL or newLevel <= oldLevel then
		return true
	end

	if config.save then
		player:save()
	end
	return true
end
