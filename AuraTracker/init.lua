local _, core = ...; -- Namespace

--------------------------------------
-- Custom Slash Command
--------------------------------------
core.commands = {
	["config"] = core.Config.Toggle, -- this is a function (no knowledge of Config object)
	
	["help"] = function()
		print(" ");
		core:Print("List of slash commands:")
		core:Print("|cff00cc66/at config|r - shows config menu");
		core:Print("|cff00cc66/at help|r - shows help info");
		print(" ");
	end,
	
	["example"] = {
		["test"] = function(value)
			core:Print("My Value:", value);
		end
	}
};

local function HandleSlashCommands(str)
	
	if (#str == 0) then
	
		-- User just entered "/at" with no additional args.
		core.commands.help();
		return;
		
	end
	
	local args = {}; -- What we will iterate over using for loop (arguments).
	for _, arg in pairs({ string.split(' ', str) }) do
		if (#arg > 0) then -- if string length is greater than 0.
			table.insert(args, arg);
		end
	end
	
	local path = core.commands; -- required for updating found table.
	
	for id, arg in ipairs(args) do
		arg = string.lower(arg);
		
		if (path[arg]) then
			if (type(path[arg]) == "function") then
			
				-- all remaining args passed to our function!
				path[arg](select(id + 1, unpack(args))); 
				return;
				
			elseif (type(path[arg]) == "table") then
			
				path = path[arg]; -- another sub-table found!
				
			else
				-- does not exist!
				core.commands.help();
				return;
			end
		else
			-- does not exist!
			core.commands.help();
			return;
		end
	end
end

function core:Print(...)
    local hex = select(4, self.Config:GetThemeColor());
    local prefix = string.format("|cff%s%s|r", hex:upper(), "Aura Tracker:");
    DEFAULT_CHAT_FRAME:AddMessage(string.join(" ", prefix, tostringall(...)));
end

-- WARNING: self automatically becomes events frame!
function core:init(event, name)
	if (name ~= "AuraTracker") then return end 

	-- allows using left and right buttons to move through chat 'edit' box
	for i = 1, NUM_CHAT_WINDOWS do
		_G["ChatFrame"..i.."EditBox"]:SetAltArrowKeyMode(false);
	end
	
	----------------------------------
	-- Register Slash Commands!
	----------------------------------
	SLASH_RELOADUI1 = "/rl"; -- new slash command for reloading UI
	SlashCmdList.RELOADUI = ReloadUI;

	SLASH_FRAMESTK1 = "/fs"; -- new slash command for showing framestack tool
	SlashCmdList.FRAMESTK = function()
		LoadAddOn("Blizzard_DebugTools");
		FrameStackTooltip_Toggle();
	end

	SLASH_AuraTracker1 = "/at";
	SlashCmdList.AuraTracker = HandleSlashCommands;
	
    core:Print("Welcome back", UnitName("player").."!");
end

local events = CreateFrame("Frame");
events:RegisterEvent("ADDON_LOADED");
events:SetScript("OnEvent", core.init);