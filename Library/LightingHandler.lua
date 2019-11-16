--[[
	LightingHandler.lua
	--------------------
	Author(s): ThunderGemios10
--]]

-- FLUX
local require = shared.import("require")

-- IMPORT

-- SERVICES
local Lighting = game:GetService("Lighting")

-- SCRIPT
local LightingHandler = {}
	
	-- LOCAL
	
	-- FUNCTIONS
	function LightingHandler:GetMinuteAfterMidnight()
		return Lighting:GetMinutesAfterMidnight()
	end
	
	function LightingHandler:GetMoonDirection()
		return Lighting:GetMoonDirection()
	end
	
	function LightingHandler:GetMoonPhase()
		return Lighting:GetMoonPhase()
	end
	
	function LightingHandler:GetClockTime()
		return Lighting.ClockTime
	end
	
	function LightingHandler:SetMinutesAfterMidnight(minutes)
		Lighting:SetMinutesAfterMidnight(minutes)
	end
	
-- RETURN
return LightingHandler