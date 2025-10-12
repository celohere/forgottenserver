function onUpdateDatabase()
    print("> Updating database to version 21 (server_record)")
	
    db.query("CREATE TABLE IF NOT EXISTS `server_record` (`world_id` INT NOT NULL DEFAULT 0, `record` INT NOT NULL, `timestamp` BIGINT NOT NULL, UNIQUE KEY (`world_id`, `record`, `timestamp`)) ENGINE = InnoDB;")
		
    return true
end
