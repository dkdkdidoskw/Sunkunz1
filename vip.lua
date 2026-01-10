-- VIP用户名单（请在此处添加VIP用户名）
local VIP_USERS = {
    "ffgbhvbe",  -- 示例用户1
    "wuckdfs",  -- 示例用户2
    "eggyparty36",  -- 示例用户3
    "ejshsh83",
    "ZUU138458",
    "hshdnc2",
    "blymm78",
    "nvsujwbwg",
    "shenchou888",
    "HPMK00",
}

-- 获取当前玩家用户名
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local playerName = localPlayer.Name

-- 检查是否为VIP用户
local isVIP = false
for _, vipName in ipairs(VIP_USERS) do
    if vipName == playerName then
        isVIP = true
        break
    end
end

local Tween = game:GetService('TweenService') 
local ScriptScreen = Instance.new('ScreenGui', game.Players.LocalPlayer.PlayerGui)
ScriptScreen.Name = "BaiMoScriptGUI"

-- 根据VIP状态设置不同的颜色主题
local VIP_COLORS = {
    Background = isVIP and Color3.new(0.1, 0.05, 0.15) or Color3.new(0, 0, 0),
    Gradient1 = isVIP and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(0, 150, 255),
    Gradient2 = isVIP and Color3.fromRGB(255, 150, 0) or Color3.fromRGB(0, 255, 255),
    TextColor = isVIP and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(255, 255, 255),
    VIPBadgeColor = Color3.fromRGB(255, 215, 0),
    NormalBadgeColor = Color3.fromRGB(150, 150, 150)
}

-- 创建主框架
local Main = Instance.new('Frame', ScriptScreen)
Main.BackgroundTransparency = 0.5
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Position = UDim2.new(0.5, 0, 0.4, 0)
Main.Name = 'Main'
Main.BackgroundColor3 = VIP_COLORS.Background
Main.Size = UDim2.new(0, 500, 0, 300)

local MainC = Instance.new('UICorner', Main)
MainC.CornerRadius = UDim.new(0.05, 0)

local MainS = Instance.new('UIStroke', Main)
MainS.Color = Color3.fromRGB(255, 255, 255)
MainS.Thickness = 3

-- 流光边框效果
local gradient1 = Instance.new('UIGradient', MainS)
gradient1.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, VIP_COLORS.Gradient1),
    ColorSequenceKeypoint.new(1, VIP_COLORS.Gradient2)
}

-- VIP专属边框闪烁效果
if isVIP then
    task.spawn(function()
        while Main and Main.Parent do
            gradient1.Rotation += 3  -- VIP旋转更快
            -- VIP边框闪烁
            MainS.Transparency = 0.3 + math.sin(tick() * 2) * 0.2
            task.wait()
        end
    end)
else
    task.spawn(function()
        while Main and Main.Parent do
            gradient1.Rotation += 1  -- 普通用户旋转较慢
            task.wait()
        end
    end)
end

-- VIP标识（徽章）
local VIPTag = Instance.new('Frame', Main)
VIPTag.BackgroundColor3 = VIP_COLORS.VIPBadgeColor
VIPTag.Size = UDim2.new(0, 100, 0, 30)
VIPTag.Position = UDim2.new(1, -110, 0, 10)
VIPTag.BackgroundTransparency = isVIP and 0.2 or 0.7
VIPTag.Name = 'VIPTag'

local VIPTagCorner = Instance.new('UICorner', VIPTag)
VIPTagCorner.CornerRadius = UDim.new(0.2, 0)

local VIPTagStroke = Instance.new('UIStroke', VIPTag)
VIPTagStroke.Color = isVIP and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(150, 150, 150)
VIPTagStroke.Thickness = 2

local VIPTagLabel = Instance.new('TextLabel', VIPTag)
VIPTagLabel.Size = UDim2.new(1, 0, 1, 0)
VIPTagLabel.BackgroundTransparency = 1
VIPTagLabel.Text = isVIP and "✨ VIP用户 ✨" or "普通用户"
VIPTagLabel.TextColor3 = isVIP and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(150, 150, 150)
VIPTagLabel.Font = Enum.Font.GothamBold
VIPTagLabel.TextSize = 14
VIPTagLabel.TextScaled = true

