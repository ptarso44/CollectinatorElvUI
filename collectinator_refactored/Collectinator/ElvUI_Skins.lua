-------------------------------------------------------------------------------
-- Collectinator - ElvUI Skins Module
-- Provides optional skinning for Collectinator when ElvUI is detected
-- This module is loaded as part of Collectinator but only activates if ElvUI is present
-------------------------------------------------------------------------------

local MODNAME = "Collectinator"
local addon = _G[MODNAME]

-- Local references for performance
local _G = getfenv(0)
local pairs = _G.pairs
local ipairs = _G.ipairs
local hooksecurefunc = _G.hooksecurefunc

-- ElvUI references (will be populated at runtime)
local E = nil
local ElvUI = nil
local S = nil

-------------------------------------------------------------------------------
-- Initialize ElvUI Skin Module
-------------------------------------------------------------------------------
function addon:InitializeElvUISkins()
    -- Check if ElvUI is available
    ElvUI = _G.ElvUI
    if not ElvUI then
        return false
    end
    
    E = _G.E
    if not E then
        return false
    end
    
    S = E:GetModule("Skins")
    if not S then
        return false
    end
    
    self:Print("ElvUI detected - applying skins")
    
    -- Apply skins immediately if frames exist
    self:SkinCollectinator()
    
    -- Hook frame show to skin frames as they appear
    self:HookFrameCreation()
    
    return true
end

-------------------------------------------------------------------------------
-- Main Skin Function - Skins all Collectinator frames
-------------------------------------------------------------------------------
function addon:SkinCollectinator()
    if not E or not ElvUI then
        return
    end
    
    local S = E:GetModule("Skins")
    if not S then
        return
    end
    
    -- Skin the main scan button
    self:SkinScanButton(S)
    
    -- Skin the main frame if it exists
    if _G.CollectinatorFrame then
        self:SkinMainFrame(_G.CollectinatorFrame, S)
    end
    
    -- Skin any other Collectinator frames
    self:SkinAdditionalFrames(S)
end

-------------------------------------------------------------------------------
-- Skin the Scan Button
-------------------------------------------------------------------------------
function addon:SkinScanButton()
    local button = _G.Collectinator_ScanButton
    if not button then
        return
    end
    
    -- Use ElvUI's HandleButton function
    S:HandleButton(button)
    
    -- Style the text
    local fontString = button:GetFontString()
    if fontString then
        local font, size, flags = fontString:GetFont()
        fontString:SetFont(font, size, flags)
    end
end

-------------------------------------------------------------------------------
-- Skin the Main Frame
-------------------------------------------------------------------------------
function addon:SkinMainFrame(frame, S)
    if not frame then
        return
    end
    
    -- Apply ElvUI frame template
    if frame.SetTemplate then
        frame:SetTemplate("Transparent")
    else
        -- Manual backdrop setup
        local backdrop = {
            bgFile = E.Media.Textures.White8x8,
            edgeFile = E.Media.Textures.White8x8,
            tile = true,
            tileSize = 4,
            edgeSize = E.PixelMode and 1 or 4,
            insets = { left = 2, right = 2, top = 2, bottom = 2 }
        }
        frame:SetBackdrop(backdrop)
        frame:SetBackdropColor(unpack(E.db.colors.backdrop))
        frame:SetBackdropBorderColor(unpack(E.db.colors.border))
    end
    
    -- Skin close button if it exists
    if frame.CloseButton then
        if E.ReskinClose then
            E:ReskinClose(frame.CloseButton)
        end
    end
    
    -- Skin title/text elements
    if frame.Title then
        frame.Title:SetTextColor(1, 0.82, 0, 1) -- ElvUI gold color
    end
end

-------------------------------------------------------------------------------
-- Skin Additional Frames (lists, tooltips, etc.)
-------------------------------------------------------------------------------
function addon:SkinAdditionalFrames(S)
    -- Skin list frames
    for i = 1, 10 do
        local listItem = _G["CollectinatorListItem"..i]
        if listItem then
            self:SkinListItem(listItem, S)
        end
    end
    
    -- Skin filter buttons
    for i = 1, 20 do
        local filterBtn = _G["CollectinatorFilter"..i]
        if filterBtn then
            self:SkinFilterButton(filterBtn, S)
        end
    end
    
    -- Skin checkboxes
    for i = 1, 30 do
        local checkbox = _G["CollectinatorCheck"..i]
        if checkbox then
            self:SkinCheckBox(checkbox, S)
        end
    end
end

-------------------------------------------------------------------------------
-- Skin List Item
-------------------------------------------------------------------------------
function addon:SkinListItem(frame, S)
    -- Background highlight
    if frame.highlight then
        frame.highlight:SetTexture(E.Media.Textures.White8x8)
        frame.highlight:SetVertexColor(0.2, 0.6, 1, 0.5)
    end
    
    -- Icon border
    if frame.Icon then
        if frame.Icon.SetTexCoord then
            frame.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
        end
    end
end

-------------------------------------------------------------------------------
-- Skin Filter Button
-------------------------------------------------------------------------------
function addon:SkinFilterButton(button, S)
    if E.ReskinButton then
        E:Reskin(button)
    elseif button.SetTemplate then
        button:SetTemplate("Default")
    end
end

-------------------------------------------------------------------------------
-- Skin CheckBox
-------------------------------------------------------------------------------
function addon:SkinCheckBox(checkbox, S)
    -- Skin the check texture
    if checkbox.checkTexture then
        checkbox.checkTexture:SetTexture(E.Media.Textures.White8x8)
        checkbox.checkTexture:SetVertexColor(0, 1, 0, 1)
    end
    
    -- Skin the border
    if checkbox.border then
        checkbox.border:SetTexture(E.Media.Textures.White8x8)
        checkbox.border:SetVertexColor(1, 1, 1, 1)
    end
end

-------------------------------------------------------------------------------
-- Apply ElvUI Tooltip Styling to Collectinator Tooltips
-------------------------------------------------------------------------------
function addon:ApplyElvUITooltipStyle(tooltip)
    if not E or not tooltip then
        return
    end
    
    -- If ElvUI has tooltip module, use it
    local TT = E:GetModule("Tooltip")
    if TT and TT.ApplyTooltipStyle then
        TT:ApplyTooltipStyle(tooltip)
    end
end

-------------------------------------------------------------------------------
-- Hook into frame creation to auto-skin new frames
-------------------------------------------------------------------------------
function addon:HookFrameCreation()
    if not E then
        return
    end
    
    -- Hook the frame show event to skin frames as they appear
    local frame = _G.CollectinatorFrame
    if frame then
        frame:HookScript("OnShow", function(self)
            addon:SkinCollectinator()
        end)
    end
end

-------------------------------------------------------------------------------
-- Initialize on addon load
-------------------------------------------------------------------------------
-- Register for ADDON_LOADED to initialize when Collectinator loads
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addonName)
    if addonName == MODNAME then
        addon:InitializeElvUISkins()
        addon:HookFrameCreation()
        self:UnregisterAllEvents()
    end
end)
