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

#ifndef FS_PLAYER_H_4083D3D3A05B4EDE891B31BB720CD06F
#define FS_PLAYER_H_4083D3D3A05B4EDE891B31BB720CD06F

#include "creature.h"
#include "container.h"
#include "cylinder.h"
#include "outfit.h"
#include "enums.h"
#include "vocation.h"
#include "protocolgame.h"
#include "ioguild.h"
#include "party.h"
#include "depotchest.h"
#include "depotlocker.h"
#include "guild.h"
#include "groups.h"
#include "town.h"

class House;
class NetworkMessage;
class Weapon;
class ProtocolGame;
class Npc;
class Party;
class SchedulerTask;
class Bed;
class Guild;

enum skillsid_t {
	SKILLVALUE_LEVEL = 0,
	SKILLVALUE_TRIES = 1,
	SKILLVALUE_PERCENT = 2,
};

enum playerinfo_t {
	PLAYERINFO_LEVELPERCENT,
	PLAYERINFO_HEALTH,
	PLAYERINFO_MAXHEALTH,
	PLAYERINFO_MANA,
	PLAYERINFO_MAXMANA,
	PLAYERINFO_MAGICLEVEL,
	PLAYERINFO_MAGICLEVELPERCENT,
};

enum chaseMode_t : uint8_t {
	CHASEMODE_STANDSTILL = 0,
	CHASEMODE_FOLLOW = 1,
};

enum fightMode_t : uint8_t {
	FIGHTMODE_ATTACK = 1,
	FIGHTMODE_BALANCED = 2,
	FIGHTMODE_DEFENSE = 3,
};

enum secureMode_t : uint8_t {
	SECUREMODE_OFF = 0,
	SECUREMODE_ON = 1,
};

enum tradestate_t : uint8_t {
	TRADE_NONE,
	TRADE_INITIATED,
	TRADE_ACCEPT,
	TRADE_ACKNOWLEDGE,
	TRADE_TRANSFER,
};

struct VIPEntry {
	VIPEntry(uint32_t guid, const std::string& name)
		: guid(guid), name(name) {}

	uint32_t guid;
	std::string name;
};

struct OpenContainer {
	Container* container;
	uint16_t index;
};

struct OutfitEntry {
	OutfitEntry(uint16_t lookType, uint8_t addons) : lookType(lookType), addons(addons) {}

	uint16_t lookType;
	uint8_t addons;
};

struct Skill {
	Skill() : tries(0), level(10), percent(0) {}
	uint64_t tries;
	uint16_t level;
	uint8_t percent;
};

typedef std::map<uint32_t, uint32_t> MuteCountMap;

#define PLAYER_MAX_SPEED 1500
#define PLAYER_MIN_SPEED 10

class Player final : public Creature, public Cylinder
{
	public:
		explicit Player(ProtocolGame_ptr p);
		~Player();

		// non-copyable
		Player(const Player&) = delete;
		Player& operator=(const Player&) = delete;

		Player* getPlayer() final {
			return this;
		}
		const Player* getPlayer() const final {
			return this;
		}

		void setID() final {
			if (id == 0) {
				id = playerAutoID++;
			}
		}

		static MuteCountMap muteCountMap;

		const std::string& getName() const final {
			return name;
		}
		void setName(std::string name) {
			this->name = name;
		}
		const std::string& getNameDescription() const final {
			return name;
		}
		std::string getDescription(int32_t lookDistance) const final;

		CreatureType_t getType() const final {
			return CREATURETYPE_PLAYER;
		}

		void sendFYIBox(const std::string& message) {
			if (client) {
				client->sendFYIBox(message);
			}
		}

		void setGUID(uint32_t _guid) {
			guid = _guid;
		}
		uint32_t getGUID() const {
			return guid;
		}
		bool canSeeInvisibility() const final {
			return hasFlag(PlayerFlag_CanSenseInvisibility) || group->access;
		}

		void removeList() final;
		void addList() final;
		void kickPlayer(bool displayEffect);

		static uint64_t getExpForLevel(int32_t lv) {
			lv--;
			return ((50ULL * lv * lv * lv) - (150ULL * lv * lv) + (400ULL * lv)) / 3ULL;
		}

		uint16_t getStaminaMinutes() const {
			return staminaMinutes;
		}

		bool addOfflineTrainingTries(skills_t skill, uint64_t tries);

