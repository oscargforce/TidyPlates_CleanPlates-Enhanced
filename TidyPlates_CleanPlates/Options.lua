local CP = LibStub("AceAddon-3.0"):GetAddon("CP")
local addonName, addon = ...

local classIconArtOptions = {
	["Default"] = "Default", 
	["Clean"] = "Clean",
	["Transparent"] = "Transparent",
	["Wowflat"] = "Wowflat",
	["Wowround"] = "Wowround",
}

function CP:SetupOptions()
	self.options = { 
		type = "group", 
		args = {
			Desc = {
				type = "description",
				order = 1,
				name = "Clear and easy to use nameplate theme for use with TidyPlates.\nFeel free to email me on charracter Isobella, on Warmane Icecrown, with any questions or comments.",
			},
			header = {
				order = 2,
				type = "header",
				name = "Tidy Plates: Clean Plates v2.0.2",
			},
			TextOptFrame = {
		        order = 1,
		        type  = "group",
       			name  = "Text Options",
		        args = {
					MOheader = {
						order = 1,
						type = "header",
						name = "Text Options",
					},
					showPlayerNames = {
						order = 2,
						type = "toggle",
						name = "Show Player Names",
						desc = "Toggle the showing and hiding of player names.",
						get = function() return self.db.profile.showPlayerNames end,
						set = function(info,val) 
							self.db.profile.showPlayerNames = val
							TidyPlatesThemeList.CP.normal.options.showName = val
							TidyPlates:ReloadTheme()
							TidyPlates:ForceUpdate()
							if self.db.profile.showPlayerNames then return print("-->>Showing player names on nameplates are now |cff00ff00ON!|r<<--") else return print("-->>Showing player names on nameplates are now |cffff0000OFF!|r<<--") end
						end
					},
					arenaDesc = {
						order = 3,
						type = "description",
						name = "Show Arena Numbers as Names",
					},
					showArenaNumbersAsName = {
						order = 4,
						type = "toggle",
						name = "Show Arena Numbers",
						desc = "Replace player names on nameplates with their corresponding arena numbers during arena matches.",
						get = function() return self.db.profile.showArenaNumbersAsName end,
						set = function(info, value)
							self.db.profile.showArenaNumbersAsName = value
							addon.ToggleArenaNumberEvents()
							TidyPlates:ReloadTheme()
							TidyPlates:ForceUpdate()
							if self.db.profile.showArenaNumbersAsName then return print("-->>Show Arena Numbers instead of player names is now |cff00ff00ON!|r<<--") else return print("-->>Show Arena Numbers instead of player names is now |cffff0000OFF!|r<<--") end
						end,
						disabled = function() return not self.db.profile.showPlayerNames end,
					},
					showArenaNumbersAsNameFontSize = {
						order = 4.5,
						type = "range",
						name = "Set the font size",
						desc = "This will only affect the arena unit number 1,2,3,4,5 not the actual font size of player names. Default is 23",
						step = 1,
						min = 12,
						max = 40,
						get = function() return self.db.profile.showArenaNumbersAsNameFontSize end,
						set = function(info, value)
							self.db.profile.showArenaNumbersAsNameFontSize = value
							TidyPlatesThemeList.CP.normal.arenaNumbers.size = value
							TidyPlates:ReloadTheme()
							TidyPlates:ForceUpdate()
						end,
						hidden = function() return not self.db.profile.showArenaNumbersAsName end,
						disabled = function() return not self.db.profile.showPlayerNames end,

					},
					showArenaNumbersAsNameY = {
						order = 4.6,
						type = "range",
						name = "Set the Y position",
						desc = "This will only affect the arena unit number 1,2,3,4,5 not the actual font size of player names. Default is 23",
						step = 1,
						min = -40,
						max = 60,
						get = function() return self.db.profile.showArenaNumbersAsNameY end,
						set = function(info, value)
							self.db.profile.showArenaNumbersAsNameY = value
							TidyPlatesThemeList.CP.normal.arenaNumbers.y = value
							TidyPlates:ReloadTheme()
							TidyPlates:ForceUpdate()
						end,
						hidden = function() return not self.db.profile.showArenaNumbersAsName end,
						disabled = function() return not self.db.profile.showPlayerNames end,

					},
					showArenaNumbersAsNameX = {
						order = 4.7,
						type = "range",
						name = "Set the X position",
						desc = "This will only affect the arena unit number 1,2,3,4,5 not the actual font size of player names. Default is 0",
						step = 1,
						min = -100,
						max = 100,
						get = function() return self.db.profile.showArenaNumbersAsNameX end,
						set = function(info, value)
							self.db.profile.showArenaNumbersAsNameX = value
							TidyPlatesThemeList.CP.normal.arenaNumbers.x = value
							TidyPlates:ReloadTheme()
							TidyPlates:ForceUpdate()
						end,
						hidden = function() return not self.db.profile.showArenaNumbersAsName end,
						disabled = function() return not self.db.profile.showPlayerNames end,

					},
					showPetNames = {
						order = 5,
						type = "toggle",
						name = "Show Pet Names",
						desc = "The main pet remains linked to players. The option below specifically controls the display of names for summoned entities such as treants, snake traps, mirror images, water elementals, spirit wolves and shadowfiend.",
						get = function() return self.db.profile.showPetNames end,
						set = function(info,val) 
							self.db.profile.showPetNames = val
							TidyPlatesThemeList.CP.pet.options.showName = val
							TidyPlates:ReloadTheme()
							TidyPlates:ForceUpdate()
							if self.db.profile.showPetNames then return print("-->>Showing pet names on nameplates are now |cff00ff00ON!|r<<--") else return print("-->>Showing pet names on nameplates are now |cffff0000OFF!|r<<--") end
						end
					},
					showTotemNames = {
						order = 6,
						type = "toggle",
						name = "Show Totem Names",
						desc = "Toggle the showing and hiding of totem names.",
						get = function() return self.db.profile.showTotemNames end,
						set = function(info,val) 
							self.db.profile.showTotemNames = val
							TidyPlatesThemeList.CP.totem.options.showName = val
							TidyPlates:ReloadTheme()
							TidyPlates:ForceUpdate()
							if self.db.profile.showTotemNames then return print("-->>Showing totem names on nameplates are now |cff00ff00ON!|r<<--") else return print("-->>Showing totem names on nameplates are now |cffff0000OFF!|r<<--") end
						end
					},
					showLevel = {
						order = 7,
						type = "toggle",
						name = "Show Player Level",
						desc = "Toggle the showing and hiding of the player level.",
						get = function() return self.db.profile.showLevel end,
						set = function(info,val) 
							self.db.profile.showLevel = val
							TidyPlatesThemeList.CP.normal.options.showLevel = val
							TidyPlates:ReloadTheme()
							TidyPlates:ForceUpdate()
							if self.db.profile.showLevel then return print("-->>Showing level on nameplates are now |cff00ff00ON!|r<<--") else return print("-->>Showing level on nameplates are now |cffff0000OFF!|r<<--") end
						end
					},
					hptext = {
						order = 8,
						type = "toggle",
						name = "Show HP Special Text",
						desc = "HP Special Text is the center text displaying the truncated HP amount and HP percentage on nameplates.",
						get = function() return self.db.profile.hptext end,
						set = function(info,val) 
							self.db.profile.hptext = not self.db.profile.hptext
							if self.db.profile.hptext then return print("-->>HP Special Text is now |cff00ff00ON!|r<<--") else return print("-->>HP Special Text is now |cffff0000OFF!|r<<--") end
						end
					},
					hundtext = {
						order = 9,
						type = "toggle",
						name = "Show HP Text at Full",
						desc = "Toggles the showing and hiding of 100\% HP Special Text",
						get = function() return self.db.profile.hundtext end,
						set = function(info,val) 
							self.db.profile.hundtext = not self.db.profile.hundtext
							if self.db.profile.hundtext then return print("-->>100\% HP Text is now |cff00ff00ON!|r<<--") else return print("-->>100\% HP Text is now |cffff0000OFF!|r<<--") end
						end
					},
					fullstringtext = {
						order = 10,
						type = "toggle",
						name = "Show Full HP and 100\%",
						desc = "Toggles the showing and hiding of Full HP amount and 100\% HP Text.",
						get = function() return self.db.profile.fullstring end,
						set = function(info,val) 
							self.db.profile.fullstring = not self.db.profile.fullstring
							if self.db.profile.fullstring then return print("-->>Full HP ammount and 100\% HP Text is now |cff00ff00ON!|r<<--") else return print("-->>Full HP ammount and 100\% HP Text is now |cffff0000OFF!|r<<--") end
						end
					},
					fctextdesc = {
						order = 11,
						type = "description",
						name = '\nHybrid Class Faction Champions can have a "spec" text next to their name showing which role they are. \n\n|cffff0000Red|r for dps and |cff00ff00green|r for healer.\n',
					},
					fctext = {
						order = 12,
						type = "toggle",
						name = "Show spec text",
						desc = "Toggles the showing and hiding of Faction Champion boss' spec text",
						get = function() return self.db.profile.fctext end,
						set = function(info,val) 
							self.db.profile.fctext = not self.db.profile.fctext
							if self.db.profile.fctext then return print("-->>Faction Champion Spec Text is now |cff00ff00ON!|r<<--") else return print("-->>Faction Champion Spec Text is now |cffff0000OFF!|r<<--") end
						end
					},
				},
			},
			IconOptions = {
				order = 2,
				type  = "group",
				name  = "Icon Options",
				args = {
					IconHeader = {
						order = 1,
						type = "header",
						name = "Faction Champion Boss Icons",
					},
					EnemyClassIcons = {
						order = 1,
						type = "group",
						name = "Enemy Class Icons",
						desc = "Configure options for PvP Icons.",
						args = {
							IconHeader = {
								order = 1,
								type = "header",
								name = "Enemy Class Icons",
							},
							classiconsdesc = {
								order = 2,
								type = "description",
								name = "\nEnemy class icons help identify the classes of opponents, making them especially useful for DPS players in arenas.\n\nWhen enabled, this feature places a class icon next to each enemy's health bar. NOTE only works on PvP flagged players.\n",
							},
							classicons = {
								order = 3,
								type = "toggle",
								name = "Show PvP Class Icons",
								desc = "Toggles the showing and hiding of class icons on PvP flagged players",
								get = function() return self.db.profile.classicons end,
								set = function(info,val) 
									self.db.profile.classicons = not self.db.profile.classicons
									TidyPlates:ForceUpdate()
									TidyPlates:ReloadTheme()
									if self.db.profile.classicons then return print("-->>Class Icons are now |cff00ff00ON!|r<<--") else return print("-->>Class Icons are now |cffff0000OFF!|r<<--") end
								end
							},
							selectedEnemyIconArt = {
								order = 4,
								type = "select",
								name = "Select Class Icon Art",
								desc = "Choose the art for the party icons",
								values = classIconArtOptions,
								get = function(info) return self.db.profile.selectedEnemyIconArt end,
								set = function(info, value) 
									self.db.profile.selectedEnemyIconArt = value
									TidyPlates:ForceUpdate()
									TidyPlates:ReloadTheme()
								end,
								disabled = function() return not self.db.profile.classicons end,  -- Disable if classicons is false
							},
							classiconsSize = {
								type = "range",
								order = 5,
								name = "|cffffffffClass Icon Size|r",
								desc = "Default is 22.",
								get = function(info) return self.db.profile.classiconsHeight end,
								set = function(info,v)
									self.db.profile.classiconsHeight = v
									self.db.profile.classiconsWidth = v
									TidyPlatesThemeList.CP.normal.specialArt.height = v
									TidyPlatesThemeList.CP.normal.specialArt.width = v
									TidyPlates:ReloadTheme()
									TidyPlates:ForceUpdate()
								end,								
								step = 0.5,
								min = 5,
								max = 120,
								isPercent = false,
								disabled = function() return not self.db.profile.classicons end,  -- Disable if classicons is false
							},
							classiconsY = {
								type = "range",
								order = 6,
								name = "|cffffffffClass Icon Y|r",
								desc = "Default is -2, adjust to move the icon up or down.",
								get = function(info) return self.db.profile.classiconsY end,
								set = function(info,v)
									self.db.profile.classiconsY = v
									TidyPlatesThemeList.CP.normal.specialArt.y = v
									TidyPlates:ReloadTheme()
									TidyPlates:ForceUpdate()
								end,								
								step = 0.5,
								min = -100,
								max = 100,
								isPercent = false,
								disabled = function() return not self.db.profile.classicons end,  -- Disable if classicons is false
							},
							classiconsX = {
								type = "range",
								order = 7,
								name = "|cffffffffClass Icon X|r",
								desc = "Default is -74, adjust to move the icon left or right.",
								get = function(info) return self.db.profile.classiconsX end,
								set = function(info,v)
									self.db.profile.classiconsX = v
									TidyPlatesThemeList.CP.normal.specialArt.x = v
									TidyPlates:ReloadTheme()
									TidyPlates:ForceUpdate()
								end,								
								step = 0.5,
								min = -100,
								max = 120,
								isPercent = false,
								disabled = function() return not self.db.profile.classicons end,  -- Disable if classicons is false
							},
						},
					},
					PartyClassIcons = {
						order = 1,
						type = "group",
						name = "Party Class Icons",
						desc = "Configure options for Party/raid Icons.",
						args = {
							IconHeader = {
								order = 1,
								type = "header",
								name = "Party/Raid Class Icons",
							},
							classiconsdesc = {
								order = 2,
								type = "description",
								name = "\nParty/Raid class icons help identify the location of players, making it especially useful for healers in arenas.\n\nWhen enabled, this feature places a class icon next to each player's health bar in your party/raid\n",
							},
							partyicons = {
								order = 3,
								type = "toggle",
								name = "Show Party Class Icons",
								desc = "Toggles the showing and hiding of class icons on raid/party members",
								get = function() return self.db.profile.partyicons end,
								set = function(info,val) 
									self.db.profile.partyicons = not self.db.profile.partyicons
									TidyPlates:ReloadTheme()
									TidyPlates:ForceUpdate()
									if self.db.profile.partyicons then return print("-->>Party Icons are now |cff00ff00ON!|r<<--") else return print("-->>Party Icons are now |cffff0000OFF!|r<<--") end
								end
							},
							selectedPartyIconArt = {
								order = 4,
								type = "select",
								name = "Select Class Icon Art",
								desc = "Choose the art for the party icons",
								values = classIconArtOptions,
								get = function(info) return self.db.profile.selectedPartyIconArt end,
								set = function(info, value) 
									self.db.profile.selectedPartyIconArt = value
									TidyPlates:ForceUpdate()
									TidyPlates:ReloadTheme()
								end,
								disabled = function() return not self.db.profile.partyicons end,  -- Disable if partyicons is false
							},
							partyiconsSize = {
								type = "range",
								order = 5,
								name = "|cffffffffParty Icon Size|r",
								desc = "Default is 22.",
								get = function(info) return self.db.profile.partyiconsHeight end,
								set = function(info,v)
									self.db.profile.partyiconsHeight = v
									self.db.profile.partyiconsWidth = v
									TidyPlatesThemeList.CP.normal.partyIcons.height = v
									TidyPlatesThemeList.CP.normal.partyIcons.width = v
									TidyPlates:ReloadTheme()
									TidyPlates:ForceUpdate()
								end,								
								step = 0.5,
								min = 5,
								max = 120,
								isPercent = false,
								disabled = function() return not self.db.profile.partyicons end,  -- Disable if partyicons is false
							},
							partyiconsY = {
								type = "range",
								order = 6,
								name = "|cffffffffParty Icon Y|r",
								desc = "Default is -2, adjust to move the icon up or down.",
								get = function(info) return self.db.profile.partyiconsY end,
								set = function(info,v)
									self.db.profile.partyiconsY = v
									TidyPlatesThemeList.CP.normal.partyIcons.y = v
									TidyPlates:ReloadTheme()
									TidyPlates:ForceUpdate()
								end,								
								step = 0.5,
								min = -100,
								max = 100,
								isPercent = false,
								disabled = function() return not self.db.profile.partyicons end,  -- Disable if partyicons is false
							},
							partyiconsX = {
								type = "range",
								order = 7,
								name = "|cffffffffParty Icon X|r",
								desc = "Default is -74, adjust to move the icon left or right.",
								get = function(info) return self.db.profile.partyiconsX end,
								set = function(info,v)
									self.db.profile.partyiconsX = v
									TidyPlatesThemeList.CP.normal.partyIcons.x = v
									TidyPlates:ReloadTheme()
									TidyPlates:ForceUpdate()
								end,								
								step = 0.5,
								min = -100,
								max = 120,
								isPercent = false,
								disabled = function() return not self.db.profile.partyicons end,  -- Disable if partyicons is false
							},
						},
					},
					PetIcons = {
						order = 1,
						type = "group",
						name = "Pet Icons",
						desc = "Configure options for Party/raid Pets Icons.",
						args = {
							IconHeader = {
								order = 1,
								type = "header",
								name = "Party/raid Pets Icons",
							},
							petIconsDesc = {
								order = 2,
								type = "description",
								name = "\nParty/Raid pet icons make it easier to locate and identify pets in combat.\n\nWhen enabled, this feature places an icon next to each party/raid member's pet health bar, helping you quickly spot their pets during encounters.\n",
							},
							showPetIcons = {
								order = 3,
								type = "toggle",
								name = "Show Pet Icons",
								desc = "Toggle the display of an icon on party and raid members pets.",
								get = function() return self.db.profile.showPetIcons end,
								set = function(info,val) 
									self.db.profile.showPetIcons = not self.db.profile.showPetIcons
									TidyPlates:ReloadTheme()
									TidyPlates:ForceUpdate()
									if self.db.profile.showPetIcons then return print("-->>Pet Icons are now |cff00ff00ON!|r<<--") else return print("-->>Pet Icons are now |cffff0000OFF!|r<<--") end
								end
							},
							petIconsSize = {
								type = "range",
								order = 4,
								name = "|cffffffffPet Icon Size|r",
								desc = "Default is 22.",
								get = function(info) return self.db.profile.petIconsHeight end,
								set = function(info,v)
									self.db.profile.petIconsHeight = v
									self.db.profile.petIconsWidth = v

									TidyPlatesThemeList.CP.normal.petIcons.width = v
									TidyPlatesThemeList.CP.normal.petIcons.height = v

									TidyPlatesThemeList.CP.pet.petIcons.width = (v - 10)
									TidyPlatesThemeList.CP.pet.petIcons.height = (v - 10)
									TidyPlates:ReloadTheme()
									TidyPlates:ForceUpdate()
								end,								
								step = 0.5,
								min = 5,
								max = 120,
								isPercent = false,
								disabled = function() return not self.db.profile.showPetIcons end,  -- Disable if showPetIcons is false
							},
							petIconsY = {
								type = "range",
								order = 5,
								name = "|cffffffffPet Icon Y|r",
								desc = "Default is -2, adjust to move the icon up or down.",
								get = function(info) return self.db.profile.petIconsY end,
								set = function(info,v)
									self.db.profile.petIconsY = v
									TidyPlatesThemeList.CP.normal.petIcons.y = v
									TidyPlatesThemeList.CP.pet.petIcons.y = v
									TidyPlates:ReloadTheme()
									TidyPlates:ForceUpdate()
								end,								
								step = 0.5,
								min = -100,
								max = 100,
								isPercent = false,
								disabled = function() return not self.db.profile.showPetIcons end,  -- Disable if showPetIcons is false
							},
							petIconsX = {
								type = "range",
								order = 6,
								name = "|cffffffffPet Icon X|r",
								desc = "Default is -74, adjust to move the icon left or right.",
								get = function(info) return self.db.profile.petIconsX end,
								set = function(info,v)
									self.db.profile.petIconsX = v
									TidyPlatesThemeList.CP.normal.petIcons.x = v
									TidyPlatesThemeList.CP.pet.petIcons.x = v
									TidyPlates:ReloadTheme()
									TidyPlates:ForceUpdate()
								end,								
								step = 0.5,
								min = -100,
								max = 120,
								isPercent = false,
								disabled = function() return not self.db.profile.showPetIcons end,  -- Disable if showPetIcons is false
							},
							displayHeader = {
								order = 7,
								type = "header",
								name = "Show for Creatures",
							},
							showBeastPetIcon = {
								order = 8,
								type = "toggle",
								name = "Beast pets",
								desc = "Toggle the display of a pet icon for Beast pets within the party or raid.",
								get = function() return self.db.profile.showBeastPetIcon end,
								set = function(info,val) 
									self.db.profile.showBeastPetIcon = not self.db.profile.showBeastPetIcon
									TidyPlates:ReloadTheme()
									TidyPlates:ForceUpdate()
									if self.db.profile.showBeastPetIcon then return print("-->>Pet Icons for Beasts are now |cff00ff00ON!|r<<--") else return print("-->>Pet Icons for Beasts are now |cffff0000OFF!|r<<--") end
								end,
								disabled = function() return not self.db.profile.showPetIcons end,  -- Disable if showPetIcons is false
							},
							showDemonPetIcon = {
								order = 9,
								type = "toggle",
								name = "Demon pets",
								desc = "Toggle the display of a pet icon for Demon pets within the party or raid.",
								get = function() return self.db.profile.showDemonPetIcon end,
								set = function(info,val) 
									self.db.profile.showDemonPetIcon = not self.db.profile.showDemonPetIcon
									TidyPlates:ReloadTheme()
									TidyPlates:ForceUpdate()
									if self.db.profile.showDemonPetIcon then return print("-->>Pet Icons for Demons are now |cff00ff00ON!|r<<--") else return print("-->>Pet Icons for Demons are now |cffff0000OFF!|r<<--") end
								end,
								disabled = function() return not self.db.profile.showPetIcons end,  -- Disable if showPetIcons is false
							},
							showUndeadPetIcon = {
								order = 10,
								type = "toggle",
								name = "Undead pets",
								desc = "Toggle the display of a pet icon for Undead pets within the party or raid.",
								get = function() return self.db.profile.showUndeadPetIcon end,
								set = function(info,val) 
									self.db.profile.showUndeadPetIcon = not self.db.profile.showUndeadPetIcon
									TidyPlates:ReloadTheme()
									TidyPlates:ForceUpdate()
									if self.db.profile.showUndeadPetIcon then return print("-->>Pet Icons for Undead are now |cff00ff00ON!|r<<--") else return print("-->>Pet Icons for Undead are now |cffff0000OFF!|r<<--") end
								end,
								disabled = function() return not self.db.profile.showPetIcons end,  -- Disable if showPetIcons is false
							},
							showElementalPetIcon = {
								order = 11,
								type = "toggle",
								name = "Elemental pets",
								desc = "Toggle the display of a pet icon for Elemental pets within the party or raid.",
								get = function() return self.db.profile.showElementalPetIcon end,
								set = function(info,val) 
									self.db.profile.showElementalPetIcon = not self.db.profile.showElementalPetIcon
									TidyPlates:ReloadTheme()
									TidyPlates:ForceUpdate()
									if self.db.profile.showElementalPetIcon then return print("-->>Pet Icons for Elementals are now |cff00ff00ON!|r<<--") else return print("-->>Pet Icons for Elementals are now |cffff0000OFF!|r<<--") end
								end,
								disabled = function() return not self.db.profile.showPetIcons end,  -- Disable if showPetIcons is false
							},
						},
					},
					TotemIcons = {
						order = 1,
						type = "group",
						name = "Totem Icons",
						desc = "Configure options for Totem Icons.",
						args = {
							IconHeader = {
								order = 1,
								type = "header",
								name = "Totem Icons",
							},
							totemsdesc = {
								order = 2,
								type = "description",
								name = "\nTotem icons are shown next to the nameplates of dropped totems. This includes totems from Faction Champions.\n",
							},
							totems = {
								order = 3,
								type = "toggle",
								name = "Show Totem Icons",
								desc = "Toggles the showing and hiding of totem icons.",
								get = function() return self.db.profile.totems end,
								set = function(info, value) 
									self.db.profile.totems = value
									TidyPlates:ReloadTheme()
									TidyPlates:ForceUpdate()
									if self.db.profile.totems then return print("-->>Totem Icons are now |cff00ff00ON!|r<<--") else return print("-->>Totem Icons are now |cffff0000OFF!|r<<--") end
								end
							},
							totemiconsSize = {
								type = "range",
								order = 4,
								name = "|cffffffffTotem Icon Size|r",
								desc = "Default is 26.",
								get = function(info) return self.db.profile.totemiconsHeight end,
								set = function(info,v)
									self.db.profile.totemiconsHeight = v
									self.db.profile.totemiconsWidth = v
									TidyPlatesThemeList.CP.totem.specialArt.height = v
									TidyPlatesThemeList.CP.totem.specialArt.width = v
									TidyPlates:ReloadTheme()
									TidyPlates:ForceUpdate()
								end,								
								step = 0.5,
								min = 10,
								max = 50,
								isPercent = false,
								disabled = function() return not self.db.profile.totems end,  -- Disable if totems is false
							},
							totemiconsY = {
								type = "range",
								order = 5,
								name = "|cffffffffTotem Icon Y|r",
								desc = "Default value is 0, adjust to move the icon up or down.",
								get = function(info) return self.db.profile.totemiconsY end,
								set = function(info,v)
									self.db.profile.totemiconsY = v
									TidyPlatesThemeList.CP.totem.specialArt.y = v
									TidyPlates:ReloadTheme()
									TidyPlates:ForceUpdate()
								end,								
								step = 0.5,
								min = -20,
								max = 60,
								isPercent = false,
								disabled = function() return not self.db.profile.totems end,  -- Disable if totems is false
							},
							totemiconsX = {
								type = "range",
								order = 6,
								name = "|cffffffffTotem Icon X|r",
								desc = "Default value is 0, adjust to move the icon left or right.",
								get = function(info) return self.db.profile.totemiconsX end,
								set = function(info,v)
									self.db.profile.totemiconsX = v
									TidyPlatesThemeList.CP.totem.specialArt.x = v
									TidyPlates:ReloadTheme()
									TidyPlates:ForceUpdate()
								end,								
								step = 0.5,
								min = -80,
								max = 80,
								isPercent = false,
								disabled = function() return not self.db.profile.totems end,  -- Disable if totems is false
							},
						},
					},
					fcicondesc = {
						order = 2,
						type = "description",
						name = '\nFaction Champion class icons work just like PvP Class icons.\n',
					},
					fcicons = {
						order = 3,
						type = "toggle",
						name = "Show Boss Class Icons",
						desc = "Toggles the showing and hiding of Faction Champion class icons",
						get = function() return self.db.profile.fcicons end,
						set = function(info,val) 
							self.db.profile.fcicons = not self.db.profile.fcicons
							if self.db.profile.fcicons then return print("-->>Faction Champion Class Icons are now |cff00ff00ON!|r<<--") else return print("-->>Faction Champion Class Icons are now |cffff0000OFF!|r<<--") end
						end
					},
				},
			},
			NameplateOptFrame = {
		        order = 3,
		        type  = "group",
       			name  = "Nameplate Options",
		        args = {				
					NamePlatesColorHeader = {
						order = 1,
						type = "header",
						name = "Color Options",
					},
					NamePlatesColordesc = {
						order = 2,
						type = "description",
						name = "\nSet friendly health bar colors and toggle the display of nameplates for various objects.\n",
					},
					friendlyHealthBarColor = {
						type = "color",
						order = 3,
						name = "Friendly Health Bar Color",
						desc = "Set the color of health bars for friendly players.",
						get = function(info)
							-- Retrieve the saved color from the database, or use a default green if not set
							 local color = self.db.profile.friendlyHealthBarColor
							 return color.r, color.g, color.b, color.a
						end,
						set = function(info, r, g, b, a)
							-- Save the chosen color to the database
							self.db.profile.friendlyHealthBarColor = { r = r, g = g, b = b, a = a }
							TidyPlates:ReloadTheme()
							TidyPlates:ForceUpdate()
						end,
						hasAlpha = true,  -- Enable opacity control for the color picker
					},
					NamePlatesDisplayHeader = {
						order = 4,
						type = "header",
						name = "Display Options",
					},
					NamePlatesDisplaydesc = {
						order = 5,
						type = "description",
						name = "\nToggle the display of art and health bar on or off\n"
					},
					worms = {
						order = 10,
						type = "toggle",
						name = "Bloodworms",
						desc = "Toggles the showing and hiding of bloodworm nameplates.",
						get = function() return self.db.profile.showworms end,
						set = function(info,val) 
							self.db.profile.showworms = not self.db.profile.showworms
							if self.db.profile.showworms then return print("-->>Bloodworm Nameplates are now |cff00ff00ON!|r<<--") else return print("-->>Bloodworm Nameplates are now |cffff0000OFF!|r<<--") end
						end
					},
					images = {
						order = 11,
						type = "toggle",
						name = "Mirror Images",
						desc = "Toggles the showing and hiding of Mirror Image nameplates.",
						get = function() return self.db.profile.showimages end,
						set = function(info,val) 
							self.db.profile.showimages = not self.db.profile.showimages
							if self.db.profile.showimages then return print("-->>Mirror Image Nameplates are now |cff00ff00ON!|r<<--") else return print("-->>Mirror Image Nameplates are now |cffff0000OFF!|r<<--") end
						end
					},
					fiends = {
						order = 12,
						type = "toggle",
						name = "Shadowfiends",
						desc = "Toggles the showing and hiding of Shadowfiend nameplates.",
						get = function() return self.db.profile.showfiends end,
						set = function(info,val) 
							self.db.profile.showfiends = not self.db.profile.showfiends
							if self.db.profile.showfiends then return print("-->>Shadowfiend Nameplates are now |cff00ff00ON!|r<<--") else return print("-->>Shadowfiend Nameplates are now |cffff0000OFF!|r<<--") end
						end
					},
					snakes = {
						order = 13,
						type = "toggle",
						name = "Snake Traps",
						desc = "Toggles the showing and hiding of snake trap nameplates.",
						get = function() return self.db.profile.showsnakes end,
						set = function(info,val) 
							self.db.profile.showsnakes = not self.db.profile.showsnakes
							if self.db.profile.showsnakes then return print("-->>Snake Trap Nameplates are now |cff00ff00ON!|r<<--") else return print("-->>Snake Trap Nameplates are now |cffff0000OFF!|r<<--") end
						end
					},
					wolves = {
						order = 14,
						type = "toggle",
						name = "Spirit Wolves",
						desc = "Toggles the showing and hiding of spirit wolf nameplates.",
						get = function() return self.db.profile.showwolves end,
						set = function(info,val) 
							self.db.profile.showwolves = not self.db.profile.showwolves
							if self.db.profile.showwolves then return print("-->>Spirit Wolf Nameplates are now |cff00ff00ON!|r<<--") else return print("-->>Spirit Wolf Nameplates are now |cffff0000OFF!|r<<--") end
						end
					},
					treants = {
						order = 15,
						type = "toggle",
						name = "Treants",
						desc = "Toggles the showing and hiding of treant nameplates.",
						get = function() return self.db.profile.showtreants end,
						set = function(info,val) 
							self.db.profile.showtreants = not self.db.profile.showtreants
							if self.db.profile.showtreants then return print("-->>Treant Nameplates are now |cff00ff00ON!|r<<--") else return print("-->>Treant Nameplates are now |cffff0000OFF!|r<<--") end
						end
					},
					elementals = {
						order = 16,
						type = "toggle",
						name = "Water Elementals",
						desc = "Toggles the showing and hiding of Water Elemental nameplates.",
						get = function() return self.db.profile.showelementals end,
						set = function(info,val) 
							self.db.profile.showelementals = not self.db.profile.showelementals
							if self.db.profile.showelementals then return print("-->>Water Elemental Nameplates are now |cff00ff00ON!|r<<--") else return print("-->>Water Elemental Nameplates are now |cffff0000OFF!|r<<--") end
						end
					},
					ghouls = {
						order = 17,
						type = "toggle",
						name = "Army Ghouls",
						desc = "Toggles the showing and hiding of Army of the Dead Ghoul nameplates.",
						get = function() return self.db.profile.showghouls end,
						set = function(info,val) 
							self.db.profile.showghouls = not self.db.profile.showghouls
							if self.db.profile.showghouls then return print("-->>Army Ghoul Nameplates are now |cff00ff00ON!|r<<--") else return print("-->>Army Ghoul Nameplates are now |cffff0000OFF!|r<<--") end
						end
					},
					AlphaSettings = {
						order = 1,
						type = "group",
						name = "Alpha Settings",
						desc = "Configure Alpha settings for nameplates.",
						args = {
							IconHeader = {
								order = 1,
								type = "header",
								name = "Alpha Settings",
							},
							classiconsdesc = {
								order = 2,
								type = "description",
								name = "\nEnable 'Target Highlight Art' if the non-target alpha is set to 0 for better visibility\n",
							},
							nonTargetAlphaValue = {
								type = "range",
								order = 3,
								desc = "Adjust the transparency of non-target nameplates",
								name = "Non-Target Alpha",
								get = function() return self.db.profile.nonTargetAlphaValue end,
								set = function(info, val)
									self.db.profile.nonTargetAlphaValue = val
									TidyPlates:ForceUpdate()
									TidyPlates:ReloadTheme()
								    end,
								min = -1,
								max = 0,
								step = 0.01,
								isPercent = true,
							},
							showTargetHighlightArt = {
								order = 4,
								type = "toggle",
								name = "Highlight Target Art",
								desc = "Toggle the display of additional art on the target nameplate to improve visibility of your current target.",
								get = function() return self.db.profile.showTargetHighlightArt end,
								set = function(info,val) 
									self.db.profile.showTargetHighlightArt = not self.db.profile.showTargetHighlightArt
									TidyPlates:ForceUpdate()
									TidyPlates:ReloadTheme()
									if self.db.profile.showTargetHighlightArt then return print("-->>Highlight Target Art is now |cff00ff00ON!|r<<--") else return print("-->>Highlight Target Art is now |cffff0000OFF!|r<<--") end
								end
							},
							selectedTargetHighlightArt = {
								order = 5,
								type = "select",
								name = "Select Target Art",
								desc = "Choose the art style for the target highlight",
								values = {
									["gold"] = "Golden Highlight", 
									["white"] = "White Highlight"
								},
								get = function(info) return self.db.profile.selectedTargetHighlightArt end,
								set = function(info, value) 
									self.db.profile.selectedTargetHighlightArt = value
									TidyPlates:ForceUpdate()
									TidyPlates:ReloadTheme()
								end,
								disabled = function() return not self.db.profile.showTargetHighlightArt end,  -- Disable if showTargetHighlightArt is false
							},
						},
					},
					ScaleOptions = {
						type = "group",
						order = 1,
						name = "Scale Options",
						args = {
							desc = {
								type = "description",
								order = 1,
								name = "Here you can set the scales of nameplates.",
							},
							header = {
								type = "header",
								order = 5,
								name = "Extra Nameplates",
							},
							Normal = {
								type = "range",
								order = 2,
								name = "|cffffffffNormal Scale|r",
								get 	= function(info) return self.db.profile.Normal_scale end,
								set 	= function(info,v)
											self.db.profile.Normal_scale = v
											TidyPlates:ReloadTheme()
											TidyPlates:ForceUpdate()
										end,								
								step = 0.05,
								min = 0.3,
								max = 2,
								isPercent = true,
							},
							Elite = {
								type = "range",
								order = 3,
								name = "|cffffff00Elite Scale|r",
								get 	= function(info) return self.db.profile.Elite_scale end,
								set 	= function(info,v)
											self.db.profile.Elite_scale = v
											TidyPlates:ReloadTheme()
											TidyPlates:ForceUpdate()
										end,								
								step = 0.05,
								min = 0.3,
								max = 2,
								isPercent = true,
							},
							Boss = {
								type = "range",
								order = 4,
								name = "|cffff0000Boss Scale|r",
								get 	= function(info) return self.db.profile.Boss_scale end,
								set 	= function(info,v)
											self.db.profile.Boss_scale = v
											TidyPlates:ReloadTheme()
											TidyPlates:ForceUpdate()
										end,								
								step = 0.05,
								min = 0.3,
								max = 2,
								isPercent = true,
							},
							Pet = {
								type = "range",
								order = 6,
								name = "|cffffffffPet Scale|r",
								get 	= function(info) return self.db.profile.Pet_scale end,
								set 	= function(info,v)
											self.db.profile.Pet_scale = v
											TidyPlates:ReloadTheme()
											TidyPlates:ForceUpdate()
										end,								
								step = 0.05,
								min = 0.3,
								max = 2,
								isPercent = true,
							},
							Totem = {
								type = "range",
								order = 7,
								name = "|cffffffffTotem Scale|r",
								get 	= function(info) return self.db.profile.Totem_scale end,
								set 	= function(info,v)
											self.db.profile.Totem_scale = v
											TidyPlates:ReloadTheme()
											TidyPlates:ForceUpdate()
										end,								
								step = 0.05,
								min = 0.3,
								max = 2,
								isPercent = true,
							},
							Special = {
								type = "range",
								order = 8,
								name = "|cffffff66Special Scale|r",
								get 	= function(info) return self.db.profile.Special_scale end,
								set 	= function(info,v)
											self.db.profile.Special_scale = v
											TidyPlates:ReloadTheme()
											TidyPlates:ForceUpdate()
										end,								
								step = 0.05,
								min = 0.3,
								max = 2,
								isPercent = true,
							},
							Empty = {
								type = "range",
								order = 9,
								name = "|cff454545Empty Scale|r",
								get 	= function(info) return self.db.profile.Empty_scale end,
								set 	= function(info,v)
											self.db.profile.Empty_scale = v
											TidyPlates:ReloadTheme()
											TidyPlates:ForceUpdate()
										end,								
								step = 0.05,
								min = 0.3,
								max = 2,
								isPercent = true,
							},
						},
					},	
				},
			},
			TotemsOptFrame = {
		        order = 4,
		        type  = "group",
       			name  = "Totem Options",
		        args = {
					totems = {
						order = 1,
						type = "toggle",
						name = "Show Totems",
						desc = "Toggles the showing and hiding of All totem nameplates.",
						get = function() return self.db.profile.showtotems end,
						set = function(info,val) 
							self.db.profile.showtotems = not self.db.profile.showtotems
							TidyPlates:ReloadTheme()
							TidyPlates:ForceUpdate()
							if self.db.profile.showtotems then return print("-->>Totem Nameplates are now |cff00ff00ON!|r<<--") else return print("-->>Totem Nameplates are now |cffff0000OFF!|r<<--") end
						end
					},
					FireTotems = {
						name = "|cffff8f8fFire Totems|r",
						type = "group",
						desc = "Fire Totem toggle's for 'on' or 'off'.",
						order = 1,
						args = {
							FNT = {
								order = 1,
								type = "toggle",
								name = "Fire Nova Totem",
								desc = "Toggles the showing and hiding of Fire Nova Totem nameplates.",
								get = function() return self.db.profile.totemList["Fire Nova Totem IX"] end,
								set = function(info,val) 
									self.db.profile.totemList["Fire Nova Totem IX"] = not self.db.profile.totemList["Fire Nova Totem IX"]
									if self.db.profile.totemList["Fire Nova Totem IX"] then return print("-->>Fire Nova Totem Nameplates are now |cff00ff00ON!|r<<--") else return print("-->>Fire Nova Totem Nameplates are now |cffff0000OFF!|r<<--") end
								end
							},
							FET = {
								order = 2,
								type = "toggle",
								name = "Fire Elemental Totem",
								desc = "Toggles the showing and hiding of Fire Elemental Totem nameplates.",
								get = function() return self.db.profile.totemList["Fire Elemental Totem"] end,
								set = function(info,val) 
									self.db.profile.totemList["Fire Elemental Totem"] = not self.db.profile.totemList["Fire Elemental Totem"]
									if self.db.profile.totemList["Fire Elemental Totem"] then return print("-->>Fire Elemental Totem Nameplates are now |cff00ff00ON!|r<<--") else return print("-->>Fire Elemental Totem Nameplates are now |cffff0000OFF!|r<<--") end
								end
							},
							FTT = {
								order = 3,
								type = "toggle",
								name = "Flametongue Totem",
								desc = "Toggles the showing and hiding of Flametongue Totem nameplates.",
								get = function() return self.db.profile.totemList["Flametongue Totem VIII"] end,
								set = function(info,val) 
									self.db.profile.totemList["Flametongue Totem VIII"] = not self.db.profile.totemList["Flametongue Totem VIII"]
									if self.db.profile.totemList["Flametongue Totem VIII"] then return print("-->>Flametongue Totem Nameplates are now |cff00ff00ON!|r<<--") else return print("-->>Flametongue Totem Nameplates are now |cffff0000OFF!|r<<--") end
								end
							},
							FRT = {
								order = 4,
								type = "toggle",
								name = "Frost Resistance Totem",
								desc = "Toggles the showing and hiding of Frost Resistance Totem nameplates.",
								get = function() return self.db.profile.totemList["Frost Resistance Totem VI"] end,
								set = function(info,val) 
									self.db.profile.totemList["Frost Resistance Totem VI"] = not self.db.profile.totemList["Frost Resistance Totem VI"]
									if self.db.profile.totemList["Frost Resistance Totem VI"] then return print("-->>Frost Resistance Totem Nameplates are now |cff00ff00ON!|r<<--") else return print("-->>Frost Resistance Totem Nameplates are now |cffff0000OFF!|r<<--") end
								end
							},
							MT = {
								order = 5,
								type = "toggle",
								name = "Magma Totem",
								desc = "Toggles the showing and hiding of Magma Totem nameplates.",
								get = function() return self.db.profile.totemList["Magma Totem VII"] end,
								set = function(info,val) 
									self.db.profile.totemList["Magma Totem VII"] = not self.db.profile.totemList["Magma Totem VII"]
									if self.db.profile.totemList["Magma Totem VII"] then return print("-->>Magma Totem Nameplates are now |cff00ff00ON!|r<<--") else return print("-->>Magma Totem Nameplates are now |cffff0000OFF!|r<<--") end
								end
							},
							ST = {
								order = 6,
								type = "toggle",
								name = "Searing Totem",
								desc = "Toggles the showing and hiding of Searing Totem nameplates.",
								get = function() return self.db.profile.totemList["Searing Totem X"] end,
								set = function(info,val) 
									self.db.profile.totemList["Searing Totem"] = not self.db.profile.totemList["Searing Totem"]
									self.db.profile.totemList["Searing Totem X"] = not self.db.profile.totemList["Searing Totem X"]
									if self.db.profile.totemList["Searing Totem X"] then return print("-->>Searing Totem Nameplates are now |cff00ff00ON!|r<<--") else return print("-->>Searing Totem Nameplates are now |cffff0000OFF!|r<<--") end
								end
							},
							TOW = {
								order = 7,
								type = "toggle",
								name = "Totem of Wrath",
								desc = "Toggles the showing and hiding of Totem of Wrath nameplates.",
								get = function() return self.db.profile.totemList["Totem of Wrath IV"] end,
								set = function(info,val) 
									self.db.profile.totemList["Totem of Wrath IV"] = not self.db.profile.totemList["Totem of Wrath IV"]
									if self.db.profile.totemList["Totem of Wrath IV"] then return print("-->>Totem of Wrath Nameplates are now |cff00ff00ON!|r<<--") else return print("-->>Totem of Wrath Nameplates are now |cffff0000OFF!|r<<--") end
								end
							},
						},
					},
					EarthTotems = {
						name = "|cffffb31fEarth Totems|r",
						type = "group",
						desc = "Earth Totem toggles for 'on' or 'off'.",
						order = 2,
						args = {
							EET = {
								order = 1,
								type = "toggle",
								name = "Earth Elemental Totem",
								desc = "Toggles the showing and hiding of Earth Elemental Totem nameplates.",
								get = function() return self.db.profile.totemList["Earth Elemental Totem"] end,
								set = function(info,val) 
									self.db.profile.totemList["Earth Elemental Totem"] = not self.db.profile.totemList["Earth Elemental Totem"]
									if self.db.profile.totemList["Earth Elemental Totem"] then return print("-->>Earth Elemental Totem Nameplates are now |cff00ff00ON!|r<<--") else return print("-->>Earth Elemental Totem Nameplates are now |cffff0000OFF!|r<<--") end
								end
							},
							EBT = {
								order = 2,
								type = "toggle",
								name = "Earthbind Totem",
								desc = "Toggles the showing and hiding of Earthbind Totem nameplates.",
								get = function() return self.db.profile.totemList["Earthbind Totem"] end,
								set = function(info,val) 
									self.db.profile.totemList["Earthbind Totem"] = not self.db.profile.totemList["Earthbind Totem"]
									if self.db.profile.totemList["Earthbind Totem"] then return print("-->>Earthbind Totem Nameplates are now |cff00ff00ON!|r<<--") else return print("-->>Earthbind Totem Nameplates are now |cffff0000OFF!|r<<--") end
								end
							},
							SCT = {
								order = 3,
								type = "toggle",
								name = "Stoneclaw Totem",
								desc = "Toggles the showing and hiding of Stoneclaw Totem nameplates.",
								get = function() return self.db.profile.totemList["Stoneclaw Totem X"] end,
								set = function(info,val) 
									self.db.profile.totemList["Stoneclaw Totem X"] = not self.db.profile.totemList["Stoneclaw Totem X"]
									if self.db.profile.totemList["Stoneclaw Totem X"] then return print("-->>Stoneclaw Totem Nameplates are now |cff00ff00ON!|r<<--") else return print("-->>Stoneclaw Totem Nameplates are now |cffff0000OFF!|r<<--") end
								end
							},
							SST = {
								order = 4,
								type = "toggle",
								name = "Stoneskin Totem",
								desc = "Toggles the showing and hiding of Stoneskin Totem nameplates.",
								get = function() return self.db.profile.totemList["Stoneskin Totem X"] end,
								set = function(info,val) 
									self.db.profile.totemList["Stoneskin Totem X"] = not self.db.profile.totemList["Stoneskin Totem X"]
									if self.db.profile.totemList["Stoneskin Totem X"] then return print("-->>Stoneskin Totem Nameplates are now |cff00ff00ON!|r<<--") else return print("-->>Stoneskin Totem Nameplates are now |cffff0000OFF!|r<<--") end
								end
							},
							SOE = {
								order = 5,
								type = "toggle",
								name = "Strength of Earth Totem",
								desc = "Toggles the showing and hiding of Strength of Earth Totem nameplates.",
								get = function() return self.db.profile.totemList["Strength of Earth Totem VIII"] end,
								set = function(info,val) 
									self.db.profile.totemList["Strength of Earth Totem VIII"] = not self.db.profile.totemList["Strength of Earth Totem VIII"]
									self.db.profile.totemList["Strength of Earth"] = not self.db.profile.totemList["Strength of Earth"]
									if self.db.profile.totemList["Strength of Earth Totem VIII"] then return print("-->>Strength of Earth Totem Nameplates are now |cff00ff00ON!|r<<--") else return print("-->>Strength of Earth Totem Nameplates are now |cffff0000OFF!|r<<--") end
								end
							},
							TT = {
								order = 6,
								type = "toggle",
								name = "Tremor Totem",
								desc = "Toggles the showing and hiding of Tremor Totem nameplates.",
								get = function() return self.db.profile.totemList["Tremor Totem"] end,
								set = function(info,val) 
									self.db.profile.totemList["Tremor Totem"] = not self.db.profile.totemList["Tremor Totem"]
									if self.db.profile.totemList["Tremor Totem"] then return print("-->>Tremor Totem Nameplates are now |cff00ff00ON!|r<<--") else return print("-->>Tremor Totem Nameplates are now |cffff0000OFF!|r<<--") end
								end
							},
						},
					},
					WaterTotems = {
						name = "|cff2b76ffWater Totems|r",
						type = "group",
						desc = "Water Totem toggles for 'on' or 'off'.",
						order = 3,
						args = {
							CT = {
								order = 1,
								type = "toggle",
								name = "Cleansing Totem",
								desc = "Toggles the showing and hiding of Cleansing Totem nameplates.",
								get = function() return self.db.profile.totemList["Cleansing Totem"] end,
								set = function(info,val) 
									self.db.profile.totemList["Cleansing Totem"] = not self.db.profile.totemList["Cleansing Totem"]
									if self.db.profile.totemList["Cleansing Totem"] then return print("-->>Cleansing Totem Nameplates are now |cff00ff00ON!|r<<--") else return print("-->>Cleansing Totem Nameplates are now |cffff0000OFF!|r<<--") end
								end
							},
							FRT = {
								order = 2,
								type = "toggle",
								name = "Fire Resistance Totem",
								desc = "Toggles the showing and hiding of Fire Resistance Totem nameplates.",
								get = function() return self.db.profile.totemList["Fire Resistance Totem VI"] end,
								set = function(info,val) 
									self.db.profile.totemList["Fire Resistance Totem VI"] = not self.db.profile.totemList["Fire Resistance Totem VI"]
									if self.db.profile.totemList["Fire Resistance Totem VI"] then return print("-->>Fire Resistance Totem Nameplates are now |cff00ff00ON!|r<<--") else return print("-->>Fire Resistance Totem Nameplates are now |cffff0000OFF!|r<<--") end
								end
							},
							HST = {
								order = 3,
								type = "toggle",
								name = "Healing Stream Totem",
								desc = "Toggles the showing and hiding of Healing Stream Totem nameplates.",
								get = function() return self.db.profile.totemList["Healing Stream Totem IX"] end,
								set = function(info,val) 
									self.db.profile.totemList["Healing Stream Totem"] = not self.db.profile.totemList["Healing Stream Totem"]
									self.db.profile.totemList["Healing Stream Totem IX"] = not self.db.profile.totemList["Healing Stream Totem IX"]
									if self.db.profile.totemList["Healing Stream Totem IX"] then return print("-->>Healing Stream Totem Nameplates are now |cff00ff00ON!|r<<--") else return print("-->>Healing Stream Totem Nameplates are now |cffff0000OFF!|r<<--") end
								end
							},
							MST = {
								order = 4,
								type = "toggle",
								name = "Mana Spring Totem",
								desc = "Toggles the showing and hiding of Mana Spring Totem nameplates.",
								get = function() return self.db.profile.totemList["Mana Spring Totem VIII"] end,
								set = function(info,val) 
									self.db.profile.totemList["Mana Spring Totem VIII"] = not self.db.profile.totemList["Mana Spring Totem VIII"]
									if self.db.profile.totemList["Mana Spring Totem VIII"] then return print("-->>Mana Spring Totem Nameplates are now |cff00ff00ON!|r<<--") else return print("-->>Mana Spring Totem Nameplates are now |cffff0000OFF!|r<<--") end
								end
							},
							MTT = {
								order = 5,
								type = "toggle",
								name = "Mana Tide Totem",
								desc = "Toggles the showing and hiding of Mana Tide Totem nameplates.",
								get = function() return self.db.profile.totemList["Mana Tide Totem"] end,
								set = function(info,val) 
									self.db.profile.totemList["Mana Tide Totem"] = not self.db.profile.totemList["Mana Tide Totem"]
									if self.db.profile.totemList["Mana Tide Totem"] then return print("-->>Mana Tide Totem Nameplates are now |cff00ff00ON!|r<<--") else return print("-->>Mana Tide Totem Nameplates are now |cffff0000OFF!|r<<--") end
								end
							},
						},
					},
					AirTotems = {
						name = "|cffb8d1ffAir Totems|r",
						type = "group",
						desc = "Air Totem toggles for 'on' or 'off'.",
						order = 4,
						args = {
							GT = {
								order = 1,
								type = "toggle",
								name = "Grounding Totem",
								desc = "Toggles the showing and hiding of Grounding Totem nameplates.",
								get = function() return self.db.profile.totemList["Grounding Totem"] end,
								set = function(info,val) 
									self.db.profile.totemList["Grounding Totem"] = not self.db.profile.totemList["Grounding Totem"]
									if self.db.profile.totemList["Grounding Totem"] then return print("-->>Grounding Totem Nameplates are now |cff00ff00ON!|r<<--") else return print("-->>Grounding Totem Nameplates are now |cffff0000OFF!|r<<--") end
								end
							},
							NRT = {
								order = 2,
								type = "toggle",
								name = "Nature Resistance Totem",
								desc = "Toggles the showing and hiding of Nature Resistance Totem nameplates.",
								get = function() return self.db.profile.totemList["Nature Resistance Totem VI"] end,
								set = function(info,val) 
									self.db.profile.totemList["Nature Resistance Totem VI"] = not self.db.profile.totemList["Nature Resistance Totem VI"]
									if self.db.profile.totemList["Nature Resistance Totem VI"] then return print("-->>Nature Resistance Totem Nameplates are now |cff00ff00ON!|r<<--") else return print("-->>Nature Resistance Totem Nameplates are now |cffff0000OFF!|r<<--") end
								end
							},
							ST = {
								order = 3,
								type = "toggle",
								name = "Sentry Totem",
								desc = "Toggles the showing and hiding of Sentry Totem nameplates.",
								get = function() return self.db.profile.totemList["Sentry Totem"] end,
								set = function(info,val) 
									self.db.profile.totemList["Sentry Totem"] = not self.db.profile.totemList["Sentry Totem"]
									if self.db.profile.totemList["Sentry Totem"] then return print("-->>Sentry Totem Nameplates are now |cff00ff00ON!|r<<--") else return print("-->>Sentry Totem Nameplates are now |cffff0000OFF!|r<<--") end
								end
							},
							WFT = {
								order = 4,
								type = "toggle",
								name = "Windfury Totem",
								desc = "Toggles the showing and hiding of Windfury Totem nameplates.",
								get = function() return self.db.profile.totemList["Windfury Totem"] end,
								set = function(info,val) 
									self.db.profile.totemList["Windfury Totem"] = not self.db.profile.totemList["Windfury Totem"]
									if self.db.profile.totemList["Windfury Totem"] then return print("-->>Windfury Totem Nameplates are now |cff00ff00ON!|r<<--") else return print("-->>Windfury Totem Nameplates are now |cffff0000OFF!|r<<--") end
								end
							},
							WAT = {
								order = 5,
								type = "toggle",
								name = "Wrath of Air Totem",
								desc = "Toggles the showing and hiding of Wrath of Air Totem nameplates.",
								get = function() return self.db.profile.totemList["Wrath of Air Totem"] end,
								set = function(info,val) 
									self.db.profile.totemList["Wrath of Air Totem"] = not self.db.profile.totemList["Wrath of Air Totem"]
									if self.db.profile.totemList["Wrath of Air Totem"] then return print("-->>Wrath of Air Totem Nameplates are now |cff00ff00ON!|r<<--") else return print("-->>Wrath of Air Totem Nameplates are now |cffff0000OFF!|r<<--") end
								end
							},
						},
					},
				},
			},
			BossSpecialOptFrame = {
		        order = 5,
		        type  = "group",
       			name  = "Boss Encounters",
		        args = {
					Yogg0 = {
						type = "group",
						name = "Yogg Zero Lights",
						desc = "Toggle options for Marked Immortals Guardians and Immortals Guardians",
						args = {
							MIG = {
								type = "group",
								name = "Marked Immortal Guardians",
								desc = "Toggle options for Marked Immortals Guardians",
								args = {
									header = {
										order = 1,
										type = "header",
										name = "Marked Immortal Guardians",
									},
									description = {
										order = 2,
										type = "description",
										name = "Marked Immortal Guardians can have their nameplates turned off or kept on.",
									},
									Show = {
										order = 3,
										type = "toggle",
										name = "Show Nameplates",
										desc = "Toggles the showing and hiding of Wrath of Air Totem nameplates.",
										get = function() return self.db.profile.bossShow["Marked Immortal Guardian"] end,
										set = function(info,val) 
											self.db.profile.bossShow["Marked Immortal Guardian"] = not self.db.profile.bossShow["Marked Immortal Guardian"]
											if self.db.profile.bossShow["Marked Immortal Guardian"] then return print("-->>Marked Immortal Guardian Nameplates are now |cff00ff00ON!|r<<--") else return print("-->>Marked Immortal Guardian Nameplates are now |cffff0000OFF!|r<<--") end
										end
									},
									description2 = {
										order = 4,
										type = "description",
										name = "Marked Immortal Guardians can have special more visual nameplates to allow better recognition.",
									},
									Special = {
										order = 5,
										type = "toggle",
										name = "Special Nameplates",
										desc = "Toggles the showing and hiding of Special nameplates.",
										get = function() return self.db.profile.bossSpecial["Marked Immortal Guardian"] end,
										set = function(info,val) 
											self.db.profile.bossSpecial["Marked Immortal Guardian"] = not self.db.profile.bossSpecial["Marked Immortal Guardian"]
											if self.db.profile.bossSpecial["Marked Immortal Guardian"] then return print("-->>Special Nameplates for Marked Immortal Guardians are now |cff00ff00ON!|r<<--") else return print("-->>Special Nameplates for Marked Immortal Guardians are now |cffff0000OFF!|r<<--") end
										end
									},
								},
							},
							IG = {
								type = "group",
								name = "Immortal Guardians",
								desc = "Toggle options for Immortals Guardians",
								args = {
									header = {
										order = 1,
										type = "header",
										name = "Immortal Guardians",
									},
									description = {
										order = 2,
										type = "description",
										name = "Immortal Guardians can have their nameplates turned off or kept on.",
									},
									Show = {
										order = 3,
										type = "toggle",
										name = "Show Nameplates",
										desc = "Toggles the showing and hiding of Wrath of Air Totem nameplates.",
										get = function() return self.db.profile.bossShow["Immortal Guardian"] end,
										set = function(info,val) 
											self.db.profile.bossShow["Immortal Guardian"] = not self.db.profile.bossShow["Immortal Guardian"]
											if self.db.profile.bossShow["Immortal Guardian"] then return print("-->>Immortal Guardian Nameplates are now |cff00ff00ON!|r<<--") else return print("-->>Immortal Guardian Nameplates are now |cffff0000OFF!|r<<--") end
										end
									},
									description2 = {
										order = 4,
										type = "description",
										name = "Immortal Guardians can have special more visual nameplates to allow better recognition.",
									},
									Special = {
										order = 5,
										type = "toggle",
										name = "Special Nameplates",
										desc = "Toggles the showing and hiding of Special nameplates.",
										get = function() return self.db.profile.bossSpecial["Immortal Guardian"] end,
										set = function(info,val) 
											self.db.profile.bossSpecial["Immortal Guardian"] = not self.db.profile.bossSpecial["Immortal Guardian"]
											if self.db.profile.bossSpecial["Immortal Guardian"] then return print("-->>Special Nameplates for Immortal Guardians are now |cff00ff00ON!|r<<--") else return print("-->>Special Nameplates for Immortal Guardians are now |cffff0000OFF!|r<<--") end
										end
									},
								},
							},
						},
					},
					Ony = {
						type = "group",
						name = "Onyxia",
						desc = "Toggle options for Onyxian Whelps.",
						args = {
							WLP = {
								type = "group",
								name = "Onyxian Whelp",
								desc = "Toggle options for Onyxian Whelp",
								args = {
									header = {
										order = 1,
										type = "header",
										name = "Onyxian Whelps",
									},
									description = {
										order = 2,
										type = "description",
										name = "Onyxian Whelps can have their nameplates turned off or kept on.",
									},
									Show = {
										order = 3,
										type = "toggle",
										name = "Show Nameplates",
										desc = "Toggles the showing and hiding of Onyxian Whelp nameplates.",
										get = function() return self.db.profile.bossShow["Onyxian Whelp"] end,
										set = function(info,val) 
											self.db.profile.bossShow["Onyxian Whelp"] = not self.db.profile.bossShow["Onyxian Whelp"]
											if self.db.profile.bossShow["Onyxian Whelp"] then return print("-->>Onyxian Whelp Nameplates are now |cff00ff00ON!|r<<--") else return print("-->>Onyxian Whelp Nameplates are now |cffff0000OFF!|r<<--") end
										end
									},
									description2 = {
										order = 4,
										type = "description",
										name = "Onyxian Whelp nameplates can be shown or hidden depending on their threat levels:",
									},
									high = {
										order = 5,
										type = "toggle",
										name = "Show High Threat",
										desc = "Toggles the showing and hiding of of Ony Whelps at high threat.",
										get = function() return self.db.profile.bossThreatHigh["Onyxian Whelp"] end,
										set = function(info,val) 
											self.db.profile.bossThreatHigh["Onyxian Whelp"] = not self.db.profile.bossThreatHigh["Onyxian Whelp"]
											if self.db.profile.bossThreatHigh["Onyxian Whelp"] then return print("-->>High Threat Onyxian Whelp nameplates are now |cff00ff00ON!|r<<--") else return print("-->>High Threat Onyxian Whelp nameplates are now |cffff0000OFF!|r<<--") end
										end
									},
									med = {
										order = 6,
										type = "toggle",
										name = "Show Medium Threat",
										desc = "Toggles the showing and hiding of of Ony Whelps at Medium threat.",
										get = function() return self.db.profile.bossThreatMed["Onyxian Whelp"] end,
										set = function(info,val) 
											self.db.profile.bossThreatMed["Onyxian Whelp"] = not self.db.profile.bossThreatMed["Onyxian Whelp"]
											if self.db.profile.bossThreatMed["Onyxian Whelp"] then return print("-->>Medium Threat Onyxian Whelp nameplates are now |cff00ff00ON!|r<<--") else return print("-->>Medium Threat Onyxian Whelp nameplates are now |cffff0000OFF!|r<<--") end
										end
									},
									low = {
										order = 7,
										type = "toggle",
										name = "Show Low Threat",
										desc = "Toggles the showing and hiding of of Ony Whelps at Low threat.",
										get = function() return self.db.profile.bossThreatLow["Onyxian Whelp"] end,
										set = function(info,val) 
											self.db.profile.bossThreatLow["Onyxian Whelp"] = not self.db.profile.bossThreatLow["Onyxian Whelp"]
											if self.db.profile.bossThreatLow["Onyxian Whelp"] then return print("-->>Low Threat Onyxian Whelp nameplates are now |cff00ff00ON!|r<<--") else return print("-->>Low Threat Onyxian Whelp nameplates are now |cffff0000OFF!|r<<--") end
										end
									},
								},
							},
						},
					},
				},
			},
		},
	}

    LibStub("AceConfig-3.0"):RegisterOptionsTable("Tidy Plates: Clean Plates Options:", self.options)
	self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Tidy Plates: Clean Plates Options:", "Tidy Plates: Clean Plates")
	self:RegisterChatCommand("cp", function() 
        InterfaceOptionsFrame_OpenToCategory(self.optionsFrame) 
    end)
end