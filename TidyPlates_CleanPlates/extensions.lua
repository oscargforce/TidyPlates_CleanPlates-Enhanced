local Media = LibStub("LibSharedMedia-3.0")
local path = "Interface\\Addons\\TidyPlates_CleanPlates\\Artwork\\"
local activeStyle = "normal"

local function UpdateTargetFrameArt(frame, unit)
	if UnitExists("target") and unit.isTarget then
		local iconPaths = {
			normal = { 
				gold = path.."CP_TargetHighlight", 
				white = path.."CP_HealthBarHighlight"
			},
			totem = { 
				gold = path.."CP_PetHighlightGold", 
				white = path.."CP_PetHighlight"
			},
			pet = { 
				gold = path.."CP_PetHighlightGold", 
				white = path.."CP_PetHighlight"
			},
			empty = path.."Empty",
			special = path.."CP_HealthBarHighlight"
		}
		local selectedArt = CP.db.profile.selectedTargetHighlightArt
		local iconPath

		if type(iconPaths[activeStyle]) == "table" then
			iconPath = iconPaths[activeStyle][selectedArt] or iconPaths[activeStyle]["gold"]
		else
			iconPath = iconPaths[activeStyle] or path.."CP_TargetHighlight"
		end

		frame.Icon:SetTexture(iconPath)
		frame:Show()
	else
		frame:Hide()
	end
end

local function CreateTargetFrameArt(parent)
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetWidth(256)
	frame:SetHeight(64)	
	frame.Icon = frame:CreateTexture(nil, "OVERLAY")
	frame.Icon:SetAllPoints(frame)
	frame:Hide()
	frame.Update = UpdateTargetFrameArt
	return frame
end

local function OnInitialize(plate)
    if not plate.widgets.TargetArt then 
		plate.widgets.TargetArt = CreateTargetFrameArt(plate)
		plate.widgets.TargetArt:SetFrameLevel(10) -- This works like css z-index
	end
end

local function OnUpdate(plate, unit)
    if not plate.widgets.TargetArt then 
        OnInitialize(plate) 
    end

	if CP.db.profile.showTargetHighlightArt then
		activeStyle = SetStyle(unit)
		local y = TidyPlatesThemeList["CP"][activeStyle].healthborder.y
		plate.widgets.TargetArt:Update(unit, style)
		plate.widgets.TargetArt:SetPoint("CENTER", plate, 0, y)
	end	
end

local setExtended = CreateFrame("Frame")
local themeEvent = {}

function themeEvent:ADDON_LOADED()
	if arg1 == "TidyPlates_CleanPlates" then
		TidyPlatesThemeList["CP"].OnInitialize = OnInitialize
		TidyPlatesThemeList["CP"].OnUpdate = OnUpdate
	end
end

setExtended:SetScript("OnEvent", function(self, event) themeEvent[event]() end)
setExtended:RegisterEvent("ADDON_LOADED")
