--[[
    ===========================================================================
    WoW Perú - Gráficos HD & Opciones Avanzadas
    Archivo: UI.lua
    Interfaz visual moderna para control nativo de renderizado y fidelidad HD
    ===========================================================================
]]

WoWPeru_Graphics = WoWPeru_Graphics or {}
local WPG = WoWPeru_Graphics

local BLANCO = "Interface\\Buttons\\WHITE8X8"
local c = WPG.Colors

-- Lista de controles para refresco dinámico
local UI_CONTROLS = {
    checkboxes    = {},
    sliders       = {},
    shadowButtons = {},
    apiButtons    = {},
    audioButtons  = {}
}

-- ============================================================================
-- HELPERS DE ESTILO VISUAL (MOTOR FLAT DARK WOW PERÚ)
-- ============================================================================
local function CrearFondo(parent, color, alfa)
    local t = parent:CreateTexture(nil, "BACKGROUND")
    t:SetTexture(BLANCO)
    t:SetVertexColor(color[1], color[2], color[3], alfa or 1)
    t:SetAllPoints(parent)
    return t
end

local function CrearBorde(parent, color, grosor)
    color = color or c.borde
    grosor = grosor or 1
    local lados = {}
    for _, lado in ipairs({ "TOP", "BOTTOM", "LEFT", "RIGHT" }) do
        local t = parent:CreateTexture(nil, "BORDER")
        t:SetTexture(BLANCO)
        t:SetVertexColor(color[1], color[2], color[3], 1)
        if lado == "TOP" or lado == "BOTTOM" then
            t:SetHeight(grosor)
            t:SetPoint(lado .. "LEFT")
            t:SetPoint(lado .. "RIGHT")
        else
            t:SetWidth(grosor)
            t:SetPoint("TOP" .. lado)
            t:SetPoint("BOTTOM" .. lado)
        end
        lados[#lados + 1] = t
    end
    parent._bordes = lados
    return lados
end

local function SetBordeColor(parent, color)
    if parent._bordes then
        for _, t in ipairs(parent._bordes) do
            t:SetVertexColor(color[1], color[2], color[3], 1)
        end
    end
end

local function CrearPanel(parent, w, h, color)
    local p = CreateFrame("Frame", nil, parent)
    p:SetWidth(w)
    p:SetHeight(h)
    CrearFondo(p, color or c.panel, 0.92)
    CrearBorde(p, c.borde, 1)
    return p
end

local function EstilarBoton(btn, colorBorde, colorHover)
    colorBorde = colorBorde or c.borde
    colorHover = colorHover or c.oro

    CrearFondo(btn, c.panelAlto, 1)
    CrearBorde(btn, colorBorde, 1)

    btn._colorBordeNormal = colorBorde
    btn._colorHover       = colorHover

    btn:HookScript("OnEnter", function(self)
        SetBordeColor(self, self._colorHover)
    end)
    btn:HookScript("OnLeave", function(self)
        SetBordeColor(self, self._colorBordeNormal)
    end)
end

-- ============================================================================
-- CREACIÓN DE LA VENTANA PRINCIPAL
-- ============================================================================
function WPG:CreateMainUI()
    if WPG.MainFrame then return end

    local f = CreateFrame("Frame", "WoWPeru_Graphics_MainFrame", UIParent)
    f:SetWidth(720)
    f:SetHeight(570)
    f:SetPoint("CENTER", UIParent, "CENTER", 0, 20)
    f:SetMovable(true)
    f:EnableMouse(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop", f.StopMovingOrSizing)
    f:SetClampedToScreen(true)
    f:SetFrameStrata("DIALOG")
    f:Hide()

    -- Registrar para que ESC cierre la ventana
    tinsert(UISpecialFrames, "WoWPeru_Graphics_MainFrame")

    -- Fondo y bordes exteriores de la ventana
    CrearFondo(f, c.fondo, 0.96)
    CrearBorde(f, c.borde, 2)

    -- Cabecera / Barra de título
    local header = CreateFrame("Frame", nil, f)
    header:SetHeight(44)
    header:SetPoint("TOPLEFT", f, "TOPLEFT", 0, 0)
    header:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, 0)
    CrearFondo(header, c.panelAlto, 1)
    CrearBorde(header, c.borde, 1)

    local title = header:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("LEFT", header, "LEFT", 16, 4)
    title:SetText("|cFFFFD700WoW Perú|r |cFF00FFCCGráficos HD & Renderizado Nativo|r")

    local subtitle = header:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    subtitle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -2)
    subtitle:SetText("Fidelidad visual cristalina sin filtros externos • Motor 3.3.5a D3D9Ex")

    -- Botón de cerrar [X]
    local closeBtn = CreateFrame("Button", nil, header, "UIPanelCloseButton")
    closeBtn:SetPoint("RIGHT", header, "RIGHT", -6, 0)
    closeBtn:SetScript("OnClick", function() f:Hide() end)

    -- ========================================================================
    -- BARRA DE PRESETS RÁPIDOS
    -- ========================================================================
    local presetBar = CreateFrame("Frame", nil, f)
    presetBar:SetHeight(38)
    presetBar:SetPoint("TOPLEFT", header, "BOTTOMLEFT", 12, -8)
    presetBar:SetPoint("TOPRIGHT", header, "BOTTOMRIGHT", -12, -8)
    CrearFondo(presetBar, c.panel, 0.85)
    CrearBorde(presetBar, c.borde, 1)

    local presetLabel = presetBar:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    presetLabel:SetPoint("LEFT", presetBar, "LEFT", 12, 0)
    presetLabel:SetText("|cFFFFD700Perfiles Rápidos:|r")

    local function CrearBotonPreset(texto, presetKey, xOffset, colorHover)
        local btn = CreateFrame("Button", nil, presetBar)
        btn:SetWidth(170)
        btn:SetHeight(24)
        btn:SetPoint("LEFT", presetBar, "LEFT", xOffset, 0)
        
        local fontStr = btn:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        fontStr:SetPoint("CENTER")
        fontStr:SetText(texto)
        btn.text = fontStr

        EstilarBoton(btn, c.borde, colorHover)

        btn:SetScript("OnClick", function()
            PlaySound("igMainMenuOptionCheat")
            WPG:ApplyPreset(presetKey)
        end)
        return btn
    end

    CrearBotonPreset("💎 Ultra HD Nativo", "ultra", 120, c.cian)
    CrearBotonPreset("⚔️ Raid 25 (120 FPS)", "raid", 300, c.oro)
    CrearBotonPreset("🔄 Original Blizzard", "classic", 480, c.textoSuave)

    -- ========================================================================
    -- CONTENEDORES DE LAS 3 COLUMNAS TÉCNICAS
    -- ========================================================================
    local colW = 222
    local colH = 410
    local topY = -96

    local col1 = CrearPanel(f, colW, colH)
    col1:SetPoint("TOPLEFT", f, "TOPLEFT", 12, topY)

    local col2 = CrearPanel(f, colW, colH)
    col2:SetPoint("TOPLEFT", col1, "TOPRIGHT", 14, 0)

    local col3 = CrearPanel(f, colW, colH)
    col3:SetPoint("TOPLEFT", col2, "TOPRIGHT", 14, 0)

    -- Cabeceras de columna
    local function AddColHeader(col, text, color)
        local h = col:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        h:SetPoint("TOPLEFT", col, "TOPLEFT", 10, -10)
        h:SetText(color .. text .. "|r")

        local sep = col:CreateTexture(nil, "ARTWORK")
        sep:SetTexture(BLANCO)
        sep:SetVertexColor(c.borde[1], c.borde[2], c.borde[3], 0.8)
        sep:SetHeight(1)
        sep:SetPoint("TOPLEFT", h, "BOTTOMLEFT", -2, -4)
        sep:SetPoint("RIGHT", col, "RIGHT", -10, 0)
        return sep
    end

    AddColHeader(col1, "1. Nitidez & Post-procesado", "|cFF00FFCC")
    AddColHeader(col2, "2. Vegetación & Entorno", "|cFFFFD700")
    AddColHeader(col3, "3. Sombras, Motor & Audio", "|cFF4CD964")

    -- ========================================================================
    -- COLUMNA 1: NITIDEZ Y POST-PROCESADO
    -- ========================================================================
    local function AddCheckbox(parent, labelText, cvar, invert, tooltipText, x, y)
        local cbName = "WPG_CB_" .. cvar .. (invert and "_Inv" or "")
        local cb = CreateFrame("CheckButton", cbName, parent, "UICheckButtonTemplate")
        cb:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
        cb:SetWidth(22)
        cb:SetHeight(22)

        local label = _G[cbName .. "Text"]
        label:SetFontObject("GameFontHighlightSmall")
        label:SetText(labelText)
        label:SetPoint("LEFT", cb, "RIGHT", 4, 1)

        cb.cvar = cvar
        cb.invert = invert
        cb.tooltip = tooltipText

        cb:SetScript("OnClick", function(self)
            PlaySound("igMainMenuOptionCheckBoxOn")
            local isChecked = self:GetChecked()
            local val
            if self.invert then
                val = isChecked and "0" or "1"
            else
                val = isChecked and "1" or "0"
            end
            WPG:SetCVar(self.cvar, val)
        end)

        cb:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(labelText, 1, 0.82, 0)
            GameTooltip:AddLine(self.tooltip, 1, 1, 1, true)
            GameTooltip:AddLine("CVar: " .. self.cvar, 0.5, 0.5, 0.5)
            GameTooltip:Show()
        end)
        cb:SetScript("OnLeave", function() GameTooltip:Hide() end)

        UI_CONTROLS.checkboxes[#UI_CONTROLS.checkboxes + 1] = cb
        return cb
    end

    local yPos1 = -38
    local ySpacing = -34

    AddCheckbox(col1, "Nitidez Cristalina (Sin Blur)", "ffxGlow", true,
        "Desactiva el resplandor lechoso borroso de 2008. Deja texturas de armaduras, armas y terreno nítidas al 100%.", 10, yPos1)
    
    AddCheckbox(col1, "Claridad Estado Fantasma", "ffxDeath", true,
        "Elimina la distorsión borrosa en blanco y negro al morir.", 10, yPos1 + ySpacing)

    AddCheckbox(col1, "Anisótropo 16x en Modelos 3D", "M2ForceBilinear", true,
        "Fuerza filtrado anisótropo en personajes y criaturas (M2) en lugar de filtrado bilinear borroso.", 10, yPos1 + ySpacing * 2)

    AddCheckbox(col1, "Ondas Dinámicas en Agua", "rippleDetail", false,
        "Activa ondulaciones físicas en el agua al caminar o nadar.", 10, yPos1 + ySpacing * 3)

    AddCheckbox(col1, "Texturas Proyectadas", "projectedTextures", false,
        "Muestra áreas de hechizos y círculos en el suelo.", 10, yPos1 + ySpacing * 4)

    AddCheckbox(col1, "Brillo Especular de Armaduras", "specular", false,
        "Reflejos de luz sobre metales pulidos y armaduras de placas.", 10, yPos1 + ySpacing * 5)

    AddCheckbox(col1, "Sombreadores M2 Avanzados", "M2UseShaders", false,
        "Habilita shaders modernos en modelos tridimensionales.", 10, yPos1 + ySpacing * 6)

    AddCheckbox(col1, "Objetos sin Desvanecimiento", "objectFade", true,
        "Evita que objetos lejanos desaparezcan prematuramente.", 10, yPos1 + ySpacing * 7)

    -- ========================================================================
    -- COLUMNA 2: VEGETACIÓN Y ENTORNO (SLIDERS)
    -- ========================================================================
    local function AddSlider(parent, labelText, cvar, minVal, maxVal, stepVal, tooltipText, x, y)
        local sName = "WPG_Slider_" .. cvar
        local s = CreateFrame("Slider", sName, parent, "OptionsSliderTemplate")
        s:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
        s:SetWidth(190)
        s:SetHeight(15)
        s:SetMinMaxValues(minVal, maxVal)
        s:SetValueStep(stepVal)

        local titleLabel = _G[sName .. "Text"]
        titleLabel:SetFontObject("GameFontHighlightSmall")
        titleLabel:SetText(labelText)

        local lowLabel = _G[sName .. "Low"]
        lowLabel:SetText(tostring(minVal))
        lowLabel:SetFontObject("GameFontDisableSmall")

        local highLabel = _G[sName .. "High"]
        highLabel:SetText(tostring(maxVal))
        highLabel:SetFontObject("GameFontDisableSmall")

        local valLabel = s:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        valLabel:SetPoint("TOP", s, "BOTTOM", 0, -2)
        s.valLabel = valLabel

        s.cvar = cvar
        s.tooltip = tooltipText
        s.stepVal = stepVal

        s:SetScript("OnValueChanged", function(self, value)
            if self.stepVal and self.stepVal > 1 then
                value = math.floor(value / self.stepVal + 0.5) * self.stepVal
            else
                value = math.floor(value + 0.5)
            end

            if self.cvar == "maxFPS" and value == 0 then
                self.valLabel:SetText("|cFF00FFCCIlimitado (0)|r")
            elseif self.cvar == "maxFPS" then
                self.valLabel:SetText("|cFF00FFCC" .. tostring(value) .. " FPS|r")
            else
                self.valLabel:SetText("|cFF00FFCC" .. tostring(value) .. "|r")
            end

            WPG:SetCVar(self.cvar, tostring(value))
        end)

        s:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(labelText, 1, 0.82, 0)
            GameTooltip:AddLine(self.tooltip, 1, 1, 1, true)
            GameTooltip:AddLine("CVar: " .. self.cvar, 0.5, 0.5, 0.5)
            GameTooltip:Show()
        end)
        s:SetScript("OnLeave", function() GameTooltip:Hide() end)

        UI_CONTROLS.sliders[#UI_CONTROLS.sliders + 1] = s
        return s
    end

    local yPos2 = -44
    local sSpacing = -54

    AddSlider(col2, "Densidad de Césped / Vegetación", "groundEffectDensity", 16, 256, 16,
        "Multiplica la densidad de césped en el suelo. El menú clásico solo permite 64; aquí puedes subir a 256.", 16, yPos2)

    AddSlider(col2, "Distancia de Vegetación", "groundEffectDist", 40, 140, 10,
        "Distancia máxima a la que se dibuja el césped visible.", 16, yPos2 + sSpacing)

    AddSlider(col2, "Distancia de Visión (Farclip)", "farclip", 300, 1277, 50,
        "Distancia máxima de dibujo del terreno y estructuras.", 16, yPos2 + sSpacing * 2)

    AddSlider(col2, "Distancia de Horizonte", "horizonfarclip", 1000, 3000, 200,
        "Distancia de visualización de montañas lejanas, cielo y niebla.", 16, yPos2 + sSpacing * 3)

    AddSlider(col2, "Límite de FPS (0 = Ilimitado)", "maxFPS", 0, 240, 10,
        "Tasa de cuadros por segundo máxima. 0 para FPS ilimitado; 120 o 144 para monitores de alta frecuencia.", 16, yPos2 + sSpacing * 4)

    -- ========================================================================
    -- COLUMNA 3: SOMBRAS, MOTOR Y AUDIO
    -- ========================================================================
    local yPos3 = -38

    -- Selector de Sombras
    local shTitle = col3:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    shTitle:SetPoint("TOPLEFT", col3, "TOPLEFT", 10, yPos3)
    shTitle:SetText("|cFFFFD700Modo de Sombras Dinámicas:|r")

    local function CrearBotonSombra(texto, sLevel, extQ, sSize, x, y, w)
        local btn = CreateFrame("Button", nil, col3)
        btn:SetWidth(w or 96)
        btn:SetHeight(22)
        btn:SetPoint("TOPLEFT", col3, "TOPLEFT", x, y)
        
        local fontStr = btn:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        fontStr:SetPoint("CENTER")
        fontStr:SetText(texto)
        btn.text = fontStr
        btn.sLevel = sLevel
        btn.extQ   = extQ
        btn.sSize  = sSize

        EstilarBoton(btn, c.borde, c.verde)

        btn:SetScript("OnClick", function(self)
            PlaySound("igMainMenuOption")
            WPG:SetCVar("shadowLevel", tostring(self.sLevel))
            WPG:SetCVar("extShadowQuality", tostring(self.extQ))
            WPG:SetCVar("shadowTextureSize", tostring(self.sSize))
            WPG:Print("Sombras configuradas: " .. texto)
            WPG:RefreshButtons()
        end)

        UI_CONTROLS.shadowButtons[#UI_CONTROLS.shadowButtons + 1] = btn
        return btn
    end

    CrearBotonSombra("Desactivadas", 0, 0, 512, 10, yPos3 - 20, 98)
    CrearBotonSombra("Básicas (Óvalo)", 1, 0, 1024, 114, yPos3 - 20, 98)
    CrearBotonSombra("Dinámicas 1024", 2, 1, 1024, 10, yPos3 - 46, 98)
    CrearBotonSombra("Ultra 2048px", 2, 2, 2048, 114, yPos3 - 46, 98)

    -- Motor Gráfico Direct3D
    local d3dTitle = col3:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    d3dTitle:SetPoint("TOPLEFT", col3, "TOPLEFT", 10, yPos3 - 82)
    d3dTitle:SetText("|cFFFFD700Motor DirectX (gxApi):|r")

    local function CrearBotonAPI(texto, apiVal, x, y)
        local btn = CreateFrame("Button", nil, col3)
        btn:SetWidth(98)
        btn:SetHeight(22)
        btn:SetPoint("TOPLEFT", col3, "TOPLEFT", x, y)
        
        local fontStr = btn:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        fontStr:SetPoint("CENTER")
        fontStr:SetText(texto)
        btn.text   = fontStr
        btn.apiVal = apiVal

        EstilarBoton(btn, c.borde, c.cian)

        btn:SetScript("OnClick", function(self)
            PlaySound("igMainMenuOption")
            WPG:SetCVar("gxApi", self.apiVal)
            WPG:Print("Motor gráfico asignado a: " .. self.apiVal .. " (Aplica tras reiniciar)")
            WPG:RefreshButtons()
        end)

        UI_CONTROLS.apiButtons[#UI_CONTROLS.apiButtons + 1] = btn
        return btn
    end

    CrearBotonAPI("D3D9Ex (Win10/11)", "D3D9Ex", 10, yPos3 - 102)
    CrearBotonAPI("D3D9 (Clásico)", "D3D9", 114, yPos3 - 102)

    -- Canales de Sonido
    local sndTitle = col3:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    sndTitle:SetPoint("TOPLEFT", col3, "TOPLEFT", 10, yPos3 - 138)
    sndTitle:SetText("|cFFFFD700Canales de Sonido (Audio):|r")

    local function CrearBotonCanales(canales, x, y)
        local btn = CreateFrame("Button", nil, col3)
        btn:SetWidth(62)
        btn:SetHeight(22)
        btn:SetPoint("TOPLEFT", col3, "TOPLEFT", x, y)
        
        local fontStr = btn:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        fontStr:SetPoint("CENTER")
        fontStr:SetText(canales .. " Can.")
        btn.text    = fontStr
        btn.canales = canales

        EstilarBoton(btn, c.borde, c.oro)

        btn:SetScript("OnClick", function(self)
            PlaySound("igMainMenuOption")
            WPG:SetCVar("Sound_NumChannels", tostring(self.canales))
            WPG:Print("Canales de sonido ajustados a: " .. self.canales)
            WPG:RefreshButtons()
        end)

        UI_CONTROLS.audioButtons[#UI_CONTROLS.audioButtons + 1] = btn
        return btn
    end

    CrearBotonCanales(32, 10, yPos3 - 158)
    CrearBotonCanales(64, 78, yPos3 - 158)
    CrearBotonCanales(128, 146, yPos3 - 158)

    -- Checkboxes de Columna 3
    AddCheckbox(col3, "Audio en Segundo Plano", "Sound_EnableSoundWhenGameIsInBG", false,
        "Permite escuchar el juego al minimizar o cambiar de ventana con Alt+Tab.", 10, yPos3 - 192)

    AddCheckbox(col3, "Sincronización Vertical (VSync)", "gxVSync", false,
        "Elimina cortes horizontales de pantalla fijando los FPS a la tasa de refresco.", 10, yPos3 - 224)

    AddCheckbox(col3, "Triple Búfer (TripleBuffering)", "gxTripleBuffer", false,
        "Evita caídas drásticas de FPS cuando VSync está activado.", 10, yPos3 - 256)

    -- Botón de Reinicio de Motor Gráfico
    local restartBtn = CreateFrame("Button", nil, col3)
    restartBtn:SetWidth(198)
    restartBtn:SetHeight(24)
    restartBtn:SetPoint("TOPLEFT", col3, "TOPLEFT", 10, yPos3 - 300)
    
    local rText = restartBtn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    rText:SetPoint("CENTER")
    rText:SetText("|cFFFFD700⚡ Reiniciar Motor (RestartGx)|r")

    EstilarBoton(restartBtn, c.oro, c.cian)

    restartBtn:SetScript("OnClick", function()
        PlaySound("igMainMenuOption")
        RestartGx()
        WPG:Print("Motor gráfico reiniciado.")
    end)

    -- ========================================================================
    -- BARRA INFERIOR / FOOTER
    -- ========================================================================
    local footer = CreateFrame("Frame", nil, f)
    footer:SetHeight(38)
    footer:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 12, 10)
    footer:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -12, 10)
    CrearFondo(footer, c.panelAlto, 1)
    CrearBorde(footer, c.borde, 1)

    -- Telemetría de FPS en tiempo real
    local fpsText = footer:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    fpsText:SetPoint("LEFT", footer, "LEFT", 14, 0)
    fpsText:SetText("FPS: -- | Memoria Lua: -- KB")

    local elapsedTimer = 0
    footer:SetScript("OnUpdate", function(self, elapsed)
        elapsedTimer = elapsedTimer + elapsed
        if elapsedTimer > 0.5 then
            elapsedTimer = 0
            local curFPS = math.floor(GetFramerate() or 0)
            local memKB = math.floor(gcinfo() or 0)
            fpsText:SetText(string.format("|cFF00FFCCFPS:|r %d  |cFF60626B•|r  |cFFFFD700Memoria:|r %d KB", curFPS, memKB))
        end
    end)

    -- Botón Cerrar
    local okBtn = CreateFrame("Button", nil, footer)
    okBtn:SetWidth(140)
    okBtn:SetHeight(24)
    okBtn:SetPoint("RIGHT", footer, "RIGHT", -10, 0)

    local okText = okBtn:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    okText:SetPoint("CENTER")
    okText:SetText("|cFFFFD700Cerrar y Guardar|r")

    EstilarBoton(okBtn, c.oro, c.cian)
    okBtn:SetScript("OnClick", function()
        f:Hide()
    end)

    WPG.MainFrame = f
end

-- ============================================================================
-- REFRESCO DE BOTONES DE MODO (SOMBRAS, AUDIO, API)
-- ============================================================================
function WPG:RefreshButtons()
    local sLevel = WPG:GetCVarNum("shadowLevel", 1)
    local extQ   = WPG:GetCVarNum("extShadowQuality", 0)
    local curApi = WPG:GetCVar("gxApi", "D3D9Ex")
    local curSnd = WPG:GetCVarNum("Sound_NumChannels", 128)

    -- Sombras
    for _, btn in ipairs(UI_CONTROLS.shadowButtons) do
        local isActive = (btn.sLevel == sLevel and btn.extQ == extQ)
        if isActive then
            btn._colorBordeNormal = c.verde
            SetBordeColor(btn, c.verde)
            btn.text:SetTextColor(c.verde[1], c.verde[2], c.verde[3], 1)
        else
            btn._colorBordeNormal = c.borde
            SetBordeColor(btn, c.borde)
            btn.text:SetTextColor(c.texto[1], c.texto[2], c.texto[3], 1)
        end
    end

    -- API
    for _, btn in ipairs(UI_CONTROLS.apiButtons) do
        local isActive = (string.lower(btn.apiVal) == string.lower(curApi))
        if isActive then
            btn._colorBordeNormal = c.cian
            SetBordeColor(btn, c.cian)
            btn.text:SetTextColor(c.cian[1], c.cian[2], c.cian[3], 1)
        else
            btn._colorBordeNormal = c.borde
            SetBordeColor(btn, c.borde)
            btn.text:SetTextColor(c.texto[1], c.texto[2], c.texto[3], 1)
        end
    end

    -- Audio
    for _, btn in ipairs(UI_CONTROLS.audioButtons) do
        local isActive = (btn.canales == curSnd)
        if isActive then
            btn._colorBordeNormal = c.oro
            SetBordeColor(btn, c.oro)
            btn.text:SetTextColor(c.oro[1], c.oro[2], c.oro[3], 1)
        else
            btn._colorBordeNormal = c.borde
            SetBordeColor(btn, c.borde)
            btn.text:SetTextColor(c.texto[1], c.texto[2], c.texto[3], 1)
        end
    end
end

-- ============================================================================
-- REFRESCO DE VALORES ACTUALES EN LOS CONTROLES
-- ============================================================================
function WPG:RefreshUI()
    if not WPG.MainFrame then return end

    -- Actualizar checkboxes
    for _, cb in ipairs(UI_CONTROLS.checkboxes) do
        local rawVal = WPG:GetCVar(cb.cvar)
        local isEnabled
        if cb.invert then
            isEnabled = (rawVal == "0" or rawVal == 0)
        else
            isEnabled = (rawVal == "1" or rawVal == 1 or rawVal == "true")
        end
        cb:SetChecked(isEnabled)
    end

    -- Actualizar sliders
    for _, s in ipairs(UI_CONTROLS.sliders) do
        local numVal = WPG:GetCVarNum(s.cvar, 0)
        s:SetValue(numVal)
        if s.valLabel then
            if s.cvar == "maxFPS" and numVal == 0 then
                s.valLabel:SetText("|cFF00FFCCIlimitado (0)|r")
            elseif s.cvar == "maxFPS" then
                s.valLabel:SetText("|cFF00FFCC" .. tostring(numVal) .. " FPS|r")
            else
                s.valLabel:SetText("|cFF00FFCC" .. tostring(numVal) .. "|r")
            end
        end
    end

    -- Actualizar botones de modo activo
    WPG:RefreshButtons()
end

-- ============================================================================
-- TOGGLE DE LA INTERFAZ
-- ============================================================================
function WPG:ToggleUI()
    if not WPG.MainFrame then
        WPG:CreateMainUI()
    end

    if WPG.MainFrame:IsShown() then
        WPG.MainFrame:Hide()
    else
        WPG:RefreshUI()
        WPG.MainFrame:Show()
    end
end
