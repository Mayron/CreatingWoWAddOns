---------------------------------
-- Helpful Dev Code
---------------------------------
SLASH_RELOADUI1 = "/rl"; -- new slash command for reloading UI
SlashCmdList.RELOADUI = ReloadUI;

SLASH_FRAMESTK1 = "/fs"; -- new slash command for showing framestack tool
SlashCmdList.FRAMESTK = function()
	LoadAddOn("Blizzard_DebugTools");
	FrameStackTooltip_Toggle();
end

-- allows using left and right buttons to move through the chat 'edit' box
for i = 1, NUM_CHAT_WINDOWS do
	_G["ChatFrame"..i.."EditBox"]:SetAltArrowKeyMode(false);
end

---------------------------------
-- Project Code Below
---------------------------------
local UIConfig = CreateFrame("Frame", "MUI_BuffFrame", UIParent, "BasicFrameTemplateWithInset");
UIConfig:SetSize(260, 360);
UIConfig:SetPoint("CENTER"); -- Doesn't need to be ("CENTER", UIParent, "CENTER")

UIConfig.title = UIConfig:CreateFontString(nil, "OVERLAY", "GameFontHighlight");
UIConfig.title:SetPoint("LEFT", UIConfig.TitleBg, "LEFT", 5, 0);
UIConfig.title:SetText("MUI Buff Option");
--UIConfig.title:SetFont("Fonts\\FRIZQT__.ttf", 11, "OUTLINE");

---------------------------------
-- Buttons
---------------------------------
-- Save Button:
UIConfig.saveBtn = CreateFrame("Button", nil, UIConfig, "GameMenuButtonTemplate");
UIConfig.saveBtn:SetPoint("CENTER", UIConfig, "TOP", 0, -70);
UIConfig.saveBtn:SetSize(140, 40);
UIConfig.saveBtn:SetText("Save");
UIConfig.saveBtn:SetNormalFontObject("GameFontNormalLarge");
UIConfig.saveBtn:SetHighlightFontObject("GameFontHighlightLarge");

--UIConfig.saveBtn:SetPushedFontObject(""); -- removed from API
--UIConfig.saveBtn:SetDisabledFontObject(" "); -- requires a name (cannot be empty!)

-- Reset Button:
UIConfig.resetBtn = CreateFrame("Button", nil, UIConfig, "GameMenuButtonTemplate");
UIConfig.resetBtn:SetPoint("TOP", UIConfig.saveBtn, "BOTTOM", 0, -10);
UIConfig.resetBtn:SetSize(140, 40);
UIConfig.resetBtn:SetText("Reset");
UIConfig.resetBtn:SetNormalFontObject("GameFontNormalLarge");
UIConfig.resetBtn:SetHighlightFontObject("GameFontHighlightLarge");

-- Load Button:
UIConfig.loadBtn = CreateFrame("Button", nil, UIConfig, "GameMenuButtonTemplate");
UIConfig.loadBtn:SetPoint("TOP", UIConfig.resetBtn, "BOTTOM", 0, -10);
UIConfig.loadBtn:SetSize(140, 40);
UIConfig.loadBtn:SetText("Load");
UIConfig.loadBtn:SetNormalFontObject("GameFontNormalLarge");
UIConfig.loadBtn:SetHighlightFontObject("GameFontHighlightLarge");

---------------------------------
-- Sliders
---------------------------------
-- Slider 1:
UIConfig.slider1 = CreateFrame("SLIDER", nil, UIConfig, "OptionsSliderTemplate");
UIConfig.slider1:SetPoint("TOP", UIConfig.loadBtn, "BOTTOM", 0, -20);
UIConfig.slider1:SetMinMaxValues(1, 100);
UIConfig.slider1:SetValue(50);
UIConfig.slider1:SetValueStep(30);
UIConfig.slider1:SetObeyStepOnDrag(true);

-- Slider 2:
UIConfig.slider2 = CreateFrame("SLIDER", nil, UIConfig, "OptionsSliderTemplate");
UIConfig.slider2:SetPoint("TOP", UIConfig.slider1, "BOTTOM", 0, -20);
UIConfig.slider2:SetMinMaxValues(1, 100);
UIConfig.slider2:SetValue(40);
UIConfig.slider2:SetValueStep(30);
UIConfig.slider2:SetObeyStepOnDrag(true);

---------------------------------
-- Check Buttons
---------------------------------
-- Check Button 1:
UIConfig.checkBtn1 = CreateFrame("CheckButton", nil, UIConfig, "UICheckButtonTemplate");
UIConfig.checkBtn1:SetPoint("TOPLEFT", UIConfig.slider1, "BOTTOMLEFT", -10, -40);
UIConfig.checkBtn1.text:SetText("My Check Button!");

-- Check Button 2:
UIConfig.checkBtn2 = CreateFrame("CheckButton", nil, UIConfig, "UICheckButtonTemplate");
UIConfig.checkBtn2:SetPoint("TOPLEFT", UIConfig.checkBtn1, "BOTTOMLEFT", 0, -10);
UIConfig.checkBtn2.text:SetText("Another Check Button!");
UIConfig.checkBtn2:SetChecked(true);
