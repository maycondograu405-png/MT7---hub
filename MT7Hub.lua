--==================================================
-- MT7 HUB
-- Otimização visual para Roblox
--==================================================

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer

--==================================================
-- CONFIGURAÇÃO
--==================================================

local Original = {}

local function Save(obj, property)
    if not Original[obj] then
        Original[obj] = {}
    end

    if Original[obj][property] == nil then
        pcall(function()
            Original[obj][property] = obj[property]
        end)
    end
end

local function RestoreAll()
    for obj, properties in pairs(Original) do
        if obj and obj.Parent then
            for property, value in pairs(properties) do
                pcall(function()
                    obj[property] = value
                end)
            end
        end
    end
end

--==================================================
-- TEMAS
--==================================================

local Themes = {
    Azul = {
        Main = Color3.fromRGB(3, 5, 8),
        Accent = Color3.fromRGB(15, 85, 150),
        Text = Color3.fromRGB(95, 190, 255),
        Stroke = Color3.fromRGB(5, 35, 70)
    },

    Roxo = {
        Main = Color3.fromRGB(5, 3, 8),
        Accent = Color3.fromRGB(100, 45, 160),
        Text = Color3.fromRGB(190, 120, 255),
        Stroke = Color3.fromRGB(55, 20, 85)
    },

    Vermelho = {
        Main = Color3.fromRGB(8, 3, 3),
        Accent = Color3.fromRGB(150, 30, 35),
        Text = Color3.fromRGB(255, 105, 105),
        Stroke = Color3.fromRGB(75, 15, 15)
    },

    Verde = {
        Main = Color3.fromRGB(2, 7, 4),
        Accent = Color3.fromRGB(15, 120, 65),
        Text = Color3.fromRGB(100, 245, 155),
        Stroke = Color3.fromRGB(10, 60, 35)
    },

    Ciano = {
        Main = Color3.fromRGB(2, 7, 9),
        Accent = Color3.fromRGB(10, 125, 150),
        Text = Color3.fromRGB(90, 225, 255),
        Stroke = Color3.fromRGB(5, 70, 85)
    }
}

local ThemeNames = {
    "Azul",
    "Roxo",
    "Vermelho",
    "Verde",
    "Ciano"
}

local ThemeIndex = 1
local Theme = Themes[ThemeNames[ThemeIndex]]

--==================================================
-- GUI
--==================================================

local Gui = Instance.new("ScreenGui")
Gui.Name = "MT7_Hub"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true

pcall(function()
    Gui.Parent = game:GetService("CoreGui")
end)

if not Gui.Parent then
    Gui.Parent = Player:WaitForChild("PlayerGui")
end

--==================================================
-- BOTÃO FLUTUANTE
--==================================================

local Floating = Instance.new("TextButton")
Floating.Name = "MT7_Floating"
Floating.Size = UDim2.new(0, 58, 0, 58)
Floating.Position = UDim2.new(0, 18, 0.5, -29)
Floating.BackgroundColor3 = Theme.Accent
Floating.BackgroundTransparency = 0.08
Floating.Text = "MT7"
Floating.TextColor3 = Theme.Text
Floating.TextSize = 16
Floating.Font = Enum.Font.GothamBold
Floating.Parent = Gui

local FloatCorner = Instance.new("UICorner")
FloatCorner.CornerRadius = UDim.new(1, 0)
FloatCorner.Parent = Floating

local FloatStroke = Instance.new("UIStroke")
FloatStroke.Color = Theme.Stroke
FloatStroke.Thickness = 2
FloatStroke.Parent = Floating

--==================================================
-- PAINEL
--==================================================

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 305, 0, 335)
Main.Position = UDim2.new(0.5, -152, 0.5, -167)
Main.BackgroundColor3 = Theme.Main
Main.BackgroundTransparency = 0.04
Main.Visible = false
Main.Parent = Gui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Theme.Stroke
MainStroke.Thickness = 2
MainStroke.Parent = Main

--==================================================
-- TÍTULO
--==================================================

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundTransparency = 1
Title.Text = "MT7 HUB"
Title.TextColor3 = Theme.Text
Title.TextSize = 22
Title.Font = Enum.Font.GothamBold
Title.Parent = Main

--==================================================
-- FUNÇÕES DE OTIMIZAÇÃO
--==================================================

