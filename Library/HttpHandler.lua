-- FLUX
local require = shared.import("require")

-- SERVICES
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

-- SCRIPT
local HttpHandler = {}
HttpHandler.__index = HttpHandler

-- LOCAL

-- FUNCTIONS
function HttpHandler.new()
	local self = setmetatable({
		--@@ PUBLIC
		
		--@@ PRIVATE
		_messagePrefix = "[HttpHandler] ",
	}, HttpHandler)
	
	return self
end

function HttpHandler:GetAsyncWithPcall(url, nocache, headers)
	local success, message = pcall(function()
		return HttpService:GetAsync(url or "", nocache or false, headers or nil)
	end)
	
	if not success then
		warn(self._messagePrefix.."ERROR HANDLED: "..message)
	end
	
	return success, message
end

function HttpHandler:PostAsyncWithPcall(url, data, content_type, compress, headers)
	local success, message = pcall(function()
		return HttpService:PostAsync(url or "", data or "", content_type or Enum.HttpContentType.ApplicationJson, compress or false, headers or nil)
	end)
	
	if not success then
		warn(self._messagePrefix.."ERROR HANDLED: "..message)
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
return HttpHandler.new()