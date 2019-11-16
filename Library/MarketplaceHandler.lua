--[[
	MarketplaceHandler.lua
	--------------------
	Author(s): AdministratorGnar
--]]

-- FLUX
local require = shared.import("require")

-- SERVICES
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")

-- SCRIPT
local MarketplaceHandler = {MarketData = {}, 
	checkForPasses = {},
	developerProducts = {
			
		end
	}}

	-- BUILT-IN
	local function handleGamePassPurchase(player, passId, wasPurchased)
		if wasPurchased and MarketplaceHandler.MarketData[player] then
			-- Once a purchase goes through, we add it to the table.
			table.insert(MarketplaceHandler.MarketData[player], 1, passId)
			warn("Marketplace registered "..player.Name.."'s purchase of "..passId)
		end
	end
	
	local function forceRecheckPasses(player)
		warn("Marketplace is "..(MarketplaceHandler.MarketData[player] and "FORCE" or "FIRST-TIME").." refreshing "..player.Name.."'s ownership of gamepasses.")		
		
		MarketplaceHandler.MarketData[player] = {}
		for _, passId in pairs(MarketplaceHandler.checkForPasses) do
			if MarketplaceService:UserOwnsGamePassAsync(player.UserId, passId) then
				-- Force check all the passes owned by this player.
				table.insert(MarketplaceHandler.MarketData[player], 1, passId)
				print("Marketplace registered "..player.Name.."'s ownership of "..passId)
			end
		end
	end
	
	function MarketplaceService.ProcessReceipt(receiptInfo) 
	 
		local player = Players:GetPlayerByUserId(receiptInfo.PlayerId)
		if not player then 
			-- If the player left the game then we will mark the product as non-processed.
			return Enum.ProductPurchaseDecision.NotProcessedYet 
		end	
	
		local handler
		for productId, func in pairs(MarketplaceHandler.developerProducts) do
			if productId == receiptInfo.ProductId then
				-- Quick loop to find the function our product needs.
				handler = func 
				break
			end
		end
	 
		if not handler then 
			-- If there isn't a handler, mark it as done as there is nothing to do.
			return Enum.ProductPurchaseDecision.PurchaseGranted 
		else
			local success, message = pcall(handler, player, receiptInfo)
			if not success then
				-- If there is a handler but it errors then we mark as un-completed.
				warn("Marketplace failed to complete "..player.Name.."'s purchase of product "..receiptInfo.ProductId)
				return Enum.ProductPurchaseDecision.NotProcessedYet
			elseif not message then
				-- If there is a handler but it fails to mark it as complete then we mark as un-completed.
				warn("Marketplace failed to complete "..player.Name.."'s purchase of product "..receiptInfo.ProductId.." due to no response from the handler.")
				return Enum.ProductPurchaseDecision.NotProcessedYet
			end
		end

		-- After this monstrosity of a function, we can finally mark the transaction as complete.
	    return Enum.ProductPurchaseDecision.PurchaseGranted	
	end

	-- REMOTE
	function MarketplaceHandler:Connect(player)
		forceRecheckPasses(player)
	end

	function MarketplaceHandler:Disconnect(player)
		if MarketplaceHandler.MarketData[player] then
			-- Mark player data as nil.
			MarketplaceHandler.MarketData[player] = nil
		end
	end
	
	function MarketplaceHandler:UserOwnsGamePass(player, passId)
		local foundPass = false
		if MarketplaceHandler.MarketData[player] then
			-- Check this players data do see if they own the passId.
			for _, pass in pairs(MarketplaceHandler.MarketData[player]) do
				if pass == passId then
					foundPass = true
					break
				end
			end
		end
		return foundPass
	end
	
	-- CONNECTIONS
	MarketplaceService.PromptGamePassPurchaseFinished:Connect(handleGamePassPurchase)
	
return MarketplaceHandler