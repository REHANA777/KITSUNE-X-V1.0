-- KITSUNE X V 1.0 BY StewartTristan5

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

-- UI Setup
local ScreenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
ScreenGui.Name = "KitsuneXUI"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Frame
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 400, 0, 350)
MainFrame.Visible = true
MainFrame.Active = true
MainFrame.Draggable = true

-- Mod Menu Icon (Kitsune Image)
local ModMenuIcon = Instance.new("ImageButton", ScreenGui)
ModMenuIcon.Size = UDim2.new(0, 60, 0, 60)
ModMenuIcon.Position = UDim2.new(0.9, 0, 0.9, 0)
ModMenuIcon.BackgroundTransparency = 1
ModMenuIcon.Image = "rbxassetid://108849426415935"
ModMenuIcon.Visible = false
ModMenuIcon.MouseButton1Click:Connect(function()
	MainFrame.Visible = true
	ModMenuIcon.Visible = false
end)

-- Close Button
local CloseBtn = Instance.new("TextButton", MainFrame)
CloseBtn.Text = "X"
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
CloseBtn.TextColor3 = Color3.new(1,1,1)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 20
CloseBtn.MouseButton1Click:Connect(function()
	MainFrame.Visible = false
	ModMenuIcon.Visible = true
end)

-- Title
local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "🌸 KITSUNE X V 1.0 🌸"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20

-- Settings Table
local Settings = {
	AutoBuySeed = false,
	SeedType = "Tomato",
	AutoBuyGear = false,
	GearType = "WateringCan",
	CheckEggPet = false
}

-- Seed Input
local SeedLabel = Instance.new("TextLabel", MainFrame)
SeedLabel.Text = "Seed Type:"
SeedLabel.Position = UDim2.new(0, 10, 0, 40)
SeedLabel.Size = UDim2.new(0, 100, 0, 25)
SeedLabel.TextColor3 = Color3.new(1,1,1)
SeedLabel.BackgroundTransparency = 1

local SeedBox = Instance.new("TextBox", MainFrame)
SeedBox.PlaceholderText = "Ex: Tomato, Corn"
SeedBox.Text = Settings.SeedType
SeedBox.Position = UDim2.new(0, 120, 0, 40)
SeedBox.Size = UDim2.new(0, 150, 0, 25)
SeedBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
SeedBox.TextColor3 = Color3.new(1,1,1)
SeedBox.FocusLost:Connect(function()
	Settings.SeedType = SeedBox.Text
end)

-- Gear Input
local GearLabel = Instance.new("TextLabel", MainFrame)
GearLabel.Text = "Gear Type:"
GearLabel.Position = UDim2.new(0, 10, 0, 70)
GearLabel.Size = UDim2.new(0, 100, 0, 25)
GearLabel.TextColor3 = Color3.new(1,1,1)
GearLabel.BackgroundTransparency = 1

local GearBox = Instance.new("TextBox", MainFrame)
GearBox.PlaceholderText = "Ex: WateringCan"
GearBox.Text = Settings.GearType
GearBox.Position = UDim2.new(0, 120, 0, 70)
GearBox.Size = UDim2.new(0, 150, 0, 25)
GearBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
GearBox.TextColor3 = Color3.new(1,1,1)
GearBox.FocusLost:Connect(function()
	Settings.GearType = GearBox.Text
end)

-- Toggle Creator
local function createToggle(name, positionY, callback)
	local Toggle = Instance.new("TextButton", MainFrame)
	Toggle.Size = UDim2.new(0, 350, 0, 30)
	Toggle.Position = UDim2.new(0, 25, 0, positionY)
	Toggle.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	Toggle.TextColor3 = Color3.new(1,1,1)
	Toggle.Text = name .. ": OFF"
	Toggle.Font = Enum.Font.Gotham
	Toggle.TextSize = 16
	Toggle.MouseButton1Click:Connect(function()
		Settings[name] = not Settings[name]
		Toggle.Text = name .. ": " .. (Settings[name] and "ON" or "OFF")
		if callback then callback(Settings[name]) end
	end)
end

-- Functional Toggles
createToggle("AutoBuySeed", 110, function(on)
	while on and Settings.AutoBuySeed do
		ReplicatedStorage:WaitForChild("Events"):WaitForChild("BuySeed"):FireServer(Settings.SeedType)
		task.wait(1)
	end
end)

createToggle("AutoBuyGear", 150, function(on)
	while on and Settings.AutoBuyGear do
		ReplicatedStorage:WaitForChild("Events"):WaitForChild("BuyGear"):FireServer(Settings.GearType)
		task.wait(2)
	end
end)

createToggle("CheckEggPet", 190, function(on)
	if on then
		for _, egg in pairs(workspace:WaitForChild("Eggs"):GetChildren()) do
			print("📦 Egg: " .. egg.Name)
			if egg:FindFirstChild("Pets") then
				for _, pet in pairs(egg.Pets:GetChildren()) do
					print(" 🐾 Pet: " .. pet.Name)
				end
			end
		end
	end
end)

print("✅ Loaded KITSUNE X V 1.0 BY StewartTristan5")
