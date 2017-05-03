--------------------------------------
-- Namespaces
--------------------------------------
local _, core = ...;
core.Config = {}; -- adds Config table to addon namespace

local Config = core.Config;
local UIConfig;

--------------------------------------
-- Defaults (usually a database!)
--------------------------------------
local defaults = {
	theme = {
		r = 0, 
		g = 0.8, -- 204/255
		b = 1,
		hex = "00ccff"
	}
}

--------------------------------------
-- Config functions
--------------------------------------
function Config:Toggle()
	local menu = UIConfig or Config:CreateMenu();
	menu:SetShown(not menu:IsShown());
end

function Config:GetThemeColor()
	local c = defaults.theme;
	return c.r, c.g, c.b, c.hex;
end

function Config:CreateButton(point, relativeFrame, relativePoint, yOffset, text)
	local btn = CreateFrame("Button", nil, relativeFrame, "GameMenuButtonTemplate");
	btn:SetPoint(point, relativeFrame, relativePoint, 0, yOffset);
	btn:SetSize(140, 40);
	btn:SetText(text);
	btn:SetNormalFontObject("GameFontNormalLarge");
	btn:SetHighlightFontObject("GameFontHighlightLarge");
	return btn;
end

local function ScrollFrame_OnMouseWheel(self, delta)
	local newValue = self:GetVerticalScroll() - (delta * 20);
	
	if (newValue < 0) then
		newValue = 0;
	elseif (newValue > self:GetVerticalScrollRange()) then
		newValue = self:GetVerticalScrollRange();
	end
	
	self:SetVerticalScroll(newValue);
end

local function Tab_OnClick(self)
	PanelTemplates_SetTab(self:GetParent(), self:GetID());
	
	local scrollChild = UIConfig.ScrollFrame:GetScrollChild();
	if (scrollChild) then
		scrollChild:Hide();
	end
	
	UIConfig.ScrollFrame:SetScrollChild(self.content);
	self.content:Show();	
end

local function SetTabs(frame, numTabs, ...)
	frame.numTabs = numTabs;
	
	local contents = {};
	local frameName = frame:GetName();
	
	for i = 1, numTabs do	
		local tab = CreateFrame("Button", frameName.."Tab"..i, frame, "CharacterFrameTabButtonTemplate");
		tab:SetID(i);
		tab:SetText(select(i, ...));
		tab:SetScript("OnClick", Tab_OnClick);
		
		tab.content = CreateFrame("Frame", nil, UIConfig.ScrollFrame);
		tab.content:SetSize(308, 500);
		tab.content:Hide();
		
		-- just for tutorial only:
		tab.content.bg = tab.content:CreateTexture(nil, "BACKGROUND");
		tab.content.bg:SetAllPoints(true);
		tab.content.bg:SetColorTexture(math.random(), math.random(), math.random(), 0.6);
		
		table.insert(contents, tab.content);
		
		if (i == 1) then
			tab:SetPoint("TOPLEFT", UIConfig, "BOTTOMLEFT", 5, 7);
		else
			tab:SetPoint("TOPLEFT", _G[frameName.."Tab"..(i - 1)], "TOPRIGHT", -14, 0);
		end	
	end
	
	Tab_OnClick(_G[frameName.."Tab1"]);
	
	return unpack(contents);
end


function Config:CreateMenu()
	UIConfig = CreateFrame("Frame", "AuraTrackerConfig", UIParent, "UIPanelDialogTemplate");
	UIConfig:SetSize(350, 400);
	UIConfig:SetPoint("CENTER"); -- Doesn't need to be ("CENTER", UIParent, "CENTER")
	
	UIConfig.title:ClearAllPoints();
	UIConfig.title:SetFontObject("GameFontHighlight");
	UIConfig.title:SetPoint("LEFT", AuraTrackerConfigTitleBG, "LEFT", 6, 1);
	UIConfig.title:SetText("Aura Tracker Options");	
	
	UIConfig.ScrollFrame = CreateFrame("ScrollFrame", nil, UIConfig, "UIPanelScrollFrameTemplate");
	UIConfig.ScrollFrame:SetPoint("TOPLEFT", AuraTrackerConfigDialogBG, "TOPLEFT", 4, -8);
	UIConfig.ScrollFrame:SetPoint("BOTTOMRIGHT", AuraTrackerConfigDialogBG, "BOTTOMRIGHT", -3, 4);
	UIConfig.ScrollFrame:SetClipsChildren(true);
	UIConfig.ScrollFrame:SetScript("OnMouseWheel", ScrollFrame_OnMouseWheel);
	
	UIConfig.ScrollFrame.ScrollBar:ClearAllPoints();
    UIConfig.ScrollFrame.ScrollBar:SetPoint("TOPLEFT", UIConfig.ScrollFrame, "TOPRIGHT", -12, -18);
    UIConfig.ScrollFrame.ScrollBar:SetPoint("BOTTOMRIGHT", UIConfig.ScrollFrame, "BOTTOMRIGHT", -7, 18);
	
	local content1, content2, content3 = SetTabs(UIConfig, 3, "Appearance", "Tracking", "Profiles");
	
	
	----------------------------------
	-- Content1
	----------------------------------
	-- Save Button:
	content1.saveBtn = self:CreateButton("CENTER", content1, "TOP", -70, "Save");

	-- Reset Button:	
	content1.resetBtn = self:CreateButton("TOP", content1.saveBtn, "BOTTOM", -10, "Reset");

	-- Load Button:	
	content1.loadBtn = self:CreateButton("TOP", content1.resetBtn, "BOTTOM", -10, "Load");

	-- Slider 1:
	content1.slider1 = CreateFrame("SLIDER", nil, content1, "OptionsSliderTemplate");
	content1.slider1:SetPoint("TOP", content1.loadBtn, "BOTTOM", 0, -20);
	content1.slider1:SetMinMaxValues(1, 100);
	content1.slider1:SetValue(50);
	content1.slider1:SetValueStep(30);
	content1.slider1:SetObeyStepOnDrag(true);

	-- Slider 2:
	content1.slider2 = CreateFrame("SLIDER", nil, content1, "OptionsSliderTemplate");
	content1.slider2:SetPoint("TOP", content1.slider1, "BOTTOM", 0, -20);
	content1.slider2:SetMinMaxValues(1, 100);
	content1.slider2:SetValue(40);
	content1.slider2:SetValueStep(30);
	content1.slider2:SetObeyStepOnDrag(true);

	-- Check Button 1:
	content1.checkBtn1 = CreateFrame("CheckButton", nil, content1, "UICheckButtonTemplate");
	content1.checkBtn1:SetPoint("TOPLEFT", content1.slider1, "BOTTOMLEFT", -10, -40);
	content1.checkBtn1.text:SetText("My Check Button!");

	-- Check Button 2:
	content1.checkBtn2 = CreateFrame("CheckButton", nil, content1, "UICheckButtonTemplate");
	content1.checkBtn2:SetPoint("TOPLEFT", content1.checkBtn1, "BOTTOMLEFT", 0, -10);
	content1.checkBtn2.text:SetText("Another Check Button!");
	content1.checkBtn2:SetChecked(true);
	
	----------------------------------
	-- Content2
	----------------------------------
	
	----------------------------------
	-- Content3
	----------------------------------
	
	UIConfig:Hide();
	return UIConfig;
end