		void addOfflineTrainingTime(int32_t addTime) {
			offlineTrainingTime = std::min<int32_t>(12 * 3600 * 1000, offlineTrainingTime + addTime);
		}
		void removeOfflineTrainingTime(int32_t removeTime) {
			offlineTrainingTime = std::max<int32_t>(0, offlineTrainingTime - removeTime);
		}
		int32_t getOfflineTrainingTime() const {
			return offlineTrainingTime;
		}

		int32_t getOfflineTrainingSkill() const {
			return offlineTrainingSkill;
		}
		void setOfflineTrainingSkill(int32_t skill) {
			offlineTrainingSkill = skill;
		}

		uint64_t getBankBalance() const {
			return bankBalance;
		}
		void setBankBalance(uint64_t balance) {
			bankBalance = balance;
		}

		Guild* getGuild() const {
			return guild;
		}
		void setGuild(Guild* guild);

		uint8_t getGuildLevel() const {
			return guildLevel;
		}
		void setGuildLevel(uint8_t newGuildLevel) {
			guildLevel = newGuildLevel;
		}

		bool isGuildMate(const Player* player) const;

		const std::string& getGuildNick() const {
			return guildNick;
		}
		void setGuildNick(std::string nick) {
			guildNick = nick;
		}

		bool isInWar(const Player* player) const;
		bool isInWarList(uint32_t guild_id) const;

		uint16_t getClientIcons() const;

		const GuildWarList& getGuildWarList() const {
			return guildWarList;
		}

		Vocation* getVocation() const {
			return vocation;
		}

		OperatingSystem_t getOperatingSystem() const {
			return operatingSystem;
		}
		void setOperatingSystem(OperatingSystem_t clientos) {
			operatingSystem = clientos;
		}

		uint16_t getProtocolVersion() const {
			if (!client) {
				return 0;
			}

			return client->getVersion();
		}

		bool hasSecureMode() const {
			return secureMode;
		}

		void setParty(Party* _party) {
			party = _party;
		}
		Party* getParty() const {
			return party;
		}
		PartyShields_t getPartyShield(const Player* player) const;
		bool isInviting(const Player* player) const;
		bool isPartner(const Player* player) const;
		void sendPlayerPartyIcons(Player* player);
		bool addPartyInvitation(Party* party);
		void removePartyInvitation(Party* party);
		void clearPartyInvitations();

		uint64_t getSpentMana() const {
			return manaSpent;
		}

		bool hasFlag(PlayerFlags value) const {
			return (group->flags & value) != 0;
		}

		BedItem* getBedItem() {
			return bedItem;
		}
		void setBedItem(BedItem* b) {
			bedItem = b;
		}

		void addBlessing(uint8_t blessing) {
			blessings |= blessing;
		}
		void removeBlessing(uint8_t blessing) {
			blessings &= ~blessing;
		}
		bool hasBlessing(uint8_t value) const {
			return (blessings & (static_cast<uint8_t>(1) << value)) != 0;
		}

		bool isOffline() const {
			return (getID() == 0);
		}
		void disconnect() {
			if (client) {
				client->disconnect();
			}
		}
		uint32_t getIP() const;

		void addContainer(uint8_t cid, Container* container);
		void closeContainer(uint8_t cid);
		void setContainerIndex(uint8_t cid, uint16_t index);

		Container* getContainerByID(uint8_t cid);
		int8_t getContainerID(const Container* container) const;
		uint16_t getContainerIndex(uint8_t cid) const;

		bool canOpenCorpse(uint32_t ownerId) const;

		void addStorageValue(const uint32_t key, const int32_t value, const bool isLogin = false);
		bool getStorageValue(const uint32_t key, int32_t& value) const;
		void genReservedStorageRange();

		void setGroup(Group* newGroup) {
			group = newGroup;
		}
		Group* getGroup() const {
			return group;
		}

		void setLastDepotId(int16_t newId) {
			lastDepotId = newId;
		}
		int16_t getLastDepotId() const {
			return lastDepotId;
		}

		void resetIdleTime() {
			idleTime = 0;
		}

		bool isInGhostMode() const {
			return ghostMode;
		}
		void switchGhostMode() {
			ghostMode = !ghostMode;
		}

		uint32_t getAccount() const {
			return accountNumber;
		}
		AccountType_t getAccountType() const {
			return accountType;
		}
		uint32_t getLevel() const {
			return level;
		}
		uint32_t getMagicLevel() const {
			return getPlayerInfo(PLAYERINFO_MAGICLEVEL);
		}
		uint32_t getBaseMagicLevel() const {
			return magLevel;
		}
		uint8_t getSoul() const {
			return soul;
		}
		bool isAccessPlayer() const {
			return group->access;
		}
		bool isPremium() const;
		void setPremiumDays(int32_t v);

