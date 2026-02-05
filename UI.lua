-- 等待游戏加载
repeat task.wait() until game:IsLoaded()

-- UI库定义
local library = {}
local ToggleUI = false
library.currentTab = nil
library.flags = {}

local services = setmetatable({}, {
    __index = function(t, k)
        return game.GetService(game, k)
    end
})

local mouse = services.Players.LocalPlayer:GetMouse()

-- Tween动画函数
function Tween(obj, t, data)
    services.TweenService:Create(obj, TweenInfo.new(t[1], Enum.EasingStyle[t[2]], Enum.EasingDirection[t[3]]), data):Play()
    return true
end

-- 水波纹效果
function Ripple(obj)
    spawn(function()
        if obj.ClipsDescendants ~= true then
            obj.ClipsDescendants = true
        end
        local Ripple = Instance.new("ImageLabel")
        Ripple.Name = "Ripple"
        Ripple.Parent = obj
        Ripple.BackgroundColor3 = Color3.fromRGB(139, 0, 255)
        Ripple.BackgroundTransparency = 1.000
        Ripple.ZIndex = 8
        Ripple.Image = "rbxassetid://17894875649"
        Ripple.ImageTransparency = 0.800
        Ripple.ScaleType = Enum.ScaleType.Fit
        Ripple.ImageColor3 = Color3.fromRGB(139, 0, 255)
        Ripple.Position = UDim2.new((mouse.X - Ripple.AbsolutePosition.X) / obj.AbsoluteSize.X, 0, (mouse.Y - Ripple.AbsolutePosition.Y) / obj.AbsoluteSize.Y, 0)
        Tween(Ripple, {.3, 'Linear', 'InOut'}, {Position = UDim2.new(-5.5, 0, -5.5, 0), Size = UDim2.new(12, 0, 12, 0)})
        wait(0.15)
        Tween(Ripple, {.3, 'Linear', 'InOut'}, {ImageTransparency = 1})
        wait(.3)
        Ripple:Destroy()
    end)
end

local toggled = false

-- 切换标签页
local switchingTabs = false
function switchTab(new)
    if switchingTabs then return end
    local old = library.currentTab
    if old == nil then
        new[2].Visible = true
        library.currentTab = new
        services.TweenService:Create(new[1], TweenInfo.new(0.1), {ImageTransparency = 0}):Play()
        services.TweenService:Create(new[1].TabText, TweenInfo.new(0.1), {TextTransparency = 0}):Play()
        return
    end
    if old[1] == new[1] then return end
    switchingTabs = true
    library.currentTab = new
    
    services.TweenService:Create(old[1], TweenInfo.new(0.1), {ImageTransparency = 0.2}):Play()
    services.TweenService:Create(new[1], TweenInfo.new(0.1), {ImageTransparency = 0}):Play()
    services.TweenService:Create(old[1].TabText, TweenInfo.new(0.1), {TextTransparency = 0.2}):Play()
    services.TweenService:Create(new[1].TabText, TweenInfo.new(0.1), {TextTransparency = 0}):Play()
    
    old[2].Visible = false
    new[2].Visible = true
    task.wait(0.1)
    switchingTabs = false
end

