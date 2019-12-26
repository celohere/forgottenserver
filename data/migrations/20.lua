function onUpdateDatabase()
    print("> Updating database to version 21 (server_record)")
	
	    db.query("CREATE TABLE IF NOT EXISTS `server_record` (`record` INT NOT NULL, `timestamp` BIGINT NOT NULL, UNIQUE (`record`, `timestamp`)) ENGINE = InnoDB;")
		
    return true
end
