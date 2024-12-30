CP = LibStub("AceAddon-3.0"):NewAddon("CP", "AceConsole-3.0")
local Media = LibStub("LibSharedMedia-3.0")
local DataBroker = LibStub:GetLibrary("LibDataBroker-1.1",true)
if not TidyPlatesThemeList then TidyPlatesThemeList = {} end
TidyPlatesThemeList["CP"] = {}

local classicon = "Interface\\Addons\\TidyPlates_CleanPlates\\Class\\"
local totem = "Interface\\Addons\\TidyPlates_CleanPlates\\Totem\\"


function CP:OnInitialize()
	local defaults 	= {
		profile = {
			Boss_scale = 1.2,
			Empty_scale = 0.3,
			Elite_scale = 1.1,
			Normal_scale = 0.8,
			Pet_scale = 1,
			Special_scale = 1.2,
			Totem_scale = 0.8,
			classicons = true,
			classiconsHeight = 22,
			classiconsWidth = 22,
			classiconsX = -74,
			classiconsY = -2,
			fcicons = true,
			fctext = true,
			friendlyHealthBarColor = { r = 0, g = 0, b = 0.9, a = 0.9 },
			fullstring = false,
			hptext = true,
			hundtext = false,
			nonTargetAlphaValue = -0.5,
			partyicons = true,
			partyiconsHeight = 22,
			partyiconsWidth = 22,
			partyiconsX = -74,
			partyiconsY = -2,
			petIconsHeight = 22,
			petIconsWidth = 22,
			petIconsX = -74,
			petIconsY = -2,
			selectedEnemyIconArt = "Default",
			selectedPartyIconArt = "Default",
			selectedTargetHighlightArt = "gold",
			showArenaNumbersAsName = false,
			showArenaNumbersAsNameFontSize = 23,
			showArenaNumbersAsNameX = 0,
			showArenaNumbersAsNameY = 23,
			showBeastPetIcon = true,
			showDemonPetIcon = true,
			showUndeadPetIcon = true,
			showElementalPetIcon = true,
			showLevel = true,
			showPetIcons = false,
			showPetNames = true,
			showPlayerNames = true,
			showTargetHighlightArt = false,
			showTotemNames = true,
			showelementals = true,
			showfiends = true,
			showghouls = true,
			showimages = true,
			showsnakes = true,
			showtreants = true,
			showworms = true,
			showwolves = true,
			totemiconsHeight = 26,
			totemiconsWidth = 26,
			totemiconsX = -0,
			totemiconsY = 0,
			totems = true,
			totemList = {
				["Fire Elemental Totem"] = true,
				["Fire Nova Totem IX"] = true,
				["Flametongue Totem VIII"] = true,
				["Frost Resistance Totem VI"] = true,
				["Magma Totem VII"] = true,
				["Searing Totem"] = true,
				["Searing Totem X"] = true,
				["Totem of Wrath IV"] = true,
				["Earth Elemental Totem"] = true,
				["Earthbind Totem"] = true,
				["Stoneclaw Totem X"] = true,
				["Stoneskin Totem X"] = true,
				["Strength of Earth"] = true,
				["Strength of Earth Totem VIII"] = true,
				["Tremor Totem"] = true,
				["Cleansing Totem"] = true,
				["Fire Resistance Totem VI"] = true,
				["Healing Stream Totem"] = true,
				["Healing Stream Totem IX"] = true,
				["Mana Spring Totem VIII"] = true,
				["Mana Tide Totem"] = true,
				["Grounding Totem"] = true,
				["Nature Resistance Totem VI"] = true,
				["Sentry Totem"] = true,
				["Windfury Totem"] = true,
				["Wrath of Air Totem"] = true
			},
			bossShow = {
				["Marked Immortal Guardian"] = true,
				["Immortal Guardian"] = true,
				["Onyxian Whelp"] = true
			},
			bossSpecial = {
				["Marked Immortal Guardian"] = true,
				["Immortal Guardian"] = false
			},
			bossThreatLow = {
				["Onyxian Whelp"] = true
			},
			bossThreatMed = {
				["Onyxian Whelp"] = true
			},
			bossThreatHigh = {
				["Onyxian Whelp"] = true
			}
		}
    }

	self.db = LibStub("AceDB-3.0"):New("CPDB", defaults)
	self:CreateNormalStyleConfig()
	self:CreatePetStyleConfig()
	self:CreateTotemStyleConfig()
	self:CreateEmptyStyleConfig()
	self:CreateSpecialStyleConfig()
	self:SetupOptions()

	self.message = "Welcome to Tidy Plates: Clean Plates theme by Syronius! |cff00ffff/Type cp for additional options!|r"
