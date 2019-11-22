--[[
	require.lua
	--------------------
	Author(s): AdministratorGnar
--]]

-- SERVICES
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- VARIABLES
local modules = {}

-- FUNCTIONS
local function recursiveGetModules(dir)
	for _, module in pairs(dir:GetChildren()) do
		if module:IsA("ModuleScript") then
			modules[module.Name] = module
		end
		recursiveGetModules(module)
	end
end

-- EXEC
do
	if Players.LocalPlayer then
		recursiveGetModules(Players.LocalPlayer.PlayerScripts["Flux/client"])
	else
		recursiveGetModules(game:GetService("ServerScriptService")["Flux/server"])
	end
	recursiveGetModules(ReplicatedStorage:WaitForChild("Shared"))
end

-- RETURN
return function(...)
	local required = {}
	for place, name in pairs({...}) do
		if modules[name] then
			table.insert(required, place, require(modules[name]))
		else
			error("Could not find module '"..name.."'")
		end
	end
	return unpack(required) 	
end