		bool setVocation(uint16_t vocId);
		uint16_t getVocationId() const {
			return vocation->getId();
		}

		PlayerSex_t getSex() const {
			return sex;
		}
		void setSex(PlayerSex_t);
		int32_t getPlayerInfo(playerinfo_t playerinfo) const;
		uint64_t getExperience() const {
			return experience;
		}

		time_t getLastLoginSaved() const {
			return lastLoginSaved;
		}

		time_t getLastLogout() const {
			return lastLogout;
		}

		const Position& getLoginPosition() const {
			return loginPosition;
		}
		const Position& getTemplePosition() const {
			return town->getTemplePosition();
		}
		Town* getTown() const {
			return town;
		}
		void setTown(Town* _town) {
			town = _town;
		}

		bool isPushable() const final;
		uint32_t isMuted() const;
		void addMessageBuffer();
		void removeMessageBuffer();

		bool removeItemOfType(uint16_t itemId, uint32_t amount, int32_t subType, bool ignoreEquipped = false) const;

		uint32_t getCapacity() const {
			if (hasFlag(PlayerFlag_CannotPickupItem)) {
				return 0;
			} else if (hasFlag(PlayerFlag_HasInfiniteCapacity)) {
				return std::numeric_limits<uint32_t>::max();
			}
			return capacity;
		}

		uint32_t getFreeCapacity() const {
			if (hasFlag(PlayerFlag_CannotPickupItem)) {
				return 0;
			} else if (hasFlag(PlayerFlag_HasInfiniteCapacity)) {
				return std::numeric_limits<uint32_t>::max();
			} else {
				return std::max<int32_t>(0, capacity - inventoryWeight);
			}
		}

		int32_t getMaxHealth() const final {
			return getPlayerInfo(PLAYERINFO_MAXHEALTH);
		}
		uint32_t getMaxMana() const {
			return getPlayerInfo(PLAYERINFO_MAXMANA);
		}

		Item* getInventoryItem(slots_t slot) const;

		bool isItemAbilityEnabled(slots_t slot) const {
			return inventoryAbilities[slot];
		}
		void setItemAbility(slots_t slot, bool enabled) {
			inventoryAbilities[slot] = enabled;
		}

		void setVarSkill(skills_t skill, int32_t modifier) {
			varSkills[skill] += modifier;
		}

		void setVarStats(stats_t stat, int32_t modifier);
		int32_t getDefaultStats(stats_t stat) const;

		void addConditionSuppressions(uint32_t conditions);
		void removeConditionSuppressions(uint32_t conditions);

		DepotChest* getDepotChest(uint32_t depotId, bool autoCreate);
		DepotLocker* getDepotLocker(uint32_t depotId);
		void onReceiveMail() const;
		bool isNearDepotBox() const;

		bool canSee(const Position& pos) const final;
		bool canSeeCreature(const Creature* creature) const final;

		RaceType_t getRace() const final {
			return RACE_BLOOD;
		}

		uint64_t getMoney() const;

		//safe-trade functions
		void setTradeState(tradestate_t state) {
			tradeState = state;
		}
		tradestate_t getTradeState() const {
			return tradeState;
		}
		Item* getTradeItem() {
			return tradeItem;
		}

		//V.I.P. functions
		void notifyStatusChange(Player* player, VipStatus_t status);
		bool removeVIP(uint32_t vipGuid);
		bool addVIP(uint32_t vipGuid, const std::string& vipName, VipStatus_t status);
		bool addVIPInternal(uint32_t vipGuid);

		//follow functions
		bool setFollowCreature(Creature* creature) final;
		void goToFollowCreature() final;

		//follow events
		void onFollowCreature(const Creature* creature) final;

		//walk events
		void onWalk(Direction& dir) final;
		void onWalkAborted() final;
		void onWalkComplete() final;

		void stopWalk();
		void setChaseMode(chaseMode_t mode);
		void setFightMode(fightMode_t mode) {
			fightMode = mode;
		}
		void setSecureMode(bool mode) {
			secureMode = mode;
		}

		//combat functions
		bool setAttackedCreature(Creature* creature) final;
		bool isImmune(CombatType_t type) const final;
		bool isImmune(ConditionType_t type) const final;
		bool hasShield() const;
		bool isAttackable() const final;

		void changeHealth(int32_t healthChange, bool sendHealthChange = true) final;
		void changeMana(int32_t manaChange) final;
		void changeSoul(int32_t soulChange);