-- VIP专属徽章动画
if isVIP then
    task.spawn(function()
        while VIPTag and VIPTag.Parent do
            VIPTagStroke.Transparency = 0.3 + math.sin(tick() * 3) * 0.3
            VIPTag.BackgroundTransparency = 0.2 + math.sin(tick() * 2) * 0.15
            task.wait()
        end
    end)
end

-- 标题
local Title1 = Instance.new('TextLabel', Main)
Title1.Text = '陌柒.小迪共创脚本'
Title1.TextSize = 40
Title1.BackgroundTransparency = 1
Title1.TextColor3 = VIP_COLORS.TextColor
Title1.AnchorPoint = Vector2.new(0.5, 0.5)
Title1.Position = UDim2.new(0.5, 0, 0.3, 0)
Title1.Font = Enum.Font.GothamBold

-- VIP专属标题效果
if isVIP then
    task.spawn(function()
        while Title1 and Title1.Parent do
            Title1.TextColor3 = Color3.fromHSV(math.sin(tick() * 0.5) * 0.5 + 0.5, 0.8, 1)
            task.wait(0.1)
        end
    end)
end

-- 玩家欢迎语
local Title2 = Instance.new('TextLabel', Main)
Title2.Text = '尊贵的' .. (isVIP and 'VIP玩家 ' or '玩家 ') .. game.Players.LocalPlayer.Name
Title2.TextSize = 22
Title2.BackgroundTransparency = 1
Title2.TextColor3 = VIP_COLORS.TextColor
Title2.AnchorPoint = Vector2.new(0.5, 0.5)
Title2.Position = UDim2.new(0.5, 0, 0.5, 0)
Title2.Font = isVIP and Enum.Font.GothamBold or Enum.Font.Gotham

-- VIP用户显示额外特权信息
if isVIP then
    local VIPPrivilege = Instance.new('TextLabel', Main)
    VIPPrivilege.Text = '🎁 尊享VIP特权 | ⚡ 极速加载 | 🌟 专属效果'
    VIPPrivilege.TextSize = 16
    VIPPrivilege.BackgroundTransparency = 1
    VIPPrivilege.TextColor3 = Color3.fromRGB(255, 215, 0)
    VIPPrivilege.AnchorPoint = Vector2.new(0.5, 0.5)
    VIPPrivilege.Position = UDim2.new(0.5, 0, 0.6, 0)
    VIPPrivilege.Font = Enum.Font.Gotham
    
    -- 特权信息闪烁效果
    task.spawn(function()
        while VIPPrivilege and VIPPrivilege.Parent do
            VIPPrivilege.TextTransparency = 0.2 + math.sin(tick() * 2) * 0.3
            task.wait(0.1)
        end
    end)
end

local Title3 = Instance.new('TextLabel', Main)
Title3.Text = isVIP and '欢迎使用VIP专属版迪脚本[BaiMo-Script]' or '欢迎使用迪脚本[BaiMo-Script]'
Title3.TextSize = 20
Title3.BackgroundTransparency = 1
Title3.TextColor3 = VIP_COLORS.TextColor
Title3.AnchorPoint = Vector2.new(0.5, 0.5)
Title3.Position = isVIP and UDim2.new(0.5, 0, 0.7, 0) or UDim2.new(0.5, 0, 0.75, 0)
Title3.Font = isVIP and Enum.Font.GothamBold or Enum.Font.Gotham

-- 加载条主框架
local LoadMain = Instance.new('Frame', ScriptScreen)
LoadMain.BackgroundTransparency = 0.5
LoadMain.AnchorPoint = Vector2.new(0.5, 0.5)
LoadMain.Position = UDim2.new(0.5, 0, isVIP and 0.8 or 0.66, 0)
LoadMain.Name = 'LoadMain'
LoadMain.BackgroundColor3 = VIP_COLORS.Background
LoadMain.Size = isVIP and UDim2.new(0, 450, 0, 40) or UDim2.new(0, 500, 0, 50)

