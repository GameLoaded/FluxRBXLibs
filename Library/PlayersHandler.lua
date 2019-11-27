--[[
	PlayerHandler.lua
	--------------------
	Author(s): ThunderGemios10
--]]

-- FLUX
local require = shared.import("require")

-- IMPORT

-- SERVICES
local Players = game:GetService("Players")

-- SCRIPT
local PlayersHandler = {}
	
	-- LOCAL
	
	-- FUNCTION
	function PlayersHandler:GetPlayers()
		return Players:GetPlayers()
	end
	
	function PlayersHandler:GetRankInGroup(player, groupId)
		assert(player ~= typeof(Instance), "Player is not an instance!")
		assert(groupId ~= typeof(string), "Group ID is not a string!")
		
		local rank = 0
		
		local success, message = pcall(function()
			rank = player:GetRankInGroup(groupId)
		end)
		
		if not success then
			warn(message)
		end
		
		return rank
	end
	
	function PlayersHandler:GetRoleInGroup(player, groupId)
		assert(player ~= typeof(Instance), "Player is not an instance!")
		assert(groupId ~= typeof(string), "Group ID is not a string!")
		
		local role = ""
		
		local success, message = pcall(function()
			role = player:GetRoleInGroup(groupId)
		end)
		
		if not success then
			warn(message)
		end
		
		return role
	end
	
-- RETURN
return PlayersHandler