end

--[[CP - Tidy Plates Theme]]--
local classByColor = {
C285 = "DEATHKNIGHT",
C390 = "DRUID",
C498 = "HUNTER",
C549 = "MAGE",
C571 = "PALADIN",
C768 = "PRIEST",	
C605 = "ROGUE",	
C335 = "SHAMAN",	
C479 = "WARLOCK",
C465 = "WARRIOR",
--C256 = "Npc",
}

function SetPetIcons(unit)
	if not CP.db.profile.showPetIcons then 
		return nil 
	end
	if (unit.type ~= "NPC") then 
		return nil	
	end
	if (unit.name == "Spirit Wolf") then 
		return nil	
	end
	if (unit.name == "Treant") then 
		return nil	
	end
	
	-- Mirror images spawns with same name as player
	local _, class = UnitClass(unit.name)
	local creatureType = UnitCreatureType(unit.name)
	-- Prevent pet icons for Mage's Mirror Images, but allow Water Ele + Warlock pets (Voidwalker and Succubus) to retain their icons
	if (class =="MAGE" and unit.type == "NPC" and unit.name ~= "Water Elemental" and creatureType ~= "Demon") then  
		return nil 
	end

	local db = CP.db.profile
	-- NOTE: Humanoid must be true for player pets with the same name as players to receive icons. Only hunters can name their pets, so they share the "Beast" state.
    local validTypes = { Beast = db.showBeastPetIcon, Demon = db.showDemonPetIcon, Elemental = db.showElementalPetIcon, Undead = db.showUndeadPetIcon, Humanoid = db.showBeastPetIcon }

    if validTypes[creatureType] then
        return classicon .. "Pets\\Pet"
    end
end

function SetPartyIcons(unit)
	if not CP.db.profile.partyicons then 
		return nil 
	end
	 -- NOTE: `unit.type == "NPC"` is required to prevent party icons from appearing on player pets with the same name as players.
	if unit.reaction ~= "FRIENDLY" or unit.type == "NPC" then
        return nil
    end
	-- NOTE: Only proceed if the unit is a player and is in the party or raid.
	if not UnitIsPlayer(unit.name) then
        return nil
    end

    -- Attempt to get the class icon path
	local _, class = UnitClass(unit.name)
    if class then
        return classicon .. CP.db.profile.selectedPartyIconArt .."\\" .. class
    end
    return nil
end

function SetAlpha(unit)
	local nonTargetAlpha

	if not unit.isTarget and UnitExists("target") then
		nonTargetAlpha = CP.db.profile.nonTargetAlphaValue
	else
		nonTargetAlpha = 0
	end

	return (1 + nonTargetAlpha), true
end

