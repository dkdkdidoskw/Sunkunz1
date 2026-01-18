-- 增强版UI库 - 彩虹主题编辑器
-- 作者：sunkun
-- 版本：2.0

local UILibrary = {}
UILibrary.__index = UILibrary

-- 服务
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- 常量
local DEFAULT_FONT = Font.new("rbxassetid://12187375422")
local RAINBOW_COLORS = {
    Color3.fromRGB(255, 0, 0),    -- 红
    Color3.fromRGB(255, 127, 0),  -- 橙
    Color3.fromRGB(255, 255, 0),  -- 黄
    Color3.fromRGB(0, 255, 0),    -- 绿
    Color3.fromRGB(0, 0, 255),    -- 蓝
    Color3.fromRGB(75, 0, 130),   -- 靛
    Color3.fromRGB(148, 0, 211)   -- 紫
}

-- 创建主UI
function UILibrary.new()
    local self = setmetatable({}, UILibrary)
    
    -- 状态变量
    self.isVisible = true
    self.rainbowEnabled = false
    self.rainbowSpeed = 1
    self.rainbowStyle = "Default"
    self.currentTheme = "Dark"
    self.currentTab = nil
    self.tabs = {}
    self.connections = {}
    
    -- 创建主界面
    self:CreateMainUI()
    self:CreateToggleButton()
    self:CreateDialogs()
    
    -- 初始化彩虹动画
    self:InitRainbowAnimation()
    
    -- 绑定快捷键
    self:BindShortcuts()
    
    return self
end

-- 创建主UI
function UILibrary:CreateMainUI()
    -- 主ScreenGui
    self.screenGui = Instance.new("ScreenGui")
    self.screenGui.Name = "SunkunUILibrary"
    self.screenGui.DisplayOrder = 999
    self.screenGui.ResetOnSpawn = false
    self.screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- 主容器
    self.mainFrame = Instance.new("Frame")
    self.mainFrame.Name = "MainFrame"
    self.mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    self.mainFrame.BorderSizePixel = 0
    self.mainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
    self.mainFrame.Size = UDim2.new(0, 600, 0, 400)
    self.mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    self.mainFrame.Parent = self.screenGui
    
    -- 圆角
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = self.mainFrame
    
    -- 彩虹边框（可动画化）
    self.rainbowBorder = Instance.new("Frame")
    self.rainbowBorder.Name = "RainbowBorder"
    self.rainbowBorder.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    self.rainbowBorder.BorderSizePixel = 0
    self.rainbowBorder.Position = UDim2.new(0, -2, 0, -2)
    self.rainbowBorder.Size = UDim2.new(1, 4, 1, 4)
    self.rainbowBorder.ZIndex = -1
    self.rainbowBorder.Parent = self.mainFrame
    
    local borderCorner = Instance.new("UICorner")
    borderCorner.CornerRadius = UDim.new(0, 14)
    borderCorner.Parent = self.rainbowBorder
    
    -- 标题栏
    self.titleBar = Instance.new("Frame")
    self.titleBar.Name = "TitleBar"
    self.titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    self.titleBar.BorderSizePixel = 0
    self.titleBar.Size = UDim2.new(1, 0, 0, 40)
    self.titleBar.Parent = self.mainFrame
    
    -- 标题
    self.titleLabel = Instance.new("TextLabel")
    self.titleLabel.Name = "Title"
    self.titleLabel.BackgroundTransparency = 1
    self.titleLabel.Position = UDim2.new(0, 15, 0, 0)
    self.titleLabel.Size = UDim2.new(0, 200, 1, 0)
    self.titleLabel.Font = DEFAULT_FONT
    self.titleLabel.Text = "sunkun"
    self.titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    self.titleLabel.TextSize = 20
    self.titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    self.titleLabel.Parent = self.titleBar
    
    -- 搜索框
    self.searchBox = Instance.new("TextBox")
    self.searchBox.Name = "SearchBox"
    self.searchBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    self.searchBox.BorderSizePixel = 0
    self.searchBox.Position = UDim2.new(0.5, -100, 0.5, -12)
    self.searchBox.Size = UDim2.new(0, 200, 0, 24)
    self.searchBox.Font = DEFAULT_FONT
    self.searchBox.PlaceholderText = "搜索..."
    self.searchBox.Text = ""
    self.searchBox.TextColor3 = Color3.fromRGB(200, 200, 200)
    self.searchBox.TextSize = 14
    self.searchBox.Parent = self.titleBar
    
    local searchCorner = Instance.new("UICorner")
    searchCorner.CornerRadius = UDim.new(0, 6)
    searchCorner.Parent = self.searchBox
    
    -- 最小化按钮
    self.minimizeButton = Instance.new("TextButton")
    self.minimizeButton.Name = "MinimizeButton"
    self.minimizeButton.BackgroundTransparency = 1
    self.minimizeButton.Position = UDim2.new(1, -60, 0.5, -10)
    self.minimizeButton.Size = UDim2.new(0, 25, 0, 20)
    self.minimizeButton.Font = DEFAULT_FONT
    self.minimizeButton.Text = "-"
    self.minimizeButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    self.minimizeButton.TextSize = 18
    self.minimizeButton.Parent = self.titleBar
    
    -- 关闭按钮
    self.closeButton = Instance.new("TextButton")
    self.closeButton.Name = "CloseButton"
    self.closeButton.BackgroundTransparency = 1
    self.closeButton.Position = UDim2.new(1, -30, 0.5, -10)
    self.closeButton.Size = UDim2.new(0, 25, 0, 20)
    self.closeButton.Font = DEFAULT_FONT
    self.closeButton.Text = "×"
    self.closeButton.TextColor3 = Color3.fromRGB(255, 100, 100)
    self.closeButton.TextSize = 18
    self.closeButton.Parent = self.titleBar
    
    -- 主内容区域
    self.contentFrame = Instance.new("Frame")
    self.contentFrame.Name = "ContentFrame"
    self.contentFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    self.contentFrame.BorderSizePixel = 0
    self.contentFrame.Position = UDim2.new(0, 0, 0, 40)
    self.contentFrame.Size = UDim2.new(1, 0, 1, -80)
    self.contentFrame.Parent = self.mainFrame
    
    -- 分界线
    self.divider = Instance.new("Frame")
    self.divider.Name = "Divider"
    self.divider.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    self.divider.BorderSizePixel = 0
    self.divider.Position = UDim2.new(0, 150, 0, 0)
    self.divider.Size = UDim2.new(0, 2, 1, 0)
    self.divider.Parent = self.contentFrame
    
    -- 分类栏容器
    self.categoryContainer = Instance.new("ScrollingFrame")
    self.categoryContainer.Name = "CategoryContainer"
    self.categoryContainer.BackgroundTransparency = 1
    self.categoryContainer.BorderSizePixel = 0
    self.categoryContainer.Size = UDim2.new(0, 150, 1, 0)
    self.categoryContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    self.categoryContainer.ScrollBarThickness = 3
    self.categoryContainer.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
    self.categoryContainer.Parent = self.contentFrame
    
    local categoryLayout = Instance.new("UIListLayout")
    categoryLayout.Padding = UDim.new(0, 5)
    categoryLayout.Parent = self.categoryContainer
    
    -- 功能页容器
    self.tabContainer = Instance.new("Frame")
    self.tabContainer.Name = "TabContainer"
    self.tabContainer.BackgroundTransparency = 1
    self.tabContainer.Position = UDim2.new(0, 152, 0, 0)
    self.tabContainer.Size = UDim2.new(1, -152, 1, 0)
    self.tabContainer.ClipsDescendants = true
    self.tabContainer.Parent = self.contentFrame
    
    -- 底部栏
    self.bottomBar = Instance.new("Frame")
    self.bottomBar.Name = "BottomBar"
    self.bottomBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    self.bottomBar.BorderSizePixel = 0
    self.bottomBar.Position = UDim2.new(0, 0, 1, -40)
    self.bottomBar.Size = UDim2.new(1, 0, 0, 40)
    self.bottomBar.Parent = self.mainFrame
    
    -- 用户信息
    self.userContainer = Instance.new("Frame")
    self.userContainer.Name = "UserContainer"
    self.userContainer.BackgroundTransparency = 1
    self.userContainer.Position = UDim2.new(0, 10, 0.5, -15)
    self.userContainer.Size = UDim2.new(0, 200, 0, 30)
    self.userContainer.Parent = self.bottomBar
    
    -- 用户头像
    self.userAvatar = Instance.new("ImageLabel")
    self.userAvatar.Name = "UserAvatar"
    self.userAvatar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    self.userAvatar.BorderSizePixel = 0
    self.userAvatar.Position = UDim2.new(0, 0, 0.5, -12)
    self.userAvatar.Size = UDim2.new(0, 24, 0, 24)
    self.userAvatar.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
    self.userAvatar.Parent = self.userContainer
    
    local avatarCorner = Instance.new("UICorner")
    avatarCorner.CornerRadius = UDim.new(1, 0)
    avatarCorner.Parent = self.userAvatar
    
    -- 用户信息标签
    self.userLabel = Instance.new("TextLabel")
    self.userLabel.Name = "UserLabel"
    self.userLabel.BackgroundTransparency = 1
    self.userLabel.Position = UDim2.new(0, 30, 0, 0)
    self.userLabel.Size = UDim2.new(1, -30, 1, 0)
    self.userLabel.Font = DEFAULT_FONT
    self.userLabel.Text = LocalPlayer.Name .. " (" .. LocalPlayer.UserId .. ")"
    self.userLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    self.userLabel.TextSize = 14
    self.userLabel.TextXAlignment = Enum.TextXAlignment.Left
    self.userLabel.Parent = self.userContainer
    
    -- 主题切换按钮
    self.themeButton = Instance.new("TextButton")
    self.themeButton.Name = "ThemeButton"
    self.themeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    self.themeButton.BorderSizePixel = 0
    self.themeButton.Position = UDim2.new(1, -100, 0.5, -12)
    self.themeButton.Size = UDim2.new(0, 90, 0, 24)
    self.themeButton.Font = DEFAULT_FONT
    self.themeButton.Text = "暗色模式"
    self.themeButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    self.themeButton.TextSize = 14
    self.themeButton.Parent = self.bottomBar
    
    local themeCorner = Instance.new("UICorner")
    themeCorner.CornerRadius = UDim.new(0, 6)
    themeCorner.Parent = self.themeButton
    
    -- 连接事件
    self:ConnectEvents()
    
    -- 设置可拖动
    self:MakeDraggable(self.titleBar, self.mainFrame)
