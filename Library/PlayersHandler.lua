--[[
	TeamsHandler.lua
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
		local success, message = pcall(function()
			return player:GetRankInGroup(groupId)
		end)
		
		return success, message
	end
	
	function PlayersHandler:GetRoleInGroup(player, groupId)
		assert(player ~= typeof(Instance), "Player is not an instance!")
		assert(groupId ~= typeof(string), "Group ID is not a string!")
		local success, message = pcall(function()
			return player:GetRoleInGroup(groupId)
		end)
		
		return success, message
	end
	
-- RETURN
return PlayersHandler