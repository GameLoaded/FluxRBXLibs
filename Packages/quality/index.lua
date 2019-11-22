--[[
	quality.lua
	--------------------
	Author(s): AdministratorGnar
--]]

-- RETURN
return function()
	return UserSettings():GetService("UserGameSettings").SavedQualityLevel.Value
end