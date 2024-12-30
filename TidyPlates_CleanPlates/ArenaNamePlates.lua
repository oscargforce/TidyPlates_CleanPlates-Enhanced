local CP = LibStub("AceAddon-3.0"):GetAddon("CP")
local addonName, addon = ...

local zone = ""
local refreshPlates = true

local arenaPlayers = { 
	["arena1"] = "",
	["arena2"] = "",
	["arena3"] = "",
	["arena4"] = "",
	["arena5"] = ""
}

local function isValidArenaUnit(unit)
	return unit:match("^arena[1-5]$")
end

local function hasArenaPlayerData(unit)
    return arenaPlayers[unit] ~= "" and arenaPlayers[unit] ~= "Unknown"
end


local function resetArenaUnitPlayerNames()
	for arenaUnit in pairs(arenaPlayers) do
		arenaPlayers[arenaUnit] = ""
	end
end

local function cachePlayerNameForArenaUnit(unit)
	if not isValidArenaUnit(unit) then return end

	if hasArenaPlayerData(unit) then
		if refreshPlates then 
			TidyPlates:ForceUpdate() -- Ensure numbers are re-added to nameplates after a reload during an arena game as the numbers may disappear otherwise.
		end
		refreshPlates = false
		return
	end

	local playerName = UnitName(unit)

	if playerName  then
		arenaPlayers[unit] = playerName   
	end
end

local function startNamePolling(unit)
    local pollFrame = CreateFrame("Frame")
    local attempts = 1
    local pollInterval = 0.5
    local maxAttempts = 20
    
    pollFrame:SetScript("OnUpdate", function(self, elapsed)
        self.timeSinceLastUpdate = (self.timeSinceLastUpdate or 0) + elapsed
        if self.timeSinceLastUpdate < pollInterval then return end
        self.timeSinceLastUpdate = 0
        
        local playerName = UnitName(unit)
        if playerName and playerName ~= "Unknown" then
            arenaPlayers[unit] = playerName
            pollFrame:SetScript("OnUpdate", nil)
			TidyPlates:ForceUpdate() -- Force a nameplate update to ensure the numbers appear, as they won't show unless the nameplates are refreshed (e.g., when they leave and re-enter the UI).
        elseif attempts > maxAttempts then
            pollFrame:SetScript("OnUpdate", nil)
        else
            attempts = attempts + 1
        end
    end)
end

local function getArenaUnitIDByPlayerName(playerName)
	for arenaKey, name in pairs(arenaPlayers) do
		if name == playerName then
			return arenaKey  
		end
	end
	return nil  
end

local function assignArenaNumbersToName(plateName)
	if not CP.db.profile.showArenaNumbersAsName then return nil end

	if zone == "arena" then
		local arenaUnitID = getArenaUnitIDByPlayerName(plateName)
		if arenaUnitID then
			return arenaUnitID:match("arena(%d+)")
		end
	end 
end

local arenaFrame = CreateFrame("Frame")
arenaFrame:RegisterEvent("ADDON_LOADED")

local function handlePlayerEnteringWorld() 
	local _, instanceType = IsInInstance()
	zone = instanceType
	if zone == "arena" then
		arenaFrame:RegisterEvent("UNIT_AURA")
	else
		resetArenaUnitPlayerNames()
		arenaFrame:UnregisterEvent("UNIT_AURA")
	end
end

local function handleArenaOpponentUpdate(unit)
	if zone ~= "arena" then return end
	local isActiveArena, _ = IsActiveBattlefieldArena()
	if not isActiveArena then return end
	if not isValidArenaUnit(unit) then return end
	if hasArenaPlayerData(unit) then return end

	startNamePolling(unit)
end

local function handleUnitAura(unit)
	cachePlayerNameForArenaUnit(unit)
end

local function handleAddonLoaded()
	if arg1 == "TidyPlates_CleanPlates" then
		TidyPlatesThemeList["CP"].AssignArenaNumbersToName = assignArenaNumbersToName
        addon.ToggleArenaNumberEvents() -- Need to trigger the register or unregister of events on load.
        arenaFrame:UnregisterEvent("ADDON_LOADED")
	end
end

arenaFrame:SetScript("OnEvent", function(self, event, unit) 
    if event == "ADDON_LOADED" then
        handleAddonLoaded()
    elseif event == "PLAYER_ENTERING_WORLD" then
        handlePlayerEnteringWorld()
    elseif event == "UNIT_AURA" then
        handleUnitAura(unit)
    elseif event == "ARENA_OPPONENT_UPDATE" then
        handleArenaOpponentUpdate(unit)
    end
end)

function addon.ToggleArenaNumberEvents()
	if CP.db.profile.showArenaNumbersAsName then
		arenaFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
		arenaFrame:RegisterEvent("ARENA_OPPONENT_UPDATE")
        handlePlayerEnteringWorld()
	else
		arenaFrame:UnregisterEvent("PLAYER_ENTERING_WORLD")
		arenaFrame:UnregisterEvent("ARENA_OPPONENT_UPDATE")
		arenaFrame:UnregisterEvent("UNIT_AURA")
	end
end