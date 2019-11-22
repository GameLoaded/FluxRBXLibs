--[[
	element.lua
	--------------------
	Author(s): AdministratorGnar
--]]

-- SERVICES
local Players = game:GetService("Players")

-- VARIABLES
local elements = {}
local symbols = {"#", "$", "%"}

-- EXEC
do
	if Players.LocalPlayer then
		Players.LocalPlayer:WaitForChild("PlayerGui").ChildAdded:Connect(function(gui)
			table.insert(elements, 1, gui)
		end)
	end
end

-- RETURN
return function(first, second)
	local argument, directories
	if type(first) == "string" then
		argument, directories = first, elements
	else
		argument, directories = second, {first}
	end
	
	while true do
		local current = argument
		local new
		
		for _, symbol in pairs(symbols) do
			local start, finish = string.find(argument, symbol, 2, true)
			if start and finish then
				new = start
				break
			end
		end
		
		local current = argument:sub(1)
		if new then
			current = argument:sub(1, new - 1)
		end
		local action, input = current:sub(1, 1), current:sub(2)
		local directory = {}
				
		local function recursiveGet(parent)
			for _, child in pairs(parent:GetChildren()) do
				if (action == "#" and child.Name == "#"..input) or (action == "$" and child.Name == input) or (action == "%" and child:IsA(input)) then
					table.insert(directory, 1, child)
				end
				recursiveGet(child)
			end
		end	
		for _, direct in pairs(directories) do
			recursiveGet(direct)		
		end

		if new then		
			directories = directory
			argument = argument:sub(new)
		else
			if #directory == 1 then
				return directory[1]
			end
			return directory
		end
	end
	return {}
end