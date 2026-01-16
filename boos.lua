-- Revenant UI Library v2.0 - 修复版
-- 开发者客户端脚本模板

local Revenant = {}
Revenant.Version = "2.0"
Revenant.Themes = {}
Revenant.CurrentTheme = "Dark"
Revenant.Elements = {}

-- 颜色配置
Revenant.Themes.Dark = {
    Main = Color3.fromRGB(25, 25, 30),
    Secondary = Color3.fromRGB(35, 35, 45),
    Accent = Color3.fromRGB(0, 170, 255),
    Text = Color3.fromRGB(240, 240, 240),
    TextSecondary = Color3.fromRGB(180, 180, 180),
    Border = Color3.fromRGB(60, 60, 70),
    Success = Color3.fromRGB(0, 200, 100),
    Warning = Color3.fromRGB(255, 150, 0),
    Error = Color3.fromRGB(255, 50, 50)
}

Revenant.Themes.Light = {
    Main = Color3.fromRGB(245, 245, 250),
    Secondary = Color3.fromRGB(230, 230, 240),
    Accent = Color3.fromRGB(0, 120, 215),
    Text = Color3.fromRGB(30, 30, 40),
    TextSecondary = Color3.fromRGB(100, 100, 120),
    Border = Color3.fromRGB(200, 200, 210),
    Success = Color3.fromRGB(0, 180, 80),
    Warning = Color3.fromRGB(230, 130, 0),
    Error = Color3.fromRGB(220, 40, 40)
}

-- 服务
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")

-- 清理旧UI
for _,v in pairs(CoreGui:GetChildren()) do
    if v.Name == "RevenantUI" or v.Name == "RevenantNotificationHolder" or v.Name == "RevenantToggleButton" then
        v:Destroy()
    end
end

-- 雪粒子系统
local function CreateSnowEffect(parent)
    local snowContainer = Instance.new("Frame")
    snowContainer.Name = "SnowEffect"
    snowContainer.BackgroundTransparency = 1
    snowContainer.Size = UDim2.new(1, 0, 1, 0)
    snowContainer.ClipsDescendants = true
    snowContainer.Parent = parent
    
    local snowParticles = {}
    
    local function createSnowflake()
        local snowflake = Instance.new("Frame")
        snowflake.Name = "Snowflake"
        snowflake.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        snowflake.BorderSizePixel = 0
        snowflake.Size = UDim2.new(0, math.random(3, 8), 0, math.random(3, 8))
        snowflake.Position = UDim2.new(0, math.random(-50, parent.AbsoluteSize.X), 0, -20)
        snowflake.AnchorPoint = Vector2.new(0, 0)
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(1, 0)
        corner.Parent = snowflake
        
        snowflake.Parent = snowContainer
        table.insert(snowParticles, {
            Object = snowflake,
            Speed = math.random(50, 150) / 100,
            Drift = (math.random() - 0.5) * 2,
            Opacity = math.random(50, 100) / 100
        })
    end
    
    -- 创建初始雪花
    for i = 1, 30 do
        createSnowflake()
    end
    
    local connection
    connection = RunService.RenderStepped:Connect(function(delta)
        for i, snow in ipairs(snowParticles) do
            if snow.Object.Parent then
                local currentPos = snow.Object.Position
                local newY = currentPos.Y.Offset + (80 * snow.Speed * delta)
                local newX = currentPos.X.Offset + (20 * snow.Drift * delta)
                
                snow.Object.Position = UDim2.new(0, newX, 0, newY)
                snow.Object.BackgroundTransparency = 1 - snow.Opacity
                
                -- 重置雪花位置当它超出边界
                if newY > parent.AbsoluteSize.Y + 20 then
                    snow.Object.Position = UDim2.new(0, math.random(-50, parent.AbsoluteSize.X), 0, -20)
                    snow.Opacity = math.random(50, 100) / 100
                end
            end
        end
        
        -- 偶尔添加新雪花
        if math.random(1, 20) == 1 then
            createSnowflake()
        end
    end)
    
    return connection
end

-- 通知系统
local function SetupNotifications()
    if not CoreGui:FindFirstChild("RevenantNotificationHolder") then
        local notificationHolder = Instance.new("ScreenGui")
        notificationHolder.Name = "RevenantNotificationHolder"
        notificationHolder.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        notificationHolder.Parent = CoreGui
        
        local holderFrame = Instance.new("Frame")
        holderFrame.Name = "HolderFrame"
        holderFrame.AnchorPoint = Vector2.new(1, 0)
        holderFrame.BackgroundTransparency = 1
        holderFrame.Position = UDim2.new(1, -20, 0, 20)
        holderFrame.Size = UDim2.new(0, 350, 1, -40)
        holderFrame.Parent = notificationHolder
        
        local listLayout = Instance.new("UIListLayout")
        listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
        listLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
        listLayout.SortOrder = Enum.SortOrder.LayoutOrder
        listLayout.Padding = UDim.new(0, 10)
        listLayout.Parent = holderFrame
    end
