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

-- SCRIPT
local HttpHandler = {} 
	
	-- REMOTE
	function HttpHandler:GetAsyncWithPcall(url, nocache, headers)
		local success, message = pcall(function()
			return HttpService:GetAsync(url or "", nocache or false, headers or nil)
		end)
		return success, message
	end
	
	function HttpHandler:PostAsyncWithPcall(url, data, content_type, compress, headers)
		local success, message = pcall(function()
			return HttpService:PostAsync(url or "", data or "", content_type or "Enum.HttpContentType.ApplicationJson", compress or false, headers or nil)
		end)
		return success, message
	end
	
return HttpHandler