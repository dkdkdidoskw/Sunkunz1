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
local localPlayer = game:GetService("Players").LocalPlayer
local playerName = localPlayer.Name

-- 检查是否为VIP用户
local isVIP = false
for _, vipName in ipairs(VIP_USERS) do
    if vipName == playerName then
        isVIP = true
        break
    end
end

-- ============ 新增：作者检测功能 ============
local AUTHOR_USERNAME = "ffgbhvbe"
local isAuthor = (playerName == AUTHOR_USERNAME)

-- ============ 新增：作者弹窗系统 ============
local authorPopupGui = Instance.new("ScreenGui")
authorPopupGui.Name = "AuthorPopupGUI"
authorPopupGui.Parent = game.CoreGui
authorPopupGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- 作者专属弹窗（金色豪华版）
local authorBackground = Instance.new("Frame")
authorBackground.Name = "AuthorBackground"
authorBackground.Parent = authorPopupGui
authorBackground.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
authorBackground.BackgroundTransparency = 0.7
authorBackground.Size = UDim2.new(1, 0, 1, 0)
authorBackground.Position = UDim2.new(0, 0, 0, 0)
authorBackground.Visible = false
authorBackground.ZIndex = 100

-- 作者弹窗主容器
local authorPopup = Instance.new("Frame")
authorPopup.Name = "AuthorPopup"
authorPopup.Parent = authorBackground
authorPopup.Size = UDim2.new(0, 400, 0, 300)
authorPopup.Position = UDim2.new(0.5, -200, 0.5, -150)
authorPopup.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
authorPopup.BorderSizePixel = 0
authorPopup.AnchorPoint = Vector2.new(0.5, 0.5)

-- 作者弹窗边框（炫彩流光效果）
local authorBorder = Instance.new("UIStroke")
authorBorder.Parent = authorPopup
authorBorder.Color = Color3.fromRGB(255, 215, 0)
authorBorder.Thickness = 3
authorBorder.Transparency = 0.2

-- 圆角效果
local authorCorner = Instance.new("UICorner")
authorCorner.CornerRadius = UDim.new(0, 15)
authorCorner.Parent = authorPopup

-- 作者标志（顶部装饰）
local authorTopDecoration = Instance.new("Frame")
authorTopDecoration.Name = "AuthorTopDecoration"
authorTopDecoration.Parent = authorPopup
authorTopDecoration.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
authorTopDecoration.Size = UDim2.new(1, 0, 0, 4)
authorTopDecoration.Position = UDim2.new(0, 0, 0, 0)
authorTopDecoration.BorderSizePixel = 0

-- 作者弹窗标题
local authorTitle = Instance.new("TextLabel")
authorTitle.Name = "AuthorTitle"
authorTitle.Parent = authorPopup
authorTitle.BackgroundTransparency = 1
authorTitle.Size = UDim2.new(1, 0, 0, 60)
authorTitle.Position = UDim2.new(0, 0, 0, 10)
authorTitle.Font = Enum.Font.GothamBlack
authorTitle.Text = "🎉 迪脚本官方系统 🎉"
authorTitle.TextColor3 = Color3.fromRGB(255, 215, 0)
authorTitle.TextSize = 24
authorTitle.TextScaled = false

-- 作者身份标识
local authorIdentity = Instance.new("TextLabel")
authorIdentity.Name = "AuthorIdentity"
authorIdentity.Parent = authorPopup
authorIdentity.BackgroundTransparency = 1
authorIdentity.Size = UDim2.new(1, 0, 0, 30)
authorIdentity.Position = UDim2.new(0, 0, 0, 70)
authorIdentity.Font = Enum.Font.GothamBold

if isAuthor then
    authorIdentity.Text = "👑 欢迎作者：" .. playerName .. " 👑"
    authorIdentity.TextColor3 = Color3.fromRGB(255, 215, 0)
else
    authorIdentity.Text = "📢 脚本作者：" .. AUTHOR_USERNAME .. " 已加入服务器 📢"
    authorIdentity.TextColor3 = Color3.fromRGB(100, 200, 255)
end
authorIdentity.TextSize = 18

-- 作者弹窗内容
local authorContent = Instance.new("TextLabel")
authorContent.Name = "AuthorContent"
authorContent.Parent = authorPopup
authorContent.BackgroundTransparency = 1
authorContent.Size = UDim2.new(1, -40, 0, 120)
authorContent.Position = UDim2.new(0, 20, 0, 110)
authorContent.Font = Enum.Font.Gotham

if isAuthor then
    authorContent.Text = "🎯 作者专属特权已激活！\n\n✨ 特权功能：\n• 金色至尊标识\n• 全功能无限制访问\n• 开发者调试权限\n• 实时服务器监控\n\n🔧 欢迎使用您自己创造的迪脚本！"
    authorContent.TextColor3 = Color3.fromRGB(255, 255, 255)
else
    authorContent.Text = "📜 脚本信息：\n• 脚本名称：迪脚本 VIP 豪华版\n• 作者：" .. AUTHOR_USERNAME .. "\n• 版本：v2.0.1\n• 状态：正常运行中\n\n⚠️ 注意：请勿盗版或修改本脚本\n💡 如遇问题，请联系作者获取帮助"
    authorContent.TextColor3 = Color3.fromRGB(200, 200, 200)
end

authorContent.TextSize = 14
authorContent.TextWrapped = true
authorContent.TextXAlignment = Enum.TextXAlignment.Left
authorContent.TextYAlignment = Enum.TextYAlignment.Top

-- 作者弹窗按钮
local authorButton = Instance.new("TextButton")
authorButton.Name = "AuthorButton"
authorButton.Parent = authorPopup
authorButton.BackgroundColor3 = isAuthor and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(0, 150, 255)
authorButton.Size = UDim2.new(0, 120, 0, 40)
authorButton.Position = UDim2.new(0.5, -60, 0.85, 0)
authorButton.Font = Enum.Font.GothamBold
authorButton.Text = isAuthor and "开始使用" or "我知道了"
authorButton.TextColor3 = isAuthor and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255)
authorButton.TextSize = 16
authorButton.BorderSizePixel = 0

-- 按钮圆角
local authorButtonCorner = Instance.new("UICorner")
authorButtonCorner.CornerRadius = UDim.new(0, 8)
authorButtonCorner.Parent = authorButton

-- 按钮发光效果（仅作者）
if isAuthor then
    local authorButtonGlow = Instance.new("UIStroke")
    authorButtonGlow.Parent = authorButton
    authorButtonGlow.Color = Color3.fromRGB(255, 255, 200)
    authorButtonGlow.Thickness = 2
    authorButtonGlow.Transparency = 0.3
end

-- 作者弹窗按钮点击事件
authorButton.MouseButton1Click:Connect(function()
    -- 缩放消失动画
    for i = 1, 10 do
        authorPopup.Size = UDim2.new(0, 400 - i * 40, 0, 300 - i * 30)
        authorPopup.Position = UDim2.new(0.5, -(200 - i * 20), 0.5, -(150 - i * 15))
        authorPopup.BackgroundTransparency = i * 0.1
        task.wait(0.02)
    end
    authorBackground.Visible = false
end)

