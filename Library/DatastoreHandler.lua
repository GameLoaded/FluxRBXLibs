--[[
	DatastoreHandler.lua
	--------------------
	Author(s): AdministratorGnar
--]]

-- FLUX
local require = shared.import("require")

-- SERVICES
local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")

-- SCRIPT
local DatastoreHandler = {Datastore = DataStoreService:GetDataStore("playerData377"), orderedDatastore = DataStoreService:GetOrderedDataStore("playerData376")}

	-- BUILT-IN
	local function recursiveDataStore(binding)
		local success, data
		repeat
			-- Loop until we can successfully execute the function.
			success = pcall(function() data = binding() end)
			if not success then
				wait(1)
				warn("Datastore failed to repeat a request.")
			end
		until success == true
		-- Return the data and if it was successful.
		return success, data
	end
	
	local function saveData(userId, data)
		-- Use the recursive function to execute the save function.
		local success = recursiveDataStore(function() return DatastoreHandler.Datastore:SetAsync("userId-"..userId, data) end)
		pcall(function() DatastoreHandler.orderedDatastore:SetAsync(Players:GetNameFromUserIdAsync(userId), data.Wins) end)
		
		if not success then
			warn("DataStore failed to save data for user "..userId)
		end
		return nil
	end
	
	local function getData(userId)
		-- Use the recursive function to grab the data from the player.
		local success, data = recursiveDataStore(function() return DatastoreHandler.Datastore:GetAsync("userId-"..userId) end)
		if not success then
			-- If it wasn't a success then return nil and report error.
			warn("Datastore failed to get data for user "..userId)
			return nil
		elseif not data then
			-- If it was a success but there isn't any data then create the new data.
			data = {}
		end
		return data
	end

	-- REMOTE
	DatastoreHandler.GetData = function(userId)
		return getData(userId)
	end

	DatastoreHandler.SaveData = function(userId, data)
		return saveData(userId, data)
	end
	
	DatastoreHandler.AutoSaveData = function(data)
		-- Log that we are autosaving.
		warn("AUTOSAVING DATA:")
		for _, player in pairs(Players:GetPlayers()) do
			-- If there is data for this player.
			if data[player] then
				print("AUTOSAVING: "..player.Name)
				saveData(player.UserId, data[player])
			else
				warn("AUTOSAVING: NO DATA: "..player.Name)
			end
		end
	end

return DatastoreHandler