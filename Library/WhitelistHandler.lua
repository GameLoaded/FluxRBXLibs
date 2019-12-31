--[[
	WhitelistHandler.lua
	--------------------
	 Author(s): ThunderGemios10
--]]

-- FLUX
local Flux = shared
local require = Flux.import("require")

-- IMPORT

-- VARIABLES
local whitelisted = false

-- TABLES
local playerWhitelist = {52562955} -- User Ids
local placeWhitelist = {[1] = true} -- Place Ids

-- SCRIPT
local WhitelistHandler = {}
	
	-- LOCAL
	local function isWhitelisted(player)	
		for _, userId in pairs(playerWhitelist) do
			if player.UserId == userId then
				return true
			end
		end
		return false
	end
	
	local function removePlayerWhitelist(id)
		for index, userId in pairs(playerWhitelist) do
			if id == userId then
				table.remove(playerWhitelist, index)
				break
			end
		end
	end
	
	-- FUNCTIONS
	function WhitelistHandler:ToggleWhitelist(toggle)
		whitelisted = toggle
	end
	
	function WhitelistHandler:AddPlaceWhitelist(placeId)
		placeWhitelist[placeId] = true
	end
	
	function WhitelistHandler:RemovePlaceWhitelist(placeId)
		placeWhitelist[placeId] = nil
	end

	function WhitelistHandler:AddPlayerWhitelist(userId)
		table.insert(playerWhitelist, userId)
	end
	
	function WhitelistHandler:RemovePlayerWhitelist(userId)
		removePlayerWhitelist(userId)
	end
	
	function WhitelistHandler:IsWhitelisted()
		return whitelisted
	end
	
	function WhitelistHandler:IsPlaceWhitelisted(placeId)
		return placeWhitelist[placeId]
	end

	function WhitelistHandler:IsPlayerWhitelisted(player)
		return isWhitelisted(player)
	end
	
	-- EXEC
	
-- RETURN
return WhitelistHandler