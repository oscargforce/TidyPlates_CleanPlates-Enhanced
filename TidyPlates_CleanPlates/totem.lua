
local Media = LibStub("LibSharedMedia-3.0")
local DataBroker = LibStub:GetLibrary("LibDataBroker-1.1",true)
local texture = "Interface\\Addons\\TidyPlates_CleanPlates\\Artwork\\"
local font = "Interface\\Addons\\TidyPlates_CleanPlates\\Fonts\\"

--[[CP - Tidy Plates Theme]]--
--[[Textures]]--

function CP:CreateTotemStyleConfig()
	local db = self.db.profile
	local config = {}

	config.frame = {
		width = 50,
		height = 50,
	}
	
	config.threatborder = {
		texture =						texture.."Empty",
		elitetexture =					texture.."Empty",
		width = 44,
		height = 16,
		x = 0,
		y = 5,
		anchor = "CENTER",
	}
	config.healthborder = {
		texture = 						texture.."CP_PetOverlay",
		glowtexture = 					texture.."CP_PetHighlight",
		width = 256,
		height = 64,
		x = 0,
		y = -25,
		anchor = "CENTER",
	}
	config.castborder = {
		texture = 						texture.."CP_PetOverlay",
		width = 256,
		height = 64,
		x = 0,
		y = -40,
		anchor = "CENTER",
	}
	
	config.castnostop = {
		texture =						texture.."CP_PetOverlay",
		width = 256,
		height = 64,
		x = 0,
		y = -40,
		anchor = "CENTER",
	}
	--[[Bar Textures]]--
	config.healthbar = {
		texture =						texture.."CP_BarTexture",
		width = 40,
		height = 6,
		x = 0,
		y = -25,
		anchor = "CENTER",
		orientation = "HORIZONTAL",
	}
	
	config.castbar = {
		texture =						texture.."CP_BarTexture",
		width = 40,
		height = 6,
		x = 0,
		y = -40,
		anchor = "CENTER",
		orientation = "HORIZONTAL",
	}
	--[[TEXT]]--
	
	config.name = {
		typeface =						font.."Accidental Presidency.ttf",
		size = 8,
		width = 105,
		height = 14,
		x = 0,
		y = -15,
		align = "CENTER",
		anchor = "CENTER",
		vertical = "CENTER",
		shadow = true,
	}
	config.level = {
		typeface =						font.."Accidental Presidency.ttf",
		size = 12,
		width = 20,
		height = 14,
		x = 50,
		y = -25,
		align = "RIGHT",
		anchor = "CENTER",
		vertical = "TOP",
		shadow = true,
	}
	config.specialText2 = {
		typeface =						font.."Accidental Presidency.ttf",
		size = 12,
		width = 90,
		height = 14,
		x = 0,
		y = -8,
		align = "CENTER",
		anchor = "CENTER",
		vertical = "CENTER",
		shadow = true,
	}
	config.specialText3 = {
		typeface =						font.."Accidental Presidency.ttf",
		size = 12,
		width = 90,
		height = 14,
		x = -30,
		y = 18,
		align = "LEFT",
		anchor = "CENTER",
		vertical = "CENTER",
		shadow = true,
	}
	config.specialText3 = {
		typeface =						font.."Accidental Presidency.ttf",
		size = 12,
		width = 90,
		height = 14,
		x = 0,
		y = -8,
		align = "CENTER",
		anchor = "CENTER",
		vertical = "CENTER",
		shadow = true,
	}
	--[[ICONS]]--
	config.dangerskull = {
		width = 14,
		height = 14,
		x = 58,
		y = 17,
		anchor = "CENTER",
	}
	config.specialArt = {
		width = db.totemiconsWidth,
		height = db.totemiconsHeight,
		x = db.totemiconsX,
		y = db.totemiconsY,
		anchor = "CENTER",
	}
	config.partyIcons = {
		width = 22,
		height = 22,
		x = -74,
		y = -2,
		anchor = "CENTER",
	}
	config.spellicon = {
		width = 20,
		height = 20,
		x = 75,
		y = -2,
		anchor = "CENTER",
	}
	config.raidicon = {
		width = 14,
		height = 14,
		x = 0,
		y = 10,
		anchor = "TOP",
	}
	--[[OPTIONS]]--
	config.threatcolor = {
		LOW = { r = 0, g = 0, b = 0, a = 0 },
		MEDIUM = { r = 0, g = 0, b = 0, a = 0 },
		HIGH = { r = 0, g = 0, b = 0, a = 0 },
	}
	config.options = {
		showLevel = false,
		showName = db.showTotemNames,
		showPartyIcons = true,
		showSpecialArt = true,
		showSpecialText = false,
		showSpecialText2 = false,
		showSpecialText3 = true,
		showDangerSkull = false,
		showspellIcon = false,
		showNostopSpell = false,
	}
	
	TidyPlatesThemeList["CP"]["totem"] = {}
	TidyPlatesThemeList["CP"]["totem"] = config
end

