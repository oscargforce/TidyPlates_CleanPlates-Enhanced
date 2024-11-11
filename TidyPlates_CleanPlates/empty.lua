
local Media = LibStub("LibSharedMedia-3.0")
local DataBroker = LibStub:GetLibrary("LibDataBroker-1.1",true)
local config = {}
local texture = "Interface\\Addons\\TidyPlates_CleanPlates\\Artwork\\"
local font = "Interface\\Addons\\TidyPlates_CleanPlates\\Fonts\\"

--[[CP - Tidy Plates Theme]]--
--[[Textures]]--

config.frame = {
	width = 2,
	height = 2,
}

config.threatborder = {
	texture =						texture.."Empty",
	width = 256,
	height = 64,
	x = 0,
	y = 5,
	anchor = "CENTER",
}
config.healthborder = {
	texture = 						texture.."Empty",
	glowtexture = 					texture.."Empty",
	elitetexture = 					texture.."Empty",
	width = 256,
	height = 64,
	x = 0,
	y = 5,
	anchor = "CENTER",
}
config.castborder = {
	texture = 						texture.."Empty",
	width = 256,
	height = 64,
	x = 0,
	y = -10,
	anchor = "CENTER",
}

config.castnostop = {
	texture =						texture.."Empty",
	width = 256,
	height = 64,
	x = 0,
	y = -10,
	anchor = "CENTER",
}
--[[Bar Textures]]--
config.healthbar = {
	texture =						texture.."Empty",
	width = 122,
	height = 12,
	x = 0,
	y = 5,
	anchor = "CENTER",
	orientation = "HORIZONTAL",
}

config.castbar = {
	texture =						texture.."Empty",
	width = 122,
	height = 12,
	x = 0,
	y = -10,
	anchor = "CENTER",
	orientation = "HORIZONTAL",
}
--[[TEXT]]--

config.name = {
	typeface =						font.."Accidental Presidency.ttf",
	size = 12,
	width = 105,
	height = 14,
	x = 0,
	y = 18,
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
	y = 5,
	align = "RIGHT",
	anchor = "CENTER",
	vertical = "TOP",
	shadow = true,
}
config.specialText = {
	typeface =						font.."Accidental Presidency.ttf",
	size = 12,
	width = 90,
	height = 14,
	x = 0,
	y = 6,
	align = "CENTER",
	anchor = "CENTER",
	vertical = "CENTER",
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
--[[ICONS]]--
config.dangerskull = {
	width = 14,
	height = 14,
	x = 58, 
	y = 17,
	anchor = "CENTER",
}
config.specialArt = {
	width = 22,
	height = 22,
	x = -74, 
	y = -2, 
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
	y = 17,
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
	showName = false,
	showPartyIcons = false,
	showSpecialArt = false,
	showSpecialText = false,
	showSpecialText2 = false,
	showSpecialText3 = false,
	showDangerSkull = false,
	showspellIcon = false,
	showNostopSpell = false,
}

TidyPlatesThemeList["CP"]["empty"] = {}
TidyPlatesThemeList["CP"]["empty"] = config