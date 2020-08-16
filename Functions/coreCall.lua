--[[
	coreCall.lua
	--------------------
	Author(s): Fractality_alt
--]]

-- SERVICES
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")

return function(method, ...)
	local MAX_RETRIES = 8
	
	local result = {}
	for retries = 1, MAX_RETRIES do
		result = {pcall(StarterGui[method], StarterGui, ...)}
		if result[1] then
			break
		end
		RunService.Stepped:Wait()
	end
end