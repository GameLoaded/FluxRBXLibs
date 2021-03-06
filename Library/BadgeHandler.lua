--[[
	BadgeHandler.lua
	--------------------
	Author(s): ThunderGemios10
--]]

-- FLUX
local require = shared.import("require")

-- SERVICES
local Players = game:GetService("Players")
local BadgeService = game:GetService("BadgeService")

-- SCRIPT
local BadgeHandler = {}

	-- BUILT-IN
	
	-- REMOTE
	function BadgeHandler:AwardBadge(player, badgeId)
		BadgeService:AwardBadge(player.UserId, badgeId)
	end
	
	function BadgeHandler:UserHasBadgeAsync(player, badgeId)
		local success, message = pcall(function()
			return BadgeService:UserHasBadgeAsync(player.UserId, badgeId)
		end)
		
		return success, message
	end
	
return BadgeHandler