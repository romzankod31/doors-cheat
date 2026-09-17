-- DOORS CHEAT v7.0 (компактная версия для loadstring)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local LP = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local Settings = {
    Speed = 16, JumpPower = 50, FlySpeed = 100,
    Noclip = false, ESP = true, Aimbot = false,
    InfiniteJump = false, AutoDoors = true, AntiAfk = true,
    FullBright = false, GodMode = false, Teleport = false
}

-- UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DoorsCheat"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LP:WaitForChild("PlayerGui")

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 350, 0, 500)
Main.Position = UDim2.new(0.5, -175, 0.5, -250)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.Active = true
Main.Draggable = true
Main.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "⚡ DOORS CHEAT v7.0"
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold
Title.Parent = Main

-- Функция кнопок
local function Toggle(name, y, icon)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Position = UDim2.new(0.05, 0, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.Text = icon .. " " .. name .. " [OFF]"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Parent = Main
    
    btn.MouseButton1Click:Connect(function()
        if name == "Скорость" then
            Settings.Speed = Settings.Speed + 5
            if Settings.Speed > 100 then Settings.Speed = 16 end
            btn.Text = icon .. " " .. name .. " [" .. Settings.Speed .. "]"
        elseif name == "Полёт" then
            Settings.Fly = not Settings.Fly
            btn.Text = icon .. " " .. name .. (Settings.Fly and " [ON]" or " [OFF]")
        elseif name == "ESP" then
            Settings.ESP = not Settings.ESP
            btn.Text = icon .. " " .. name .. (Settings.ESP and " [ON]" or " [OFF]")
        elseif name == "Ноклип" then
            Settings.Noclip = not Settings.Noclip
            btn.Text = icon .. " " .. name .. (Settings.Noclip and " [ON]" or " [OFF]")
        elseif name == "Аимбот" then
            Settings.Aimbot = not Settings.Aimbot
            btn.Text = icon .. " " .. name .. (Settings.Aimbot and " [ON]" or " [OFF]")
        elseif name == "Беск. прыжок" then
            Settings.InfiniteJump = not Settings.InfiniteJump
            btn.Text = icon .. " " .. name .. (Settings.InfiniteJump and " [ON]" or " [OFF]")
        elseif name == "Авто двери" then
            Settings.AutoDoors = not Settings.AutoDoors
            btn.Text = icon .. " " .. name .. (Settings.AutoDoors and " [ON]" or " [OFF]")
        elseif name == "Анти-АФК" then
            Settings.AntiAfk = not Settings.AntiAfk
            btn.Text = icon .. " " .. name .. (Settings.AntiAfk and " [ON]" or " [OFF]")
        elseif name == "Фуллбрайт" then
            Settings.FullBright = not Settings.FullBright
            btn.Text = icon .. " " .. name .. (Settings.FullBright and " [ON]" or " [OFF]")
            if Settings.FullBright then
                Lighting.Brightness = 2
                Lighting.Ambient = Color3.fromRGB(255, 255, 255)
            else
                Lighting.Brightness = 1
                Lighting.Ambient = Color3.fromRGB(128, 128, 128)
            end
        elseif name == "Бессмертие" then
            Settings.GodMode = not Settings.GodMode
            btn.Text = icon .. " " .. name .. (Settings.GodMode and " [ON]" or " [OFF]")
        elseif name == "Телепорт" then
            Settings.Teleport = not Settings.Teleport
            btn.Text = icon .. " " .. name .. (Settings.Teleport and " [ON]" or " [OFF]")
        end
        btn.BackgroundColor3 = btn.Text:find("ON") and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(30, 30, 30)
    end)
end

-- Создание кнопок
Toggle("Скорость", 50, "🏃")
Toggle("Полёт", 90, "✈️")
Toggle("ESP", 130, "👁️")
Toggle("Ноклип", 170, "🧱")
Toggle("Аимбот", 210, "🎯")
Toggle("Беск. прыжок", 250, "🦘")
Toggle("Авто двери", 290, "🚪")
Toggle("Анти-АФК", 330, "💤")
Toggle("Фуллбрайт", 370, "💡")
Toggle("Бессмертие", 410, "🛡️")
Toggle("Телепорт", 450, "🏁")

-- Функции
RunService.RenderStepped:Connect(function()
    local char = LP.Character
    if not char then return end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart")
    if not humanoid or not root then return end
    
    humanoid.WalkSpeed = Settings.Speed
    humanoid.JumpPower = Settings.JumpPower
    
    -- Полёт
    if Settings.Fly then
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
        local bg = root:FindFirstChild("BodyGyro")
        local bv = root:FindFirstChild("BodyVelocity")
        if not bg then
            bg = Instance.new("BodyGyro")
            bg.Parent = root
            bg.MaxTorque = Vector3.new(0, 0, 0)
        end
        if not bv then
            bv = Instance.new("BodyVelocity")
            bv.Parent = root
            bv.MaxForce = Vector3.new(100000, 100000, 100000)
        end
        local move = Vector3.new()
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then move = move - Vector3.new(0, 1, 0) end
        bv.Velocity = move * Settings.FlySpeed
        bg.CFrame = Camera.CFrame
    end
    
    -- Ноклип
    if Settings.Noclip then
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
    
    -- ESP
    if Settings.ESP then
        for _, entity in pairs(workspace:GetDescendants()) do
            if entity:IsA("Model") and entity.Name:match("Rush|Ambush|Figure|Screech|Jack|Eyes|Seek|Halt|Dupe|Void|Shadow") then
                local part = entity:FindFirstChild("HumanoidRootPart") or entity:FindFirstChild("Torso") or entity:FindFirstChild("Head")
                if part and not part:FindFirstChild("ESP") then
                    local esp = Instance.new("BoxHandleAdornment")
                    esp.Name = "ESP"
                    esp.Size = Vector3.new(4, 6, 4)
                    esp.Color = Color3.fromRGB(255, 0, 0)
                    esp.Transparency = 0.5
                    esp.AlwaysOnTop = true
                    esp.Parent = part
                end
            end
        end
    end
    
    -- Аимбот
    if Settings.Aimbot then
        local closest = nil
        local dist = 200
        for _, entity in pairs(workspace:GetDescendants()) do
            if entity:IsA("Model") and entity.Name:match("Rush|Ambush|Figure|Screech") then
                local part = entity:FindFirstChild("HumanoidRootPart") or entity:FindFirstChild("Torso")
                if part then
                    local pos, onScreen = Camera:WorldToScreenPoint(part.Position)
                    if onScreen then
                        local d = (Vector2.new(pos.X, pos.Y) - Camera.ViewportSize / 2).Magnitude
                        if d < dist then dist = d closest = part end
                    end
                end
            end
        end
        if closest then
            Camera.CFrame = Camera.CFrame:Lerp(CFrame.lookAt(Camera.CFrame.Position, closest.Position), 0.2)
        end
    end
    
    -- Авто двери
    if Settings.AutoDoors then
        for _, door in pairs(workspace:GetDescendants()) do
            if door:IsA("Model") and door.Name:match("Door") then
                local part = door:FindFirstChild("Door") or door:FindFirstChild("MainDoor")
                if part and part:IsA("BasePart") and (part.Position - root.Position).Magnitude < 15 then
                    part.CanCollide = false
                end
            end
        end
    end
    
    -- Анти-АФК
    if Settings.AntiAfk then
        root.CFrame = root.CFrame * CFrame.new(0, 0, 0.1)
    end
    
    -- Бессмертие
    if Settings.GodMode then
        humanoid.MaxHealth = math.huge
        humanoid.Health = humanoid.MaxHealth
    end
    
    -- Телепорт
    if Settings.Teleport then
        local highest = nil
        local hy = -math.huge
        for _, door in pairs(workspace:GetDescendants()) do
            if door:IsA("Model") and door.Name:match("Door") then
                local part = door:FindFirstChild("Door") or door:FindFirstChild("MainDoor")
                if part and part:IsA("BasePart") and part.Position.Y > hy then
                    hy = part.Position.Y
                    highest = part
                end
            end
        end
        if highest then root.CFrame = CFrame.new(highest.Position + Vector3.new(0, 3, 0)) end
    end
end)

-- Бесконечный прыжок
UserInputService.JumpRequest:Connect(function()
    if Settings.InfiniteJump then
        local char = LP.Character
        if char then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid then humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
        end
    end
end)

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "⚡ DOORS CHEAT",
    Text = "Загружен!",
    Duration = 3
})