function SetSpecialArt(unit)
--[[Totem Icons]]--
	if CP.db.profile.totems then
	--[[Totems]]--
		if unit.name == "Tremor Totem"
			or unit.name == "Cleansing Totem"
			or unit.name == "Grounding Totem"
			or unit.name == "Windfury Totem"
			or unit.name == "Wrath of Air Totem"
			or unit.name == "Earthbind Totem"
			or unit.name == "Mana Tide Totem"
			or unit.name == "Sentry Totem"
			or unit.name == "Fire Elemental Totem"
			or unit.name == "Earth Elemental Totem"
			or unit.name == "Nature Resistance Totem VI"
			or unit.name == "Frost Resistance Totem VI"
			or unit.name == "Fire Resistance Totem VI"
			or unit.name == "Searing Totem X"
			or unit.name == "Magma Totem VII"
			or unit.name == "Fire Nova Totem IX"
			or unit.name == "Flametongue Totem VIII"
			or unit.name == "Totem of Wrath IV"
			or unit.name == "Stoneclaw Totem X"
			or unit.name == "Stoneskin Totem X"
			or unit.name == "Strength of Earth Totem VIII"
			or unit.name == "Healing Stream Totem IX"
			or unit.name == "Mana Spring Totem VIII" then
				if CP.db.profile.totemList[unit.name] then
					return totem..unit.name
				else return ""
				end
	--[[Faction Champs Totems]]--[[Windfury, Grounding, and Tremor are the same name as player totems]]--
		elseif unit.name == "Healing Stream Totem" then
			if CP.db.profile.totemList[unit.name] then
				return totem.."Healing Stream Totem IX"
			else return ""
			end
		elseif unit.name == "Searing Totem" then --[[Added v1.4]]--
			if CP.db.profile.totemList[unit.name] then
				return totem.."Searing Totem X"
			else return ""
			end
		elseif unit.name == "Strength of Earth" then --[[Unofficial]]--
			if CP.db.profile.totemList[unit.name] then
				return totem.."Strength of Earth Totem VIII"
			else return ""
			end
		end
	end
--[[Enable FC Icons]]--
	if CP.db.profile.fcicons and CP.db.profile.classicons then
	--[[Shaman]]--
		if unit.name == "Shaabad" or unit.name == "Saamul" or unit.name == "Broln Stouthorn" or unit.name == "Thrakgar" then
				return classicon.."SHAMAN"
	--[[Paladins]]--
			elseif unit.name == "Velanaa" or unit.name == "Baelnor Lightbearer" or unit.name == "Liandra Suncaller" or unit.name == "Malithas Brightblade" then
				return classicon.."PALADIN"
	--[[Druids]]--
			elseif unit.name == "Kavina Grovesong" or unit.name == "Melador Valestrider" or unit.name == "Birana Stormhoof" or unit.name == "Erin Misthoof" then
				return classicon.."DRUID"
	--[[Priests]]--
			elseif unit.name == "Anthar Forgemender" or unit.name == "Brienna Nightfell" or unit.name == "Caiphus the Stern" or unit.name == "Vivienne Blackwhisper" then
				return classicon.."PRIEST"
	--[[Warlocks]]--
			elseif unit.name == "Serissa Grimdabbler" or unit.name == "Harkzog" then
				return classicon.."WARLOCK"
	--[[Warriors]]--
			elseif unit.name == "Shocuul" or unit.name == "Narrhok Steelbreaker" then
				return classicon.."WARRIOR"
	--[[Rogues]]--
			elseif unit.name == "Irieth Shadowstep" or unit.name == "Maz'dinah" then
				return classicon.."ROGUE"
	--[[Death Knights]]--
			elseif unit.name == "Tyrius Duskblade" or unit.name == "Gorgrim Shadowcleave" then
				return classicon.."DEATHKNIGHT"
	--[[Hunters]]--
			elseif unit.name == "Alyssia Moonstalker" or unit.name == "Ruj'kah" then
				return classicon.."HUNTER"
	--[[Mages]]--
			elseif unit.name == "Noozle Whizzlestick" or unit.name == "Ginselle Blightslinger" then
				return classicon.."MAGE"
			end
	end
--[[Enable Class Icons PvP]]--
	if CP.db.profile.classicons then
--[[PvP Class Icons]]--		
		if unit.reaction == "HOSTILE" then
				local r = ceil(unit.red*256)
				local g = ceil(unit.green*256)
				local b = ceil(unit.blue*256)
				local class = nil
				local index = 0
				for index = -2, 3 do
					class = classByColor["C"..(r+g+b+index)]
					if class then return classicon .. CP.db.profile.selectedEnemyIconArt .."\\" .. class end
				end	
		end
	end 
	return nil
end
--[[Health Truncate Function]]--
local Truncate = function(value)
	if value >= 1e6 then
		return format('%.1fm', value / 1e6)
	elseif value >= 1e4 then
		return format('%.1fk', value / 1e3)
	else
		return value
	end
