
CP = LibStub("AceAddon-3.0"):NewAddon("CP", "AceConsole-3.0")
local Media = LibStub("LibSharedMedia-3.0")
local DataBroker = LibStub:GetLibrary("LibDataBroker-1.1",true)
if not TidyPlatesThemeList then TidyPlatesThemeList = {} end
TidyPlatesThemeList["CP"] = {}

local classicon = "Interface\\Addons\\TidyPlates_CleanPlates\\Class\\"
local totem = "Interface\\Addons\\TidyPlates_CleanPlates\\Totem\\"

function CP:OnInitialize()
	local options = { 
		type = "group", 
		args = {
			Desc = {
				type = "description",
				order = 1,
				name = "Clear and easy to use nameplate theme for use with TidyPlates.\nFeel free to email me at |cff00ff00Shamtasticle@gmail.com|r\nSyronius, of Black Dragonflight - US <Fallout>",
			},
--[[Options Frames]]--
			header = {
				order = 2,
				type = "header",
				name = "Tidy Plates: Clean Plates v1.9g",
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
					hptextdesc = {
						order = 2,
						type = "description",
						name = "\nHP Special Text is the center text displaying the truncated HP amount and HP percentage on nameplates.\n",
					},
					hptext = {
						order = 3,
						type = "toggle",
						name = "Show HP Special Text",
						desc = "Toggles the showing and hiding of HP Special Text",
						get = function() return self.db.profile.hptext end,
						set = function(info,val) 
							self.db.profile.hptext = not self.db.profile.hptext
							if self.db.profile.hptext then return print("-->>HP Special Text is now |cff00ff00ON!|r<<--") else return print("-->>HP Special Text is now |cffff0000OFF!|r<<--") end
						end
					},
					hundtext = {
						order = 4,
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
						order = 5,
						type = "toggle",
						name = "Show Full HP and 100\%",
						desc = "Toggles the showing and hiding of Full HP amount and 100\% HP Text.",
						get = function() return self.db.profile.fullstring end,
						set = function(info,val) 
							self.db.profile.fullstring = not self.db.profile.fullstring
							if self.db.profile.fullstring then return print("-->>Full HP ammount and 100\% HP Text is now |cff00ff00ON!|r<<--") else return print("-->>Full HP ammount and 100\% HP Text is now |cffff0000OFF!|r<<--") end
						end
					},
					casttext = {
						order = 5,
						type = "toggle",
						name = "Show Spell Cast Text",
						desc = "Toggles the showing and hiding of Spell Cast Text",
						get = function() return self.db.profile.casttext end,
						set = function(info,val) 
							self.db.profile.casttext = not self.db.profile.casttext
							if self.db.profile.casttext then return print("-->>Spell Cast Text is now |cff00ff00ON!|r<<--") else return print("-->>Spell Cast Text is now |cffff0000OFF!|r<<--") end
						end
					},
					fctextdesc = {
						order = 6,
						type = "description",
						name = '\nHybrid Class Faction Champions can have a "spec" text next to their name showing which role they are. \n\n|cffff0000Red|r for dps and |cff00ff00green|r for healer.\n',
					},
					fctext = {
						order = 7,
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
						name = "Icon Options",
					},
					classiconsdesc = {
						order = 2,
						type = "description",
						name = "\nClass icons are used to show which classes PvP flagged players are with a wow icon of their class on their nameplate.\n",
					},
					classicons = {
						order = 3,
						type = "toggle",
						name = "Show PvP Class Icons",
						desc = "Toggles the showing and hiding of class icons on PvP flagged players",
						get = function() return self.db.profile.classicons end,
						set = function(info,val) 
							self.db.profile.classicons = not self.db.profile.classicons
							if self.db.profile.classicons then return print("-->>Class Icons are now |cff00ff00ON!|r<<--") else return print("-->>Class Icons are now |cffff0000OFF!|r<<--") end
						end
					},
					classiconsWidth = {
						type = "range",
						order = 4,
						name = "|cffffffffPvP Icon Width|r",
						desc = "For best looks, keep this the same as the height. Default is 22.",
						get = function(info) return self.db.profile.classiconsWidth end,
						set = function(info,v)
							self.db.profile.classiconsWidth = v
							TidyPlatesThemeList.CP.normal.specialArt.width = v
								end,								
						step = 0.5,
						min = 10,
						max = 50,
						isPercent = false,
						disabled = function() return not self.db.profile.classicons end,  -- Disable if partyicons is false
					},
					classiconsHeight = {
						type = "range",
						order = 5,
						name = "|cffffffffPvP Icon Height|r",
						desc = "For best looks, keep this the same as the width. Default is 22.",
						get = function(info) return self.db.profile.classiconsHeight end,
						set = function(info,v)
							self.db.profile.classiconsHeight = v
							TidyPlatesThemeList.CP.normal.specialArt.height = v
								end,								
						step = 0.5,
						min = 10,
						max = 50,
						isPercent = false,
						disabled = function() return not self.db.profile.classicons end,  -- Disable if classicons is false
					},
					classiconsY = {
						type = "range",
						order = 6,
						name = "|cffffffffPvP Icon Y|r",
						desc = "Default is -2, adjust to move the icon up or down.",
						get = function(info) return self.db.profile.classiconsY end,
						set = function(info,v)
							self.db.profile.classiconsY = v
							TidyPlatesThemeList.CP.normal.specialArt.y = v
								end,								
						step = 0.5,
						min = -20,
						max = 60,
						isPercent = false,
						disabled = function() return not self.db.profile.classicons end,  -- Disable if classicons is false
					},
					classiconsX = {
						type = "range",
						order = 7,
						name = "|cffffffffPvP Icon X|r",
						desc = "Default is -74, adjust to move the icon left or right.",
						get = function(info) return self.db.profile.classiconsX end,
						set = function(info,v)
							self.db.profile.classiconsX = v
							TidyPlatesThemeList.CP.normal.specialArt.x = v
								end,								
						step = 0.5,
						min = -80,
						max = 80,
						isPercent = false,
						disabled = function() return not self.db.profile.classicons end,  -- Disable if classicons is false
					},
					partyicons = {
						order = 8,
						type = "toggle",
						name = "Show Party Class Icons",
						desc = "Toggles the showing and hiding of class icons on raid/party members",
						get = function() return self.db.profile.partyicons end,
						set = function(info,val) 
							self.db.profile.partyicons = not self.db.profile.partyicons
							if self.db.profile.partyicons then return print("-->>Party Icons are now |cff00ff00ON!|r<<--") else return print("-->>Party Icons are now |cffff0000OFF!|r<<--") end
						end
					},
					partyiconsWidth = {
						type = "range",
						order = 9,
						name = "|cffffffffParty Icon Width|r",
						desc = "For best looks, keep this the same as the height. Default is 22.",
						get = function(info) return self.db.profile.partyiconsWidth end,
						set = function(info,v)
							self.db.profile.partyiconsWidth = v
							TidyPlatesThemeList.CP.normal.partyIcons.width = v
								end,								
						step = 0.5,
						min = 10,
						max = 50,
						isPercent = false,
						disabled = function() return not self.db.profile.partyicons end,  -- Disable if partyicons is false
					},
					partyiconsHeight = {
						type = "range",
						order = 10,
						name = "|cffffffffParty Icon Height|r",
						desc = "For best looks, keep this the same as the width. Default is 22.",
						get = function(info) return self.db.profile.partyiconsHeight end,
						set = function(info,v)
							self.db.profile.partyiconsHeight = v
							TidyPlatesThemeList.CP.normal.partyIcons.height = v
								end,								
						step = 0.5,
						min = 10,
						max = 50,
						isPercent = false,
						disabled = function() return not self.db.profile.partyicons end,  -- Disable if partyicons is false
					},
					partyiconsY = {
						type = "range",
						order = 11,
						name = "|cffffffffParty Icon Y|r",
						desc = "Default is -2, adjust to move the icon up or down.",
						get = function(info) return self.db.profile.partyiconsY end,
						set = function(info,v)
							self.db.profile.partyiconsY = v
							TidyPlatesThemeList.CP.normal.partyIcons.y = v
								end,								
						step = 0.5,
						min = -20,
						max = 60,
						isPercent = false,
						disabled = function() return not self.db.profile.partyicons end,  -- Disable if partyicons is false
					},
					partyiconsX = {
						type = "range",
						order = 12,
						name = "|cffffffffParty Icon X|r",
						desc = "Default is -74, adjust to move the icon left or right.",
						get = function(info) return self.db.profile.partyiconsX end,
						set = function(info,v)
							self.db.profile.partyiconsX = v
							TidyPlatesThemeList.CP.normal.partyIcons.x = v
								end,								
						step = 0.5,
						min = -80,
						max = 80,
						isPercent = false,
						disabled = function() return not self.db.profile.partyicons end,  -- Disable if partyicons is false
					},
					fcicondesc = {
						order = 13,
						type = "description",
						name = '\nFaction Champion class icons work just like PvP Class icons.\n',
					},
					fcicons = {
						order = 14,
						type = "toggle",
						name = "Show Boss Class Icons",
						desc = "Toggles the showing and hiding of Faction Champion class icons",
						get = function() return self.db.profile.fcicons end,
						set = function(info,val) 
							self.db.profile.fcicons = not self.db.profile.fcicons
							if self.db.profile.fcicons then return print("-->>Faction Champion Class Icons are now |cff00ff00ON!|r<<--") else return print("-->>Faction Champion Class Icons are now |cffff0000OFF!|r<<--") end
						end
					},
					totemsdesc = {
						order = 15,
						type = "description",
						name = "\nTotem icons are shown next to the nameplates of dropped totems. This includes totems from Faction Champions.\n",
					},
					totems = {
						order = 16,
						type = "toggle",
						name = "Show Totem Icons",
						desc = "Toggles the showing and hiding of totem icons.",
						get = function() return self.db.profile.totems end,
						set = function(info,val) 
							self.db.profile.totems = not self.db.profile.totems
							if self.db.profile.totems then return print("-->>Totem Icons are now |cff00ff00ON!|r<<--") else return print("-->>Totem Icons are now |cffff0000OFF!|r<<--") end
						end
					},
					totemiconsWidth = {
						type = "range",
						order = 17,
						name = "|cffffffffTotem Icon Width|r",
						desc = "For best looks, keep this the same as the height. Default is 26.",
						get = function(info) return self.db.profile.totemiconsWidth end,
						set = function(info,v)
							self.db.profile.totemiconsWidth = v
							TidyPlatesThemeList.CP.totem.specialArt.width = v
								end,								
						step = 0.5,
						min = 10,
						max = 50,
						isPercent = false,
						disabled = function() return not self.db.profile.totems end,  -- Disable if totems is false
					},
					totemiconsHeight = {
						type = "range",
						order = 18,
						name = "|cffffffffTotem Icon Height|r",
						desc = "For best looks, keep this the same as the width. Default is 26.",
						get = function(info) return self.db.profile.totemiconsHeight end,
						set = function(info,v)
							self.db.profile.totemiconsHeight = v
							TidyPlatesThemeList.CP.totem.specialArt.height = v
								end,								
						step = 0.5,
						min = 10,
						max = 50,
						isPercent = false,
						disabled = function() return not self.db.profile.totems end,  -- Disable if totems is false
					},
					totemiconsY = {
						type = "range",
						order = 19,
						name = "|cffffffffTotem Icon Y|r",
						desc = "Default value is 0, adjust to move the icon up or down.",
						get = function(info) return self.db.profile.totemiconsY end,
						set = function(info,v)
							self.db.profile.totemiconsY = v
							TidyPlatesThemeList.CP.totem.specialArt.y = v
								end,								
						step = 0.5,
						min = -20,
						max = 60,
						isPercent = false,
						disabled = function() return not self.db.profile.totems end,  -- Disable if totems is false
					},
					totemiconsX = {
						type = "range",
						order = 20,
						name = "|cffffffffTotem Icon X|r",
						desc = "Default value is -0, adjust to move the icon left or right.",
						get = function(info) return self.db.profile.totemiconsX end,
						set = function(info,v)
							self.db.profile.totemiconsX = v
							TidyPlatesThemeList.CP.totem.specialArt.x = v
								end,								
						step = 0.5,
						min = -80,
						max = 80,
						isPercent = false,
						disabled = function() return not self.db.profile.totems end,  -- Disable if totems is false
					},
				},
			},
			NameplateOptFrame = {
		        order = 3,
		        type  = "group",
       			name  = "Nameplate Options",
		        args = {
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
										end,								
								step = 0.05,
								min = 0.3,
								max = 2,
								isPercent = true,
							},
						},
					},					
					NamePlatesHeader = {
						order = 1,
						type = "header",
						name = "Nameplate Options",
					},
					NamePlatesdesc = {
						order = 2,
						type = "description",
						name = "\nSet friendly health bar colors and toggle the display of nameplates for various objects:\n",
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
							-- Apply the new color to friendly health bars as needed
						end,
						hasAlpha = true,  -- Enable opacity control for the color picker
					},
					worms = {
						order = 4,
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
						order = 5,
						type = "toggle",
						name = "Mirror Images(Not working)",
						desc = "Toggles the showing and hiding of Mirror Image nameplates.",
						get = function() return self.db.profile.showimages end,
						set = function(info,val) 
							self.db.profile.showimages = not self.db.profile.showimages
							if self.db.profile.showimages then return print("-->>Mirror Image Nameplates are now |cff00ff00ON!|r<<--") else return print("-->>Mirror Image Nameplates are now |cffff0000OFF!|r<<--") end
						end
					},
					fiends = {
						order = 6,
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
						order = 7,
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
						order = 8,
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
						order = 9,
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
						order = 10,
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
						order = 11,
						type = "toggle",
						name = "Army Ghouls",
						desc = "Toggles the showing and hiding of Army of the Dead Ghoul nameplates.",
						get = function() return self.db.profile.showghouls end,
						set = function(info,val) 
							self.db.profile.showghouls = not self.db.profile.showghouls
							if self.db.profile.showghouls then return print("-->>Army Ghoul Nameplates are now |cff00ff00ON!|r<<--") else return print("-->>Army Ghoul Nameplates are now |cffff0000OFF!|r<<--") end
						end
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
	local defaults 	= {
		profile = {
			hundtext = false,
			fullstring = false,
			hptext = true,
			fctext = true,
			casttext = true,
			fcicons = true,
			classicons = true,
			classiconsY = -2,
			classiconsX = -74,
			classiconsWidth = 22,
			classiconsHeight = 22,
			friendlyHealthBarColor = { r = 0, g = 0, b = 0.9, a = 0.9 },
			partyicons = true,
			partyiconsY = -2,
			partyiconsX = -74,
			partyiconsWidth = 22,
			partyiconsHeight = 22,
			totemicons = true,
			showtotems = true,
			showworms = true,
			showwolves = true,
			showtreants = true,
			showimages = true,
			showfiends = true,
			showsnakes = true,
			showelementals = true,
			showghouls = true,
			totems = true,
			totemiconsWidth = 26,
			totemiconsHeight = 26,
			totemiconsX = -0,
			totemiconsY = 0,
			Normal_scale = 0.8,
			Elite_scale = 1.1,
			Boss_scale = 1.2,
			Pet_scale = 1,
			Totem_scale = 0.8,
			Special_scale = 1.2,
			Empty_scale = 0.3,
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

	LibStub("AceConfig-3.0"):RegisterOptionsTable("Tidy Plates: Clean Plates Options:", options)
	self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Tidy Plates: Clean Plates Options:", "Tidy Plates: Clean Plates")
	self:RegisterChatCommand("cp", function () InterfaceOptionsFrame_OpenToCategory(self.optionsFrame) end)
	self.message = "Welcome to Tidy Plates: Clean Plates theme by Syronius! |cff00ffff/Type cp for additional options!|r"
	self.db = LibStub("AceDB-3.0"):New("CPDB", defaults)
	local db = self.db.profile
	
	TidyPlatesThemeList.CP.normal.specialArt.y = db.classiconsY
	TidyPlatesThemeList.CP.normal.specialArt.x = db.classiconsX
	TidyPlatesThemeList.CP.normal.specialArt.height = db.classiconsHeight
	TidyPlatesThemeList.CP.normal.specialArt.width = db.classiconsWidth

	TidyPlatesThemeList.CP.normal.partyIcons.y = db.partyiconsY
	TidyPlatesThemeList.CP.normal.partyIcons.x = db.partyiconsX
	TidyPlatesThemeList.CP.normal.partyIcons.height = db.partyiconsHeight
	TidyPlatesThemeList.CP.normal.partyIcons.width = db.partyiconsWidth

	TidyPlatesThemeList.CP.totem.specialArt.height = db.totemiconsHeight
	TidyPlatesThemeList.CP.totem.specialArt.width = db.totemiconsWidth
	TidyPlatesThemeList.CP.totem.specialArt.x = db.totemiconsX
	TidyPlatesThemeList.CP.totem.specialArt.y = db.totemiconsY
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

-- Function to get the class icon path for a unit
local function GetClassIconPath(unit)
    local _, class = UnitClass(unit)
    if class then
        return classicon .. class
    end
    return nil
end

function SetPartyIcons(unit)
	if not CP.db.profile.partyicons then 
		return nil 
	end
	if unit.reaction ~= "FRIENDLY" or not UnitIsPlayer(unit.name) then
        return nil
    end

    -- Attempt to get the class icon path
    return GetClassIconPath(unit.name)
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
					if class then return classicon..class end
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
function SetSpecialText2(unit)
	if CP.db.profile.casttext then
		local spellname
		if unit.isCasting then 
			spellname = UnitCastingInfo("target") 
			if spellname == nil then
				spellname = UnitChannelInfo("target")
			end
			return spellname
		else return ""
		end
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
local function SetStyle(unit)
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
TidyPlatesThemeList["CP"].SetSpecialText = SetSpecialText
TidyPlatesThemeList["CP"].SetSpecialText2 = SetSpecialText2
TidyPlatesThemeList["CP"].SetSpecialText3 = SetSpecialText3
TidyPlatesThemeList["CP"].SetPartyIcons = SetPartyIcons
TidyPlatesThemeList["CP"].SetSpecialArt = SetSpecialArt
TidyPlatesThemeList["CP"].SetScale = SetScale
TidyPlatesThemeList["CP"].SetHealthbarColor = SetHealthbarColor