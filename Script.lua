-- Configurações iniciais
_G.HeadSize = 6.5
_G.Disabled = true
local ESP_ENABLED = true
local HITBOX_ENABLED = false

-- Função para criar o ESP
local function createESP(player)
    if ESP_ENABLED and player.Character and player.Character:FindFirstChild("Head") then
        local BillboardGui = Instance.new("BillboardGui")
        local TextLabel = Instance.new("TextLabel")

        BillboardGui.Adornee = player.Character.Head
        BillboardGui.Name = "ESP"
        BillboardGui.Parent = player.Character
        BillboardGui.AlwaysOnTop = true
        BillboardGui.ExtentsOffset = Vector3.new(0, 3, 0)
        BillboardGui.Size = UDim2.new(0, 200, 0, 50)

        TextLabel.Parent = BillboardGui
        TextLabel.Text = player.Name
        TextLabel.BackgroundTransparency = 1
        TextLabel.Size = UDim2.new(1, 0, 1, 0)
        TextLabel.TextColor3 = Color3.fromRGB(128, 128, 128) -- Cor cinza
        TextLabel.TextSize = 20 -- Tamanho do texto
        TextLabel.Font = Enum.Font.Arcade -- Fonte mais "gamer"
        TextLabel.TextStrokeTransparency = 0.5 -- Suavizar o texto
        TextLabel.ZIndex = 10
    end
end

-- Função para remover o ESP
local function removeESP(player)
    if player.Character and player.Character:FindFirstChild("ESP") then
        player.Character.ESP:Destroy()
    end
end

-- Função para atualizar o ESP
local function updateESP()
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            if player.Character and player.Character:FindFirstChild("Head") then
                if not player.Character:FindFirstChild("ESP") then
                    createESP(player)
                end
            else
                removeESP(player)
            end
        end
    end
end

-- Atualiza o ESP para jogadores existentes e novos
game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        if ESP_ENABLED then
            createESP(player)
        end
    end)
end)

game.Players.PlayerRemoving:Connect(function(player)
    removeESP(player)
end)

-- Atualiza o ESP periodicamente para manter a consistência
game:GetService('RunService').RenderStepped:Connect(updateESP)

-- Script de hitbox
game:GetService('RunService').RenderStepped:Connect(function()
    if HITBOX_ENABLED then
        for _, v in pairs(game:GetService('Players'):GetPlayers()) do
            if v.Name ~= game:GetService('Players').LocalPlayer.Name then
                pcall(function()
                    local humanoidRootPart = v.Character:FindFirstChild("HumanoidRootPart")
                    if humanoidRootPart then
                        humanoidRootPart.Size = Vector3.new(_G.HeadSize, _G.HeadSize, _G.HeadSize)
                        humanoidRootPart.Transparency = 0.7
                        humanoidRootPart.BrickColor = BrickColor.new("Really black")
                        humanoidRootPart.Material = "Neon"
                        humanoidRootPart.CanCollide = false
                    end
                end)
            end
        end
    else
        for _, v in pairs(game:GetService('Players'):GetPlayers()) do
            if v.Name ~= game:GetService('Players').LocalPlayer.Name then
                pcall(function()
                    local humanoidRootPart = v.Character:FindFirstChild("HumanoidRootPart")
                    if humanoidRootPart then
                        humanoidRootPart.Size = Vector3.new(2, 2, 1) -- Tamanho padrão
                        humanoidRootPart.Transparency = 1 -- Invisível
                        humanoidRootPart.BrickColor = BrickColor.new("Medium stone grey")
                        humanoidRootPart.Material = "Plastic"
                        humanoidRootPart.CanCollide = false -- Garantir que não tenha colisão
                    end
                end)
            end
        end
    end
end)

local UserInputService = game:GetService("UserInputService")