-- 显示作者弹窗函数
local function showAuthorPopup()
    authorBackground.Visible = true
    
    -- 初始状态（最小化）
    authorPopup.Size = UDim2.new(0, 10, 0, 10)
    authorPopup.Position = UDim2.new(0.5, -5, 0.5, -5)
    authorPopup.BackgroundTransparency = 1
    
    -- 展开动画
    for i = 1, 20 do
        authorPopup.Size = UDim2.new(0, 10 + i * 19.5, 0, 10 + i * 14.5)
        authorPopup.Position = UDim2.new(0.5, 0, 0.5, 0)
        authorPopup.BackgroundTransparency = 1 - (i * 0.05)
        task.wait(0.01)
    end
    
    -- 作者弹窗的流光效果
    if isAuthor then
        task.spawn(function()
            while authorBackground.Visible and isAuthor do
                local hue = (tick() * 0.5) % 1
                local rainbowColor = Color3.fromHSV(hue, 0.8, 1)
                authorBorder.Color = rainbowColor
                authorTopDecoration.BackgroundColor3 = rainbowColor
                task.wait(0.05)
            end
        end)
    else
        -- 非作者用户的轻微闪烁效果
        task.spawn(function()
            while authorBackground.Visible and not isAuthor do
                local pulse = 0.2 + math.sin(tick() * 2) * 0.1
                authorBorder.Transparency = pulse
                task.wait(0.1)
            end
        end)
    end
end

-- ============ 玩家检测系统（添加作者高亮）============
local Players = game:GetService("Players")

-- 监听玩家加入事件，检测作者是否加入
Players.PlayerAdded:Connect(function(player)
    if player.Name == AUTHOR_USERNAME and player ~= localPlayer then
        -- 检测到真正的作者加入（不是本地玩家）
        print("[作者检测] 脚本作者 " .. AUTHOR_USERNAME .. " 已加入服务器！")
        
        -- 显示作者加入提示（延迟3秒，让作者加载完成）
        task.wait(3)
        
        -- 显示系统消息
        local StarterGui = game:GetService("StarterGui")
        StarterGui:SetCore("ChatMakeSystemMessage", {
            Text = "🎉 [系统通知] 迪脚本作者 " .. AUTHOR_USERNAME .. " 已加入本服务器！",
            Color = Color3.fromRGB(255, 215, 0),
            Font = Enum.Font.GothamBold,
            FontSize = Enum.FontSize.Size18
        })
        
        -- 显示弹窗
        showAuthorPopup()
    end
end)

-- 检查当前服务器中是否有作者（除了自己）
local function checkForAuthorInServer()
    local players = Players:GetPlayers()
    for _, player in ipairs(players) do
        if player.Name == AUTHOR_USERNAME and player ~= localPlayer then
            print("[作者检测] 发现脚本作者已在线！")
            return true
        end
    end
    return false
end

-- 1. 创建 UI 容器与文本标签
local LBLG = Instance.new("ScreenGui")
LBLG.Name = "LBLG"
LBLG.Parent = game.CoreGui
LBLG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
LBLG.Enabled = true

-- 核心：单UI容器，避免冗余
local mainGui = Instance.new("ScreenGui")
mainGui.Name = "VIPTimeDisplay"
mainGui.Parent = game.CoreGui
mainGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
mainGui.Enabled = true

-- 容器优化：尺寸自适应，布局更紧凑
local container = Instance.new("Frame")
container.Name = "Container"
container.Parent = mainGui
container.BackgroundTransparency = 1
container.Position = UDim2.new(0.98, -5, 0.01, 5)
container.AnchorPoint = Vector2.new(1, 0)
container.Size = UDim2.new(0, 170, 0, 36)

-- 第一行：VIP时间显示（根据VIP状态显示不同内容）
local vipLabel = Instance.new("TextLabel")
vipLabel.Name = "VIPLabel"
vipLabel.Parent = container
vipLabel.BackgroundTransparency = 1
vipLabel.Position = UDim2.new(0, 0, 0, 0)
vipLabel.Size = UDim2.new(0, 75, 0, 18)
vipLabel.Font = Enum.Font.GothamBold
vipLabel.TextScaled = true
vipLabel.TextSize = 9
vipLabel.TextXAlignment = Enum.TextXAlignment.Right

-- 根据VIP状态设置不同的文本和颜色
if isVIP then
    if isAuthor then
        vipLabel.Text = "👑 作者时间"
        vipLabel.TextColor3 = Color3.fromRGB(255, 50, 50)  -- 作者红色
    else
        vipLabel.Text = "金贵的VIP时间"
        vipLabel.TextColor3 = Color3.fromRGB(255, 215, 0)  -- 金色
    end
else
    vipLabel.Text = "非VIP用户"
    vipLabel.TextColor3 = Color3.fromRGB(150, 150, 150)  -- 灰色
end

-- 发光效果
if isVIP then
    local vipGlow = Instance.new("UIStroke")
    vipGlow.Parent = vipLabel
    if isAuthor then
        vipGlow.Color = Color3.fromRGB(255, 100, 100)  -- 作者红色发光
    else
        vipGlow.Color = Color3.fromRGB(255, 230, 100)  -- VIP金色发光
    end
    vipGlow.Thickness = 1.5
    vipGlow.Transparency = 0.4
    vipGlow.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
end

-- 时间标签（所有用户都显示）- 修改为彩虹色
local timeLabel = Instance.new("TextLabel")
timeLabel.Name = "TimeLabel"
timeLabel.Parent = container
timeLabel.BackgroundTransparency = 1
timeLabel.Position = UDim2.new(0, 78, 0, 0)
timeLabel.Size = UDim2.new(0, 85, 0, 18)
timeLabel.Font = Enum.Font.GothamSemibold
timeLabel.Text = os.date("%H:%M:%S")
timeLabel.TextScaled = true
timeLabel.TextSize = 8.5
timeLabel.TextXAlignment = Enum.TextXAlignment.Left

-- 第二行：倒计时显示（所有用户都显示）
local toLabel = Instance.new("TextLabel")
toLabel.Name = "ToLabel"
toLabel.Parent = container
toLabel.BackgroundTransparency = 1
toLabel.Position = UDim2.new(0, 0, 0, 18)
toLabel.Size = UDim2.new(0, 12, 0, 18)
toLabel.Font = Enum.Font.GothamSemibold
toLabel.Text = "到"
toLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
toLabel.TextScaled = true
toLabel.TextSize = 8
toLabel.TextXAlignment = Enum.TextXAlignment.Right

