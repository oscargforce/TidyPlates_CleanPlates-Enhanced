
local Media = LibStub("LibSharedMedia-3.0")
local DataBroker = LibStub:GetLibrary("LibDataBroker-1.1",true)
local config = {}
local texture = "Interface\\Addons\\TidyPlates_CleanPlates\\Artwork\\"
local font = "Interface\\Addons\\TidyPlates_CleanPlates\\Fonts\\"
local BarTexture = texture.."CP_Bartexture"

--[[CP - Tidy Plates Theme]]--
--[[Textures]]--

config.frame = {
	width = 124,
	height = 30,
}

config.threatborder = {
	texture =						texture.."CP_Threat",
	elitetexture =					texture.."CP_Threat",
	width = 256,
	height = 64,
	x = 0,
	y = 5,
	anchor = "CENTER",
}
config.healthborder = {
	texture = 						texture.."CP_HealthBarOverlay",
	glowtexture = 					texture.."CP_HealthBarHighlight",
	elitetexture = 					texture.."CP_HealthBarEliteOverlay",
	width = 256,
	height = 64,
	x = 0,
	y = 5,
	anchor = "CENTER",
}
config.castborder = {
	texture = 						texture.."CP_CastBarOverlay",
	width = 256,
	height = 64,
	x = 0,
	y = -10,
	anchor = "CENTER",
}

config.castnostop = {
	texture =						texture.."CP_CastBarLock",
	width = 256,
	height = 64,
	x = 0,
	y = -10,
	anchor = "CENTER",
}
--[[Bar Textures]]--
config.healthbar = {
	texture =						BarTexture,
	width = 120,
	height = 10,
	x = 0,
	y = 5,
	anchor = "CENTER",
	orientation = "HORIZONTAL",
}
config.castbar = {
	texture =						BarTexture,
	width = 120,
	height = 10,
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
	LOW = { r = 1, g = 1, b = 1, a = 1 },
	MEDIUM = { r = 1, g = 1, b = 0, a = 1 },
	HIGH = { r = 1, g = 0, b = 0, a = 1 },
}
config.options = {
	showLevel = true,
	showName = true,
	showPartyIcons = true,
	showSpecialArt = true,
	showSpecialText = true,
	showSpecialText2 = true,
	showSpecialText3 = true,
	showDangerSkull = true,
	showspellIcon = true,
	showNostopSpell = true,
}

TidyPlatesThemeList["CP"]["normal"] = {}
TidyPlatesThemeList["CP"]["normal"] = config