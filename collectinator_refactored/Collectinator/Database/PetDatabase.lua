--------------------------------------------------------------------------------------------------------------------
-- ./DB/PetDatabase.lua
-- Pet Database data for all of Collectinator
--------------------------------------------------------------------------------------------------------------------
-- File date: 2010-10-06T14:32:22Z
-- Project version: v1.0.4-5-g96b932e
--------------------------------------------------------------------------------------------------------------------
-- Please see http://www.wowace.com/addons/collectinator/ for more information.
--------------------------------------------------------------------------------------------------------------------
-- License:
-- Please see LICENSE.txt
-- This source code is released under All Rights Reserved.
--------------------------------------------------------------------------------------------------------------------

--[[
http://lua-users.org/wiki/SlightlyLessSimpleLuaPreprocessor
http://wowuidev.pastey.net/125321
http://wowuidev.pastey.net/125322
12:59	sylvanaar	Ackis so i saved that code to a file luapp.lua, then i did lua luapp.lua infile.lua outfile.lua
13:00	sylvanaar	"lua luapp.lua infile.lua outfile.lua"
]]--

local MODNAME		= "Collectinator"
local addon		= LibStub("AceAddon-3.0"):GetAddon(MODNAME)
local BF		= LibStub("LibBabble-Faction-3.0"):GetLookupTable()

local FACTION_ALLIANCE	= BF["Alliance"]
local FACTION_HORDE	= BF["Horde"]

local MY_FACTION	= select(2, UnitFactionGroup("player"))

-------------------------------------------------------------------------------
-- Item "rarity"
-------------------------------------------------------------------------------
local R_COMMON, R_UNCOMMON, R_RARE, R_EPIC, R_LEGENDARY, R_ARTIFACT = 1, 2, 3, 4, 5, 6

-------------------------------------------------------------------------------
-- Origin
-------------------------------------------------------------------------------
local GAME_ORIG, GAME_BC, GAME_WOTLK = 0, 1, 2

-------------------------------------------------------------------------------
-- Filter flags
-------------------------------------------------------------------------------
local F_ALLIANCE, F_HORDE, F_VENDOR, F_QUEST, F_CRAFT, F_INSTANCE, F_RAID, F_SEASONAL, F_WORLD_DROP, F_MOB_DROP = 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
local F_TCG, F_SPEC_EVENT, F_COLLECTORS, F_REMOVED, F_ACHIEVEMENT, F_PVP, F_STORE, F_SIGIL = 11, 12, 13, 14, 15, 16, 77, 99
local F_BOE, F_BOP, F_BOA = 17, 18, 19
local F_ALCH, F_BS, F_COOKING, F_ENCH, F_ENG, F_FIRST_AID, F_INSC, F_JC, F_LW, F_SMELT, F_TAILOR, F_FISHING = 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32

-------------------------------------------------------------------------------
-- Reputation Filter Flags
-------------------------------------------------------------------------------
local F_ARGENT_DAWN, F_BLOODSAIL, F_CENARION_CIRCLE, F_THORIUM_BROTHERHOOD, F_TIMBERMAW, F_WINTERSRPING, F_ZANDALAR = 33, 34, 35, 36, 37, 38, 39
local F_ALDOR, F_ASHTONGUE, F_CENARION_EXPIDITION, F_HELLFIRE, F_CONSORTIUM, F_KOT, F_LOWER_CITY, F_NAGRAND = 40, 41, 42, 43, 44, 45, 46, 47
local F_NETHERWING, F_SCALE_SANDS, F_SCRYER, F_SHATAR, F_SKYGUARD, F_SHATTEREDSUN, F_SPOREGGAR, F_VIOLET_EYE = 48, 49, 50, 51, 52, 53, 54, 55
local F_ARGENT_CRUSADE, F_FRENZYHEART, F_EBON_BLADE, F_KIRINTOR, F_HODIR, F_KALUAK, F_ORACLES, F_WYRMREST = 56, 57, 58, 59, 60, 61, 62, 63
local WRATHCOMMON1, WRATHCOMMON2, WRATHCOMMON3, WRATHCOMMON4, WRATHCOMMON5 = 64, 65, 66, 67, 68
local F_CITY1, F_CITY2, F_CITY3, F_CITY4, F_CITY5 = 69, 70, 71, 72, 73
local F_PVP1, F_PVP2, F_PVP3 = 74, 75, 76

