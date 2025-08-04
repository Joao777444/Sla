-- Hub com visual melhorado (funções originais preservadas)

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local DragBar = Instance.new("Frame")
local TextBox = Instance.new("TextBox")
local ExecuteButton = Instance.new("TextButton")
local LoopButton = Instance.new("TextButton")
local StopLoopButton = Instance.new("TextButton")
local AmountBox = Instance.new("TextBox")
local SpeedBox = Instance.new("TextBox")
local ToggleMenuButton = Instance.new("ImageButton")

local UICorner = Instance.new("UICorner")
local UIStroke = Instance.new("UIStroke")

ScreenGui.Name = "ExecHub"
ScreenGui.Parent = game.CoreGui

-- Função para aplicar cantos arredondados e borda
local function estilo(obj, radius, strokeColor)
	local corner = UICorner:Clone()
	corner.CornerRadius = UDim.new(0, radius)
	corner.Parent = obj

	local stroke = UIStroke:Clone()
	stroke.Thickness = 1
	stroke.Color = strokeColor or Color3.fromRGB(80, 80, 80)
	stroke.Parent = obj
end

-- Frame principal
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.Position = UDim2.new(0.5, -175, 0.5, -150)
Frame.Size = UDim2.new(0, 350, 0, 250)
Frame.Visible = true
estilo(Frame, 10)

-- Barra de arrastar
DragBar.Parent = Frame
DragBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
DragBar.Size = UDim2.new(1, 0, 0, 25)
estilo(DragBar, 6)

-- TextBox principal
TextBox.Parent = Frame
TextBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TextBox.Position = UDim2.new(0.1, 0, 0.15, 0)
TextBox.Size = UDim2.new(0.8, 0, 0.2, 0)
TextBox.Text = "Cole o seu script aqui"
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.ClearTextOnFocus = false
TextBox.Font = Enum.Font.Code
TextBox.TextSize = 16
TextBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
estilo(TextBox, 6)

-- AmountBox
AmountBox.Parent = Frame
AmountBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
AmountBox.Position = UDim2.new(0.1, 0, 0.4, 0)
AmountBox.Size = UDim2.new(0.35, 0, 0.15, 0)
AmountBox.Text = "Quantidade"
AmountBox.TextColor3 = Color3.fromRGB(255, 255, 255)
AmountBox.ClearTextOnFocus = true
AmountBox.Font = Enum.Font.Code
AmountBox.TextSize = 14
estilo(AmountBox, 6)

-- SpeedBox
SpeedBox.Parent = Frame
SpeedBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
SpeedBox.Position = UDim2.new(0.55, 0, 0.4, 0)
SpeedBox.Size = UDim2.new(0.35, 0, 0.15, 0)
SpeedBox.Text = "Velocidade"
SpeedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBox.ClearTextOnFocus = true
SpeedBox.Font = Enum.Font.Code
SpeedBox.TextSize = 14
estilo(SpeedBox, 6)

-- Execute Button
ExecuteButton.Parent = Frame
ExecuteButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
ExecuteButton.Position = UDim2.new(0.1, 0, 0.6, 0)
ExecuteButton.Size = UDim2.new(0.35, 0, 0.15, 0)
ExecuteButton.Text = "Executar"
ExecuteButton.Font = Enum.Font.Code
ExecuteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ExecuteButton.TextSize = 15
estilo(ExecuteButton, 6)

-- Loop Button
LoopButton.Parent = Frame
LoopButton.BackgroundColor3 = Color3.fromRGB(0, 0, 170)
LoopButton.Position = UDim2.new(0.55, 0, 0.6, 0)
LoopButton.Size = UDim2.new(0.35, 0, 0.15, 0)
LoopButton.Text = "Ativar Loop"
LoopButton.Font = Enum.Font.Code
LoopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
LoopButton.TextSize = 15
estilo(LoopButton, 6)

-- Stop Loop Button
StopLoopButton.Parent = Frame
StopLoopButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
StopLoopButton.Position = UDim2.new(0.1, 0, 0.8, 0)
StopLoopButton.Size = UDim2.new(0.35, 0, 0.15, 0)
StopLoopButton.Text = "Desativar Loop"
StopLoopButton.Font = Enum.Font.Code
StopLoopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StopLoopButton.TextSize = 15
estilo(StopLoopButton, 6)

-- Botão de abrir menu
ToggleMenuButton.Parent = ScreenGui
ToggleMenuButton.BackgroundTransparency = 1
ToggleMenuButton.Position = UDim2.new(0, 20, 0, 20)
ToggleMenuButton.Size = UDim2.new(0, 60, 0, 60)
ToggleMenuButton.Image = "rbxassetid://6031068420"
ToggleMenuButton.ImageColor3 = Color3.fromRGB(0, 255, 127)

-- Drag system (mesmo do original)
local dragging, dragInput, mousePos, framePos

DragBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        mousePos = input.Position
        framePos = Frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

DragBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - mousePos
        Frame.Position = UDim2.new(
            framePos.X.Scale, framePos.X.Offset + delta.X,
            framePos.Y.Scale, framePos.Y.Offset + delta.Y
        )
    end
end)

-- 👇 Funções 100% originais
local loopAtivo = false

local function executarScript(script, quantidade)
    for i = 1, quantidade do
        loadstring(script)()
    end
end

local function ativarLoop(script, velocidade)
    loopAtivo = true
    while loopAtivo do
        loadstring(script)()
        wait(velocidade)
    end
end

local menuVisivel = true
ToggleMenuButton.MouseButton1Click:Connect(function()
    menuVisivel = not menuVisivel
    Frame.Visible = menuVisivel
end)

ExecuteButton.MouseButton1Click:Connect(function()
    local script = TextBox.Text
    local quantidade = tonumber(AmountBox.Text)
    if script and quantidade then
        executarScript(script, quantidade)
    end
end)

LoopButton.MouseButton1Click:Connect(function()
    local script = TextBox.Text
    local velocidade = tonumber(SpeedBox.Text) or 1
    if script then
        ativarLoop(script, velocidade)
    end
end)

StopLoopButton.MouseButton1Click:Connect(function()
    loopAtivo = false
end)