		bool isPzLocked() const {
			return pzLocked;
		}
		BlockType_t blockHit(Creature* attacker, CombatType_t combatType, int32_t& damage,
									 bool checkDefense = false, bool checkArmor = false, bool field = false) final;
		void doAttacking(uint32_t interval) final;
		bool hasExtraSwing() final {
			return lastAttack > 0 && ((OTSYS_TIME() - lastAttack) >= getAttackSpeed());
		}

		uint16_t getSkillLevel(uint8_t skill) const {
			return std::max<int32_t>(0, skills[skill].level + varSkills[skill]);
		}
		uint16_t getBaseSkill(uint8_t skill) const {
			return skills[skill].level;
		}
		uint8_t getSkillPercent(uint8_t skill) const {
			return skills[skill].percent;
		}

		bool getAddAttackSkill() const {
			return addAttackSkillPoint;
		}
		BlockType_t getLastAttackBlockType() const {
			return lastAttackBlockType;
		}

		Item* getWeapon(slots_t slot, bool ignoreAmmo) const;
		Item* getWeapon(bool ignoreAmmo = false) const;
		WeaponType_t getWeaponType() const;
		int32_t getWeaponSkill(const Item* item) const;
		void getShieldAndWeapon(const Item*& shield, const Item*& weapon) const;

		void drainHealth(Creature* attacker, int32_t damage) final;
		void drainMana(Creature* attacker, int32_t manaLoss) final;
		void addManaSpent(uint64_t amount);
		void addSkillAdvance(skills_t skill, uint64_t count);

		int32_t getArmor() const final;
		int32_t getDefense() const final;
		float getAttackFactor() const final;
		float getDefenseFactor() const final;
		
		void addWeaponExhaust(uint32_t ticks);
		void addCombatExhaust(uint32_t ticks);
		void addHealExhaust(uint32_t ticks);
		void addInFightTicks(bool pzlock = false);

		uint64_t getGainedExperience(Creature* attacker) const final;

		//combat event functions
		void onAddCondition(ConditionType_t type) final;
		void onAddCombatCondition(ConditionType_t type) final;
		void onEndCondition(ConditionType_t type) final;
		void onCombatRemoveCondition(Condition* condition) final;
		void onAttackedCreature(Creature* target) final;
		void onAttacked() final;
		void onAttackedCreatureDrainHealth(Creature* target, int32_t points) final;
		void onTargetCreatureGainHealth(Creature* target, int32_t points) final;
		bool onKilledCreature(Creature* target, bool lastHit = true) final;
		void onGainExperience(uint64_t gainExp, Creature* target) final;
		void onGainSharedExperience(uint64_t gainExp, Creature* source);
		void onAttackedCreatureBlockHit(BlockType_t blockType) final;
		void onBlockHit() final;
		void onChangeZone(ZoneType_t zone) final;
		void onAttackedCreatureChangeZone(ZoneType_t zone) final;
		void onIdleStatus() final;
		void onPlacedCreature() final;

		void getCreatureLight(LightInfo& light) const final;

		Skulls_t getSkull() const final;
		Skulls_t getSkullClient(const Creature* creature) const final;
		int64_t getSkullTicks() const { return skullTicks; }
		void setSkullTicks(int64_t ticks) { skullTicks = ticks; }

		bool hasAttacked(const Player* attacked) const;
		void addAttacked(const Player* attacked);
		void removeAttacked(const Player* attacked);
		void clearAttacked();
		void addUnjustifiedDead(const Player* attacked);
		void sendCreatureSkull(const Creature* creature) const {
			if (client) {
				client->sendCreatureSkull(creature);
			}
		}
		void checkSkullTicks(int32_t ticks);

		bool canWear(uint32_t lookType, uint8_t addons) const;
		void addOutfit(uint16_t lookType, uint8_t addons);
		bool removeOutfit(uint16_t lookType);
		bool removeOutfitAddon(uint16_t lookType, uint8_t addons);
		bool getOutfitAddons(const Outfit& outfit, uint8_t& addons) const;

		bool canLogout();

		size_t getMaxVIPEntries() const;
		size_t getMaxDepotItems() const;

