--[[
	asset.lua
	--------------------
	Author(s): AdministratorGnar
--]]

-- VARIABLES
local assets = {}

-- FUNCTIONS
local function recursiveGetAssets(dir)
	for _, asset in pairs(dir:GetChildren()) do
		if not asset:IsA("Folder") then
			assets[asset.Name] = asset
		end
		recursiveGetAssets(asset)
	end
end

-- EXEC
do
	if not game:GetService("Players").LocalPlayer then
		recursiveGetAssets(game:GetService("ServerStorage")["Assets"])
	end
	recursiveGetAssets(game:GetService("ReplicatedStorage"):WaitForChild("Assets"))
end

-- RETURN
return function(name)
	if assets[name] then
		return assets[name]
	else
		warn("Attempted to fetch asset ("..name..")")
	end
end