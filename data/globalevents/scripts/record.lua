function onRecord(current, old)
	db.query("INSERT INTO `server_record` (`record`, `timestamp`) VALUES (" .. current .. ", " .. os.time() .. ");")
	addEvent(broadcastMessage, 150, "New record: " .. current .. " players are logged in.", MESSAGE_STATUS_WARNING)
	return true
end