end

SetupNotifications()

function Revenant.Notification(config)
    config = config or {}
    local title = config.Title or "通知"
    local content = config.Content or "这是一条通知"
    local duration = config.Duration or 5
    local icon = config.Icon or "rbxassetid://134902782140905"
    
    local notificationHolder = CoreGui:FindFirstChild("RevenantNotificationHolder")
    if not notificationHolder then return end
    
    local holderFrame = notificationHolder:FindFirstChild("HolderFrame")
    
    -- 创建通知框架
    local notification = Instance.new("Frame")
    notification.Name = "Notification"
    notification.BackgroundColor3 = Revenant.Themes[Revenant.CurrentTheme].Secondary
    notification.BackgroundTransparency = 0.1
    notification.BorderSizePixel = 0
    notification.Size = UDim2.new(0, 320, 0, 0)
    notification.ClipsDescendants = true
    notification.Parent = holderFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = notification
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Revenant.Themes[Revenant.CurrentTheme].Border
    stroke.Thickness = 1
    stroke.Parent = notification
    
    -- 图标
    local iconImage = Instance.new("ImageLabel")
    iconImage.Name = "Icon"
    iconImage.BackgroundTransparency = 1
    iconImage.Position = UDim2.new(0, 15, 0, 15)
    iconImage.Size = UDim2.new(0, 24, 0, 24)
    iconImage.Image = icon
    iconImage.Parent = notification
    
    -- 标题
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = title
    titleLabel.TextColor3 = Revenant.Themes[Revenant.CurrentTheme].Text
    titleLabel.TextSize = 14
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.BackgroundTransparency = 1
    titleLabel.Position = UDim2.new(0, 50, 0, 15)
    titleLabel.Size = UDim2.new(1, -65, 0, 20)
    titleLabel.Parent = notification
    
    -- 内容
    local contentLabel = Instance.new("TextLabel")
    contentLabel.Name = "Content"
    contentLabel.Font = Enum.Font.Gotham
    contentLabel.Text = content
    contentLabel.TextColor3 = Revenant.Themes[Revenant.CurrentTheme].TextSecondary
    contentLabel.TextSize = 12
    contentLabel.TextXAlignment = Enum.TextXAlignment.Left
    contentLabel.TextYAlignment = Enum.TextYAlignment.Top
    contentLabel.TextWrapped = true
    contentLabel.BackgroundTransparency = 1
    contentLabel.Position = UDim2.new(0, 50, 0, 40)
    contentLabel.Size = UDim2.new(1, -65, 0, 0)
    contentLabel.Parent = notification
    
    -- 进度条
    local progressBar = Instance.new("Frame")
    progressBar.Name = "ProgressBar"
    progressBar.BackgroundColor3 = Revenant.Themes[Revenant.CurrentTheme].Accent
    progressBar.BorderSizePixel = 0
    progressBar.Position = UDim2.new(0, 0, 1, -3)
    progressBar.Size = UDim2.new(1, 0, 0, 3)
    progressBar.Parent = notification
    
    local progressCorner = Instance.new("UICorner")
    progressCorner.CornerRadius = UDim.new(0, 8)
    progressCorner.Parent = progressBar
    
    -- 计算所需高度
    local textHeight = math.min(contentLabel.TextBounds.Y, 80)
    local totalHeight = 60 + textHeight
    
    -- 动画进入
    notification.Size = UDim2.new(0, 0, 0, 0)
    contentLabel.Size = UDim2.new(1, -65, 0, textHeight)
    
    local enterTween = TweenService:Create(notification, 
        TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Size = UDim2.new(0, 320, 0, totalHeight)}
    )
    enterTween:Play()
    
    -- 进度条动画
    local progressTween = TweenService:Create(progressBar,
        TweenInfo.new(duration, Enum.EasingStyle.Linear),
        {Size = UDim2.new(0, 0, 0, 3)}
    )
    
    -- 自动关闭
    task.delay(duration, function()
        local exitTween = TweenService:Create(notification,
            TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In),
            {Size = UDim2.new(0, 0, 0, totalHeight)}
        )
        exitTween:Play()
        exitTween.Completed:Wait()
        notification:Destroy()
    end)
    
    progressTween:Play()
    
    return notification
end