		//tile
		//send methods
		void sendAddTileItem(const Tile* tile, const Position& pos, const Item* item) {
			if (client) {
				int32_t stackpos = tile->getStackposOfItem(this, item);
				if (stackpos != -1) {
					client->sendAddTileItem(pos, stackpos, item);
				}
			}
		}
		void sendUpdateTileItem(const Tile* tile, const Position& pos, const Item* item) {
			if (client) {
				int32_t stackpos = tile->getStackposOfItem(this, item);
				if (stackpos != -1) {
					client->sendUpdateTileItem(pos, stackpos, item);
				}
			}
		}
		void sendRemoveTileThing(const Position& pos, int32_t stackpos) {
			if (stackpos != -1 && client) {
				client->sendRemoveTileThing(pos, stackpos);
			}
		}
		void sendUpdateTile(const Tile* tile, const Position& pos) {
			if (client) {
				client->sendUpdateTile(tile, pos);
			}
		}

		void sendChannelMessage(const std::string& author, const std::string& text, SpeakClasses type, uint16_t channel) {
			if (client) {
				client->sendChannelMessage(author, text, type, channel);
			}
		}
		void sendCreatureAppear(const Creature* creature, const Position& pos, bool isLogin) {
			if (client) {
				client->sendAddCreature(creature, pos, creature->getTile()->getStackposOfCreature(this, creature), isLogin);
			}
		}
		void sendCreatureMove(const Creature* creature, const Position& newPos, int32_t newStackPos, const Position& oldPos, int32_t oldStackPos, bool teleport) {
			if (client) {
				client->sendMoveCreature(creature, newPos, newStackPos, oldPos, oldStackPos, teleport);
			}
		}
		void sendCreatureTurn(const Creature* creature) {
			if (client && canSeeCreature(creature)) {
				int32_t stackpos = creature->getTile()->getStackposOfCreature(this, creature);
				if (stackpos != -1) {
					client->sendCreatureTurn(creature, stackpos);
				}
			}
		}
		void sendCreatureSay(const Creature* creature, SpeakClasses type, const std::string& text, const Position* pos = nullptr) {
			if (client) {
				client->sendCreatureSay(creature, type, text, pos);
			}
		}
		void sendPrivateMessage(const Player* speaker, SpeakClasses type, const std::string& text) {
			if (client) {
				client->sendPrivateMessage(speaker, type, text);
			}
		}
		void sendCreatureSquare(const Creature* creature, SquareColor_t color) {
			if (client) {
				client->sendCreatureSquare(creature, color);
			}
		}
		void sendCreatureChangeOutfit(const Creature* creature, const Outfit_t& outfit) {
			if (client) {
				client->sendCreatureOutfit(creature, outfit);
			}
		}
		void sendCreatureChangeVisible(const Creature* creature, bool visible) {
			if (!client) {
				return;
			}

			if (creature->getPlayer()) {
				if (visible) {
					client->sendCreatureOutfit(creature, creature->getCurrentOutfit());
				} else {
					static Outfit_t outfit;
					client->sendCreatureOutfit(creature, outfit);
				}
			} else if (canSeeInvisibility()) {
				client->sendCreatureOutfit(creature, creature->getCurrentOutfit());
			} else {
				int32_t stackpos = creature->getTile()->getStackposOfCreature(this, creature);
				if (stackpos == -1) {
					return;
				}

				if (visible) {
					client->sendAddCreature(creature, creature->getPosition(), stackpos, false);
				} else {
					client->sendRemoveTileThing(creature->getPosition(), stackpos);
				}
			}
		}
		void sendCreatureLight(const Creature* creature) {
			if (client) {
				client->sendCreatureLight(creature);
			}
		}
		void sendCreatureShield(const Creature* creature) {
			if (client) {
				client->sendCreatureShield(creature);
			}
		}
		void sendAnimatedText(const std::string& message, const Position& pos, TextColor_t color) {
			if (client) {
				client->sendAnimatedText(message, pos, color);
			}
		}

		//container
		void sendAddContainerItem(const Container* container, const Item* item);
		void sendUpdateContainerItem(const Container* container, uint16_t slot, const Item* newItem);
		void sendRemoveContainerItem(const Container* container, uint16_t slot);
		void sendContainer(uint8_t cid, const Container* container, bool hasParent, uint16_t firstIndex) {
			if (client) {
				client->sendContainer(cid, container, hasParent, firstIndex);
			}
		}

		//inventory
		void sendInventoryItem(slots_t slot, const Item* item) {
			if (client) {
				client->sendInventoryItem(slot, item);
			}
		}

		//event methods
		void onUpdateTileItem(const Tile* tile, const Position& pos, const Item* oldItem,
									  const ItemType& oldType, const Item* newItem, const ItemType& newType) final;
		void onRemoveTileItem(const Tile* tile, const Position& pos, const ItemType& iType,
									  const Item* item) final;