-- 目标事件标签（可自定义，所有用户都显示）
local eventLabel = Instance.new("TextLabel")
eventLabel.Name = "EventLabel"
eventLabel.Parent = container
eventLabel.BackgroundTransparency = 1
eventLabel.Position = UDim2.new(0, 15, 0, 18)
eventLabel.Size = UDim2.new(0, 45, 0, 18)
eventLabel.Font = Enum.Font.GothamSemibold
eventLabel.Text = "元旦"
eventLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
eventLabel.TextScaled = true
eventLabel.TextSize = 8
eventLabel.TextXAlignment = Enum.TextXAlignment.Left

-- "还有"标签（所有用户都显示）
local leftLabel = Instance.new("TextLabel")
leftLabel.Name = "LeftLabel"
leftLabel.Parent = container
leftLabel.BackgroundTransparency = 1
leftLabel.Position = UDim2.new(0, 62, 0, 18)
leftLabel.Size = UDim2.new(0, 25, 0, 18)
leftLabel.Font = Enum.Font.GothamSemibold
leftLabel.Text = "还有"
leftLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
leftLabel.TextScaled = true
leftLabel.TextSize = 8
leftLabel.TextXAlignment = Enum.TextXAlignment.Right

-- 详细时间显示（所有用户都显示）- 修改为彩虹色
local detailLabel = Instance.new("TextLabel")
detailLabel.Name = "DetailLabel"
detailLabel.Parent = container
detailLabel.BackgroundTransparency = 1
detailLabel.Position = UDim2.new(0, 90, 0, 18)
detailLabel.Size = UDim2.new(0, 80, 0, 18)
detailLabel.Font = Enum.Font.GothamBold
detailLabel.Text = "计算中..."
detailLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
detailLabel.TextScaled = true
detailLabel.TextSize = 8
detailLabel.TextXAlignment = Enum.TextXAlignment.Left

-- ============ 优化后的弹窗系统（更新内容）============
-- 创建弹窗背景（缩小尺寸）
local popupBackground = Instance.new("Frame")
popupBackground.Name = "PopupBackground"
popupBackground.Parent = mainGui
popupBackground.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
popupBackground.BackgroundTransparency = 0.8
popupBackground.Size = UDim2.new(0, 280, 0, 160)
popupBackground.Position = UDim2.new(0.5, -140, 0.5, -80)
popupBackground.Visible = false
popupBackground.ZIndex = 10
popupBackground.AnchorPoint = Vector2.new(0.5, 0.5)

-- VIP弹窗（金色豪华效果）
local vipPopup = Instance.new("Frame")
vipPopup.Name = "VIPPopup"
vipPopup.Parent = popupBackground
vipPopup.Size = UDim2.new(1, 0, 1, 0)
vipPopup.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
vipPopup.BorderSizePixel = 0
vipPopup.Visible = isVIP  -- 只有VIP显示

-- VIP弹窗边框（金色流光）
local vipBorder = Instance.new("UIStroke")
vipBorder.Parent = vipPopup
if isAuthor then
    vipBorder.Color = Color3.fromRGB(255, 50, 50)  -- 作者红色
else
    vipBorder.Color = Color3.fromRGB(255, 215, 0)  -- VIP金色
end
vipBorder.Thickness = 2
vipBorder.Transparency = 0.3

-- VIP弹窗标题
local vipTitle = Instance.new("TextLabel")
vipTitle.Name = "VIPTitle"
vipTitle.Parent = vipPopup
vipTitle.BackgroundTransparency = 1
vipTitle.Size = UDim2.new(1, 0, 0, 30)
vipTitle.Position = UDim2.new(0, 0, 0, 5)
vipTitle.Font = Enum.Font.GothamBold
if isAuthor then
    vipTitle.Text = "👑 作者至尊特权 👑"
    vipTitle.TextColor3 = Color3.fromRGB(255, 50, 50)
else
    vipTitle.Text = "✨ VIP 尊贵特权 ✨"
    vipTitle.TextColor3 = Color3.fromRGB(255, 215, 0)
end
vipTitle.TextSize = 16
vipTitle.TextScaled = false

-- VIP弹窗内容（更新）
local vipContent = Instance.new("TextLabel")
vipContent.Name = "VIPContent"
vipContent.Parent = vipPopup
vipContent.BackgroundTransparency = 1
vipContent.Size = UDim2.new(1, -20, 0, 70)
vipContent.Position = UDim2.new(0, 10, 0, 40)
vipContent.Font = Enum.Font.Gotham

if isAuthor then
    vipContent.Text = "作者特权已激活：\n• 至尊红色标识\n• 全功能无限制\n• 开发者调试权限\n• 服务器监控能力\n• 自动发送欢迎消息"
else
    vipContent.Text = "特权已解锁：\n• 金色VIP标识\n• 彩虹倒计时特效\n• 弹窗发光动画\n• 自动发送欢迎消息"
end

vipContent.TextColor3 = Color3.fromRGB(255, 255, 255)
vipContent.TextSize = 12
vipContent.TextWrapped = true
vipContent.TextXAlignment = Enum.TextXAlignment.Left
vipContent.TextYAlignment = Enum.TextYAlignment.Top

-- VIP弹窗按钮
local vipButton = Instance.new("TextButton")
vipButton.Name = "VIPButton"
vipButton.Parent = vipPopup
vipButton.BackgroundColor3 = isAuthor and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(255, 215, 0)
vipButton.Size = UDim2.new(0, 80, 0, 25)
vipButton.Position = UDim2.new(0.5, -40, 0.85, 0)
vipButton.Font = Enum.Font.GothamBold
vipButton.Text = isAuthor and "朕知道了" or "朕知道了"
vipButton.TextColor3 = isAuthor and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0)
vipButton.TextSize = 12
vipButton.BorderSizePixel = 0

-- 非VIP弹窗（普通效果）
local nonVipPopup = Instance.new("Frame")
nonVipPopup.Name = "NonVipPopup"
nonVipPopup.Parent = popupBackground
nonVipPopup.Size = UDim2.new(1, 0, 1, 0)
nonVipPopup.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
nonVipPopup.BorderSizePixel = 0
nonVipPopup.Visible = not isVIP  -- 非VIP显示

-- 非VIP弹窗边框（灰色）
local nonVipBorder = Instance.new("UIStroke")
nonVipBorder.Parent = nonVipPopup
nonVipBorder.Color = Color3.fromRGB(120, 120, 120)
nonVipBorder.Thickness = 1.5
nonVipBorder.Transparency = 0.4

-- 非VIP弹窗标题
local nonVipTitle = Instance.new("TextLabel")
nonVipTitle.Name = "NonVipTitle"
nonVipTitle.Parent = nonVipPopup
nonVipTitle.BackgroundTransparency = 1
nonVipTitle.Size = UDim2.new(1, 0, 0, 30)
nonVipTitle.Position = UDim2.new(0, 0, 0, 5)
nonVipTitle.Font = Enum.Font.Gotham
nonVipTitle.Text = "普通用户提示"
nonVipTitle.TextColor3 = Color3.fromRGB(180, 180, 180)
nonVipTitle.TextSize = 14

