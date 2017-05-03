--[[ 
	Will allow us to create timers to track buff and debuff durations.
	Timers can be set to icon or timer bar mode.
--]]

----------------------
-- Namespaces
----------------------
local _, core = ...;
core.Timer = {};

local Timer = core.Timer;

----------------------
-- Timer functions
----------------------
--[[
	Should return an instance of a Timer (using metatables).
	A "static" function.
--]]
function Timer:Create()
	
end

--[[
	Should update the duration of the timer using events.
--]]
function Timer:Update()
	
end

--[[
	Destroy the timer after it has expired (recylce it).
--]]
function Timer:Destroy()

end