local LoadMainC = Instance.new('UICorner', LoadMain)
LoadMainC.CornerRadius = UDim.new(0.08, 0)

local LoadMainS = Instance.new('UIStroke', LoadMain)
LoadMainS.Color = Color3.fromRGB(255, 255, 255)
LoadMainS.Thickness = 3

local gradient2 = Instance.new('UIGradient', LoadMainS)
gradient2.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, VIP_COLORS.Gradient1),
    ColorSequenceKeypoint.new(1, VIP_COLORS.Gradient2)
}

-- 加载条边框动画
if isVIP then
    task.spawn(function()
        while LoadMain and LoadMain.Parent do
            gradient2.Rotation += 2
            LoadMainS.Transparency = 0.2 + math.sin(tick() * 2.5) * 0.2
            task.wait()
        end
    end)
else
    task.spawn(function()
        while LoadMain and LoadMain.Parent do
            gradient2.Rotation += 1
            task.wait()
        end
    end)
end

-- 加载填充条
local LoadFillMain = Instance.new('Frame', LoadMain)
LoadFillMain.BackgroundTransparency = 0.5
LoadFillMain.Name = 'LoadMain'
LoadFillMain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
LoadFillMain.Size = UDim2.new(0, 0, 1, 0)

local LoadFillMainC = Instance.new('UICorner', LoadFillMain)
LoadFillMainC.CornerRadius = UDim.new(0.08, 0)

local gradient3 = Instance.new('UIGradient', LoadFillMain)
gradient3.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, VIP_COLORS.Gradient1),
    ColorSequenceKeypoint.new(1, VIP_COLORS.Gradient2)
}

-- VIP用户填充条渐变旋转
if isVIP then
    task.spawn(function()
        while LoadFillMain and LoadFillMain.Parent do
            gradient3.Rotation += 3
            task.wait()
        end
    end)
else
    task.spawn(function()
        while LoadFillMain and LoadFillMain.Parent do
            gradient3.Rotation += 1
            task.wait()
        end
    end)
end

-- 状态文本
local LoadState = Instance.new('TextLabel', Main)
LoadState.Text = isVIP and '🌟 VIP专属加速加载中...' or '正在加载玩家信息...'
LoadState.TextSize = 18
LoadState.BackgroundTransparency = 1
LoadState.TextColor3 = VIP_COLORS.TextColor
LoadState.AnchorPoint = Vector2.new(0.5, 0.5)
LoadState.Position = isVIP and UDim2.new(0.5, 0, 0.9, 0) or UDim2.new(0.5, 0, 1.3, 0)
LoadState.Font = isVIP and Enum.Font.GothamBold or Enum.Font.Gotham

-- VIP用户状态文本闪烁效果
if isVIP then
    task.spawn(function()
        while LoadState and LoadState.Parent do
            LoadState.TextTransparency = 0.1 + math.sin(tick() * 2) * 0.2
            task.wait(0.1)
        end
    end)
end

-- VIP用户显示加载百分比
local LoadPercent = nil
if isVIP then
    LoadPercent = Instance.new('TextLabel', LoadMain)
    LoadPercent.Size = UDim2.new(1, 0, 1, 0)
    LoadPercent.BackgroundTransparency = 1
    LoadPercent.Text = '0%'
    LoadPercent.TextColor3 = Color3.fromRGB(255, 255, 255)
    LoadPercent.Font = Enum.Font.GothamBold
    LoadPercent.TextSize = 16
    LoadPercent.TextStrokeTransparency = 0.5
end

-- VIP加载进度更新函数
local function updateVIPLoadPercent(percent)
    if isVIP and LoadPercent then
        LoadPercent.Text = math.floor(percent * 100) .. '%'
        -- VIP百分比颜色渐变
        LoadPercent.TextColor3 = Color3.fromHSV(percent * 0.3, 0.8, 1)
    end