-- 非VIP弹窗内容（更新）
local nonVipContent = Instance.new("TextLabel")
nonVipContent.Name = "NonVipContent"
nonVipContent.Parent = nonVipPopup
nonVipContent.BackgroundTransparency = 1
nonVipContent.Size = UDim2.new(1, -20, 0, 70)
nonVipContent.Position = UDim2.new(0, 10, 0, 40)
nonVipContent.Font = Enum.Font.Gotham
nonVipContent.Text = "当前可用功能：\n• 实时时间显示\n• 节日倒计时\n• 弹窗提示\n• 自动发送欢迎消息\n\n升级VIP可解锁炫酷特效\n\n脚本作者：" .. AUTHOR_USERNAME
nonVipContent.TextColor3 = Color3.fromRGB(180, 180, 180)
nonVipContent.TextSize = 11
nonVipContent.TextWrapped = true
nonVipContent.TextXAlignment = Enum.TextXAlignment.Left
nonVipContent.TextYAlignment = Enum.TextYAlignment.Top

-- 非VIP弹窗按钮
local nonVipButton = Instance.new("TextButton")
nonVipButton.Name = "NonVipButton"
nonVipButton.Parent = nonVipPopup
nonVipButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
nonVipButton.Size = UDim2.new(0, 80, 0, 25)
nonVipButton.Position = UDim2.new(0.5, -40, 0.85, 0)
nonVipButton.Font = Enum.Font.Gotham
nonVipButton.Text = "明白了"
nonVipButton.TextColor3 = Color3.fromRGB(255, 255, 255)
nonVipButton.TextSize = 12
nonVipButton.BorderSizePixel = 0

-- 弹窗圆角效果
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = popupBackground

local vipCorner = Instance.new("UICorner")
vipCorner.CornerRadius = UDim.new(0, 8)
vipCorner.Parent = vipPopup

local nonVipCorner = Instance.new("UICorner")
nonVipCorner.CornerRadius = UDim.new(0, 8)
nonVipCorner.Parent = nonVipPopup

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 5)
buttonCorner.Parent = vipButton
buttonCorner:Clone().Parent = nonVipButton

-- VIP弹窗按钮点击事件
vipButton.MouseButton1Click:Connect(function()
    popupBackground.Visible = false
end)

-- 非VIP弹窗按钮点击事件
nonVipButton.MouseButton1Click:Connect(function()
    popupBackground.Visible = false
end)

-- 弹窗显示函数（简化动画）
local function showPopup()
    popupBackground.Visible = true
    popupBackground.Size = UDim2.new(0, 10, 0, 10)
    popupBackground.Position = UDim2.new(0.5, -5, 0.5, -5)
    
    -- 展开动画
    for i = 1, 10 do
        popupBackground.Size = UDim2.new(0, 10 + i * 27, 0, 10 + i * 15)
        popupBackground.Position = UDim2.new(0.5, 0, 0.5, 0)
        task.wait(0.01)
    end
    
    -- VIP用户的额外闪烁效果
    if isVIP then
        task.spawn(function()
            while popupBackground.Visible and isVIP do
                if isAuthor then
                    vipBorder.Transparency = 0.2 + math.sin(tick() * 3) * 0.3
                else
                    vipBorder.Transparency = 0.3 + math.sin(tick() * 3) * 0.2
                end
                task.wait(0.05)
            end
        end)
    end
end

-- ============ 新增：对局玩家检测系统 ============
local playerListGui = Instance.new("ScreenGui")
playerListGui.Name = "PlayerListGUI"
playerListGui.Parent = game.CoreGui
playerListGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- 玩家列表容器（右上角）
local playerListContainer = Instance.new("Frame")
playerListContainer.Name = "PlayerListContainer"
playerListContainer.Parent = playerListGui
playerListContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
playerListContainer.BackgroundTransparency = 0.1
playerListContainer.BorderSizePixel = 0
playerListContainer.Position = UDim2.new(0.98, -200, 0.01, 45)
playerListContainer.AnchorPoint = Vector2.new(1, 0)
playerListContainer.Size = UDim2.new(0, 195, 0, 30)
playerListContainer.Visible = false  -- 默认隐藏，需要时显示

-- 圆角
local listCorner = Instance.new("UICorner")
listCorner.CornerRadius = UDim.new(0, 6)
listCorner.Parent = playerListContainer

-- 边框
local listBorder = Instance.new("UIStroke")
listBorder.Parent = playerListContainer
listBorder.Color = Color3.fromRGB(60, 60, 80)
listBorder.Thickness = 1.5

-- 标题栏
local listTitle = Instance.new("TextLabel")
listTitle.Name = "ListTitle"
listTitle.Parent = playerListContainer
listTitle.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
listTitle.Size = UDim2.new(1, 0, 0, 25)
listTitle.Font = Enum.Font.GothamBold
listTitle.Text = "对局玩家检测"
listTitle.TextColor3 = Color3.fromRGB(220, 220, 220)
listTitle.TextSize = 12
listTitle.TextXAlignment = Enum.TextXAlignment.Center

-- 标题栏圆角（仅顶部）
local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 6)
titleCorner.Parent = listTitle

-- 玩家列表滚动框
local playerListScrolling = Instance.new("ScrollingFrame")
playerListScrolling.Name = "PlayerListScrolling"
playerListScrolling.Parent = playerListContainer
playerListScrolling.BackgroundTransparency = 1
playerListScrolling.Position = UDim2.new(0, 0, 0, 25)
playerListScrolling.Size = UDim2.new(1, 0, 1, -25)
playerListScrolling.CanvasSize = UDim2.new(0, 0, 0, 0)
playerListScrolling.ScrollBarThickness = 4
playerListScrolling.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 100)

-- 玩家列表UI列表布局
local playerListUIList = Instance.new("UIListLayout")
playerListUIList.Parent = playerListScrolling
playerListUIList.SortOrder = Enum.SortOrder.Name
playerListUIList.Padding = UDim.new(0, 2)

-- 显示/隐藏玩家列表的按钮
local toggleListButton = Instance.new("TextButton")
toggleListButton.Name = "ToggleListButton"
toggleListButton.Parent = mainGui
toggleListButton.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
toggleListButton.BackgroundTransparency = 0.1
toggleListButton.Position = UDim2.new(0.98, -35, 0.01, 45)
toggleListButton.AnchorPoint = Vector2.new(1, 0)
toggleListButton.Size = UDim2.new(0, 30, 0, 30)
toggleListButton.Font = Enum.Font.GothamBold
toggleListButton.Text = "👥"
toggleListButton.TextColor3 = Color3.fromRGB(220, 220, 220)
toggleListButton.TextSize = 14
toggleListButton.BorderSizePixel = 0

-- 按钮圆角和边框
local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 6)
toggleCorner.Parent = toggleListButton

local toggleBorder = Instance.new("UIStroke")
toggleBorder.Parent = toggleListButton
toggleBorder.Color = Color3.fromRGB(60, 60, 80)
toggleBorder.Thickness = 1.5

