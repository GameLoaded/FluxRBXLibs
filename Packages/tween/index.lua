--[[
	tween.lua
	--------------------
	Author(s): AdministratorGnar
--]]

-- SERVICES
local TweenService = game:GetService("TweenService")

-- VARIABLES
local tweens = {}

-- RETURN
return function(object, properties, duration, easingStyle, easingDirection, repeatCount, reverses, delayTime)
	if tweens[object] then
		tweens[object]:Cancel()
	end
	local tween = TweenService:Create(object, TweenInfo.new(duration or 1, easingStyle or Enum.EasingStyle.Linear, easingDirection or Enum.EasingDirection.Out, repeatCount or 0, reverses or false, delayTime or 0), properties)
	tween.Completed:Connect(function(playbackState)
		tweens[object] = nil
	end)
	tween:Play()
	return tween
end