end

-- ============ VIP自动关闭计时器 ============
local AutoCloseTimer = nil
local CountdownLabel = nil

if isVIP then
    -- 创建倒计时显示标签
    CountdownLabel = Instance.new('TextLabel', Main)
    CountdownLabel.Size = UDim2.new(0, 150, 0, 25)
    CountdownLabel.Position = UDim2.new(0.5, -75, 0.95, 0)
    CountdownLabel.BackgroundTransparency = 0.8
    CountdownLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    CountdownLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    CountdownLabel.Font = Enum.Font.GothamBold
    CountdownLabel.TextSize = 14
    CountdownLabel.Text = "自动关闭倒计时: 5秒"
    CountdownLabel.Visible = false
    
    local CountdownCorner = Instance.new('UICorner', CountdownLabel)
    CountdownCorner.CornerRadius = UDim.new(0.2, 0)
    
    local CountdownStroke = Instance.new('UIStroke', CountdownLabel)
    CountdownStroke.Color = Color3.fromRGB(255, 215, 0)
    CountdownStroke.Thickness = 2
end

-- VIP自动关闭函数
local function startAutoCloseTimer(seconds)
    if not isVIP then return end
    
    CountdownLabel.Visible = true
    
    local remainingTime = seconds
    AutoCloseTimer = task.spawn(function()
        while remainingTime > 0 and CountdownLabel and CountdownLabel.Parent do
            CountdownLabel.Text = string.format("⏰ 自动关闭倒计时: %d秒", remainingTime)
            
            -- 最后3秒闪烁
            if remainingTime <= 3 then
                CountdownLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
                CountdownLabel.BackgroundTransparency = 0.3 + math.sin(tick() * 10) * 0.3
            end
            
            remainingTime -= 1
            task.wait(1)
        end
        
        if CountdownLabel and CountdownLabel.Parent then
            -- 执行关闭动画
            CountdownLabel.Text = "🎉 加载完成，正在关闭..."
            CountdownLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
            
            -- VIP关闭特效
            task.spawn(function()
                for i = 1, 5 do
                    CountdownLabel.BackgroundTransparency = 0.2 + math.sin(tick() * 20) * 0.3
                    task.wait(0.05)
                end
            end)
            
            task.wait(0.5)
            
            -- 执行优雅的关闭动画
            local fadeOutTime = 0.8
            Tween:Create(Main, TweenInfo.new(fadeOutTime), {
                BackgroundTransparency = 1,
                Size = UDim2.new(0, 0, 0, 0)
            }):Play()
            
            Tween:Create(LoadMain, TweenInfo.new(fadeOutTime), {
                BackgroundTransparency = 1,
                Size = UDim2.new(0, 0, 0, 0)
            }):Play()
            
            Tween:Create(LoadFillMain, TweenInfo.new(fadeOutTime), {
                BackgroundTransparency = 1,
                Size = UDim2.new(0, 0, 0, 0)
            }):Play()
            
            Tween:Create(CountdownLabel, TweenInfo.new(fadeOutTime), {
                BackgroundTransparency = 1,
                TextTransparency = 1
            }):Play()
            
            -- 所有文本元素淡出
            local textElements = {Title1, Title2, Title3, LoadState, VIPPrivilege}
            for _, element in pairs(textElements) do
                if element and element.Parent then
                    Tween:Create(element, TweenInfo.new(fadeOutTime), {
                        TextTransparency = 1
                    }):Play()
                end
            end
            
            if VIPTag and VIPTag.Parent then
                Tween:Create(VIPTag, TweenInfo.new(fadeOutTime), {
                    BackgroundTransparency = 1,
                    Size = UDim2.new(0, 0, 0, 0)
                }):Play()
            end
            
            -- 等待动画完成
            task.wait(fadeOutTime + 0.1)
            
            -- 清理所有UI元素
            Main:Destroy()
            LoadMain:Destroy()
            LoadFillMain:Destroy()
            if CountdownLabel then CountdownLabel:Destroy() end
            if VIPTag then VIPTag:Destroy() end
            
            print("[VIP系统] 界面已自动关闭")
        end
    end)
