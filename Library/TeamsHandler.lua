--[[
	TeamsHandler.lua
	--------------------
	Author(s): ThunderGemios10
--]]

-- FLUX
local require = shared.import("require")

-- IMPORT

-- SERVICES
local Teams = game:GetService("Teams")

-- SCRIPT
local TeamsHandler = {}
	
	-- LOCAL
	
	-- FUNCTIONS
	function TeamsHandler:GetTeams()
		return Teams:GetTeams()
	end
	
	function TeamsHandler:GetTeam(team)
		return Teams[team]
	end
	
-- RETURN
return TeamsHandler