-- 拖动功能
function drag(frame, hold)
    if not hold then
        hold = frame
    end
    local dragging
    local dragInput
    local dragStart
    local startPos
    
    local function update(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
    hold.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    services.UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

-- 创建UI库
function library.new(library, name, theme)
    for _, v in next, services.CoreGui:GetChildren() do
        if v.Name == "frosty" then
            v:Destroy()
        end
    end
    
    -- 颜色设置
    local ALTransparency = 0.6
    local ALcolor = Color3.fromRGB(0, 255, 127)
    local MainColor = Color3.fromRGB(25, 25, 25)
    local Background = Color3.fromRGB(25, 25, 25)
    local zyColor = Color3.fromRGB(25, 25, 25)
    local beijingColor = Color3.fromRGB(25, 25, 25)
    
    -- 创建主界面元素
    local dogent = Instance.new("ScreenGui")
    local Main = Instance.new("Frame")
    local TabMain = Instance.new("Frame")
    local MainC = Instance.new("UICorner")
    local SB = Instance.new("Frame")
    local SBC = Instance.new("UICorner")
    local Side = Instance.new("Frame")
    local SideG = Instance.new("UIGradient")
    local TabBtns = Instance.new("ScrollingFrame")
    local TabBtnsL = Instance.new("UIListLayout")
    local ScriptTitle = Instance.new("TextLabel")
    local SBG = Instance.new("UIGradient")
    local Open = Instance.new("ImageButton")
    local UIG = Instance.new("UIGradient")
    local DropShadowHolder = Instance.new("Frame")
    local DropShadow = Instance.new("ImageLabel")
    local UICornerMain = Instance.new("UICorner")
    local UIGradient = Instance.new("UIGradient")
    local UIGradientTitle = Instance.new("UIGradient")
    local Frame = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local UICorner_2 = Instance.new("UICorner")
    
    -- 保护GUI
    if syn and syn.protect_gui then
        syn.protect_gui(dogent)
    end
    
    dogent.Name = "frosty"
    dogent.Parent = services.CoreGui
    
    -- 销毁UI函数
    function UiDestroy()
        dogent:Destroy()
    end
    
    -- 创建彩虹渐变
    local function createRainbowGradient(parent)
        local gradient = Instance.new("UIGradient")
        gradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
            ColorSequenceKeypoint.new(0.10, Color3.fromRGB(255, 127, 0)),
            ColorSequenceKeypoint.new(0.20, Color3.fromRGB(255, 255, 0)),
            ColorSequenceKeypoint.new(0.30, Color3.fromRGB(0, 255, 0)),
            ColorSequenceKeypoint.new(0.40, Color3.fromRGB(0, 255, 255)),
            ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 0, 255)),
            ColorSequenceKeypoint.new(0.60, Color3.fromRGB(139, 0, 255)),
            ColorSequenceKeypoint.new(0.70, Color3.fromRGB(255, 0, 0)),
            ColorSequenceKeypoint.new(0.80, Color3.fromRGB(255, 127, 0)),
            ColorSequenceKeypoint.new(0.90, Color3.fromRGB(255, 255, 0)),
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 255, 0))
        }
        gradient.Parent = parent
        return gradient
    end
    
    -- 设置主窗口
    Main.Name = "Main"
    Main.Parent = dogent
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.BackgroundColor3 = Background
    Main.BorderColor3 = MainColor
    Main.Position = UDim2.new(0.5, 0, 0.5, 0)
    Main.Size = UDim2.new(0, 600, 0, 400)
    Main.ZIndex = 1
    Main.Active = true
    Main.Draggable = true
    Main.Transparency = 0.95
    
    -- 彩虹边框效果
    local borderFrame = Instance.new("Frame")
    borderFrame.Name = "RainbowBorder"
    borderFrame.Parent = Main
    borderFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    borderFrame.BorderSizePixel = 0
    borderFrame.Position = UDim2.new(-0.005, 0, -0.005, 0)
    borderFrame.Size = UDim2.new(1.01, 0, 1.01, 0)
    borderFrame.ZIndex = 0
    
    local borderCorner = Instance.new("UICorner")
    borderCorner.CornerRadius = UDim.new(0, 8)
    borderCorner.Parent = borderFrame
    
    local borderGradient = createRainbowGradient(borderFrame)
    borderGradient.Rotation = 0
    
    -- 添加旋转动画
    local tweenInfo = TweenInfo.new(10, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1)
    local tween = services.TweenService:Create(borderGradient, tweenInfo, {Rotation = 360})
    tween:Play()
    
    -- 主窗口圆角
    UICornerMain.Parent = Main
    UICornerMain.CornerRadius = UDim.new(0, 6)
    
    -- 启用Ctrl键隐藏/显示UI
    services.UserInputService.InputEnded:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.LeftControl then
            Main.Visible = not Main.Visible
        end
    end)
    
    drag(Main)
    
    -- 标题栏
    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Parent = Main
    titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    titleBar.BackgroundTransparency = 0.3
    titleBar.Size = UDim2.new(1, 0, 0, 30)
    
    local titleText = Instance.new("TextLabel")
    titleText.Name = "TitleText"
    titleText.Parent = titleBar
    titleText.BackgroundTransparency = 1
    titleText.Position = UDim2.new(0.02, 0, 0, 0)
    titleText.Size = UDim2.new(0.5, 0, 1, 0)
    titleText.Font = Enum.Font.GothamBold
    titleText.Text = "孙坤脚本"
    titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleText.TextSize = 16
    titleText.TextXAlignment = Enum.TextXAlignment.Left
    
    -- 标题彩虹渐变
    local titleGradient = createRainbowGradient(titleText)
    
    -- 控制按钮
    local buttonContainer = Instance.new("Frame")
    buttonContainer.Name = "ButtonContainer"
    buttonContainer.Parent = titleBar
    buttonContainer.BackgroundTransparency = 1
    buttonContainer.Position = UDim2.new(0.8, 0, 0, 0)
    buttonContainer.Size = UDim2.new(0.2, 0, 1, 0)
    
    local minimizeBtn = Instance.new("TextButton")
    minimizeBtn.Name = "MinimizeBtn"
    minimizeBtn.Parent = buttonContainer
    minimizeBtn.BackgroundTransparency = 1
    minimizeBtn.Size = UDim2.new(0.33, 0, 1, 0)
    minimizeBtn.Font = Enum.Font.GothamBold
    minimizeBtn.Text = "-"
    minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    minimizeBtn.TextSize = 20
    
    local expandBtn = Instance.new("TextButton")
    expandBtn.Name = "ExpandBtn"
    expandBtn.Parent = buttonContainer
    expandBtn.BackgroundTransparency = 1
    expandBtn.Position = UDim2.new(0.33, 0, 0, 0)
    expandBtn.Size = UDim2.new(0.33, 0, 1, 0)
    expandBtn.Font = Enum.Font.GothamBold
    expandBtn.Text = "□"
    expandBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    expandBtn.TextSize = 16
    
    local closeBtn = Instance.new("TextButton")
    closeBtn.Name = "CloseBtn"
    closeBtn.Parent = buttonContainer
    closeBtn.BackgroundTransparency = 1
    closeBtn.Position = UDim2.new(0.66, 0, 0, 0)
    closeBtn.Size = UDim2.new(0.33, 0, 1, 0)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
    closeBtn.TextSize = 16
    
    -- 侧边栏
    Side.Name = "Side"
    Side.Parent = Main
    Side.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Side.BackgroundTransparency = 0.3
    Side.Position = UDim2.new(0, 0, 0, 30)
    Side.Size = UDim2.new(0, 150, 0, 370)
    
    -- 标签页按钮容器
    TabBtns.Name = "TabBtns"
    TabBtns.Parent = Side
    TabBtns.Active = true
    TabBtns.BackgroundTransparency = 1
    TabBtns.Size = UDim2.new(1, 0, 1, 0)
    TabBtns.CanvasSize = UDim2.new(0, 0, 1, 0)
    TabBtns.ScrollBarThickness = 3
    
    TabBtnsL.Name = "TabBtnsL"
    TabBtnsL.Parent = TabBtns
    TabBtnsL.SortOrder = Enum.SortOrder.LayoutOrder
    TabBtnsL.Padding = UDim.new(0, 5)
    
    -- 内容区域
    TabMain.Name = "TabMain"
    TabMain.Parent = Main
    TabMain.BackgroundTransparency = 1
    TabMain.Position = UDim2.new(0, 150, 0, 30)
    TabMain.Size = UDim2.new(0, 450, 0, 370)
    
    -- 创建外部控制按钮
    local externalBtnFrame = Instance.new("Frame")
    externalBtnFrame.Name = "ExternalBtn"
    externalBtnFrame.Parent = dogent
    externalBtnFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    externalBtnFrame.BackgroundTransparency = 0.85
    externalBtnFrame.Position = UDim2.new(0, 20, 0.5, -50)
    externalBtnFrame.Size = UDim2.new(0, 120, 0, 40)
    externalBtnFrame.Active = true
    externalBtnFrame.Draggable = true
    
    local externalCorner = Instance.new("UICorner")
    externalCorner.CornerRadius = UDim.new(0, 10)
    externalCorner.Parent = externalBtnFrame
    
    -- 外部按钮彩虹边框
    local externalBorder = Instance.new("Frame")
    externalBorder.Name = "ExternalBorder"
    externalBorder.Parent = externalBtnFrame
    externalBorder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    externalBorder.BorderSizePixel = 0
    externalBorder.Position = UDim2.new(-0.01, 0, -0.01, 0)
    externalBorder.Size = UDim2.new(1.02, 0, 1.02, 0)
    externalBorder.ZIndex = -1
    
    local externalBorderCorner = Instance.new("UICorner")
    externalBorderCorner.CornerRadius = UDim.new(0, 10)
    externalBorderCorner.Parent = externalBorder
    
    local externalGradient = createRainbowGradient(externalBorder)
    externalGradient.Rotation = 0
    
    local externalTween = services.TweenService:Create(externalGradient, tweenInfo, {Rotation = 360})
    externalTween:Play()
    
    local externalText = Instance.new("TextLabel")
    externalText.Name = "ExternalText"
    externalText.Parent = externalBtnFrame
    externalText.BackgroundTransparency = 1
    externalText.Size = UDim2.new(1, 0, 1, 0)
    externalText.Font = Enum.Font.GothamBold
    externalText.Text = "孙坤脚本"
    externalText.TextColor3 = Color3.fromRGB(255, 255, 255)
    externalText.TextSize = 14
    
    -- 外部按钮功能
    drag(externalBtnFrame)
    
    externalBtnFrame.MouseButton1Click:Connect(function()
        Main.Visible = not Main.Visible
        if Main.Visible then
            externalText.Text = "隐藏UI"
        else
            externalText.Text = "显示UI"
        end
    end)
    
    -- 控制按钮功能
    minimizeBtn.MouseButton1Click:Connect(function()
        if toggled then
            Tween(Main, {0.3, 'Sine', 'InOut'}, {Size = UDim2.new(0, 600, 0, 400)})
            expandBtn.Text = "□"
        else
            Tween(Main, {0.3, 'Sine', 'InOut'}, {Size = UDim2.new(0, 600, 0, 50)})
            expandBtn.Text = "+"
        end
        toggled = not toggled
    end)
    
    expandBtn.MouseButton1Click:Connect(function()
        if expandBtn.Text == "□" then
            Tween(Main, {0.3, 'Sine', 'InOut'}, {Size = UDim2.new(0, 800, 0, 500)})
            expandBtn.Text = "□"
        else
            Tween(Main, {0.3, 'Sine', 'InOut'}, {Size = UDim2.new(0, 600, 0, 400)})
            expandBtn.Text = "□"
        end
    end)
    
    closeBtn.MouseButton1Click:Connect(function()
        dogent:Destroy()
    end)
    
    -- 通知系统
    local notificationContainer = Instance.new("Frame")
    notificationContainer.Name = "NotificationContainer"
    notificationContainer.Parent = dogent
    notificationContainer.BackgroundTransparency = 1
    notificationContainer.Position = UDim2.new(1, -320, 1, -300)
    notificationContainer.Size = UDim2.new(0, 300, 0, 400)
    notificationContainer.ZIndex = 100
    
    local notifications = {}
    
    function library.Notify(title, text, duration)
        duration = duration or 5
        
        local notification = Instance.new("Frame")
        notification.Name = "Notification"
        notification.Parent = notificationContainer
        notification.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        notification.BackgroundTransparency = 0.2
        notification.Size = UDim2.new(1, -10, 0, 80)
        notification.Position = UDim2.new(0, 5, 0, (#notifications * 85) + 5)
        
        local notifCorner = Instance.new("UICorner")
        notifCorner.CornerRadius = UDim.new(0, 8)
        notifCorner.Parent = notification
        
        local rainbowBorder = Instance.new("Frame")
        rainbowBorder.Name = "RainbowBorder"
        rainbowBorder.Parent = notification
        rainbowBorder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        rainbowBorder.BorderSizePixel = 0
        rainbowBorder.Position = UDim2.new(-0.005, 0, -0.005, 0)
        rainbowBorder.Size = UDim2.new(1.01, 0, 1.01, 0)
        rainbowBorder.ZIndex = -1
        
        local borderCorner = Instance.new("UICorner")
        borderCorner.CornerRadius = UDim.new(0, 8)
        borderCorner.Parent = rainbowBorder
        
        local borderGradient = createRainbowGradient(rainbowBorder)
        borderGradient.Rotation = 0
        
        local gradientTween = services.TweenService:Create(borderGradient, tweenInfo, {Rotation = 360})
        gradientTween:Play()
        
        local closeBtn = Instance.new("TextButton")
        closeBtn.Name = "CloseBtn"
        closeBtn.Parent = notification
        closeBtn.BackgroundTransparency = 1
        closeBtn.Position = UDim2.new(0.85, 0, 0.1, 0)
        closeBtn.Size = UDim2.new(0, 20, 0, 20)
        closeBtn.Font = Enum.Font.GothamBold
        closeBtn.Text = "X"
        closeBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
        closeBtn.TextSize = 14
        
        local titleLabel = Instance.new("TextLabel")
        titleLabel.Name = "Title"
        titleLabel.Parent = notification
        titleLabel.BackgroundTransparency = 1
        titleLabel.Position = UDim2.new(0.05, 0, 0.1, 0)
        titleLabel.Size = UDim2.new(0.75, 0, 0, 20)
        titleLabel.Font = Enum.Font.GothamBold
        titleLabel.Text = title
        titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        titleLabel.TextSize = 14
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        
        local textLabel = Instance.new("TextLabel")
        textLabel.Name = "Text"
        textLabel.Parent = notification
        textLabel.BackgroundTransparency = 1
        textLabel.Position = UDim2.new(0.05, 0, 0.4, 0)
        textLabel.Size = UDim2.new(0.9, 0, 0, 40)
        textLabel.Font = Enum.Font.Gotham
        textLabel.Text = text
        textLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        textLabel.TextSize = 12
        textLabel.TextXAlignment = Enum.TextXAlignment.Left
        textLabel.TextYAlignment = Enum.TextYAlignment.Top
        textLabel.TextWrapped = true
        
        local progressBar = Instance.new("Frame")
        progressBar.Name = "ProgressBar"
        progressBar.Parent = notification
        progressBar.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        progressBar.BorderSizePixel = 0
        progressBar.Position = UDim2.new(0.05, 0, 0.85, 0)
        progressBar.Size = UDim2.new(0.9, 0, 0, 4)
        
        local progressFill = Instance.new("Frame")
        progressFill.Name = "ProgressFill"
        progressFill.Parent = progressBar
        progressFill.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        progressFill.BorderSizePixel = 0
        progressFill.Size = UDim2.new(1, 0, 1, 0)
        
        local progressCorner = Instance.new("UICorner")
        progressCorner.CornerRadius = UDim.new(0, 2)
        progressCorner.Parent = progressBar
        
        table.insert(notifications, notification)
        
        closeBtn.MouseButton1Click:Connect(function()
            Tween(notification, {0.3, 'Linear', 'InOut'}, {Size = UDim2.new(0, 0, 0, 80)})
            wait(0.3)
            notification:Destroy()
            for i, notif in ipairs(notifications) do
                if notif == notification then
                    table.remove(notifications, i)
                    break
                end
            end
            reorganizeNotifications()
        end)
        
        spawn(function()
            local startTime = tick()
            while tick() - startTime < duration do
                local elapsed = tick() - startTime
                local progress = 1 - (elapsed / duration)
                progressFill.Size = UDim2.new(progress, 0, 1, 0)
                wait(0.1)
            end
            Tween(notification, {0.3, 'Linear', 'InOut'}, {Size = UDim2.new(0, 0, 0, 80)})
            wait(0.3)
            notification:Destroy()
            for i, notif in ipairs(notifications) do
                if notif == notification then
                    table.remove(notifications, i)
                    break
                end
            end
            reorganizeNotifications()
        end)
        
        function reorganizeNotifications()
            for i, notif in ipairs(notifications) do
                Tween(notif, {0.3, 'Linear', 'InOut'}, {Position = UDim2.new(0, 5, 0, ((i-1) * 85) + 5)})
            end
        end
    end
    
    -- 窗口对象
    local window = {}
    
    -- 创建标签页
    function window.Tab(window, name, icon)
        local Tab = Instance.new("ScrollingFrame")
        local TabBtn = Instance.new("TextButton")
        local TabText = Instance.new("TextLabel")
        
        Tab.Name = "Tab"
        Tab.Parent = TabMain
        Tab.Active = true
        Tab.BackgroundTransparency = 1
        Tab.Size = UDim2.new(1, 0, 1, 0)
        Tab.ScrollBarThickness = 5
        Tab.Visible = false
        
        TabBtn.Name = "TabBtn"
        TabBtn.Parent = TabBtns
        TabBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        TabBtn.BackgroundTransparency = 0.5
        TabBtn.Size = UDim2.new(1, -10, 0, 40)
        TabBtn.AutoButtonColor = false
        TabBtn.Font = Enum.Font.Gotham
        TabBtn.Text = ""
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 6)
        btnCorner.Parent = TabBtn
        
        TabText.Name = "TabText"
        TabText.Parent = TabBtn
        TabText.BackgroundTransparency = 1
        TabText.Size = UDim2.new(1, 0, 1, 0)
        TabText.Font = Enum.Font.GothamBold
        TabText.Text = name
        TabText.TextColor3 = Color3.fromRGB(200, 200, 200)
        TabText.TextSize = 14
        
        TabBtn.MouseButton1Click:Connect(function()
            Ripple(TabBtn)
            switchTab({TabBtn, Tab})
        end)
        
        if library.currentTab == nil then
            switchTab({TabBtn, Tab})
        end
        
        local TabL = Instance.new("UIListLayout")
        TabL.Name = "TabL"
        TabL.Parent = Tab
        TabL.SortOrder = Enum.SortOrder.LayoutOrder
        TabL.Padding = UDim.new(0, 10)
        
        local TabPadding = Instance.new("UIPadding")
        TabPadding.Parent = Tab
        TabPadding.PaddingLeft = UDim.new(0, 10)
        TabPadding.PaddingTop = UDim.new(0, 10)
        TabPadding.PaddingRight = UDim.new(0, 10)
        
        TabL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            Tab.CanvasSize = UDim2.new(0, 0, 0, TabL.AbsoluteContentSize.Y + 20)
        end)
        
        local tab = {}
        
        -- 创建分区
        function tab.section(tab, name, isOpen)
            local Section = Instance.new("Frame")
            local SectionCorner = Instance.new("UICorner")
            local SectionTitle = Instance.new("TextLabel")
            local SectionToggle = Instance.new("TextButton")
            local SectionContent = Instance.new("Frame")
            local SectionList = Instance.new("UIListLayout")
            
            Section.Name = "Section"
            Section.Parent = Tab
            Section.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            Section.BackgroundTransparency = 0.7
            Section.Size = UDim2.new(1, -20, 0, 40)
            
            SectionCorner.CornerRadius = UDim.new(0, 8)
            SectionCorner.Parent = Section
            
            SectionTitle.Name = "SectionTitle"
            SectionTitle.Parent = Section
            SectionTitle.BackgroundTransparency = 1
            SectionTitle.Position = UDim2.new(0.05, 0, 0, 0)
            SectionTitle.Size = UDim2.new(0.8, 0, 1, 0)
            SectionTitle.Font = Enum.Font.GothamBold
            SectionTitle.Text = name
            SectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            SectionTitle.TextSize = 14
            SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            SectionToggle.Name = "SectionToggle"
            SectionToggle.Parent = Section
            SectionToggle.BackgroundTransparency = 1
            SectionToggle.Position = UDim2.new(0.9, 0, 0, 0)
            SectionToggle.Size = UDim2.new(0.1, 0, 1, 0)
            SectionToggle.Font = Enum.Font.GothamBold
            SectionToggle.Text = isOpen and "-" : "+"
            SectionToggle.TextColor3 = Color3.fromRGB(200, 200, 200)
            SectionToggle.TextSize = 18
            
            SectionContent.Name = "SectionContent"
            SectionContent.Parent = Section
            SectionContent.BackgroundTransparency = 1
            SectionContent.Position = UDim2.new(0, 0, 1, 0)
            SectionContent.Size = UDim2.new(1, 0, 0, 0)
            SectionContent.ClipsDescendants = true
            
            SectionList.Name = "SectionList"
            SectionList.Parent = SectionContent
            SectionList.SortOrder = Enum.SortOrder.LayoutOrder
            SectionList.Padding = UDim.new(0, 5)
            
            local open = isOpen or false
            
            if open then
                SectionToggle.Text = "-"
                Section.Size = UDim2.new(1, -20, 0, 40)
            end
            
            SectionToggle.MouseButton1Click:Connect(function()
                open = not open
                SectionToggle.Text = open and "-" or "+"
                
                if open then
                    local contentHeight = 0
                    for _, child in ipairs(SectionContent:GetChildren()) do
                        if child:IsA("Frame") and child.Name ~= "SectionList" then
                            contentHeight = contentHeight + child.Size.Y.Offset + 5
                        end
                    end
                    Tween(Section, {0.3, 'Linear', 'InOut'}, {Size = UDim2.new(1, -20, 0, 40 + contentHeight)})
                    Tween(SectionContent, {0.3, 'Linear', 'InOut'}, {Size = UDim2.new(1, 0, 0, contentHeight)})
                else
                    Tween(Section, {0.3, 'Linear', 'InOut'}, {Size = UDim2.new(1, -20, 0, 40)})
                    Tween(SectionContent, {0.3, 'Linear', 'InOut'}, {Size = UDim2.new(1, 0, 0, 0)})
                end
            end)
            
            local section = {}
            
            -- 信息标签
            function section.Label(text)
                local LabelFrame = Instance.new("Frame")
                local LabelText = Instance.new("TextLabel")
                local LabelCorner = Instance.new("UICorner")
                
                LabelFrame.Name = "LabelFrame"
                LabelFrame.Parent = SectionContent
                LabelFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                LabelFrame.BackgroundTransparency = 0.8
                LabelFrame.Size = UDim2.new(1, 0, 0, 30)
                
                LabelCorner.CornerRadius = UDim.new(0, 6)
                LabelCorner.Parent = LabelFrame
                
                LabelText.Name = "LabelText"
                LabelText.Parent = LabelFrame
                LabelText.BackgroundTransparency = 1
                LabelText.Size = UDim2.new(1, -10, 1, 0)
                LabelText.Position = UDim2.new(0, 5, 0, 0)
                LabelText.Font = Enum.Font.Gotham
                LabelText.Text = text
                LabelText.TextColor3 = Color3.fromRGB(200, 200, 200)
                LabelText.TextSize = 12
                LabelText.TextWrapped = true
                
                return LabelText
            end
            
            -- 按钮
            function section.Button(text, callback)
                local BtnFrame = Instance.new("Frame")
                local Btn = Instance.new("TextButton")
                local BtnCorner = Instance.new("UICorner")
                
                BtnFrame.Name = "BtnFrame"
                BtnFrame.Parent = SectionContent
                BtnFrame.BackgroundTransparency = 1
                BtnFrame.Size = UDim2.new(1, 0, 0, 35)
                
                Btn.Name = "Btn"
                Btn.Parent = BtnFrame
                Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                Btn.BackgroundTransparency = 0.7
                Btn.Size = UDim2.new(1, 0, 1, 0)
                Btn.AutoButtonColor = false
                Btn.Font = Enum.Font.GothamBold
                Btn.Text = text
                Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                Btn.TextSize = 14
                
                BtnCorner.CornerRadius = UDim.new(0, 6)
                BtnCorner.Parent = Btn
                
                Btn.MouseButton1Click:Connect(function()
                    Ripple(Btn)
                    if callback then
                        callback()
                    end
                end)
            end
            
            -- 开关
            function section.Toggle(text, flag, default, callback)
                local ToggleFrame = Instance.new("Frame")
                local ToggleBtn = Instance.new("TextButton")
                local ToggleCorner = Instance.new("UICorner")
                local ToggleText = Instance.new("TextLabel")
                local ToggleSwitch = Instance.new("Frame")
                local ToggleSwitchCorner = Instance.new("UICorner")
                local ToggleKnob = Instance.new("Frame")
                local ToggleKnobCorner = Instance.new("UICorner")
                
                ToggleFrame.Name = "ToggleFrame"
                ToggleFrame.Parent = SectionContent
                ToggleFrame.BackgroundTransparency = 1
                ToggleFrame.Size = UDim2.new(1, 0, 0, 35)
                
                ToggleBtn.Name = "ToggleBtn"
                ToggleBtn.Parent = ToggleFrame
                ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                ToggleBtn.BackgroundTransparency = 0.7
                ToggleBtn.Size = UDim2.new(1, 0, 1, 0)
                ToggleBtn.AutoButtonColor = false
                ToggleBtn.Text = ""
                
                ToggleCorner.CornerRadius = UDim.new(0, 6)
                ToggleCorner.Parent = ToggleBtn
                
                ToggleText.Name = "ToggleText"
                ToggleText.Parent = ToggleBtn
                ToggleText.BackgroundTransparency = 1
                ToggleText.Position = UDim2.new(0.05, 0, 0, 0)
                ToggleText.Size = UDim2.new(0.7, 0, 1, 0)
                ToggleText.Font = Enum.Font.Gotham
                ToggleText.Text = text
                ToggleText.TextColor3 = Color3.fromRGB(255, 255, 255)
                ToggleText.TextSize = 14
                ToggleText.TextXAlignment = Enum.TextXAlignment.Left
                
                ToggleSwitch.Name = "ToggleSwitch"
                ToggleSwitch.Parent = ToggleBtn
                ToggleSwitch.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
                ToggleSwitch.Position = UDim2.new(0.85, 0, 0.2, 0)
                ToggleSwitch.Size = UDim2.new(0, 40, 0, 20)
                
                ToggleSwitchCorner.CornerRadius = UDim.new(0, 10)
                ToggleSwitchCorner.Parent = ToggleSwitch
                
                ToggleKnob.Name = "ToggleKnob"
                ToggleKnob.Parent = ToggleSwitch
                ToggleKnob.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
                ToggleKnob.Position = UDim2.new(0, 2, 0, 2)
                ToggleKnob.Size = UDim2.new(0, 16, 0, 16)
                
                ToggleKnobCorner.CornerRadius = UDim.new(0, 8)
                ToggleKnobCorner.Parent = ToggleKnob
                
                local state = default or false
                library.flags[flag] = state
                
                if state then
                    ToggleKnob.Position = UDim2.new(1, -18, 0, 2)
                    ToggleSwitch.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
                end
                
                ToggleBtn.MouseButton1Click:Connect(function()
                    state = not state
                    library.flags[flag] = state
                    
                    if state then
                        Tween(ToggleKnob, {0.2, 'Linear', 'InOut'}, {Position = UDim2.new(1, -18, 0, 2)})
                        Tween(ToggleSwitch, {0.2, 'Linear', 'InOut'}, {BackgroundColor3 = Color3.fromRGB(0, 200, 0)})
                    else
                        Tween(ToggleKnob, {0.2, 'Linear', 'InOut'}, {Position = UDim2.new(0, 2, 0, 2)})
                        Tween(ToggleSwitch, {0.2, 'Linear', 'InOut'}, {BackgroundColor3 = Color3.fromRGB(70, 70, 70)})
                    end
                    
                    if callback then
                        callback(state)
                    end
                end)
                
                local funcs = {
                    SetState = function(self, newState)
                        state = newState
                        library.flags[flag] = state
                        
                        if state then
                            ToggleKnob.Position = UDim2.new(1, -18, 0, 2)
                            ToggleSwitch.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
                        else
                            ToggleKnob.Position = UDim2.new(0, 2, 0, 2)
                            ToggleSwitch.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
                        end
                        
                        if callback then
                            callback(state)
                        end
                    end
                }
                
                return funcs
            end
            
            -- 滑动条
            function section.Slider(text, flag, min, max, default, callback)
                local SliderFrame = Instance.new("Frame")
                local SliderBtn = Instance.new("TextButton")
                local SliderCorner = Instance.new("UICorner")
                local SliderText = Instance.new("TextLabel")
                local SliderValue = Instance.new("TextLabel")
                local SliderBar = Instance.new("Frame")
                local SliderBarCorner = Instance.new("UICorner")
                local SliderFill = Instance.new("Frame")
                local SliderFillCorner = Instance.new("UICorner")
                local SliderKnob = Instance.new("Frame")
                local SliderKnobCorner = Instance.new("UICorner")
                
                SliderFrame.Name = "SliderFrame"
                SliderFrame.Parent = SectionContent
                SliderFrame.BackgroundTransparency = 1
                SliderFrame.Size = UDim2.new(1, 0, 0, 50)
                
                SliderBtn.Name = "SliderBtn"
                SliderBtn.Parent = SliderFrame
                SliderBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                SliderBtn.BackgroundTransparency = 0.7
                SliderBtn.Size = UDim2.new(1, 0, 1, 0)
                SliderBtn.AutoButtonColor = false
                SliderBtn.Text = ""
                
                SliderCorner.CornerRadius = UDim.new(0, 6)
                SliderCorner.Parent = SliderBtn
                
                SliderText.Name = "SliderText"
                SliderText.Parent = SliderBtn
                SliderText.BackgroundTransparency = 1
                SliderText.Position = UDim2.new(0.05, 0, 0.1, 0)
                SliderText.Size = UDim2.new(0.7, 0, 0.3, 0)
                SliderText.Font = Enum.Font.Gotham
                SliderText.Text = text
                SliderText.TextColor3 = Color3.fromRGB(255, 255, 255)
                SliderText.TextSize = 14
                SliderText.TextXAlignment = Enum.TextXAlignment.Left
                
                SliderValue.Name = "SliderValue"
                SliderValue.Parent = SliderBtn
                SliderValue.BackgroundTransparency = 1
                SliderValue.Position = UDim2.new(0.8, 0, 0.1, 0)
                SliderValue.Size = UDim2.new(0.15, 0, 0.3, 0)
                SliderValue.Font = Enum.Font.Gotham
                SliderValue.Text = tostring(default)
                SliderValue.TextColor3 = Color3.fromRGB(200, 200, 200)
                SliderValue.TextSize = 14
                
                SliderBar.Name = "SliderBar"
                SliderBar.Parent = SliderBtn
                SliderBar.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
                SliderBar.Position = UDim2.new(0.05, 0, 0.6, 0)
                SliderBar.Size = UDim2.new(0.9, 0, 0, 8)
                
                SliderBarCorner.CornerRadius = UDim.new(0, 4)
                SliderBarCorner.Parent = SliderBar
                
                SliderFill.Name = "SliderFill"
                SliderFill.Parent = SliderBar
                SliderFill.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
                SliderFill.Size = UDim2.new(0.5, 0, 1, 0)
                
                SliderFillCorner.CornerRadius = UDim.new(0, 4)
                SliderFillCorner.Parent = SliderFill
                
                SliderKnob.Name = "SliderKnob"
                SliderKnob.Parent = SliderBar
                SliderKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SliderKnob.Position = UDim2.new(0.5, -8, 0, -4)
                SliderKnob.Size = UDim2.new(0, 16, 0, 16)
                
                SliderKnobCorner.CornerRadius = UDim.new(0, 8)
                SliderKnobCorner.Parent = SliderKnob
                
                local value = default or min
                library.flags[flag] = value
                
                local percent = (value - min) / (max - min)
                SliderFill.Size = UDim2.new(percent, 0, 1, 0)
                SliderKnob.Position = UDim2.new(percent, -8, 0, -4)
                
                local dragging = false
                
                local function updateValue(mouseX)
                    local absolutePos = SliderBar.AbsolutePosition.X
                    local absoluteSize = SliderBar.AbsoluteSize.X
                    local relative = math.clamp((mouseX - absolutePos) / absoluteSize, 0, 1)
                    
                    value = math.floor(min + (max - min) * relative)
                    percent = (value - min) / (max - min)
                    
                    SliderValue.Text = tostring(value)
                    SliderFill.Size = UDim2.new(percent, 0, 1, 0)
                    SliderKnob.Position = UDim2.new(percent, -8, 0, -4)
                    
                    library.flags[flag] = value
                    
                    if callback then
                        callback(value)
                    end
                end
                
                SliderKnob.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                    end
                end)
                
                SliderBar.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                        updateValue(input.Position.X)
                    end
                end)
                
                services.UserInputService.InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        updateValue(input.Position.X)
                    end
                end)
                
                services.UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end)
                
                local funcs = {
                    SetValue = function(self, newValue)
                        value = math.clamp(newValue, min, max)
                        percent = (value - min) / (max - min)
                        
                        SliderValue.Text = tostring(value)
                        SliderFill.Size = UDim2.new(percent, 0, 1, 0)
                        SliderKnob.Position = UDim2.new(percent, -8, 0, -4)
                        
                        library.flags[flag] = value
                        
                        if callback then
                            callback(value)
                        end
                    end
                }
                
                return funcs
            end
            
            -- 下拉框
            function section.Dropdown(text, flag, options, default, callback)
                local DropdownFrame = Instance.new("Frame")
                local DropdownBtn = Instance.new("TextButton")
                local DropdownCorner = Instance.new("UICorner")
                local DropdownText = Instance.new("TextLabel")
                local DropdownArrow = Instance.new("TextLabel")
                local DropdownList = Instance.new("ScrollingFrame")
                local DropdownListLayout = Instance.new("UIListLayout")
                
                DropdownFrame.Name = "DropdownFrame"
                DropdownFrame.Parent = SectionContent
                DropdownFrame.BackgroundTransparency = 1
                DropdownFrame.Size = UDim2.new(1, 0, 0, 35)
                
                DropdownBtn.Name = "DropdownBtn"
                DropdownBtn.Parent = DropdownFrame
                DropdownBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                DropdownBtn.BackgroundTransparency = 0.7
                DropdownBtn.Size = UDim2.new(1, 0, 1, 0)
                DropdownBtn.AutoButtonColor = false
                DropdownBtn.Text = ""
                
                DropdownCorner.CornerRadius = UDim.new(0, 6)
                DropdownCorner.Parent = DropdownBtn
                
                DropdownText.Name = "DropdownText"
                DropdownText.Parent = DropdownBtn
                DropdownText.BackgroundTransparency = 1
                DropdownText.Position = UDim2.new(0.05, 0, 0, 0)
                DropdownText.Size = UDim2.new(0.8, 0, 1, 0)
                DropdownText.Font = Enum.Font.Gotham
                DropdownText.Text = text
                DropdownText.TextColor3 = Color3.fromRGB(255, 255, 255)
                DropdownText.TextSize = 14
                DropdownText.TextXAlignment = Enum.TextXAlignment.Left
                
                DropdownArrow.Name = "DropdownArrow"
                DropdownArrow.Parent = DropdownBtn
                DropdownArrow.BackgroundTransparency = 1
                DropdownArrow.Position = UDim2.new(0.9, 0, 0, 0)
                DropdownArrow.Size = UDim2.new(0.1, 0, 1, 0)
                DropdownArrow.Font = Enum.Font.GothamBold
                DropdownArrow.Text = "▼"
                DropdownArrow.TextColor3 = Color3.fromRGB(200, 200, 200)
                DropdownArrow.TextSize = 14
                
                DropdownList.Name = "DropdownList"
                DropdownList.Parent = DropdownFrame
                DropdownList.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                DropdownList.BackgroundTransparency = 0.2
                DropdownList.Position = UDim2.new(0, 0, 1, 5)
                DropdownList.Size = UDim2.new(1, 0, 0, 0)
                DropdownList.ScrollBarThickness = 3
                DropdownList.ClipsDescendants = true
                DropdownList.Visible = false
                
                DropdownListLayout.Name = "DropdownListLayout"
                DropdownListLayout.Parent = DropdownList
                DropdownListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                
                local isOpen = false
                local selected = default or options[1]
                library.flags[flag] = selected
                
                local function toggleDropdown()
                    isOpen = not isOpen
                    DropdownList.Visible = isOpen
                    DropdownArrow.Text = isOpen and "▲" or "▼"
                    
                    if isOpen then
                        local itemCount = #options
                        local maxHeight = math.min(itemCount * 30, 150)
                        DropdownList.Size = UDim2.new(1, 0, 0, maxHeight)
                        DropdownList.CanvasSize = UDim2.new(0, 0, 0, itemCount * 30)
                    else
                        DropdownList.Size = UDim2.new(1, 0, 0, 0)
                    end
                end
                
                DropdownBtn.MouseButton1Click:Connect(function()
                    toggleDropdown()
                end)
                
                local function createOption(optionText)
                    local OptionBtn = Instance.new("TextButton")
                    local OptionCorner = Instance.new("UICorner")
                    
                    OptionBtn.Name = "Option_" .. optionText
                    OptionBtn.Parent = DropdownList
                    OptionBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
                    OptionBtn.BackgroundTransparency = 0.5
                    OptionBtn.Size = UDim2.new(1, -10, 0, 25)
                    OptionBtn.Position = UDim2.new(0, 5, 0, 0)
                    OptionBtn.AutoButtonColor = false
                    OptionBtn.Font = Enum.Font.Gotham
                    OptionBtn.Text = optionText
                    OptionBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                    OptionBtn.TextSize = 12
                    
                    OptionCorner.CornerRadius = UDim.new(0, 4)
                    OptionCorner.Parent = OptionBtn
                    
                    OptionBtn.MouseButton1Click:Connect(function()
                        selected = optionText
                        library.flags[flag] = selected
                        DropdownText.Text = text .. ": " .. selected
                        toggleDropdown()
                        
                        if callback then
                            callback(selected)
                        end
                    end)
                end
                
                for _, option in ipairs(options) do
                    createOption(option)
                end
                
                DropdownText.Text = text .. ": " .. selected
                
                local funcs = {
                    SetOptions = function(self, newOptions)
                        options = newOptions
                        for _, child in ipairs(DropdownList:GetChildren()) do
                            if child:IsA("TextButton") then
                                child:Destroy()
                            end
                        end
                        for _, option in ipairs(newOptions) do
                            createOption(option)
                        end
                    end
                }
                
                return funcs
            end
            
            -- 输入框
            function section.Textbox(text, flag, placeholder, default, callback)
                local TextboxFrame = Instance.new("Frame")
                local TextboxBtn = Instance.new("TextButton")
                local TextboxCorner = Instance.new("UICorner")
                local TextboxText = Instance.new("TextLabel")
                local TextboxInput = Instance.new("TextBox")
                local TextboxInputCorner = Instance.new("UICorner")
                
                TextboxFrame.Name = "TextboxFrame"
                TextboxFrame.Parent = SectionContent
                TextboxFrame.BackgroundTransparency = 1
                TextboxFrame.Size = UDim2.new(1, 0, 0, 35)
                
                TextboxBtn.Name = "TextboxBtn"
                TextboxBtn.Parent = TextboxFrame
                TextboxBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                TextboxBtn.BackgroundTransparency = 0.7
                TextboxBtn.Size = UDim2.new(1, 0, 1, 0)
                TextboxBtn.AutoButtonColor = false
                TextboxBtn.Text = ""
                
                TextboxCorner.CornerRadius = UDim.new(0, 6)
                TextboxCorner.Parent = TextboxBtn
                
                TextboxText.Name = "TextboxText"
                TextboxText.Parent = TextboxBtn
                TextboxText.BackgroundTransparency = 1
                TextboxText.Position = UDim2.new(0.05, 0, 0, 0)
                TextboxText.Size = UDim2.new(0.4, 0, 1, 0)
                TextboxText.Font = Enum.Font.Gotham
                TextboxText.Text = text
                TextboxText.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextboxText.TextSize = 14
                TextboxText.TextXAlignment = Enum.TextXAlignment.Left
                
                TextboxInput.Name = "TextboxInput"
                TextboxInput.Parent = TextboxBtn
                TextboxInput.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                TextboxInput.Position = UDim2.new(0.5, 0, 0.2, 0)
                TextboxInput.Size = UDim2.new(0.45, 0, 0.6, 0)
                TextboxInput.Font = Enum.Font.Gotham
                TextboxInput.PlaceholderText = placeholder
                TextboxInput.Text = default or ""
                TextboxInput.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextboxInput.TextSize = 12
                TextboxInput.ClearTextOnFocus = false
                
                TextboxInputCorner.CornerRadius = UDim.new(0, 4)
                TextboxInputCorner.Parent = TextboxInput
                
                library.flags[flag] = default or ""
                
                TextboxInput.FocusLost:Connect(function()
                    local text = TextboxInput.Text
                    library.flags[flag] = text
                    
                    if callback then
                        callback(text)
                    end
                end)
                
                local funcs = {
                    SetText = function(self, newText)
                        TextboxInput.Text = newText
                        library.flags[flag] = newText
                        
                        if callback then
                            callback(newText)
                        end
                    end
                }
                
                return funcs
            end
            
            -- 关键帧绑定
            function section.Keybind(text, flag, default, callback)
                local KeybindFrame = Instance.new("Frame")
                local KeybindBtn = Instance.new("TextButton")
                local KeybindCorner = Instance.new("UICorner")
                local KeybindText = Instance.new("TextLabel")
                local KeybindValue = Instance.new("TextButton")
                local KeybindValueCorner = Instance.new("UICorner")
                
                KeybindFrame.Name = "KeybindFrame"
                KeybindFrame.Parent = SectionContent
                KeybindFrame.BackgroundTransparency = 1
                KeybindFrame.Size = UDim2.new(1, 0, 0, 35)
                
                KeybindBtn.Name = "KeybindBtn"
                KeybindBtn.Parent = KeybindFrame
                KeybindBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                KeybindBtn.BackgroundTransparency = 0.7
                KeybindBtn.Size = UDim2.new(1, 0, 1, 0)
                KeybindBtn.AutoButtonColor = false
                KeybindBtn.Text = ""
                
                KeybindCorner.CornerRadius = UDim.new(0, 6)
                KeybindCorner.Parent = KeybindBtn
                
                KeybindText.Name = "KeybindText"
                KeybindText.Parent = KeybindBtn
                KeybindText.BackgroundTransparency = 1
                KeybindText.Position = UDim2.new(0.05, 0, 0, 0)
                KeybindText.Size = UDim2.new(0.6, 0, 1, 0)
                KeybindText.Font = Enum.Font.Gotham
                KeybindText.Text = text
                KeybindText.TextColor3 = Color3.fromRGB(255, 255, 255)
                KeybindText.TextSize = 14
                KeybindText.TextXAlignment = Enum.TextXAlignment.Left
                
                KeybindValue.Name = "KeybindValue"
                KeybindValue.Parent = KeybindBtn
                KeybindValue.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                KeybindValue.Position = UDim2.new(0.7, 0, 0.2, 0)
                KeybindValue.Size = UDim2.new(0.25, 0, 0.6, 0)
                KeybindValue.AutoButtonColor = false
                KeybindValue.Font = Enum.Font.Gotham
                KeybindValue.Text = default and default.Name or "None"
                KeybindValue.TextColor3 = Color3.fromRGB(255, 255, 255)
                KeybindValue.TextSize = 12
                
                KeybindValueCorner.CornerRadius = UDim.new(0, 4)
                KeybindValueCorner.Parent = KeybindValue
                
                local key = default
                library.flags[flag] = key
                local listening = false
                
                local function updateKey(newKey)
                    key = newKey
                    KeybindValue.Text = newKey and newKey.Name or "None"
                    library.flags[flag] = key
                    listening = false
                    
                    if callback then
                        callback(key)
                    end
                end
                
                KeybindValue.MouseButton1Click:Connect(function()
                    if not listening then
                        listening = true
                        KeybindValue.Text = "..."
                        KeybindValue.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
                        
                        local connection
                        connection = services.UserInputService.InputBegan:Connect(function(input)
                            if input.UserInputType == Enum.UserInputType.Keyboard then
                                updateKey(input.KeyCode)
                                connection:Disconnect()
                                KeybindValue.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                            end
                        end)
                    end
                end)
                
                if key then
                    services.UserInputService.InputBegan:Connect(function(input, gameProcessed)
                        if not gameProcessed and input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == key then
                            if callback then
                                callback(key)
                            end
                        end
                    end)
                end
                
                local funcs = {
                    SetKey = function(self, newKey)
                        updateKey(newKey)
                    end
                }
                
                return funcs
            end
            
            return section
        end
        
        return tab
    end
    
    return window
end

-- 返回库
return library
