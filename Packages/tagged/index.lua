--[[
	tagged.lua
	--------------------
	Author(s): AdministratorGnar
--]]

-- SERVICES
local CollectionService = game:GetService("CollectionService")

-- RETURN
return function(...)
	local tagged = {}
	for _, tag in pairs({...}) do
		for _, instance in pairs(CollectionService:GetTagged(tag)) do
			table.insert(tagged, 1, instance)
		end
	end
	return tagged
end