/**
 * The Forgotten Server - a free and open-source MMORPG server emulator
 * Copyright (C) 2016  Mark Samman <mark.samman@gmail.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 */

#include "otpch.h"

#include "protocollogin.h"

#include "outputmessage.h"
#include "tasks.h"

#include "configmanager.h"
#include "iologindata.h"
#include "ban.h"
#include <iomanip>
#include "game.h"
#include "account.h"

extern ConfigManager g_config;
extern IPList serverIPs;
extern Game g_game;
World world;

void ProtocolLogin::disconnectClient(const std::string& message)
{
	auto output = OutputMessagePool::getOutputMessage();

	output->addByte(0x0A);
	output->addString(message);
	send(output);

	disconnect();
}

void ProtocolLogin::getCharacterList(uint32_t accountName, const std::string& password)
{
	//std::cout << "Getting character list..." << std::endl;

	Account account;
	if (!IOLoginData::loginserverAuthentication(accountName, password, account)) {
		disconnectClient("Account number or password is not correct.");
		return;
	}

	auto output = OutputMessagePool::getOutputMessage();
	// Update premium days
	Game::updatePremium(account);

	const std::string& motd = g_config.getString(ConfigManager::MOTD);
	if (!motd.empty()) {
		// Add MOTD
		output->addByte(0x14);

		std::ostringstream ss;
		ss << g_game.getMotdNum() << "\n" << motd;
		output->addString(ss.str());
	}

	// Add char list
	output->addByte(0x64);

	uint8_t size = std::min<size_t>(std::numeric_limits<uint8_t>::max(), account.characters.size());
	output->addByte(size);

	//std::cout << "Character list:" << std::endl;
	for (uint8_t i = 0; i < size; i++) {
		//int count = i + 1;
		//std::cout << "Character " << count << ": " << account.characters[i] << std::endl;

		// Getting world name from database
		std::string worldName = IOLoginData::getWorldNameById(account.world[i]); // Pass only the world ID

		if (worldName.empty()) {
			std::cerr << "Failed to get world name for character " << i << std::endl;
			worldName = "Unknown";
		}

		//std::cout << "World Name: " << worldName << std::endl;

		// Determining player IP and port based on world ID
		uint32_t playerIp = 0;
		uint16_t playerPort = 0;

		auto it = std::find(world.world_id.begin(), world.world_id.end(), account.world[i]);
		if (it != world.world_id.end()) {
			size_t index = std::distance(world.world_id.begin(), it);
			playerIp = world.ip[index];
			playerPort = world.port[index];
		} else {
			std::cerr << "World ID not found: " << account.world[i] << std::endl;
		}

		//std::cout << "Player IP: " << playerIp << ", Port: " << playerPort << std::endl;

		output->addString(account.characters[i]);
		output->addString(worldName); // World name instead of server name
		output->add<uint32_t>(playerIp);
		output->add<uint16_t>(playerPort);
	}

	// Add premium days
	if (g_config.getBoolean(ConfigManager::FREE_PREMIUM)) {
		output->add<uint16_t>(0xFFFF); // Client displays free premium
	} else {
		output->add<uint16_t>(account.premiumDays);
	}

	//std::cout << "Sending character list to client..." << std::endl;

	send(output);

	disconnect();

	//std::cout << "Character list sent successfully." << std::endl;
}

void ProtocolLogin::onRecvFirstMessage(NetworkMessage& msg)
{
	if (g_game.getGameState() == GAME_STATE_SHUTDOWN) {
		disconnect();
		return;
	}

	/*uint16_t clientos = */
	msg.get<uint16_t>();

	uint16_t version = msg.get<uint16_t>();
	msg.skipBytes(12);
	/*
	 * Skipped bytes:
	 * 4 bytes: protocolVersion
	 * 12 bytes: dat, spr, pic signatures (4 bytes each)
	 * 1 byte: 0
	 */

	if (version <= 760) {
		disconnectClient("Only clients with protocol " CLIENT_VERSION_STR " allowed!");
		return;
	}

	if (!Protocol::RSA_decrypt(msg)) {
		disconnect();
		return;
	}

	uint32_t key[4];
	key[0] = msg.get<uint32_t>();
	key[1] = msg.get<uint32_t>();
	key[2] = msg.get<uint32_t>();
	key[3] = msg.get<uint32_t>();
	enableXTEAEncryption();
	setXTEAKey(key);

	uint32_t accountName = msg.get<uint32_t>();
	std::string password = msg.getString();

	if (version < CLIENT_VERSION_MIN || version > CLIENT_VERSION_MAX) {
		disconnectClient("Only clients with protocol " CLIENT_VERSION_STR " allowed!");
		return;
	}

	if (g_game.getGameState() == GAME_STATE_STARTUP) {
		disconnectClient("Gameworld is starting up. Please wait.");
		return;
	}

	if (g_game.getGameState() == GAME_STATE_MAINTAIN) {
		disconnectClient("Gameworld is under maintenance.\nPlease re-connect in a while.");
		return;
	}

	BanInfo banInfo;
	auto connection = getConnection();
	if (!connection) {
		return;
	}

	if (IOBan::isIpBanned(connection->getIP(), banInfo)) {
		if (banInfo.reason.empty()) {
			banInfo.reason = "(none)";
		}

		std::ostringstream ss;
		ss << "Your IP has been banned until " << formatDateShort(banInfo.expiresAt) << " by " << banInfo.bannedBy << ".\n\nReason specified:\n" << banInfo.reason;
		disconnectClient(ss.str());
		return;
	}

	if (accountName == 0) {
		disconnectClient("Invalid account number.");
		return;
	}

	auto thisPtr = std::static_pointer_cast<ProtocolLogin>(shared_from_this());
	g_dispatcher.addTask(createTask(std::bind(&ProtocolLogin::getCharacterList, thisPtr, accountName, password)));
}
