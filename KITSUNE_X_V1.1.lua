--// LocalScript, taruh di StarterPlayerScripts

local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Buat ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Frame utama
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 250, 0, 150)
mainFrame.Position = UDim2.new(0.5, -125, 0.5, -75)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.Visible = false
mainFrame.Parent = screenGui

-- Ujung bulat
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true

-- Tombol buka/tutup
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 100, 0, 40)
toggleButton.Position = UDim2.new(0, 10, 0, 10)
toggleButton.Text = "Open Avatar Copier"
toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggleButton.TextColor3 = Color3.new(1, 1, 1)
toggleButton.Parent = screenGui

-- TextBox buat input username
local usernameBox = Instance.new("TextBox")
usernameBox.Size = UDim2.new(0, 200, 0, 30)
usernameBox.Position = UDim2.new(0, 25, 0, 25)
usernameBox.PlaceholderText = "Masukin Username..."
usernameBox.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
usernameBox.TextColor3 = Color3.new(1,1,1)
usernameBox.Parent = mainFrame

-- Tombol Copy Avatar
local copyButton = Instance.new("TextButton")
copyButton.Size = UDim2.new(0, 200, 0, 30)
copyButton.Position = UDim2.new(0, 25, 0, 70)
copyButton.Text = "Copy Avatar"
copyButton.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
copyButton.TextColor3 = Color3.new(1,1,1)
copyButton.Parent = mainFrame

-- Fungsi copy avatar
local function CopyAvatar(username)
	local success, targetUserId = pcall(function()
		return Players:GetUserIdFromNameAsync(username)
	end)

	if success and targetUserId then
		local success2, characterModel = pcall(function()
			return Players:GetCharacterAppearanceAsync(targetUserId)
		end)

		if success2 and characterModel then
			local char = player.Character or player.CharacterAdded:Wait()
			
			-- hapus aksesoris lama
			for _, obj in ipairs(char:GetChildren()) do
				if obj:IsA("Accessory") or obj:IsA("Shirt") or obj:IsA("Pants") or obj:IsA("ShirtGraphic") or obj:IsA("BodyColors") then
					obj:Destroy()
				end
			end

			-- clone dari target
			for _, obj in ipairs(characterModel:GetChildren()) do
				if obj:IsA("Accessory") or obj:IsA("Shirt") or obj:IsA("Pants") or obj:IsA("ShirtGraphic") or obj:IsA("BodyColors") then
					obj:Clone().Parent = char
				end
			end
		else
			warn("Gagal ambil avatar!")
		end
	else
		warn("Username tidak ditemukan!")
	end
end

-- Event tombol
copyButton.MouseButton1Click:Connect(function()
	if usernameBox.Text ~= "" then
		CopyAvatar(usernameBox.Text)
	end
end)

toggleButton.MouseButton1Click:Connect(function()
	mainFrame.Visible = not mainFrame.Visible
	if mainFrame.Visible then
		toggleButton.Text = "Close Avatar Copier"
	else
		toggleButton.Text = "Open Avatar Copier"
	end
end)