local function AntiLagOn()

    pcall(function()
        Save(Lighting, "GlobalShadows")
        Lighting.GlobalShadows = false
    end)

    for _, obj in ipairs(Workspace:GetDescendants()) do
        pcall(function()

            if obj:IsA("ParticleEmitter")
            or obj:IsA("Trail")
            or obj:IsA("Beam")
            or obj:IsA("Smoke")
            or obj:IsA("Fire")
            or obj:IsA("Sparkles") then

                Save(obj, "Enabled")
                obj.Enabled = false

            elseif obj:IsA("PointLight")
            or obj:IsA("SpotLight")
            or obj:IsA("SurfaceLight") then

                Save(obj, "Enabled")
                obj.Enabled = false

            end
        end)
    end
end

local function AntiTextureOn()

    for _, obj in ipairs(Workspace:GetDescendants()) do
        pcall(function()

            if obj:IsA("Texture")
            or obj:IsA("Decal") then

                Save(obj, "Transparency")
                obj.Transparency = 1

            elseif obj:IsA("SurfaceAppearance") then

                Save(obj, "Parent")
                obj.Parent = nil

            elseif obj:IsA("MeshPart") then

                Save(obj, "TextureID")
                obj.TextureID = ""

            elseif obj:IsA("SpecialMesh") then

                Save(obj, "TextureId")
                obj.TextureId = ""

            end
        end)
    end
end

local function FPSBoostOn()

    pcall(function()
        Save(Lighting, "GlobalShadows")
        Lighting.GlobalShadows = false
    end)

    for _, obj in ipairs(Lighting:GetChildren()) do
        pcall(function()

            if obj:IsA("BloomEffect")
            or obj:IsA("BlurEffect")
            or obj:IsA("ColorCorrectionEffect")
            or obj:IsA("DepthOfFieldEffect")
            or obj:IsA("SunRaysEffect") then

                Save(obj, "Enabled")
                obj.Enabled = false

            elseif obj:IsA("Atmosphere") then

                Save(obj, "Density")
                obj.Density = 0

            end
        end)
    end

    for _, obj in ipairs(Workspace:GetDescendants()) do
        pcall(function()

            if obj:IsA("Highlight")
            or obj:IsA("ParticleEmitter")
            or obj:IsA("Trail")
            or obj:IsA("Beam") then

                Save(obj, "Enabled")
                obj.Enabled = false

            end
        end)
    end

    pcall(function()
        local Terrain = Workspace:FindFirstChildOfClass("Terrain")

        if Terrain then
            Save(Terrain, "Decoration")
            Terrain.Decoration = false
        end
    end)
end

local function AntiFreezeOn()

    for _, obj in ipairs(Workspace:GetDescendants()) do
        pcall(function()

            if obj:IsA("ParticleEmitter")
            or obj:IsA("Trail")
            or obj:IsA("Beam")
            or obj:IsA("Smoke")
            or obj:IsA("Fire")
            or obj:IsA("Sparkles")
            or obj:IsA("Highlight") then

                Save(obj, "Enabled")
                obj.Enabled = false

            end
        end)
    end

    for _, obj in ipairs(Lighting:GetChildren()) do
        pcall(function()

            if obj:IsA("BloomEffect")
            or obj:IsA("BlurEffect")
            or obj:IsA("DepthOfFieldEffect")
            or obj:IsA("SunRaysEffect") then

                Save(obj, "Enabled")
                obj.Enabled = false

            end
        end)
    end
end

--==================================================
-- TOGGLE
--==================================================

local ToggleObjects = {}

local function CreateToggle(name, y, callback)

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0, 165, 0, 38)
    Label.Position = UDim2.new(0, 15, 0, y)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(215, 220, 225)
    Label.TextSize = 13
    Label.Font = Enum.Font.GothamSemibold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Main

    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0, 88, 0, 32)
    Button.Position = UDim2.new(1, -103, 0, y + 3)
    Button.BackgroundColor3 = Color3.fromRGB(12, 14, 18)
    Button.Text = "OFF"
    Button.TextColor3 = Color3.fromRGB(150, 155, 165)
    Button.TextSize = 13
    Button.Font = Enum.Font.GothamBold
    Button.Parent = Main

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Button

    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Theme.Stroke
    Stroke.Thickness = 1.5
    Stroke.Parent = Button

    ToggleObjects[#ToggleObjects + 1] = {
        Button = Button,
        Stroke = Stroke
    }

    local Enabled = false

    Button.MouseButton1Click:Connect(function()

        Enabled = not Enabled

        if Enabled then
            Button.Text = "ON"
            Button.BackgroundColor3 = Theme.Accent
            Button.TextColor3 = Theme.Text

            callback(true)

        else
            Button.Text = "OFF"
            Button.BackgroundColor3 = Color3.fromRGB(12, 14, 18)
            Button.TextColor3 = Color3.fromRGB(150, 155, 165)

            RestoreAll()

            callback(false)
        end
    end)