-- 玩家列表切换功能
local isListVisible = false
toggleListButton.MouseButton1Click:Connect(function()
    isListVisible = not isListVisible
    playerListContainer.Visible = isListVisible
    toggleListButton.BackgroundColor3 = isListVisible and Color3.fromRGB(45, 45, 65) or Color3.fromRGB(35, 35, 45)
    
    if isListVisible then
        updatePlayerList()
    end
end)

-- 更新玩家列表函数（添加作者检测）
function updatePlayerList()
    -- 清空现有列表
    for _, child in ipairs(playerListScrolling:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    
    local players = Players:GetPlayers()
    local vipCount = 0
    local authorCount = 0
    local totalCount = #players
    
    -- 为每个玩家创建显示项
    for _, player in ipairs(players) do
        local isPlayerVIP = false
        local isPlayerAuthor = (player.Name == AUTHOR_USERNAME)
        
        -- 检查是否为VIP
        for _, vipName in ipairs(VIP_USERS) do
            if vipName == player.Name then
                isPlayerVIP = true
                vipCount = vipCount + 1
                break
            end
        end
        
        if isPlayerAuthor then
            authorCount = authorCount + 1
        end
        
        local playerItem = Instance.new("Frame")
        playerItem.Name = player.Name
        playerItem.Parent = playerListScrolling
        playerItem.BackgroundTransparency = 1
        playerItem.Size = UDim2.new(1, -10, 0, 20)
        
        local playerColor = Instance.new("Frame")
        playerColor.Name = "ColorIndicator"
        playerColor.Parent = playerItem
        if isPlayerAuthor then
            playerColor.BackgroundColor3 = Color3.fromRGB(255, 50, 50)  -- 作者红色
        elseif isPlayerVIP then
            playerColor.BackgroundColor3 = Color3.fromRGB(255, 215, 0)  -- VIP金色
        else
            playerColor.BackgroundColor3 = Color3.fromRGB(100, 100, 120)  -- 普通用户
        end
        playerColor.Size = UDim2.new(0, 4, 1, 0)
        playerColor.BorderSizePixel = 0
        
        local playerNameLabel = Instance.new("TextLabel")
        playerNameLabel.Name = "PlayerName"
        playerNameLabel.Parent = playerItem
        playerNameLabel.BackgroundTransparency = 1
        playerNameLabel.Position = UDim2.new(0, 8, 0, 0)
        playerNameLabel.Size = UDim2.new(0.6, -8, 1, 0)
        playerNameLabel.Font = Enum.Font.Gotham
        playerNameLabel.Text = player.Name
        if isPlayerAuthor then
            playerNameLabel.TextColor3 = Color3.fromRGB(255, 100, 100)  -- 作者红色
            playerNameLabel.Font = Enum.Font.GothamBold
        elseif isPlayerVIP then
            playerNameLabel.TextColor3 = Color3.fromRGB(255, 215, 0)  -- VIP金色
        else
            playerNameLabel.TextColor3 = Color3.fromRGB(220, 220, 220)  -- 普通用户
        end
        playerNameLabel.TextSize = 11
        playerNameLabel.TextXAlignment = Enum.TextXAlignment.Left
        playerNameLabel.TextTruncate = Enum.TextTruncate.AtEnd
        
        local playerStatusLabel = Instance.new("TextLabel")
        playerStatusLabel.Name = "PlayerStatus"
        playerStatusLabel.Parent = playerItem
        playerStatusLabel.BackgroundTransparency = 1
        playerStatusLabel.Position = UDim2.new(0.6, 5, 0, 0)
        playerStatusLabel.Size = UDim2.new(0.4, -5, 1, 0)
        playerStatusLabel.Font = Enum.Font.Gotham
        if isPlayerAuthor then
            playerStatusLabel.Text = "👑 作者"
            playerStatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        elseif isPlayerVIP then
            playerStatusLabel.Text = "VIP会员"
            playerStatusLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
        else
            playerStatusLabel.Text = "普通用户"
            playerStatusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
        end
        playerStatusLabel.TextSize = 10
        playerStatusLabel.TextXAlignment = Enum.TextXAlignment.Right
    end
    
    -- 更新标题显示统计信息
    local titleText = "玩家检测"
    if authorCount > 0 then
        titleText = string.format("玩家检测 (作者: %d, VIP: %d/%d)", authorCount, vipCount, totalCount)
    else
        titleText = string.format("玩家检测 (VIP: %d/%d)", vipCount, totalCount)
    end
    listTitle.Text = titleText
    
    -- 更新滚动区域大小
    playerListScrolling.CanvasSize = UDim2.new(0, 0, 0, playerListUIList.AbsoluteContentSize.Y)
    
    -- 调整容器高度（最多显示10个玩家）
    local maxHeight = math.min(totalCount * 22 + 25, 10 * 22 + 25)
    playerListContainer.Size = UDim2.new(0, 195, 0, maxHeight)
end

-- 监听玩家加入/离开事件
Players.PlayerAdded:Connect(function(player)
    if isListVisible then
        updatePlayerList()
    end
    
    -- 如果作者加入，显示欢迎消息
    if player.Name == AUTHOR_USERNAME and player ~= localPlayer then
        task.wait(2)
        print("[作者系统] 欢迎作者 " .. AUTHOR_USERNAME .. " 加入服务器！")
    end
end)

Players.PlayerRemoving:Connect(function(player)
    if isListVisible then
        task.wait(0.5) -- 等待玩家完全离开
        updatePlayerList()
    end
end)

-- 点击容器显示弹窗
container.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        showPopup()
    end
end)

-- ============ 新增：自动发送欢迎消息功能 ============
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")

-- ============ 新增：消息确认弹窗系统 ============
local messageConfirmGui = Instance.new("ScreenGui")
messageConfirmGui.Name = "MessageConfirmGUI"
messageConfirmGui.Parent = game.CoreGui
messageConfirmGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- 确认弹窗背景
local confirmBackground = Instance.new("Frame")
confirmBackground.Name = "ConfirmBackground"
confirmBackground.Parent = messageConfirmGui
confirmBackground.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
confirmBackground.BackgroundTransparency = 0.7
confirmBackground.Size = UDim2.new(1, 0, 1, 0)
confirmBackground.Position = UDim2.new(0, 0, 0, 0)
confirmBackground.Visible = false
confirmBackground.ZIndex = 99

-- 确认弹窗主容器
local confirmPopup = Instance.new("Frame")
confirmPopup.Name = "ConfirmPopup"
confirmPopup.Parent = confirmBackground
confirmPopup.Size = UDim2.new(0, 350, 0, 200)
confirmPopup.Position = UDim2.new(0.5, -175, 0.5, -100)
confirmPopup.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
confirmPopup.BorderSizePixel = 0
confirmPopup.AnchorPoint = Vector2.new(0.5, 0.5)

