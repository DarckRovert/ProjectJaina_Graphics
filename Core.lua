--[[
    ===========================================================================
    WoW Perú - Gráficos HD & Opciones Avanzadas
    Archivo: Core.lua
    Motor de CVars, gestión de presets y sincronización con el motor gráfico 3.3.5a
    ===========================================================================
]]

WoWPeru_Graphics = WoWPeru_Graphics or {}
local WPG = WoWPeru_Graphics

-- Estado y versión
WPG.Version = "1.0.3"
WPG.Title = "|cFFFFD700WoW Perú|r |cFF00FFCCGráficos HD|r"

-- Constantes de color oficiales
WPG.Colors = {
    fondo       = { 0.039, 0.043, 0.055 }, -- #0A0B0E
    panel       = { 0.078, 0.086, 0.110 }, -- #14161C
    panelAlto   = { 0.106, 0.118, 0.149 }, -- #1B1E26
    borde       = { 0.173, 0.184, 0.220 }, -- #2C2F38
    oro         = { 0.910, 0.710, 0.302 }, -- #E8B54D
    cian        = { 0.000, 1.000, 0.800 }, -- #00FFCC
    verde       = { 0.298, 0.765, 0.478 }, -- #4CD964
    rojo        = { 0.784, 0.220, 0.259 }, -- #C83842
    texto       = { 0.941, 0.945, 0.957 },
    textoSuave  = { 0.604, 0.624, 0.671 },
}

-- Logger formal
function WPG:Print(msg)
    DEFAULT_CHAT_FRAME:AddMessage("|cFFFFD700[WoW Perú HD]|r " .. tostring(msg))
end

-- ============================================================================
-- GESTIÓN SEGURA DE CVARS
-- ============================================================================
function WPG:GetCVar(cvar, default)
    local val = GetCVar(cvar)
    if val == nil or val == "" then
        return default
    end
    return val
end

function WPG:GetCVarNum(cvar, default)
    local val = tonumber(GetCVar(cvar))
    if val == nil then
        return default or 0
    end
    return val
end

function WPG:GetCVarBool(cvar, default)
    local val = GetCVar(cvar)
    if val == nil then return default or false end
    return (val == "1" or val == 1 or val == "true")
end

function WPG:SetCVar(cvar, value)
    local strVal = tostring(value)
    local ok, err = pcall(SetCVar, cvar, strVal)
    if not ok then
        -- Fallback por consola
        ConsoleExec(cvar .. " " .. strVal)
    end
end

