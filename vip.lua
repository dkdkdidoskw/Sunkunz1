--[[
    孙坤黑名单系统 v2.0
]]

-- 服务声明
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")

-- 确保本地玩家已加载
local LocalPlayer = Players.LocalPlayer
while not LocalPlayer do
    task.wait(0.1)
    LocalPlayer = Players.LocalPlayer
end

-- 禁用所有默认UI界面（仅禁用一次）
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)

-- 黑名单定义（无语法错误）
local Blacklist = {
    Users = {
        "nall",
        "KSapplep",
    }
}

-- 安全检查：确保玩家名称有效
local playerName = LocalPlayer.Name
if not playerName or type(playerName) ~= "string" then
    return -- 如果名称无效，静默退出
end

-- 检查是否在黑名单中
local isBanned = false
local checkName = playerName:lower():gsub("%s+", "") -- 清理空格

for _, bannedName in ipairs(Blacklist.Users) do
    if checkName == bannedName:lower() then
        isBanned = true
        break
    end
end

-- 如果不是黑名单用户，恢复UI并退出
if not isBanned then
    task.wait(1)
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
    return
end

-- ==== 从这里开始是黑名单用户的处理 ====

-- 禁用所有用户输入
UserInputService.ModalEnabled = true

-- 创建一个安全的GUI容器
local function createSafeGUI()
    local success, result = pcall(function()
        local playerGui = LocalPlayer:WaitForChild("PlayerGui", 5)
        if not playerGui then
            LocalPlayer:Kick("系统错误: 无法加载用户界面")
            return nil
        end
        
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "BlacklistSystem_V2"
        screenGui.DisplayOrder = 999999
        screenGui.ResetOnSpawn = false
        screenGui.IgnoreGuiInset = true
        screenGui.Parent = playerGui
        
        return screenGui
    end)
    
    if success and result then
        return result
    else
        LocalPlayer:Kick("用户: " .. playerName .. " - 系统初始化失败")
        return nil
    end
end

local screenGui = createSafeGUI()
if not screenGui then return end

-- 创建背景效果
local background = Instance.new("Frame")
background.Name = "DarkOverlay"
background.Size = UDim2.new(1, 0, 1, 0)
background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
background.BackgroundTransparency = 0
background.BorderSizePixel = 0
background.ZIndex = 1
background.Parent = screenGui

-- 添加红色扫描线效果
local scanLine = Instance.new("Frame")
scanLine.Name = "ScanLine"
scanLine.Size = UDim2.new(1, 0, 0, 2)
scanLine.Position = UDim2.new(0, 0, 0, -2)
scanLine.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
scanLine.BackgroundTransparency = 0.7
scanLine.BorderSizePixel = 0
scanLine.ZIndex = 2
scanLine.Parent = screenGui

-- 扫描线动画
task.spawn(function()
    while task.wait(0.05) do
        local currentY = scanLine.Position.Y.Scale
        local newY = (currentY + 0.05) % 1
        scanLine.Position = UDim2.new(0, 0, newY, -2)
    end
end)

-- 主警告容器
local mainContainer = Instance.new("Frame")
mainContainer.Name = "WarningContainer"
mainContainer.AnchorPoint = Vector2.new(0.5, 0.5)
mainContainer.Size = UDim2.new(0.8, 0, 0.7, 0)
mainContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
mainContainer.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
mainContainer.BackgroundTransparency = 0.2
mainContainer.ZIndex = 3
mainContainer.Parent = screenGui

-- 容器边框效果
local containerStroke = Instance.new("UIStroke")
containerStroke.Name = "Border"
containerStroke.Color = Color3.fromRGB(255, 0, 0)
containerStroke.Thickness = 3
containerStroke.Transparency = 0
containerStroke.Parent = mainContainer

-- 内阴影
local innerShadow = Instance.new("Frame")
innerShadow.Name = "InnerShadow"
innerShadow.Size = UDim2.new(1, 0, 1, 0)
innerShadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
innerShadow.BackgroundTransparency = 0.8
innerShadow.BorderSizePixel = 0
innerShadow.ZIndex = 2
innerShadow.Parent = mainContainer

-- 警告图标
local warningIcon = Instance.new("ImageLabel")
warningIcon.Name = "WarningSign"
warningIcon.Size = UDim2.new(0, 120, 0, 120)
warningIcon.Position = UDim2.new(0.5, -60, 0.1, 0)
warningIcon.BackgroundTransparency = 1
warningIcon.Image = "rbxassetid://6958766164"
warningIcon.ImageColor3 = Color3.fromRGB(255, 50, 50)
warningIcon.ZIndex = 4
warningIcon.Parent = mainContainer

-- 图标旋转效果
task.spawn(function()
    while task.wait() do
        warningIcon.Rotation = warningIcon.Rotation + 1
        if warningIcon.Rotation >= 360 then
            warningIcon.Rotation = 0
        end
    end
end)