		void onCreatureAppear(Creature* creature, bool isLogin) final;
		void onRemoveCreature(Creature* creature, bool isLogout) final;
		void onCreatureMove(Creature* creature, const Tile* newTile, const Position& newPos,
									const Tile* oldTile, const Position& oldPos, bool teleport) final;

		void onAttackedCreatureDisappear(bool isLogout) final;
		void onFollowCreatureDisappear(bool isLogout) final;

		//container
		void onAddContainerItem(const Item* item);
		void onUpdateContainerItem(const Container* container, const Item* oldItem, const Item* newItem);
		void onRemoveContainerItem(const Container* container, const Item* item);

		void onCloseContainer(const Container* container);
		void onSendContainer(const Container* container);
		void autoCloseContainers(const Container* container);

		//inventory
		void onUpdateInventoryItem(Item* oldItem, Item* newItem);
		void onRemoveInventoryItem(Item* item);

		void sendCancelMessage(const std::string& msg) const {
			if (client) {
				client->sendTextMessage(TextMessage(MESSAGE_STATUS_SMALL, msg));
			}
		}
		void sendCancelMessage(ReturnValue message) const;
		void sendCancelTarget() const {
			if (client) {
				client->sendCancelTarget();
			}
		}
		void sendCancelWalk() const {
			if (client) {
				client->sendCancelWalk();
			}
		}
		void sendChangeSpeed(const Creature* creature, uint32_t newSpeed) const {
			if (client) {
				client->sendChangeSpeed(creature, newSpeed);
			}
		}
		void sendCreatureHealth(const Creature* creature) const {
			if (client) {
				client->sendCreatureHealth(creature);
			}
		}
		void sendDistanceShoot(const Position& from, const Position& to, unsigned char type) const {
			if (client) {
				client->sendDistanceShoot(from, to, type);
			}
		}
		void sendHouseWindow(House* house, uint32_t listId) const;
		void sendCreatePrivateChannel(uint16_t channelId, const std::string& channelName) {
			if (client) {
				client->sendCreatePrivateChannel(channelId, channelName);
			}
		}
		void sendClosePrivate(uint16_t channelId);
		void sendIcons() const {
			if (client) {
				client->sendIcons(getClientIcons());
			}
		}
		void sendMagicEffect(const Position& pos, uint8_t type) const {
			if (client) {
				client->sendMagicEffect(pos, type);
			}
		}
		void sendPing();
		void sendStats();
		void sendSkills() const {
			if (client) {
				client->sendSkills();
			}
		}
		void sendTextMessage(MessageClasses mclass, const std::string& message) const {
			if (client) {
				client->sendTextMessage(TextMessage(mclass, message));
			}
		}
		void sendTextMessage(const TextMessage& message) const {
			if (client) {
				client->sendTextMessage(message);
			}
		}
		void sendReLoginWindow() const {
			if (client) {
				client->sendReLoginWindow();
			}
		}
		void sendTextWindow(Item* item, uint16_t maxlen, bool canWrite) const {
			if (client) {
				client->sendTextWindow(windowTextId, item, maxlen, canWrite);
			}
		}
		void sendTextWindow(uint32_t itemId, const std::string& text) const {
			if (client) {
				client->sendTextWindow(windowTextId, itemId, text);
			}
		}
		void sendToChannel(const Creature* creature, SpeakClasses type, const std::string& text, uint16_t channelId) const {
			if (client) {
				client->sendToChannel(creature, type, text, channelId);
			}
		}
		void sendTradeItemRequest(const std::string& traderName, const Item* item, bool ack) const {
			if (client) {
				client->sendTradeItemRequest(traderName, item, ack);
			}
		}
		void sendTradeClose() const {
			if (client) {
				client->sendCloseTrade();
			}
		}
		void sendWorldLight(const LightInfo& lightInfo) {
			if (client) {
				client->sendWorldLight(lightInfo);
			}
		}
		void sendChannelsDialog() {
			if (client) {
				client->sendChannelsDialog();
			}
		}
		void sendOpenPrivateChannel(const std::string& receiver) {
			if (client) {
				client->sendOpenPrivateChannel(receiver);
			}
		}
		void sendOutfitWindow() {
			if (client) {
				client->sendOutfitWindow();
			}
		}
		void sendCloseContainer(uint8_t cid) {
			if (client) {
				client->sendCloseContainer(cid);
			}
		}