-- 弹窗边框
local confirmBorder = Instance.new("UIStroke")
confirmBorder.Parent = confirmPopup
confirmBorder.Color = isAuthor and Color3.fromRGB(255, 50, 50) or (isVIP and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(100, 100, 120))
confirmBorder.Thickness = 2
confirmBorder.Transparency = 0.3

-- 圆角效果
local confirmCorner = Instance.new("UICorner")
confirmCorner.CornerRadius = UDim.new(0, 12)
confirmCorner.Parent = confirmPopup

-- 标题
local confirmTitle = Instance.new("TextLabel")
confirmTitle.Name = "ConfirmTitle"
confirmTitle.Parent = confirmPopup
confirmTitle.BackgroundTransparency = 1
confirmTitle.Size = UDim2.new(1, 0, 0, 40)
confirmTitle.Position = UDim2.new(0, 0, 0, 10)
confirmTitle.Font = Enum.Font.GothamBold
confirmTitle.Text = "📢 发送欢迎消息确认"
confirmTitle.TextColor3 = isAuthor and Color3.fromRGB(255, 100, 100) or (isVIP and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(200, 200, 200))
confirmTitle.TextSize = 18

-- 消息内容
local confirmMessage = Instance.new("TextLabel")
confirmMessage.Name = "ConfirmMessage"
confirmMessage.Parent = confirmPopup
confirmMessage.BackgroundTransparency = 1
confirmMessage.Size = UDim2.new(1, -40, 0, 60)
confirmMessage.Position = UDim2.new(0, 20, 0, 60)
confirmMessage.Font = Enum.Font.Gotham

local welcomeText = ""
if isAuthor then
    welcomeText = "👑 迪脚本作者 " .. playerName .. " 已上线！"
elseif isVIP then
    welcomeText = "尊敬的VIP，欢迎使用迪脚本！"
else
    welcomeText = "欢迎使用迪脚本！"
end

confirmMessage.Text = "将发送以下消息到聊天框：\n\n\"" .. welcomeText .. "\"\n\n是否确认发送？"
confirmMessage.TextColor3 = Color3.fromRGB(220, 220, 220)
confirmMessage.TextSize = 13
confirmMessage.TextWrapped = true
confirmMessage.TextXAlignment = Enum.TextXAlignment.Center
confirmMessage.TextYAlignment = Enum.TextYAlignment.Top

-- 倒计时显示
local countdownLabel = Instance.new("TextLabel")
countdownLabel.Name = "CountdownLabel"
countdownLabel.Parent = confirmPopup
countdownLabel.BackgroundTransparency = 1
countdownLabel.Size = UDim2.new(1, 0, 0, 20)
countdownLabel.Position = UDim2.new(0, 0, 0, 125)
countdownLabel.Font = Enum.Font.Gotham
countdownLabel.Text = "10秒内未选择将默认不发送"
countdownLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
countdownLabel.TextSize = 11

-- 按钮容器
local buttonContainer = Instance.new("Frame")
buttonContainer.Name = "ButtonContainer"
buttonContainer.Parent = confirmPopup
buttonContainer.BackgroundTransparency = 1
buttonContainer.Size = UDim2.new(1, -40, 0, 40)
buttonContainer.Position = UDim2.new(0, 20, 0, 150)

-- 发送按钮
local sendButton = Instance.new("TextButton")
sendButton.Name = "SendButton"
sendButton.Parent = buttonContainer
sendButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
sendButton.Size = UDim2.new(0, 100, 0, 35)
sendButton.Position = UDim2.new(0, 0, 0, 0)
sendButton.Font = Enum.Font.GothamBold
sendButton.Text = "✅ 确认发送"
sendButton.TextColor3 = Color3.fromRGB(255, 255, 255)
sendButton.TextSize = 13

-- 不发送按钮
local dontSendButton = Instance.new("TextButton")
dontSendButton.Name = "DontSendButton"
dontSendButton.Parent = buttonContainer
dontSendButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
dontSendButton.Size = UDim2.new(0, 100, 0, 35)
dontSendButton.Position = UDim2.new(1, -100, 0, 0)
dontSendButton.Font = Enum.Font.Gotham
dontSendButton.Text = "❌ 不发送"
dontSendButton.TextColor3 = Color3.fromRGB(255, 255, 255)
dontSendButton.TextSize = 13

-- 按钮圆角
local buttonCorner1 = Instance.new("UICorner")
buttonCorner1.CornerRadius = UDim.new(0, 6)
buttonCorner1.Parent = sendButton

local buttonCorner2 = Instance.new("UICorner")
buttonCorner2.CornerRadius = UDim.new(0, 6)
buttonCorner2.Parent = dontSendButton

-- 变量跟踪确认状态
local messageConfirmed = nil  -- nil: 未选择, true: 发送, false: 不发送
local countdownTimer = 10

-- 发送聊天消息的函数
local function sendWelcomeMessage()
    local message = welcomeText
    
    -- 方法1：尝试使用TextChatService（Roblox新聊天系统）
    if TextChatService then
        local chatTextChannel = TextChatService:FindFirstChild("TextChannels")
        if chatTextChannel then
            chatTextChannel = chatTextChannel:FindFirstChild("RBXGeneral")
            if chatTextChannel then
                chatTextChannel:SendAsync(message)
                print("[自动消息] 通过TextChatService发送:", message)
                return
            end
        end
    end
    
    -- 方法2：尝试使用旧版聊天（SayMessageRequest）
    local SayMessageRequest = ReplicatedStorage:FindFirstChild("SayMessageRequest")
    if not SayMessageRequest then
        SayMessageRequest = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
        if SayMessageRequest then
            SayMessageRequest = SayMessageRequest:FindFirstChild("SayMessageRequest")
        end
    end
    
    if SayMessageRequest then
        SayMessageRequest:FireServer(message, "All")
        print("[自动消息] 通过SayMessageRequest发送:", message)
        return
    end
    
    -- 如果所有方法都失败，尝试模拟按键输入
    local StarterGui = game:GetService("StarterGui")
    if isAuthor then
        StarterGui:SetCore("ChatMakeSystemMessage", {
            Text = "[作者系统] " .. message,
            Color = Color3.fromRGB(255, 50, 50),
            Font = Enum.Font.GothamBold,
            FontSize = Enum.FontSize.Size20
        })
    else
        StarterGui:SetCore("ChatMakeSystemMessage", {
            Text = "[系统] " .. message,
            Color = isVIP and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(100, 200, 255),
            Font = Enum.Font.GothamBold,
            FontSize = Enum.FontSize.Size18
        })
    end
    
    print("[自动消息] 通过系统消息显示:", message)
end