-- ============================================================================
-- PRESETS OFICIALES DE RENDERIZADO
-- ============================================================================
WPG.Presets = {
    ultra = {
        name = "Ultra HD Nativo (Fidelidad Máxima)",
        desc = "Nitidez cristalina sin desenfoque lechoso, sombras proyectadas dinámicas, vegetación densa, filtrado anisótropo 16x y audio optimizado para 32-bit.",
        cvars = {
            ffxGlow              = "0",    -- Nitidez cristalina (elimina el bloom lechoso)
            ffxDeath             = "0",    -- Claridad sin desenfoque en modo fantasma
            groundEffectDensity  = "128",  -- Densidad frondosa calibrada para parches HD
            groundEffectDist     = "80",   -- Distancia balanceada de vegetación
            detailDoodadAlpha    = "100",  -- Visibilidad completa de objetos del suelo
            shadowLevel          = "1",    -- Sombras proyectadas dinámicas estables
            extShadowQuality     = "1",    -- Calidad dinámica sin artefactos
            waterRipples         = "1",    -- Ondulaciones en el agua
            farclip              = "850",  -- Distancia de visión panorámica óptima para evitar OOM de texturas HD
            environmentDetail    = "1.0",  -- Detalle geométrico de edificios
            weatherDensity       = "3",    -- Lluvia, nieve y niebla detallada
            particleDensity      = "1",    -- Partículas y magia al 100%
            specular             = "1",    -- Reflejos especulares en metales
            projectedTextures    = "1",    -- Áreas de hechizos en el suelo visibles
            anisotropic          = "16",   -- Filtrado anisótropo 16x de terreno
            Sound_NumChannels    = "64",   -- 64 canales para proteger el heap de 32 bits
            textureCacheSize     = "64",   -- Caché máximo de texturas en RAM
            gxApi                = "D3D9", -- Direct3D 9 estándar y estable (cero fallos en AMD/Intel/Nvidia)
        }
    },
    raid = {
        name = "Raid 25 Competitivo (120 FPS)",
        desc = "Optimizado para máxima fluidez y claridad en encuentros de banda con 25 jugadores. Mantiene áreas de hechizos y audio pero reduce follaje.",
        cvars = {
            ffxGlow              = "0",
            ffxDeath             = "0",
            groundEffectDensity  = "64",
            groundEffectDist     = "70",
            shadowLevel          = "1",
            extShadowQuality     = "0",
            farclip              = "777",
            environmentDetail    = "1.0",
            particleDensity      = "0.8",
            specular             = "1",
            projectedTextures    = "1",
            Sound_NumChannels    = "128",
            gxApi                = "D3D9",
        }
    },
    classic = {
        name = "Clásico Blizzard (Estándar 2008)",
        desc = "Valores por defecto del cliente original 3.3.5a de Blizzard.",
        cvars = {
            ffxGlow              = "1",
            ffxDeath             = "1",
            groundEffectDensity  = "64",
            groundEffectDist     = "70",
            shadowLevel          = "1",
            extShadowQuality     = "0",
            farclip              = "777",
            environmentDetail    = "1.0",
            weatherDensity       = "1",
            particleDensity      = "1",
            Sound_NumChannels    = "64",
            gxApi                = "D3D9",
        }
    }
}

function WPG:ApplyPreset(presetKey)
    local preset = WPG.Presets[presetKey]
    if not preset then return end

    for cvar, val in pairs(preset.cvars) do
        WPG:SetCVar(cvar, val)
    end

    if WPG.RefreshUI then
        WPG:RefreshUI()
    end

    WPG:Print("|cFF00FFCCPreset aplicado:|r " .. preset.name)
    UIErrorsFrame:AddMessage("WoW Perú: " .. preset.name .. " Aplicado", 0.0, 1.0, 0.8, 1.0, 3)
end

-- ============================================================================
-- INICIALIZACIÓN Y EVENTOS
-- ============================================================================
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGIN")

frame:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == "WoWPeru_Graphics" then
        WoWPeruGraphics_DB = WoWPeruGraphics_DB or {
            minimap = { hide = false, pos = 45 },
            activePreset = "ultra"
        }
    elseif event == "PLAYER_LOGIN" then
        WPG:InitUIHooks()
    end
end)