		void sendChannel(uint16_t channelId, const std::string& channelName, const UsersMap* channelUsers, const InvitedMap* invitedUsers) {
			if (client) {
				client->sendChannel(channelId, channelName, channelUsers, invitedUsers);
			}
		}
		void sendAddMarker(const Position& pos, uint8_t markType, const std::string& desc) {
			if (client) {
				client->sendAddMarker(pos, markType, desc);
			}
		}
		void sendQuestLog() {
			if (client) {
				client->sendQuestLog();
			}
		}
		void sendQuestLine(const Quest* quest) {
			if (client) {
				client->sendQuestLine(quest);
			}
		}
		void sendFightModes() {
			if (client) {
				client->sendFightModes();
			}
		}
		void sendNetworkMessage(const NetworkMessage& message) {
			if (client) {
				client->writeToOutputBuffer(message);
			}
		}

		void receivePing() {
			lastPong = OTSYS_TIME();
		}

		void onThink(uint32_t interval) final;

		void postAddNotification(Thing* thing, const Cylinder* oldParent, int32_t index, cylinderlink_t link = LINK_OWNER) final;
		void postRemoveNotification(Thing* thing, const Cylinder* newParent, int32_t index, cylinderlink_t link = LINK_OWNER) final;

		void setNextAction(int64_t time) {
			if (time > nextAction) {
				nextAction = time;
			}
		}
		bool canDoAction() const {
			return nextAction <= OTSYS_TIME();
		}
		uint32_t getNextActionTime() const;

		Item* getWriteItem(uint32_t& _windowTextId, uint16_t& _maxWriteLen);
		void setWriteItem(Item* item, uint16_t _maxWriteLen = 0);

		House* getEditHouse(uint32_t& _windowTextId, uint32_t& _listId);
		void setEditHouse(House* house, uint32_t listId = 0);

		void learnInstantSpell(const std::string& spellName);
		void forgetInstantSpell(const std::string& spellName);
		bool hasLearnedInstantSpell(const std::string& spellName) const;

	protected:
		std::forward_list<Condition*> getMuteConditions() const;

		void checkTradeState(const Item* item);
		bool hasCapacity(const Item* item, uint32_t count) const;

		void gainExperience(uint64_t exp, Creature* source);
		void addExperience(Creature* source, uint64_t exp, bool sendText = false);
		void removeExperience(uint64_t exp, bool sendText = false);

		void updateInventoryWeight();

		void setNextWalkActionTask(SchedulerTask* task);
		void setNextWalkTask(SchedulerTask* task);
		void setNextActionTask(SchedulerTask* task);

		void death(Creature* _lastHitCreature) final;
		bool dropCorpse(Creature* _lastHitCreature, Creature* mostDamageCreature, bool lastHitUnjustified, bool mostDamageUnjustified) final;
		Item* getCorpse(Creature* _lastHitCreature, Creature* mostDamageCreature) final;

		//cylinder implementations
		ReturnValue queryAdd(int32_t index, const Thing& thing, uint32_t count,
				uint32_t flags, Creature* actor = nullptr) const final;
		ReturnValue queryMaxCount(int32_t index, const Thing& thing, uint32_t count, uint32_t& maxQueryCount,
				uint32_t flags) const final;
		ReturnValue queryRemove(const Thing& thing, uint32_t count, uint32_t flags) const final;
		Cylinder* queryDestination(int32_t& index, const Thing& thing, Item** destItem,
				uint32_t& flags) final;

		void addThing(Thing*) final {}
		void addThing(int32_t index, Thing* thing) final;

		void updateThing(Thing* thing, uint16_t itemId, uint32_t count) final;
		void replaceThing(uint32_t index, Thing* thing) final;

		void removeThing(Thing* thing, uint32_t count) final;

		int32_t getThingIndex(const Thing* thing) const final;
		size_t getFirstIndex() const final;
		size_t getLastIndex() const final;
		uint32_t getItemTypeCount(uint16_t itemId, int32_t subType = -1) const final;
		std::map<uint32_t, uint32_t>& getAllItemTypeCount(std::map<uint32_t, uint32_t> &countMap) const final;
		Thing*getThing(size_t index) const final;

		void internalAddThing(Thing* thing) final;
		void internalAddThing(uint32_t index, Thing* thing) final;

		std::unordered_set<uint32_t> attackedSet;
		std::unordered_set<uint32_t> VIPList;

		std::map<uint8_t, OpenContainer> openContainers;
		std::map<uint32_t, DepotLocker*> depotLockerMap;
		std::map<uint32_t, DepotChest*> depotChests;
		std::map<uint32_t, int32_t> storageMap;

		std::vector<OutfitEntry> outfits;
		GuildWarList guildWarList;