end

-- 创建切换按钮
function UILibrary:CreateToggleButton()
    self.toggleButton = Instance.new("ImageButton")
    self.toggleButton.Name = "ToggleButton"
    self.toggleButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    self.toggleButton.BorderSizePixel = 0
    self.toggleButton.Position = UDim2.new(0, 20, 0, 20)
    self.toggleButton.Size = UDim2.new(0, 40, 0, 40)
    self.toggleButton.Image = "rbxassetid://134902782140905"
    self.toggleButton.Parent = self.screenGui
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 8)
    toggleCorner.Parent = self.toggleButton
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Thickness = 2
    stroke.Parent = self.toggleButton
    
    -- 点击事件
    self.toggleButton.MouseButton1Click:Connect(function()
        self:ToggleUI()
    end)
end

-- 创建对话框
function UILibrary:CreateDialogs()
    -- 关闭确认对话框
    self.closeDialog = Instance.new("Frame")
    self.closeDialog.Name = "CloseDialog"
    self.closeDialog.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    self.closeDialog.BorderSizePixel = 0
    self.closeDialog.Position = UDim2.new(0.5, -150, 0.5, -75)
    self.closeDialog.Size = UDim2.new(0, 300, 0, 150)
    self.closeDialog.AnchorPoint = Vector2.new(0.5, 0.5)
    self.closeDialog.Visible = false
    self.closeDialog.ZIndex = 100
    self.closeDialog.Parent = self.screenGui
    
    local dialogCorner = Instance.new("UICorner")
    dialogCorner.CornerRadius = UDim.new(0, 12)
    dialogCorner.Parent = self.closeDialog
    
    local dialogStroke = Instance.new("UIStroke")
    dialogStroke.Color = Color3.fromRGB(100, 100, 100)
    dialogStroke.Thickness = 2
    dialogStroke.Parent = self.closeDialog
    
    -- 标题
    local dialogTitle = Instance.new("TextLabel")
    dialogTitle.Name = "Title"
    dialogTitle.BackgroundTransparency = 1
    dialogTitle.Position = UDim2.new(0, 20, 0, 20)
    dialogTitle.Size = UDim2.new(1, -40, 0, 30)
    dialogTitle.Font = DEFAULT_FONT
    dialogTitle.Text = "是否关闭？"
    dialogTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    dialogTitle.TextSize = 20
    dialogTitle.TextXAlignment = Enum.TextXAlignment.Left
    dialogTitle.Parent = self.closeDialog
    
    -- 内容
    local dialogContent = Instance.new("TextLabel")
    dialogContent.Name = "Content"
    dialogContent.BackgroundTransparency = 1
    dialogContent.Position = UDim2.new(0, 20, 0, 60)
    dialogContent.Size = UDim2.new(1, -40, 0, 40)
    dialogContent.Font = DEFAULT_FONT
    dialogContent.Text = "关闭脚本"
    dialogContent.TextColor3 = Color3.fromRGB(200, 200, 200)
    dialogContent.TextSize = 16
    dialogContent.TextXAlignment = Enum.TextXAlignment.Left
    dialogContent.TextYAlignment = Enum.TextYAlignment.Top
    dialogContent.Parent = self.closeDialog
    
    -- 按钮容器
    local buttonContainer = Instance.new("Frame")
    buttonContainer.Name = "ButtonContainer"
    buttonContainer.BackgroundTransparency = 1
    buttonContainer.Position = UDim2.new(0, 20, 1, -50)
    buttonContainer.Size = UDim2.new(1, -40, 0, 30)
    buttonContainer.Parent = self.closeDialog
    
    -- 否按钮
    self.noButton = Instance.new("TextButton")
    self.noButton.Name = "NoButton"
    self.noButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    self.noButton.BorderSizePixel = 0
    self.noButton.Position = UDim2.new(0, 0, 0, 0)
    self.noButton.Size = UDim2.new(0.5, -5, 1, 0)
    self.noButton.Font = DEFAULT_FONT
    self.noButton.Text = "否"
    self.noButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    self.noButton.TextSize = 16
    self.noButton.Parent = buttonContainer
    
    local noCorner = Instance.new("UICorner")
    noCorner.CornerRadius = UDim.new(0, 6)
    noCorner.Parent = self.noButton
    
    -- 是按钮
    self.yesButton = Instance.new("TextButton")
    self.yesButton.Name = "YesButton"
    self.yesButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    self.yesButton.BorderSizePixel = 0
    self.yesButton.Position = UDim2.new(0.5, 5, 0, 0)
    self.yesButton.Size = UDim2.new(0.5, -5, 1, 0)
    self.yesButton.Font = DEFAULT_FONT
    self.yesButton.Text = "是"
    self.yesButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    self.yesButton.TextSize = 16
    self.yesButton.Parent = buttonContainer
    
    local yesCorner = Instance.new("UICorner")
    yesCorner.CornerRadius = UDim.new(0, 6)
    yesCorner.Parent = self.yesButton
    
    -- 连接事件
    self.noButton.MouseButton1Click:Connect(function()
        self.closeDialog.Visible = false
    end)
    
    self.yesButton.MouseButton1Click:Connect(function()
        self:Destroy()
    end)
