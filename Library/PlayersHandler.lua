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
PlayersHandler.__index = PlayersHandler

-- LOCAL

-- FUNCTIONS
function PlayersHandler.new()
	local self = setmetatable({
		--@@ PRIVATE
		_messagePrefix = "[PlayersHandler] "
	}, PlayersHandler)
	
	return self
end

function PlayersHandler:GetPlayers()
	return Players:GetPlayers()
end

function PlayersHandler:IsInGroup(player, groupId)
	assert(player ~= typeof(Instance), "Player is not an instance!")
	assert(groupId ~= typeof(string), "Group ID is not a string!")
	local isInGroup = false
	
	local success, message = pcall(function()
		isInGroup = player:IsInGroup(groupId)
	end)
	
	return isInGroup
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
	
	local role = "Guest"
	
	local success, message = pcall(function()
		role = player:GetRoleInGroup(groupId)
	end)
	
	if not success then
		warn(message)
	end
	
	return role
end

function PlayersHandler:GetUserThumbnailAsync(userId, thumbnailType, thumbnailSize)
	local content, isReady = "rbxasset://textures/ui/GuiImagePlaceholder.png", false
	
	local success, message = pcall(function()
		content, isReady = Players:GetUserThumbnailAsync(userId, thumbnailType, thumbnailSize)
	end)
	
	if not success then
		warn(self._messagePrefix.."ERROR HANDLED: "..message)
	end
	
	return content, isReady
end

-- RETURN
return PlayersHandler.new()