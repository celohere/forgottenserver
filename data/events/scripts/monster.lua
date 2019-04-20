function Monster:onSpawn(pos, forced)
	self:registerEvent("DropMonsterLoot")

	return true
end