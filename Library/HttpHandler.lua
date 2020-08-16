--[[
	HttpsHandler.lua
	--------------------
	Author(s): AdministratorGnar
--]]

-- FLUX
local require = shared.import("require")

-- SERVICES
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

-- VARIABLES
local messagePrefix = "[HttpHandler] "

-- SCRIPT
local HttpHandler = {} 
	
	-- LOCAL
	
	-- FUNCTIONS
	function HttpHandler:GetAsyncWithPcall(url, nocache, headers)
		local success, message = pcall(function()
			return HttpService:GetAsync(url or "", nocache or false, headers or nil)
		end)
		return success, message
	end
	
	function HttpHandler:PostAsyncWithPcall(url, data, content_type, compress, headers)
		local success, message = pcall(function()
			return HttpService:PostAsync(url or "", data or "", content_type or Enum.HttpContentType.ApplicationJson, compress or false, headers or nil)
		end)
		
		if not success then
			warn(messagePrefix.."ERROR HANDLED: "..message)
		end
		
		return success, message
	end
	
	function HttpHandler:JSONEncode(input)
		return HttpService:JSONEncode(input)
	end

	function HttpHandler:JSONDecode(input)
		return HttpService:JSONDecode(input)
	end

-- RETURN
return HttpHandler