-- 显示确认弹窗的函数
local function showMessageConfirm()
    confirmBackground.Visible = true
    messageConfirmed = nil
    countdownTimer = 10
    
    -- 初始动画
    confirmPopup.Size = UDim2.new(0, 10, 0, 10)
    confirmPopup.Position = UDim2.new(0.5, -5, 0.5, -5)
    confirmPopup.BackgroundTransparency = 1
    
    -- 展开动画
    for i = 1, 20 do
        confirmPopup.Size = UDim2.new(0, 10 + i * 17, 0, 10 + i * 9.5)
        confirmPopup.Position = UDim2.new(0.5, 0, 0.5, 0)
        confirmPopup.BackgroundTransparency = 1 - (i * 0.05)
        task.wait(0.01)
    end
    
    -- 边框闪烁效果
    task.spawn(function()
        while confirmBackground.Visible and messageConfirmed == nil do
            local pulse = 0.3 + math.sin(tick() * 3) * 0.2
            confirmBorder.Transparency = pulse
            task.wait(0.05)
        end
    end)
    
    -- 倒计时
    task.spawn(function()
        while confirmBackground.Visible and messageConfirmed == nil and countdownTimer > 0 do
            countdownLabel.Text = string.format("%d秒内未选择将默认不发送", countdownTimer)
            countdownTimer = countdownTimer - 1
            task.wait(1)
        end
        
        -- 倒计时结束
        if confirmBackground.Visible and messageConfirmed == nil then
            messageConfirmed = false
            print("[消息确认] 倒计时结束，默认不发送消息")
            
            -- 关闭弹窗动画
            for i = 1, 10 do
                confirmPopup.BackgroundTransparency = 0.5 + (i * 0.05)
                task.wait(0.02)
            end
            confirmBackground.Visible = false
        end
    end)
end

-- 按钮事件
sendButton.MouseButton1Click:Connect(function()
    messageConfirmed = true
    print("[消息确认] 用户选择发送消息")
    
    -- 发送消息
    sendWelcomeMessage()
    
    -- 关闭弹窗动画
    for i = 1, 10 do
        confirmPopup.BackgroundTransparency = 0.5 + (i * 0.05)
        task.wait(0.02)
    end
    confirmBackground.Visible = false
end)

dontSendButton.MouseButton1Click:Connect(function()
    messageConfirmed = false
    print("[消息确认] 用户选择不发送消息")
    
    -- 关闭弹窗动画
    for i = 1, 10 do
        confirmPopup.BackgroundTransparency = 0.5 + (i * 0.05)
        task.wait(0.02)
    end
    confirmBackground.Visible = false
end)

-- 自动发送欢迎消息（延迟5秒，确保游戏加载完成）
task.spawn(function()
    task.wait(5) -- 等待5秒确保游戏完全加载
    
    -- 显示确认弹窗
    showMessageConfirm()
    
    -- 等待用户选择（最长10秒）
    local startTime = tick()
    while tick() - startTime < 10 and messageConfirmed == nil do
        task.wait(0.1)
    end
    
    -- 如果用户选择了发送，不再发送额外消息
    if messageConfirmed then
        return
    end
    
    -- 作者用户显示专属消息
    if isAuthor then
        task.wait(2)
        
        -- 显示作者专属弹窗
        showAuthorPopup()
        
        local authorExclusiveMessage = "👑 作者特权已激活！享受至尊红色标识和全功能无限制访问！"
        
        -- 使用系统消息显示作者专属消息
        local StarterGui = game:GetService("StarterGui")
        StarterGui:SetCore("ChatMakeSystemMessage", {
            Text = "[作者系统] " .. authorExclusiveMessage,
            Color = Color3.fromRGB(255, 50, 50),
            Font = Enum.Font.GothamBold,
            FontSize = Enum.FontSize.Size18
        })
        
        -- 检查服务器中是否有其他作者（除了自己）
        if checkForAuthorInServer() then
            task.wait(3)
            StarterGui:SetCore("ChatMakeSystemMessage", {
                Text = "[系统警告] 检测到多个作者账号，请确保账号安全！",
                Color = Color3.fromRGB(255, 100, 100),
                Font = Enum.Font.GothamBold,
                FontSize = Enum.FontSize.Size16
            })
        end
    elseif isVIP then
        task.wait(2) -- 等待2秒再发送VIP专属消息
        local vipExclusiveMessage = "VIP特权已激活！享受专属金色标识和彩虹特效！"
        
        -- 使用系统消息显示VIP专属消息
        local StarterGui = game:GetService("StarterGui")
        StarterGui:SetCore("ChatMakeSystemMessage", {
            Text = "[VIP系统] " .. vipExclusiveMessage,
            Color = Color3.fromRGB(255, 215, 0),
            Font = Enum.Font.GothamBold,
            FontSize = Enum.FontSize.Size16
        })
    end
end)

-- ============ 彩虹颜色逻辑 ============
local Hue = 0
local function HSVToRGB(h, s, v)
    local r, g, b
    local i = math.floor(h * 6)
    local f = h * 6 - i
    local p = v * (1 - s)
    local q = v * (1 - f * s)
    local t = v * (1 - (1 - f) * s)
    
    i = i % 6
    if i == 0 then r, g, b = v, t, p
    elseif i == 1 then r, g, b = q, v, p
    elseif i == 2 then r, g, b = p, v, t
    elseif i == 3 then r, g, b = p, q, v
    elseif i == 4 then r, g, b = t, p, v
    else r, g, b = v, p, q end
    
    return Color3.new(r, g, b)
end

-- 彩虹颜色更新函数（用于时间和倒计时）
local function updateRainbowColors()
    while task.wait() and timeLabel and timeLabel.Parent do
        Hue = (Hue + 0.002) % 1
        local rainbowColor = HSVToRGB(Hue, 0.8, 1)
        
        -- 更新时间显示颜色（彩虹色）
        timeLabel.TextColor3 = rainbowColor
        
        -- 更新倒计时颜色（彩虹色）
        if detailLabel then
            detailLabel.TextColor3 = rainbowColor
        end
        
        -- 特殊效果：作者和VIP有额外闪烁
        if isAuthor or isVIP then
            local pulse = 0.7 + math.sin(tick() * 2) * 0.3
            if isAuthor then
                timeLabel.TextTransparency = pulse * 0.5
                if detailLabel then
                    detailLabel.TextTransparency = pulse * 0.5
                end
            else
                timeLabel.TextTransparency = pulse * 0.3
                if detailLabel then
                    detailLabel.TextTransparency = pulse * 0.3
                end
            end
        end
        
        task.wait(0.05)
    end
end

-- 中国节日数据库
local ChineseFestivals = {
    {name = "元旦", month = 1, day = 1, color = Color3.fromRGB(255, 100, 100)},
    {name = "春节", month = 1, day = 29, color = Color3.fromRGB(255, 215, 0)},
    {name = "元宵节", month = 2, day = 12, color = Color3.fromRGB(255, 150, 200)},
    {name = "清明节", month = 4, day = 4, color = Color3.fromRGB(100, 255, 100)},
    {name = "劳动节", month = 5, day = 1, color = Color3.fromRGB(255, 100, 100)},
    {name = "端午节", month = 5, day = 31, color = Color3.fromRGB(255, 100, 100)},
    {name = "中秋节", month = 9, day = 29, color = Color3.fromRGB(255, 215, 0)},
    {name = "国庆节", month = 10, day = 1, color = Color3.fromRGB(255, 100, 100)},
    {name = "情人节", month = 2, day = 14, color = Color3.fromRGB(255, 150, 200)},
    {name = "圣诞节", month = 12, day = 25, color = Color3.fromRGB(255, 100, 100)},
    {name = "生日", month = 8, day = 15, color = Color3.fromRGB(0, 200, 255)},
}