end

-- 连接事件
function UILibrary:ConnectEvents()
    -- 最小化按钮
    self.minimizeButton.MouseButton1Click:Connect(function()
        self:Minimize()
    end)
    
    -- 关闭按钮
    self.closeButton.MouseButton1Click:Connect(function()
        self.closeDialog.Visible = true
    end)
    
    -- 主题切换按钮
    self.themeButton.MouseButton1Click:Connect(function()
        self:ToggleTheme()
    end)
    
    -- 搜索框
    self.searchBox.FocusLost:Connect(function()
        self:Search(self.searchBox.Text)
    end)
end

-- 绑定快捷键
function UILibrary:BindShortcuts()
    table.insert(self.connections, UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed then
            if input.KeyCode == Enum.KeyCode.RightControl then
                self:ToggleUI()
            elseif input.KeyCode == Enum.KeyCode.Escape then
                self.closeDialog.Visible = true
            end
        end
    end))
end

-- 初始化彩虹动画
function UILibrary:InitRainbowAnimation()
    self.rainbowIndex = 1
    self.rainbowTime = 0
    
    -- 彩虹动画循环
    self.rainbowConnection = RunService.RenderStepped:Connect(function(deltaTime)
        if self.rainbowEnabled then
            self.rainbowTime = self.rainbowTime + deltaTime * self.rainbowSpeed
            
            if self.rainbowStyle == "Default" then
                -- 平滑过渡
                local t = (math.sin(self.rainbowTime) + 1) / 2
                local colorIndex = math.floor(t * (#RAINBOW_COLORS - 1)) + 1
                local nextIndex = colorIndex % #RAINBOW_COLORS + 1
                local localT = (t * (#RAINBOW_COLORS - 1)) % 1
                
                self.rainbowBorder.BackgroundColor3 = RAINBOW_COLORS[colorIndex]:Lerp(
                    RAINBOW_COLORS[nextIndex], localT
                )
            elseif self.rainbowStyle == "Pulse" then
                -- 脉冲效果
                local pulse = (math.sin(self.rainbowTime * 2) + 1) / 2
                self.rainbowBorder.BackgroundColor3 = Color3.fromHSV(
                    (self.rainbowTime * 0.5) % 1, 1, 0.5 + pulse * 0.5
                )
            elseif self.rainbowStyle == "Static" then
                -- 静态彩虹（分段）
                local segment = math.floor((self.rainbowTime * 0.5) % #RAINBOW_COLORS) + 1
                self.rainbowBorder.BackgroundColor3 = RAINBOW_COLORS[segment]
            end
        end
    end)
end

-- 创建标签页
function UILibrary:CreateTab(name)
    local tab = {}
    tab.name = name
    tab.visible = false
    
    -- 创建分类按钮
    local categoryButton = Instance.new("TextButton")
    categoryButton.Name = name .. "Category"
    categoryButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    categoryButton.BorderSizePixel = 0
    categoryButton.Size = UDim2.new(1, -10, 0, 35)
    categoryButton.Font = DEFAULT_FONT
    categoryButton.Text = name
    categoryButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    categoryButton.TextSize = 16
    categoryButton.Parent = self.categoryContainer
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 6)
    buttonCorner.Parent = categoryButton
    
    -- 创建标签页
    local tabFrame = Instance.new("ScrollingFrame")
    tabFrame.Name = name .. "Tab"
    tabFrame.BackgroundTransparency = 1
    tabFrame.Size = UDim2.new(1, 0, 1, 0)
    tabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    tabFrame.ScrollBarThickness = 5
    tabFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
    tabFrame.Visible = false
    tabFrame.Parent = self.tabContainer
    
    local tabLayout = Instance.new("UIListLayout")
    tabLayout.Padding = UDim.new(0, 10)
    tabLayout.Parent = tabFrame
    
    tab.button = categoryButton
    tab.frame = tabFrame
    tab.layout = tabLayout
    tab.elements = {}
    
    -- 点击事件
    categoryButton.MouseButton1Click:Connect(function()
        self:SwitchTab(name)
    end)
    
    -- 存储标签页
    self.tabs[name] = tab
    
    -- 设置第一个标签页为默认
    if not self.currentTab then
        self:SwitchTab(name)
    end
    
    -- 更新容器大小
    self:UpdateCategoryContainer()
    
    return tab
end

-- 更新分类容器大小
function UILibrary:UpdateCategoryContainer()
    local totalHeight = 0
    for _, child in ipairs(self.categoryContainer:GetChildren()) do
        if child:IsA("TextButton") then
            totalHeight = totalHeight + child.Size.Y.Offset + 5
        end
    end
    self.categoryContainer.CanvasSize = UDim2.new(0, 0, 0, totalHeight)
end

-- 切换标签页
function UILibrary:SwitchTab(tabName)
    -- 隐藏当前标签页
    if self.currentTab then
        self.tabs[self.currentTab].frame.Visible = false
        self.tabs[self.currentTab].button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end
    
    -- 显示新标签页
    self.currentTab = tabName
    self.tabs[tabName].frame.Visible = true
    self.tabs[tabName].button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
end

-- 添加按钮
function UILibrary:AddButton(tabName, buttonName, callback)
    local tab = self.tabs[tabName]
    if not tab then return end
    
    local button = Instance.new("TextButton")
    button.Name = buttonName
    button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    button.BorderSizePixel = 0
    button.Size = UDim2.new(1, -20, 0, 40)
    button.Font = DEFAULT_FONT
    button.Text = buttonName
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 16
    button.Parent = tab.frame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button
    
    -- 悬停效果
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(55, 55, 55)
        }):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        }):Play()
    end)
    
    -- 点击事件
    button.MouseButton1Click:Connect(function()
        if callback then
            local success, err = pcall(callback)
            if not success then
                warn("按钮回调错误: " .. err)
            end
        end
    end)
    
    -- 添加到元素列表
    table.insert(tab.elements, {
        type = "Button",
        name = buttonName,
        object = button
    })
    
    -- 更新标签页大小
    self:UpdateTabSize(tabName)
    
    return button
end