		std::forward_list<Party*> invitePartyList;
		std::forward_list<std::string> learnedInstantSpellList;
		std::forward_list<Condition*> storedConditionList; // TODO: This variable is only temporarily used when logging in, get rid of it somehow

		std::string name;
		std::string guildNick;

		Skill skills[SKILL_LAST + 1];
		LightInfo itemsLight;
		Position loginPosition;

		time_t lastLoginSaved;
		time_t lastLogout;

		uint64_t experience;
		uint64_t manaSpent;
		uint64_t lastAttack;
		uint64_t bankBalance;
		uint64_t lastQuestlogUpdate;
		int64_t lastFailedFollow;
		int64_t skullTicks;
		int64_t lastPing;
		int64_t lastPong;
		int64_t nextAction;

		BedItem* bedItem;
		Guild* guild;
		Group* group;
		Item* tradeItem;
		Item* inventory[CONST_SLOT_LAST + 1];
		Item* writeItem;
		House* editHouse;
		Npc* shopOwner;
		Party* party;
		Player* tradePartner;
		ProtocolGame_ptr client;
		SchedulerTask* walkTask;
		Town* town;
		Vocation* vocation;

		uint32_t inventoryWeight;
		uint32_t capacity;
		uint32_t damageImmunities;
		uint32_t conditionImmunities;
		uint32_t conditionSuppressions;
		uint32_t level;
		uint32_t magLevel;
		uint32_t actionTaskEvent;
		uint32_t nextStepEvent;
		uint32_t walkTaskEvent;
		uint32_t MessageBufferTicks;
		uint32_t lastIP;
		uint32_t accountNumber;
		uint32_t guid;
		uint32_t windowTextId;
		uint32_t editListId;
		uint32_t manaMax;
		int32_t varSkills[SKILL_LAST + 1];
		int32_t varStats[STAT_LAST + 1];
		int32_t purchaseCallback;
		int32_t saleCallback;
		int32_t MessageBufferCount;
		int32_t premiumDays;
		int32_t bloodHitCount;
		int32_t shieldBlockCount;
		int32_t offlineTrainingSkill;
		int32_t offlineTrainingTime;
		int32_t idleTime;

		uint16_t lastStatsTrainingTime;

		uint16_t staminaMinutes;
		uint16_t maxWriteLen;
		int16_t lastDepotId;

		uint8_t soul;
		uint8_t blessings;
		uint8_t guildLevel;
		uint8_t levelPercent;
		uint8_t magLevelPercent;

		PlayerSex_t sex;
		OperatingSystem_t operatingSystem;
		BlockType_t lastAttackBlockType;
		tradestate_t tradeState;
		chaseMode_t chaseMode;
		fightMode_t fightMode;
		AccountType_t accountType;

		bool secureMode;
		bool ghostMode;
		bool pzLocked;
		bool isConnecting;
		bool addAttackSkillPoint;
		bool inventoryAbilities[CONST_SLOT_LAST + 1];

		static uint32_t playerAutoID;

		void updateItemsLight(bool internal = false);
		int32_t getStepSpeed() const final {
			return std::max<int32_t>(PLAYER_MIN_SPEED, std::min<int32_t>(PLAYER_MAX_SPEED, getSpeed()));
		}
		void updateBaseSpeed() {
			if (!hasFlag(PlayerFlag_SetMaxSpeed)) {
				baseSpeed = vocation->getBaseSpeed() + (2 * (level - 1));
			} else {
				baseSpeed = PLAYER_MAX_SPEED;
			}
		}

		bool isPromoted() const;

		uint32_t getAttackSpeed() const {
			return vocation->getAttackSpeed();
		}

		static uint8_t getPercentLevel(uint64_t count, uint64_t nextLevelCount);
		double getLostPercent() const;
		uint64_t getLostExperience() const final {
			return skillLoss ? static_cast<uint64_t>(experience * getLostPercent()) : 0;
		}
		uint32_t getDamageImmunities() const final {
			return damageImmunities;
		}
		uint32_t getConditionImmunities() const final {
			return conditionImmunities;
		}
		uint32_t getConditionSuppressions() const final {
			return conditionSuppressions;
		}
		uint16_t getLookCorpse() const final;
		void getPathSearchParams(const Creature* creature, FindPathParams& fpp) const final;

		friend class Game;
		friend class Npc;
		friend class LuaScriptInterface;
		friend class Map;
		friend class Actions;
		friend class IOLoginData;
		friend class Weapon;
		friend class ProtocolGame;
};

#endif