end

-- VIP手动跳过按钮
local SkipButton = nil
if isVIP then
    SkipButton = Instance.new('TextButton', Main)
    SkipButton.Size = UDim2.new(0, 120, 0, 35)
    SkipButton.Position = UDim2.new(0.5, -60, 1.1, 0)
    SkipButton.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    SkipButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    SkipButton.Font = Enum.Font.GothamBold
    SkipButton.TextSize = 14
    SkipButton.Text = "⏭️ 立即跳过"
    SkipButton.Visible = false
    SkipButton.BorderSizePixel = 0
    
    local SkipCorner = Instance.new('UICorner', SkipButton)
    SkipCorner.CornerRadius = UDim.new(0.2, 0)
    
    SkipButton.MouseButton1Click:Connect(function()
        if AutoCloseTimer then
            task.cancel(AutoCloseTimer)
            AutoCloseTimer = nil
        end
        
        -- 立即关闭特效
        SkipButton.Text = "🎯 正在关闭..."
        SkipButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
        
        -- 立即执行关闭动画
        startAutoCloseTimer(0)
    end)
    
    -- 按钮悬停效果
    SkipButton.MouseEnter:Connect(function()
        SkipButton.BackgroundColor3 = Color3.fromRGB(255, 230, 100)
    end)
    
    SkipButton.MouseLeave:Connect(function()
        SkipButton.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    end)
end

-- ============ 加载动画序列 ============

-- VIP用户有更快的加载速度
local loadTimeMultiplier = isVIP and 0.8 or 1  -- VIP加载速度提升20%

-- 第一阶段加载
task.wait(0.5)
Tween:Create(LoadFillMain, TweenInfo.new(1 * loadTimeMultiplier), {Size = UDim2.new(0.2, 0, 1, 0)}):Play()
updateVIPLoadPercent(0.2)

-- VIP用户特殊音效（可选）
if isVIP and game:GetService("SoundService") then
    task.spawn(function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://3570574687"  -- VIP加载音效
        sound.Volume = 0.2
        sound.Parent = game.Workspace
        sound:Play()
        game:GetService("Debris"):AddItem(sound, 3)
    end)
end

task.wait(1 * loadTimeMultiplier)
LoadState.Text = isVIP and '✨ 正在加载VIP专属界面...' or '正在加载脚本界面...'
Tween:Create(LoadFillMain, TweenInfo.new(0.7 * loadTimeMultiplier), {Size = UDim2.new(0.5, 0, 1, 0)}):Play()
updateVIPLoadPercent(0.5)

task.wait(0.7 * loadTimeMultiplier)
LoadState.Text = isVIP and '⚡ 正在加载VIP特权项目...' or '正在加载项目...'
Tween:Create(LoadFillMain, TweenInfo.new(0.6 * loadTimeMultiplier), {Size = UDim2.new(1, 0, 1, 0)}):Play()
updateVIPLoadPercent(1)

task.wait(0.7 * loadTimeMultiplier)
LoadState.Text = isVIP and '🎉 VIP加载完成! 欢迎尊贵用户!' or '加载完成!'
updateVIPLoadPercent(1)