-- 添加开关
function UILibrary:AddToggle(tabName, toggleName, defaultValue, callback)
    local tab = self.tabs[tabName]
    if not tab then return end
    
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Name = toggleName .. "Toggle"
    toggleFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    toggleFrame.BorderSizePixel = 0
    toggleFrame.Size = UDim2.new(1, -20, 0, 40)
    toggleFrame.Parent = tab.frame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = toggleFrame
    
    -- 标签
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 15, 0, 0)
    label.Size = UDim2.new(0.7, -15, 1, 0)
    label.Font = DEFAULT_FONT
    label.Text = toggleName
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 16
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = toggleFrame
    
    -- 开关背景
    local toggleBackground = Instance.new("Frame")
    toggleBackground.Name = "Background"
    toggleBackground.BackgroundColor3 = defaultValue and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(80, 80, 80)
    toggleBackground.BorderSizePixel = 0
    toggleBackground.Position = UDim2.new(1, -65, 0.5, -10)
    toggleBackground.Size = UDim2.new(0, 50, 0, 20)
    toggleBackground.AnchorPoint = Vector2.new(1, 0.5)
    toggleBackground.Parent = toggleFrame
    
    local bgCorner = Instance.new("UICorner")
    bgCorner.CornerRadius = UDim.new(1, 0)
    bgCorner.Parent = toggleBackground
    
    -- 开关圆点
    local toggleCircle = Instance.new("Frame")
    toggleCircle.Name = "Circle"
    toggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    toggleCircle.BorderSizePixel = 0
    toggleCircle.Position = defaultValue and UDim2.new(1, -15, 0.5, -8) or UDim2.new(0, 5, 0.5, -8)
    toggleCircle.Size = UDim2.new(0, 16, 0, 16)
    toggleCircle.AnchorPoint = Vector2.new(0, 0.5)
    toggleCircle.Parent = toggleBackground
    
    local circleCorner = Instance.new("UICorner")
    circleCorner.CornerRadius = UDim.new(1, 0)
    circleCorner.Parent = toggleCircle
    
    -- 状态
    local state = defaultValue or false
    
    -- 点击事件
    toggleFrame.MouseButton1Click:Connect(function()
        state = not state
        
        TweenService:Create(toggleBackground, TweenInfo.new(0.2), {
            BackgroundColor3 = state and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(80, 80, 80)
        }):Play()
        
        TweenService:Create(toggleCircle, TweenInfo.new(0.2), {
            Position = state and UDim2.new(1, -15, 0.5, -8) or UDim2.new(0, 5, 0.5, -8)
        }):Play()
        
        if callback then
            local success, err = pcall(callback, state)
            if not success then
                warn("开关回调错误: " .. err)
            end
        end
    end)
    
    -- 悬停效果
    toggleFrame.MouseEnter:Connect(function()
        TweenService:Create(toggleFrame, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(55, 55, 55)
        }):Play()
    end)
    
    toggleFrame.MouseLeave:Connect(function()
        TweenService:Create(toggleFrame, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        }):Play()
    end)
    
    -- 添加到元素列表
    table.insert(tab.elements, {
        type = "Toggle",
        name = toggleName,
        state = state,
        object = toggleFrame,
        background = toggleBackground,
        circle = toggleCircle
    })
    
    -- 更新标签页大小
    self:UpdateTabSize(tabName)
    
    return {
        Set = function(value)
            state = value
            toggleBackground.BackgroundColor3 = value and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(80, 80, 80)
            toggleCircle.Position = value and UDim2.new(1, -15, 0.5, -8) or UDim2.new(0, 5, 0.5, -8)
        end,
        Get = function()
            return state
        end
    }
end

-- 添加滑动条
function UILibrary:AddSlider(tabName, sliderName, minValue, maxValue, defaultValue, callback)
    local tab = self.tabs[tabName]
    if not tab then return end
    
    defaultValue = defaultValue or minValue
    
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Name = sliderName .. "Slider"
    sliderFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    sliderFrame.BorderSizePixel = 0
    sliderFrame.Size = UDim2.new(1, -20, 0, 60)
    sliderFrame.Parent = tab.frame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = sliderFrame
    
    -- 标签和值
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 15, 0, 5)
    label.Size = UDim2.new(1, -30, 0, 20)
    label.Font = DEFAULT_FONT
    label.Text = sliderName .. ": " .. defaultValue
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 16
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = sliderFrame
    
    -- 滑动条背景
    local sliderBackground = Instance.new("Frame")
    sliderBackground.Name = "Background"
    sliderBackground.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    sliderBackground.BorderSizePixel = 0
    sliderBackground.Position = UDim2.new(0, 15, 0, 35)
    sliderBackground.Size = UDim2.new(1, -30, 0, 6)
    sliderBackground.Parent = sliderFrame
    
    local bgCorner = Instance.new("UICorner")
    bgCorner.CornerRadius = UDim.new(1, 0)
    bgCorner.Parent = sliderBackground
    
    -- 滑动条填充
    local sliderFill = Instance.new("Frame")
    sliderFill.Name = "Fill"
    sliderFill.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    sliderFill.BorderSizePixel = 0
    sliderFill.Size = UDim2.new((defaultValue - minValue) / (maxValue - minValue), 0, 1, 0)
    sliderFill.Parent = sliderBackground
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(1, 0)
    fillCorner.Parent = sliderFill
    
    -- 滑动点
    local sliderDot = Instance.new("Frame")
    sliderDot.Name = "Dot"
    sliderDot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderDot.BorderSizePixel = 0
    sliderDot.Position = UDim2.new((defaultValue - minValue) / (maxValue - minValue), -8, 0.5, -8)
    sliderDot.Size = UDim2.new(0, 16, 0, 16)
    sliderDot.AnchorPoint = Vector2.new(0.5, 0.5)
    sliderDot.Parent = sliderBackground
    
    local dotCorner = Instance.new("UICorner")
    dotCorner.CornerRadius = UDim.new(1, 0)
    dotCorner.Parent = sliderDot
    
    -- 状态
    local dragging = false
    local value = defaultValue
    
    -- 更新值
    local function updateValue(newValue)
        value = math.clamp(newValue, minValue, maxValue)
        local percentage = (value - minValue) / (maxValue - minValue)
        
        sliderFill.Size = UDim2.new(percentage, 0, 1, 0)
        sliderDot.Position = UDim2.new(percentage, -8, 0.5, -8)
        label.Text = sliderName .. ": " .. math.floor(value * 100) / 100
        
        if callback then
            local success, err = pcall(callback, value)
            if not success then
                warn("滑动条回调错误: " .. err)
            end
        end
    end
    
    -- 鼠标事件
    local function onInput(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local relativeX = (input.Position.X - sliderBackground.AbsolutePosition.X) / sliderBackground.AbsoluteSize.X
            relativeX = math.clamp(relativeX, 0, 1)
            updateValue(minValue + relativeX * (maxValue - minValue))
        end
    end
    
    sliderBackground.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            onInput(input)
        end
    end)
    
    sliderBackground.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    sliderBackground.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            onInput(input)
        end
    end)
    
    -- 悬停效果
    sliderFrame.MouseEnter:Connect(function()
        TweenService:Create(sliderFrame, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(55, 55, 55)
        }):Play()
    end)
    
    sliderFrame.MouseLeave:Connect(function()
        TweenService:Create(sliderFrame, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        }):Play()
    end)
    
    -- 添加到元素列表
    table.insert(tab.elements, {
        type = "Slider",
        name = sliderName,
        value = value,
        object = sliderFrame
    })
    
    -- 更新标签页大小
    self:UpdateTabSize(tabName)
    
    return {
        Set = function(newValue)
            updateValue(newValue)
        end,
        Get = function()
            return value
        end
    }
end