-- City 1 Darnassus/Darkspear
-- City 2 Stormwind/Orgrimmar
-- City 3 Gnomerga/Thunder Bluff
-- City 4 Ironforge/Undercity
-- City 5 Exodar/Silvermoon
-- PVP 1 WSG
-- PVP 2 AV
-- PVP 3 AB
--Wrath Common Factions 1 (The Silver Covenant/The Sunreavers)
--Wrath Common Factions 2 (Explorer's League/Hand of Vengance)
--Wrath Common Factions 3 (Explorer's League/Valiance Expedition)
--Wrath Common Factions 4 (The Frostborn/The Taunka)
--Wrath Common Factions 5 (Alliance Vanguard/Horde Expedition)

-------------------------------------------------------------------------------
-- Acquire types
-------------------------------------------------------------------------------
local A_VENDOR, A_QUEST, A_CRAFTED, A_MOB, A_SEASONAL, A_REPUTATION, A_WORLD_DROP, A_CUSTOM, A_ACHIEVEMENT = 1, 2, 3, 4, 5, 6, 7, 8, 9

-------------------------------------------------------------------------------
-- Reputation Levels
-------------------------------------------------------------------------------
local FRIENDLY = 1
local HONORED = 2
local REVERED = 3
local EXALTED = 4

local initialized = false
local num_pets = 0

function addon:GetMiniPetTotal(PetDB)
	if initialized then
		return num_pets
	end
	initialized = true

	-------------------------------------------------------------------------------
	-- Counter and wrapper function
	-------------------------------------------------------------------------------
	local function AddPet(SpellID, PetItemID, Rarity, Game)
		num_pets = num_pets + 1
		addon:AddCompanion(PetDB, "CRITTER", SpellID, PetItemID, Rarity, Game)
	end
	
-- 3.3 pets - not categorized
	-- Core Hound Pup
	AddPet(69452, 49646, R_RARE, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 69452, F_ALLIANCE, F_HORDE, F_SPEC_EVENT, F_BOP)
	self:AddCompanionAcquire(PetDB, 69452, A_CUSTOM, 14)

	-- Calico Cat
	AddPet(65358, 46398, R_COMMON, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 65358, F_ALLIANCE, F_HORDE, F_VENDOR, F_BOE)
	self:AddCompanionAcquire(PetDB, 65358, A_VENDOR, 28951)

	-- Albino Snake
	AddPet(10713, 44822, R_COMMON, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 10713, F_ALLIANCE, F_HORDE, F_VENDOR, F_BOE)
	self:AddCompanionAcquire(PetDB, 10713, A_VENDOR, 28951)

	-- Zipao Tiger - 69539
	AddPet(69539, nil, R_RARE, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 69539, F_ALLIANCE, F_HORDE, F_SPEC_EVENT, F_REMOVED, F_BOE)
	self:AddCompanionAcquire(PetDB, 69539, A_CUSTOM, 34)

--ACHIEVEMENTS
	-- Pilgrim Turkey - 61773
	AddPet(61773, 44810, R_RARE, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 61773, F_ALLIANCE, F_HORDE, F_ACHIEVEMENT)
	self:AddCompanionAcquire(PetDB, 61773, A_ACHIEVEMENT, 3478, A_ACHIEVEMENT, 3656)

	-- Kirin Tor Familiar - 61472
	AddPet(61472, 44738, R_RARE, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 61472, F_ALLIANCE, F_HORDE, F_ACHIEVEMENT, F_BOP)
	self:AddCompanionAcquire(PetDB, 61472, A_ACHIEVEMENT, 1956)

	-- Reeking Pet Carrier - 40990
	AddPet(40990, 40653, R_RARE, GAME_TBC)
	self:AddCompanionFlags(PetDB, 40990, F_ALLIANCE, F_HORDE, F_ACHIEVEMENT, F_BOP)
	self:AddCompanionAcquire(PetDB, 40990, A_ACHIEVEMENT, 1250)

	-- Little Fawn - 61991
	AddPet(61991, 44841, R_RARE, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 61991, F_ALLIANCE, F_HORDE, F_ACHIEVEMENT, F_BOP)
	self:AddCompanionAcquire(PetDB, 61991, A_ACHIEVEMENT, 2516)

	-- Perky Pug - 70613
	AddPet(70613, 49912, R_RARE, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 70613, F_ALLIANCE, F_HORDE, F_SPEC_EVENT, F_BOP)
	self:AddCompanionAcquire(PetDB, 70613, A_CUSTOM, 15)

--FISHING
	-- Magical Crawdad Box - 33050
	AddPet(33050, 27445, R_COMMON, GAME_TBC)
	self:AddCompanionFlags(PetDB, 33050, F_ALLIANCE, F_HORDE, F_WORLD_DROP, F_BOP, F_FISHING)
	self:AddCompanionAcquire(PetDB, 33050, A_ACHIEVEMENT, 726, A_CUSTOM, 9)

	-- Toothy's Bucket - 43697
	AddPet(43697, 33816, R_RARE, GAME_TBC)
	self:AddCompanionFlags(PetDB, 43697, F_ALLIANCE, F_HORDE, F_QUEST, F_BOP, F_FISHING)
	self:AddCompanionAcquire(PetDB, 43697, A_QUEST, 11665, A_CUSTOM, 18)

	-- Muckbreath's Bucket - 43698
	AddPet(43698, 33818, R_RARE, GAME_TBC)
	self:AddCompanionFlags(PetDB, 43698, F_ALLIANCE, F_HORDE, F_QUEST, F_BOP, F_FISHING)
	self:AddCompanionAcquire(PetDB, 43698, A_QUEST, 11665, A_CUSTOM, 18)

	-- Snarly's Bucket - 46425
	AddPet(46425, 35349, R_RARE, GAME_TBC)
	self:AddCompanionFlags(PetDB, 46425, F_ALLIANCE, F_HORDE, F_QUEST, F_BOP, F_FISHING)
	self:AddCompanionAcquire(PetDB, 46425, A_QUEST, 11665, A_CUSTOM, 18)

	-- Chuck's Bucket - 46426
	AddPet(46426, 35350, R_RARE, GAME_TBC)
	self:AddCompanionFlags(PetDB, 46426, F_ALLIANCE, F_HORDE, F_QUEST, F_BOP, F_FISHING)
	self:AddCompanionAcquire(PetDB, 46426, A_QUEST, 11665, A_CUSTOM, 18)

	-- Giant Sewer Rat - 59250
	AddPet(59250, 43698, R_RARE, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 59250, F_ALLIANCE, F_HORDE, F_BOP, F_WORLD_DROP, F_FISHING)
	self:AddCompanionAcquire(PetDB, 59250, A_ACHIEVEMENT, 1958)

	-- Strand Crawler -- 62561
	AddPet(62561, 44983, R_RARE, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 62561, F_ALLIANCE, F_HORDE, F_QUEST, F_BOP, F_FISHING)
	self:AddCompanionAcquire(PetDB, 62561, A_QUEST, 13830, A_QUEST, 13832, A_QUEST, 13833, A_QUEST, 13834, A_QUEST, 13836)

--PLAYERMADE
	-- Mechanical Squirrel Box - 4055
	AddPet(4055, 4401, R_COMMON, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 4055, F_ALLIANCE, F_HORDE, F_CRAFT, F_BOE)
	self:AddCompanionAcquire(PetDB, 4055, A_CRAFTED, 4036, 3928)

	-- Pet Bombling - 15048
	AddPet(15048, 11825, R_COMMON, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 15048, F_ALLIANCE, F_HORDE, F_CRAFT, F_BOE, F_ENG)
	self:AddCompanionAcquire(PetDB, 15048, A_CRAFTED, 4036, 15628)

	-- Lil' Smoky - 15049
	AddPet(15049, 11826, R_COMMON, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 15049, F_ALLIANCE, F_HORDE, F_CRAFT, F_BOE, F_ENG)
	self:AddCompanionAcquire(PetDB, 15049, A_CRAFTED, 4036, 15633)

	-- Lifelike Mechanical Toad - 19772
	AddPet(19772, 15996, R_COMMON, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 19772, F_ALLIANCE, F_HORDE, F_CRAFT, F_BOE)
	self:AddCompanionAcquire(PetDB, 19772, A_CRAFTED, 4036, 19793)

	-- Tranquil Mechanical Yeti - 26010
	AddPet(26010, 21277, R_COMMON, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 26010, F_ALLIANCE, F_HORDE, F_CRAFT, F_BOE)
	self:AddCompanionAcquire(PetDB, 26010, A_CRAFTED, 4036, 26011)

--WORLD EVENT DROP
	-- Snowman Kit - 26045
	AddPet(26045, 21309, R_COMMON, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 26045, F_ALLIANCE, F_HORDE, F_SEASONAL, F_BOE)
	self:AddCompanionAcquire(PetDB, 26045, A_SEASONAL, 1)

	-- Jingling Bell - 26529
	AddPet(26529, 21308, R_COMMON, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 26529, F_ALLIANCE, F_HORDE, F_SEASONAL, F_BOE)
	self:AddCompanionAcquire(PetDB, 26529, A_SEASONAL, 1)

	-- Green Helper Box - 26533
	AddPet(26533, 21301, R_COMMON, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 26533, F_ALLIANCE, F_HORDE, F_SEASONAL, F_BOE)
	self:AddCompanionAcquire(PetDB, 26533, A_SEASONAL, 1)

	-- Red Helper Box - 26541
	AddPet(26541, 21305, R_COMMON, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 26541, F_ALLIANCE, F_HORDE, F_SEASONAL, F_BOE)
	self:AddCompanionAcquire(PetDB, 26541, A_SEASONAL, 1)

	-- Truesilver Shafted Arrow - 27570
	AddPet(27570, 22235, R_COMMON, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 27570, F_ALLIANCE, F_HORDE, F_SEASONAL, F_BOP)
	self:AddCompanionAcquire(PetDB, 27570, A_ACHIEVEMENT, 1700, A_SEASONAL, 5)

	-- Sinister Squashling - 42609
	AddPet(42609, 33154, R_RARE, GAME_TBC)
	self:AddCompanionFlags(PetDB, 42609, F_ALLIANCE, F_HORDE, F_INSTANCE, F_SEASONAL, F_MOB_DROP, F_BOP)
	self:AddCompanionAcquire(PetDB, 42609, A_MOB, 23682, A_SEASONAL, 7)

	-- Scorched Stone - 45890
	AddPet(45890, 34955, R_RARE, GAME_TBC)
	self:AddCompanionFlags(PetDB, 45890, F_ALLIANCE, F_HORDE, F_INSTANCE, F_SEASONAL, F_MOB_DROP, F_BOP)
	self:AddCompanionAcquire(PetDB, 45890, A_MOB, 25740, A_SEASONAL, 4)

	-- Clockwork Rocket Bot - 54187
	AddPet(54187, 34425, R_RARE, GAME_TBC)
	self:AddCompanionFlags(PetDB, 54187, F_ALLIANCE, F_HORDE, F_SEASONAL, F_BOP, F_REMOVED)
	self:AddCompanionAcquire(PetDB, 54187, A_ACHIEVEMENT, 1705, A_SEASONAL, 1)

	-- Spring Rabbit - 61725
	AddPet(61725, 44794, R_RARE, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 61725, F_ALLIANCE, F_HORDE, F_SEASONAL)
	self:AddCompanionAcquire(PetDB, 61725, A_SEASONAL, 9)

	-- Toxic Wasteling - 71840
	AddPet(71840, 50446, R_RARE, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 71840, F_ALLIANCE, F_HORDE, F_SEASONAL, F_MOB_DROP, F_INSTANCE, F_BOP)
	self:AddCompanionAcquire(PetDB, 71840, A_SEASONAL, 5, A_MOB, 36296)

	-- Ice Chip (Frigid Frostling) - 74932
	AddPet(74932, 53641, R_RARE, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 74932, F_ALLIANCE, F_HORDE, F_SEASONAL, F_MOB_DROP, F_INSTANCE, F_BOP)
	self:AddCompanionAcquire(PetDB, 74932, A_SEASONAL, 4, A_MOB, 25740)

--WORLD EVENT VENDOR
	-- Spirit of Summer - 28871
	AddPet(28871, 23083, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 28871, F_ALLIANCE, F_HORDE, F_SEASONAL, F_BOP)
	self:AddCompanionAcquire(PetDB, 28871, A_SEASONAL, 4)

	-- Pint-Sized Pink Pachyderm - 44369
	AddPet(44369, 46707, R_RARE, GAME_TBC)
	self:AddCompanionFlags(PetDB, 44369, F_ALLIANCE, F_HORDE, F_SEASONAL, F_BOP)
	self:AddCompanionAcquire(PetDB, 44369, A_SEASONAL, 6, A_VENDOR, 23710, A_VENDOR, 24495, A_VENDOR, 27478, A_VENDOR, 27489)

--DROP
	-- Parrot Cage (Hyacinth Macaw) - 10682
	AddPet(10682, 8494, R_EPIC, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 10682, F_ALLIANCE, F_HORDE, F_MOB_DROP, F_BOE)
	self:AddCompanionAcquire(PetDB, 10682, A_MOB, 1561, A_MOB, 1562, A_MOB, 1563, A_MOB, 1564, A_MOB, 1565, A_MOB, 1653, A_MOB, 2545, A_MOB, 4505, A_MOB, 4506)

	-- Parrot Cage (Green Wing Macaw) - 10683
	AddPet(10683, 8492, R_COMMON, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 10683, F_ALLIANCE, F_HORDE, F_INSTANCE, F_MOB_DROP, F_BOE)
	self:AddCompanionAcquire(PetDB, 10683, A_MOB, 657)

	-- Cat Carrier (Black Tabby) - 10675
	AddPet(10675, 8491, R_COMMON, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 10675, F_ALLIANCE, F_HORDE, F_MOB_DROP, F_BOE)
	self:AddCompanionAcquire(PetDB, 10675, A_MOB, 1920, A_MOB, 2271, A_MOB, 2272, A_MOB, 2358)

	-- Cat Carrier (Siamese) - 10677
	AddPet(10677, 8490, R_COMMON, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 10677, F_ALLIANCE, F_HORDE, F_VENDOR, F_INSTANCE, F_BOE)
	self:AddCompanionAcquire(PetDB, 10677, A_VENDOR, 20980, A_MOB, 645)

	-- Dark Whelpling - 10695
	AddPet(10695, 10822, R_COMMON, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 10695, F_ALLIANCE, F_HORDE, F_MOB_DROP, F_BOE)
	self:AddCompanionAcquire(PetDB, 10695, A_MOB, 2725, A_MOB, 4324)

	-- Azure Whelpling - 10696
	AddPet(10696, 34535, R_COMMON, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 10696, F_ALLIANCE, F_HORDE, F_MOB_DROP, F_BOE)
	self:AddCompanionAcquire(PetDB, 10696, A_MOB, 193, A_MOB, 6129, A_MOB, 6130, A_MOB, 6131)

	-- Tiny Crimson Whelpling - 10697
	AddPet(10697, 8499, R_COMMON, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 10697, F_ALLIANCE, F_HORDE, F_MOB_DROP, F_BOE)
	self:AddCompanionAcquire(PetDB, 10697, A_MOB, 1042, A_MOB, 1044, A_MOB, 1069)

	-- Tiny Emerald Whelpling - 10698
	AddPet(10698, 8498, R_COMMON, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 10698, F_ALLIANCE, F_HORDE, F_MOB_DROP, F_BOE)
	self:AddCompanionAcquire(PetDB, 10698, A_MOB, 741)

	-- Disgusting Oozeling - 25162
	AddPet(25162, 20769, R_COMMON, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 25162, F_ALLIANCE, F_HORDE, F_WORLD_DROP, F_BOE)
	self:AddCompanionAcquire(PetDB, 25162, A_MOB, 14345, A_MOB, 15335, A_MOB, 8606, A_MOB, 8607, A_MOB, 1808, A_MOB, 12387, A_MOB, 1806, A_MOB, 9621, A_MOB, 9477, A_MOB, 7093, A_MOB, 6559, A_MOB, 7092, A_MOB, 6557, A_CUSTOM, 3)

	-- Captured Firefly - 36034
	AddPet(36034, 29960, R_COMMON, GAME_TBC)
	self:AddCompanionFlags(PetDB, 36034, F_ALLIANCE, F_HORDE, F_MOB_DROP, F_BOE)
	self:AddCompanionAcquire(PetDB, 36034, A_MOB, 20197)

	-- Mojo - 43918
	AddPet(43918, 33993, R_RARE, GAME_TBC)
	self:AddCompanionFlags(PetDB, 43918, F_ALLIANCE, F_HORDE, F_RAID, F_BOP)
	self:AddCompanionAcquire(PetDB, 43918, A_MOB, 24396, A_CUSTOM, 19)

	-- Phoenix Hatchling - 46599
	AddPet(46599, 35504, R_RARE, GAME_TBC)
	self:AddCompanionFlags(PetDB, 46599, F_ALLIANCE, F_HORDE, F_INSTANCE, F_MOB_DROP, F_BOP)
	self:AddCompanionAcquire(PetDB, 46599, A_MOB, 24664)

	-- Darting Hatchling
	AddPet(67413, 48112, R_COMMON, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 67413, F_ALLIANCE, F_HORDE, F_MOB_DROP, F_BOE)
	self:AddCompanionAcquire(PetDB, 67413, A_MOB, 14232)

	-- Deviate Hatchling
	AddPet(67414, 48114, R_COMMON, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 67414, F_ALLIANCE, F_HORDE, F_MOB_DROP, F_BOE)
	self:AddCompanionAcquire(PetDB, 67414, A_MOB, 3636, A_MOB, 3637)

	-- Gundrak Hatchling
	AddPet(67415, 48116, R_COMMON, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 67415, F_ALLIANCE, F_HORDE, F_MOB_DROP, F_BOE)
	self:AddCompanionAcquire(PetDB, 67415, A_MOB, 29334)

	-- Leaping Hatchling
	AddPet(67416, 48118, R_COMMON, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 67416, F_ALLIANCE, F_HORDE, F_MOB_DROP, F_BOE)
	self:AddCompanionAcquire(PetDB, 67416, A_MOB, 5842)

	-- Ravasaur Hatchling
	AddPet(67418, 48122, R_COMMON, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 67418, F_ALLIANCE, F_HORDE, F_MOB_DROP, F_BOE)
	self:AddCompanionAcquire(PetDB, 67418, A_MOB, 6581)

	-- Razormaw Hatchling
	AddPet(67419, 48124, R_COMMON, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 67419, F_ALLIANCE, F_HORDE, F_MOB_DROP, F_BOE)
	self:AddCompanionAcquire(PetDB, 67419, A_MOB, 1140)

	-- Razzashi Hatchling
	AddPet(67420, 48122, R_COMMON, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 67420, F_ALLIANCE, F_HORDE, F_RAID, F_MOB_DROP, F_BOE)
	self:AddCompanionAcquire(PetDB, 67420, A_MOB, 14821)

--QUESTS
	-- Mechanical Chicken - 12243
	AddPet(12243, 10398, R_COMMON, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 12243, F_ALLIANCE, F_HORDE, F_QUEST, F_BOE)
	self:AddCompanionAcquire(PetDB, 12243, A_QUEST, 3721)

	-- Chicken Egg - 13548
	AddPet(13548, 11110, R_COMMON, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 13548, F_ALLIANCE, F_HORDE, F_QUEST, F_BOP)
	self:AddCompanionAcquire(PetDB, 13548, A_QUEST, 3861, A_CUSTOM, 2)

	-- Sprite Darter Egg - 15067
	AddPet(15067, 11474, R_COMMON, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 15067, F_ALLIANCE, F_HORDE, F_QUEST, F_BOP)
	self:AddCompanionAcquire(PetDB, 15067, A_QUEST, 4298, A_MOB, 5278, A_CUSTOM, 27)

	-- Worg Carrier - 15999
	AddPet(15999, 12264, R_COMMON, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 15999, F_ALLIANCE, F_HORDE, F_QUEST, F_BOP)
	self:AddCompanionAcquire(PetDB, 15999, A_QUEST, 4729)

	-- Smolderweb Carrier - 16450
	AddPet(16450, 12529, R_COMMON, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 16450, F_ALLIANCE, F_HORDE, F_QUEST, F_BOP)
	self:AddCompanionAcquire(PetDB, 16450, A_QUEST, 4862)

	-- A Jubling's Tiny Home - 23811
	AddPet(23811, 19450, R_COMMON, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 23811, F_ALLIANCE, F_HORDE, F_SEASONAL, F_BOP)
	self:AddCompanionAcquire(PetDB, 23811, A_QUEST, 7946, A_SEASONAL, 3)

	-- Miniwing - 39181
	AddPet(39181, 31760, R_COMMON, GAME_TBC)
	self:AddCompanionFlags(PetDB, 39181, F_ALLIANCE, F_HORDE, F_QUEST, F_BOP)
	self:AddCompanionAcquire(PetDB, 39181, A_QUEST, 10898)

	-- Wolpertinger's Tankard - 39709
	AddPet(39709, 32233, R_RARE, GAME_TBC)
	self:AddCompanionFlags(PetDB, 39709, F_ALLIANCE, F_HORDE, F_QUEST, F_SEASONAL, F_BOP)
	self:AddCompanionAcquire(PetDB, 39709, A_SEASONAL, 6, A_QUEST, 11431, A_QUEST, 11117)

	-- Argent Squire -- 62609
	AddPet(62609, 44998, R_RARE, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 62609, F_ALLIANCE, F_QUEST, F_BOP)
	self:AddCompanionAcquire(PetDB, 62609, A_QUEST, 13702, A_QUEST, 13732, A_QUEST, 13733, A_QUEST, 13734, A_QUEST, 13735)

	-- Argent Gruntling -- 62746
	AddPet(62746, 45022, R_RARE, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 62746, F_HORDE, F_QUEST, F_BOP)
	self:AddCompanionAcquire(PetDB, 62746, A_QUEST, 13736, A_QUEST, 13737, A_QUEST, 13738, A_QUEST, 13739, A_QUEST, 13740)

	-- Turtle Box - 28738
	AddPet(28738, 23002, R_COMMON, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 28738, F_ALLIANCE, F_HORDE, F_QUEST, F_SEASONAL, F_BOP)
	self:AddCompanionAcquire(PetDB, 28738, A_QUEST, 171, A_QUEST, 5502, A_SEASONAL, 8)

	-- Piglet's Collar - 28739
	AddPet(28739, 23007, R_COMMON, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 28739, F_ALLIANCE, F_HORDE, F_QUEST, F_SEASONAL, F_BOP)
	self:AddCompanionAcquire(PetDB, 28739, A_QUEST, 171, A_QUEST, 5502, A_SEASONAL, 8)

	-- Rat Cage - 28740
	AddPet(28740, 23015, R_COMMON, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 28740, F_ALLIANCE, F_HORDE, F_QUEST, F_SEASONAL, F_BOP)
	self:AddCompanionAcquire(PetDB, 28740, A_QUEST, 171, A_QUEST, 5502, A_ACHIEVEMENT, 1792)

	-- Sleepy Willy - 40613
	AddPet(40613, 32617, R_RARE, GAME_TBC)
	self:AddCompanionFlags(PetDB, 40613, F_ALLIANCE, F_HORDE, F_QUEST, F_SEASONAL, F_BOP)
	self:AddCompanionAcquire(PetDB, 40613, A_QUEST, 10966, A_QUEST, 10967, A_SEASONAL, 8)

	-- Egbert's Egg - 40614
	AddPet(40614, 32616, R_RARE, GAME_TBC)
	self:AddCompanionFlags(PetDB, 40614, F_ALLIANCE, F_HORDE, F_QUEST, F_SEASONAL, F_BOP)
	self:AddCompanionAcquire(PetDB, 40614, A_QUEST, 10966, A_QUEST, 10967, A_SEASONAL, 8)

	-- Elekk Training Collar - 40634
	AddPet(40634, 32622, R_RARE, GAME_TBC)
	self:AddCompanionFlags(PetDB, 40634, F_ALLIANCE, F_HORDE, F_QUEST, F_SEASONAL, F_BOP)
	self:AddCompanionAcquire(PetDB, 40634, A_QUEST, 10966, A_QUEST, 10967, A_SEASONAL, 8)

	-- Curious Wolvar Pup
	AddPet(65382, 46544, R_RARE, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 65382, F_ALLIANCE, F_HORDE, F_SEASONAL, F_BOP)
	self:AddCompanionAcquire(PetDB, 65382, A_QUEST, 13959, A_SEASONAL, 8)

	-- Curious Oracle Hatchling
	AddPet(65381, 46545, R_RARE, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 65381, F_ALLIANCE, F_HORDE, F_SEASONAL, F_BOP)
	self:AddCompanionAcquire(PetDB, 65381, A_QUEST, 13960, A_SEASONAL, 8)

--REP VENDOR ARGENT
	-- Teldrassil Sproutling -- 62491
	AddPet(62491, 44965, R_RARE, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 62491, F_ALLIANCE, F_VENDOR, F_BOE)
	self:AddCompanionAcquire(PetDB, 62491, A_VENDOR, 33653)

	-- Dun Morogh Cub -- 62508
	AddPet(62508, 44970, R_RARE, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 62508, F_ALLIANCE, F_VENDOR, F_BOE)
	self:AddCompanionAcquire(PetDB, 62508, A_VENDOR, 33310)

	-- Tirisfal Batling -- 62510
	AddPet(62510, 44971, R_RARE, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 62510, F_HORDE, F_VENDOR, F_BOE)
	self:AddCompanionAcquire(PetDB, 62510, A_VENDOR, 33555)

	-- Durotar Scorpion -- 62513
	AddPet(62513, 44973, R_RARE, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 62513, F_HORDE, F_VENDOR, F_BOE)
	self:AddCompanionAcquire(PetDB, 62513, A_VENDOR, 33553)

	-- Elwynn Lamb -- 62516
	AddPet(62516, 44974, R_RARE, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 62516, F_ALLIANCE, F_VENDOR, F_BOE)
	self:AddCompanionAcquire(PetDB, 62516, A_VENDOR, 33307)

	-- Mulgore Hatchling -- 62542
	AddPet(62542, 44980, R_RARE, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 62542, F_HORDE, F_VENDOR, F_BOE)
	self:AddCompanionAcquire(PetDB, 62542, A_VENDOR, 33556)

	-- Ammen Vale Lashling -- 62562
	AddPet(62562, 44984, R_RARE, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 62562, F_ALLIANCE, F_VENDOR, F_BOE)
	self:AddCompanionAcquire(PetDB, 62562, A_VENDOR, 33657)

	-- Enchanted Broom -- 62564
	AddPet(62564, 44982, R_RARE, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 62564, F_HORDE, F_VENDOR, F_BOE)
	self:AddCompanionAcquire(PetDB, 62564, A_VENDOR, 33557)

	-- Mechanopeep -- 62674
	AddPet(62674, 45002, R_RARE, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 62674, F_ALLIANCE, F_VENDOR, F_BOE)
	self:AddCompanionAcquire(PetDB, 62674, A_VENDOR, 33650)

	-- Sen'jin Fetish -- 63712
	AddPet(63712, 45606, R_RARE, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 63712, F_HORDE, F_VENDOR, F_BOE)
	self:AddCompanionAcquire(PetDB, 63712, A_VENDOR, 33554)

--REP VENDOR NEUTRAL
	-- Tiny Sporebat - 45082
	AddPet(45082, 34478, R_RARE, GAME_TBC)
	self:AddCompanionFlags(PetDB, 45082, F_ALLIANCE, F_HORDE, F_VENDOR, F_BOP, F_SPOREGGAR)
	self:AddCompanionAcquire(PetDB, 45082, A_REPUTATION, 970, EXALTED, 18382)

	-- Nether Ray Fry - 51716
	AddPet(51716, 38628, R_RARE, GAME_TBC)
	self:AddCompanionFlags(PetDB, 51716, F_ALLIANCE, F_HORDE, F_VENDOR, F_BOP, F_SKYGUARD)
	self:AddCompanionAcquire(PetDB, 51716, A_REPUTATION, 1031, EXALTED, 23367)

	-- Tickbird Hatchling -- 61348
	AddPet(61348, 39896, R_COMMON, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 61348, F_ALLIANCE, F_HORDE, F_VENDOR, F_BOP, F_ORACLES)
	self:AddCompanionAcquire(PetDB, 61348, A_REPUTATION, 1105, REVERED, 31910, A_CUSTOM, 16)

	-- White Tickbird Hatchling -- 61349
	AddPet(61349, 39899, R_COMMON, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 61349, F_ALLIANCE, F_HORDE, F_VENDOR, F_BOP, F_ORACLES)
	self:AddCompanionAcquire(PetDB, 61349, A_REPUTATION, 1105, REVERED, 31910, A_CUSTOM, 16)

	-- Proto-Drake Whelp -- 61350
	AddPet(61350, 44721, R_COMMON, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 61350, F_ALLIANCE, F_HORDE, F_VENDOR, F_BOP, F_ORACLES)
	self:AddCompanionAcquire(PetDB, 61350, A_REPUTATION, 1105, REVERED, 31910, A_CUSTOM, 16)

	-- Cobra Hatchling -- 61351
	AddPet(61351, 39898, R_COMMON, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 61351, F_ALLIANCE, F_HORDE, F_VENDOR, F_BOP, F_ORACLES)
	self:AddCompanionAcquire(PetDB, 61351, A_REPUTATION, 1105, REVERED, 31910, A_CUSTOM, 16)

	-- Nurtured Penguin Egg - 61357
	AddPet(61357, 44723, R_RARE, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 61357, F_ALLIANCE, F_HORDE, F_VENDOR, F_BOP, F_KALUAK)
	self:AddCompanionAcquire(PetDB, 61357, A_REPUTATION, 1073, EXALTED, 31916, A_REPUTATION, 1073, EXALTED, 32763)

--VENDOR NEUTRAL
	-- Parrot Cage (Cockatiel) - 10680
	AddPet(10680, 8496, R_COMMON, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 10680, F_ALLIANCE, F_HORDE, F_VENDOR, F_BOE)
	self:AddCompanionAcquire(PetDB, 10680, A_VENDOR, 2663)

	-- Parrot Cage (Senegal) - 10684
	AddPet(10684, 8495, R_COMMON, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 10684, F_ALLIANCE, F_HORDE, F_VENDOR, F_BOE)
	self:AddCompanionAcquire(PetDB, 10684, A_VENDOR, 2663, A_VENDOR, 20980)

	-- Ancona Chicken - 10685
	AddPet(10685, 11023, R_COMMON, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 10685, F_ALLIANCE, F_HORDE, F_VENDOR, F_BOE)
	self:AddCompanionAcquire(PetDB, 10685, A_VENDOR, 6548)

	-- Wood Frog Box - 10703
	AddPet(10703, 11027, R_COMMON, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 10703, F_ALLIANCE, F_HORDE, F_VENDOR, F_SEASONAL, F_BOE)
	self:AddCompanionAcquire(PetDB, 10703, A_VENDOR, 14860, A_SEASONAL, 3)

	-- Tree Frog Box - 10704
	AddPet(10704, 11026, R_COMMON, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 10704, F_ALLIANCE, F_HORDE, F_VENDOR, F_SEASONAL, F_BOE)
	self:AddCompanionAcquire(PetDB, 10704, A_VENDOR, 14860, A_SEASONAL, 3)

	-- Crimson Snake - 10717
	AddPet(10717, 10392, R_COMMON, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 10717, F_ALLIANCE, F_HORDE, F_VENDOR, F_BOE)
	self:AddCompanionAcquire(PetDB, 10717, A_VENDOR, 8404, A_VENDOR, 20980)

	-- Mana Wyrmling - 35156
	AddPet(35156, 29363, R_COMMON, GAME_TBC)
	self:AddCompanionFlags(PetDB, 35156, F_ALLIANCE, F_HORDE, F_VENDOR, F_BOE)
	self:AddCompanionAcquire(PetDB, 35156, A_VENDOR, 20980)

	-- Brown Rabbit Crate - 35239
	AddPet(35239, 29364, R_COMMON, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 35239, F_ALLIANCE, F_HORDE, F_VENDOR, F_BOE)
	self:AddCompanionAcquire(PetDB, 35239, A_VENDOR, 20980)

	-- Red Moth Egg - 35909
	AddPet(35909, 29902, R_COMMON, GAME_TBC)
	self:AddCompanionFlags(PetDB, 35909, F_ALLIANCE, F_HORDE, F_VENDOR, F_BOE)
	self:AddCompanionAcquire(PetDB, 35909, A_VENDOR, 20980)

	-- Blue Dragonhawk Hatchling - 36031
	AddPet(36031, 29958, R_COMMON, GAME_TBC)
	self:AddCompanionFlags(PetDB, 36031, F_ALLIANCE, F_HORDE, F_VENDOR, F_BOE)
	self:AddCompanionAcquire(PetDB, 36031, A_VENDOR, 20980)

	-- Ghostly Skull - 53316
	AddPet(53316, 39973, R_RARE, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 53316, F_ALLIANCE, F_HORDE, F_VENDOR, F_BOP)
	self:AddCompanionAcquire(PetDB, 53316, A_VENDOR, 29537)

	-- Obsidian Hatchling
	AddPet(67417, 48120, R_COMMON, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 67417, F_ALLIANCE, F_HORDE, F_VENDOR, F_BOE)
	self:AddCompanionAcquire(PetDB, 67417, A_VENDOR, 28951)

	-- Blue Clockwork Rocket Bot
	AddPet(75134, 54436, R_RARE, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 75134, F_ALLIANCE, F_HORDE, F_VENDOR, F_BOP)
	self:AddCompanionAcquire(PetDB, 75134, A_VENDOR, 29478, A_VENDOR, 29716)

--VENDOR HORDE
	-- Cockroach - 10688
	AddPet(10688, 10393, R_COMMON, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 10688, F_ALLIANCE, F_HORDE, F_VENDOR, F_BOE)
	self:AddCompanionAcquire(PetDB, 10688, A_VENDOR, 8403, A_VENDOR,20980)

	-- Prairie Dog Whistle - 10709
	AddPet(10709, 10394, R_COMMON, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 10709, F_HORDE, F_VENDOR, F_BOE)
	self:AddCompanionAcquire(PetDB, 10709, A_VENDOR, 8401)

	-- Black Kingsnake - 10714
	AddPet(10714, 10360, R_COMMON, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 10714, F_HORDE, F_VENDOR, F_BOE)
	self:AddCompanionAcquire(PetDB, 10714, A_VENDOR, 8404)

	-- Brown Snake - 10716
	AddPet(10716, 10361, R_COMMON, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 10716, F_HORDE, F_VENDOR, F_BOE)
	self:AddCompanionAcquire(PetDB, 10716, A_VENDOR, 8404)

	-- Golden Dragonhawk Hatchling - 36027
	AddPet(36027, 29953, R_COMMON, GAME_TBC)
	self:AddCompanionFlags(PetDB, 36027, F_HORDE, F_VENDOR, F_BOE)
	self:AddCompanionAcquire(PetDB, 36027, A_VENDOR, 16860)

	-- Red Dragonhawk Hatchling - 36028
	AddPet(36028, 29956, R_COMMON, GAME_TBC)
	self:AddCompanionFlags(PetDB, 36028, F_HORDE, F_VENDOR, F_BOE)
	self:AddCompanionAcquire(PetDB, 36028, A_VENDOR, 16860)

	-- Silver Dragonhawk Hatchling - 36029
	AddPet(36029, 29957, R_COMMON, GAME_TBC)
	self:AddCompanionFlags(PetDB, 36029, F_HORDE, F_VENDOR, F_BOE)
	self:AddCompanionAcquire(PetDB, 36029, A_VENDOR, 16860)

--VENDOR ALLIANCE
	-- Cat Carrier (Bombay) - 10673
	AddPet(10673, 8485, R_COMMON, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 10673, F_ALLIANCE, F_VENDOR, F_BOE)
	self:AddCompanionAcquire(PetDB, 10673, A_VENDOR, 6367)

	-- Cat Carrier (Cornish Rex) - 10674
	AddPet(10674, 8486, R_COMMON, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 10674, F_ALLIANCE, F_VENDOR, F_BOE)
	self:AddCompanionAcquire(PetDB, 10674, A_VENDOR, 6367)

	-- Cat Carrier (Orange Tabby) - 10676
	AddPet(10676, 8487, R_COMMON, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 10676, F_ALLIANCE, F_VENDOR, F_BOE)
	self:AddCompanionAcquire(PetDB, 10676, A_VENDOR,6367)

	-- Cat Carrier (Silver Tabby) - 10678
	AddPet(10678, 8488, R_COMMON, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 10678, F_ALLIANCE, F_VENDOR, F_BOE)
	self:AddCompanionAcquire(PetDB, 10678, A_VENDOR,6367)

	-- Cat Carrier (White Kitten) - 10679
	AddPet(10679, 8489, R_COMMON, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 10679, F_ALLIANCE, F_VENDOR, F_BOE)
	self:AddCompanionAcquire(PetDB, 10679, A_VENDOR, 8666)

	-- Hawk Owl - 10706
	AddPet(10706, 8501, R_COMMON, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 10706, F_ALLIANCE, F_VENDOR, F_BOE)
	self:AddCompanionAcquire(PetDB, 10706, A_VENDOR, 8665)

	-- Great Horned Owl - 10707
	AddPet(10707, 8500, R_COMMON, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 10707, F_ALLIANCE, F_VENDOR, F_BOE)
	self:AddCompanionAcquire(PetDB, 10707, A_VENDOR, 8665)

	-- Rabbit Crate (Snowshoe) - 10711
	AddPet(10711, 8497, R_COMMON, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 10711, F_ALLIANCE, F_VENDOR, F_BOE)
	self:AddCompanionAcquire(PetDB, 10711, A_VENDOR, 1263)

	-- Blue Moth Egg - 35907
	AddPet(35907, 29901, R_COMMON, GAME_TBC)
	self:AddCompanionFlags(PetDB, 35907, F_ALLIANCE, F_VENDOR, F_BOE)
	self:AddCompanionAcquire(PetDB, 35907, A_VENDOR, 21019)

	-- Yellow Moth Egg - 35910
	AddPet(35910, 29903, R_COMMON, GAME_TBC)
	self:AddCompanionFlags(PetDB, 35910, F_ALLIANCE, F_VENDOR, F_BOE)
	self:AddCompanionAcquire(PetDB, 35910, A_VENDOR, 21019)

	-- White Moth Egg - 35911
	AddPet(35911, 29904, R_COMMON, GAME_TBC)
	self:AddCompanionFlags(PetDB, 35911, F_ALLIANCE, F_VENDOR, F_BOE)
	self:AddCompanionAcquire(PetDB, 35911, A_VENDOR, 21019)

--RETIRED
	-- Spirit of Competition - 48406
	AddPet(48406, 37297, R_RARE, GAME_TBC)
	self:AddCompanionFlags(PetDB, 48406, F_ALLIANCE, F_HORDE, F_SPEC_EVENT, F_REMOVED, F_BOA)
	self:AddCompanionAcquire(PetDB, 48406, A_ACHIEVEMENT, 1637)

	-- Essence of Competition - 48408
	AddPet(48408, nil, R_UNCOMMON, GAME_TBC)
	self:AddCompanionFlags(PetDB, 48408, F_ALLIANCE, F_HORDE, F_SPEC_EVENT, F_REMOVED, F_BOA)
	self:AddCompanionAcquire(PetDB, 48408, A_CUSTOM, 13)

	-- Vampiric Batling - 51851
	AddPet(51851, 38658, R_RARE, GAME_TBC)
	self:AddCompanionFlags(PetDB, 51851, F_ALLIANCE, F_HORDE, F_RAID, F_MOB_DROP, F_SPEC_EVENT, F_REMOVED, F_BOP)
	self:AddCompanionAcquire(PetDB, 51851, A_ACHIEVEMENT, 2456, A_MOB, 28194)

	-- Baby Blizzard Bear - 61855
	AddPet(61855, 44819, R_COMMON, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 61855, F_ALLIANCE, F_HORDE, F_SPEC_EVENT, F_ACHIEVEMENT, F_REMOVED, F_BOA)
	self:AddCompanionAcquire(PetDB, 61855, A_ACHIEVEMENT, 2398)

	-- Murkimus' Little Spear - 63318
	AddPet(63318, 45180, R_RARE, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 63318, F_ALLIANCE, F_HORDE, F_SPEC_EVENT, F_REMOVED, F_PVP, F_BOA)
	self:AddCompanionAcquire(PetDB, 63318, A_ACHIEVEMENT, 3618, A_CUSTOM, 21)

	-- Onyxian Whelpling - 69002
	AddPet(69002, 49362, R_COMMON, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 69002, F_ALLIANCE, F_HORDE, F_ACHIEVEMENT, F_SPEC_EVENT, F_STORE, F_BOA)
	self:AddCompanionAcquire(PetDB, 69002, A_ACHIEVEMENT, 4400, A_CUSTOM, 36)

	-- Mr. Chilly - 55068
	AddPet(55068, 41133, R_RARE, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 55068, F_ALLIANCE, F_HORDE, F_SPEC_EVENT, F_REMOVED, F_BOA)
	self:AddCompanionAcquire(PetDB, 55068, A_CUSTOM, 28)


--COLLECTORS EDITION
	-- Diablo Stone - 17708
	AddPet(17708, 13584, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 17708, F_ALLIANCE, F_HORDE, F_COLLECTORS, F_REMOVED, F_BOA)
	self:AddCompanionAcquire(PetDB, 17708, A_ACHIEVEMENT, 662)

	-- Panda Collar - 17707
	AddPet(17707, 13583, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 17707, F_ALLIANCE, F_HORDE, F_COLLECTORS, F_REMOVED, F_BOA)
	self:AddCompanionAcquire(PetDB, 17707, A_ACHIEVEMENT, 663)

	-- Zergling Leash - 17709
	AddPet(17709, 13582, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 17709, F_ALLIANCE, F_HORDE, F_COLLECTORS, F_REMOVED, F_BOA)
	self:AddCompanionAcquire(PetDB, 17709, A_ACHIEVEMENT, 664)

	-- Lurky's Egg - 24988
	AddPet(24988, 30360, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 24988, F_ALLIANCE, F_HORDE, F_COLLECTORS, F_REMOVED, F_BOA)
	self:AddCompanionAcquire(PetDB, 24988, A_CUSTOM, 10)

	-- Netherwhelp's Collar - 32298
	AddPet(32298, 25535, R_RARE, GAME_TBC)
	self:AddCompanionFlags(PetDB, 32298, F_ALLIANCE, F_HORDE, F_COLLECTORS, F_REMOVED, F_BOA)
	self:AddCompanionAcquire(PetDB, 32298, A_ACHIEVEMENT, 665)

	-- Frosty's Collar - 52615
	AddPet(52615, 39286, R_RARE, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 52615, F_ALLIANCE, F_HORDE, F_COLLECTORS, F_REMOVED, F_BOA)
	self:AddCompanionAcquire(PetDB, 52615, A_ACHIEVEMENT, 683)

	-- Mini Thor - 78381
	AddPet(78381, 56806, R_RARE, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 78381, F_ALLIANCE, F_HORDE, F_COLLECTORS, F_REMOVED, F_BOA)
	self:AddCompanionAcquire(PetDB, 78381, A_ACHIEVEMENT, 4824)

--BLIZZ CON
	-- Blue Murloc Egg - 24696 (Murky)
	AddPet(24696, 20371, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 24696, F_ALLIANCE, F_HORDE, F_SPEC_EVENT, F_REMOVED, F_BOA)
	self:AddCompanionAcquire(PetDB, 24696, A_ACHIEVEMENT, 411)

	-- Heavy Murloc Egg
	AddPet(66030, 45180, R_RARE, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 66030, F_ALLIANCE, F_HORDE, F_SPEC_EVENT, F_REMOVED, F_BOP)
	self:AddCompanionAcquire(PetDB, 66030, A_ACHIEVEMENT, 3536)

--PROMO
	-- Pink Murloc Egg - 27241 (Gurky)
	AddPet(27241, 22114, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 27241, F_ALLIANCE, F_HORDE, F_SPEC_EVENT, F_REMOVED, F_BOA)
	self:AddCompanionAcquire(PetDB, 27241, A_CUSTOM, 6)

	-- Polar Bear Collar - 28505 (Poley)
	AddPet(28505, 22781, R_COMMON, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 28505, F_ALLIANCE, F_HORDE, F_SPEC_EVENT, F_REMOVED, F_BOA)
	self:AddCompanionAcquire(PetDB, 28505, A_CUSTOM, 7)

	-- Red Dragon Orb - 23531
	AddPet(23531, 19055, R_COMMON, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 23531, F_ALLIANCE, F_HORDE, F_SPEC_EVENT, F_REMOVED, F_BOA)
	self:AddCompanionAcquire(PetDB, 23531, A_CUSTOM, 7)
				
	-- Green Dragon Orb - 23530
	AddPet(23530, 19054, R_COMMON, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 23530, F_ALLIANCE, F_HORDE, F_SPEC_EVENT, F_REMOVED, F_BOA)
	self:AddCompanionAcquire(PetDB, 23530, A_CUSTOM, 7)

	-- Fortune Coin - 40405 (Lucky)
	AddPet(40405, 32498, R_RARE, GAME_TBC)
	self:AddCompanionFlags(PetDB, 40405, F_ALLIANCE, F_HORDE, F_SPEC_EVENT, F_REMOVED, F_BOA)
	self:AddCompanionAcquire(PetDB, 40405, A_CUSTOM, 12)

	-- Tyrael's Hilt - 53082
	AddPet(53082, 39656, R_ARTIFACT, GAME_TBC)
	self:AddCompanionFlags(PetDB, 53082, F_ALLIANCE, F_HORDE, F_SPEC_EVENT, F_STORE, F_BOA)
	self:AddCompanionAcquire(PetDB, 53082, A_ACHIEVEMENT, 414, A_CUSTOM, 36)

	-- Warbot
	AddPet(65682, 46767, R_RARE, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 65682, F_ALLIANCE, F_HORDE, F_SPEC_EVENT, F_REMOVED, F_BOP)
	self:AddCompanionAcquire(PetDB, 65682, A_CUSTOM, 24)

--TCG
	-- Banana Charm - 40549
	AddPet(40549, 32588, R_ARTIFACT, GAME_TBC)
	self:AddCompanionFlags(PetDB, 40549, F_ALLIANCE, F_HORDE, F_TCG, F_STORE, F_BOA)
	self:AddCompanionAcquire(PetDB, 40549, A_CUSTOM, 1, A_CUSTOM, 36)

	-- Rocket Chicken - 45125
	AddPet(45125, 34492, R_ARTIFACT, GAME_TBC)
	self:AddCompanionFlags(PetDB, 45125, F_ALLIANCE, F_HORDE, F_TCG, F_STORE, F_BOA)
	self:AddCompanionAcquire(PetDB, 45125, A_CUSTOM, 1, A_CUSTOM, 36)

	-- Dragon Kite - 45127
	AddPet(45127, 34493, R_ARTIFACT, GAME_TBC)
	self:AddCompanionFlags(PetDB, 45127, F_ALLIANCE, F_HORDE, F_TCG, F_STORE, F_BOA)
	self:AddCompanionAcquire(PetDB, 45127, A_CUSTOM, 1, A_CUSTOM, 36)

	-- Hippogryph Hatchling - 30156
	AddPet(30156, 23713, R_EPIC, GAME_TBC)
	self:AddCompanionFlags(PetDB, 30156, F_ALLIANCE, F_HORDE, F_TCG, F_BOP)
	self:AddCompanionAcquire(PetDB, 30156, A_CUSTOM, 1)

	-- Soul-Trader Beacon - 49964
	AddPet(49964, 38050, R_RARE, GAME_TBC)
	self:AddCompanionFlags(PetDB, 49964, F_ALLIANCE, F_HORDE, F_TCG, F_BOP)
	self:AddCompanionAcquire(PetDB, 49964, A_CUSTOM, 1)

	-- Tuskarr Kite - 68767
	AddPet(68767, 49287, R_EPIC, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 68767, F_ALLIANCE, F_HORDE, F_TCG, F_BOP)
	self:AddCompanionAcquire(PetDB, 68767, A_CUSTOM, 1)

	-- Spectral Tiger Cub - 68810
	AddPet(68810, 49343, R_RARE, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 68810, F_ALLIANCE, F_HORDE, F_TCG, F_BOP)
	self:AddCompanionAcquire(PetDB, 68810, A_CUSTOM, 1)

--PURCHASED
	-- Lil' K.T. - 69677
	AddPet(69677, 49693, R_ARTIFACT, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 69677, F_ALLIANCE, F_HORDE, F_STORE, F_BOA)
	self:AddCompanionAcquire(PetDB, 69677, A_CUSTOM, 4, A_CUSTOM, 36)

	-- Pandaren Monk - 69541
	AddPet(69541, 49665, R_RARE, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 69541, F_ALLIANCE, F_HORDE, F_STORE, F_BOA)
	self:AddCompanionAcquire(PetDB, 69541, A_CUSTOM, 4)

	-- Gryphon Hatchling - 69535
	AddPet(69535, 49662, R_RARE, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 69535, F_ALLIANCE, F_HORDE, F_STORE, F_BOA)
	self:AddCompanionAcquire(PetDB, 69535, A_CUSTOM, 4)

	-- Wind Rider Cub - 69536
	AddPet(69536, 49663, R_RARE, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 69536, F_ALLIANCE, F_HORDE, F_STORE, F_BOA)
	self:AddCompanionAcquire(PetDB, 69536, A_CUSTOM, 4)

	-- Lil' XT - 75906
	AddPet(75906, 54847, R_RARE, GAME_WOTLK)
	self:AddCompanionFlags(PetDB, 75906, F_ALLIANCE, F_HORDE, F_STORE, F_BOA)
	self:AddCompanionAcquire(PetDB, 75906, A_CUSTOM, 4)
	
	-- Aeon - 498784
	AddPet(498784, 499202, R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 498784, F_ALLIANCE, F_HORDE, F_STORE, F_BOE)
	self:AddCompanionAcquire(PetDB, 498784, A_CUSTOM, 36)
	
	-- Ancient Guardian of Dawn - 499666
	AddPet(499666, 499576,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 499666, F_ALLIANCE, F_HORDE, F_STORE, F_BOE)
	self:AddCompanionAcquire(PetDB, 499666, A_CUSTOM, 36)
	
	-- Kromlins Candle - 102100
	AddPet(102100, 102100,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 102100, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 102100, A_CUSTOM, 36)
	
	-- Nightsaber Cub - 979864
	AddPet(979864, 68841,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 979864, F_ALLIANCE, F_HORDE, F_STORE, F_BOE)
	self:AddCompanionAcquire(PetDB, 979864, A_CUSTOM, 36)
	
	-- Sunblade Rune of Activation - 499213
	AddPet(499213, 499388,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 499213, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 499213, A_CUSTOM, 36)
	
	-- Onyx Serpent Hatchling - 499219
	AddPet(499219, 499390,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 499219, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 499219, A_CUSTOM, 36)
	
	-- Syd - 498797
	AddPet(498797, 499305,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 498797, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 498797, A_CUSTOM, 36)
	
	-- Lootbot 3000 - 9930889
	AddPet(9930889, 57000,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 9930889, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 9930889, A_CUSTOM, 36)
	
	-- Portable Transmogrifier - 2002012
	AddPet(2002012, 1002087,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 2002012, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 2002012, A_CUSTOM, 36)
	
	-- Soul of the Aspects - 498798
	AddPet(498798, 499306,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 498798, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 498798, A_CUSTOM, 36)
	
	-- Treasure Keeper - 985356
	AddPet(985356, 99491,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 985356, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 985356, A_CUSTOM, 36)
	
	-- Wisper - 499763
	AddPet(499763, 499637,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 499763, F_ALLIANCE, F_HORDE, F_STORE, F_BOE)
	self:AddCompanionAcquire(PetDB, 499763, A_CUSTOM, 36)
	
	-- Zao,  Calfling of Niuzao - 499667
	AddPet(499667, 499577,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 499667, F_ALLIANCE, F_HORDE, F_STORE, F_BOE)
	self:AddCompanionAcquire(PetDB, 499667, A_CUSTOM, 36)
	
	-- Lil Nefarian - 499918
	AddPet(499918, 499633,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 499918, F_ALLIANCE, F_HORDE, F_STORE, F_BOE)
	self:AddCompanionAcquire(PetDB, 499918, A_CUSTOM, 36)
	
	-- Book of Artisans - 750750
	AddPet(750750, 750750, R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 750750, F_ALLIANCE, F_HORDE, F_STORE, F_BOE)
	self:AddCompanionAcquire(PetDB, 750750, A_CUSTOM, 36)
	
	-- Book of Ascension - 979602
	AddPet(979602, 98457,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 979602, F_ALLIANCE, F_HORDE, F_STORE, F_BOE)
	self:AddCompanionAcquire(PetDB, 979602, A_CUSTOM, 36)
	
	-- Bloodforged Book of Ascension - 499908
	AddPet(499908, 499920,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 499908, F_ALLIANCE, F_HORDE, F_STORE, F_BOP, F_REMOVED)
	self:AddCompanionAcquire(PetDB, 499908, A_CUSTOM, 36, A_CUSTOM, 44)
	
	-- Wild Book of Ascension - 979616
	AddPet(979616, 102133,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 979616, F_ALLIANCE, F_HORDE, F_STORE, F_BOE, F_REMOVED)
	self:AddCompanionAcquire(PetDB, 979616, A_CUSTOM, 36, A_CUSTOM, 44)
	
	-- Drafted Book of Ascension - 999315
	AddPet(999315, 99386,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 999315, F_ALLIANCE, F_HORDE, F_STORE, F_BOP, F_REMOVED)
	self:AddCompanionAcquire(PetDB, 999315, A_CUSTOM, 36, A_CUSTOM, 44)
	
	-- Nightmarish Book of Ascension - 979042
	AddPet(979042, 98450,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 979042, F_ALLIANCE, F_HORDE, F_STORE, F_BOP, F_REMOVED)
	self:AddCompanionAcquire(PetDB, 979042, A_CUSTOM, 36, A_CUSTOM, 44)
	
	-- Ruthless Book of Ascension - 999615
	AddPet(999615, 91461,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 999615, F_ALLIANCE, F_HORDE, F_STORE, F_BOP, F_REMOVED)
	self:AddCompanionAcquire(PetDB, 999615, A_CUSTOM, 36, A_CUSTOM, 44)
	
	-- Verdant Book of Ascension - 979615
	AddPet(979615, 98461,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 979615, F_ALLIANCE, F_HORDE, F_STORE, F_BOP, F_REMOVED)
	self:AddCompanionAcquire(PetDB, 979615, A_CUSTOM, 36, A_CUSTOM, 44)
	
	-- Vilemus Fel Crystal - 800555
	AddPet(800555, 800555,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 800555, F_ALLIANCE, F_HORDE, F_STORE, F_BOP, F_REMOVED)
	self:AddCompanionAcquire(PetDB, 800555, A_CUSTOM, 36, A_CUSTOM, 44)
	
	-- Pit Lords Eye - 985357
	AddPet(985357, 99492,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 985357, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 985357, A_CUSTOM, 36)
	
	-- Reborn Book of Ascension - 84287
	AddPet(84287, 637848,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84287, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 84287, A_CUSTOM, 36)
	
	-- Lil Alar - 84184
	AddPet(84184, 97320,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84184, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 84184, A_CUSTOM, 36)	
	
	-- Portable Silas Darkmoon - 999317
	AddPet(999317, 998100,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 999317, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 999317, A_CUSTOM, 36)	
	
--OTHER CUSTOM
	-- Bloody Rags (Troll Berserker) - 966036
	AddPet(966036, 100016, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 966036, F_ALLIANCE, F_HORDE, F_PVP, F_BOE)
	self:AddCompanionAcquire(PetDB, 966036, A_CUSTOM, 42)
	
	-- Greedy Demon - 979850
	AddPet(979850, 98460, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 979850, F_ALLIANCE, F_HORDE, F_STORE, F_WORLD_DROP, F_BOA)
	self:AddCompanionAcquire(PetDB, 979850, A_CUSTOM, 39, A_CUSTOM, 36)
	
	-- Chi-Chi,  Hatchling of Chi-Ji - 499564
	AddPet(499564, 499422, R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 499564, F_ALLIANCE, F_HORDE, F_VENDOR, F_BOE, F_REMOVED)
	self:AddCompanionAcquire(PetDB, 499564, A_CUSTOM, 41)
	
	-- Kute - 499563
	AddPet(499563, 499421, R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 499563, F_ALLIANCE, F_HORDE, F_VENDOR, F_BOE, F_REMOVED)
	self:AddCompanionAcquire(PetDB, 499563, A_CUSTOM, 41)
	
	-- Pandaren Fire Spirit - 499562
	AddPet(499562, 499420, R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 499562, F_ALLIANCE, F_HORDE, F_VENDOR, F_BOE, F_REMOVED)
	self:AddCompanionAcquire(PetDB, 499562, A_CUSTOM, 41)
	
	-- Ra Kim - 499565
	AddPet(499565, 499423, R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 499565, F_ALLIANCE, F_HORDE, F_VENDOR, F_BOE, F_REMOVED)
	self:AddCompanionAcquire(PetDB, 499565, A_CUSTOM, 41)

	-- Decaying Flesh - 966114
	AddPet(966114, 100018, R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 966114, F_ALLIANCE, F_HORDE, F_MOB_DROP, F_BOE, F_REMOVED)
	self:AddCompanionAcquire(PetDB, 966114, A_CUSTOM, 40)
	
	-- Felfire Impling - 966367
	AddPet(966367, 100566,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 966367, F_ALLIANCE, F_HORDE, F_MOB_DROP, F_BOE, F_REMOVED)
	self:AddCompanionAcquire(PetDB, 966367, A_CUSTOM, 40)
	
	-- Rotting Carcass (Grubby) - 965639
	AddPet(965639, 100006,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 965639, F_ALLIANCE, F_HORDE, F_MOB_DROP, F_BOE, F_REMOVED)
	self:AddCompanionAcquire(PetDB, 965639, A_CUSTOM, 40)
	
	-- Giant Qiraji Shell (Il'ixx the terrible) - 965641
	AddPet(965641, 100008,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 965641, F_ALLIANCE, F_HORDE, F_MOB_DROP, F_BOE, F_REMOVED)
	self:AddCompanionAcquire(PetDB, 965641, A_CUSTOM, 40)
	
	-- Scarab Shell - 965638
	AddPet(965638, 100003,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 965638, F_ALLIANCE, F_HORDE, F_MOB_DROP, F_BOE, F_REMOVED)
	self:AddCompanionAcquire(PetDB, 965638, A_CUSTOM, 40)
	
	-- Idol of the Watcher - 965640
	AddPet(965640, 100007,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 965640, F_ALLIANCE, F_HORDE, F_MOB_DROP, F_BOE, F_REMOVED)
	self:AddCompanionAcquire(PetDB, 965640, A_CUSTOM, 40)
	
	-- Lil Evil Eye - 966368
	AddPet(966368, 100567,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 966368, F_ALLIANCE, F_HORDE, F_MOB_DROP, F_BOE, F_REMOVED)
	self:AddCompanionAcquire(PetDB, 966368, A_CUSTOM, 40)
	
	-- Rattling Bones - 966115
	AddPet(966115, 100019,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 966115, F_ALLIANCE, F_HORDE, F_MOB_DROP, F_BOE, F_REMOVED)
	self:AddCompanionAcquire(PetDB, 966115, A_CUSTOM, 40)
	
	-- Burning Skull - 966116
	AddPet(966116, 100020,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 966116, F_ALLIANCE, F_HORDE, F_MOB_DROP, F_BOE, F_REMOVED)
	self:AddCompanionAcquire(PetDB, 966116, A_CUSTOM, 40)
	
	-- Brilliant Kaliri - 498743
	AddPet(498743, 499183, R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 498743, F_ALLIANCE, F_HORDE, F_ACHIEVEMENT, F_BOP)
	self:AddCompanionAcquire(PetDB, 498743, A_ACHIEVEMENT, 26149)
	
	-- Nuts Acorn - 498744
	AddPet(498744, 499184,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 498744, F_ALLIANCE, F_HORDE, F_ACHIEVEMENT, F_BOP)
	self:AddCompanionAcquire(PetDB, 498744, A_ACHIEVEMENT, 26148)
	
	-- Pet Cage - World First Archimonde - 842008
	AddPet(842008, 842008,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 842008, F_ALLIANCE, F_HORDE, F_ACHIEVEMENT, F_BOP, F_REMOVED)
	self:AddCompanionAcquire(PetDB, 842008, A_ACHIEVEMENT, 12493, A_ACHIEVEMENT, 14493)
	
	-- Pet Cage - World First Gruul - 842001
	AddPet(842001, 842001,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 842001, F_ALLIANCE, F_HORDE, F_ACHIEVEMENT, F_BOP, F_REMOVED)
	self:AddCompanionAcquire(PetDB, 842001, A_ACHIEVEMENT, 12477, A_ACHIEVEMENT, 14477)
	
	-- Pet Cage - World First Magtheridon - 842004
	AddPet(842004, 842004,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 842004, F_ALLIANCE, F_HORDE, F_ACHIEVEMENT, F_BOP, F_REMOVED)
	self:AddCompanionAcquire(PetDB, 842004, A_ACHIEVEMENT, 12478, A_ACHIEVEMENT, 14478)
	
	-- Pet Cage - World First Illidan Stormrage - 842009
	AddPet(842009, 842009,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 842009, F_ALLIANCE, F_HORDE, F_ACHIEVEMENT, F_BOP, F_REMOVED)
	self:AddCompanionAcquire(PetDB, 842009, A_ACHIEVEMENT, 12505, A_ACHIEVEMENT, 14505)
	
	-- Pet Cage - World First Malchezaar - 842002
	AddPet(842002, 842002,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 842002, F_ALLIANCE, F_HORDE, F_ACHIEVEMENT, F_BOP, F_REMOVED)
	self:AddCompanionAcquire(PetDB, 842002, A_ACHIEVEMENT, 12365, A_ACHIEVEMENT, 14365)
	
	-- Pet Cage - World First Kaelthas Sunstrider - 842007
	AddPet(842007, 842007,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 842007, F_ALLIANCE, F_HORDE, F_ACHIEVEMENT, F_BOP, F_REMOVED)
	self:AddCompanionAcquire(PetDB, 842007, A_ACHIEVEMENT, 12488, A_ACHIEVEMENT, 14488)
	
	-- Pet Cage - World First KilJaeden - 842010
	AddPet(842010, 842010,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 842010, F_ALLIANCE, F_HORDE, F_ACHIEVEMENT, F_BOP, F_REMOVED)
	self:AddCompanionAcquire(PetDB, 842010, A_ACHIEVEMENT, 12513, A_ACHIEVEMENT, 14513)
	
	-- Pet Cage - World First Lady Vashj - 842006
	AddPet(842006, 842006,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 842006, F_ALLIANCE, F_HORDE, F_ACHIEVEMENT, F_BOP, F_REMOVED)
	self:AddCompanionAcquire(PetDB, 842006, A_ACHIEVEMENT, 12484, A_ACHIEVEMENT, 14484)
	
	-- Pet Cage - World First Nightbane - 842003
	AddPet(842003, 842003,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 842003, F_ALLIANCE, F_HORDE, F_ACHIEVEMENT, F_BOP, F_REMOVED)
	self:AddCompanionAcquire(PetDB, 842003, A_ACHIEVEMENT, 12364, A_ACHIEVEMENT, 14364)
	
	-- Pet Cage - World First ZulJin - 842005
	AddPet(842005, 842005,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 842005, F_ALLIANCE, F_HORDE, F_ACHIEVEMENT, F_BOP, F_REMOVED)
	self:AddCompanionAcquire(PetDB, 842005, A_ACHIEVEMENT, 12371, A_ACHIEVEMENT, 14371)

	-- Chaotic Saber Cub - 999864
	AddPet(999864, 99985, R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 999864, F_ALLIANCE, F_HORDE, F_ACHIEVEMENT, F_BOE)
	self:AddCompanionAcquire(PetDB, 999864, A_ACHIEVEMENT, 6533, A_CUSTOM, 38)
	
	-- Crawling Claw - 999316
	AddPet(999316, 99385,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 999316, F_ALLIANCE, F_HORDE, F_ACHIEVEMENT, F_BOE)
	self:AddCompanionAcquire(PetDB, 999316, A_CUSTOM, 38)
	
	-- Legions Lexicon - 1008018
	AddPet(1008018, 1008017,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 1008018, F_ALLIANCE, F_HORDE, F_VENDOR, F_BOP)
	self:AddCompanionAcquire(PetDB, 1008018, A_CUSTOM, 38)
	
	-- Lump of Coal - 498762
	AddPet(498762, 499192,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 498762, F_ALLIANCE, F_HORDE, F_MOB_DROP, F_BOE)
	self:AddCompanionAcquire(PetDB, 498762, A_CUSTOM, 43)

	-- Sigil of Geras - 82253
	AddPet(82253, 79175, R_RARE, GAME_BC)
	self:AddCompanionFlags(PetDB, 82253, F_ALLIANCE, F_HORDE, F_VENDOR, F_BOE)
	self:AddCompanionAcquire(PetDB, 82253, A_VENDOR, 18525)
	
	-- Sigil of Qormaladon - 79084
	AddPet(79084, 79279,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 79084, F_ALLIANCE, F_HORDE, F_VENDOR, F_BOP)
	self:AddCompanionAcquire(PetDB, 79084, A_CUSTOM, 38)
	
	-- Sigil of the Twisting Nether Felguard - 79085
	AddPet(79085, 79280,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 79085, F_ALLIANCE, F_HORDE, F_VENDOR, F_BOP)
	self:AddCompanionAcquire(PetDB, 79085, A_CUSTOM, 38)
	
	-- Sigil of Beelzebub - 79086
	AddPet(79086, 79281,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 79086, F_ALLIANCE, F_HORDE, F_VENDOR, F_BOP)
	self:AddCompanionAcquire(PetDB, 79086, A_CUSTOM, 38)
	
	-- Dungeon Illuminator - 83050
	AddPet(83050, 101169,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83050, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 83050, A_CUSTOM, 36)
	
	-- Unstable Lightwell - 83101
	AddPet(83101, 101180,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83101, F_ALLIANCE, F_HORDE, F_VENDOR, F_BOP)
	self:AddCompanionAcquire(PetDB, 83101, A_CUSTOM, 38)
	
	-- Kleptomanic Demon Leash - 83086
	AddPet(83086, 101172,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83086, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 83086, A_CUSTOM, 36)
	
	-- Transmogrifier Gimbly - 83087
	AddPet(83087, 101173,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83087, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 83087, A_CUSTOM, 36)
	
	-- Alliance Balloon - 83099
	AddPet(83099, 101178,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83099, F_ALLIANCE, F_HORDE, F_VENDOR, F_BOP)
	self:AddCompanionAcquire(PetDB, 83099, A_CUSTOM, 38)
	
	-- Horde Balloon - 83100
	AddPet(83100, 101179,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83100, F_ALLIANCE, F_HORDE, F_VENDOR, F_BOP)
	self:AddCompanionAcquire(PetDB, 83100, A_CUSTOM, 38)
	
	-- Lil Chromaggus Whistle - 84200 - UNKNOWN WHERE THIS COMES FROM
	AddPet(84200, 97331,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84200, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 84200, A_CUSTOM, 38)
	
	-- Microbot 8D - 84776 - UNKNOWN WHERE THIS COMES FROM
	AddPet(84776, 246188,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84776, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 84776, A_CUSTOM, 38)	
	
	-- Necrotic Book of Ascension - 979043
	AddPet(979043, 6300095,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 979043, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 979043, A_CUSTOM, 36)
	
	-- Spiteful Apparition - 102103
	AddPet(102103, 102103,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 102103, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 102103, A_CUSTOM, 36)

	-- White Murloc Egg - 28487
	AddPet(28487, 22780,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 28487, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 28487, A_CUSTOM, 37)
	
	-- Silver Pig Coin - 45175
	AddPet(45175, 34519,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 45175, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 45175, A_CUSTOM, 37)
	
	-- Withers - 9931385
	AddPet(9931385, 46325,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 9931385, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 9931385, A_CUSTOM, 37)
	
	-- Enchanted Jade - 9931400
	AddPet(9931400, 46894,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 9931400, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 9931400, A_CUSTOM, 37)
	
	-- Enchanted Onyx - 67527
	AddPet(67527, 48527,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 67527, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 67527, A_CUSTOM, 37)
	
	-- Enchanted Purple Jade - 9931401
	AddPet(9931401, 49664,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 9931401, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 9931401, A_CUSTOM, 37)
	
	-- Celestial Dragon - 75613
	AddPet(75613, 54810,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 75613, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 75613, A_CUSTOM, 37)
	
	-- De-Weaponized Mechanical Companion - 9931388
	AddPet(9931388, 60216,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 9931388, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 9931388, A_CUSTOM, 37)
	
	-- Pebble - 9931379
	AddPet(9931379, 60869,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 9931379, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 9931379, A_CUSTOM, 37)
	
	-- Rustberg Gull - 9931390
	AddPet(9931390, 63355,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 9931390, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 9931390, A_CUSTOM, 37)
	
	-- Clockwork Gnome - 9931407
	AddPet(9931407, 64372,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 9931407, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 9931407, A_CUSTOM, 37)
	
	-- Fox Kit - 9931395
	AddPet(9931395, 64403,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 9931395, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 9931395, A_CUSTOM, 37)
	
	-- Tiny Shale Spider - 9931398
	AddPet(9931398, 64494,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 9931398, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 9931398, A_CUSTOM, 37)
	
	-- Snail Shell - 9931391
	AddPet(9931391, 66073,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 9931391, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 9931391, A_CUSTOM, 37)
	
	-- Mr. Grubbs - 9931397
	AddPet(9931397, 66076,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 9931397, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 9931397, A_CUSTOM, 37)
	
	-- Enchanted Lantern - 9931386
	AddPet(9931386, 67274,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 9931386, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 9931386, A_CUSTOM, 37)
	
	-- Magic Lamp - 9931387
	AddPet(9931387, 67275,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 9931387, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 9931387, A_CUSTOM, 37)
	
	-- Elementium Geode - 9931393
	AddPet(9931393, 67282,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 9931393, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 9931393, A_CUSTOM, 37)
	
	-- Owlkin Hatchling - 9931381
	AddPet(9931381, 68618,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 9931381, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 9931381, A_CUSTOM, 37)
	
	-- Moonkin Hatchling - 9931382
	AddPet(9931382, 68619,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 9931382, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 9931382, A_CUSTOM, 37)
	
	-- Lashtail Hatchling - 9931392
	AddPet(9931392, 69251,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 9931392, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 9931392, A_CUSTOM, 37)
	
	-- Legs - 9931394
	AddPet(9931394, 69648,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 9931394, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 9931394, A_CUSTOM, 37)
	
	-- Crimson Lasher - 9931389
	AddPet(9931389, 70160,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 9931389, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 9931389, A_CUSTOM, 37)

	-- Grell Moss - 9931396
	AddPet(9931396, 72134,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 9931396, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 9931396, A_CUSTOM, 37)
	
	-- Darkmoon Monkey - 9931355
	AddPet(9931355, 73764,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 9931355, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 9931355, A_CUSTOM, 44)
	
	-- Darkmoon Turtle - 9931356
	AddPet(9931356, 73765,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 9931356, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 9931356, A_CUSTOM, 44)
	
	-- Darkmoon Zeppelin - 9931361
	AddPet(9931361, 73905,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 9931361, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 9931361, A_CUSTOM, 44)
	
	-- Darkmoon Cub - 9931359
	AddPet(9931359, 74981,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 9931359, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 9931359, A_CUSTOM, 44)
	
	-- Darkmoon Rabbit - 9931358
	AddPet(9931358, 80008,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 9931358, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 9931358, A_CUSTOM, 44)
	
	-- Sapphire Cub - 9931399
	AddPet(9931399, 82775,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 9931399, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 9931399, A_CUSTOM, 37)
	
	-- Baneling - 9931402
	AddPet(9931402, 90177,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 9931402, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 9931402, A_CUSTOM, 37)
	
	-- Darkmoon Hatchling - 9931360
	AddPet(9931360, 91003,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 9931360, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 9931360, A_CUSTOM, 44)
	
	-- Darkmoon Eye - 9931357
	AddPet(9931357, 91040,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 9931357, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 9931357, A_CUSTOM, 47)
	
	-- Sigil of Goldilocks - 92453
	AddPet(92453, 97393,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 92453, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 92453, A_CUSTOM, 44)
	
	-- Corgi Pup - 9931384
	AddPet(9931384, 136925,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 9931384, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 9931384, A_CUSTOM, 37)
	
	-- Corgnelius - 9931383
	AddPet(9931383, 140320,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 9931383, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 9931383, A_CUSTOM, 37)
	
	-- [HR] Tike Myson - 101500
	AddPet(101500, 500750,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 101500, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 101500, A_CUSTOM, 47)
	
	-- Tike Myson - 101501
	AddPet(101501, 500751,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 101501, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 101501, A_CUSTOM, 47)
	
	-- Pet Cage - World First Magtheridon 25 HC - 842104
	AddPet(842104, 842104,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 842104, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 842104, A_CUSTOM, 47)
	
	-- Pet Cage - World First Lady Vashj Ascended (25 Player) - 942100
	AddPet(942100, 942100,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 942100, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 942100, A_CUSTOM, 47)
	
	-- Pet Cage - Wildcard World First Lady Vashj Ascended (10 Player) - 942101
	AddPet(942101, 942101,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 942101, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 942101, A_CUSTOM, 47)
	
	-- Pet Cage - Wildcard World First Lady Vashj Ascended (25 Player) - 942102
	AddPet(942102, 942102,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 942102, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 942102, A_CUSTOM, 47)
	
	-- Mobile Stable Master - 9931336
	AddPet(9931336, 1777070,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 9931336, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 9931336, A_CUSTOM, 47)
	
	-- Tiny Amani Elite War Bear (Green) - 9931476
	AddPet(9931476, 1777230,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 9931476, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 9931476, A_CUSTOM, 37)
	
	-- Tiny Amani Elite War Bear (Brown) - 13801564
	AddPet(13801564, 1777231,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 13801564, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 13801564, A_CUSTOM, 37)
	
	-- Tiny Amani Elite War Bear (Yellow) - 13801565
	AddPet(13801565, 1777232,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 13801565, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 13801565, A_CUSTOM, 37)
	
	-- Tiny Amani Elite War Bear (Red) - 13801566
	AddPet(13801566, 1777233,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 13801566, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 13801566, A_CUSTOM, 37)
	
	-- Tiny Amani Elite War Bear (Pink) - 13801567
	AddPet(13801567, 1777234,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 13801567, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 13801567, A_CUSTOM, 37)
	
	-- Tiny Amani Elite War Bear (Purple) - 13801568
	AddPet(13801568, 1777235,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 13801568, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 13801568, A_CUSTOM, 37)
	
	-- Baa'l - 9931477
	AddPet(9931477, 1777245,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 9931477, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 9931477, A_CUSTOM, 44)
	
	-- Miimii - 9931485
	AddPet(9931485, 1777253,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 9931485, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 9931485, A_CUSTOM, 44)
	
	-- Sir Snips - 9931501
	AddPet(9931501, 1777269,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 9931501, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 9931501, A_CUSTOM, 44)
	
	-- Bucketshell - 9931502
	AddPet(9931502, 1777270,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 9931502, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 9931502, A_CUSTOM, 44)
	
	-- Unleashed Book of Ascension - 9931566
	AddPet(9931566, 1777357,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 9931566, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 9931566, A_CUSTOM, 44)
	
	-- Pet Cage - World First Kael'thas Sunstrider (25 Player) - 1842007
	AddPet(1842007, 1842007,  R_ARTIFACT, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 1842007, F_ALLIANCE, F_HORDE, F_STORE, F_BOP)
	self:AddCompanionAcquire(PetDB, 1842007, A_CUSTOM, 47)	
	
--SIGILS
	-- Sigil of 7:XT - 82068
	AddPet(82068, 60025, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82068, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82068, A_CUSTOM, 46)
	
	-- Sigil of 8th Legion Marine - 84130
	AddPet(84130, 72172, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84130, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84130, A_CUSTOM, 46)
	
	-- Sigil of Abhorrent Aberration - 83809
	AddPet(83809, 70677, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83809, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83809, A_CUSTOM, 46)
	
	-- Sigil of Accursed Slitherblade - 82073
	AddPet(82073, 60030, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82073, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82073, A_CUSTOM, 46)
	
	-- Sigil of Achellios the Banished - 81772
	AddPet(81772, 58220, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81772, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81772, A_CUSTOM, 46)
	
	-- Sigil of Aean Swiftriver - 81734
	AddPet(81734, 57677, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81734, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81734, A_CUSTOM, 46)
	
	-- Sigil of Aeonus - 82318
	AddPet(82318, 61371, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82318, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82318, A_CUSTOM, 46)
	
	-- Sigil of Agathelos the Raging - 81688
	AddPet(81688, 57631, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81688, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81688, A_CUSTOM, 46)
	
	-- Sigil of Aggem Thorncurse - 81689
	AddPet(81689, 57632, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81689, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81689, A_CUSTOM, 46)
	
	-- Sigil of Akilzon - 82520
	AddPet(82520, 63943, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82520, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82520, A_CUSTOM, 46)
	
	-- Sigil of Akkrilus - 81664
	AddPet(81664, 57607, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81664, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81664, A_CUSTOM, 46)
	
	-- Sigil of Akumai - 84326
	AddPet(84326, 72775, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84326, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84326, A_CUSTOM, 46)
	
	-- Sigil of Akumai - 81695
	AddPet(81695, 57638, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81695, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81695, A_CUSTOM, 46)
	
	-- Sigil of Akubar the Seer - 81856
	AddPet(81856, 59812, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81856, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81856, A_CUSTOM, 46)
	
	-- Sigil of Alar - 82404
	AddPet(82404, 62443, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82404, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82404, A_CUSTOM, 46)
	
	-- Sigil of Alliance Guard - 84129
	AddPet(84129, 72171, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84129, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84129, A_CUSTOM, 46)
	
	-- Sigil of Alshirr Banebreath - 82105
	AddPet(82105, 60062, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82105, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82105, A_CUSTOM, 46)
	
	-- Sigil of Alzzin the Wildshaper - 82005
	AddPet(82005, 59962, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82005, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82005, A_CUSTOM, 46)
	
	-- Sigil of Amanitar - 82729
	AddPet(82729, 64152, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82729, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82729, A_CUSTOM, 46)
	
	-- Sigil of Ambassador Bloodrage - 81823
	AddPet(81823, 58900, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81823, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81823, A_CUSTOM, 46)
	
	-- Sigil of Ambassador Flamelash - 81887
	AddPet(81887, 59843, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81887, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81887, A_CUSTOM, 46)
	
	-- Sigil of Ambassador Hellmaw - 82385
	AddPet(82385, 62306, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82385, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82385, A_CUSTOM, 46)
	
	-- Sigil of Ambassador Jerrikar - 82378
	AddPet(82378, 62297, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82378, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82378, A_CUSTOM, 46)
	
	-- Sigil of Amnennar the Coldbringer - 81818
	AddPet(81818, 58874, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81818, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81818, A_CUSTOM, 46)
	
	-- Sigil of Anathemus - 81634
	AddPet(81634, 57109, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81634, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81634, A_CUSTOM, 46)
	
	-- Sigil of Ancient Stone Keeper - 81808
	AddPet(81808, 58857, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81808, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81808, A_CUSTOM, 46)
	
	-- Sigil of Anetheron - 82309
	AddPet(82309, 61287, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82309, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82309, A_CUSTOM, 46)
	
	-- Sigil of Anomalus - 82598
	AddPet(82598, 64021, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82598, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82598, A_CUSTOM, 46)
	
	-- Sigil of Antilos - 81794
	AddPet(81794, 58786, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81794, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81794, A_CUSTOM, 46)
	
	-- Sigil of Antilus the Soarer - 81707
	AddPet(81707, 57650, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81707, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81707, A_CUSTOM, 46)
	
	-- Sigil of Antusul - 81826
	AddPet(81826, 59124, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81826, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81826, A_CUSTOM, 46)
	
	-- Sigil of Anubarak - 82989
	AddPet(82989, 67266, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82989, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82989, A_CUSTOM, 46)
	
	-- Sigil of Anubarak - 82687
	AddPet(82687, 64110, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82687, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82687, A_CUSTOM, 46)
	
	-- Sigil of AnubRekhan - 82229
	AddPet(82229, 60182, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82229, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82229, A_CUSTOM, 46)
	
	-- Sigil of Anzu - 82509
	AddPet(82509, 63932, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82509, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82509, A_CUSTOM, 46)
	
	-- Sigil of Aotona - 82846
	AddPet(82846, 64268, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82846, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82846, A_CUSTOM, 46)
	
	-- Sigil of Apothecary Falthis - 81662
	AddPet(81662, 57605, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81662, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81662, A_CUSTOM, 46)
	
	-- Sigil of Araga - 82066
	AddPet(82066, 60023, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82066, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82066, A_CUSTOM, 46)
	
	-- Sigil of Arash-ethis - 81709
	AddPet(81709, 57652, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81709, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81709, A_CUSTOM, 46)
	
	-- Sigil of Arcanist Doan - 81783
	AddPet(81783, 58411, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81783, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81783, A_CUSTOM, 46)
	
	-- Sigil of Arch Mage Merlin - 84160
	AddPet(84160, 72241, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84160, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84160, A_CUSTOM, 46)
	
	-- Sigil of Archaedas - 81629
	AddPet(81629, 57104, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81629, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81629, A_CUSTOM, 46)
	
	-- Sigil of Archavon the Stone Watcher - 82775
	AddPet(82775, 64198, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82775, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82775, A_CUSTOM, 46)
	
	-- Sigil of Archimonde - 82325
	AddPet(82325, 61557, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82325, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82325, A_CUSTOM, 46)
	
	-- Sigil of Archivist Galford - 81975
	AddPet(81975, 59932, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81975, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81975, A_CUSTOM, 46)
	
	-- Sigil of Archmage Arugal - 81682
	AddPet(81682, 57625, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81682, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81682, A_CUSTOM, 46)
	
	-- Sigil of Arcturis - 83244
	AddPet(83244, 68615, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83244, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83244, A_CUSTOM, 46)
	
	-- Sigil of Arygos - 84260
	AddPet(84260, 72709, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84260, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84260, A_CUSTOM, 46)
	
	-- Sigil of Atalalarion - 81866
	AddPet(81866, 59822, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81866, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81866, A_CUSTOM, 46)
	
	-- Sigil of Attumen the Huntsman - 82245
	AddPet(82245, 60198, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82245, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82245, A_CUSTOM, 46)
	
	-- Sigil of Auriaya - 82912
	AddPet(82912, 64427, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82912, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82912, A_CUSTOM, 46)
	
	-- Sigil of Ava - 84165
	AddPet(84165, 72290, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84165, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84165, A_CUSTOM, 46)
	
	-- Sigil of Avatar of Hakkar - 81863
	AddPet(81863, 59819, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81863, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81863, A_CUSTOM, 46)
	
	-- Sigil of Ayamiss the Hunter - 84256
	AddPet(84256, 72654, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84256, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84256, A_CUSTOM, 46)
	
	-- Sigil of Ayamiss the Hunter - 82181
	AddPet(82181, 60137, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82181, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82181, A_CUSTOM, 46)
	
	-- Sigil of Azgalor - 82311
	AddPet(82311, 61289, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82311, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82311, A_CUSTOM, 46)
	
	-- Sigil of Azshir the Sleepless - 81786
	AddPet(81786, 58495, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81786, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81786, A_CUSTOM, 46)
	
	-- Sigil of Azuregos - 81776
	AddPet(81776, 58226, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81776, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81776, A_CUSTOM, 46)
	
	-- Sigil of Azurous - 81924
	AddPet(81924, 59880, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81924, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81924, A_CUSTOM, 46)
	
	-- Sigil of Azzere the Skyblade - 81751
	AddPet(81751, 57908, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81751, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81751, A_CUSTOM, 46)
	
	-- Sigil of BaelGar - 81875
	AddPet(81875, 59831, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81875, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81875, A_CUSTOM, 46)
	
	-- Sigil of Baelog - 81799
	AddPet(81799, 58847, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81799, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81799, A_CUSTOM, 46)
	
	-- Sigil of Balnazzar - 81976
	AddPet(81976, 59933, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81976, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81976, A_CUSTOM, 46)
	
	-- Sigil of Baltharus the Warborn - 83304
	AddPet(83304, 68725, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83304, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83304, A_CUSTOM, 46)
	
	-- Sigil of Bannok Grimaxe - 81901
	AddPet(81901, 59857, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81901, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81901, A_CUSTOM, 46)
	
	-- Sigil of Barnabus - 81633
	AddPet(81633, 57108, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81633, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81633, A_CUSTOM, 46)
	
	-- Sigil of Baron Aquanis - 84332
	AddPet(84332, 72781, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84332, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84332, A_CUSTOM, 46)
	
	-- Sigil of Baron Bloodbane - 81979
	AddPet(81979, 59936, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81979, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81979, A_CUSTOM, 46)
	
	-- Sigil of Baron Geddon - 84301
	AddPet(84301, 72750, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84301, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84301, A_CUSTOM, 46)
	
	-- Sigil of Baron Geddon - 84227
	AddPet(84227, 72565, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84227, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84227, A_CUSTOM, 46)
	
	-- Sigil of Baron Geddon - 84112
	AddPet(84112, 72142, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84112, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84112, A_CUSTOM, 46)
	
	-- Sigil of Baron Geddon - 83317
	AddPet(83317, 68816, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83317, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83317, A_CUSTOM, 46)
	
	-- Sigil of Baron Geddon - 82032
	AddPet(82032, 59989, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82032, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82032, A_CUSTOM, 46)
	
	-- Sigil of Baron Kazum - 82168
	AddPet(82168, 60124, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82168, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82168, A_CUSTOM, 46)
	
	-- Sigil of Baron Rivendare - 81950
	AddPet(81950, 59907, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81950, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81950, A_CUSTOM, 46)
	
	-- Sigil of Baron Silverlaine - 81669
	AddPet(81669, 57612, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81669, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81669, A_CUSTOM, 46)
	
	-- Sigil of Baroness Anastari - 81946
	AddPet(81946, 59903, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81946, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81946, A_CUSTOM, 46)
	
	-- Sigil of Battleguard Sartura - 84264
	AddPet(84264, 72713, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84264, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84264, A_CUSTOM, 46)
	
	-- Sigil of Battleguard Sartura - 82203
	AddPet(82203, 60156, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82203, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82203, A_CUSTOM, 46)
	
	-- Sigil of Bayne - 81934
	AddPet(81934, 59890, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81934, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81934, A_CUSTOM, 46)
	
	-- Sigil of Bazil Thredd - 81579
	AddPet(81579, 56972, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81579, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81579, A_CUSTOM, 46)
	
	-- Sigil of Bazzalan - 82013
	AddPet(82013, 59970, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82013, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82013, A_CUSTOM, 46)
	
	-- Sigil of Beezlebub - 84209
	AddPet(84209, 72546, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84209, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84209, A_CUSTOM, 46)
	
	-- Sigil of Belphegor - 84208
	AddPet(84208, 72545, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84208, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84208, A_CUSTOM, 46)
	
	-- Sigil of Big Samras - 82095
	AddPet(82095, 60052, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82095, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82095, A_CUSTOM, 46)
	
	-- Sigil of Biggelrott - 83896
	AddPet(83896, 71188, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83896, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83896, A_CUSTOM, 46)
	
	-- Sigil of Bjarn - 81563
	AddPet(81563, 56955, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81563, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81563, A_CUSTOM, 46)
	
	-- Sigil of Blackheart the Inciter - 82361
	AddPet(82361, 61629, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82361, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82361, A_CUSTOM, 46)
	
	-- Sigil of Blackmoss the Fetid - 81648
	AddPet(81648, 57591, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81648, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81648, A_CUSTOM, 46)
	
	-- Sigil of Blind Hunter - 81690
	AddPet(81690, 57633, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81690, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81690, A_CUSTOM, 46)
	
	-- Sigil of Blood Guard Porung - 82451
	AddPet(82451, 63297, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82451, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82451, A_CUSTOM, 46)
	
	-- Sigil of Bloodlord Mandokir - 84218
	AddPet(84218, 72556, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84218, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84218, A_CUSTOM, 46)
	
	-- Sigil of Bloodlord Mandokir - 81996
	AddPet(81996, 59953, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81996, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81996, A_CUSTOM, 46)
	
	-- Sigil of Bloodmage Thalnos - 81694
	AddPet(81694, 57637, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81694, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81694, A_CUSTOM, 46)
	
	-- Sigil of Blood-Queen Lanathel - 83209
	AddPet(83209, 68243, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83209, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83209, A_CUSTOM, 46)
	
	-- Sigil of Bloodroar the Stalker - 81706
	AddPet(81706, 57649, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81706, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81706, A_CUSTOM, 46)
	
	-- Sigil of Boahn - 81658
	AddPet(81658, 57601, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81658, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81658, A_CUSTOM, 46)
	
	-- Sigil of Bog Lurker - 82368
	AddPet(82368, 62031, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82368, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82368, A_CUSTOM, 46)
	
	-- Sigil of Bone Witch - 82251
	AddPet(82251, 60368, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82251, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82251, A_CUSTOM, 46)
	
	-- Sigil of Boss Galgosh - 81569
	AddPet(81569, 56961, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81569, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81569, A_CUSTOM, 46)
	
	-- Sigil of Boulderheart - 82089
	AddPet(82089, 60046, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82089, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82089, A_CUSTOM, 46)
	
	-- Sigil of Brack - 81536
	AddPet(81536, 56928, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81536, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81536, A_CUSTOM, 46)
	
	-- Sigil of Brainwashed Noble - 81543
	AddPet(81543, 56935, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81543, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81543, A_CUSTOM, 46)
	
	-- Sigil of Branch Snapper - 81967
	AddPet(81967, 59924, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81967, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81967, A_CUSTOM, 46)
	
	-- Sigil of BroGaz the Clanless - 82370
	AddPet(82370, 62042, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82370, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82370, A_CUSTOM, 46)
	
	-- Sigil of Broggok - 82286
	AddPet(82286, 60949, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82286, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82286, A_CUSTOM, 46)
	
	-- Sigil of Broken Tooth - 81637
	AddPet(81637, 57141, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81637, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81637, A_CUSTOM, 46)
	
	-- Sigil of Brokespear - 81755
	AddPet(81755, 57995, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81755, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81755, A_CUSTOM, 46)
	
	-- Sigil of Bronjahm - 83147
	AddPet(83147, 67907, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83147, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83147, A_CUSTOM, 46)
	
	-- Sigil of Brontus - 81745
	AddPet(81745, 57883, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81745, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81745, A_CUSTOM, 46)
	
	-- Sigil of Broodlord Lashlayer - 84225
	AddPet(84225, 72563, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84225, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84225, A_CUSTOM, 46)
	
	-- Sigil of Broodlord Lashlayer - 82029
	AddPet(82029, 59986, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82029, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82029, A_CUSTOM, 46)
	
	-- Sigil of Brother Ravenoak - 81767
	AddPet(81767, 58213, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81767, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81767, A_CUSTOM, 46)
	
	-- Sigil of Bruegal Ironknuckle - 81581
	AddPet(81581, 56974, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81581, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81581, A_CUSTOM, 46)
	
	-- Sigil of Brun - 81025
	AddPet(81025, 103721, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81025, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81025, A_CUSTOM, 46)
	
	-- Sigil of Brutallus - 82553
	AddPet(82553, 63976, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82553, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82553, A_CUSTOM, 46)
	
	-- Sigil of Burgle Eye - 82074
	AddPet(82074, 60031, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82074, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82074, A_CUSTOM, 46)
	
	-- Sigil of Burning Felguard - 81931
	AddPet(81931, 59887, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81931, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81931, A_CUSTOM, 46)
	
	-- Sigil of Buru the Gorger - 84257
	AddPet(84257, 72680, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84257, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84257, A_CUSTOM, 46)
	
	-- Sigil of Buru the Gorger - 82182
	AddPet(82182, 60138, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82182, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82182, A_CUSTOM, 46)
	
	-- Sigil of CThun - 84269
	AddPet(84269, 72718, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84269, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84269, A_CUSTOM, 46)
	
	-- Sigil of CThun - 82218
	AddPet(82218, 60171, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82218, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82218, A_CUSTOM, 46)
	
	-- Sigil of Caelestrasz - 84259
	AddPet(84259, 72708, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84259, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84259, A_CUSTOM, 46)
	
	-- Sigil of Cairne Bloodhoof - 84350
	AddPet(84350, 73037, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84350, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84350, A_CUSTOM, 46)
	
	-- Sigil of Cairne Bloodhoof - 81640
	AddPet(81640, 57564, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81640, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81640, A_CUSTOM, 46)
	
	-- Sigil of Cannon Master Willey - 81992
	AddPet(81992, 59949, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81992, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81992, A_CUSTOM, 46)
	
	-- Sigil of Captain Balinda Stonehearth - 82023
	AddPet(82023, 59980, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82023, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82023, A_CUSTOM, 46)
	
	-- Sigil of Captain Flat Tusk - 81743
	AddPet(81743, 57881, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81743, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81743, A_CUSTOM, 46)
	
	-- Sigil of Captain Galvangar - 82021
	AddPet(82021, 59978, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82021, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82021, A_CUSTOM, 46)
	
	-- Sigil of Captain Gerogg Hammertoe - 81761
	AddPet(81761, 58149, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81761, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81761, A_CUSTOM, 46)
	
	-- Sigil of Captain Greenskin - 81552
	AddPet(81552, 56944, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81552, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81552, A_CUSTOM, 46)
	
	-- Sigil of Captain Kromcrush - 82101
	AddPet(82101, 60058, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82101, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82101, A_CUSTOM, 46)
	
	-- Sigil of Captain Sayana Stormrunner - 84096
	AddPet(84096, 72116, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84096, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84096, A_CUSTOM, 46)
	
	-- Sigil of Carnivous the Breaker - 81608
	AddPet(81608, 57003, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81608, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81608, A_CUSTOM, 46)
	
	-- Sigil of Celebras the Cursed - 82040
	AddPet(82040, 59997, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82040, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82040, A_CUSTOM, 46)
	
	-- Sigil of Charlga Razorflank - 81687
	AddPet(81687, 57630, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81687, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81687, A_CUSTOM, 46)
	
	-- Sigil of Chatter - 81546
	AddPet(81546, 56938, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81546, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81546, A_CUSTOM, 46)
	
	-- Sigil of Chief Engineer Lorthander - 84359
	AddPet(84359, 73081, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84359, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84359, A_CUSTOM, 46)
	
	-- Sigil of Chief Engineer Lorthander - 82380
	AddPet(82380, 62300, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82380, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82380, A_CUSTOM, 46)
	
	-- Sigil of Chief Ukorz Sandscalp - 81810
	AddPet(81810, 58859, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81810, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81810, A_CUSTOM, 46)
	
	-- Sigil of ChoRush the Observer - 82100
	AddPet(82100, 60057, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82100, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82100, A_CUSTOM, 46)
	
	-- Sigil of Chromaggus - 84235
	AddPet(84235, 72573, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84235, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84235, A_CUSTOM, 46)
	
	-- Sigil of Chromaggus - 82064
	AddPet(82064, 60021, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82064, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82064, A_CUSTOM, 46)
	
	-- Sigil of Chromie - 83507
	AddPet(83507, 69384, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83507, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83507, A_CUSTOM, 46)
	
	-- Sigil of Chrono Lord Deja - 82316
	AddPet(82316, 61304, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82316, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82316, A_CUSTOM, 46)
	
	-- Sigil of Chrono-Lord Epoch - 82589
	AddPet(82589, 64012, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82589, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82589, A_CUSTOM, 46)
	
	-- Sigil of Clack the Reaver - 81859
	AddPet(81859, 59815, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81859, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81859, A_CUSTOM, 46)
	
	-- Sigil of Clutchmother Zavas - 81788
	AddPet(81788, 58497, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81788, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81788, A_CUSTOM, 46)
	
	-- Sigil of Coilfang Emissary - 82367
	AddPet(82367, 62030, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82367, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82367, A_CUSTOM, 46)
	
	-- Sigil of Collidus the Warp-Watcher - 82377
	AddPet(82377, 62296, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82377, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82377, A_CUSTOM, 46)
	
	-- Sigil of Commander Felstrom - 81554
	AddPet(81554, 56946, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81554, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81554, A_CUSTOM, 46)
	
	-- Sigil of Commander Sarannis - 82327
	AddPet(82327, 61561, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82327, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82327, A_CUSTOM, 46)
	
	-- Sigil of Commander Springvale - 81683
	AddPet(81683, 57626, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81683, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81683, A_CUSTOM, 46)
	
	-- Sigil of Commander Stoutbeard - 82601
	AddPet(82601, 64024, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82601, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82601, A_CUSTOM, 46)
	
	-- Sigil of Cookie - 81550
	AddPet(81550, 56942, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81550, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81550, A_CUSTOM, 46)
	
	-- Sigil of Cranky Benj - 82067
	AddPet(82067, 60024, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82067, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82067, A_CUSTOM, 46)
	
	-- Sigil of Crazed Indule Survivor - 82835
	AddPet(82835, 64257, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82835, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82835, A_CUSTOM, 46)
	
	-- Sigil of Creepthess - 82094
	AddPet(82094, 60051, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82094, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82094, A_CUSTOM, 46)
	
	-- Sigil of Crippler - 82373
	AddPet(82373, 62292, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82373, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82373, A_CUSTOM, 46)
	
	-- Sigil of Crowd Pummeler 9-60 - 81780
	AddPet(81780, 58359, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81780, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81780, A_CUSTOM, 46)
	
	-- Sigil of Crusty - 82343
	AddPet(82343, 61593, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82343, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82343, A_CUSTOM, 46)
	
	-- Sigil of Crypt Summoner - 83504
	AddPet(83504, 69381, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83504, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83504, A_CUSTOM, 46)
	
	-- Sigil of Crystal Fang - 81939
	AddPet(81939, 59895, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81939, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81939, A_CUSTOM, 46)
	
	-- Sigil of Cucurbitus - 83678
	AddPet(83678, 69657, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83678, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83678, A_CUSTOM, 46)
	
	-- Sigil of Cursed Centaur - 82019
	AddPet(82019, 59976, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82019, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82019, A_CUSTOM, 46)
	
	-- Sigil of Cyanigosa - 82776
	AddPet(82776, 64199, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82776, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82776, A_CUSTOM, 46)
	
	-- Sigil of Cyclok the Mad - 81830
	AddPet(81830, 59128, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81830, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81830, A_CUSTOM, 46)
	
	-- Sigil of Dalaran Spellscribe - 81599
	AddPet(81599, 56992, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81599, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81599, A_CUSTOM, 46)
	
	-- Sigil of Dalliah the Doomsayer - 82448
	AddPet(82448, 63290, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82448, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82448, A_CUSTOM, 46)
	
	-- Sigil of Dalronn the Controller - 82537
	AddPet(82537, 63960, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82537, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82537, A_CUSTOM, 46)
	
	-- Sigil of DarKhos - 83897
	AddPet(83897, 71207, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83897, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83897, A_CUSTOM, 46)
	
	-- Sigil of Darbel Montrose - 81619
	AddPet(81619, 57049, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81619, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81619, A_CUSTOM, 46)
	
	-- Sigil of Dark Iron Ambassador - 81779
	AddPet(81779, 58230, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81779, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81779, A_CUSTOM, 46)
	
	-- Sigil of Darkmaster Gandling - 81595
	AddPet(81595, 56988, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81595, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81595, A_CUSTOM, 46)
	
	-- Sigil of Darkmist Widow - 81685
	AddPet(81685, 57628, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81685, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81685, A_CUSTOM, 46)
	
	-- Sigil of Darkslayer Mordenthal - 81663
	AddPet(81663, 57606, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81663, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81663, A_CUSTOM, 46)
	
	-- Sigil of Darkweaver Syth - 82356
	AddPet(82356, 61619, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82356, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82356, A_CUSTOM, 46)
	
	-- Sigil of Dart - 82076
	AddPet(82076, 60033, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82076, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82076, A_CUSTOM, 46)
	
	-- Sigil of Death Flayer - 81742
	AddPet(81742, 57880, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81742, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81742, A_CUSTOM, 46)
	
	-- Sigil of Death Howl - 82104
	AddPet(82104, 60061, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82104, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82104, A_CUSTOM, 46)
	
	-- Sigil of Death Knight Soulbearer - 81978
	AddPet(81978, 59935, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81978, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81978, A_CUSTOM, 46)
	
	-- Sigil of Death Speaker Jargba - 81691
	AddPet(81691, 57634, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81691, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81691, A_CUSTOM, 46)
	
	-- Sigil of Deatheye - 81860
	AddPet(81860, 59816, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81860, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81860, A_CUSTOM, 46)
	
	-- Sigil of Deathmaw - 81908
	AddPet(81908, 59864, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81908, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81908, A_CUSTOM, 46)
	
	-- Sigil of Deathspeaker Selendre - 81987
	AddPet(81987, 59944, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81987, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81987, A_CUSTOM, 46)
	
	-- Sigil of Deathsworn Captain - 81667
	AddPet(81667, 57610, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81667, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81667, A_CUSTOM, 46)
	
	-- Sigil of Deeb - 81598
	AddPet(81598, 56991, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81598, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81598, A_CUSTOM, 46)
	
	-- Sigil of Dessecus - 81806
	AddPet(81806, 58854, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81806, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81806, A_CUSTOM, 46)
	
	-- Sigil of Deviate Faerie Dragon - 81766
	AddPet(81766, 58212, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81766, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81766, A_CUSTOM, 46)
	
	-- Sigil of Devourer of Souls - 83148
	AddPet(83148, 67908, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83148, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83148, A_CUSTOM, 46)
	
	-- Sigil of Dextren Ward - 81576
	AddPet(81576, 56969, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81576, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81576, A_CUSTOM, 46)
	
	-- Sigil of Diamond Head - 81705
	AddPet(81705, 57648, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81705, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81705, A_CUSTOM, 46)
	
	-- Sigil of Digger Flameforge - 81760
	AddPet(81760, 58081, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81760, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81760, A_CUSTOM, 46)
	
	-- Sigil of Digmaster Shovelphlange - 81804
	AddPet(81804, 58852, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81804, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81804, A_CUSTOM, 46)
	
	-- Sigil of Dirkee - 82852
	AddPet(82852, 64274, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82852, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82852, A_CUSTOM, 46)
	
	-- Sigil of Dishu - 81765
	AddPet(81765, 58211, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81765, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81765, A_CUSTOM, 46)
	
	-- Sigil of Doctor Theolen Krastinov - 81994
	AddPet(81994, 59951, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81994, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81994, A_CUSTOM, 46)
	
	-- Sigil of Doom Lord Kazzak - 82384
	AddPet(82384, 62304, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82384, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82384, A_CUSTOM, 46)
	
	-- Sigil of Doomsayer Jurim - 82372
	AddPet(82372, 62291, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82372, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82372, A_CUSTOM, 46)
	
	-- Sigil of Doomwalker - 82302
	AddPet(82302, 61195, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82302, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82302, A_CUSTOM, 46)
	
	-- Sigil of Dr. Whitherlimb - 82482
	AddPet(82482, 63397, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82482, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82482, A_CUSTOM, 46)
	
	-- Sigil of Dragonmaw Battlemaster - 81558
	AddPet(81558, 56950, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81558, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81558, A_CUSTOM, 46)
	
	-- Sigil of Drakkari Elemental - 82714
	AddPet(82714, 64137, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82714, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82714, A_CUSTOM, 46)
	
	-- Sigil of Drakos the Interrogator - 82617
	AddPet(82617, 64040, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82617, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82617, A_CUSTOM, 46)
	
	-- Sigil of Dreadscorn - 81862
	AddPet(81862, 59818, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81862, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81862, A_CUSTOM, 46)
	
	-- Sigil of Dreadwhisper - 81592
	AddPet(81592, 56985, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81592, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81592, A_CUSTOM, 46)
	
	-- Sigil of Dreamscythe - 81722
	AddPet(81722, 57665, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81722, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81722, A_CUSTOM, 46)
	
	-- Sigil of Dreamwatcher Forktongue - 81708
	AddPet(81708, 57651, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81708, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81708, A_CUSTOM, 46)
	
	-- Sigil of Drogoth the Roamer - 82075
	AddPet(82075, 60032, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82075, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82075, A_CUSTOM, 46)
	
	-- Sigil of Duggan Wildhammer - 81977
	AddPet(81977, 59934, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81977, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81977, A_CUSTOM, 46)
	
	-- Sigil of Duke Ragereaver - 81980
	AddPet(81980, 59937, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81980, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81980, A_CUSTOM, 46)
	
	-- Sigil of Duskstalker - 82119
	AddPet(82119, 60076, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82119, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82119, A_CUSTOM, 46)
	
	-- Sigil of Dustwraith - 81911
	AddPet(81911, 59867, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81911, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81911, A_CUSTOM, 46)
	
	-- Sigil of Earthcaller Halmgar - 81699
	AddPet(81699, 57642, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81699, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81699, A_CUSTOM, 46)
	
	-- Sigil of Ebonroc - 84241
	AddPet(84241, 72588, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84241, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84241, A_CUSTOM, 46)
	
	-- Sigil of Ebonroc - 82149
	AddPet(82149, 60105, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82149, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82149, A_CUSTOM, 46)
	
	-- Sigil of Eck the Ferocious - 82721
	AddPet(82721, 64144, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82721, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82721, A_CUSTOM, 46)
	
	-- Sigil of Eckalom - 81968
	AddPet(81968, 59925, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81968, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81968, A_CUSTOM, 46)
	
	-- Sigil of Edan the Howler - 81565
	AddPet(81565, 56957, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81565, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81565, A_CUSTOM, 46)
	
	-- Sigil of Edwin VanCleef - 81547
	AddPet(81547, 56939, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81547, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81547, A_CUSTOM, 46)
	
	-- Sigil of Elder Brightleaf - 82873
	AddPet(82873, 64295, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82873, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82873, A_CUSTOM, 46)
	
	-- Sigil of Elder Brightleaf (1) - 82901
	AddPet(82901, 64369, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82901, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82901, A_CUSTOM, 46)
	
	-- Sigil of Elder Mystic Razorsnout - 81643
	AddPet(81643, 57586, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81643, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81643, A_CUSTOM, 46)
	
	-- Sigil of Elder Nadox - 82700
	AddPet(82700, 64123, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82700, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82700, A_CUSTOM, 46)
	
	-- Sigil of Eldinarcus - 82267
	AddPet(82267, 60550, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82267, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82267, A_CUSTOM, 46)
	
	-- Sigil of Electrocutioner 6000 - 81781
	AddPet(81781, 58360, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81781, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81781, A_CUSTOM, 46)
	
	-- Sigil of Emalon the Storm Watcher - 82937
	AddPet(82937, 65390, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82937, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82937, A_CUSTOM, 46)
	
	-- Sigil of Emeriss - 82156
	AddPet(82156, 60112, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82156, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82156, A_CUSTOM, 46)
	
	-- Sigil of Emissary Romankhan - 82153
	AddPet(82153, 60109, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82153, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82153, A_CUSTOM, 46)
	
	-- Sigil of Emogg the Crusher - 82083
	AddPet(82083, 60040, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82083, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82083, A_CUSTOM, 46)
	
	-- Sigil of Emperor Dagran Thaurissan - 81878
	AddPet(81878, 59834, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81878, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81878, A_CUSTOM, 46)
	
	-- Sigil of Emperor Veklor - 84250
	AddPet(84250, 72599, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84250, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84250, A_CUSTOM, 46)
	
	-- Sigil of Emperor Veklor - 82172
	AddPet(82172, 60128, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82172, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82172, A_CUSTOM, 46)
	
	-- Sigil of Emperor Veknilash - 84249
	AddPet(84249, 72598, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84249, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84249, A_CUSTOM, 46)
	
	-- Sigil of Emperor Veknilash - 82171
	AddPet(82171, 60127, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82171, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82171, A_CUSTOM, 46)
	
	-- Sigil of Enforcer Emilgund - 81727
	AddPet(81727, 57670, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81727, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81727, A_CUSTOM, 46)
	
	-- Sigil of Engineer Whirleygig - 81753
	AddPet(81753, 57993, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81753, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81753, A_CUSTOM, 46)
	
	-- Sigil of Entropius - 82581
	AddPet(82581, 64004, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82581, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82581, A_CUSTOM, 46)
	
	-- Sigil of Erekem - 82703
	AddPet(82703, 64126, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82703, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82703, A_CUSTOM, 46)
	
	-- Sigil of Essence of Anger - 82517
	AddPet(82517, 63940, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82517, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82517, A_CUSTOM, 46)
	
	-- Sigil of Ever-Core the Punisher - 82381
	AddPet(82381, 62301, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82381, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82381, A_CUSTOM, 46)
	
	-- Sigil of Exarch Maladaar - 82350
	AddPet(82350, 61607, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82350, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82350, A_CUSTOM, 46)
	
	-- Sigil of Eydis Darkbane - 82986
	AddPet(82986, 67263, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82986, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82986, A_CUSTOM, 46)
	
	-- Sigil of Eye of CThun - 84268
	AddPet(84268, 72717, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84268, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84268, A_CUSTOM, 46)
	
	-- Sigil of Fallen Champion - 81784
	AddPet(81784, 58493, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81784, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81784, A_CUSTOM, 46)
	
	-- Sigil of Falric - 83222
	AddPet(83222, 68391, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83222, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83222, A_CUSTOM, 46)
	
	-- Sigil of Fankriss the Unyielding - 84262
	AddPet(84262, 72711, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84262, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84262, A_CUSTOM, 46)
	
	-- Sigil of Fankriss the Unyielding - 82201
	AddPet(82201, 60154, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82201, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82201, A_CUSTOM, 46)
	
	-- Sigil of Farmer Solliden - 81600
	AddPet(81600, 56993, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81600, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81600, A_CUSTOM, 46)
	
	-- Sigil of Fathom-Lord Karathress - 82457
	AddPet(82457, 63325, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82457, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82457, A_CUSTOM, 46)
	
	-- Sigil of Faulty War Golem - 81849
	AddPet(81849, 59445, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81849, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81849, A_CUSTOM, 46)
	
	-- Sigil of Fazethan - 84166
	AddPet(84166, 72292, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84166, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84166, A_CUSTOM, 46)
	
	-- Sigil of Fedfennel - 81531
	AddPet(81531, 103731, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81531, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81531, A_CUSTOM, 46)
	
	-- Sigil of Felendor the Accuser - 82106
	AddPet(82106, 60063, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82106, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82106, A_CUSTOM, 46)
	
	-- Sigil of Fellicents Shade - 81936
	AddPet(81936, 59892, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81936, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81936, A_CUSTOM, 46)
	
	-- Sigil of Felmyst - 82557
	AddPet(82557, 63980, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82557, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82557, A_CUSTOM, 46)
	
	-- Sigil of Felweaver Scornn - 81741
	AddPet(81741, 57876, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81741, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81741, A_CUSTOM, 46)
	
	-- Sigil of Fenissa the Assassin - 82481
	AddPet(82481, 63394, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82481, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82481, A_CUSTOM, 46)
	
	-- Sigil of Fenros - 81534
	AddPet(81534, 56926, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81534, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81534, A_CUSTOM, 46)
	
	-- Sigil of Fenrus the Devourer - 81681
	AddPet(81681, 57624, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81681, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81681, A_CUSTOM, 46)
	
	-- Sigil of Festergut - 83154
	AddPet(83154, 67914, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83154, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83154, A_CUSTOM, 46)
	
	-- Sigil of Fineous Darkvire - 81885
	AddPet(81885, 59841, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81885, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81885, A_CUSTOM, 46)
	
	-- Sigil of Fingat - 82125
	AddPet(82125, 60082, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82125, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82125, A_CUSTOM, 46)
	
	-- Sigil of Firecaller Radison - 81610
	AddPet(81610, 57040, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81610, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81610, A_CUSTOM, 46)
	
	-- Sigil of Firemaw - 84223
	AddPet(84223, 72561, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84223, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84223, A_CUSTOM, 46)
	
	-- Sigil of Firemaw - 82027
	AddPet(82027, 59984, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82027, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82027, A_CUSTOM, 46)
	
	-- Sigil of Fjola Lightbane - 82987
	AddPet(82987, 67264, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82987, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82987, A_CUSTOM, 46)
	
	-- Sigil of Flagglemurk the Cruel - 81801
	AddPet(81801, 58849, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81801, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81801, A_CUSTOM, 46)
	
	-- Sigil of Flame Leviathan - 82879
	AddPet(82879, 64322, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82879, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82879, A_CUSTOM, 46)
	
	-- Sigil of Flamegor - 84221
	AddPet(84221, 72559, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84221, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84221, A_CUSTOM, 46)
	
	-- Sigil of Flamegor - 82025
	AddPet(82025, 59982, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82025, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82025, A_CUSTOM, 46)
	
	-- Sigil of Foe Reaper 4000 - 81540
	AddPet(81540, 56932, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81540, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81540, A_CUSTOM, 46)
	
	-- Sigil of Foreman Grills - 81752
	AddPet(81752, 57992, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81752, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81752, A_CUSTOM, 46)
	
	-- Sigil of Foreman Jerris - 81588
	AddPet(81588, 56981, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81588, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81588, A_CUSTOM, 46)
	
	-- Sigil of Foreman Marcrid - 81589
	AddPet(81589, 56982, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81589, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81589, A_CUSTOM, 46)
	
	-- Sigil of Forgemaster Garfrost - 83146
	AddPet(83146, 67906, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83146, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83146, A_CUSTOM, 46)
	
	-- Sigil of Foulbelly - 81621
	AddPet(81621, 57051, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81621, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81621, A_CUSTOM, 46)
	
	-- Sigil of Foulmane - 81590
	AddPet(81590, 56983, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81590, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81590, A_CUSTOM, 46)
	
	-- Sigil of Fulgorge - 82364
	AddPet(82364, 61932, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82364, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82364, A_CUSTOM, 46)
	
	-- Sigil of Fumblub Gearwind - 82824
	AddPet(82824, 64246, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82824, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82824, A_CUSTOM, 46)
	
	-- Sigil of Fury Shelda - 82120
	AddPet(82120, 60077, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82120, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82120, A_CUSTOM, 46)
	
	-- Sigil of Gahzlanka - 83325
	AddPet(83325, 68831, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83325, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83325, A_CUSTOM, 46)
	
	-- Sigil of Gahzranka - 84247
	AddPet(84247, 72595, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84247, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84247, A_CUSTOM, 46)
	
	-- Sigil of Gahzranka - 82164
	AddPet(82164, 60120, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82164, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82164, A_CUSTOM, 46)
	
	-- Sigil of Gahzrilla - 81813
	AddPet(81813, 58863, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81813, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81813, A_CUSTOM, 46)
	
	-- Sigil of Galdarah - 82698
	AddPet(82698, 64121, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82698, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82698, A_CUSTOM, 46)
	
	-- Sigil of Galgann Firehammer - 81815
	AddPet(81815, 58869, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81815, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81815, A_CUSTOM, 46)
	
	-- Sigil of Garneg Charskull - 81604
	AddPet(81604, 56997, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81604, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81604, A_CUSTOM, 46)
	
	-- Sigil of Garr - 84299
	AddPet(84299, 72748, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84299, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84299, A_CUSTOM, 46)
	
	-- Sigil of Garr - 84228
	AddPet(84228, 72566, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84228, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84228, A_CUSTOM, 46)
	
	-- Sigil of Garr - 84110
	AddPet(84110, 72139, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84110, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84110, A_CUSTOM, 46)
	
	-- Sigil of Garr - 82033
	AddPet(82033, 59990, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82033, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82033, A_CUSTOM, 46)
	
	-- Sigil of Gatekeeper Rageroar - 81797
	AddPet(81797, 58814, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81797, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81797, A_CUSTOM, 46)
	
	-- Sigil of Gatewatcher Gyro-Kill - 82400
	AddPet(82400, 62403, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82400, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82400, A_CUSTOM, 46)
	
	-- Sigil of Gatewatcher Iron-Hand - 82411
	AddPet(82411, 62500, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82411, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82411, A_CUSTOM, 46)
	
	-- Sigil of Gathios the Shatterer - 82503
	AddPet(82503, 63529, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82503, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82503, A_CUSTOM, 46)
	
	-- Sigil of Gehennas - 84298
	AddPet(84298, 72747, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84298, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84298, A_CUSTOM, 46)
	
	-- Sigil of Gehennas - 84231
	AddPet(84231, 72569, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84231, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84231, A_CUSTOM, 46)
	
	-- Sigil of Gehennas - 84109
	AddPet(84109, 72138, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84109, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84109, A_CUSTOM, 46)
	
	-- Sigil of Gehennas - 82044
	AddPet(82044, 60001, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82044, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82044, A_CUSTOM, 46)
	
	-- Sigil of Gelihast - 84331
	AddPet(84331, 72780, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84331, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84331, A_CUSTOM, 46)
	
	-- Sigil of Gelihast - 81782
	AddPet(81782, 58401, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81782, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81782, A_CUSTOM, 46)
	
	-- Sigil of General Angerforge - 81881
	AddPet(81881, 59837, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81881, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81881, A_CUSTOM, 46)
	
	-- Sigil of General Bjarngrim - 82668
	AddPet(82668, 64091, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82668, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82668, A_CUSTOM, 46)
	
	-- Sigil of General Colbatann - 81918
	AddPet(81918, 59874, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81918, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81918, A_CUSTOM, 46)
	
	-- Sigil of General Drakkisath - 81938
	AddPet(81938, 59894, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81938, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81938, A_CUSTOM, 46)
	
	-- Sigil of General Fangferror - 81796
	AddPet(81796, 58808, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81796, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81796, A_CUSTOM, 46)
	
	-- Sigil of General Rajaxx - 84254
	AddPet(84254, 72619, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84254, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84254, A_CUSTOM, 46)
	
	-- Sigil of General Rajaxx - 84195
	AddPet(84195, 72532, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84195, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84195, A_CUSTOM, 46)
	
	-- Sigil of General Rajaxx - 82178
	AddPet(82178, 60134, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82178, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82178, A_CUSTOM, 46)
	
	-- Sigil of General Vezax - 82894
	AddPet(82894, 64336, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82894, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82894, A_CUSTOM, 46)
	
	-- Sigil of General Zarithrian - 83302
	AddPet(83302, 68708, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83302, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83302, A_CUSTOM, 46)
	
	-- Sigil of Geolord Mottle - 81744
	AddPet(81744, 57882, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81744, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81744, A_CUSTOM, 46)
	
	-- Sigil of Geomancer Flintdagger - 81627
	AddPet(81627, 57057, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81627, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81627, A_CUSTOM, 46)
	
	-- Sigil of Geopriest Gukkrok - 81763
	AddPet(81763, 58207, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81763, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81763, A_CUSTOM, 46)
	
	-- Sigil of Gesharahan - 81645
	AddPet(81645, 57588, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81645, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81645, A_CUSTOM, 46)
	
	-- Sigil of Ghamoo-ra - 84330
	AddPet(84330, 72779, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84330, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84330, A_CUSTOM, 46)
	
	-- Sigil of Ghamoo-ra - 81701
	AddPet(81701, 57644, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81701, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81701, A_CUSTOM, 46)
	
	-- Sigil of Ghazan - 82339
	AddPet(82339, 61585, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82339, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82339, A_CUSTOM, 46)
	
	-- Sigil of Ghok Bashguud - 81904
	AddPet(81904, 59860, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81904, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81904, A_CUSTOM, 46)
	
	-- Sigil of Ghost Howl - 81639
	AddPet(81639, 57250, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81639, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81639, A_CUSTOM, 46)
	
	-- Sigil of Gibblesnik - 82116
	AddPet(82116, 60073, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82116, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82116, A_CUSTOM, 46)
	
	-- Sigil of Gibblewilt - 81864
	AddPet(81864, 59820, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81864, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81864, A_CUSTOM, 46)
	
	-- Sigil of Giggler - 82072
	AddPet(82072, 60029, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82072, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82072, A_CUSTOM, 46)
	
	-- Sigil of Gilmorian - 82126
	AddPet(82126, 60083, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82126, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82126, A_CUSTOM, 46)
	
	-- Sigil of Gilnid - 81583
	AddPet(81583, 56976, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81583, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81583, A_CUSTOM, 46)
	
	-- Sigil of Gish the Unmoving - 81985
	AddPet(81985, 59942, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81985, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81985, A_CUSTOM, 46)
	
	-- Sigil of Gizrul the Slavener - 81933
	AddPet(81933, 59889, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81933, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81933, A_CUSTOM, 46)
	
	-- Sigil of Gluggle - 82138
	AddPet(82138, 60094, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82138, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82138, A_CUSTOM, 46)
	
	-- Sigil of Gluth - 84342
	AddPet(84342, 72791, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84342, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84342, A_CUSTOM, 46)
	
	-- Sigil of Gluth - 82224
	AddPet(82224, 60177, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82224, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82224, A_CUSTOM, 46)
	
	-- Sigil of Glutton - 81865
	AddPet(81865, 59821, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81865, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81865, A_CUSTOM, 46)
	
	-- Sigil of Gnarl Leafbrother - 81712
	AddPet(81712, 57655, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81712, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81712, A_CUSTOM, 46)
	
	-- Sigil of Gnawbone - 82114
	AddPet(82114, 60071, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82114, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82114, A_CUSTOM, 46)
	
	-- Sigil of Golem Lord Argelmach - 81874
	AddPet(81874, 59830, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81874, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81874, A_CUSTOM, 46)
	
	-- Sigil of Golemagg the Incinerator - 84302
	AddPet(84302, 72751, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84302, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84302, A_CUSTOM, 46)
	
	-- Sigil of Golemagg the Incinerator - 84224
	AddPet(84224, 72562, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84224, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84224, A_CUSTOM, 46)
	
	-- Sigil of Golemagg the Incinerator - 84113
	AddPet(84113, 72143, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84113, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84113, A_CUSTOM, 46)
	
	-- Sigil of Golemagg the Incinerator - 82028
	AddPet(82028, 59985, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82028, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82028, A_CUSTOM, 46)
	
	-- Sigil of Gondria - 82927
	AddPet(82927, 65157, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82927, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82927, A_CUSTOM, 46)
	
	-- Sigil of Goraluk Anvilcrack - 81989
	AddPet(81989, 59946, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81989, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81989, A_CUSTOM, 46)
	
	-- Sigil of Gorefang - 82047
	AddPet(82047, 60004, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82047, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82047, A_CUSTOM, 46)
	
	-- Sigil of Goretooth - 82277
	AddPet(82277, 60818, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82277, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82277, A_CUSTOM, 46)
	
	-- Sigil of Gorgonoch - 81903
	AddPet(81903, 59859, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81903, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81903, A_CUSTOM, 46)
	
	-- Sigil of Gortok Palehoof - 82594
	AddPet(82594, 64017, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82594, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82594, A_CUSTOM, 46)
	
	-- Sigil of Gothik the Harvester - 82236
	AddPet(82236, 60189, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82236, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82236, A_CUSTOM, 46)
	
	-- Sigil of Grand Magus Telestra - 82597
	AddPet(82597, 64020, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82597, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82597, A_CUSTOM, 46)
	
	-- Sigil of Grand Warlock Alythess - 82562
	AddPet(82562, 63985, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82562, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82562, A_CUSTOM, 46)
	
	-- Sigil of Grand Warlock Nethekurse - 82263
	AddPet(82263, 60546, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82263, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82263, A_CUSTOM, 46)
	
	-- Sigil of Grand Widow Faerlina - 82227
	AddPet(82227, 60180, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82227, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82227, A_CUSTOM, 46)
	
	-- Sigil of Grandmaster Vorpil - 82386
	AddPet(82386, 62307, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82386, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82386, A_CUSTOM, 46)
	
	-- Sigil of Gravis Slipknot - 82065
	AddPet(82065, 60022, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82065, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82065, A_CUSTOM, 46)
	
	-- Sigil of Great Father Arctikus - 81567
	AddPet(81567, 56959, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81567, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81567, A_CUSTOM, 46)
	
	-- Sigil of Greater Firebird - 81835
	AddPet(81835, 59133, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81835, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81835, A_CUSTOM, 46)
	
	-- Sigil of Gretheer - 82129
	AddPet(82129, 60086, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82129, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82129, A_CUSTOM, 46)
	
	-- Sigil of Grilek - 84308
	AddPet(84308, 72757, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84308, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84308, A_CUSTOM, 46)
	
	-- Sigil of Grilek - 84243
	AddPet(84243, 72591, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84243, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84243, A_CUSTOM, 46)
	
	-- Sigil of Grilek - 84126
	AddPet(84126, 72168, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84126, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84126, A_CUSTOM, 46)
	
	-- Sigil of Grilek - 82160
	AddPet(82160, 60116, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82160, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82160, A_CUSTOM, 46)
	
	-- Sigil of Griegen - 82844
	AddPet(82844, 64266, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82844, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82844, A_CUSTOM, 46)
	
	-- Sigil of Grimlok - 81700
	AddPet(81700, 57643, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81700, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81700, A_CUSTOM, 46)
	
	-- Sigil of Grimmaw - 82118
	AddPet(82118, 60075, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82118, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82118, A_CUSTOM, 46)
	
	-- Sigil of Grimungous - 81842
	AddPet(81842, 59154, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81842, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81842, A_CUSTOM, 46)
	
	-- Sigil of Grizlak - 81572
	AddPet(81572, 56964, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81572, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81572, A_CUSTOM, 46)
	
	-- Sigil of Grizzle Snowpaw - 81921
	AddPet(81921, 59877, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81921, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81921, A_CUSTOM, 46)
	
	-- Sigil of Grobbulus - 82223
	AddPet(82223, 60176, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82223, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82223, A_CUSTOM, 46)
	
	-- Sigil of Grocklar - 82837
	AddPet(82837, 64259, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82837, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82837, A_CUSTOM, 46)
	
	-- Sigil of Grubbis - 81819
	AddPet(81819, 58875, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81819, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81819, A_CUSTOM, 46)
	
	-- Sigil of Grubthor - 82134
	AddPet(82134, 60091, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82134, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82134, A_CUSTOM, 46)
	
	-- Sigil of Gruff - 81789
	AddPet(81789, 58498, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81789, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81789, A_CUSTOM, 46)
	
	-- Sigil of Gruff Swiftbite - 81528
	AddPet(81528, 103728, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81528, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81528, A_CUSTOM, 46)
	
	-- Sigil of Gruklash - 81872
	AddPet(81872, 59828, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81872, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81872, A_CUSTOM, 46)
	
	-- Sigil of Grunter - 81861
	AddPet(81861, 59817, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81861, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81861, A_CUSTOM, 46)
	
	-- Sigil of Grutak - 83322
	AddPet(83322, 68828, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83322, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83322, A_CUSTOM, 46)
	
	-- Sigil of Gruul the Dragonkiller - 82399
	AddPet(82399, 62402, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82399, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82399, A_CUSTOM, 46)
	
	-- Sigil of Guard Fengus - 82097
	AddPet(82097, 60054, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82097, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82097, A_CUSTOM, 46)
	
	-- Sigil of Guard Moldar - 82102
	AddPet(82102, 60059, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82102, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82102, A_CUSTOM, 46)
	
	-- Sigil of Guard Slipkik - 82099
	AddPet(82099, 60056, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82099, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82099, A_CUSTOM, 46)
	
	-- Sigil of Gurtogg Bloodboil - 82502
	AddPet(82502, 63521, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82502, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82502, A_CUSTOM, 46)
	
	-- Sigil of Haarka the Ravenous - 81833
	AddPet(81833, 59131, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81833, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81833, A_CUSTOM, 46)
	
	-- Sigil of Hadronox - 82677
	AddPet(82677, 64100, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82677, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82677, A_CUSTOM, 46)
	
	-- Sigil of Hagg Taurenbane - 81762
	AddPet(81762, 58206, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81762, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81762, A_CUSTOM, 46)
	
	-- Sigil of HahkZor - 81902
	AddPet(81902, 59858, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81902, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81902, A_CUSTOM, 46)
	
	-- Sigil of Hakkar - 84242
	AddPet(84242, 72590, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84242, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84242, A_CUSTOM, 46)
	
	-- Sigil of Hakkar - 82152
	AddPet(82152, 60108, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82152, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82152, A_CUSTOM, 46)
	
	-- Sigil of Halazzi - 82522
	AddPet(82522, 63945, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82522, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82522, A_CUSTOM, 46)
	
	-- Sigil of Halion - 83305
	AddPet(83305, 68726, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83305, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83305, A_CUSTOM, 46)
	
	-- Sigil of Halos - 81042
	AddPet(81042, 103722, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81042, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81042, A_CUSTOM, 46)
	
	-- Sigil of Halycon - 81926
	AddPet(81926, 59882, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81926, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81926, A_CUSTOM, 46)
	
	-- Sigil of Hamhock - 81580
	AddPet(81580, 56973, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81580, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81580, A_CUSTOM, 46)
	
	-- Sigil of Hammerspine - 81562
	AddPet(81562, 56954, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81562, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81562, A_CUSTOM, 46)
	
	-- Sigil of Hannah Bladeleaf - 81736
	AddPet(81736, 57679, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81736, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81736, A_CUSTOM, 46)
	
	-- Sigil of Harb Foulmountain - 82115
	AddPet(82115, 60072, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82115, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82115, A_CUSTOM, 46)
	
	-- Sigil of Harbinger Skyriss - 82450
	AddPet(82450, 63295, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82450, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82450, A_CUSTOM, 46)
	
	-- Sigil of Hayoc - 82078
	AddPet(82078, 60035, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82078, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82078, A_CUSTOM, 46)
	
	-- Sigil of Hazzarah - 84244
	AddPet(84244, 72592, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84244, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84244, A_CUSTOM, 46)
	
	-- Sigil of Hazzarah - 82161
	AddPet(82161, 60117, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82161, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82161, A_CUSTOM, 46)
	
	-- Sigil of Hazzas - 81723
	AddPet(81723, 57666, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81723, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81723, A_CUSTOM, 46)
	
	-- Sigil of Hearthsinger Forresten - 81961
	AddPet(81961, 59918, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81961, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81961, A_CUSTOM, 46)
	
	-- Sigil of Heartrazor - 81773
	AddPet(81773, 58221, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81773, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81773, A_CUSTOM, 46)
	
	-- Sigil of Hedmush the Rotting - 81981
	AddPet(81981, 59938, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81981, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81981, A_CUSTOM, 46)
	
	-- Sigil of Heggin Stonewhisker - 81758
	AddPet(81758, 57998, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81758, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81758, A_CUSTOM, 46)
	
	-- Sigil of Heigan the Unclean - 82225
	AddPet(82225, 60178, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82225, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82225, A_CUSTOM, 46)
	
	-- Sigil of Hellfire Channeler - 82281
	AddPet(82281, 60944, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82281, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82281, A_CUSTOM, 46)
	
	-- Sigil of Hemathion - 82375
	AddPet(82375, 62294, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82375, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82375, A_CUSTOM, 46)
	
	-- Sigil of Hematos - 81870
	AddPet(81870, 59826, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81870, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81870, A_CUSTOM, 46)
	
	-- Sigil of Herald Volazj - 82702
	AddPet(82702, 64125, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82702, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82702, A_CUSTOM, 46)
	
	-- Sigil of Herod - 81674
	AddPet(81674, 57617, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81674, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81674, A_CUSTOM, 46)
	
	-- Sigil of Hex Lord Malacrass - 82539
	AddPet(82539, 63962, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82539, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82539, A_CUSTOM, 46)
	
	-- Sigil of High Astromancer Solarian - 82388
	AddPet(82388, 62309, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82388, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82388, A_CUSTOM, 46)
	
	-- Sigil of High Botanist Freywinn - 82326
	AddPet(82326, 61559, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82326, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82326, A_CUSTOM, 46)
	
	-- Sigil of High Commander Halford Wyrmbane - 84162
	AddPet(84162, 72252, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84162, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84162, A_CUSTOM, 46)
	
	-- Sigil of High General Abbendis - 81988
	AddPet(81988, 59945, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81988, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81988, A_CUSTOM, 46)
	
	-- Sigil of High Inquisitor Fairbanks - 81693
	AddPet(81693, 57636, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81693, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81693, A_CUSTOM, 46)
	
	-- Sigil of High Inquisitor Qormaladon - 83902
	AddPet(83902, 71223, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83902, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83902, A_CUSTOM, 46)
	
	-- Sigil of High Inquisitor Qormaladon - 83318
	AddPet(83318, 68817, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83318, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83318, A_CUSTOM, 46)
	
	-- Sigil of High Inquisitor Whitemane - 81675
	AddPet(81675, 57618, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81675, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81675, A_CUSTOM, 46)
	
	-- Sigil of High Interrogator Gerstahn - 81877
	AddPet(81877, 59833, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81877, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81877, A_CUSTOM, 46)
	
	-- Sigil of High King Maulgar - 82390
	AddPet(82390, 62311, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82390, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82390, A_CUSTOM, 46)
	
	-- Sigil of High Marshal Whirlaxis - 82167
	AddPet(82167, 60123, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82167, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82167, A_CUSTOM, 46)
	
	-- Sigil of High Nethermancer Zerevor - 82504
	AddPet(82504, 63690, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82504, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82504, A_CUSTOM, 46)
	
	-- Sigil of High Overlord Saurfang - 84100
	AddPet(84100, 72123, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84100, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84100, A_CUSTOM, 46)
	
	-- Sigil of High Priest Thekal - 84237
	AddPet(84237, 72577, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84237, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84237, A_CUSTOM, 46)
	
	-- Sigil of High Priest Thekal - 84122
	AddPet(84122, 72155, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84122, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84122, A_CUSTOM, 46)
	
	-- Sigil of High Priest Thekal - 82145
	AddPet(82145, 60101, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82145, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82145, A_CUSTOM, 46)
	
	-- Sigil of High Priest Venoxis - 84306
	AddPet(84306, 72755, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84306, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84306, A_CUSTOM, 46)
	
	-- Sigil of High Priest Venoxis - 84236
	AddPet(84236, 72576, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84236, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84236, A_CUSTOM, 46)
	
	-- Sigil of High Priest Venoxis - 84124
	AddPet(84124, 72166, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84124, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84124, A_CUSTOM, 46)
	
	-- Sigil of High Priest Venoxis - 84120
	AddPet(84120, 72152, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84120, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84120, A_CUSTOM, 46)
	
	-- Sigil of High Priest Venoxis - 82144
	AddPet(82144, 60100, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82144, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82144, A_CUSTOM, 46)
	
	-- Sigil of High Priestess Arlokk - 84239
	AddPet(84239, 72580, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84239, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84239, A_CUSTOM, 46)
	
	-- Sigil of High Priestess Arlokk - 84123
	AddPet(84123, 72157, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84123, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84123, A_CUSTOM, 46)
	
	-- Sigil of High Priestess Arlokk - 82147
	AddPet(82147, 60103, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82147, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82147, A_CUSTOM, 46)
	
	-- Sigil of High Priestess Haiwatna - 81997
	AddPet(81997, 59954, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81997, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81997, A_CUSTOM, 46)
	
	-- Sigil of High Priestess Jeklik - 84307
	AddPet(84307, 72756, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84307, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84307, A_CUSTOM, 46)
	
	-- Sigil of High Priestess Jeklik - 84240
	AddPet(84240, 72581, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84240, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84240, A_CUSTOM, 46)
	
	-- Sigil of High Priestess Jeklik - 84125
	AddPet(84125, 72167, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84125, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84125, A_CUSTOM, 46)
	
	-- Sigil of High Priestess Jeklik - 84119
	AddPet(84119, 72151, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84119, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84119, A_CUSTOM, 46)
	
	-- Sigil of High Priestess Jeklik - 83497
	AddPet(83497, 69374, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83497, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83497, A_CUSTOM, 46)
	
	-- Sigil of High Priestess Jeklik - 82148
	AddPet(82148, 60104, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82148, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82148, A_CUSTOM, 46)
	
	-- Sigil of High Priestess Marli - 84238
	AddPet(84238, 72579, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84238, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84238, A_CUSTOM, 46)
	
	-- Sigil of High Priestess Marli - 84121
	AddPet(84121, 72154, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84121, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84121, A_CUSTOM, 46)
	
	-- Sigil of High Priestess Marli - 82146
	AddPet(82146, 60102, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82146, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82146, A_CUSTOM, 46)
	
	-- Sigil of High Thane Jorfus - 82853
	AddPet(82853, 64275, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82853, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82853, A_CUSTOM, 46)
	
	-- Sigil of High Tinker Mekkatorque - 84349
	AddPet(84349, 72953, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84349, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84349, A_CUSTOM, 46)
	
	-- Sigil of High Tinker Mekkatorque - 84131
	AddPet(84131, 72173, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84131, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84131, A_CUSTOM, 46)
	
	-- Sigil of High Tinker Mekkatorque - 81824
	AddPet(81824, 59055, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81824, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81824, A_CUSTOM, 46)
	
	-- Sigil of High Warlord Najentus - 84338
	AddPet(84338, 72787, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84338, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84338, A_CUSTOM, 46)
	
	-- Sigil of High Warlord Najentus - 82497
	AddPet(82497, 63451, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82497, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82497, A_CUSTOM, 46)
	
	-- Sigil of Highlord Bolvar Fordragon - 84345
	AddPet(84345, 72797, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84345, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84345, A_CUSTOM, 46)
	
	-- Sigil of Highlord Bolvar Fordragon - 81582
	AddPet(81582, 56975, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81582, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81582, A_CUSTOM, 46)
	
	-- Sigil of Highlord Mastrogonde - 81852
	AddPet(81852, 59488, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81852, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81852, A_CUSTOM, 46)
	
	-- Sigil of Highlord Omokk - 81888
	AddPet(81888, 59844, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81888, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81888, A_CUSTOM, 46)
	
	-- Sigil of Hildana Deathstealer - 82851
	AddPet(82851, 64273, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82851, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82851, A_CUSTOM, 46)
	
	-- Sigil of Hissperak - 82071
	AddPet(82071, 60028, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82071, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82071, A_CUSTOM, 46)
	
	-- Sigil of Horde Guard - 84098
	AddPet(84098, 72121, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84098, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84098, A_CUSTOM, 46)
	
	-- Sigil of Houndmaster Grebmar - 81894
	AddPet(81894, 59850, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81894, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81894, A_CUSTOM, 46)
	
	-- Sigil of Houndmaster Loksey - 81673
	AddPet(81673, 57616, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81673, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81673, A_CUSTOM, 46)
	
	-- Sigil of Humar the Pridelord - 81746
	AddPet(81746, 57887, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81746, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81746, A_CUSTOM, 46)
	
	-- Sigil of Hungarfen - 82304
	AddPet(82304, 61197, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82304, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82304, A_CUSTOM, 46)
	
	-- Sigil of Huricanian - 82135
	AddPet(82135, 60092, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82135, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82135, A_CUSTOM, 46)
	
	-- Sigil of Hurley Blackbreath - 81898
	AddPet(81898, 59854, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81898, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81898, A_CUSTOM, 46)
	
	-- Sigil of Hyakiss the Lurker - 82246
	AddPet(82246, 60199, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82246, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82246, A_CUSTOM, 46)
	
	-- Sigil of Hydromancer Thespia - 82307
	AddPet(82307, 61200, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82307, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82307, A_CUSTOM, 46)
	
	-- Sigil of Hydromancer Velratha - 81820
	AddPet(81820, 58876, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81820, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81820, A_CUSTOM, 46)
	
	-- Sigil of Hydrospawn - 82055
	AddPet(82055, 60012, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82055, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82055, A_CUSTOM, 46)
	
	-- Sigil of Hydross the Unstable - 82459
	AddPet(82459, 63338, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82459, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82459, A_CUSTOM, 46)
	
	-- Sigil of Hyjal Bear - 84169
	AddPet(84169, 72303, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84169, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84169, A_CUSTOM, 46)
	
	-- Sigil of Icehorn - 82825
	AddPet(82825, 64247, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82825, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82825, A_CUSTOM, 46)
	
	-- Sigil of Icehowl - 82996
	AddPet(82996, 67441, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82996, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82996, A_CUSTOM, 46)
	
	-- Sigil of Ick - 83145
	AddPet(83145, 67905, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83145, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83145, A_CUSTOM, 46)
	
	-- Sigil of Ignis the Furnace Master - 82880
	AddPet(82880, 64323, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82880, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82880, A_CUSTOM, 46)
	
	-- Sigil of Illidan Stormrage - 82499
	AddPet(82499, 63511, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82499, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82499, A_CUSTOM, 46)
	
	-- Sigil of Illyanna Ravenoak - 82002
	AddPet(82002, 59959, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82002, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82002, A_CUSTOM, 46)
	
	-- Sigil of Immolthar - 82006
	AddPet(82006, 59963, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82006, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82006, A_CUSTOM, 46)
	
	-- Sigil of Immolatus - 81807
	AddPet(81807, 58855, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81807, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81807, A_CUSTOM, 46)
	
	-- Sigil of Ingvar the Plunderer - 82535
	AddPet(82535, 63958, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82535, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82535, A_CUSTOM, 46)
	
	-- Sigil of Instructor Malicia - 81954
	AddPet(81954, 59911, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81954, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81954, A_CUSTOM, 46)
	
	-- Sigil of Instructor Razuvious - 82237
	AddPet(82237, 60190, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82237, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82237, A_CUSTOM, 46)
	
	-- Sigil of Interrogator Vishas - 81676
	AddPet(81676, 57619, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81676, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81676, A_CUSTOM, 46)
	
	-- Sigil of Ionar - 82666
	AddPet(82666, 64089, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82666, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82666, A_CUSTOM, 46)
	
	-- Sigil of Ironaya - 81809
	AddPet(81809, 58858, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81809, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81809, A_CUSTOM, 46)
	
	-- Sigil of Ironback - 81840
	AddPet(81840, 59138, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81840, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81840, A_CUSTOM, 46)
	
	-- Sigil of Ironeye the Invincible - 81774
	AddPet(81774, 58222, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81774, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81774, A_CUSTOM, 46)
	
	-- Sigil of Ironspine - 81785
	AddPet(81785, 58494, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81785, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81785, A_CUSTOM, 46)
	
	-- Sigil of Jack Macdonald - 84344
	AddPet(84344, 72796, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84344, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84344, A_CUSTOM, 46)
	
	-- Sigil of Jade - 81559
	AddPet(81559, 56951, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81559, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81559, A_CUSTOM, 46)
	
	-- Sigil of Jalinde Summerdrake - 81841
	AddPet(81841, 59139, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81841, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81841, A_CUSTOM, 46)
	
	-- Sigil of Jammalan the Prophet - 81719
	AddPet(81719, 57662, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81719, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81719, A_CUSTOM, 46)
	
	-- Sigil of Janalai - 82523
	AddPet(82523, 63946, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82523, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82523, A_CUSTOM, 46)
	
	-- Sigil of Jandice Barov - 81952
	AddPet(81952, 59909, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81952, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81952, A_CUSTOM, 46)
	
	-- Sigil of Jed Runewatcher - 81958
	AddPet(81958, 59915, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81958, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81958, A_CUSTOM, 46)
	
	-- Sigil of Jedoga Shadowseeker - 82701
	AddPet(82701, 64124, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82701, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82701, A_CUSTOM, 46)
	
	-- Sigil of Jergosh the Invoker - 82012
	AddPet(82012, 59969, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82012, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82012, A_CUSTOM, 46)
	
	-- Sigil of Jimmy the Bleeder - 82096
	AddPet(82096, 60053, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82096, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82096, A_CUSTOM, 46)
	
	-- Sigil of Jindo the Hexxer - 84217
	AddPet(84217, 72555, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84217, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84217, A_CUSTOM, 46)
	
	-- Sigil of Jindo the Hexxer - 81995
	AddPet(81995, 59952, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81995, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81995, A_CUSTOM, 46)
	
	-- Sigil of JinZallah the Sandbringer - 81828
	AddPet(81828, 59126, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81828, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81828, A_CUSTOM, 46)
	
	-- Sigil of Julianne - 82292
	AddPet(82292, 61022, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82292, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82292, A_CUSTOM, 46)
	
	-- Sigil of Kaelthas Sunstrider - 82547
	AddPet(82547, 63970, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82547, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82547, A_CUSTOM, 46)
	
	-- Sigil of Kaelthas Sunstrider - 82409
	AddPet(82409, 62498, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82409, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82409, A_CUSTOM, 46)
	
	-- Sigil of Kam Deepfury - 81577
	AddPet(81577, 56970, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81577, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81577, A_CUSTOM, 46)
	
	-- Sigil of Kashoch the Reaver - 81920
	AddPet(81920, 59876, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81920, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81920, A_CUSTOM, 46)
	
	-- Sigil of Kaskk - 82070
	AddPet(82070, 60027, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82070, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82070, A_CUSTOM, 46)
	
	-- Sigil of Kazrogal - 82320
	AddPet(82320, 61394, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82320, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82320, A_CUSTOM, 46)
	
	-- Sigil of Kazon - 81542
	AddPet(81542, 56934, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81542, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81542, A_CUSTOM, 46)
	
	-- Sigil of Keeper of Chaos - 83895
	AddPet(83895, 71187, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83895, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83895, A_CUSTOM, 46)
	
	-- Sigil of KelThuzad - 82232
	AddPet(82232, 60185, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82232, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82232, A_CUSTOM, 46)
	
	-- Sigil of Kelidan the Breaker - 82285
	AddPet(82285, 60948, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82285, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82285, A_CUSTOM, 46)
	
	-- Sigil of Keristrasza - 82596
	AddPet(82596, 64019, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82596, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82596, A_CUSTOM, 46)
	
	-- Sigil of Kiljaeden - 82565
	AddPet(82565, 63988, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82565, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82565, A_CUSTOM, 46)
	
	-- Sigil of King Dred - 82616
	AddPet(82616, 64039, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82616, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82616, A_CUSTOM, 46)
	
	-- Sigil of King Gordok - 82009
	AddPet(82009, 59966, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82009, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82009, A_CUSTOM, 46)
	
	-- Sigil of King Krush - 82848
	AddPet(82848, 64270, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82848, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82848, A_CUSTOM, 46)
	
	-- Sigil of King Magni Bronzebeard - 84348
	AddPet(84348, 72928, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84348, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84348, A_CUSTOM, 46)
	
	-- Sigil of King Magni Bronzebeard - 81636
	AddPet(81636, 57124, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81636, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81636, A_CUSTOM, 46)
	
	-- Sigil of King Mosh - 81790
	AddPet(81790, 58780, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81790, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81790, A_CUSTOM, 46)
	
	-- Sigil of King Ping - 82831
	AddPet(82831, 64253, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82831, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82831, A_CUSTOM, 46)
	
	-- Sigil of King Ymiron - 82602
	AddPet(82602, 64025, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82602, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82602, A_CUSTOM, 46)
	
	-- Sigil of Kirtonos the Herald - 81955
	AddPet(81955, 59912, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81955, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81955, A_CUSTOM, 46)
	
	-- Sigil of Koralon the Flame Watcher - 83007
	AddPet(83007, 67490, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83007, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83007, A_CUSTOM, 46)
	
	-- Sigil of Kovork - 81623
	AddPet(81623, 57053, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81623, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81623, A_CUSTOM, 46)
	
	-- Sigil of Kraator - 82379
	AddPet(82379, 62299, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82379, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82379, A_CUSTOM, 46)
	
	-- Sigil of Kregg Keelhaul - 81831
	AddPet(81831, 59129, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81831, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81831, A_CUSTOM, 46)
	
	-- Sigil of Krellack - 82133
	AddPet(82133, 60090, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82133, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82133, A_CUSTOM, 46)
	
	-- Sigil of Kresh - 81653
	AddPet(81653, 57596, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81653, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81653, A_CUSTOM, 46)
	
	-- Sigil of Krethis Shadowspinner - 82049
	AddPet(82049, 60006, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82049, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82049, A_CUSTOM, 46)
	
	-- Sigil of Krikthir the Gatewatcher - 82671
	AddPet(82671, 64094, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82671, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82671, A_CUSTOM, 46)
	
	-- Sigil of Krystallus - 82643
	AddPet(82643, 64066, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82643, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82643, A_CUSTOM, 46)
	
	-- Sigil of Kurinnaxx - 84255
	AddPet(84255, 72620, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84255, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84255, A_CUSTOM, 46)
	
	-- Sigil of Kurinnaxx - 82179
	AddPet(82179, 60135, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82179, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82179, A_CUSTOM, 46)
	
	-- Sigil of Kurmokk - 82141
	AddPet(82141, 60097, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82141, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82141, A_CUSTOM, 46)
	
	-- Sigil of Lachlan MacGraff - 84173
	AddPet(84173, 72500, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84173, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84173, A_CUSTOM, 46)
	
	-- Sigil of Lady Anacondra - 81657
	AddPet(81657, 57600, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81657, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81657, A_CUSTOM, 46)
	
	-- Sigil of Lady Deathwhisper - 83164
	AddPet(83164, 68011, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83164, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83164, A_CUSTOM, 46)
	
	-- Sigil of Lady Hederine - 81923
	AddPet(81923, 59879, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81923, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81923, A_CUSTOM, 46)
	
	-- Sigil of Lady Illucia Barov - 81951
	AddPet(81951, 59908, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81951, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81951, A_CUSTOM, 46)
	
	-- Sigil of Lady Malande - 82505
	AddPet(82505, 63928, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82505, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82505, A_CUSTOM, 46)
	
	-- Sigil of Lady Moongazer - 81607
	AddPet(81607, 57001, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81607, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81607, A_CUSTOM, 46)
	
	-- Sigil of Lady Sacrolash - 82561
	AddPet(82561, 63984, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82561, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82561, A_CUSTOM, 46)
	
	-- Sigil of Lady Sarevess - 84328
	AddPet(84328, 72777, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84328, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84328, A_CUSTOM, 46)
	
	-- Sigil of Lady Sarevess - 81697
	AddPet(81697, 57640, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81697, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81697, A_CUSTOM, 46)
	
	-- Sigil of Lady Sesspira - 81795
	AddPet(81795, 58807, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81795, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81795, A_CUSTOM, 46)
	
	-- Sigil of Lady Sylvanas Windrunner - 84351
	AddPet(84351, 73073, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84351, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84351, A_CUSTOM, 46)
	
	-- Sigil of Lady Sylvanas Windrunner - 81916
	AddPet(81916, 59872, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81916, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81916, A_CUSTOM, 46)
	
	-- Sigil of Lady Szallah - 81704
	AddPet(81704, 57647, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81704, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81704, A_CUSTOM, 46)
	
	-- Sigil of Lady Vashj - 82455
	AddPet(82455, 63320, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82455, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82455, A_CUSTOM, 46)
	
	-- Sigil of Lady Vespia - 81962
	AddPet(81962, 59919, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81962, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81962, A_CUSTOM, 46)
	
	-- Sigil of Lady Vespira - 81802
	AddPet(81802, 58850, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81802, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81802, A_CUSTOM, 46)
	
	-- Sigil of Lady Xylvienne - 84213
	AddPet(84213, 72550, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84213, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84213, A_CUSTOM, 46)
	
	-- Sigil of Lady Zephris - 82092
	AddPet(82092, 60049, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82092, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82092, A_CUSTOM, 46)
	
	-- Sigil of Laj - 82330
	AddPet(82330, 61567, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82330, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82330, A_CUSTOM, 46)
	
	-- Sigil of Landslide - 82039
	AddPet(82039, 59996, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82039, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82039, A_CUSTOM, 46)
	
	-- Sigil of Lapress - 82130
	AddPet(82130, 60087, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82130, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82130, A_CUSTOM, 46)
	
	-- Sigil of Large Loch Crocolisk - 81617
	AddPet(81617, 57047, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81617, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81617, A_CUSTOM, 46)
	
	-- Sigil of Leech Widow - 81561
	AddPet(81561, 56953, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81561, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81561, A_CUSTOM, 46)
	
	-- Sigil of Leotheras the Blind - 82458
	AddPet(82458, 63326, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82458, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82458, A_CUSTOM, 46)
	
	-- Sigil of Leprithus - 81539
	AddPet(81539, 56931, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81539, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81539, A_CUSTOM, 46)
	
	-- Sigil of Lethon - 82155
	AddPet(82155, 60111, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82155, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82155, A_CUSTOM, 46)
	
	-- Sigil of Lethtendris - 82103
	AddPet(82103, 60060, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82103, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82103, A_CUSTOM, 46)
	
	-- Sigil of Leviathan Mk II - 82908
	AddPet(82908, 64423, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82908, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82908, A_CUSTOM, 46)
	
	-- Sigil of Leviathan Mk II (1) - 82944
	AddPet(82944, 65397, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82944, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82944, A_CUSTOM, 46)
	
	-- Sigil of Ley-Guardian Eregos - 82619
	AddPet(82619, 64042, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82619, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82619, A_CUSTOM, 46)
	
	-- Sigil of Licillin - 81609
	AddPet(81609, 57004, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81609, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81609, A_CUSTOM, 46)
	
	-- Sigil of LoGrosh - 81616
	AddPet(81616, 57046, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81616, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81616, A_CUSTOM, 46)
	
	-- Sigil of Loatheb - 82233
	AddPet(82233, 60186, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82233, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82233, A_CUSTOM, 46)
	
	-- Sigil of Lodey MacGraff - 84174
	AddPet(84174, 72501, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84174, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84174, A_CUSTOM, 46)
	
	-- Sigil of Loken - 82678
	AddPet(82678, 64101, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82678, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82678, A_CUSTOM, 46)
	
	-- Sigil of Loquenahak - 82855
	AddPet(82855, 64277, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82855, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82855, A_CUSTOM, 46)
	
	-- Sigil of Lord Alexei Barov - 81953
	AddPet(81953, 59910, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81953, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81953, A_CUSTOM, 46)
	
	-- Sigil of Lord Angler - 82080
	AddPet(82080, 60037, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82080, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82080, A_CUSTOM, 46)
	
	-- Sigil of Lord Captain Wyrmak - 82124
	AddPet(82124, 60081, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82124, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82124, A_CUSTOM, 46)
	
	-- Sigil of Lord Cobrahn - 81655
	AddPet(81655, 57598, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81655, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81655, A_CUSTOM, 46)
	
	-- Sigil of Lord Condar - 82084
	AddPet(82084, 60041, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82084, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82084, A_CUSTOM, 46)
	
	-- Sigil of Lord Darkscythe - 81986
	AddPet(81986, 59943, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81986, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81986, A_CUSTOM, 46)
	
	-- Sigil of Lord Greed - 84343
	AddPet(84343, 72795, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84343, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84343, A_CUSTOM, 46)
	
	-- Sigil of Lord Helnurath - 82143
	AddPet(82143, 60099, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82143, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82143, A_CUSTOM, 46)
	
	-- Sigil of Lord Incendius - 81876
	AddPet(81876, 59832, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81876, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81876, A_CUSTOM, 46)
	
	-- Sigil of Lord Jaraxxus - 82994
	AddPet(82994, 67432, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82994, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82994, A_CUSTOM, 46)
	
	-- Sigil of Lord Kazzak - 82046
	AddPet(82046, 60003, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82046, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82046, A_CUSTOM, 46)
	
	-- Sigil of Lord Kri - 84263
	AddPet(84263, 72712, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84263, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84263, A_CUSTOM, 46)
	
	-- Sigil of Lord Kri - 82202
	AddPet(82202, 60155, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82202, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82202, A_CUSTOM, 46)
	
	-- Sigil of Lord Malathrom - 81532
	AddPet(81532, 103732, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81532, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81532, A_CUSTOM, 46)
	
	-- Sigil of Lord Maldazzar - 81591
	AddPet(81591, 56984, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81591, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81591, A_CUSTOM, 46)
	
	-- Sigil of Lord Marrowgar - 83311
	AddPet(83311, 68736, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83311, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83311, A_CUSTOM, 46)
	
	-- Sigil of Lord Marrowgar - 83153
	AddPet(83153, 67913, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83153, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83153, A_CUSTOM, 46)
	
	-- Sigil of Lord Pythas - 81656
	AddPet(81656, 57599, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81656, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81656, A_CUSTOM, 46)
	
	-- Sigil of Lord Roccor - 81880
	AddPet(81880, 59836, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81880, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81880, A_CUSTOM, 46)
	
	-- Sigil of Lord Sakrasis - 81618
	AddPet(81618, 57048, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81618, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81618, A_CUSTOM, 46)
	
	-- Sigil of Lord Serpentis - 81659
	AddPet(81659, 57602, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81659, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81659, A_CUSTOM, 46)
	
	-- Sigil of Lord Sinslayer - 81803
	AddPet(81803, 58851, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81803, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81803, A_CUSTOM, 46)
	
	-- Sigil of Lord Skwol - 82175
	AddPet(82175, 60131, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82175, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82175, A_CUSTOM, 46)
	
	-- Sigil of Lord Valthalak - 82235
	AddPet(82235, 60188, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82235, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82235, A_CUSTOM, 46)
	
	-- Sigil of Lord Victor Nefarius - 84215
	AddPet(84215, 72552, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84215, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84215, A_CUSTOM, 46)
	
	-- Sigil of Lord Vyletongue - 82041
	AddPet(82041, 59998, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82041, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82041, A_CUSTOM, 46)
	
	-- Sigil of Lorekeeper Polkelt - 81990
	AddPet(81990, 59947, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81990, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81990, A_CUSTOM, 46)
	
	-- Sigil of Lorgus Jett - 84333
	AddPet(84333, 72782, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84333, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84333, A_CUSTOM, 46)
	
	-- Sigil of Lorgus Jett - 82053
	AddPet(82053, 60010, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82053, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82053, A_CUSTOM, 46)
	
	-- Sigil of Lost One Chieftain - 81553
	AddPet(81553, 56945, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81553, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81553, A_CUSTOM, 46)
	
	-- Sigil of Lost One Cook - 81560
	AddPet(81560, 56952, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81560, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81560, A_CUSTOM, 46)
	
	-- Sigil of Lost Soul - 81573
	AddPet(81573, 56965, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81573, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81573, A_CUSTOM, 46)
	
	-- Sigil of Lucifron - 84296
	AddPet(84296, 72745, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84296, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84296, A_CUSTOM, 46)
	
	-- Sigil of Lucifron - 84230
	AddPet(84230, 72568, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84230, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84230, A_CUSTOM, 46)
	
	-- Sigil of Lucifron - 84107
	AddPet(84107, 72136, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84107, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84107, A_CUSTOM, 46)
	
	-- Sigil of Lucifron - 83315
	AddPet(83315, 68791, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83315, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83315, A_CUSTOM, 46)
	
	-- Sigil of Lucifron - 82036
	AddPet(82036, 59993, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82036, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82036, A_CUSTOM, 46)
	
	-- Sigil of Lumbering Horror - 82150
	AddPet(82150, 60106, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82150, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82150, A_CUSTOM, 46)
	
	-- Sigil of Lupos - 81537
	AddPet(81537, 56929, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81537, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81537, A_CUSTOM, 46)
	
	-- Sigil of Maruk Wyrmscale - 81603
	AddPet(81603, 56996, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81603, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81603, A_CUSTOM, 46)
	
	-- Sigil of Maexxna - 82226
	AddPet(82226, 60179, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82226, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82226, A_CUSTOM, 46)
	
	-- Sigil of Maghar Grunt - 84099
	AddPet(84099, 72122, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84099, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84099, A_CUSTOM, 46)
	
	-- Sigil of Mage-Lord Urom - 82618
	AddPet(82618, 64041, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82618, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82618, A_CUSTOM, 46)
	
	-- Sigil of Magister Hawkhelm - 81793
	AddPet(81793, 58785, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81793, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81793, A_CUSTOM, 46)
	
	-- Sigil of Magister Kalendris - 82001
	AddPet(82001, 59958, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82001, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82001, A_CUSTOM, 46)
	
	-- Sigil of Magistrate Barthilas - 81945
	AddPet(81945, 59902, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81945, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81945, A_CUSTOM, 46)
	
	-- Sigil of Magmadar - 84297
	AddPet(84297, 72746, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84297, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84297, A_CUSTOM, 46)
	
	-- Sigil of Magmadar - 84222
	AddPet(84222, 72560, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84222, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84222, A_CUSTOM, 46)
	
	-- Sigil of Magmadar - 84108
	AddPet(84108, 72137, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84108, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84108, A_CUSTOM, 46)
	
	-- Sigil of Magmadar - 82026
	AddPet(82026, 59983, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82026, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82026, A_CUSTOM, 46)
	
	-- Sigil of Magmus - 81907
	AddPet(81907, 59863, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81907, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81907, A_CUSTOM, 46)
	
	-- Sigil of Magosh - 81570
	AddPet(81570, 56962, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81570, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81570, A_CUSTOM, 46)
	
	-- Sigil of Magronos the Unyielding - 81855
	AddPet(81855, 59811, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81855, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81855, A_CUSTOM, 46)
	
	-- Sigil of Magtheridon - 82282
	AddPet(82282, 60945, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82282, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82282, A_CUSTOM, 46)
	
	-- Sigil of Maiden of Grief - 82642
	AddPet(82642, 64065, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82642, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82642, A_CUSTOM, 46)
	
	-- Sigil of Maiden of Virtue - 82252
	AddPet(82252, 60369, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82252, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82252, A_CUSTOM, 46)
	
	-- Sigil of Majordomo Executus - 84304
	AddPet(84304, 72753, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84304, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84304, A_CUSTOM, 46)
	
	-- Sigil of Majordomo Executus - 84226
	AddPet(84226, 72564, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84226, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84226, A_CUSTOM, 46)
	
	-- Sigil of Maleki the Pallid - 81948
	AddPet(81948, 59905, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81948, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81948, A_CUSTOM, 46)
	
	-- Sigil of Malfunctioning Reaver - 81873
	AddPet(81873, 59829, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81873, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81873, A_CUSTOM, 46)
	
	-- Sigil of Malgin Barleybrew - 81759
	AddPet(81759, 58080, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81759, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81759, A_CUSTOM, 46)
	
	-- Sigil of Malor the Zealous - 81993
	AddPet(81993, 59950, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81993, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81993, A_CUSTOM, 46)
	
	-- Sigil of Marcus Bel - 81737
	AddPet(81737, 57680, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81737, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81737, A_CUSTOM, 46)
	
	-- Sigil of Marduk Blackpool - 81944
	AddPet(81944, 59900, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81944, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81944, A_CUSTOM, 46)
	
	-- Sigil of Marisa duPaige - 81544
	AddPet(81544, 56936, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81544, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81544, A_CUSTOM, 46)
	
	-- Sigil of Marticar - 82366
	AddPet(82366, 61968, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82366, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82366, A_CUSTOM, 46)
	
	-- Sigil of Maruum - 84172
	AddPet(84172, 72499, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84172, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84172, A_CUSTOM, 46)
	
	-- Sigil of Maruum - 84164
	AddPet(84164, 72287, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84164, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84164, A_CUSTOM, 46)
	
	-- Sigil of Marwyn - 83223
	AddPet(83223, 68392, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83223, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83223, A_CUSTOM, 46)
	
	-- Sigil of Master Digger - 81571
	AddPet(81571, 56963, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81571, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81571, A_CUSTOM, 46)
	
	-- Sigil of Master Feardred - 81798
	AddPet(81798, 58823, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81798, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81798, A_CUSTOM, 46)
	
	-- Sigil of Maws - 82208
	AddPet(82208, 60161, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82208, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82208, A_CUSTOM, 46)
	
	-- Sigil of Mazzranache - 81641
	AddPet(81641, 57565, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81641, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81641, A_CUSTOM, 46)
	
	-- Sigil of Meathook - 82587
	AddPet(82587, 64010, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82587, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82587, A_CUSTOM, 46)
	
	-- Sigil of Mechano-Lord Capacitus - 82401
	AddPet(82401, 62411, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82401, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82401, A_CUSTOM, 46)
	
	-- Sigil of Mekgineer Steamrigger - 82306
	AddPet(82306, 61199, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82306, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82306, A_CUSTOM, 46)
	
	-- Sigil of Mekgineer Thermaplugg - 81822
	AddPet(81822, 58879, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81822, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81822, A_CUSTOM, 46)
	
	-- Sigil of Mekthorg the Wild - 82363
	AddPet(82363, 61631, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82363, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82363, A_CUSTOM, 46)
	
	-- Sigil of Mennu the Betrayer - 82321
	AddPet(82321, 61537, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82321, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82321, A_CUSTOM, 46)
	
	-- Sigil of Merithra of the Dream - 84258
	AddPet(84258, 72707, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84258, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84258, A_CUSTOM, 46)
	
	-- Sigil of Meshlok the Harvester - 82042
	AddPet(82042, 59999, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82042, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82042, A_CUSTOM, 46)
	
	-- Sigil of Mezzir the Howler - 81919
	AddPet(81919, 59875, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81919, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81919, A_CUSTOM, 46)
	
	-- Sigil of Miner Johnson - 81650
	AddPet(81650, 57593, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81650, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81650, A_CUSTOM, 46)
	
	-- Sigil of Mirelow - 82113
	AddPet(82113, 60070, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82113, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82113, A_CUSTOM, 46)
	
	-- Sigil of Mist Howler - 81970
	AddPet(81970, 59927, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81970, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81970, A_CUSTOM, 46)
	
	-- Sigil of Mithrethis the Enchanter - 81844
	AddPet(81844, 59338, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81844, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81844, A_CUSTOM, 46)
	
	-- Sigil of Moam - 84253
	AddPet(84253, 72602, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84253, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84253, A_CUSTOM, 46)
	
	-- Sigil of Moam - 82177
	AddPet(82177, 60133, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82177, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82177, A_CUSTOM, 46)
	
	-- Sigil of Mojo the Twisted - 81854
	AddPet(81854, 59528, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81854, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81854, A_CUSTOM, 46)
	
	-- Sigil of Molok the Crusher - 81624
	AddPet(81624, 57054, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81624, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81624, A_CUSTOM, 46)
	
	-- Sigil of Molt Thorn - 82127
	AddPet(82127, 60084, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82127, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82127, A_CUSTOM, 46)
	
	-- Sigil of Mongress - 82109
	AddPet(82109, 60066, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82109, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82109, A_CUSTOM, 46)
	
	-- Sigil of Monnos the Elder - 81792
	AddPet(81792, 58782, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81792, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81792, A_CUSTOM, 46)
	
	-- Sigil of Moorabi - 82697
	AddPet(82697, 64120, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82697, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82697, A_CUSTOM, 46)
	
	-- Sigil of Moragg - 82704
	AddPet(82704, 64127, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82704, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82704, A_CUSTOM, 46)
	
	-- Sigil of Morbent Fell - 83505
	AddPet(83505, 69382, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83505, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83505, A_CUSTOM, 46)
	
	-- Sigil of Morcrush - 82374
	AddPet(82374, 62293, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82374, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82374, A_CUSTOM, 46)
	
	-- Sigil of Mordresh Fire Eye - 81817
	AddPet(81817, 58872, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81817, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81817, A_CUSTOM, 46)
	
	-- Sigil of Morgaine the Sly - 81527
	AddPet(81527, 103727, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81527, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81527, A_CUSTOM, 46)
	
	-- Sigil of Moroes - 82213
	AddPet(82213, 60166, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82213, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82213, A_CUSTOM, 46)
	
	-- Sigil of Morogrim Tidewalker - 82456
	AddPet(82456, 63324, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82456, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82456, A_CUSTOM, 46)
	
	-- Sigil of Morphaz - 81720
	AddPet(81720, 57663, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81720, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81720, A_CUSTOM, 46)
	
	-- Sigil of Mother Fang - 81530
	AddPet(81530, 103730, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81530, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81530, A_CUSTOM, 46)
	
	-- Sigil of Mother Shahraz - 82501
	AddPet(82501, 63520, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82501, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82501, A_CUSTOM, 46)
	
	-- Sigil of Mother Smolderweb - 81964
	AddPet(81964, 59921, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81964, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81964, A_CUSTOM, 46)
	
	-- Sigil of Mr. Smite - 81551
	AddPet(81551, 56943, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81551, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81551, A_CUSTOM, 46)
	
	-- Sigil of Muad - 81597
	AddPet(81597, 56990, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81597, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81597, A_CUSTOM, 46)
	
	-- Sigil of Mugglefin - 81969
	AddPet(81969, 59926, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81969, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81969, A_CUSTOM, 46)
	
	-- Sigil of Murderous Blisterpaw - 81836
	AddPet(81836, 59134, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81836, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81836, A_CUSTOM, 46)
	
	-- Sigil of Murmur - 82383
	AddPet(82383, 62303, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82383, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82383, A_CUSTOM, 46)
	
	-- Sigil of Mushgog - 81998
	AddPet(81998, 59955, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81998, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81998, A_CUSTOM, 46)
	
	-- Sigil of Mutanus the Devourer - 81654
	AddPet(81654, 57597, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81654, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81654, A_CUSTOM, 46)
	
	-- Sigil of Naltaszar - 81679
	AddPet(81679, 57622, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81679, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81679, A_CUSTOM, 46)
	
	-- Sigil of Nalorakk - 82521
	AddPet(82521, 63944, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82521, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82521, A_CUSTOM, 46)
	
	-- Sigil of Naraxis - 81541
	AddPet(81541, 56933, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81541, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81541, A_CUSTOM, 46)
	
	-- Sigil of Narg the Taskmaster - 81068
	AddPet(81068, 103726, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81068, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81068, A_CUSTOM, 46)
	
	-- Sigil of Narillasanz - 81614
	AddPet(81614, 57044, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81614, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81614, A_CUSTOM, 46)
	
	-- Sigil of Nazan - 82294
	AddPet(82294, 61024, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82294, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82294, A_CUSTOM, 46)
	
	-- Sigil of Nefarian - 84220
	AddPet(84220, 72558, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84220, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84220, A_CUSTOM, 46)
	
	-- Sigil of Nefarian - 82016
	AddPet(82016, 59973, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82016, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82016, A_CUSTOM, 46)
	
	-- Sigil of Nefaru - 81538
	AddPet(81538, 56930, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81538, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81538, A_CUSTOM, 46)
	
	-- Sigil of Nekrum Gutchewer - 81821
	AddPet(81821, 58878, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81821, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81821, A_CUSTOM, 46)
	
	-- Sigil of Neptune - 84105
	AddPet(84105, 72131, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84105, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84105, A_CUSTOM, 46)
	
	-- Sigil of Nerubenkan - 81947
	AddPet(81947, 59904, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81947, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81947, A_CUSTOM, 46)
	
	-- Sigil of Nerubian Overseer - 82249
	AddPet(82249, 60366, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82249, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82249, A_CUSTOM, 46)
	
	-- Sigil of Nethermancer Sepethrea - 82403
	AddPet(82403, 62442, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82403, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82403, A_CUSTOM, 46)
	
	-- Sigil of Netherspite - 82215
	AddPet(82215, 60168, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82215, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82215, A_CUSTOM, 46)
	
	-- Sigil of Netherstrand Longbow - 82461
	AddPet(82461, 63340, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82461, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82461, A_CUSTOM, 46)
	
	-- Sigil of Nexus-Prince Shaffar - 82348
	AddPet(82348, 61603, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82348, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82348, A_CUSTOM, 46)
	
	-- Sigil of Nightbane - 82279
	AddPet(82279, 60833, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82279, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82279, A_CUSTOM, 46)
	
	-- Sigil of Nimar the Slayer - 81626
	AddPet(81626, 57056, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81626, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81626, A_CUSTOM, 46)
	
	-- Sigil of Noth the Plaguebringer - 82228
	AddPet(82228, 60181, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82228, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82228, A_CUSTOM, 46)
	
	-- Sigil of Novos the Summoner - 82591
	AddPet(82591, 64014, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82591, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82591, A_CUSTOM, 46)
	
	-- Sigil of Noxxion - 82056
	AddPet(82056, 60013, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82056, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82056, A_CUSTOM, 46)
	
	-- Sigil of Nuramoc - 82452
	AddPet(82452, 63298, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82452, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82452, A_CUSTOM, 46)
	
	-- Sigil of Oakpaw - 81966
	AddPet(81966, 59923, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81966, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81966, A_CUSTOM, 46)
	
	-- Sigil of Odo the Blindwatcher - 81684
	AddPet(81684, 57627, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81684, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81684, A_CUSTOM, 46)
	
	-- Sigil of Oggleflint - 82011
	AddPet(82011, 59968, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82011, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82011, A_CUSTOM, 46)
	
	-- Sigil of Okrek - 82371
	AddPet(82371, 62250, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82371, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82371, A_CUSTOM, 46)
	
	-- Sigil of Old Cliff Jumper - 81838
	AddPet(81838, 59136, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81838, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81838, A_CUSTOM, 46)
	
	-- Sigil of Old Crystalbark - 82823
	AddPet(82823, 64245, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82823, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82823, A_CUSTOM, 46)
	
	-- Sigil of Old Grizzlegut - 81711
	AddPet(81711, 57654, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81711, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81711, A_CUSTOM, 46)
	
	-- Sigil of Old Serrakis - 84327
	AddPet(84327, 72776, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84327, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84327, A_CUSTOM, 46)
	
	-- Sigil of Old Serrakis - 81696
	AddPet(81696, 57639, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81696, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81696, A_CUSTOM, 46)
	
	-- Sigil of Old Vicejaw - 82048
	AddPet(82048, 60005, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82048, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82048, A_CUSTOM, 46)
	
	-- Sigil of Olm the Wise - 82108
	AddPet(82108, 60065, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82108, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82108, A_CUSTOM, 46)
	
	-- Sigil of Omen - 82195
	AddPet(82195, 60149, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82195, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82195, A_CUSTOM, 46)
	
	-- Sigil of Omgorn the Lost - 81829
	AddPet(81829, 59127, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81829, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81829, A_CUSTOM, 46)
	
	-- Sigil of Omor the Unscarred - 82284
	AddPet(82284, 60947, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82284, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82284, A_CUSTOM, 46)
	
	-- Sigil of Onyxia - 84216
	AddPet(84216, 72554, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84216, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84216, A_CUSTOM, 46)
	
	-- Sigil of Onyxia - 81917
	AddPet(81917, 59873, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81917, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81917, A_CUSTOM, 46)
	
	-- Sigil of Oozeworm - 82081
	AddPet(82081, 60038, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82081, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82081, A_CUSTOM, 46)
	
	-- Sigil of Ormorok the Tree-Shaper - 82600
	AddPet(82600, 64023, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82600, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82600, A_CUSTOM, 46)
	
	-- Sigil of Ossirian the Unscarred - 84252
	AddPet(84252, 72601, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84252, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84252, A_CUSTOM, 46)
	
	-- Sigil of Ossirian the Unscarred - 82176
	AddPet(82176, 60132, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82176, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82176, A_CUSTOM, 46)
	
	-- Sigil of Ouro - 84265
	AddPet(84265, 72714, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84265, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84265, A_CUSTOM, 46)
	
	-- Sigil of Ouro - 82204
	AddPet(82204, 60157, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82204, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82204, A_CUSTOM, 46)
	
	-- Sigil of Overlord Ramtusk - 81686
	AddPet(81686, 57629, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81686, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81686, A_CUSTOM, 46)
	
	-- Sigil of Overlord Wyrmthalak - 81900
	AddPet(81900, 59856, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81900, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81900, A_CUSTOM, 46)
	
	-- Sigil of Pandemonius - 82346
	AddPet(82346, 61599, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82346, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82346, A_CUSTOM, 46)
	
	-- Sigil of Panzor the Invincible - 81868
	AddPet(81868, 59824, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81868, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81868, A_CUSTOM, 46)
	
	-- Sigil of Patchwerk - 82234
	AddPet(82234, 60187, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82234, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82234, A_CUSTOM, 46)
	
	-- Sigil of Pathaleon the Calculator - 82402
	AddPet(82402, 62419, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82402, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82402, A_CUSTOM, 46)
	
	-- Sigil of Perobas the Bloodthirster - 82829
	AddPet(82829, 64251, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82829, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82829, A_CUSTOM, 46)
	
	-- Sigil of Phaeton - 83321
	AddPet(83321, 68827, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83321, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83321, A_CUSTOM, 46)
	
	-- Sigil of Phalanx - 81897
	AddPet(81897, 59853, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81897, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81897, A_CUSTOM, 46)
	
	-- Sigil of Phaseshift Bulwark - 82462
	AddPet(82462, 63360, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82462, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82462, A_CUSTOM, 46)
	
	-- Sigil of Plugger Spazzring - 81896
	AddPet(81896, 59852, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81896, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81896, A_CUSTOM, 46)
	
	-- Sigil of plz no evade - 83886
	AddPet(83886, 71136, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83886, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83886, A_CUSTOM, 46)
	
	-- Sigil of Portal - 83894
	AddPet(83894, 71186, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83894, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83894, A_CUSTOM, 46)
	
	-- Sigil of Pridewing Patriarch - 81677
	AddPet(81677, 57620, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81677, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81677, A_CUSTOM, 46)
	
	-- Sigil of Priestess Delrissa - 82546
	AddPet(82546, 63969, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82546, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82546, A_CUSTOM, 46)
	
	-- Sigil of Prince Keleseth - 82534
	AddPet(82534, 63957, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82534, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82534, A_CUSTOM, 46)
	
	-- Sigil of Prince Kellen - 82069
	AddPet(82069, 60026, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82069, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82069, A_CUSTOM, 46)
	
	-- Sigil of Prince Malchezaar - 82216
	AddPet(82216, 60169, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82216, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82216, A_CUSTOM, 46)
	
	-- Sigil of Prince Nazjak - 81635
	AddPet(81635, 57123, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81635, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81635, A_CUSTOM, 46)
	
	-- Sigil of Prince Raze - 81971
	AddPet(81971, 59928, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81971, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81971, A_CUSTOM, 46)
	
	-- Sigil of Prince Skaldrenox - 82166
	AddPet(82166, 60122, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82166, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82166, A_CUSTOM, 46)
	
	-- Sigil of Prince Taldaram - 82699
	AddPet(82699, 64122, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82699, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82699, A_CUSTOM, 46)
	
	-- Sigil of Prince Thunderaan - 82123
	AddPet(82123, 60080, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82123, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82123, A_CUSTOM, 46)
	
	-- Sigil of Prince Tortheldrin - 82000
	AddPet(82000, 59957, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82000, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82000, A_CUSTOM, 46)
	
	-- Sigil of Prince Valanar - 83213
	AddPet(83213, 68380, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83213, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83213, A_CUSTOM, 46)
	
	-- Sigil of Princess Huhuran - 84261
	AddPet(84261, 72710, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84261, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84261, A_CUSTOM, 46)
	
	-- Sigil of Princess Huhuran - 82200
	AddPet(82200, 60153, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82200, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82200, A_CUSTOM, 46)
	
	-- Sigil of Princess Theradras - 82038
	AddPet(82038, 59995, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82038, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82038, A_CUSTOM, 46)
	
	-- Sigil of Princess Yauj - 84266
	AddPet(84266, 72715, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84266, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84266, A_CUSTOM, 46)
	
	-- Sigil of Princess Yauj - 82205
	AddPet(82205, 60158, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82205, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82205, A_CUSTOM, 46)
	
	-- Sigil of Professor Putricide - 83159
	AddPet(83159, 67919, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83159, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83159, A_CUSTOM, 46)
	
	-- Sigil of Professor Slate - 83880
	AddPet(83880, 71126, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83880, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83880, A_CUSTOM, 46)
	
	-- Sigil of Prognar - 84311
	AddPet(84311, 72760, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84311, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84311, A_CUSTOM, 46)
	
	-- Sigil of Pulvis - 81062
	AddPet(81062, 103724, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81062, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81062, A_CUSTOM, 46)
	
	-- Sigil of Putridius - 81593
	AddPet(81593, 56986, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81593, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81593, A_CUSTOM, 46)
	
	-- Sigil of Putridus the Ancient - 82849
	AddPet(82849, 64271, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82849, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82849, A_CUSTOM, 46)
	
	-- Sigil of Pyroguard Emberseer - 81906
	AddPet(81906, 59862, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81906, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81906, A_CUSTOM, 46)
	
	-- Sigil of Pyromancer Loregrain - 81879
	AddPet(81879, 59835, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81879, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81879, A_CUSTOM, 46)
	
	-- Sigil of Qirot - 81710
	AddPet(81710, 57653, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81710, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81710, A_CUSTOM, 46)
	
	-- Sigil of Quagmirran - 82322
	AddPet(82322, 61539, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82322, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82322, A_CUSTOM, 46)
	
	-- Sigil of Quartermaster Zigris - 81905
	AddPet(81905, 59861, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81905, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81905, A_CUSTOM, 46)
	
	-- Sigil of Rage Winterchill - 82303
	AddPet(82303, 61196, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82303, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82303, A_CUSTOM, 46)
	
	-- Sigil of Ragepaw - 82107
	AddPet(82107, 60064, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82107, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82107, A_CUSTOM, 46)
	
	-- Sigil of Ragnaros - 84305
	AddPet(84305, 72754, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84305, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84305, A_CUSTOM, 46)
	
	-- Sigil of Ragnaros - 84219
	AddPet(84219, 72557, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84219, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84219, A_CUSTOM, 46)
	
	-- Sigil of Ragnaros - 84116
	AddPet(84116, 72148, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84116, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84116, A_CUSTOM, 46)
	
	-- Sigil of Ragnaros - 82010
	AddPet(82010, 59967, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82010, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82010, A_CUSTOM, 46)
	
	-- Sigil of Rakshiri - 81922
	AddPet(81922, 59878, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81922, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81922, A_CUSTOM, 46)
	
	-- Sigil of Ramstein the Gorger - 81949
	AddPet(81949, 59906, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81949, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81949, A_CUSTOM, 46)
	
	-- Sigil of Ranger Lord Hawkspear - 84360
	AddPet(84360, 73082, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84360, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84360, A_CUSTOM, 46)
	
	-- Sigil of Ranger Lord Hawkspear - 81984
	AddPet(81984, 59941, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81984, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81984, A_CUSTOM, 46)
	
	-- Sigil of Ras Frostwhisper - 81957
	AddPet(81957, 59914, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81957, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81957, A_CUSTOM, 46)
	
	-- Sigil of Rathorian - 81646
	AddPet(81646, 57589, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81646, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81646, A_CUSTOM, 46)
	
	-- Sigil of Rattlegore - 82017
	AddPet(82017, 59974, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82017, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82017, A_CUSTOM, 46)
	
	-- Sigil of Ravage - 81858
	AddPet(81858, 59814, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81858, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81858, A_CUSTOM, 46)
	
	-- Sigil of Ravasaur Matriarch - 81787
	AddPet(81787, 58496, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81787, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81787, A_CUSTOM, 46)
	
	-- Sigil of Ravenclaw Regent - 81612
	AddPet(81612, 57042, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81612, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81612, A_CUSTOM, 46)
	
	-- Sigil of Razorclaw the Butcher - 81668
	AddPet(81668, 57611, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81668, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81668, A_CUSTOM, 46)
	
	-- Sigil of Razorfen Spearhide - 81692
	AddPet(81692, 57635, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81692, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81692, A_CUSTOM, 46)
	
	-- Sigil of Razorgore the Untamed - 84233
	AddPet(84233, 72571, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84233, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84233, A_CUSTOM, 46)
	
	-- Sigil of Razorgore the Untamed - 82050
	AddPet(82050, 60007, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82050, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82050, A_CUSTOM, 46)
	
	-- Sigil of Razorlash - 82043
	AddPet(82043, 60000, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82043, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82043, A_CUSTOM, 46)
	
	-- Sigil of Razormaw Matriarch - 81566
	AddPet(81566, 56958, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81566, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81566, A_CUSTOM, 46)
	
	-- Sigil of Razorscale - 84341
	AddPet(84341, 72790, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84341, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84341, A_CUSTOM, 46)
	
	-- Sigil of Razorscale - 82884
	AddPet(82884, 64327, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82884, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82884, A_CUSTOM, 46)
	
	-- Sigil of Razortalon - 81837
	AddPet(81837, 59135, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81837, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81837, A_CUSTOM, 46)
	
	-- Sigil of Reek - 84127
	AddPet(84127, 72169, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84127, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84127, A_CUSTOM, 46)
	
	-- Sigil of Rekktilac - 81847
	AddPet(81847, 59365, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81847, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81847, A_CUSTOM, 46)
	
	-- Sigil of Renataki - 84245
	AddPet(84245, 72593, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84245, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84245, A_CUSTOM, 46)
	
	-- Sigil of Renataki - 82162
	AddPet(82162, 60118, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82162, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82162, A_CUSTOM, 46)
	
	-- Sigil of Ressan the Needler - 81935
	AddPet(81935, 59891, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81935, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81935, A_CUSTOM, 46)
	
	-- Sigil of Retherokk the Berserker - 81843
	AddPet(81843, 59155, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81843, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81843, A_CUSTOM, 46)
	
	-- Sigil of Rethilgore - 81670
	AddPet(81670, 57613, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81670, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81670, A_CUSTOM, 46)
	
	-- Sigil of Revelosh - 81800
	AddPet(81800, 58848, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81800, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81800, A_CUSTOM, 46)
	
	-- Sigil of Rex Ashil - 82132
	AddPet(82132, 60089, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82132, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82132, A_CUSTOM, 46)
	
	-- Sigil of RhahkZor - 81549
	AddPet(81549, 56941, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81549, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81549, A_CUSTOM, 46)
	
	-- Sigil of Ribbly Screwspigot - 81899
	AddPet(81899, 59855, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81899, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81899, A_CUSTOM, 46)
	
	-- Sigil of Ribchaser - 82087
	AddPet(82087, 60044, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82087, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82087, A_CUSTOM, 46)
	
	-- Sigil of Rippa - 82140
	AddPet(82140, 60096, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82140, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82140, A_CUSTOM, 46)
	
	-- Sigil of Ripscale - 82077
	AddPet(82077, 60034, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82077, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82077, A_CUSTOM, 46)
	
	-- Sigil of RoBark - 82093
	AddPet(82093, 60050, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82093, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82093, A_CUSTOM, 46)
	
	-- Sigil of Rocklance - 81756
	AddPet(81756, 57996, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81756, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81756, A_CUSTOM, 46)
	
	-- Sigil of Rohh the Silent - 81556
	AddPet(81556, 56948, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81556, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81556, A_CUSTOM, 46)
	
	-- Sigil of Rokad the Ravager - 82248
	AddPet(82248, 60365, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82248, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82248, A_CUSTOM, 46)
	
	-- Sigil of Rokmar the Crackler - 82331
	AddPet(82331, 61569, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82331, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82331, A_CUSTOM, 46)
	
	-- Sigil of Roloch - 82139
	AddPet(82139, 60095, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82139, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82139, A_CUSTOM, 46)
	
	-- Sigil of Romulo - 82291
	AddPet(82291, 60992, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82291, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82291, A_CUSTOM, 46)
	
	-- Sigil of Roogug - 81778
	AddPet(81778, 58229, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81778, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81778, A_CUSTOM, 46)
	
	-- Sigil of Rorgish Jowl - 81965
	AddPet(81965, 59922, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81965, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81965, A_CUSTOM, 46)
	
	-- Sigil of Rot Hide Bruiser - 81601
	AddPet(81601, 56994, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81601, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81601, A_CUSTOM, 46)
	
	-- Sigil of Rotface - 83155
	AddPet(83155, 67915, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83155, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83155, A_CUSTOM, 46)
	
	-- Sigil of Rotgrip - 82057
	AddPet(82057, 60014, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82057, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82057, A_CUSTOM, 46)
	
	-- Sigil of Rumbler - 81632
	AddPet(81632, 57107, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81632, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81632, A_CUSTOM, 46)
	
	-- Sigil of Runemaster Molgeim - 82874
	AddPet(82874, 64296, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82874, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82874, A_CUSTOM, 46)
	
	-- Sigil of Ruul Onestone - 81622
	AddPet(81622, 57052, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81622, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81622, A_CUSTOM, 46)
	
	-- Sigil of Salramm the Fleshcrafter - 82588
	AddPet(82588, 64011, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82588, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82588, A_CUSTOM, 46)
	
	-- Sigil of Sandarr Dunereaver - 81910
	AddPet(81910, 59866, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81910, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81910, A_CUSTOM, 46)
	
	-- Sigil of Sapphiron - 82231
	AddPet(82231, 60184, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82231, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82231, A_CUSTOM, 46)
	
	-- Sigil of Sartharion - 82675
	AddPet(82675, 64098, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82675, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82675, A_CUSTOM, 46)
	
	-- Sigil of Sathrovarr the Corruptor - 82555
	AddPet(82555, 63978, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82555, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82555, A_CUSTOM, 46)
	
	-- Sigil of Saviana Ragefire - 83303
	AddPet(83303, 68723, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83303, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83303, A_CUSTOM, 46)
	
	-- Sigil of Scald - 81851
	AddPet(81851, 59447, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81851, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81851, A_CUSTOM, 46)
	
	-- Sigil of Scale Belly - 81575
	AddPet(81575, 56967, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81575, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81575, A_CUSTOM, 46)
	
	-- Sigil of Scalebeard - 82059
	AddPet(82059, 60016, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82059, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82059, A_CUSTOM, 46)
	
	-- Sigil of Scargil - 82091
	AddPet(82091, 60048, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82091, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82091, A_CUSTOM, 46)
	
	-- Sigil of Scarlet Executioner - 81587
	AddPet(81587, 56980, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81587, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81587, A_CUSTOM, 46)
	
	-- Sigil of Scarlet High Clerist - 81586
	AddPet(81586, 56979, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81586, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81586, A_CUSTOM, 46)
	
	-- Sigil of Scarlet Highlord Daion - 82836
	AddPet(82836, 64258, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82836, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82836, A_CUSTOM, 46)
	
	-- Sigil of Scarlet Interrogator - 81585
	AddPet(81585, 56978, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81585, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81585, A_CUSTOM, 46)
	
	-- Sigil of Scarlet Judge - 81584
	AddPet(81584, 56977, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81584, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81584, A_CUSTOM, 46)
	
	-- Sigil of Scarlet Smith - 81596
	AddPet(81596, 56989, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81596, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81596, A_CUSTOM, 46)
	
	-- Sigil of Scarshield Quartermaster - 81884
	AddPet(81884, 59840, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81884, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81884, A_CUSTOM, 46)
	
	-- Sigil of Scourge Overlord animator PH hyjal - 84103
	AddPet(84103, 72129, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84103, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84103, A_CUSTOM, 46)
	
	-- Sigil of Scourgelord Tyrannus - 83158
	AddPet(83158, 67918, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83158, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83158, A_CUSTOM, 46)
	
	-- Sigil of Seeker Aqualon - 82085
	AddPet(82085, 60042, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82085, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82085, A_CUSTOM, 46)
	
	-- Sigil of Seething Hate - 82838
	AddPet(82838, 64260, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82838, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82838, A_CUSTOM, 46)
	
	-- Sigil of Selin Fireheart - 82548
	AddPet(82548, 63971, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82548, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82548, A_CUSTOM, 46)
	
	-- Sigil of Sentinel Amarassan - 81768
	AddPet(81768, 58214, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81768, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81768, A_CUSTOM, 46)
	
	-- Sigil of Sergeant Brashclaw - 81533
	AddPet(81533, 56925, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81533, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81533, A_CUSTOM, 46)
	
	-- Sigil of Setis - 82128
	AddPet(82128, 60085, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82128, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82128, A_CUSTOM, 46)
	
	-- Sigil of Sewer Beast - 81649
	AddPet(81649, 57592, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81649, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81649, A_CUSTOM, 46)
	
	-- Sigil of Shade of Akama - 82494
	AddPet(82494, 63425, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82494, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82494, A_CUSTOM, 46)
	
	-- Sigil of Shade of Aran - 84340
	AddPet(84340, 72789, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84340, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84340, A_CUSTOM, 46)
	
	-- Sigil of Shade of Aran - 82254
	AddPet(82254, 60372, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82254, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82254, A_CUSTOM, 46)
	
	-- Sigil of Shade of Eranikus - 81718
	AddPet(81718, 57661, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81718, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81718, A_CUSTOM, 46)
	
	-- Sigil of Shadikith the Glider - 82247
	AddPet(82247, 60200, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82247, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82247, A_CUSTOM, 46)
	
	-- Sigil of Shadow Hunter Voshgajin - 81892
	AddPet(81892, 59848, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81892, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81892, A_CUSTOM, 46)
	
	-- Sigil of Shadowclaw - 81606
	AddPet(81606, 56999, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81606, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81606, A_CUSTOM, 46)
	
	-- Sigil of Shadowforge Commander - 81628
	AddPet(81628, 57103, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81628, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81628, A_CUSTOM, 46)
	
	-- Sigil of Shadowpriest Sezzziz - 81814
	AddPet(81814, 58868, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81814, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81814, A_CUSTOM, 46)
	
	-- Sigil of Shadron - 82740
	AddPet(82740, 64163, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82740, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82740, A_CUSTOM, 46)
	
	-- Sigil of Shanda the Spinner - 82082
	AddPet(82082, 60039, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82082, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82082, A_CUSTOM, 46)
	
	-- Sigil of Sharptooth Frenzy - 84106
	AddPet(84106, 72135, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84106, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84106, A_CUSTOM, 46)
	
	-- Sigil of Shazzrah - 84300
	AddPet(84300, 72749, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84300, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84300, A_CUSTOM, 46)
	
	-- Sigil of Shazzrah - 84232
	AddPet(84232, 72570, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84232, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84232, A_CUSTOM, 46)
	
	-- Sigil of Shazzrah - 84111
	AddPet(84111, 72141, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84111, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84111, A_CUSTOM, 46)
	
	-- Sigil of Shazzrah - 82045
	AddPet(82045, 60002, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82045, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82045, A_CUSTOM, 46)
	
	-- Sigil of Shirrak the Dead Watcher - 82349
	AddPet(82349, 61605, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82349, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82349, A_CUSTOM, 46)
	
	-- Sigil of Shleipnarr - 81850
	AddPet(81850, 59446, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81850, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81850, A_CUSTOM, 46)
	
	-- Sigil of Siege Golem - 81630
	AddPet(81630, 57105, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81630, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81630, A_CUSTOM, 46)
	
	-- Sigil of Silithid Harvester - 81642
	AddPet(81642, 57573, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81642, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81642, A_CUSTOM, 46)
	
	-- Sigil of Silithid Ravager - 81680
	AddPet(81680, 57623, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81680, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81680, A_CUSTOM, 46)
	
	-- Sigil of Sindragosa - 83163
	AddPet(83163, 68010, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83163, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83163, A_CUSTOM, 46)
	
	-- Sigil of Singer - 81620
	AddPet(81620, 57050, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81620, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81620, A_CUSTOM, 46)
	
	-- Sigil of Sister Hatelash - 81725
	AddPet(81725, 57668, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81725, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81725, A_CUSTOM, 46)
	
	-- Sigil of Sister Rathtalon - 81748
	AddPet(81748, 57893, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81748, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81748, A_CUSTOM, 46)
	
	-- Sigil of Sister Riven - 81770
	AddPet(81770, 58218, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81770, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81770, A_CUSTOM, 46)
	
	-- Sigil of Sjonnir The Ironshaper - 82644
	AddPet(82644, 64067, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82644, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82644, A_CUSTOM, 46)
	
	-- Sigil of Skadi the Ruthless - 82595
	AddPet(82595, 64018, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82595, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82595, A_CUSTOM, 46)
	
	-- Sigil of Skarr the Unbreakable - 82008
	AddPet(82008, 59965, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82008, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82008, A_CUSTOM, 46)
	
	-- Sigil of Skhowl - 81615
	AddPet(81615, 57045, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81615, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81615, A_CUSTOM, 46)
	
	-- Sigil of Skoll - 83011
	AddPet(83011, 67512, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83011, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83011, A_CUSTOM, 46)
	
	-- Sigil of Skreeg - 84210
	AddPet(84210, 72547, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84210, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84210, A_CUSTOM, 46)
	
	-- Sigil of Skul - 81940
	AddPet(81940, 59896, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81940, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81940, A_CUSTOM, 46)
	
	-- Sigil of Skum - 81660
	AddPet(81660, 57603, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81660, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81660, A_CUSTOM, 46)
	
	-- Sigil of Sladran - 82696
	AddPet(82696, 64119, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82696, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82696, A_CUSTOM, 46)
	
	-- Sigil of Slark - 81535
	AddPet(81535, 56927, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81535, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81535, A_CUSTOM, 46)
	
	-- Sigil of Slave Master Blackheart - 81853
	AddPet(81853, 59527, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81853, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81853, A_CUSTOM, 46)
	
	-- Sigil of Sludge Beast - 81644
	AddPet(81644, 57587, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81644, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81644, A_CUSTOM, 46)
	
	-- Sigil of Sludginn - 82122
	AddPet(82122, 60079, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82122, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82122, A_CUSTOM, 46)
	
	-- Sigil of Smoldar - 81848
	AddPet(81848, 59366, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81848, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81848, A_CUSTOM, 46)
	
	-- Sigil of Snagglespear - 81726
	AddPet(81726, 57669, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81726, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81726, A_CUSTOM, 46)
	
	-- Sigil of Snarler - 81713
	AddPet(81713, 57656, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81713, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81713, A_CUSTOM, 46)
	
	-- Sigil of Snarlflare - 82088
	AddPet(82088, 60045, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82088, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82088, A_CUSTOM, 46)
	
	-- Sigil of Snarlmane - 81602
	AddPet(81602, 56995, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81602, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81602, A_CUSTOM, 46)
	
	-- Sigil of Sneed - 81548
	AddPet(81548, 56940, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81548, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81548, A_CUSTOM, 46)
	
	-- Sigil of Snort the Heckler - 81747
	AddPet(81747, 57890, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81747, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81747, A_CUSTOM, 46)
	
	-- Sigil of Solakar Flamewreath - 81932
	AddPet(81932, 59888, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81932, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81932, A_CUSTOM, 46)
	
	-- Sigil of Soriid the Devourer - 81832
	AddPet(81832, 59130, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81832, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81832, A_CUSTOM, 46)
	
	-- Sigil of Sorrow Wing - 81769
	AddPet(81769, 58215, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81769, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81769, A_CUSTOM, 46)
	
	-- Sigil of Soul of The Harvester - 84204
	AddPet(84204, 72541, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84204, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84204, A_CUSTOM, 46)
	
	-- Sigil of Spawn of Hakkar - 81717
	AddPet(81717, 57660, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81717, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81717, A_CUSTOM, 46)
	
	-- Sigil of Speaker Margrom - 82376
	AddPet(82376, 62295, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82376, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82376, A_CUSTOM, 46)
	
	-- Sigil of Spirestone Battle Lord - 81890
	AddPet(81890, 59846, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81890, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81890, A_CUSTOM, 46)
	
	-- Sigil of Spirestone Butcher - 81891
	AddPet(81891, 59847, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81891, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81891, A_CUSTOM, 46)
	
	-- Sigil of Spirestone Lord Magus - 81889
	AddPet(81889, 59845, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81889, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81889, A_CUSTOM, 46)
	
	-- Sigil of Spirit of the Damned - 82250
	AddPet(82250, 60367, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82250, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82250, A_CUSTOM, 46)
	
	-- Sigil of Spiteflayer - 81857
	AddPet(81857, 59813, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81857, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81857, A_CUSTOM, 46)
	
	-- Sigil of Squiddic - 82086
	AddPet(82086, 60043, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82086, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82086, A_CUSTOM, 46)
	
	-- Sigil of Sriskulk - 81937
	AddPet(81937, 59893, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81937, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81937, A_CUSTOM, 46)
	
	-- Sigil of Staggon - 81929
	AddPet(81929, 59885, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81929, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81929, A_CUSTOM, 46)
	
	-- Sigil of Steelbreaker - 82868
	AddPet(82868, 64290, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82868, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82868, A_CUSTOM, 46)
	
	-- Sigil of Stomper Kreeg - 82098
	AddPet(82098, 60055, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82098, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82098, A_CUSTOM, 46)
	
	-- Sigil of Stone Fury - 81611
	AddPet(81611, 57041, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81611, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81611, A_CUSTOM, 46)
	
	-- Sigil of Stone Giant - 84363
	AddPet(84363, 73086, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84363, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84363, A_CUSTOM, 46)
	
	-- Sigil of Stonearm - 81754
	AddPet(81754, 57994, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81754, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81754, A_CUSTOM, 46)
	
	-- Sigil of Stonespine - 81973
	AddPet(81973, 59930, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81973, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81973, A_CUSTOM, 46)
	
	-- Sigil of Stony Tark - 884319
	AddPet(884319, 872768, R_COMMON, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 884319, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 884319, A_CUSTOM, 46)
	
	-- Sigil of Stormcaller Brundir - 82866
	AddPet(82866, 64288, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82866, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82866, A_CUSTOM, 46)
	
	-- Sigil of Strider Clutchmother - 81605
	AddPet(81605, 56998, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81605, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81605, A_CUSTOM, 46)
	
	-- Sigil of Sulfuron Harbinger - 84303
	AddPet(84303, 72752, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84303, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84303, A_CUSTOM, 46)
	
	-- Sigil of Sulfuron Harbinger - 84229
	AddPet(84229, 72567, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84229, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84229, A_CUSTOM, 46)
	
	-- Sigil of Sulfuron Harbinger - 84114
	AddPet(84114, 72144, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84114, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84114, A_CUSTOM, 46)
	
	-- Sigil of Sulfuron Harbinger - 83316
	AddPet(83316, 68792, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83316, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83316, A_CUSTOM, 46)
	
	-- Sigil of Sulfuron Harbinger - 82034
	AddPet(82034, 59991, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82034, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82034, A_CUSTOM, 46)
	
	-- Sigil of Supremus - 82498
	AddPet(82498, 63510, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82498, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82498, A_CUSTOM, 46)
	
	-- Sigil of Svala Sorrowgrave - 82593
	AddPet(82593, 64016, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82593, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82593, A_CUSTOM, 46)
	
	-- Sigil of Swamplord Muselek - 82310
	AddPet(82310, 61288, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82310, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82310, A_CUSTOM, 46)
	
	-- Sigil of Swiftmane - 81749
	AddPet(81749, 57897, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81749, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81749, A_CUSTOM, 46)
	
	-- Sigil of Swinegart Spearhide - 81764
	AddPet(81764, 58210, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81764, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81764, A_CUSTOM, 46)
	
	-- Sigil of Syreian the Bonecarver - 82840
	AddPet(82840, 64262, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82840, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82840, A_CUSTOM, 46)
	
	-- Sigil of Taerar - 82157
	AddPet(82157, 60113, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82157, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82157, A_CUSTOM, 46)
	
	-- Sigil of Takk the Leaper - 81757
	AddPet(81757, 57997, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81757, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81757, A_CUSTOM, 46)
	
	-- Sigil of Talon King Ikiss - 82357
	AddPet(82357, 61621, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82357, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82357, A_CUSTOM, 46)
	
	-- Sigil of Tamra Stormpike - 82090
	AddPet(82090, 60047, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82090, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82090, A_CUSTOM, 46)
	
	-- Sigil of Taragaman the Hungerer - 82014
	AddPet(82014, 59971, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82014, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82014, A_CUSTOM, 46)
	
	-- Sigil of Targetdummy Baron Geddon - 84175
	AddPet(84175, 72502, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84175, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84175, A_CUSTOM, 46)
	
	-- Sigil of Targorr the Dread - 81578
	AddPet(81578, 56971, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81578, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81578, A_CUSTOM, 46)
	
	-- Sigil of Tarphel The Animator - 83899
	AddPet(83899, 71220, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83899, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83899, A_CUSTOM, 46)
	
	-- Sigil of Taskmaster Barphul - 83893
	AddPet(83893, 71185, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83893, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83893, A_CUSTOM, 46)
	
	-- Sigil of Taskmaster Whipfang - 81771
	AddPet(81771, 58219, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81771, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81771, A_CUSTOM, 46)
	
	-- Sigil of Tavarok - 82347
	AddPet(82347, 61601, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82347, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82347, A_CUSTOM, 46)
	
	-- Sigil of Temporus - 82317
	AddPet(82317, 61352, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82317, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82317, A_CUSTOM, 46)
	
	-- Sigil of Tendris Warpwood - 82003
	AddPet(82003, 59960, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82003, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82003, A_CUSTOM, 46)
	
	-- Sigil of Tenebron - 82741
	AddPet(82741, 64164, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82741, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82741, A_CUSTOM, 46)
	
	-- Sigil of Tentacle (2) - 84292
	AddPet(84292, 72741, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84292, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84292, A_CUSTOM, 46)
	
	-- Sigil of Tentacle (3) - 84294
	AddPet(84294, 72743, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84294, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84294, A_CUSTOM, 46)
	
	-- Sigil of Terestian Illhoof - 82214
	AddPet(82214, 60167, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82214, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82214, A_CUSTOM, 46)
	
	-- Sigil of Teron Gorefiend - 82496
	AddPet(82496, 63443, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82496, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82496, A_CUSTOM, 46)
	
	-- Sigil of Terror Spinner - 84309
	AddPet(84309, 72758, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84309, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84309, A_CUSTOM, 46)
	
	-- Sigil of Terror Spinner - 82845
	AddPet(82845, 64267, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82845, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82845, A_CUSTOM, 46)
	
	-- Sigil of Terrorspark - 81909
	AddPet(81909, 59865, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81909, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81909, A_CUSTOM, 46)
	
	-- Sigil of Terrowulf Packlord - 81665
	AddPet(81665, 57608, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81665, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81665, A_CUSTOM, 46)
	
	-- Sigil of Thaddius - 82220
	AddPet(82220, 60173, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82220, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82220, A_CUSTOM, 46)
	
	-- Sigil of Thauris Balgarr - 81871
	AddPet(81871, 59827, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81871, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81871, A_CUSTOM, 46)
	
	-- Sigil of The Beast - 81942
	AddPet(81942, 59898, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81942, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81942, A_CUSTOM, 46)
	
	-- Sigil of The Behemoth - 81869
	AddPet(81869, 59825, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81869, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81869, A_CUSTOM, 46)
	
	-- Sigil of The Big Bad Wolf - 82290
	AddPet(82290, 60991, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82290, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82290, A_CUSTOM, 46)
	
	-- Sigil of The Black Stalker - 82319
	AddPet(82319, 61393, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82319, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82319, A_CUSTOM, 46)
	
	-- Sigil of The Crone - 82341
	AddPet(82341, 61590, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82341, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82341, A_CUSTOM, 46)
	
	-- Sigil of The Curator - 82217
	AddPet(82217, 60170, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82217, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82217, A_CUSTOM, 46)
	
	-- Sigil of The Evalcharr - 81867
	AddPet(81867, 59823, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81867, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81867, A_CUSTOM, 46)
	
	-- Sigil of The Harbringer - 84310
	AddPet(84310, 72759, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84310, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84310, A_CUSTOM, 46)
	
	-- Sigil of The Husk - 81594
	AddPet(81594, 56987, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81594, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81594, A_CUSTOM, 46)
	
	-- Sigil of The Lich King - 83150
	AddPet(83150, 67910, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83150, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83150, A_CUSTOM, 46)
	
	-- Sigil of The Lurker Below - 82460
	AddPet(82460, 63339, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82460, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82460, A_CUSTOM, 46)
	
	-- Sigil of The Maker - 82287
	AddPet(82287, 60950, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82287, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82287, A_CUSTOM, 46)
	
	-- Sigil of The Nightmare Before Winter Veil - 83878
	AddPet(83878, 71124, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83878, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83878, A_CUSTOM, 46)
	
	-- Sigil of The Odd One - 84312
	AddPet(84312, 72761, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84312, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84312, A_CUSTOM, 46)
	
	-- Sigil of The Ongar - 82110
	AddPet(82110, 60067, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82110, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82110, A_CUSTOM, 46)
	
	-- Sigil of The Prophet Skeram - 84319
	AddPet(84319, 72768, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84319, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84319, A_CUSTOM, 46)
	
	-- Sigil of The Prophet Skeram - 84318
	AddPet(84318, 72767, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84318, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84318, A_CUSTOM, 46)
	
	-- Sigil of The Prophet Skeram - 84317
	AddPet(84317, 72766, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84317, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84317, A_CUSTOM, 46)
	
	-- Sigil of The Prophet Skeram - 84248
	AddPet(84248, 72596, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84248, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84248, A_CUSTOM, 46)
	
	-- Sigil of The Prophet Skeram - 82170
	AddPet(82170, 60126, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82170, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82170, A_CUSTOM, 46)
	
	-- Sigil of The Rake - 81738
	AddPet(81738, 57681, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81738, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81738, A_CUSTOM, 46)
	
	-- Sigil of The Ravenian - 81956
	AddPet(81956, 59913, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81956, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81956, A_CUSTOM, 46)
	
	-- Sigil of The Razza - 82007
	AddPet(82007, 59964, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82007, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82007, A_CUSTOM, 46)
	
	-- Sigil of The Reak - 81839
	AddPet(81839, 59137, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81839, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81839, A_CUSTOM, 46)
	
	-- Sigil of The Rot - 82079
	AddPet(82079, 60036, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82079, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82079, A_CUSTOM, 46)
	
	-- Sigil of The Unforgiven - 81959
	AddPet(81959, 59916, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81959, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81959, A_CUSTOM, 46)
	
	-- Sigil of Theka the Martyr - 81812
	AddPet(81812, 58862, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81812, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81812, A_CUSTOM, 46)
	
	-- Sigil of Thora Feathermoon - 81735
	AddPet(81735, 57678, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81735, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81735, A_CUSTOM, 46)
	
	-- Sigil of Thorngrin the Tender - 82329
	AddPet(82329, 61565, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82329, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82329, A_CUSTOM, 46)
	
	-- Sigil of Thrall - 84346
	AddPet(84346, 72885, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84346, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84346, A_CUSTOM, 46)
	
	-- Sigil of Thrall - 81702
	AddPet(81702, 57645, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81702, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81702, A_CUSTOM, 46)
	
	-- Sigil of Threggil - 82121
	AddPet(82121, 60078, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82121, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82121, A_CUSTOM, 46)
	
	-- Sigil of Thunderstomp - 81750
	AddPet(81750, 57900, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81750, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81750, A_CUSTOM, 46)
	
	-- Sigil of Thuros Lightfingers - 81066
	AddPet(81066, 103725, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81066, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81066, A_CUSTOM, 46)
	
	-- Sigil of Tichondrius - 83506
	AddPet(83506, 69383, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83506, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83506, A_CUSTOM, 46)
	
	-- Sigil of Tidelord Rrurgaz - 82242
	AddPet(82242, 60195, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82242, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82242, A_CUSTOM, 46)
	
	-- Sigil of Tilian - 84167
	AddPet(84167, 72295, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84167, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84167, A_CUSTOM, 46)
	
	-- Sigil of Timber - 81564
	AddPet(81564, 56956, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81564, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81564, A_CUSTOM, 46)
	
	-- Sigil of Time-Lost Proto Drake - 82850
	AddPet(82850, 64272, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82850, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82850, A_CUSTOM, 46)
	
	-- Sigil of Timmy the Cruel - 81972
	AddPet(81972, 59929, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81972, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81972, A_CUSTOM, 46)
	
	-- Sigil of Tinkerer Gizlock - 82058
	AddPet(82058, 60015, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82058, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82058, A_CUSTOM, 46)
	
	-- Sigil of Toravon the Ice Watcher - 83240
	AddPet(83240, 68605, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83240, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83240, A_CUSTOM, 46)
	
	-- Sigil of Tormented Spirit - 81574
	AddPet(81574, 56966, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81574, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81574, A_CUSTOM, 46)
	
	-- Sigil of Tregla - 82268
	AddPet(82268, 60572, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82268, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82268, A_CUSTOM, 46)
	
	-- Sigil of Trigore the Lasher - 81652
	AddPet(81652, 57595, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81652, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81652, A_CUSTOM, 46)
	
	-- Sigil of Trollgore - 82590
	AddPet(82590, 64013, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82590, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82590, A_CUSTOM, 46)
	
	-- Sigil of Tsuzee - 81999
	AddPet(81999, 59956, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81999, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81999, A_CUSTOM, 46)
	
	-- Sigil of Tsunis - 81060
	AddPet(81060, 103723, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81060, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81060, A_CUSTOM, 46)
	
	-- Sigil of Tukemuth - 82832
	AddPet(82832, 64254, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82832, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82832, A_CUSTOM, 46)
	
	-- Sigil of Tutenkash - 81816
	AddPet(81816, 58870, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81816, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81816, A_CUSTOM, 46)
	
	-- Sigil of Twilight Lord Everun - 82136
	AddPet(82136, 60093, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82136, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82136, A_CUSTOM, 46)
	
	-- Sigil of Twilight Lord Kelris - 84329
	AddPet(84329, 72778, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84329, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84329, A_CUSTOM, 46)
	
	-- Sigil of Twilight Lord Kelris - 81698
	AddPet(81698, 57641, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81698, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81698, A_CUSTOM, 46)
	
	-- Sigil of Tyrande Whisperwind - 84352
	AddPet(84352, 73074, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84352, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84352, A_CUSTOM, 46)
	
	-- Sigil of Tyrande Whisperwind - 81825
	AddPet(81825, 59056, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81825, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81825, A_CUSTOM, 46)
	
	-- Sigil of Uhkloc - 81791
	AddPet(81791, 58781, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81791, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81791, A_CUSTOM, 46)
	
	-- Sigil of Unbound dryad PH Hyjal - 84102
	AddPet(84102, 72128, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84102, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84102, A_CUSTOM, 46)
	
	-- Sigil of Urok Doomhowl - 81963
	AddPet(81963, 59920, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81963, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81963, A_CUSTOM, 46)
	
	-- Sigil of Ursollok - 82031
	AddPet(82031, 59988, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82031, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82031, A_CUSTOM, 46)
	
	-- Sigil of Uruson - 82117
	AddPet(82117, 60074, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82117, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82117, A_CUSTOM, 46)
	
	-- Sigil of Vaelastrasz the Corrupt - 84234
	AddPet(84234, 72572, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84234, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84234, A_CUSTOM, 46)
	
	-- Sigil of Vaelastrasz the Corrupt - 82054
	AddPet(82054, 60011, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82054, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82054, A_CUSTOM, 46)
	
	-- Sigil of Vanndar Stormpike - 82022
	AddPet(82022, 59979, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82022, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82022, A_CUSTOM, 46)
	
	-- Sigil of Varothens Ghost - 81777
	AddPet(81777, 58227, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81777, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81777, A_CUSTOM, 46)
	
	-- Sigil of Varos Cloudstrider - 82613
	AddPet(82613, 64036, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82613, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82613, A_CUSTOM, 46)
	
	-- Sigil of Vazruden - 82295
	AddPet(82295, 61025, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82295, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82295, A_CUSTOM, 46)
	
	-- Sigil of Vectus - 81943
	AddPet(81943, 59899, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81943, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81943, A_CUSTOM, 46)
	
	-- Sigil of Vem - 84267
	AddPet(84267, 72716, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84267, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84267, A_CUSTOM, 46)
	
	-- Sigil of Vem - 82206
	AddPet(82206, 60159, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82206, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82206, A_CUSTOM, 46)
	
	-- Sigil of Vengeful Ancient - 81678
	AddPet(81678, 57621, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81678, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81678, A_CUSTOM, 46)
	
	-- Sigil of Veras Darkshadow - 84357
	AddPet(84357, 73079, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84357, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84357, A_CUSTOM, 46)
	
	-- Sigil of Veras Darkshadow - 82506
	AddPet(82506, 63929, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82506, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82506, A_CUSTOM, 46)
	
	-- Sigil of Verdan the Everliving - 81724
	AddPet(81724, 57667, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81724, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81724, A_CUSTOM, 46)
	
	-- Sigil of Verek - 81883
	AddPet(81883, 59839, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81883, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81883, A_CUSTOM, 46)
	
	-- Sigil of Verifonix - 82142
	AddPet(82142, 60098, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82142, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82142, A_CUSTOM, 46)
	
	-- Sigil of Vesperon - 82739
	AddPet(82739, 64162, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82739, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82739, A_CUSTOM, 46)
	
	-- Sigil of Vexallus - 82549
	AddPet(82549, 63972, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82549, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82549, A_CUSTOM, 46)
	
	-- Sigil of Veyzhak the Cannibal - 81715
	AddPet(81715, 57658, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81715, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81715, A_CUSTOM, 46)
	
	-- Sigil of Vigdis the War Maiden - 82830
	AddPet(82830, 64252, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82830, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82830, A_CUSTOM, 46)
	
	-- Sigil of Vile Sting - 81775
	AddPet(81775, 58223, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81775, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81775, A_CUSTOM, 46)
	
	-- Sigil of Viscidus - 84251
	AddPet(84251, 72600, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84251, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84251, A_CUSTOM, 46)
	
	-- Sigil of Viscidus - 82173
	AddPet(82173, 60129, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82173, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82173, A_CUSTOM, 46)
	
	-- Sigil of Viscous Fallout - 81805
	AddPet(81805, 58853, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81805, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81805, A_CUSTOM, 46)
	
	-- Sigil of Void Reaver - 84358
	AddPet(84358, 73080, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84358, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84358, A_CUSTOM, 46)
	
	-- Sigil of Void Reaver - 82405
	AddPet(82405, 62444, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82405, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82405, A_CUSTOM, 46)
	
	-- Sigil of Voidhunter Yar - 82369
	AddPet(82369, 62041, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82369, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82369, A_CUSTOM, 46)
	
	-- Sigil of Voljin - 84347
	AddPet(84347, 72927, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84347, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84347, A_CUSTOM, 46)
	
	-- Sigil of Voljin - 81960
	AddPet(81960, 59917, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81960, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81960, A_CUSTOM, 46)
	
	-- Sigil of Volchan - 81913
	AddPet(81913, 59869, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81913, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81913, A_CUSTOM, 46)
	
	-- Sigil of Volkhan - 82669
	AddPet(82669, 64092, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82669, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82669, A_CUSTOM, 46)
	
	-- Sigil of Vorakem Doomspeaker - 82365
	AddPet(82365, 61933, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82365, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82365, A_CUSTOM, 46)
	
	-- Sigil of Vultros - 81529
	AddPet(81529, 103729, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81529, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81529, A_CUSTOM, 46)
	
	-- Sigil of VX-001 - 82917
	AddPet(82917, 64432, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82917, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82917, A_CUSTOM, 46)
	
	-- Sigil of VX-001 (1) - 82945
	AddPet(82945, 65398, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82945, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82945, A_CUSTOM, 46)
	
	-- Sigil of Vyragosa - 82861
	AddPet(82861, 64283, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82861, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82861, A_CUSTOM, 46)
	
	-- Sigil of War Golem - 81631
	AddPet(81631, 57106, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81631, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81631, A_CUSTOM, 46)
	
	-- Sigil of War Master Voone - 81893
	AddPet(81893, 59849, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81893, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81893, A_CUSTOM, 46)
	
	-- Sigil of Warbringer Omrogg - 82265
	AddPet(82265, 60548, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82265, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82265, A_CUSTOM, 46)
	
	-- Sigil of Warchief Kargath Bladefist - 82264
	AddPet(82264, 60547, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82264, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82264, A_CUSTOM, 46)
	
	-- Sigil of Warchief Rend Blackhand - 81941
	AddPet(81941, 59897, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81941, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81941, A_CUSTOM, 46)
	
	-- Sigil of Warder Stilgiss - 81882
	AddPet(81882, 59838, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81882, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81882, A_CUSTOM, 46)
	
	-- Sigil of Warleader Krazzilak - 81827
	AddPet(81827, 59125, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81827, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81827, A_CUSTOM, 46)
	
	-- Sigil of Warlord Kalithresh - 82308
	AddPet(82308, 61286, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82308, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82308, A_CUSTOM, 46)
	
	-- Sigil of Warlord Kolkanis - 81739
	AddPet(81739, 57759, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81739, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81739, A_CUSTOM, 46)
	
	-- Sigil of Warlord Threshjin - 81982
	AddPet(81982, 59939, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81982, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81982, A_CUSTOM, 46)
	
	-- Sigil of Warp Splinter - 82328
	AddPet(82328, 61563, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82328, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82328, A_CUSTOM, 46)
	
	-- Sigil of Watch Commander Zalaphil - 81740
	AddPet(81740, 57760, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81740, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81740, A_CUSTOM, 46)
	
	-- Sigil of Watchkeeper Gargolmar - 82283
	AddPet(82283, 60946, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82283, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82283, A_CUSTOM, 46)
	
	-- Sigil of Weaver - 81721
	AddPet(81721, 57664, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81721, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81721, A_CUSTOM, 46)
	
	-- Sigil of Wep - 81927
	AddPet(81927, 59883, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81927, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81927, A_CUSTOM, 46)
	
	-- Sigil of Widowed Murloc Queen - 83313
	AddPet(83313, 68738, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83313, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83313, A_CUSTOM, 46)
	
	-- Sigil of Witch Doctor Zumrah - 81811
	AddPet(81811, 58861, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81811, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81811, A_CUSTOM, 46)
	
	-- Sigil of Witherheart the Stalker - 81845
	AddPet(81845, 59339, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81845, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81845, A_CUSTOM, 46)
	
	-- Sigil of Wolf Master Nandos - 81671
	AddPet(81671, 57614, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81671, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81671, A_CUSTOM, 46)
	
	-- Sigil of Wrath-Scryer Soccothrates - 82449
	AddPet(82449, 63294, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82449, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82449, A_CUSTOM, 46)
	
	-- Sigil of Wushoolay - 84246
	AddPet(84246, 72594, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84246, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84246, A_CUSTOM, 46)
	
	-- Sigil of Wushoolay - 82163
	AddPet(82163, 60119, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82163, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82163, A_CUSTOM, 46)
	
	-- Sigil of XT-002 Deconstructor - 82896
	AddPet(82896, 64359, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82896, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82896, A_CUSTOM, 46)
	
	-- Sigil of Yoarg Spellfist - 84206
	AddPet(84206, 72543, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 84206, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 84206, A_CUSTOM, 46)
	
	-- Sigil of Yogg-Saron - 82895
	AddPet(82895, 64338, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82895, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82895, A_CUSTOM, 46)
	
	-- Sigil of Yor - 82500
	AddPet(82500, 63512, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82500, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82500, A_CUSTOM, 46)
	
	-- Sigil of Ysera - 83508
	AddPet(83508, 69385, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83508, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83508, A_CUSTOM, 46)
	
	-- Sigil of Ysondre - 82154
	AddPet(82154, 60110, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82154, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82154, A_CUSTOM, 46)
	
	-- Sigil of Zalas Witherbark - 81625
	AddPet(81625, 57055, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81625, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81625, A_CUSTOM, 46)
	
	-- Sigil of Zaricotl - 81638
	AddPet(81638, 57249, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81638, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81638, A_CUSTOM, 46)
	
	-- Sigil of Zaytoven - 83308
	AddPet(83308, 68733, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 83308, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 83308, A_CUSTOM, 46)
	
	-- Sigil of Zekkis - 81716
	AddPet(81716, 57659, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81716, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81716, A_CUSTOM, 46)
	
	-- Sigil of Zereketh the Unbound - 82447
	AddPet(82447, 63289, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82447, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82447, A_CUSTOM, 46)
	
	-- Sigil of Zerillis - 81912
	AddPet(81912, 59868, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81912, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81912, A_CUSTOM, 46)
	
	-- Sigil of Zevrim Thornhoof - 82004
	AddPet(82004, 59961, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82004, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82004, A_CUSTOM, 46)
	
	-- Sigil of Zora - 82131
	AddPet(82131, 60088, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82131, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82131, A_CUSTOM, 46)
	
	-- Sigil of Zularek Hatefowler - 81846
	AddPet(81846, 59360, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81846, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81846, A_CUSTOM, 46)
	
	-- Sigil of ZulBrin Warpbranch - 81983
	AddPet(81983, 59940, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 81983, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 81983, A_CUSTOM, 46)
	
	-- Sigil of Zuldrak Sentinel - 82843
	AddPet(82843, 64265, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82843, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82843, A_CUSTOM, 46)
	
	-- Sigil of Zuljin - 82526
	AddPet(82526, 63949, R_RARE, GAME_ORIG)
	self:AddCompanionFlags(PetDB, 82526, F_ALLIANCE, F_HORDE, F_SIGIL, F_BOE)
	self:AddCompanionAcquire(PetDB, 82526, A_CUSTOM, 46)

-- We only add the faction specific pets if the user is part of that faction
	if MY_FACTION == FACTION_ALLIANCE then
		-- Shimmering Wyrmling -- 66096
		AddPet(66096, 46820, R_RARE, GAME_WOTLK)
		self:AddCompanionFlags(PetDB, 66096, F_ALLIANCE, F_VENDOR, F_BOE, WRATHCOMMON2)
		self:AddCompanionAcquire(PetDB, 66096, A_REPUTATION, 1094, EXALTED, 34881)

	elseif MY_FACTION == FACTION_HORDE then
		-- Shimmering Wyrmling -- 66096
		AddPet(66096, 46821, R_RARE, GAME_WOTLK)
		self:AddCompanionFlags(PetDB, 66096, F_HORDE, F_VENDOR, F_BOE, WRATHCOMMON2)
		self:AddCompanionAcquire(PetDB, 66096, A_REPUTATION, 1124, EXALTED, 34772)
	end
	return num_pets
end