-- 获取下一个节日
local function getNextFestival()
    local currentTime = os.time()
    local currentYear = tonumber(os.date("%Y", currentTime))
    local nextFestival = nil
    local minDiff = math.huge
    
    for _, festival in ipairs(ChineseFestivals) do
        local festivalTime = os.time({
            year = currentYear,
            month = festival.month,
            day = festival.day,
            hour = 0,
            min = 0,
            sec = 0
        })
        
        if festivalTime < currentTime then
            festivalTime = os.time({
                year = currentYear + 1,
                month = festival.month,
                day = festival.day,
                hour = 0,
                min = 0,
                sec = 0
            })
        end
        
        local diff = festivalTime - currentTime
        
        if diff < minDiff and diff > 0 then
            minDiff = diff
            nextFestival = {
                name = festival.name,
                time = festivalTime,
                color = festival.color
            }
        end
    end
    
    return nextFestival
end

-- VIP闪烁动画（作者有特殊效果）
local function vipPulseAnimation()
    while task.wait() and vipLabel and vipLabel.Parent do
        if isVIP then
            local pulse = 0.4 + math.sin(tick() * 1.8) * 0.08
            for _, child in ipairs(vipLabel:GetChildren()) do
                if child:IsA("UIStroke") then
                    child.Transparency = pulse
                end
            end
            vipLabel.TextTransparency = 0.15 + math.abs(math.sin(tick() * 3.5)) * 0.08
            
            -- 作者专属的红色闪烁效果
            if isAuthor then
                local redPulse = 0.2 + math.abs(math.sin(tick() * 2)) * 0.3
                vipLabel.TextColor3 = Color3.new(1, 0.2 + redPulse * 0.3, 0.2 + redPulse * 0.3)
            end
        else
            vipLabel.TextTransparency = 0
        end
        task.wait(0.05)
    end
end

-- 计算目标时间
local function getNextTargetTime()
    local nextFestival = getNextFestival()
    if nextFestival then
        eventLabel.TextColor3 = nextFestival.color
        eventLabel.Text = nextFestival.name
        return nextFestival.time
    end
    
    local currentTime = os.time()
    local currentYear = tonumber(os.date("%Y", currentTime))
    eventLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    eventLabel.Text = "元旦"
    return os.time({
        year = currentYear + 1,
        month = 1,
        day = 1,
        hour = 0,
        min = 0,
        sec = 0
    })
end

-- 时间格式化函数
local function formatTime(seconds)
    if seconds <= 0 then return "已到" end
    
    local days = math.floor(seconds / 86400)
    local hours = math.floor((seconds % 86400) / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local secs = math.floor(seconds % 60)
    
    if days > 0 then
        return string.format("%d天%d时", days, hours)
    elseif hours > 0 then
        return string.format("%d时%d分", hours, minutes)
    else
        return string.format("%d分%d秒", minutes, secs)
    end
end

-- 获取目标时间
local targetTime = getNextTargetTime()

-- 更新时间显示
local function updateTime()
    while task.wait() and timeLabel and detailLabel and timeLabel.Parent do
        timeLabel.Text = os.date("%H:%M:%S")
        
        local currentTime = os.time()
        local timeDiff = targetTime - currentTime
        
        if timeDiff > 0 then
            detailLabel.Text = formatTime(timeDiff)
        else
            detailLabel.Text = "已到"
            
            task.wait(1)
            targetTime = getNextTargetTime()
        end
        
        task.wait(0.1)
    end
end

-- 添加鼠标悬停提示
local tooltip = Instance.new("TextLabel")
tooltip.Name = "Tooltip"
tooltip.Parent = mainGui
tooltip.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
tooltip.BackgroundTransparency = 0.3
tooltip.BorderSizePixel = 0
tooltip.Position = UDim2.new(0.98, -180, 0.01, 40)
tooltip.AnchorPoint = Vector2.new(1, 0)
tooltip.Size = UDim2.new(0, 175, 0, 30)
tooltip.Visible = false
tooltip.Font = Enum.Font.Gotham

if isAuthor then
    tooltip.Text = "👑 作者：" .. playerName .. "\n状态：至尊作者\n特权：全功能无限制\n点击查看详情"
else
    tooltip.Text = "用户: " .. playerName .. "\n状态: " .. (isVIP and "VIP用户" or "普通用户") .. "\n点击查看详情\n自动消息已启用"
end

tooltip.TextColor3 = isAuthor and Color3.fromRGB(255, 200, 200) or Color3.fromRGB(200, 200, 200)
tooltip.TextSize = 10
tooltip.TextXAlignment = Enum.TextXAlignment.Left
tooltip.TextYAlignment = Enum.TextYAlignment.Top
tooltip.TextWrapped = true

-- 鼠标悬停显示提示
container.MouseEnter:Connect(function()
    tooltip.Visible = true
end)

container.MouseLeave:Connect(function()
    tooltip.Visible = false
end)

-- 脚本启动时显示欢迎弹窗（延迟2秒）
task.wait(2)
showPopup()

-- 如果是作者，显示作者专属弹窗
if isAuthor then
    task.wait(1)
    showAuthorPopup()
end

-- 启动动画和时间更新
task.spawn(vipPulseAnimation)
task.spawn(updateTime)
task.spawn(updateRainbowColors)  -- 启动彩虹颜色更新

-- 显示当前用户状态
print("[VIP系统] 当前用户:", playerName)
print("[VIP系统] 用户身份:", isAuthor and "👑 脚本作者" or (isVIP and "VIP用户" or "普通用户"))
print("[聊天系统] 自动消息: 已启用")

if isAuthor then
    print("[作者系统] 👑 作者特权已激活！")
    print("[作者系统] 欢迎使用您自己创造的迪脚本！")
elseif isVIP then
    print("[聊天系统] VIP专属消息: 尊敬的VIP，欢迎使用迪脚本！")
else
    print("[聊天系统] 普通用户消息: 欢迎使用迪脚本！")
end

print("[作者系统] 脚本作者: " .. AUTHOR_USERNAME)
print("[VIP系统] 功能说明:")
print("  • 点击时间显示区域: 查看VIP状态弹窗")
print("  • 点击👥按钮: 显示/隐藏对局玩家检测列表")
print("  • 作者检测: 实时监控作者是否加入服务器")
print("  • 自动消息: 游戏启动后显示确认弹窗")
print("  • 作者特权: 👑 红色至尊标识 + 专属弹窗")
print("  • 彩虹效果: 时间和倒计时显示彩虹变色")