end
--[[Special Text]]--
function SetSpecialText(unit)
	if CP.db.profile.hptext then
		healthpercent = 100* (unit.health / unit.healthmax) 				--[[Creates the health percentage number]]--
		hpstring = Truncate(unit.health).." - "
		if (unit.health / unit.healthmax) < 1 then 							--[[If Health is less than 100%]]--
			return Truncate(unit.health).." - "..ceil(healthpercent ).."%" 	--[[Display Truncated HP Amount and Percentage]]--
		else 																--[[If HP is 100%]]--
			if CP.db.profile.hundtext then
				if CP.db.profile.fullstring then
					return hpstring..ceil(healthpercent ).."%"				--[[Display Nothing or Optional 100% text]]--
				else 
					return Truncate(unit.health)
				end
			else 
				return ""
			end
		end
	else return ""
	end
end

function SetSpecialText3(unit) --[[Faction Champs Class Spec]]--
	if CP.db.profile.fctext then
	--[[Shaman]]--
		if unit.name == "Shaabad" or unit.name == "Broln Stouthorn" then
			return "|cffff0000ENH|r"
		elseif unit.name == "Saamul" or unit.name == "Thrakgar" then
			return "|cff00ff00RESTO|r"
	--[[Paladins]]--
		elseif unit.name == "Velanaa" or unit.name == "Liandra Suncaller" then
			return "|cff00ff00HOLY|r"
		elseif  unit.name == "Baelnor Lightbearer" or unit.name == "Malithas Brightblade" then
			return "|cffff0000RET|r"
	--[[Druids]]--
		elseif unit.name == "Kavina Grovesong" or unit.name == "Birana Stormhoof" then
			return "|cff00ff00BAL|r"
		elseif unit.name == "Melador Valestrider" or unit.name == "Erin Misthoof" then
			return "|cffff0000RESTO|r"
	--[[Priests]]--
		elseif unit.name == "Anthar Forgemender" or unit.name == "Caiphus the Stern" then
			return "|cff00ff00DISC|r"
		elseif unit.name == "Brienna Nightfell" or unit.name == "Vivienne Blackwhisper" then
			return "|cffff0000SHDW|r"
		end
	else return ""
	end
end

--[[Set Style with conditionals]]--
function SetStyle(unit)
	if unit.name == "Tremor Totem"
			or unit.name == "Cleansing Totem"
			or unit.name == "Grounding Totem"
			or unit.name == "Windfury Totem"
			or unit.name == "Wrath of Air Totem"
			or unit.name == "Earthbind Totem"
			or unit.name == "Mana Tide Totem"
			or unit.name == "Sentry Totem"
			or unit.name == "Fire Elemental Totem"
			or unit.name == "Earth Elemental Totem"
			or unit.name == "Nature Resistance Totem VI"
			or unit.name == "Frost Resistance Totem VI"
			or unit.name == "Fire Resistance Totem VI"
			or unit.name == "Searing Totem X"
			or unit.name == "Magma Totem VII"
			or unit.name == "Fire Nova Totem IX"
			or unit.name == "Flametongue Totem VIII"
			or unit.name == "Totem of Wrath IV"
			or unit.name == "Stoneclaw Totem X"
			or unit.name == "Stoneskin Totem X"
			or unit.name == "Strength of Earth Totem VIII"
			or unit.name == "Healing Stream Totem IX"
			or unit.name == "Mana Spring Totem VIII"
		--[[Faction Champs]]--
			or unit.name == "Healing Stream Totem"
			or unit.name == "Searing Totem"
			or unit.name == "Strength of Earth"
	then 
		if CP.db.profile.showtotems and CP.db.profile.totemList[unit.name] then
				return "totem"
			else return "empty"
		end
	elseif unit.name == "Bloodworm" then
		if CP.db.profile.showworms then
				return "pet"
			else return "empty"
		end
	elseif unit.name == "Viper" or unit.name == "Venomous Snake" then
		if CP.db.profile.showsnakes then
				return "pet"
			else return "empty"
		end	
	elseif unit.name == "Spirit Wolf" then
		if CP.db.profile.showwolves then
				return "pet"
			else return "empty"
		end
	elseif unit.name == "Treant" then
		if CP.db.profile.showtreants then
				return "pet"
			else return "empty"
		end
	elseif unit.name == "Mirror Image" then
		if CP.db.profile.showimages then
				return "pet"
			else return "empty"
		end
	elseif unit.name == "Shadowfiend" then
		if CP.db.profile.showfiends then
				return "pet"
			else return "empty"
		end
	elseif unit.name == "Water Elemental" then
		if CP.db.profile.showelementals then
				return "pet"
			else return "empty"
		end
	elseif unit.name == "Army of the Dead Ghoul" then
		if CP.db.profile.showghouls then
				return "pet"
			else return "empty"
		end
	--[[Boss Encounters]]--
	elseif unit.name == "Immortal Guardian" then
		if CP.db.profile.bossShow[unit.name] then
			if CP.db.profile.bossSpecial[unit.name] then
				return "special"
			else 
				return "normal"
			end
		else return "empty"
		end
	elseif unit.name == "Marked Immortal Guardian" then
		if CP.db.profile.bossShow[unit.name] then
			if CP.db.profile.bossSpecial[unit.name] then
				return "special"
			else 
				return "normal"
			end
		else return "empty"
		end
	elseif unit.name == "Onyxian Whelp" then
		if CP.db.profile.bossShow[unit.name] then
			if unit.threatSituation == "LOW" and CP.db.profile.bossThreatLow then
				return "pet"
			elseif unit.threatSituation == "MEDIUM" and CP.db.profile.bossThreatMed then
				return "pet"
			elseif unit.threatSituation == "HIGH" and CP.db.profile.bossThreatHigh then
				return "pet"
			else return "empty"
			end
		else return "empty"
		end
