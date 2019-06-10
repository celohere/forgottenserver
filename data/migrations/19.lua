function onUpdateDatabase()
    print("> Updating database to version 20 (player_bans)")

    db.query("CREATE TABLE IF NOT EXISTS `player_bans` (`id` INT UNSIGNED NOT NULL AUTO_INCREMENT, `player_id` int(11) NOT NULL, `reason` varchar(255) NOT NULL, `banned_at` bigint(20) NOT NULL, `expires_at` bigint(20) NOT NULL, `banned_by` int(11) NOT NULL, PRIMARY KEY (`id`), KEY (`player_id`), KEY `banned_by` (`banned_by`), FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY (`banned_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE) ENGINE=InnoDB")

    return true
end