-- Função para criar o GUI
local function createGUI()
    local ScreenGui = Instance.new("ScreenGui")
    local ToggleMenuButton = Instance.new("TextButton")
    local MenuFrame = Instance.new("Frame")
    local ToggleESPButton = Instance.new("TextButton")
    local ToggleHitboxButton = Instance.new("TextButton")
    local HitboxSizeBox = Instance.new("TextBox")
    local CreditLabel = Instance.new("TextLabel")

    ScreenGui.Name = "ControlPanel"
    ScreenGui.Parent = game.CoreGui

    -- Botão para abrir/fechar o menu
    ToggleMenuButton.Name = "ToggleMenuButton"
    ToggleMenuButton.Parent = ScreenGui
    ToggleMenuButton.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
    ToggleMenuButton.BorderSizePixel = 2
    ToggleMenuButton.Position = UDim2.new(0, 10, 0, 10)
    ToggleMenuButton.Size = UDim2.new(0, 100, 0, 50)
    ToggleMenuButton.Text = "Menu"
    ToggleMenuButton.TextScaled = true
    ToggleMenuButton.Font = Enum.Font.SourceSansBold
    ToggleMenuButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleMenuButton.TextStrokeTransparency = 0.5
    ToggleMenuButton.BackgroundTransparency = 0.2
    ToggleMenuButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ToggleMenuButton.ZIndex = 10

    -- Frame do menu
    MenuFrame.Name = "MenuFrame"
    MenuFrame.Parent = ScreenGui
    MenuFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    MenuFrame.Position = UDim2.new(0, 120, 0, 10)
    MenuFrame.Size = UDim2.new(0, 200, 0, 230)
    MenuFrame.Visible = false
    MenuFrame.Active = true
    MenuFrame.Draggable = true

    -- Abrir/fechar menu
    ToggleMenuButton.MouseButton1Click:Connect(function()
        MenuFrame.Visible = not MenuFrame.Visible
    end)

    -- Botão de ESP
    ToggleESPButton.Name = "ToggleESPButton"
    ToggleESPButton.Parent = MenuFrame
    ToggleESPButton.BackgroundColor3 = Color3.new(0, 1, 0)
    ToggleESPButton.Position = UDim2.new(0, 0, 0, 0)
    ToggleESPButton.Size = UDim2.new(0, 200, 0, 50)
    ToggleESPButton.Text = "Disable ESP"
    ToggleESPButton.TextScaled = true
    ToggleESPButton.Font = Enum.Font.Arcade -- Fonte "gamer"
    ToggleESPButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleESPButton.TextStrokeTransparency = 0.5
    ToggleESPButton.ZIndex = 10

    ToggleESPButton.MouseButton1Click:Connect(function()
        ESP_ENABLED = not ESP_ENABLED
        if ESP_ENABLED then
            ToggleESPButton.Text = "Disable ESP"
            addESPToPlayers()
        else
            ToggleESPButton.Text = "Enable ESP"
            for _, player in pairs(game.Players:GetPlayers()) do
                removeESP(player)
            end
        end
    end)

    -- Botão de Hitbox
    ToggleHitboxButton.Name = "ToggleHitboxButton"
    ToggleHitboxButton.Parent = MenuFrame
    ToggleHitboxButton.BackgroundColor3 = Color3.new(1, 0, 0)
    ToggleHitboxButton.Position = UDim2.new(0, 0, 0, 60)
    ToggleHitboxButton.Size = UDim2.new(0, 200, 0, 50)
    ToggleHitboxButton.Text = "Enable Hitbox"
    ToggleHitboxButton.TextScaled = true
    ToggleHitboxButton.Font = Enum.Font.Arcade -- Fonte "gamer"
    ToggleHitboxButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleHitboxButton.TextStrokeTransparency = 0.5
    ToggleHitboxButton.ZIndex = 10

    ToggleHitboxButton.MouseButton1Click:Connect(function()
        HITBOX_ENABLED = not HITBOX_ENABLED
        if HITBOX_ENABLED then
            ToggleHitboxButton.Text = "Disable Hitbox"
        else
            ToggleHitboxButton.Text = "Enable Hitbox"
        end
    end)

    -- Caixa de texto para tamanho da hitbox
    HitboxSizeBox.Name = "HitboxSizeBox"
    HitboxSizeBox.Parent = MenuFrame
    HitboxSizeBox.BackgroundColor3 = Color3.new(0.8, 0.8, 0.8)
    HitboxSizeBox.Position = UDim2.new(0, 0, 0, 120)
    HitboxSizeBox.Size = UDim2.new(0, 200, 0, 50)
    HitboxSizeBox.Text = tostring(_G.HeadSize)
    HitboxSizeBox.TextScaled = true
    HitboxSizeBox.Font = Enum.Font.Arcade -- Fonte "gamer"
    HitboxSizeBox.TextColor3 = Color3.fromRGB(0, 0, 0)
    HitboxSizeBox.TextStrokeTransparency = 0.5
    HitboxSizeBox.ZIndex = 10

    HitboxSizeBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            local newSize = tonumber(HitboxSizeBox.Text)
            if newSize then
                _G.HeadSize = newSize
            else
                HitboxSizeBox.Text = tostring(_G.HeadSize)
            end
        end
    end)

    -- Label de Crédito
    CreditLabel.Name = "CreditLabel"
    CreditLabel.Parent = MenuFrame
    CreditLabel.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    CreditLabel.Position = UDim2.new(0, 0, 0, 180)
    CreditLabel.Size = UDim2.new(0, 200, 0, 50)
    CreditLabel.Text = "by: jaum"
    CreditLabel.TextScaled = true
    CreditLabel.Font = Enum.Font.Arcade -- Fonte "gamer"
    CreditLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    CreditLabel.TextStrokeTransparency = 0.5
    CreditLabel.ZIndex = 10
end

-- Cria o GUI
createGUI()