--[[All Else]]--
	else 
		local _, class = UnitClass(unit.name)
		local creatureType = UnitCreatureType(unit.name)
		-- Apply "pet" style to Mage's Mirror Images and exclude Warlock pets (Succubus and Voidwalker) from adopting the "pet" style.
		if class == "MAGE" and unit.type == "NPC" and creatureType ~= "Demon" then  
			return CP.db.profile.showimages and "pet" or "empty"
		end

		return "normal"
	end
end

--[[Scaling]]--
function SetScale(unit)
	if SetStyle(unit) == "normal" then
		if unit.isElite and not unit.isDangerous then
			return CP.db.profile.Elite_scale
		elseif unit.isElite and unit.isDangerous then
			return CP.db.profile.Boss_scale
		else
			return CP.db.profile.Normal_scale
		end
	elseif SetStyle(unit) == "pet" then
		return CP.db.profile.Pet_scale
	elseif SetStyle(unit) == "totem" then
		return CP.db.profile.Totem_scale
	elseif SetStyle(unit) == "special" then
		return CP.db.profile.Special_scale
	elseif SetStyle(unit) == "empty" then
		return CP.db.profile.Empty_scale
	else return 1
	end
end

function SetHealthbarColor(unit, bars)	
	if unit.reaction == "FRIENDLY" and unit.type == "PLAYER" then
		return CP.db.profile.friendlyHealthBarColor.r, CP.db.profile.friendlyHealthBarColor.g, CP.db.profile.friendlyHealthBarColor.b, CP.db.profile.friendlyHealthBarColor.a
	 else
		return bars.health:GetStatusBarColor()
	end
end

--[[Auto Config Player WoW Settings]]--
SetCVar("threatWarning", 3)
SetCVar("nameplateShowEnemies", 1)
SetCVar("ShowClassColorInNameplate", 1)
--[[Set Styles]]--

TidyPlatesThemeList["CP"].SetStyle = SetStyle
TidyPlatesThemeList["CP"].SetAlpha = SetAlpha
TidyPlatesThemeList["CP"].SetSpecialText = SetSpecialText
TidyPlatesThemeList["CP"].SetSpecialText3 = SetSpecialText3
TidyPlatesThemeList["CP"].SetPartyIcons = SetPartyIcons
TidyPlatesThemeList["CP"].SetPetIcons = SetPetIcons
TidyPlatesThemeList["CP"].SetSpecialArt = SetSpecialArt
TidyPlatesThemeList["CP"].SetScale = SetScale
TidyPlatesThemeList["CP"].SetHealthbarColor = SetHealthbarColor