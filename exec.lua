local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local ExecuteButton = Instance.new("TextButton")
local ScriptBox = Instance.new("TextBox")
local ToggleButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")
local dragging, dragInput, dragStart, startPos

-- GUI Principal
ScreenGui.Name = "w_w"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Botão Flutuante >_
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ToggleButton.TextColor3 = Color3.fromRGB(0, 255, 0)
ToggleButton.BorderSizePixel = 0
ToggleButton.Position = UDim2.new(0, 20, 0, 200)
ToggleButton.Size = UDim2.new(0, 40, 0, 40)
ToggleButton.Text = ">_"
ToggleButton.Font = Enum.Font.Code
ToggleButton.TextSize = 18

-- Tornar o botão móvel
ToggleButton.Active = true
ToggleButton.Draggable = true

-- Frame principal (hub)
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
MainFrame.Size = UDim2.new(0, 300, 0, 200)
MainFrame.Visible = false

-- TextBox para scripts
ScriptBox.Name = "ScriptBox"
ScriptBox.Parent = MainFrame
ScriptBox.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ScriptBox.TextColor3 = Color3.fromRGB(0, 255, 0)
ScriptBox.Position = UDim2.new(0, 10, 0, 10)
ScriptBox.Size = UDim2.new(1, -20, 0, 120)
ScriptBox.ClearTextOnFocus = false
ScriptBox.Font = Enum.Font.Code
ScriptBox.TextSize = 14
ScriptBox.Text = "-- Escreva seu script aqui"
ScriptBox.TextXAlignment = Enum.TextXAlignment.Left
ScriptBox.TextYAlignment = Enum.TextYAlignment.Top
ScriptBox.MultiLine = true

-- Botão de Executar
ExecuteButton.Name = "ExecuteButton"
ExecuteButton.Parent = MainFrame
ExecuteButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ExecuteButton.TextColor3 = Color3.fromRGB(0, 255, 0)
ExecuteButton.Position = UDim2.new(0, 10, 1, -50)
ExecuteButton.Size = UDim2.new(1, -20, 0, 30)
ExecuteButton.Font = Enum.Font.Code
ExecuteButton.Text = "Executar"
ExecuteButton.TextSize = 14

-- Botão de Fechar
CloseButton.Name = "CloseButton"
CloseButton.Parent = MainFrame
CloseButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
CloseButton.TextColor3 = Color3.fromRGB(0, 255, 0)
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Font = Enum.Font.Code
CloseButton.Text = ">_"
CloseButton.TextSize = 14

-- Lógica de execução
ExecuteButton.MouseButton1Click:Connect(function()
	local source = ScriptBox.Text
	if source and source ~= "" then
		local func, err = loadstring(source)
		if func then
			pcall(func)
		else
			warn("Erro ao compilar: " .. err)
		end
	end
end)

-- Mostrar/Ocultar Frame principal
ToggleButton.MouseButton1Click:Connect(function()
	MainFrame.Visible = not MainFrame.Visible
end)

-- Fechar Hub
CloseButton.MouseButton1Click:Connect(function()
	MainFrame.Visible = false
end)