-- 添加颜色选择器
function UILibrary:AddColorPicker(tabName, pickerName, defaultColor, callback)
    local tab = self.tabs[tabName]
    if not tab then return end
    
    defaultColor = defaultColor or Color3.fromRGB(255, 255, 255)
    
    local pickerFrame = Instance.new("Frame")
    pickerFrame.Name = pickerName .. "ColorPicker"
    pickerFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    pickerFrame.BorderSizePixel = 0
    pickerFrame.Size = UDim2.new(1, -20, 0, 50)
    pickerFrame.Parent = tab.frame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = pickerFrame
    
    -- 标签
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 15, 0, 0)
    label.Size = UDim2.new(0.7, -15, 1, 0)
    label.Font = DEFAULT_FONT
    label.Text = pickerName
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 16
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = pickerFrame
    
    -- 颜色预览
    local colorPreview = Instance.new("Frame")
    colorPreview.Name = "Preview"
    colorPreview.BackgroundColor3 = defaultColor
    colorPreview.BorderSizePixel = 0
    colorPreview.Position = UDim2.new(1, -45, 0.5, -15)
    colorPreview.Size = UDim2.new(0, 30, 0, 30)
    colorPreview.AnchorPoint = Vector2.new(1, 0.5)
    colorPreview.Parent = pickerFrame
    
    local previewCorner = Instance.new("UICorner")
    previewCorner.CornerRadius = UDim.new(0, 6)
    previewCorner.Parent = colorPreview
    
    -- 点击打开颜色选择器
    local colorPickerOpen = false
    local colorPickerFrame = nil
    
    local function createColorPicker()
        if colorPickerFrame then
            colorPickerFrame:Destroy()
        end
        
        colorPickerFrame = Instance.new("Frame")
        colorPickerFrame.Name = "ColorPicker"
        colorPickerFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        colorPickerFrame.BorderSizePixel = 0
        colorPickerFrame.Position = UDim2.new(0, 0, 1, 5)
        colorPickerFrame.Size = UDim2.new(1, 0, 0, 150)
        colorPickerFrame.Visible = true
        colorPickerFrame.Parent = pickerFrame
        
        local pickerCorner = Instance.new("UICorner")
        pickerCorner.CornerRadius = UDim.new(0, 6)
        pickerCorner.Parent = colorPickerFrame
        
        -- 色相条
        local hueBar = Instance.new("Frame")
        hueBar.Name = "HueBar"
        hueBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        hueBar.BorderSizePixel = 0
        hueBar.Position = UDim2.new(0, 10, 0, 10)
        hueBar.Size = UDim2.new(1, -20, 0, 20)
        hueBar.Parent = colorPickerFrame
        
        local hueGradient = Instance.new("UIGradient")
        hueGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
            ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
            ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
            ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
            ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
        })
        hueGradient.Parent = hueBar
        
        -- 亮度/饱和度选择
        local saturationFrame = Instance.new("Frame")
        saturationFrame.Name = "SaturationFrame"
        saturationFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        saturationFrame.BorderSizePixel = 0
        saturationFrame.Position = UDim2.new(0, 10, 0, 40)
        saturationFrame.Size = UDim2.new(0.7, -15, 0, 100)
        saturationFrame.Parent = colorPickerFrame
        
        local saturationGradient1 = Instance.new("UIGradient")
        saturationGradient1.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
            ColorSequenceKeypoint.new(1, colorPreview.BackgroundColor3)
        })
        saturationGradient1.Rotation = 0
        saturationGradient1.Parent = saturationFrame
        
        local saturationGradient2 = Instance.new("UIGradient")
        saturationGradient2.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0, 0)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
        })
        saturationGradient2.Rotation = 90
        saturationGradient2.Parent = saturationFrame
        
        -- 当前颜色预览
        local currentColorPreview = Instance.new("Frame")
        currentColorPreview.Name = "CurrentColor"
        currentColorPreview.BackgroundColor3 = colorPreview.BackgroundColor3
        currentColorPreview.BorderSizePixel = 0
        currentColorPreview.Position = UDim2.new(0.75, 10, 0, 40)
        currentColorPreview.Size = UDim2.new(0.25, -15, 0, 100)
        currentColorPreview.Parent = colorPickerFrame
        
        local currentCorner = Instance.new("UICorner")
        currentCorner.CornerRadius = UDim.new(0, 6)
        currentCorner.Parent = currentColorPreview
        
        -- RGB值显示
        local rgbLabel = Instance.new("TextLabel")
        rgbLabel.Name = "RGBLabel"
        rgbLabel.BackgroundTransparency = 1
        rgbLabel.Position = UDim2.new(0.75, 10, 0, 145)
        rgbLabel.Size = UDim2.new(0.25, -15, 0, 20)
        rgbLabel.Font = DEFAULT_FONT
        rgbLabel.Text = string.format("R:%d G:%d B:%d", 
            math.floor(colorPreview.BackgroundColor3.r * 255),
            math.floor(colorPreview.BackgroundColor3.g * 255),
            math.floor(colorPreview.BackgroundColor3.b * 255))
        rgbLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        rgbLabel.TextSize = 12
        rgbLabel.TextXAlignment = Enum.TextXAlignment.Center
        rgbLabel.Parent = colorPickerFrame
        
        -- 选择点
        local selectionDot = Instance.new("Frame")
        selectionDot.Name = "SelectionDot"
        selectionDot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        selectionDot.BorderSizePixel = 1
        selectionDot.BorderColor3 = Color3.fromRGB(0, 0, 0)
        selectionDot.Size = UDim2.new(0, 10, 0, 10)
        selectionDot.AnchorPoint = Vector2.new(0.5, 0.5)
        selectionDot.Parent = saturationFrame
        
        local dotCorner = Instance.new("UICorner")
        dotCorner.CornerRadius = UDim.new(1, 0)
        dotCorner.Parent = selectionDot
        
        -- 色相选择点
        local hueSelection = Instance.new("Frame")
        hueSelection.Name = "HueSelection"
        hueSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        hueSelection.BorderSizePixel = 1
        hueSelection.BorderColor3 = Color3.fromRGB(0, 0, 0)
        hueSelection.Size = UDim2.new(0, 10, 0, 10)
        hueSelection.AnchorPoint = Vector2.new(0.5, 0.5)
        hueSelection.Parent = hueBar
        
        local hueDotCorner = Instance.new("UICorner")
        hueDotCorner.CornerRadius = UDim.new(1, 0)
        hueDotCorner.Parent = hueSelection
        
        -- 更新颜色
        local function updateColor(h, s, v)
            local newColor = Color3.fromHSV(h, s, v)
            colorPreview.BackgroundColor3 = newColor
            currentColorPreview.BackgroundColor3 = newColor
            
            -- 更新饱和度渐变
            saturationGradient1.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                ColorSequenceKeypoint.new(1, Color3.fromHSV(h, 1, 1))
            })
            
            -- 更新RGB标签
            rgbLabel.Text = string.format("R:%d G:%d B:%d", 
                math.floor(newColor.r * 255),
                math.floor(newColor.g * 255),
                math.floor(newColor.b * 255))
            
            if callback then
                local success, err = pcall(callback, newColor)
                if not success then
                    warn("颜色选择器回调错误: " .. err)
                end
            end
        end
        
        -- 鼠标事件
        local dragging = false
        local hueDragging = false
        
        saturationFrame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                local relativeX = (input.Position.X - saturationFrame.AbsolutePosition.X) / saturationFrame.AbsoluteSize.X
                local relativeY = (input.Position.Y - saturationFrame.AbsolutePosition.Y) / saturationFrame.AbsoluteSize.Y
                
                relativeX = math.clamp(relativeX, 0, 1)
                relativeY = math.clamp(relativeY, 0, 1)
                
                selectionDot.Position = UDim2.new(relativeX, 0, relativeY, 0)
                updateColor(0.5, relativeX, 1 - relativeY)
            end
        end)
        
        hueBar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                hueDragging = true
                local relativeX = (input.Position.X - hueBar.AbsolutePosition.X) / hueBar.AbsoluteSize.X
                relativeX = math.clamp(relativeX, 0, 1)
                
                hueSelection.Position = UDim2.new(relativeX, 0, 0.5, 0)
                updateColor(relativeX, 0.5, 0.5)
            end
        end)
        
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
                hueDragging = false
            end
        end)
        
        UserInputService.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                if dragging then
                    local relativeX = (input.Position.X - saturationFrame.AbsolutePosition.X) / saturationFrame.AbsoluteSize.X
                    local relativeY = (input.Position.Y - saturationFrame.AbsolutePosition.Y) / saturationFrame.AbsoluteSize.Y
                    
                    relativeX = math.clamp(relativeX, 0, 1)
                    relativeY = math.clamp(relativeY, 0, 1)
                    
                    selectionDot.Position = UDim2.new(relativeX, 0, relativeY, 0)
                    updateColor(0.5, relativeX, 1 - relativeY)
                elseif hueDragging then
                    local relativeX = (input.Position.X - hueBar.AbsolutePosition.X) / hueBar.AbsoluteSize.X
                    relativeX = math.clamp(relativeX, 0, 1)
                    
                    hueSelection.Position = UDim2.new(relativeX, 0, 0.5, 0)
                    updateColor(relativeX, 0.5, 0.5)
                end
            end
        end)
    end
    
    pickerFrame.MouseButton1Click:Connect(function()
        colorPickerOpen = not colorPickerOpen
        if colorPickerOpen then
            createColorPicker()
        elseif colorPickerFrame then
            colorPickerFrame:Destroy()
            colorPickerFrame = nil
        end
    end)
    
    -- 悬停效果
    pickerFrame.MouseEnter:Connect(function()
        TweenService:Create(pickerFrame, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(55, 55, 55)
        }):Play()
    end)
    
    pickerFrame.MouseLeave:Connect(function()
        TweenService:Create(pickerFrame, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        }):Play()
    end)
    
    -- 添加到元素列表
    table.insert(tab.elements, {
        type = "ColorPicker",
        name = pickerName,
        color = defaultColor,
        object = pickerFrame
    })
    
    -- 更新标签页大小
    self:UpdateTabSize(tabName)
    
    return {
        Set = function(newColor)
            colorPreview.BackgroundColor3 = newColor
            if callback then
                local success, err = pcall(callback, newColor)
                if not success then
                    warn("颜色选择器回调错误: " .. err)
                end
            end
        end,
        Get = function()
            return colorPreview.BackgroundColor3
        end
    }