-- 创建侧边按钮
function Revenant.CreateToggleButton(config)
    config = config or {}
    local icon = config.Icon or "rbxassetid://134902782140905"
    local position = config.Position or UDim2.new(0, 20, 0, 20)
    
    -- 检查是否已存在
    local existing = CoreGui:FindFirstChild("RevenantToggleButton")
    if existing then
        existing:Destroy()
    end
    
    local toggleButton = Instance.new("ImageButton")
    toggleButton.Name = "RevenantToggleButton"
    toggleButton.Image = icon
    toggleButton.BackgroundColor3 = Revenant.Themes[Revenant.CurrentTheme].Secondary
    toggleButton.BackgroundTransparency = 0.1
    toggleButton.Position = position
    toggleButton.Size = UDim2.new(0, 50, 0, 50)
    toggleButton.Parent = CoreGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = toggleButton
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Thickness = 2
    stroke.Parent = toggleButton
    
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.Image = "rbxassetid://1316045217"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.8
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    shadow.BackgroundTransparency = 1
    shadow.Size = UDim2.new(1, 30, 1, 30)
    shadow.Position = UDim2.new(0, -15, 0, -15)
    shadow.ZIndex = -1
    shadow.Parent = toggleButton
    
    -- 存储引用
    Revenant.Elements.ToggleButton = toggleButton
    
    return toggleButton
end