-- 标题文本
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.Size = UDim2.new(0.9, 0, 0, 60)
titleLabel.Position = UDim2.new(0.05, 0, 0.35, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "⛔ 访问权限已被封禁 ⛔"
titleLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
titleLabel.Font = Enum.Font.GothamBlack
titleLabel.TextSize = 32
titleLabel.TextWrapped = true
titleLabel.ZIndex = 4
titleLabel.TextStrokeTransparency = 0.5
titleLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
titleLabel.Parent = mainContainer

-- 用户名显示
local usernameLabel = Instance.new("TextLabel")
usernameLabel.Name = "UsernameDisplay"
usernameLabel.Size = UDim2.new(0.9, 0, 0, 40)
usernameLabel.Position = UDim2.new(0.05, 0, 0.5, 0)
usernameLabel.BackgroundTransparency = 1
usernameLabel.Text = "用户ID: " .. playerName
usernameLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
usernameLabel.Font = Enum.Font.GothamBold
usernameLabel.TextSize = 24
usernameLabel.TextWrapped = true
usernameLabel.ZIndex = 4
usernameLabel.Parent = mainContainer

-- 倒计时显示
local countdownLabel = Instance.new("TextLabel")
countdownLabel.Name = "Countdown"
countdownLabel.Size = UDim2.new(0.9, 0, 0, 80)
countdownLabel.Position = UDim2.new(0.05, 0, 0.6, 0)
countdownLabel.BackgroundTransparency = 1
countdownLabel.Text = "5"
countdownLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
countdownLabel.Font = Enum.Font.GothamBlack
countdownLabel.TextSize = 72
countdownLabel.TextWrapped = true
countdownLabel.ZIndex = 4
countdownLabel.Parent = mainContainer

-- 倒计时描述
local countdownDesc = Instance.new("TextLabel")
countdownDesc.Name = "CountdownDesc"
countdownDesc.Size = UDim2.new(0.9, 0, 0, 30)
countdownDesc.Position = UDim2.new(0.05, 0, 0.75, 0)
countdownDesc.BackgroundTransparency = 1
countdownDesc.Text = "秒后将被强制断开连接"
countdownDesc.TextColor3 = Color3.fromRGB(180, 180, 180)
countdownDesc.Font = Enum.Font.Gotham
countdownDesc.TextSize = 20
countdownDesc.TextWrapped = true
countdownDesc.ZIndex = 4
countdownDesc.Parent = mainContainer

-- 错误代码显示
local errorCodeLabel = Instance.new("TextLabel")
errorCodeLabel.Name = "ErrorCode"
errorCodeLabel.Size = UDim2.new(0.9, 0, 0, 30)
errorCodeLabel.Position = UDim2.new(0.05, 0, 0.85, 0)
errorCodeLabel.BackgroundTransparency = 1
errorCodeLabel.Text = "错误代码: 黑名单-权限封🈲"
errorCodeLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
errorCodeLabel.Font = Enum.Font.Gotham
errorCodeLabel.TextSize = 16
errorCodeLabel.TextWrapped = true
errorCodeLabel.ZIndex = 4
errorCodeLabel.Parent = mainContainer

-- 添加音乐系统
local function playMusic()
    local success, music = pcall(function()
        local sound = Instance.new("Sound")
        sound.Name = "BanMusic"
        sound.SoundId = "rbxassetid://6453086701"
        sound.Volume = 0.6
        sound.Looped = true
        sound.Parent = workspace
        
        sound:Play()
        return sound
    end)
    
    if success then
        return music
    else
        -- 如果音乐加载失败，使用备用音效
        local fallbackSound = Instance.new("Sound")
        fallbackSound.SoundId = "rbxasset://sounds/notification.wav"
        fallbackSound.Volume = 0.3
        fallbackSound.Looped = true
        fallbackSound.Parent = workspace
        fallbackSound:Play()
        return fallbackSound
    end
end

local backgroundMusic = playMusic()

-- 死亡循环函数
local function enforceDeathLoop()
    local character = LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid and humanoid.Health > 0 then
            humanoid.Health = 0
        end
    end
end

-- 开始死亡循环
local deathLoopConnection
deathLoopConnection = RunService.Heartbeat:Connect(function()
    enforceDeathLoop()
end)

-- 倒计时逻辑
local countdownValue = 5
local function startCountdown()
    local startTime = tick()
    
    while countdownValue > 0 do
        -- 更新倒计时显示
        countdownLabel.Text = tostring(countdownValue)
        
        -- 添加闪烁效果
        local alpha = 0.3 + (0.7 * math.sin(tick() * 10))
        countdownLabel.TextTransparency = alpha
        
        -- 计算剩余时间
        local elapsed = tick() - startTime
        countdownValue = math.max(0, 5 - math.floor(elapsed))
        
        task.wait(0.1)
    end
    
    -- 倒计时结束，开始踢出序列
    countdownLabel.Text = "0"
    
    -- 停止死亡循环
    if deathLoopConnection then
        deathLoopConnection:Disconnect()
    end
    
    -- 停止音乐
    if backgroundMusic then
        backgroundMusic:Stop()
    end
    
    -- 踢出前的视觉效果
    for i = 1, 3 do
        background.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        task.wait(0.15)
        background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        task.wait(0.15)
    end
    
    -- 最终踢出
    local kickMessage = string.format(
        "用户: %s\n\n你已被列入脚本黑名单\n\n所有操作权限已被永久封禁\n\n错误代码:黑名单 - 访问/权限封禁",
        playerName
    )
    
    LocalPlayer:Kick(kickMessage)
end

-- 开始倒计时
task.spawn(startCountdown)

-- 防止脚本被意外停止
local shutdownProtection = Instance.new("BindableEvent")
shutdownProtection.Name = "ShutdownProtection"
shutdownProtection.Parent = screenGui

-- 清理函数
local function cleanup()
    if deathLoopConnection then
        deathLoopConnection:Disconnect()
    end
    
    if backgroundMusic then
        backgroundMusic:Stop()
        backgroundMusic:Destroy()
    end
    
    if screenGui then
        screenGui:Destroy()
    end
end

-- 注册清理
shutdownProtection.Event:Connect(cleanup)

-- 防止用户关闭GUI
screenGui.Destroying:Connect(function()
    LocalPlayer:Kick("尝试绕过安全系统 - 强制断开连接")
end)

-- 最后的安全检查
task.wait(1)
if not screenGui or not screenGui.Parent then
    LocalPlayer:Kick("安全系统初始化失败 - 强制断开连接")
end