end

-- 添加按键绑定
function UILibrary:AddKeybind(tabName, keybindName, defaultKey, callback)
    local tab = self.tabs[tabName]
    if not tab then return end
    
    defaultKey = defaultKey or Enum.KeyCode.F
    
    local keybindFrame = Instance.new("Frame")
    keybindFrame.Name = keybindName .. "Keybind"
    keybindFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    keybindFrame.BorderSizePixel = 0
    keybindFrame.Size = UDim2.new(1, -20, 0, 40)
    keybindFrame.Parent = tab.frame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = keybindFrame
    
    -- 标签
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 15, 0, 0)
    label.Size = UDim2.new(0.7, -15, 1, 0)
    label.Font = DEFAULT_FONT
    label.Text = keybindName
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 16
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = keybindFrame
    
    -- 按键显示
    local keyDisplay = Instance.new("TextButton")
    keyDisplay.Name = "KeyDisplay"
    keyDisplay.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    keyDisplay.BorderSizePixel = 0
    keyDisplay.Position = UDim2.new(1, -100, 0.5, -12)
    keyDisplay.Size = UDim2.new(0, 80, 0, 24)
    keyDisplay.AnchorPoint = Vector2.new(1, 0.5)
    keyDisplay.Font = DEFAULT_FONT
    keyDisplay.Text = defaultKey.Name
    keyDisplay.TextColor3 = Color3.fromRGB(255, 255, 255)
    keyDisplay.TextSize = 14
    keyDisplay.Parent = keybindFrame
    
    local keyCorner = Instance.new("UICorner")
    keyCorner.CornerRadius = UDim.new(0, 6)
    keyCorner.Parent = keyDisplay
    
    -- 状态
    local listening = false
    local currentKey = defaultKey
    
    -- 按键监听
    local function startListening()
        listening = true
        keyDisplay.Text = "..."
        keyDisplay.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
        
        local connection
        connection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if not gameProcessed then
                if input.UserInputType == Enum.UserInputType.Keyboard then
                    currentKey = input.KeyCode
                    keyDisplay.Text = currentKey.Name
                    keyDisplay.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                    listening = false
                    connection:Disconnect()
                    
                    if callback then
                        local success, err = pcall(callback, currentKey)
                        if not success then
                            warn("按键绑定回调错误: " .. err)
                        end
                    end
                elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
                    currentKey = Enum.KeyCode.LeftControl
                    keyDisplay.Text = "LeftCtrl"
                    keyDisplay.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                    listening = false
                    connection:Disconnect()
                end
            end
        end)
    end
    
    -- 点击事件
    keyDisplay.MouseButton1Click:Connect(function()
        if not listening then
            startListening()
        end
    end)
    
    -- 全局按键检测
    table.insert(self.connections, UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and not listening then
            if input.KeyCode == currentKey then
                if callback then
                    local success, err = pcall(callback, currentKey)
                    if not success then
                        warn("按键绑定触发错误: " .. err)
                    end
                end
            end
        end
    end))
    
    -- 悬停效果
    keybindFrame.MouseEnter:Connect(function()
        TweenService:Create(keybindFrame, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(55, 55, 55)
        }):Play()
    end)
    
    keybindFrame.MouseLeave:Connect(function()
        TweenService:Create(keybindFrame, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        }):Play()
    end)
    
    -- 添加到元素列表
    table.insert(tab.elements, {
        type = "Keybind",
        name = keybindName,
        key = currentKey,
        object = keybindFrame
    })
    
    -- 更新标签页大小
    self:UpdateTabSize(tabName)
    
    return {
        Set = function(newKey)
            currentKey = newKey
            keyDisplay.Text = newKey.Name
        end,
        Get = function()
            return currentKey
        end
    }
end

-- 添加文本标签
function UILibrary:AddLabel(tabName, labelText)
    local tab = self.tabs[tabName]
    if not tab then return end
    
    local labelFrame = Instance.new("Frame")
    labelFrame.Name = "Label_" .. labelText
    labelFrame.BackgroundTransparency = 1
    labelFrame.Size = UDim2.new(1, -20, 0, 30)
    labelFrame.Parent = tab.frame
    
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1, 0, 1, 0)
    label.Font = DEFAULT_FONT
    label.Text = labelText
    label.TextColor3 = Color3.fromRGB(200, 200, 200)
    label.TextSize = 16
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = labelFrame
    
    -- 添加到元素列表
    table.insert(tab.elements, {
        type = "Label",
        name = labelText,
        object = labelFrame
    })
    
    -- 更新标签页大小
    self:UpdateTabSize(tabName)
    
    return labelFrame
end