end

--==================================================
-- OPÇÕES
--==================================================

CreateToggle("ANTI-LAG", 52, function(on)
    if on then
        AntiLagOn()
    end
end)

CreateToggle("ANTI-TEXTURA", 92, function(on)
    if on then
        AntiTextureOn()
    end
end)

CreateToggle("FPS BOOST", 132, function(on)
    if on then
        FPSBoostOn()
    end
end)

CreateToggle("ANTI-CONGELAMENTO", 172, function(on)
    if on then
        AntiFreezeOn()
    end
end)

--==================================================
-- BOTÃO DE TEMA
--==================================================

local ThemeButton = Instance.new("TextButton")
ThemeButton.Size = UDim2.new(1, -30, 0, 38)
ThemeButton.Position = UDim2.new(0, 15, 0, 225)
ThemeButton.BackgroundColor3 = Theme.Accent
ThemeButton.Text = "COR: AZUL"
ThemeButton.TextColor3 = Theme.Text
ThemeButton.TextSize = 13
ThemeButton.Font = Enum.Font.GothamBold
ThemeButton.Parent = Main

local ThemeCorner = Instance.new("UICorner")
ThemeCorner.CornerRadius = UDim.new(0, 8)
ThemeCorner.Parent = ThemeButton

local ThemeStroke = Instance.new("UIStroke")
ThemeStroke.Color = Theme.Stroke
ThemeStroke.Thickness = 1.5
ThemeStroke.Parent = ThemeButton

local function ApplyTheme()

    Theme = Themes[ThemeNames[ThemeIndex]]

    Main.BackgroundColor3 = Theme.Main
    MainStroke.Color = Theme.Stroke

    Floating.BackgroundColor3 = Theme.Accent
    Floating.TextColor3 = Theme.Text
    FloatStroke.Color = Theme.Stroke

    Title.TextColor3 = Theme.Text

    ThemeButton.BackgroundColor3 = Theme.Accent
    ThemeButton.TextColor3 = Theme.Text
    ThemeStroke.Color = Theme.Stroke

    for _, item in ipairs(ToggleObjects) do
        item.Stroke.Color = Theme.Stroke

        if item.Button.Text == "ON" then
            item.Button.BackgroundColor3 = Theme.Accent
            item.Button.TextColor3 = Theme.Text
        end
    end
end

ThemeButton.MouseButton1Click:Connect(function()

    ThemeIndex = ThemeIndex + 1

    if ThemeIndex > #ThemeNames then
        ThemeIndex = 1
    end

    ThemeButton.Text = "COR: " .. string.upper(ThemeNames[ThemeIndex])

    ApplyTheme()
end)

--==================================================
-- ANIMAÇÃO DO PAINEL
--==================================================

local function OpenPanel()

    Main.Visible = true

    Main.Size = UDim2.new(0, 260, 0, 285)
    Main.Position = UDim2.new(0.5, -130, 0.5, -142)

    Main.BackgroundTransparency = 1

    local Info = TweenInfo.new(
        0.25,
        Enum.EasingStyle.Quint,
        Enum.EasingDirection.Out
    )

    TweenService:Create(
        Main,
        Info,
        {
            Size = UDim2.new(0, 305, 0, 335),
            Position = UDim2.new(0.5, -152, 0.5, -167),
            BackgroundTransparency = 0.04
        }
    ):Play()
end

local function ClosePanel()

    local Info = TweenInfo.new(
        0.18,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.In
    )

    local Tween = TweenService:Create(
        Main,
        Info,
        {
            Size = UDim2.new(0, 260, 0, 285),
            BackgroundTransparency = 1
        }
    )

    Tween:Play()

    Tween.Completed:Connect(function()
        Main.Visible = false
    end)
end

Floating.MouseButton1Click:Connect(function()

    if Main.Visible then
        ClosePanel()
    else
        OpenPanel()
    end
end)

--==================================================
-- ARRASTAR BOTÃO FLUTUANTE
--==================================================

local dragging = false
local dragStart
local startPos

Floating.InputBegan:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then

        dragging = true
        dragStart = input.Position
        startPos = Floating.Position

        input.Changed:Connect(function()

            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end

        end)
    end
end)

Floating.InputChanged:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch then

        if dragging then

            local delta = input.Position - dragStart

            Floating.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,

                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end
end)

--==================================================
-- FINAL
--==================================================

print("MT7 HUB carregado!")