-- VIP用户完成特效
if isVIP then
    -- VIP完成闪烁效果
    for i = 1, 3 do
        LoadState.TextColor3 = Color3.fromRGB(255, 215, 0)
        task.wait(0.1)
        LoadState.TextColor3 = Color3.fromRGB(255, 255, 255)
        task.wait(0.1)
    end
    
    LoadState.Text = '🎊 迪脚本[BaiMo-Script] 已准备就绪'
    LoadState.TextColor3 = Color3.fromRGB(255, 215, 0)
    
    -- 显示跳过按钮
    if SkipButton then
        SkipButton.Visible = true
        Tween:Create(SkipButton, TweenInfo.new(0.3), {
            Position = UDim2.new(0.5, -60, 0.85, 0)
        }):Play()
    end
    
    -- VIP徽章缩小并移动到右上角
    Tween:Create(VIPTag, TweenInfo.new(0.5), {
        Size = UDim2.new(0, 80, 0, 25),
        Position = UDim2.new(1, -85, 0, 5)
    }):Play()
    
    -- 启动自动关闭倒计时（5秒后自动关闭）
    task.wait(1)  -- 等待1秒让用户看到完成状态
    startAutoCloseTimer(5)
    
    -- VIP完成音效
    if game:GetService("SoundService") then
        task.spawn(function()
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://9118340725"  -- 完成音效
            sound.Volume = 0.3
            sound.Parent = game.Workspace
            sound:Play()
            game:GetService("Debris"):AddItem(sound, 3)
        end)
    end
else
    -- 普通用户流程
    task.wait(0.5)
    Title1:Destroy()
    Title2:Destroy()
    Title3:Destroy()
    LoadState:Destroy()
    if VIPTag then VIPTag:Destroy() end
    
    Tween:Create(Main, TweenInfo.new(0.5), {Size = UDim2.new(0, 0, 0, 0)}):Play()
    Tween:Create(LoadFillMain, TweenInfo.new(0.5), {Size = UDim2.new(0, 0, 0, 0)}):Play()
    Tween:Create(LoadMain, TweenInfo.new(0.5), {Size = UDim2.new(0, 0, 0, 0)}):Play()
    task.wait(0.5)
    Main:Destroy()
    LoadMain:Destroy()
    LoadFillMain:Destroy()
    print("[系统] 普通用户加载完成")
end

-- 输出用户状态信息
print("=================================")
print("迪脚本[BaiMo-Script] 加载系统")
print("用户: " .. playerName)
print("VIP状态: " .. (isVIP and "尊贵VIP用户" or "普通用户"))
print("加载时间: " .. (isVIP and "加速完成" or "标准完成"))
if isVIP then
    print("自动关闭: 5秒后自动关闭界面")
    print("操作提示: 可点击'立即跳过'按钮提前关闭")
end
print("=================================")

-- VIP用户额外提示
if isVIP then
    -- 在聊天框发送VIP提示
    task.spawn(function()
        task.wait(3)
        local message = "🎉 VIP加载完成! 脚本界面将在倒计时结束后自动关闭。"
        if game:GetService("Players").LocalPlayer and game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui") then
            -- 创建一个通知
            local notification = Instance.new("ScreenGui")
            notification.Name = "VIPNotification"
            notification.Parent = game:GetService("Players").LocalPlayer.PlayerGui
            
            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(0, 300, 0, 50)
            frame.Position = UDim2.new(0.5, -150, 0.1, 0)
            frame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
            frame.BackgroundTransparency = 0.3
            frame.Parent = notification
            
            local corner = Instance.new("UICorner", frame)
            corner.CornerRadius = UDim.new(0.1, 0)
            
            local stroke = Instance.new("UIStroke", frame)
            stroke.Color = Color3.fromRGB(255, 215, 0)
            stroke.Thickness = 2
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -20, 1, -10)
            label.Position = UDim2.new(0, 10, 0, 5)
            label.BackgroundTransparency = 1
            label.Text = message
            label.TextColor3 = Color3.fromRGB(255, 215, 0)
            label.Font = Enum.Font.Gotham
            label.TextSize = 14
            label.TextWrapped = true
            label.Parent = frame
            
            -- 3秒后淡出
            task.wait(3)
            Tween:Create(frame, TweenInfo.new(1), {
                BackgroundTransparency = 1,
                Position = UDim2.new(0.5, -150, 0, -100)
            }):Play()
            Tween:Create(stroke, TweenInfo.new(1), {
                Transparency = 1
            }):Play()
            Tween:Create(label, TweenInfo.new(1), {
                TextTransparency = 1
            }):Play()
            
            task.wait(1)
            notification:Destroy()
        end
    end)
end