-- 添加文本框
function UILibrary:AddTextBox(tabName, textBoxName, placeholder, callback)
    local tab = self.tabs[tabName]
    if not tab then return end
    
    local textBoxFrame = Instance.new("Frame")
    textBoxFrame.Name = textBoxName .. "TextBox"
    textBoxFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    textBoxFrame.BorderSizePixel = 0
    textBoxFrame.Size = UDim2.new(1, -20, 0, 40)
    textBoxFrame.Parent = tab.frame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = textBoxFrame
    
    -- 标签
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 15, 0, 0)
    label.Size = UDim2.new(0.3, -15, 1, 0)
    label.Font = DEFAULT_FONT
    label.Text = textBoxName
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 16
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = textBoxFrame
    
    -- 文本框
    local textBox = Instance.new("TextBox")
    textBox.Name = "TextBox"
    textBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    textBox.BorderSizePixel = 0
    textBox.Position = UDim2.new(0.35, 0, 0.5, -12)
    textBox.Size = UDim2.new(0.65, -20, 0, 24)
    textBox.AnchorPoint = Vector2.new(0, 0.5)
    textBox.Font = DEFAULT_FONT
    textBox.PlaceholderText = placeholder or "输入文本..."
    textBox.Text = ""
    textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    textBox.TextSize = 14
    textBox.TextXAlignment = Enum.TextXAlignment.Left
    textBox.Parent = textBoxFrame
    
    local textBoxCorner = Instance.new("UICorner")
    textBoxCorner.CornerRadius = UDim.new(0, 6)
    textBoxCorner.Parent = textBox
    
    -- 复制按钮
    local copyButton = Instance.new("TextButton")
    copyButton.Name = "CopyButton"
    copyButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    copyButton.BorderSizePixel = 0
    copyButton.Position = UDim2.new(1, -35, 0.5, -10)
    copyButton.Size = UDim2.new(0, 30, 0, 20)
    copyButton.AnchorPoint = Vector2.new(1, 0.5)
    copyButton.Font = DEFAULT_FONT
    copyButton.Text = "复制"
    copyButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    copyButton.TextSize = 12
    copyButton.Parent = textBoxFrame
    
    local copyCorner = Instance.new("UICorner")
    copyCorner.CornerRadius = UDim.new(0, 4)
    copyCorner.Parent = copyButton
    
    -- 事件
    textBox.FocusLost:Connect(function(enterPressed)
        if enterPressed and callback then
            local success, err = pcall(callback, textBox.Text)
            if not success then
                warn("文本框回调错误: " .. err)
            end
        end
    end)
    
    copyButton.MouseButton1Click:Connect(function()
        if textBox.Text ~= "" then
            setclipboard(tostring(textBox.Text))
        end
    end)
    
    -- 悬停效果
    textBoxFrame.MouseEnter:Connect(function()
        TweenService:Create(textBoxFrame, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(55, 55, 55)
        }):Play()
    end)
    
    textBoxFrame.MouseLeave:Connect(function()
        TweenService:Create(textBoxFrame, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        }):Play()
    end)
    
    copyButton.MouseEnter:Connect(function()
        TweenService:Create(copyButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        }):Play()
    end)
    
    copyButton.MouseLeave:Connect(function()
        TweenService:Create(copyButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        }):Play()
    end)
    
    -- 添加到元素列表
    table.insert(tab.elements, {
        type = "TextBox",
        name = textBoxName,
        object = textBoxFrame,
        textBox = textBox
    })
    
    -- 更新标签页大小
    self:UpdateTabSize(tabName)
    
    return {
        Set = function(text)
            textBox.Text = text
        end,
        Get = function()
            return textBox.Text
        end
    }
end

-- 添加彩虹控制选项
function UILibrary:AddRainbowControls(tabName)
    local tab = self.tabs[tabName]
    if not tab then return end
    
    -- 彩虹开关
    self:AddToggle(tabName, "彩虹边框", false, function(state)
        self.rainbowEnabled = state
    end)
    
    -- 彩虹速度滑块
    self:AddSlider(tabName, "彩虹速度", 0.1, 5, 1, function(value)
        self.rainbowSpeed = value
    end)
    
    -- 彩虹样式下拉菜单
    local rainbowStyles = {"Default", "Pulse", "Static"}
    
    local styleFrame = Instance.new("Frame")
    styleFrame.Name = "RainbowStyle"
    styleFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    styleFrame.BorderSizePixel = 0
    styleFrame.Size = UDim2.new(1, -20, 0, 40)
    styleFrame.Parent = tab.frame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = styleFrame
    
    -- 标签
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 15, 0, 0)
    label.Size = UDim2.new(0.7, -15, 1, 0)
    label.Font = DEFAULT_FONT
    label.Text = "彩虹样式: Default"
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 16
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = styleFrame
    
    -- 下拉箭头
    local arrow = Instance.new("TextLabel")
    arrow.Name = "Arrow"
    arrow.BackgroundTransparency = 1
    arrow.Position = UDim2.new(1, -30, 0, 0)
    arrow.Size = UDim2.new(0, 30, 1, 0)
    arrow.Font = DEFAULT_FONT
    arrow.Text = "▼"
    arrow.TextColor3 = Color3.fromRGB(200, 200, 200)
    arrow.TextSize = 14
    arrow.Parent = styleFrame
    
    -- 下拉菜单
    local dropdownOpen = false
    local dropdownFrame = nil
    
    local function createDropdown()
        if dropdownFrame then
            dropdownFrame:Destroy()
        end
        
        dropdownFrame = Instance.new("Frame")
        dropdownFrame.Name = "Dropdown"
        dropdownFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        dropdownFrame.BorderSizePixel = 0
        dropdownFrame.Position = UDim2.new(0, 0, 1, 5)
        dropdownFrame.Size = UDim2.new(1, 0, 0, #rainbowStyles * 30 + 10)
        dropdownFrame.Visible = true
        dropdownFrame.Parent = styleFrame
        
        local dropdownCorner = Instance.new("UICorner")
        dropdownCorner.CornerRadius = UDim.new(0, 6)
        dropdownCorner.Parent = dropdownFrame
        
        for i, style in ipairs(rainbowStyles) do
            local option = Instance.new("TextButton")
            option.Name = style
            option.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            option.BorderSizePixel = 0
            option.Position = UDim2.new(0, 5, 0, 5 + (i-1)*30)
            option.Size = UDim2.new(1, -10, 0, 25)
            option.Font = DEFAULT_FONT
            option.Text = style
            option.TextColor3 = Color3.fromRGB(255, 255, 255)
            option.TextSize = 14
            option.Parent = dropdownFrame
            
            local optionCorner = Instance.new("UICorner")
            optionCorner.CornerRadius = UDim.new(0, 4)
            optionCorner.Parent = option
            
            option.MouseButton1Click:Connect(function()
                self.rainbowStyle = style
                label.Text = "彩虹样式: " .. style
                dropdownOpen = false
                dropdownFrame:Destroy()
                dropdownFrame = nil
            end)
            
            option.MouseEnter:Connect(function()
                TweenService:Create(option, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(70, 70, 70)
                }):Play()
            end)
            
            option.MouseLeave:Connect(function()
                TweenService:Create(option, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                }):Play()
            end)
        end
    end
    
    styleFrame.MouseButton1Click:Connect(function()
        dropdownOpen = not dropdownOpen
        if dropdownOpen then
            createDropdown()
        elseif dropdownFrame then
            dropdownFrame:Destroy()
            dropdownFrame = nil
        end
    end)
    
    -- 悬停效果
    styleFrame.MouseEnter:Connect(function()
        TweenService:Create(styleFrame, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(55, 55, 55)
        }):Play()
    end)
    
    styleFrame.MouseLeave:Connect(function()
        TweenService:Create(styleFrame, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        }):Play()
    end)
    
    -- 添加到元素列表
    table.insert(tab.elements, {
        type = "RainbowStyle",
        name = "彩虹样式",
        object = styleFrame
    })
    
    -- 更新标签页大小
    self:UpdateTabSize(tabName)