-- ============================================================================
-- INTEGRACIÓN CON MENÚS NATIVOS (ESC Y OPCIONES DE VÍDEO)
-- ============================================================================
function WPG:InitUIHooks()
    -- 1. Botón en VideoOptionsFrame
    if VideoOptionsFrame then
        local hdBtn = CreateFrame("Button", "VideoOptionsFrame_WoWPeruHDButton", VideoOptionsFrame, "UIPanelButtonTemplate")
        hdBtn:SetWidth(150)
        hdBtn:SetHeight(22)
        hdBtn:SetPoint("TOPRIGHT", VideoOptionsFrame, "TOPRIGHT", -40, -14)
        hdBtn:SetText("|cFFFFD700Opciones HD|r")
        hdBtn:SetScript("OnClick", function()
            WPG:ToggleUI()
        end)
    end

    -- 2. Botón en GameMenuFrame (Menú de Escape)
    if GameMenuFrame then
        local gmBtn = CreateFrame("Button", "GameMenuButton_WoWPeruGraphics", GameMenuFrame, "GameMenuButtonTemplate")
        gmBtn:SetText("|cFFFFD700Gráficos HD|r")
        
        local btnWidth = (GameMenuButtonOptions and GameMenuButtonOptions:GetWidth() and GameMenuButtonOptions:GetWidth() > 0) and GameMenuButtonOptions:GetWidth() or 144
        gmBtn:SetWidth(btnWidth)
        gmBtn:SetHeight(21)

        local function AdjustGameMenuAnchors()
            if GameMenuButtonOptions and GameMenuButtonSoundOptions then
                gmBtn:ClearAllPoints()
                gmBtn:SetPoint("TOP", GameMenuButtonOptions, "BOTTOM", 0, -1)

                GameMenuButtonSoundOptions:ClearAllPoints()
                GameMenuButtonSoundOptions:SetPoint("TOP", gmBtn, "BOTTOM", 0, -1)

                if GameMenuButtonUIOptions then
                    GameMenuButtonUIOptions:ClearAllPoints()
                    GameMenuButtonUIOptions:SetPoint("TOP", GameMenuButtonSoundOptions, "BOTTOM", 0, -1)
                end
            end
        end

        local heightAdjusted = false
        GameMenuFrame:HookScript("OnShow", function(self)
            if not heightAdjusted then
                self:SetHeight(self:GetHeight() + 22)
                heightAdjusted = true
            end
            AdjustGameMenuAnchors()
        end)

        AdjustGameMenuAnchors()

        gmBtn:SetScript("OnClick", function()
            PlaySound("igMainMenuOption")
            HideUIPanel(GameMenuFrame)
            WPG:ToggleUI()
        end)
    end


    -- 3. Panel en InterfaceOptionsFrame -> AddOns
    WPG:InitBlizOptionsPanel()
end

function WPG:InitBlizOptionsPanel()
    local panel = CreateFrame("Frame", "WoWPeru_Graphics_BlizPanel", UIParent)
    panel.name = "WoW Perú Gráficos HD"

    local title = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 16, -16)
    title:SetText("|cFFFFD700WoW Perú|r - |cFF00FFCCPanel de Gráficos HD|r")

    local desc = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    desc:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
    desc:SetWidth(380)
    desc:SetJustifyH("LEFT")
    desc:SetText("Control de fidelidad gráfica nativa sin filtros externos: nitidez cristalina (sin desenfoque lechoso), sombras dinámicas proyectadas, vegetación cuádruple, filtrado anisótropo en armaduras y audio a 128 canales.")

    local openBtn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
    openBtn:SetWidth(200)
    openBtn:SetHeight(26)
    openBtn:SetPoint("TOPLEFT", desc, "BOTTOMLEFT", 0, -16)
    openBtn:SetText("|cFFFFD700Abrir Suite Gráfica HD|r")
    openBtn:SetScript("OnClick", function()
        InterfaceOptionsFrame_Show()
        HideUIPanel(InterfaceOptionsFrame)
        WPG:ToggleUI()
    end)

    InterfaceOptions_AddCategory(panel)
end

-- ============================================================================
-- SLASH COMMANDS
-- ============================================================================
SLASH_WOWPERU_GRAPHICS1 = "/graficos"
SLASH_WOWPERU_GRAPHICS2 = "/graphics"
SLASH_WOWPERU_GRAPHICS3 = "/hd"
SLASH_WOWPERU_GRAPHICS4 = "/wpg"

SlashCmdList["WOWPERU_GRAPHICS"] = function(msg)
    msg = string.lower(string.trim(msg or ""))
    if msg == "ultra" then
        WPG:ApplyPreset("ultra")
    elseif msg == "raid" then
        WPG:ApplyPreset("raid")
    elseif msg == "classic" then
        WPG:ApplyPreset("classic")
    else
        WPG:ToggleUI()
    end
end
