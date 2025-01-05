function onUpdateDatabase()
	print("> Updating database to version 22 (Multi World)")
	db.query("ALTER TABLE `players` ADD COLUMN `world_id` int(10) unsigned NOT NULL DEFAULT 1")
	db.query("ALTER TABLE `players_online` ADD COLUMN `world_id` int(10) unsigned NOT NULL DEFAULT 1")
	db.query("ALTER TABLE `player_deaths` ADD COLUMN `world_id` int(10) unsigned NOT NULL DEFAULT 1")
	db.query("ALTER TABLE `guilds` ADD COLUMN `world_id` int(10) unsigned NOT NULL DEFAULT 1")
	db.query("ALTER TABLE `market_offers` ADD COLUMN `world_id` int(10) unsigned NOT NULL DEFAULT 1")
	db.query("CREATE TABLE IF NOT EXISTS `servers` ( `id` int(11) NOT NULL AUTO_INCREMENT, `name` varchar(32) NOT NULL DEFAULT 'Server Name', `ip` varchar(32) NOT NULL DEFAULT '127.0.0.1', `port` int(11) NOT NULL DEFAULT '7172', `world_id` int(11) NOT NULL DEFAULT '0', PRIMARY KEY (`id`) ) ENGINE=InnoDB;")
	return true
end