end

-- 更新标签页大小
function UILibrary:UpdateTabSize(tabName)
    local tab = self.tabs[tabName]
    if not tab then return end
    
    local totalHeight = 0
    for _, element in ipairs(tab.elements) do
        totalHeight = totalHeight + element.object.Size.Y.Offset + 10
    end
    
    tab.frame.CanvasSize = UDim2.new(0, 0, 0, totalHeight)
end

-- 搜索功能
function UILibrary:Search(query)
    if query == "" or query == "搜索..." then
        -- 显示所有元素
        for _, tab in pairs(self.tabs) do
            for _, element in ipairs(tab.elements) do
                element.object.Visible = true
            end
            self:UpdateTabSize(tab.name)
        end
        return
    end
    
    query = string.lower(query)
    
    for _, tab in pairs(self.tabs) do
        local visibleCount = 0
        for _, element in ipairs(tab.elements) do
            if string.find(string.lower(element.name), query) then
                element.object.Visible = true
                visibleCount = visibleCount + 1
            else
                element.object.Visible = false
            end
        end
    end
end

-- 切换主题
function UILibrary:ToggleTheme()
    if self.currentTheme == "Dark" then
        self:SetTheme("Light")
        self.themeButton.Text = "亮色模式"
        self.currentTheme = "Light"
    else
        self:SetTheme("Dark")
        self.themeButton.Text = "暗色模式"
        self.currentTheme = "Dark"
    end
end

-- 设置主题
function UILibrary:SetTheme(theme)
    if theme == "Dark" then
        self.mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        self.titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        self.contentFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        self.bottomBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        self.divider.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        
        -- 更新所有元素颜色
        for _, tab in pairs(self.tabs) do
            for _, element in ipairs(tab.elements) do
                if element.type == "Button" or element.type == "Toggle" or 
                   element.type == "Slider" or element.type == "ColorPicker" or
                   element.type == "Keybind" or element.type == "TextBox" then
                    element.object.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                end
            end
        end
    else -- Light theme
        self.mainFrame.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
        self.titleBar.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
        self.contentFrame.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
        self.bottomBar.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
        self.divider.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
        
        self.titleLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
        self.userLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
        
        -- 更新所有元素颜色
        for _, tab in pairs(self.tabs) do
            for _, element in ipairs(tab.elements) do
                if element.type == "Button" or element.type == "Toggle" or 
                   element.type == "Slider" or element.type == "ColorPicker" or
                   element.type == "Keybind" or element.type == "TextBox" then
                    element.object.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                    
                    -- 更新文本颜色
                    for _, child in ipairs(element.object:GetChildren()) do
                        if child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("TextBox") then
                            child.TextColor3 = Color3.fromRGB(0, 0, 0)
                        end
                    end
                elseif element.type == "Label" then
                    for _, child in ipairs(element.object:GetChildren()) do
                        if child:IsA("TextLabel") then
                            child.TextColor3 = Color3.fromRGB(0, 0, 0)
                        end
                    end
                end
            end
        end
    end
end

-- 最小化
function UILibrary:Minimize()
    if self.isVisible then
        TweenService:Create(self.mainFrame, TweenInfo.new(0.3), {
            Size = UDim2.new(0, 600, 0, 40)
        }):Play()
        self.contentFrame.Visible = false
        self.bottomBar.Visible = false
        self.isVisible = false
    else
        TweenService:Create(self.mainFrame, TweenInfo.new(0.3), {
            Size = UDim2.new(0, 600, 0, 400)
        }):Play()
        self.contentFrame.Visible = true
        self.bottomBar.Visible = true
        self.isVisible = true
    end
end

-- 切换UI显示
function UILibrary:ToggleUI()
    if self.mainFrame.Visible then
        self:HideUI()
    else
        self:ShowUI()
    end
end

-- 显示UI
function UILibrary:ShowUI()
    self.mainFrame.Visible = true
    self.toggleButton.Visible = false
end

-- 隐藏UI
function UILibrary:HideUI()
    self.mainFrame.Visible = false
    self.toggleButton.Visible = true
    self.closeDialog.Visible = false
end

-- 设置可拖动
function UILibrary:MakeDraggable(dragFrame, targetFrame)
    local dragging = false
    local dragInput
    local dragStart
    local startPos
    
    local function update(input)
        local delta = input.Position - dragStart
        targetFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, 
                                         startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
    dragFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = targetFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    dragFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

-- 销毁UI
function UILibrary:Destroy()
    -- 断开所有连接
    for _, connection in ipairs(self.connections) do
        connection:Disconnect()
    end
    
    if self.rainbowConnection then
        self.rainbowConnection:Disconnect()
    end
    
    -- 销毁UI
    self.screenGui:Destroy()
    
    -- 清理引用
    setmetatable(self, nil)
    for k in pairs(self) do
        self[k] = nil
    end
end

-- 设置父级
function UILibrary:SetParent(parent)
    self.screenGui.Parent = parent or game.CoreGui
end

-- 示例使用代码
local function ExampleUsage()
    -- 创建UI库实例
    local UI = UILibrary.new()
    UI:SetParent(game.CoreGui)
    
    -- 创建标签页
    UI:CreateTab("主要")
    UI:CreateTab("视觉")
    UI:CreateTab("设置")
    
    -- 主要标签页
    UI:AddButton("主要", "测试按钮", function()
        print("按钮被点击了!")
    end)
    
    UI:AddToggle("主要", "启用功能", false, function(state)
        print("功能状态:", state)
    end)
    
    UI:AddSlider("主要", "音量控制", 0, 100, 50, function(value)
        print("音量设置为:", value)
    end)
    
    UI:AddLabel("主要", "这是一个文本标签")
    
    UI:AddTextBox("主要", "脚本输入", "输入脚本代码...", function(text)
        local success, err = pcall(loadstring(text))
        if not success then
            warn("脚本执行错误:", err)
        end
    end)
    
    -- 视觉标签页
    UI:AddToggle("视觉", "透视", false, function(state)
        print("透视:", state)
    end)
    
    UI:AddColorPicker("视觉", "界面颜色", Color3.fromRGB(0, 120, 255), function(color)
        print("颜色选择:", color)
    end)
    
    UI:AddKeybind("视觉", "飞行按键", Enum.KeyCode.F, function(key)
        print("飞行键按下:", key.Name)
    end)
    
    -- 设置标签页
    UI:AddRainbowControls("设置")
    
    UI:AddButton("设置", "保存配置", function()
        print("配置已保存")
    end)
    
    UI:AddButton("设置", "重置配置", function()
        print("配置已重置")
    end)
    
    -- 添加更多示例功能...
    UI:AddToggle("设置", "显示FPS", true, function(state)
        print("显示FPS:", state)
    end)
    
    UI:AddSlider("设置", "UI透明度", 0.5, 1, 1, function(value)
        UI.mainFrame.BackgroundTransparency = 1 - value
    end)
    
    return UI
end

-- 导出库
return {
    Library = UILibrary,
    Example = ExampleUsage
}