-- 主窗口创建
function Revenant.CreateWindow(config)
    config = config or {}
    local title = config.Title or "孙坤脚本"
    local size = config.Size or UDim2.new(0, 700, 0, 500)
    local position = config.Position or UDim2.new(0.5, -350, 0.5, -250)
    
    -- 检查是否已存在
    local existing = CoreGui:FindFirstChild("RevenantUI")
    if existing then
        existing:Destroy()
    end
    
    -- 创建主窗口
    local mainWindow = Instance.new("ScreenGui")
    mainWindow.Name = "RevenantUI"
    mainWindow.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    mainWindow.Parent = CoreGui
    
    -- 主容器
    local mainContainer = Instance.new("Frame")
    mainContainer.Name = "MainContainer"
    mainContainer.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    mainContainer.BackgroundTransparency = 0.3
    mainContainer.Position = position
    mainContainer.Size = UDim2.new(0, 0, 0, 0)
    mainContainer.Parent = mainWindow
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 20)
    corner.Parent = mainContainer
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Revenant.Themes[Revenant.CurrentTheme].Border
    stroke.Thickness = 2
    stroke.Parent = mainContainer
    
    -- 添加下雪效果
    local snowConnection = CreateSnowEffect(mainContainer)
    
    -- 标题栏
    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.BackgroundColor3 = Revenant.Themes[Revenant.CurrentTheme].Main
    titleBar.BackgroundTransparency = 0.1
    titleBar.Size = UDim2.new(1, 0, 0, 40)
    titleBar.Parent = mainContainer
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 20)
    titleCorner.Parent = titleBar
    
    -- 标题文本
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = title
    titleLabel.TextColor3 = Revenant.Themes[Revenant.CurrentTheme].Text
    titleLabel.TextSize = 16
    titleLabel.BackgroundTransparency = 1
    titleLabel.Position = UDim2.new(0, 20, 0, 0)
    titleLabel.Size = UDim2.new(0, 200, 1, 0)
    titleLabel.Parent = titleBar
    
    -- 搜索框
    local searchBox = Instance.new("TextBox")
    searchBox.Name = "SearchBox"
    searchBox.Font = Enum.Font.Gotham
    searchBox.PlaceholderText = "搜索..."
    searchBox.PlaceholderColor3 = Revenant.Themes[Revenant.CurrentTheme].TextSecondary
    searchBox.Text = ""
    searchBox.TextColor3 = Revenant.Themes[Revenant.CurrentTheme].Text
    searchBox.TextSize = 12
    searchBox.BackgroundColor3 = Revenant.Themes[Revenant.CurrentTheme].Secondary
    searchBox.BackgroundTransparency = 0.1
    searchBox.Position = UDim2.new(1, -200, 0.5, -15)
    searchBox.Size = UDim2.new(0, 150, 0, 30)
    searchBox.Parent = titleBar
    
    local searchCorner = Instance.new("UICorner")
    searchCorner.CornerRadius = UDim.new(0, 8)
    searchCorner.Parent = searchBox
    
    -- 搜索图标
    local searchIcon = Instance.new("ImageLabel")
    searchIcon.Name = "SearchIcon"
    searchIcon.Image = "rbxassetid://134902782140905"
    searchIcon.BackgroundTransparency = 1
    searchIcon.Position = UDim2.new(0, 8, 0, 7)
    searchIcon.Size = UDim2.new(0, 16, 0, 16)
    searchIcon.Parent = searchBox
    
    searchBox.PlaceholderText = "搜索..."
    
    -- 控制按钮
    local minimizeBtn = Instance.new("TextButton")
    minimizeBtn.Name = "Minimize"
    minimizeBtn.Font = Enum.Font.GothamBold
    minimizeBtn.Text = "-"
    minimizeBtn.TextColor3 = Revenant.Themes[Revenant.CurrentTheme].Text
    minimizeBtn.TextSize = 16
    minimizeBtn.BackgroundColor3 = Revenant.Themes[Revenant.CurrentTheme].Secondary
    minimizeBtn.BackgroundTransparency = 0.1
    minimizeBtn.Position = UDim2.new(1, -90, 0.5, -15)
    minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
    minimizeBtn.Parent = titleBar
    
    local minimizeCorner = Instance.new("UICorner")
    minimizeCorner.CornerRadius = UDim.new(0, 8)
    minimizeCorner.Parent = minimizeBtn
    
    local closeBtn = Instance.new("TextButton")
    closeBtn.Name = "Close"
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Revenant.Themes[Revenant.CurrentTheme].Error
    closeBtn.TextSize = 14
    closeBtn.BackgroundColor3 = Revenant.Themes[Revenant.CurrentTheme].Secondary
    closeBtn.BackgroundTransparency = 0.1
    closeBtn.Position = UDim2.new(1, -50, 0.5, -15)
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Parent = titleBar
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 8)
    closeCorner.Parent = closeBtn
    
    -- 内容区域
    local contentArea = Instance.new("Frame")
    contentArea.Name = "ContentArea"
    contentArea.BackgroundTransparency = 1
    contentArea.Position = UDim2.new(0, 0, 0, 40)
    contentArea.Size = UDim2.new(1, 0, 1, -40)
    contentArea.Parent = mainContainer
    
    -- 分割线
    local divider = Instance.new("Frame")
    divider.Name = "Divider"
    divider.BackgroundColor3 = Revenant.Themes[Revenant.CurrentTheme].Border
    divider.BorderSizePixel = 0
    divider.Position = UDim2.new(0, 200, 0, 0)
    divider.Size = UDim2.new(0, 2, 1, 0)
    divider.Parent = contentArea
    
    -- 左侧分类栏
    local categoryList = Instance.new("ScrollingFrame")
    categoryList.Name = "CategoryList"
    categoryList.BackgroundTransparency = 1
    categoryList.BorderSizePixel = 0
    categoryList.Position = UDim2.new(0, 0, 0, 0)
    categoryList.Size = UDim2.new(0, 198, 1, -80)
    categoryList.CanvasSize = UDim2.new(0, 0, 0, 0)
    categoryList.ScrollBarThickness = 3
    categoryList.Parent = contentArea
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0, 5)
    listLayout.Parent = categoryList
    
    -- 用户信息框
    local userInfo = Instance.new("Frame")
    userInfo.Name = "UserInfo"
    userInfo.BackgroundColor3 = Revenant.Themes[Revenant.CurrentTheme].Secondary
    userInfo.BackgroundTransparency = 0.1
    userInfo.Position = UDim2.new(0, 10, 1, -70)
    userInfo.Size = UDim2.new(0, 178, 0, 60)
    userInfo.Parent = contentArea
    
    local userCorner = Instance.new("UICorner")
    userCorner.CornerRadius = UDim.new(0, 12)
    userCorner.Parent = userInfo
    
    -- 用户头像
    local avatar = Instance.new("ImageLabel")
    avatar.Name = "Avatar"
    avatar.Image = Players:GetUserThumbnailAsync(Player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
    avatar.BackgroundColor3 = Revenant.Themes[Revenant.CurrentTheme].Border
    avatar.Position = UDim2.new(0, 10, 0, 10)
    avatar.Size = UDim2.new(0, 40, 0, 40)
    avatar.Parent = userInfo
    
    local avatarCorner = Instance.new("UICorner")
    avatarCorner.CornerRadius = UDim.new(0, 20)
    avatarCorner.Parent = avatar
    
    -- 用户名
    local usernameLabel = Instance.new("TextLabel")
    usernameLabel.Name = "Username"
    usernameLabel.Font = Enum.Font.GothamBold
    usernameLabel.Text = Player.Name
    usernameLabel.TextColor3 = Revenant.Themes[Revenant.CurrentTheme].Text
    usernameLabel.TextSize = 12
    usernameLabel.TextXAlignment = Enum.TextXAlignment.Left
    usernameLabel.BackgroundTransparency = 1
    usernameLabel.Position = UDim2.new(0, 60, 0, 15)
    usernameLabel.Size = UDim2.new(0, 110, 0, 20)
    usernameLabel.Parent = userInfo
    
    -- 用户ID
    local userIdLabel = Instance.new("TextLabel")
    userIdLabel.Name = "UserID"
    userIdLabel.Font = Enum.Font.Gotham
    userIdLabel.Text = "ID: " .. Player.UserId
    userIdLabel.TextColor3 = Revenant.Themes[Revenant.CurrentTheme].TextSecondary
    userIdLabel.TextSize = 10
    userIdLabel.TextXAlignment = Enum.TextXAlignment.Left
    userIdLabel.BackgroundTransparency = 1
    userIdLabel.Position = UDim2.new(0, 60, 0, 30)
    userIdLabel.Size = UDim2.new(0, 110, 0, 15)
    userIdLabel.Parent = userInfo
    
    -- 右侧功能区域
    local functionArea = Instance.new("ScrollingFrame")
    functionArea.Name = "FunctionArea"
    functionArea.BackgroundTransparency = 1
    functionArea.Position = UDim2.new(0, 202, 0, 0)
    functionArea.Size = UDim2.new(1, -202, 1, 0)
    functionArea.CanvasSize = UDim2.new(0, 0, 0, 0)
    functionArea.ScrollBarThickness = 3
    functionArea.Parent = contentArea
    
    local functionLayout = Instance.new("UIListLayout")
    functionLayout.Padding = UDim.new(0, 10)
    functionLayout.Parent = functionArea
    
    -- 动画显示窗口
    local showTween = TweenService:Create(mainContainer,
        TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Size = size}
    )
    showTween:Play()
    
    -- 窗口拖动
    local dragging = false
    local dragStart, startPos
    
    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = mainContainer.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    titleBar.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            mainContainer.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                              startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    -- 按钮事件
    minimizeBtn.MouseButton1Click:Connect(function()
        local tween = TweenService:Create(mainContainer,
            TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 0, 0, 0)}
        )
        tween:Play()
        tween.Completed:Wait()
        mainWindow.Enabled = false
    end)
    
    closeBtn.MouseButton1Click:Connect(function()
        -- 确认对话框
        local confirmDialog = Instance.new("Frame")
        confirmDialog.Name = "ConfirmDialog"
        confirmDialog.BackgroundColor3 = Revenant.Themes[Revenant.CurrentTheme].Secondary
        confirmDialog.BackgroundTransparency = 0.1
        confirmDialog.Position = UDim2.new(0.5, -150, 0.5, -75)
        confirmDialog.Size = UDim2.new(0, 300, 0, 150)
        confirmDialog.Parent = mainContainer
        confirmDialog.ZIndex = 100
        
        local dialogCorner = Instance.new("UICorner")
        dialogCorner.CornerRadius = UDim.new(0, 15)
        dialogCorner.Parent = confirmDialog
        
        local dialogStroke = Instance.new("UIStroke")
        dialogStroke.Color = Revenant.Themes[Revenant.CurrentTheme].Accent
        dialogStroke.Thickness = 2
        dialogStroke.Parent = confirmDialog
        
        local title = Instance.new("TextLabel")
        title.Font = Enum.Font.GothamBold
        title.Text = "确认关闭"
        title.TextColor3 = Revenant.Themes[Revenant.CurrentTheme].Text
        title.TextSize = 18
        title.BackgroundTransparency = 1
        title.Size = UDim2.new(1, 0, 0, 50)
        title.Parent = confirmDialog
        
        local message = Instance.new("TextLabel")
        message.Font = Enum.Font.Gotham
        message.Text = "确定要关闭脚本吗？"
        message.TextColor3 = Revenant.Themes[Revenant.CurrentTheme].TextSecondary
        message.TextSize = 14
        message.BackgroundTransparency = 1
        message.Position = UDim2.new(0, 0, 0, 50)
        message.Size = UDim2.new(1, 0, 0, 50)
        message.Parent = confirmDialog
        
        local cancelBtn = Instance.new("TextButton")
        cancelBtn.Name = "Cancel"
        cancelBtn.Font = Enum.Font.GothamBold
        cancelBtn.Text = "否"
        cancelBtn.TextColor3 = Revenant.Themes[Revenant.CurrentTheme].Text
        cancelBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        cancelBtn.Position = UDim2.new(0, 50, 1, -60)
        cancelBtn.Size = UDim2.new(0, 80, 0, 40)
        cancelBtn.Parent = confirmDialog
        
        local cancelCorner = Instance.new("UICorner")
        cancelCorner.CornerRadius = UDim.new(0, 8)
        cancelCorner.Parent = cancelBtn
        
        local confirmBtn = Instance.new("TextButton")
        confirmBtn.Name = "Confirm"
        confirmBtn.Font = Enum.Font.GothamBold
        confirmBtn.Text = "是"
        confirmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        confirmBtn.BackgroundColor3 = Revenant.Themes[Revenant.CurrentTheme].Accent
        confirmBtn.Position = UDim2.new(1, -130, 1, -60)
        confirmBtn.Size = UDim2.new(0, 80, 0, 40)
        confirmBtn.Parent = confirmDialog
        
        local confirmCorner = Instance.new("UICorner")
        confirmCorner.CornerRadius = UDim.new(0, 8)
        confirmCorner.Parent = confirmBtn
        
        cancelBtn.MouseButton1Click:Connect(function()
            confirmDialog:Destroy()
        end)
        
        confirmBtn.MouseButton1Click:Connect(function()
            snowConnection:Disconnect()
            mainWindow:Destroy()
            if Revenant.Elements.ToggleButton then
                Revenant.Elements.ToggleButton:Destroy()
            end
        end)
    end)
    
    -- 搜索功能
    searchBox.Focused:Connect(function()
        searchBox.PlaceholderText = ""
    end)
    
    searchBox.FocusLost:Connect(function()
        if searchBox.Text == "" then
            searchBox.PlaceholderText = "搜索..."
        end
    end)
    
    local windowMethods = {}
    
    -- 添加分类
    function windowMethods:AddCategory(name, icon)
        icon = icon or "rbxassetid://134902782140905"
        
        local categoryBtn = Instance.new("TextButton")
        categoryBtn.Name = name
        categoryBtn.Font = Enum.Font.GothamBold
        categoryBtn.Text = "   " .. name
        categoryBtn.TextColor3 = Revenant.Themes[Revenant.CurrentTheme].Text
        categoryBtn.TextSize = 14
        categoryBtn.TextXAlignment = Enum.TextXAlignment.Left
        categoryBtn.BackgroundColor3 = Revenant.Themes[Revenant.CurrentTheme].Secondary
        categoryBtn.BackgroundTransparency = 0.1
        categoryBtn.Size = UDim2.new(1, -20, 0, 40)
        categoryBtn.Parent = categoryList
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 8)
        btnCorner.Parent = categoryBtn
        
        -- 图标
        local btnIcon = Instance.new("ImageLabel")
        btnIcon.Name = "Icon"
        btnIcon.Image = icon
        btnIcon.BackgroundTransparency = 1
        btnIcon.Position = UDim2.new(0, 10, 0.5, -12)
        btnIcon.Size = UDim2.new(0, 24, 0, 24)
        btnIcon.Parent = categoryBtn
        
        -- 更新滚动区域大小
        categoryList.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y)
        
        return categoryBtn
    end
    
    -- 添加开关
    function windowMethods:AddToggle(config)
        config = config or {}
        local name = config.Name or "开关"
        local defaultValue = config.Default or false
        local callback = config.Callback or function() end
        
        local toggleFrame = Instance.new("Frame")
        toggleFrame.Name = "Toggle_" .. name
        toggleFrame.BackgroundColor3 = Revenant.Themes[Revenant.CurrentTheme].Secondary
        toggleFrame.BackgroundTransparency = 0.1
        toggleFrame.Size = UDim2.new(1, -40, 0, 50)
        toggleFrame.Parent = functionArea
        
        local toggleCorner = Instance.new("UICorner")
        toggleCorner.CornerRadius = UDim.new(0, 12)
        toggleCorner.Parent = toggleFrame
        
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Font = Enum.Font.GothamBold
        nameLabel.Text = name
        nameLabel.TextColor3 = Revenant.Themes[Revenant.CurrentTheme].Text
        nameLabel.TextSize = 14
        nameLabel.TextXAlignment = Enum.TextXAlignment.Left
        nameLabel.BackgroundTransparency = 1
        nameLabel.Position = UDim2.new(0, 20, 0, 0)
        nameLabel.Size = UDim2.new(0.6, 0, 1, 0)
        nameLabel.Parent = toggleFrame
        
        local toggleBtn = Instance.new("Frame")
        toggleBtn.Name = "ToggleButton"
        toggleBtn.BackgroundColor3 = defaultValue and Revenant.Themes[Revenant.CurrentTheme].Success or Color3.fromRGB(100, 100, 110)
        toggleBtn.Position = UDim2.new(1, -70, 0.5, -15)
        toggleBtn.Size = UDim2.new(0, 60, 0, 30)
        toggleBtn.Parent = toggleFrame
        
        local toggleBtnCorner = Instance.new("UICorner")
        toggleBtnCorner.CornerRadius = UDim.new(1, 0)
        toggleBtnCorner.Parent = toggleBtn
        
        local toggleKnob = Instance.new("Frame")
        toggleKnob.Name = "ToggleKnob"
        toggleKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        toggleKnob.Position = defaultValue and UDim2.new(1, -25, 0.5, -10) or UDim2.new(0, 5, 0.5, -10)
        toggleKnob.Size = UDim2.new(0, 20, 0, 20)
        toggleKnob.Parent = toggleBtn
        
        local knobCorner = Instance.new("UICorner")
        knobCorner.CornerRadius = UDim.new(1, 0)
        knobCorner.Parent = toggleKnob
        
        toggleBtn.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                defaultValue = not defaultValue
                callback(defaultValue)
                
                local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                local knobTween = TweenService:Create(toggleKnob, tweenInfo,
                    {Position = defaultValue and UDim2.new(1, -25, 0.5, -10) or UDim2.new(0, 5, 0.5, -10)})
                local colorTween = TweenService:Create(toggleBtn, tweenInfo,
                    {BackgroundColor3 = defaultValue and Revenant.Themes[Revenant.CurrentTheme].Success or Color3.fromRGB(100, 100, 110)})
                
                knobTween:Play()
                colorTween:Play()
            end
        end)
        
        -- 更新滚动区域大小
        functionArea.CanvasSize = UDim2.new(0, 0, 0, functionLayout.AbsoluteContentSize.Y)
        
        return toggleFrame
    end
    
    -- 添加按钮
    function windowMethods:AddButton(config)
        config = config or {}
        local name = config.Name or "按钮"
        local callback = config.Callback or function() end
        
        local button = Instance.new("TextButton")
        button.Name = "Button_" .. name
        button.Font = Enum.Font.GothamBold
        button.Text = name
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.TextSize = 14
        button.BackgroundColor3 = Revenant.Themes[Revenant.CurrentTheme].Accent
        button.Size = UDim2.new(1, -40, 0, 50)
        button.Parent = functionArea
        
        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 12)
        buttonCorner.Parent = button
        
        button.MouseButton1Click:Connect(function()
            callback()
        end)
        
        -- 更新滚动区域大小
        functionArea.CanvasSize = UDim2.new(0, 0, 0, functionLayout.AbsoluteContentSize.Y)
        
        return button
    end
    
    -- 添加滑动条
    function windowMethods:AddSlider(config)
        config = config or {}
        local name = config.Name or "滑动条"
        local min = config.Min or 0
        local max = config.Max or 100
        local defaultValue = config.Default or 50
        local callback = config.Callback or function() end
        
        local sliderFrame = Instance.new("Frame")
        sliderFrame.Name = "Slider_" .. name
        sliderFrame.BackgroundColor3 = Revenant.Themes[Revenant.CurrentTheme].Secondary
        sliderFrame.BackgroundTransparency = 0.1
        sliderFrame.Size = UDim2.new(1, -40, 0, 70)
        sliderFrame.Parent = functionArea
        
        local sliderCorner = Instance.new("UICorner")
        sliderCorner.CornerRadius = UDim.new(0, 12)
        sliderCorner.Parent = sliderFrame
        
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Font = Enum.Font.GothamBold
        nameLabel.Text = name
        nameLabel.TextColor3 = Revenant.Themes[Revenant.CurrentTheme].Text
        nameLabel.TextSize = 14
        nameLabel.TextXAlignment = Enum.TextXAlignment.Left
        nameLabel.BackgroundTransparency = 1
        nameLabel.Position = UDim2.new(0, 20, 0, 10)
        nameLabel.Size = UDim2.new(0.6, 0, 0, 20)
        nameLabel.Parent = sliderFrame
        
        local valueLabel = Instance.new("TextLabel")
        valueLabel.Name = "Value"
        valueLabel.Font = Enum.Font.Gotham
        valueLabel.Text = tostring(defaultValue)
        valueLabel.TextColor3 = Revenant.Themes[Revenant.CurrentTheme].TextSecondary
        valueLabel.TextSize = 12
        valueLabel.TextXAlignment = Enum.TextXAlignment.Right
        valueLabel.BackgroundTransparency = 1
        valueLabel.Position = UDim2.new(0.6, 0, 0, 10)
        valueLabel.Size = UDim2.new(0.4, -20, 0, 20)
        valueLabel.Parent = sliderFrame
        
        local sliderTrack = Instance.new("Frame")
        sliderTrack.Name = "Track"
        sliderTrack.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        sliderTrack.Position = UDim2.new(0, 20, 0, 40)
        sliderTrack.Size = UDim2.new(1, -40, 0, 8)
        sliderTrack.Parent = sliderFrame
        
        local trackCorner = Instance.new("UICorner")
        trackCorner.CornerRadius = UDim.new(1, 0)
        trackCorner.Parent = sliderTrack
        
        local sliderFill = Instance.new("Frame")
        sliderFill.Name = "Fill"
        sliderFill.BackgroundColor3 = Revenant.Themes[Revenant.CurrentTheme].Accent
        sliderFill.Size = UDim2.new((defaultValue - min) / (max - min), 0, 1, 0)
        sliderFill.Parent = sliderTrack
        
        local fillCorner = Instance.new("UICorner")
        fillCorner.CornerRadius = UDim.new(1, 0)
        fillCorner.Parent = sliderFill
        
        local sliderKnob = Instance.new("Frame")
        sliderKnob.Name = "Knob"
        sliderKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        sliderKnob.Position = UDim2.new((defaultValue - min) / (max - min), -8, 0.5, -8)
        sliderKnob.Size = UDim2.new(0, 16, 0, 16)
        sliderKnob.Parent = sliderTrack
        
        local knobCorner = Instance.new("UICorner")
        knobCorner.CornerRadius = UDim.new(1, 0)
        knobCorner.Parent = sliderKnob
        
        local dragging = false
        
        local function updateSlider(input)
            local pos = UDim2.new(math.clamp((input.Position.X - sliderTrack.AbsolutePosition.X) / sliderTrack.AbsoluteSize.X, 0, 1), 0, 0.5, -8)
            local value = math.floor(min + (max - min) * pos.X.Scale)
            
            sliderKnob.Position = pos
            sliderFill.Size = UDim2.new(pos.X.Scale, 0, 1, 0)
            valueLabel.Text = tostring(value)
            callback(value)
        end
        
        sliderKnob.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
            end
        end)
        
        sliderKnob.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)
        
        UserInputService.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                updateSlider(input)
            end
        end)
        
        sliderTrack.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                updateSlider(input)
            end
        end)
        
        -- 更新滚动区域大小
        functionArea.CanvasSize = UDim2.new(0, 0, 0, functionLayout.AbsoluteContentSize.Y)
        
        return sliderFrame
    end
    
    -- 添加单选按钮
    function windowMethods:AddRadio(config)
        config = config or {}
        local name = config.Name or "单选"
        local options = config.Options or {"选项1", "选项2", "选项3"}
        local defaultValue = config.Default or 1
        local callback = config.Callback or function() end
        
        local radioFrame = Instance.new("Frame")
        radioFrame.Name = "Radio_" .. name
        radioFrame.BackgroundColor3 = Revenant.Themes[Revenant.CurrentTheme].Secondary
        radioFrame.BackgroundTransparency = 0.1
        radioFrame.Size = UDim2.new(1, -40, 0, 40 + (#options * 30))
        radioFrame.Parent = functionArea
        
        local radioCorner = Instance.new("UICorner")
        radioCorner.CornerRadius = UDim.new(0, 12)
        radioCorner.Parent = radioFrame
        
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Font = Enum.Font.GothamBold
        nameLabel.Text = name
        nameLabel.TextColor3 = Revenant.Themes[Revenant.CurrentTheme].Text
        nameLabel.TextSize = 14
        nameLabel.TextXAlignment = Enum.TextXAlignment.Left
        nameLabel.BackgroundTransparency = 1
        nameLabel.Position = UDim2.new(0, 20, 0, 10)
        nameLabel.Size = UDim2.new(1, -40, 0, 20)
        nameLabel.Parent = radioFrame
        
        local selected = defaultValue
        
        for i, option in ipairs(options) do
            local optionFrame = Instance.new("Frame")
            optionFrame.Name = "Option_" .. option
            optionFrame.BackgroundTransparency = 1
            optionFrame.Position = UDim2.new(0, 20, 0, 30 * i)
            optionFrame.Size = UDim2.new(1, -40, 0, 30)
            optionFrame.Parent = radioFrame
            
            local radioOuter = Instance.new("Frame")
            radioOuter.Name = "RadioOuter"
            radioOuter.BackgroundColor3 = Revenant.Themes[Revenant.CurrentTheme].Secondary
            radioOuter.Position = UDim2.new(0, 0, 0.5, -8)
            radioOuter.Size = UDim2.new(0, 16, 0, 16)
            radioOuter.Parent = optionFrame
            
            local outerCorner = Instance.new("UICorner")
            outerCorner.CornerRadius = UDim.new(1, 0)
            outerCorner.Parent = radioOuter
            
            local radioInner = Instance.new("Frame")
            radioInner.Name = "RadioInner"
            radioInner.BackgroundColor3 = i == selected and Revenant.Themes[Revenant.CurrentTheme].Accent or Color3.fromRGB(60, 60, 70)
            radioInner.Position = UDim2.new(0.5, -4, 0.5, -4)
            radioInner.Size = UDim2.new(0, 8, 0, 8)
            radioInner.Parent = radioOuter
            
            local innerCorner = Instance.new("UICorner")
            innerCorner.CornerRadius = UDim.new(1, 0)
            innerCorner.Parent = radioInner
            
            local optionLabel = Instance.new("TextLabel")
            optionLabel.Font = Enum.Font.Gotham
            optionLabel.Text = option
            optionLabel.TextColor3 = Revenant.Themes[Revenant.CurrentTheme].Text
            optionLabel.TextSize = 12
            optionLabel.TextXAlignment = Enum.TextXAlignment.Left
            optionLabel.BackgroundTransparency = 1
            optionLabel.Position = UDim2.new(0, 30, 0, 0)
            optionLabel.Size = UDim2.new(1, -30, 1, 0)
            optionLabel.Parent = optionFrame
            
            optionFrame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    selected = i
                    callback(option, i)
                    
                    -- 更新所有选项
                    for _, child in pairs(radioFrame:GetChildren()) do
                        if child:IsA("Frame") and child.Name:find("Option_") then
                            local inner = child:FindFirstChild("RadioOuter"):FindFirstChild("RadioInner")
                            inner.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
                        end
                    end
                    
                    radioInner.BackgroundColor3 = Revenant.Themes[Revenant.CurrentTheme].Accent
                end
            end)
        end
        
        -- 更新滚动区域大小
        functionArea.CanvasSize = UDim2.new(0, 0, 0, functionLayout.AbsoluteContentSize.Y)
        
        return radioFrame
    end
    
    -- 存储窗口引用
    Revenant.Elements.MainWindow = mainWindow
    Revenant.Elements.WindowMethods = windowMethods
    
    return windowMethods
end

-- 导出库
return Revenant
