--[[
	TextHandler.lua
	--------------------
	Author(s): ThunderGemios10
	--------------------
	Description: Handles ROBLOX's TextService.
--]]

-- FLUX
local require = shared.import("require")

-- IMPORT

-- SERVICES
local TextService = game:GetService("TextService")

-- DEFINITIONS

-- SCRIPT
local TextHandler = {}

	-- LOCAL
	local function filterStringAsync(text, userId, textContext)
		assert(text ~= "", "String is empty!")
		local filteredString = ""
		
		local success, message = pcall(function()
			filteredString = TextService:FilterStringAsync(text, userId, textContext or Enum.TextFilterContext.PrivateChat)
		end)
		
		if success then
			return filteredString
		else
			error(message)
		end
	end
	
	local function getChatForUserAsync(stringObject, targetUserId)
		assert(stringObject ~= nil, "String object is nil!")
		local filteredString
		
		local success, message = pcall(function()
			filteredString = stringObject:GetChatForUserAsync(targetUserId)
		end)
		
		if success then
			return filteredString
		else
			error(message)
		end
	end
	
	-- FUNCTIONS
	function TextHandler:FilterText(text, userId, textContext)
		local stringObject = filterStringAsync(text, userId, textContext)
		local filteredString
		
		if stringObject then
			filteredString = getChatForUserAsync(stringObject, userId)
		end
		
		return filteredString
	end
	
-- RETURN
return TextHandler