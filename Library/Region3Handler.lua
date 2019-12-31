--[[
	Region3Handler.lua
	--------------------
	Author(s): ThunderGemios10
--]]

-- FLUX
local Flux = shared
local require = Flux.import("require")

-- IMPORT
local PlayersHandler = require("PlayersHandler")

-- SERVICES

-- SCRIPT
local Region3Handler = {}
	
	-- LOCAL
	
	-- FUNCTIONS
	function Region3Handler:CreateRegion(object)
		return Region3.new(object.Position - (object.Size/2), object.Position + (object.Size/2))
	end
	
	function Region3Handler:GetPlayersInRegion(region)
		local players = PlayersHandler:GetPlayers()
		local playerCharacters = {}
		local charactersChecked = {}
		local playersInRegion = {}
		
		for _, player in pairs(players) do
			local character = player.Character
			local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
			
			if humanoidRootPart then
				table.insert(playerCharacters, humanoidRootPart)
			end
		end
		
		local partsInRegion = workspace:FindPartsInRegion3WithWhiteList(region, playerCharacters, #players)
		
		if #partsInRegion > 0 then
			for _, part in pairs(partsInRegion) do
				local character = part.Parent
				
				if not charactersChecked[character] then
					charactersChecked[character] = true
					local player = PlayersHandler:GetPlayerFromCharacter(character)
					
					if player then
						playersInRegion[player] = player
					end
				end
			end
		end
		
		return playersInRegion
	end
	
-- RETURN
return Region3Handler