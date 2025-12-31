-- 等待游戏加载
repeat task.wait() until game:IsLoaded()

-- 初始化UI库
local library = {}
local ToggleUI = false
library.currentTab = nil
library.flags = {}

-- 获取服务
local services = setmetatable({}, {
    __index = function(t, k)
        return game:GetService(k)
    end
})

-- 获取鼠标
local Players = game:GetService("Players")
local mouse = Players.LocalPlayer:GetMouse()

-- 缓动函数
function Tween(obj, t, data)
    services.TweenService:Create(obj, TweenInfo.new(t[1], Enum.EasingStyle[t[2]], Enum.EasingDirection[t[3]]), data):Play()
    return true
end

-- 波纹效果
function Ripple(obj)
    spawn(function()
        if obj.ClipsDescendants ~= true then
            obj.ClipsDescendants = true
        end
        
        local Ripple = Instance.new("ImageLabel")
        Ripple.Name = "Ripple"
        Ripple.Parent = obj
        Ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Ripple.BackgroundTransparency = 1.000
        Ripple.ZIndex = 8
        Ripple.Image = "rbxassetid://2708891598"
        Ripple.ImageTransparency = 0.800
        Ripple.ScaleType = Enum.ScaleType.Fit
        Ripple.ImageColor3 = Color3.fromRGB(200, 200, 200)
        Ripple.Position = UDim2.new(
            (mouse.X - Ripple.AbsolutePosition.X) / obj.AbsoluteSize.X, 0,
            (mouse.Y - Ripple.AbsolutePosition.Y) / obj.AbsoluteSize.Y, 0
        )
        
        Tween(Ripple, {.3, "Linear", "InOut"}, {
            Position = UDim2.new(-5.5, 0, -5.5, 0),
            Size = UDim2.new(12, 0, 12, 0)
        })
        
        wait(0.15)
        Tween(Ripple, {.3, "Linear", "InOut"}, {ImageTransparency = 1})
        wait(.3)
        Ripple:Destroy()
    end)
end

-- 标签切换
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

-- 拖动函数
function drag(frame, hold)
    if not hold then hold = frame end
    local dragging, dragInput, dragStart, startPos
    
    local function update(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
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

-- 主库函数
function library.new(library, name, theme)
    -- 清理旧的UI
    for _, v in next, services.CoreGui:GetChildren() do
        if v.Name == "SunkunScriptUI" then
            v:Destroy()
        end
    end
    
    -- 主题颜色设置 (透明灰色风格)
    local MainColor = Color3.fromRGB(60, 60, 70)
    local Background = Color3.fromRGB(40, 40, 50)
    local zyColor = Color3.fromRGB(50, 50, 60)
    local beijingColor = Color3.fromRGB(200, 200, 210)
    local AccentColor = Color3.fromRGB(100, 150, 255)
    
    -- 创建UI实例
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
    local Open = Instance.new("TextButton")
    local DropShadowHolder = Instance.new("Frame")
    local DropShadow = Instance.new("ImageLabel")
    local UICornerMain = Instance.new("UICorner")
    local TitleGlow = Instance.new("UIGradient")
    
    -- 保护GUI
    if syn and syn.protect_gui then
        syn.protect_gui(dogent)
    end
    
    dogent.Name = "SunkunScriptUI"
    dogent.Parent = services.CoreGui
    
    -- UI销毁函数
    function UiDestroy()
        dogent:Destroy()
    end
    
    -- 切换UI显示
    function ToggleUILib()
        ToggleUI = not ToggleUI
        dogent.Enabled = ToggleUI
    end
    
    -- 创建主窗口
    Main.Name = "Main"
    Main.Parent = dogent
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    Main.BackgroundTransparency = 0.1
    Main.Position = UDim2.new(0.5, 0, 0.5, 0)
    Main.Size = UDim2.new(0, 600, 0, 400)
    Main.ZIndex = 1
    Main.Active = true
    
    -- 主窗口圆角
    UICornerMain.Parent = Main
    UICornerMain.CornerRadius = UDim.new(0, 8)
    
    -- 阴影效果
    DropShadowHolder.Name = "DropShadowHolder"
    DropShadowHolder.Parent = Main
    DropShadowHolder.BackgroundTransparency = 1.000
    DropShadowHolder.BorderSizePixel = 0
    DropShadowHolder.Size = UDim2.new(1, 0, 1, 0)
    DropShadowHolder.ZIndex = 0
    
    DropShadow.Name = "DropShadow"
    DropShadow.Parent = DropShadowHolder
    DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
    DropShadow.BackgroundTransparency = 1.000
    DropShadow.BorderSizePixel = 0
    DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    DropShadow.Size = UDim2.new(1, 24, 1, 24)
    DropShadow.ZIndex = 0
    DropShadow.Image = "rbxassetid://6015897843"
    DropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    DropShadow.ImageTransparency = 0.5
    DropShadow.ScaleType = Enum.ScaleType.Slice
    DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)
    
    -- 标签主区域
    TabMain.Name = "TabMain"
    TabMain.Parent = Main
    TabMain.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    TabMain.BackgroundTransparency = 0.1
    TabMain.Position = UDim2.new(0.2, 0, 0.1, 0)
    TabMain.Size = UDim2.new(0, 480, 0, 360)
    
    MainC.CornerRadius = UDim.new(0, 6)
    MainC.Name = "MainC"
    MainC.Parent = TabMain
    
    -- 侧边栏
    SB.Name = "SB"
    SB.Parent = Main
    SB.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    SB.BackgroundTransparency = 0.1
    SB.Size = UDim2.new(0, 120, 0, 400)
    
    SBC.CornerRadius = UDim.new(0, 8)
    SBC.Name = "SBC"
    SBC.Parent = SB
    
    -- 侧边栏渐变
    Side.Name = "Side"
    Side.Parent = SB
    Side.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    Side.BackgroundTransparency = 0.1
    Side.BorderSizePixel = 0
    Side.ClipsDescendants = true
    Side.Size = UDim2.new(1, 0, 1, 0)
    
    -- 标签按钮区域
    TabBtns.Name = "TabBtns"
    TabBtns.Parent = Side
    TabBtns.Active = true
    TabBtns.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabBtns.BackgroundTransparency = 1.000
    TabBtns.BorderSizePixel = 0
    TabBtns.Position = UDim2.new(0, 0, 0.15, 0)
    TabBtns.Size = UDim2.new(1, 0, 0.85, 0)
    TabBtns.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabBtns.ScrollBarThickness = 2
    TabBtns.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 110)
    
    TabBtnsL.Name = "TabBtnsL"
    TabBtnsL.Parent = TabBtns
    TabBtnsL.SortOrder = Enum.SortOrder.LayoutOrder
    TabBtnsL.Padding = UDim.new(0, 8)
    
    -- 脚本标题 (闪烁效果)
    ScriptTitle.Name = "ScriptTitle"
    ScriptTitle.Parent = Side
    ScriptTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ScriptTitle.BackgroundTransparency = 1.000
    ScriptTitle.Position = UDim2.new(0.1, 0, 0.02, 0)
    ScriptTitle.Size = UDim2.new(0.8, 0, 0.1, 0)
    ScriptTitle.Font = Enum.Font.GothamSemibold
    ScriptTitle.Text = "Sunkun脚本"
    ScriptTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    ScriptTitle.TextSize = 16
    ScriptTitle.TextStrokeTransparency = 0.7
    ScriptTitle.TextStrokeColor3 = Color3.fromRGB(100, 150, 255)
    
    -- 标题闪烁渐变
    TitleGlow.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 150, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(150, 200, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 150, 255))
    })
    TitleGlow.Rotation = 0
    TitleGlow.Parent = ScriptTitle
    
    -- 标题闪烁动画
    spawn(function()
        while true do
            for i = 0, 1, 0.05 do
                TitleGlow.Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 1-i),
                    NumberSequenceKeypoint.new(0.5, 0.5-i*0.5),
                    NumberSequenceKeypoint.new(1, 1-i)
                })
                wait(0.05)
            end
            for i = 1, 0, -0.05 do
                TitleGlow.Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 1-i),
                    NumberSequenceKeypoint.new(0.5, 0.5-i*0.5),
                    NumberSequenceKeypoint.new(1, 1-i)
                })
                wait(0.05)
            end
        end
    end)
    
    -- 打开/关闭按钮
    Open.Name = "Open"
    Open.Parent = dogent
    Open.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    Open.BackgroundTransparency = 0.2
    Open.Position = UDim2.new(0, 10, 0.5, 0)
    Open.Size = UDim2.new(0, 80, 0, 30)
    Open.Font = Enum.Font.Gotham
    Open.Text = "孙坤脚本"
    Open.TextColor3 = Color3.fromRGB(220, 220, 220)
    Open.TextSize = 14
    Open.ZIndex = 100
    
    -- 按钮样式
    local OpenCorner = Instance.new("UICorner")
    OpenCorner.CornerRadius = UDim.new(0, 6)
    OpenCorner.Parent = Open
    
    local OpenStroke = Instance.new("UIStroke")
    OpenStroke.Parent = Open
    OpenStroke.Color = Color3.fromRGB(100, 150, 255)
    OpenStroke.Thickness = 1
    OpenStroke.Transparency = 0.5
    
    -- 标签按钮大小变化
    TabBtnsL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        TabBtns.CanvasSize = UDim2.new(0, 0, 0, TabBtnsL.AbsoluteContentSize.Y + 20)
    end)
    
    -- 打开/关闭按钮点击事件
    local uihide = false
    Open.MouseButton1Click:Connect(function()
        if uihide == false then
            uihide = true
            Main:TweenPosition(UDim2.new(0.5, 0, 2, 0), "Out", "Sine", 0.5, true)
            wait(0.5)
            Main.Visible = false
        else
            Main.Visible = true
            Main:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Sine", 0.5, true)
            wait(0.5)
            uihide = false
        end
    end)
    
    -- 初始动画
    wait(0.1)
    Main:TweenPosition(UDim2.new(0.5, 0, 2, 0), "Out", "Sine", 0.7, true)
    wait(0.5)
    Main:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Sine", 0.5, true)
    
    -- 使窗口可拖动
    drag(Main)
    
    local window = {}
    
    -- 创建标签页函数
    function window.Tab(window, name, icon)
        local Tab = Instance.new("ScrollingFrame")
        local TabIco = Instance.new("ImageLabel")
        local TabText = Instance.new("TextLabel")
        local TabBtn = Instance.new("TextButton")
        local TabL = Instance.new("UIListLayout")
        
        -- 标签内容区域
        Tab.Name = "Tab"
        Tab.Parent = TabMain
        Tab.Active = true
        Tab.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
        Tab.BackgroundTransparency = 0.1
        Tab.Size = UDim2.new(1, 0, 1, 0)
        Tab.ScrollBarThickness = 3
        Tab.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 110)
        Tab.Visible = false
        
        -- 标签图标
        TabIco.Name = "TabIco"
        TabIco.Parent = TabBtns
        TabIco.BackgroundTransparency = 1.000
        TabIco.BorderSizePixel = 0
        TabIco.Size = UDim2.new(0, 28, 0, 28)
        TabIco.Image = ("rbxassetid://%s"):format((icon or 7734068321))
        TabIco.ImageTransparency = 0.3
        
        -- 标签文本
        TabText.Name = "TabText"
        TabText.Parent = TabIco
        TabText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabText.BackgroundTransparency = 1.000
        TabText.Position = UDim2.new(1.2, 0, 0, 0)
        TabText.Size = UDim2.new(0, 80, 0, 28)
        TabText.Font = Enum.Font.GothamSemibold
        TabText.Text = name
        TabText.TextColor3 = Color3.fromRGB(220, 220, 220)
        TabText.TextSize = 14
        TabText.TextXAlignment = Enum.TextXAlignment.Left
        TabText.TextTransparency = 0.3
        
        -- 标签按钮
        TabBtn.Name = "TabBtn"
        TabBtn.Parent = TabIco
        TabBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabBtn.BackgroundTransparency = 1.000
        TabBtn.BorderSizePixel = 0
        TabBtn.Size = UDim2.new(0, 120, 0, 28)
        TabBtn.AutoButtonColor = false
        TabBtn.Font = Enum.Font.SourceSans
        TabBtn.Text = ""
        
        -- 标签布局
        TabL.Name = "TabL"
        TabL.Parent = Tab
        TabL.SortOrder = Enum.SortOrder.LayoutOrder
        TabL.Padding = UDim.new(0, 8)
        
        -- 标签点击事件
        TabBtn.MouseButton1Click:Connect(function()
            spawn(function()
                Ripple(TabBtn)
            end)
            switchTab({TabIco, Tab})
        end)
        
        -- 默认标签
        if library.currentTab == nil then
            switchTab({TabIco, Tab})
        end
        
        -- 标签内容大小变化
        TabL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            Tab.CanvasSize = UDim2.new(0, 0, 0, TabL.AbsoluteContentSize.Y + 20)
        end)
        
        local tab = {}
        
        -- 创建分区函数
        function tab.section(tab, name, TabVal)
            local Section = Instance.new("Frame")
            local SectionC = Instance.new("UICorner")
            local SectionText = Instance.new("TextLabel")
            local SectionOpen = Instance.new("ImageLabel")
            local SectionOpened = Instance.new("ImageLabel")
            local SectionToggle = Instance.new("ImageButton")
            local Objs = Instance.new("Frame")
            local ObjsL = Instance.new("UIListLayout")
            
            -- 分区框架
            Section.Name = "Section"
            Section.Parent = Tab
            Section.BackgroundColor3 = Color3.fromRGB(55, 55, 65)
            Section.BackgroundTransparency = 0.1
            Section.BorderSizePixel = 0
            Section.ClipsDescendants = true
            Section.Size = UDim2.new(0.98, 0, 0, 40)
            
            -- 分区圆角
            SectionC.CornerRadius = UDim.new(0, 8)
            SectionC.Name = "SectionC"
            SectionC.Parent = Section
            
            -- 分区文本
            SectionText.Name = "SectionText"
            SectionText.Parent = Section
            SectionText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SectionText.BackgroundTransparency = 1.000
            SectionText.Position = UDim2.new(0.05, 0, 0, 0)
            SectionText.Size = UDim2.new(0.9, 0, 0, 40)
            SectionText.Font = Enum.Font.GothamSemibold
            SectionText.Text = name
            SectionText.TextColor3 = Color3.fromRGB(220, 220, 220)
            SectionText.TextSize = 16
            SectionText.TextXAlignment = Enum.TextXAlignment.Left
            
            -- 分区展开按钮
            local open = TabVal or false
            SectionToggle.Name = "SectionToggle"
            SectionToggle.Parent = SectionText
            SectionToggle.BackgroundTransparency = 1
            SectionToggle.BorderSizePixel = 0
            SectionToggle.Position = UDim2.new(0.95, 0, 0.25, 0)
            SectionToggle.Size = UDim2.new(0, 20, 0, 20)
            SectionToggle.Image = open and "rbxassetid://6031091004" or "rbxassetid://6031091007"
            
            -- 内容区域
            Objs.Name = "Objs"
            Objs.Parent = Section
            Objs.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Objs.BackgroundTransparency = 1
            Objs.BorderSizePixel = 0
            Objs.Position = UDim2.new(0, 10, 0, 45)
            Objs.Size = UDim2.new(0.96, 0, 0, 0)
            
            ObjsL.Name = "ObjsL"
            ObjsL.Parent = Objs
            ObjsL.SortOrder = Enum.SortOrder.LayoutOrder
            ObjsL.Padding = UDim.new(0, 10)
            
            -- 初始状态
            if TabVal ~= false then
                Section.Size = UDim2.new(0.98, 0, 0, open and 50 + ObjsL.AbsoluteContentSize.Y + 10 or 40)
            end
            
            -- 切换展开状态
            SectionToggle.MouseButton1Click:Connect(function()
                open = not open
                Section.Size = UDim2.new(0.98, 0, 0, open and 50 + ObjsL.AbsoluteContentSize.Y + 10 or 40)
                SectionToggle.Image = open and "rbxassetid://6031091004" or "rbxassetid://6031091007"
                Tween(SectionToggle, {0.2, "Sine", "Out"}, {Rotation = open and 180 or 0})
            end)
            
            -- 内容大小变化
            ObjsL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                if not open then return end
                Section.Size = UDim2.new(0.98, 0, 0, 50 + ObjsL.AbsoluteContentSize.Y + 10)
            end)
            
            local section = {}
            
            -- 按钮样式1: 普通按钮
            function section.Button(section, text, callback)
                local callback = callback or function() end
                local BtnModule = Instance.new("Frame")
                local Btn = Instance.new("TextButton")
                local BtnC = Instance.new("UICorner")
                local BtnStroke = Instance.new("UIStroke")
                
                BtnModule.Name = "BtnModule"
                BtnModule.Parent = Objs
                BtnModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                BtnModule.BackgroundTransparency = 1.000
                BtnModule.BorderSizePixel = 0
                BtnModule.Size = UDim2.new(1, 0, 0, 40)
                
                Btn.Name = "Btn"
                Btn.Parent = BtnModule
                Btn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
                Btn.BackgroundTransparency = 0.1
                Btn.BorderSizePixel = 0
                Btn.Size = UDim2.new(1, 0, 0, 40)
                Btn.AutoButtonColor = false
                Btn.Font = Enum.Font.GothamSemibold
                Btn.Text = "  " .. text
                Btn.TextColor3 = Color3.fromRGB(220, 220, 220)
                Btn.TextSize = 14
                Btn.TextXAlignment = Enum.TextXAlignment.Left
                
                BtnC.CornerRadius = UDim.new(0, 8)
                BtnC.Name = "BtnC"
                BtnC.Parent = Btn
                
                BtnStroke.Parent = Btn
                BtnStroke.Color = Color3.fromRGB(100, 100, 110)
                BtnStroke.Thickness = 1
                
                -- 悬停效果
                Btn.MouseEnter:Connect(function()
                    Tween(Btn, {0.2, "Sine", "Out"}, {BackgroundColor3 = Color3.fromRGB(70, 70, 80)})
                end)
                
                Btn.MouseLeave:Connect(function()
                    Tween(Btn, {0.2, "Sine", "Out"}, {BackgroundColor3 = Color3.fromRGB(60, 60, 70)})
                end)
                
                -- 点击事件
                Btn.MouseButton1Click:Connect(function()
                    spawn(function()
                        Ripple(Btn)
                    end)
                    spawn(callback)
                end)
            end
            
            -- 按钮样式2: 彩色按钮
            function section.ColorButton(section, text, color, callback)
                local callback = callback or function() end
                local BtnModule = Instance.new("Frame")
                local Btn = Instance.new("TextButton")
                local BtnC = Instance.new("UICorner")
                
                BtnModule.Name = "ColorBtnModule"
                BtnModule.Parent = Objs
                BtnModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                BtnModule.BackgroundTransparency = 1.000
                BtnModule.BorderSizePixel = 0
                BtnModule.Size = UDim2.new(1, 0, 0, 40)
                
                Btn.Name = "ColorBtn"
                Btn.Parent = BtnModule
                Btn.BackgroundColor3 = color or Color3.fromRGB(100, 150, 255)
                Btn.BackgroundTransparency = 0.1
                Btn.BorderSizePixel = 0
                Btn.Size = UDim2.new(1, 0, 0, 40)
                Btn.AutoButtonColor = false
                Btn.Font = Enum.Font.GothamSemibold
                Btn.Text = "  " .. text
                Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                Btn.TextSize = 14
                Btn.TextXAlignment = Enum.TextXAlignment.Left
                
                BtnC.CornerRadius = UDim.new(0, 8)
                BtnC.Name = "BtnC"
                BtnC.Parent = Btn
                
                -- 悬停效果
                Btn.MouseEnter:Connect(function()
                    Tween(Btn, {0.2, "Sine", "Out"}, {BackgroundTransparency = 0})
                end)
                
                Btn.MouseLeave:Connect(function()
                    Tween(Btn, {0.2, "Sine", "Out"}, {BackgroundTransparency = 0.1})
                end)
                
                -- 点击事件
                Btn.MouseButton1Click:Connect(function()
                    spawn(function()
                        Ripple(Btn)
                    end)
                    spawn(callback)
                end)
            end
            
            -- 按钮样式3: 图标按钮
            function section.IconButton(section, text, icon, callback)
                local callback = callback or function() end
                local BtnModule = Instance.new("Frame")
                local Btn = Instance.new("TextButton")
                local BtnC = Instance.new("UICorner")
                local BtnIcon = Instance.new("ImageLabel")
                
                BtnModule.Name = "IconBtnModule"
                BtnModule.Parent = Objs
                BtnModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                BtnModule.BackgroundTransparency = 1.000
                BtnModule.BorderSizePixel = 0
                BtnModule.Size = UDim2.new(1, 0, 0, 40)
                
                Btn.Name = "IconBtn"
                Btn.Parent = BtnModule
                Btn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
                Btn.BackgroundTransparency = 0.1
                Btn.BorderSizePixel = 0
                Btn.Size = UDim2.new(1, 0, 0, 40)
                Btn.AutoButtonColor = false
                Btn.Font = Enum.Font.GothamSemibold
                Btn.Text = ""
                Btn.TextColor3 = Color3.fromRGB(220, 220, 220)
                Btn.TextSize = 14
                
                BtnC.CornerRadius = UDim.new(0, 8)
                BtnC.Name = "BtnC"
                BtnC.Parent = Btn
                
                BtnIcon.Name = "BtnIcon"
                BtnIcon.Parent = Btn
                BtnIcon.BackgroundTransparency = 1
                BtnIcon.Position = UDim2.new(0.05, 0, 0.2, 0)
                BtnIcon.Size = UDim2.new(0, 25, 0, 25)
                BtnIcon.Image = icon or "rbxassetid://6031094670"
                BtnIcon.ImageColor3 = Color3.fromRGB(200, 200, 210)
                
                local TextLabel = Instance.new("TextLabel")
                TextLabel.Parent = Btn
                TextLabel.BackgroundTransparency = 1
                TextLabel.Position = UDim2.new(0.15, 0, 0, 0)
                TextLabel.Size = UDim2.new(0.8, 0, 1, 0)
                TextLabel.Font = Enum.Font.GothamSemibold
                TextLabel.Text = text
                TextLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
                TextLabel.TextSize = 14
                TextLabel.TextXAlignment = Enum.TextXAlignment.Left
                
                -- 悬停效果
                Btn.MouseEnter:Connect(function()
                    Tween(Btn, {0.2, "Sine", "Out"}, {BackgroundColor3 = Color3.fromRGB(70, 70, 80)})
                    Tween(BtnIcon, {0.2, "Sine", "Out"}, {ImageColor3 = Color3.fromRGB(100, 150, 255)})
                end)
                
                Btn.MouseLeave:Connect(function()
                    Tween(Btn, {0.2, "Sine", "Out"}, {BackgroundColor3 = Color3.fromRGB(60, 60, 70)})
                    Tween(BtnIcon, {0.2, "Sine", "Out"}, {ImageColor3 = Color3.fromRGB(200, 200, 210)})
                end)
                
                -- 点击事件
                Btn.MouseButton1Click:Connect(function()
                    spawn(function()
                        Ripple(Btn)
                    end)
                    spawn(callback)
                end)
            end
            
            -- 标签
            function section:Label(text)
                local LabelModule = Instance.new("Frame")
                local TextLabel = Instance.new("TextLabel")
                local LabelC = Instance.new("UICorner")
                
                LabelModule.Name = "LabelModule"
                LabelModule.Parent = Objs
                LabelModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                LabelModule.BackgroundTransparency = 1.000
                LabelModule.BorderSizePixel = 0
                LabelModule.Size = UDim2.new(1, 0, 0, 25)
                
                TextLabel.Parent = LabelModule
                TextLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
                TextLabel.BackgroundTransparency = 0.1
                TextLabel.Size = UDim2.new(1, 0, 0, 25)
                TextLabel.Font = Enum.Font.GothamSemibold
                TextLabel.Text = text
                TextLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
                TextLabel.TextSize = 14
                
                LabelC.CornerRadius = UDim.new(0, 6)
                LabelC.Name = "LabelC"
                LabelC.Parent = TextLabel
                
                return TextLabel
            end
            
            -- 开关
            function section.Toggle(section, text, flag, enabled, callback)
                local callback = callback or function() end
                local enabled = enabled or false
                assert(text, "No text provided")
                assert(flag, "No flag provided")
                
                library.flags[flag] = enabled
                
                local ToggleModule = Instance.new("Frame")
                local ToggleBtn = Instance.new("TextButton")
                local ToggleBtnC = Instance.new("UICorner")
                local ToggleSwitch = Instance.new("Frame")
                local ToggleSwitchC = Instance.new("UICorner")
                
                ToggleModule.Name = "ToggleModule"
                ToggleModule.Parent = Objs
                ToggleModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ToggleModule.BackgroundTransparency = 1.000
                ToggleModule.BorderSizePixel = 0
                ToggleModule.Size = UDim2.new(1, 0, 0, 40)
                
                ToggleBtn.Name = "ToggleBtn"
                ToggleBtn.Parent = ToggleModule
                ToggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
                ToggleBtn.BackgroundTransparency = 0.1
                ToggleBtn.BorderSizePixel = 0
                ToggleBtn.Size = UDim2.new(1, 0, 0, 40)
                ToggleBtn.AutoButtonColor = false
                ToggleBtn.Font = Enum.Font.GothamSemibold
                ToggleBtn.Text = "  " .. text
                ToggleBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
                ToggleBtn.TextSize = 14
                ToggleBtn.TextXAlignment = Enum.TextXAlignment.Left
                
                ToggleBtnC.CornerRadius = UDim.new(0, 8)
                ToggleBtnC.Name = "ToggleBtnC"
                ToggleBtnC.Parent = ToggleBtn
                
                ToggleSwitch.Name = "ToggleSwitch"
                ToggleSwitch.Parent = ToggleBtn
                ToggleSwitch.BackgroundColor3 = enabled and Color3.fromRGB(100, 150, 255) or Color3.fromRGB(80, 80, 90)
                ToggleSwitch.BorderSizePixel = 0
                ToggleSwitch.Position = UDim2.new(0.85, 0, 0.25, 0)
                ToggleSwitch.Size = UDim2.new(0, 40, 0, 20)
                
                ToggleSwitchC.CornerRadius = UDim.new(0, 10)
                ToggleSwitchC.Name = "ToggleSwitchC"
                ToggleSwitchC.Parent = ToggleSwitch
                
                local SwitchCircle = Instance.new("Frame")
                SwitchCircle.Name = "SwitchCircle"
                SwitchCircle.Parent = ToggleSwitch
                SwitchCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SwitchCircle.BorderSizePixel = 0
                SwitchCircle.Size = UDim2.new(0, 16, 0, 16)
                SwitchCircle.Position = enabled and UDim2.new(0.6, 0, 0.1, 0) or UDim2.new(0.1, 0, 0.1, 0)
                
                local SwitchCircleC = Instance.new("UICorner")
                SwitchCircleC.CornerRadius = UDim.new(1, 0)
                SwitchCircleC.Parent = SwitchCircle
                
                local funcs = {
                    SetState = function(self, state)
                        if state == nil then
                            state = not library.flags[flag]
                        end
                        
                        if library.flags[flag] == state then
                            return
                        end
                        
                        library.flags[flag] = state
                        
                        Tween(SwitchCircle, {0.2, "Sine", "Out"}, {
                            Position = state and UDim2.new(0.6, 0, 0.1, 0) or UDim2.new(0.1, 0, 0.1, 0)
                        })
                        
                        Tween(ToggleSwitch, {0.2, "Sine", "Out"}, {
                            BackgroundColor3 = state and Color3.fromRGB(100, 150, 255) or Color3.fromRGB(80, 80, 90)
                        })
                        
                        callback(state)
                    end,
                    Module = ToggleModule
                }
                
                -- 悬停效果
                ToggleBtn.MouseEnter:Connect(function()
                    Tween(ToggleBtn, {0.2, "Sine", "Out"}, {BackgroundColor3 = Color3.fromRGB(70, 70, 80)})
                end)
                
                ToggleBtn.MouseLeave:Connect(function()
                    Tween(ToggleBtn, {0.2, "Sine", "Out"}, {BackgroundColor3 = Color3.fromRGB(60, 60, 70)})
                end)
                
                -- 点击切换
                ToggleBtn.MouseButton1Click:Connect(function()
                    spawn(function()
                        Ripple(ToggleBtn)
                    end)
                    funcs:SetState()
                end)
                
                return funcs
            end
            
            -- 滑动条
            function section.Slider(section, text, flag, default, min, max, precise, callback)
                local callback = callback or function() end
                local min = min or 0
                local max = max or 100
                local default = default or min
                local precise = precise or false
                
                library.flags[flag] = default
                assert(text, "No text provided")
                assert(flag, "No flag provided")
                assert(default, "No default value provided")
                
                local SliderModule = Instance.new("Frame")
                local SliderBack = Instance.new("TextButton")
                local SliderBackC = Instance.new("UICorner")
                local SliderBar = Instance.new("Frame")
                local SliderBarC = Instance.new("UICorner")
                local SliderFill = Instance.new("Frame")
                local SliderFillC = Instance.new("UICorner")
                local SliderValue = Instance.new("TextLabel")
                
                SliderModule.Name = "SliderModule"
                SliderModule.Parent = Objs
                SliderModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SliderModule.BackgroundTransparency = 1.000
                SliderModule.BorderSizePixel = 0
                SliderModule.Size = UDim2.new(1, 0, 0, 60)
                
                SliderBack.Name = "SliderBack"
                SliderBack.Parent = SliderModule
                SliderBack.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
                SliderBack.BackgroundTransparency = 0.1
                SliderBack.BorderSizePixel = 0
                SliderBack.Size = UDim2.new(1, 0, 0, 60)
                SliderBack.AutoButtonColor = false
                SliderBack.Font = Enum.Font.GothamSemibold
                SliderBack.Text = ""
                
                SliderBackC.CornerRadius = UDim.new(0, 8)
                SliderBackC.Name = "SliderBackC"
                SliderBackC.Parent = SliderBack
                
                -- 滑动条背景
                SliderBar.Name = "SliderBar"
                SliderBar.Parent = SliderBack
                SliderBar.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
                SliderBar.BorderSizePixel = 0
                SliderBar.Position = UDim2.new(0.05, 0, 0.6, 0)
                SliderBar.Size = UDim2.new(0.9, 0, 0, 6)
                
                SliderBarC.CornerRadius = UDim.new(1, 0)
                SliderBarC.Name = "SliderBarC"
                SliderBarC.Parent = SliderBar
                
                -- 滑动条填充
                SliderFill.Name = "SliderFill"
                SliderFill.Parent = SliderBar
                SliderFill.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
                SliderFill.BorderSizePixel = 0
                SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
                
                SliderFillC.CornerRadius = UDim.new(1, 0)
                SliderFillC.Name = "SliderFillC"
                SliderFillC.Parent = SliderFill
                
                -- 滑块
                local SliderHandle = Instance.new("Frame")
                SliderHandle.Name = "SliderHandle"
                SliderHandle.Parent = SliderBar
                SliderHandle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SliderHandle.BorderSizePixel = 0
                SliderHandle.Size = UDim2.new(0, 16, 0, 16)
                SliderHandle.Position = UDim2.new((default - min) / (max - min), -8, 0.5, -8)
                
                local SliderHandleC = Instance.new("UICorner")
                SliderHandleC.CornerRadius = UDim.new(1, 0)
                SliderHandleC.Parent = SliderHandle
                
                -- 数值显示
                SliderValue.Name = "SliderValue"
                SliderValue.Parent = SliderBack
                SliderValue.BackgroundTransparency = 1
                SliderValue.Position = UDim2.new(0.05, 0, 0.1, 0)
                SliderValue.Size = UDim2.new(0.9, 0, 0, 20)
                SliderValue.Font = Enum.Font.GothamSemibold
                SliderValue.Text = text .. ": " .. tostring(default)
                SliderValue.TextColor3 = Color3.fromRGB(220, 220, 220)
                SliderValue.TextSize = 14
                SliderValue.TextXAlignment = Enum.TextXAlignment.Left
                
                local dragging = false
                local funcs = {}
                
                funcs.SetValue = function(self, value)
                    local percent
                    if value then
                        percent = (value - min) / (max - min)
                    else
                        local mousePos = services.UserInputService:GetMouseLocation()
                        local barPos = SliderBar.AbsolutePosition
                        local barSize = SliderBar.AbsoluteSize
                        percent = math.clamp((mousePos.X - barPos.X) / barSize.X, 0, 1)
                    end
                    
                    percent = math.clamp(percent, 0, 1)
                    
                    if precise then
                        value = value or tonumber(string.format("%.2f", min + (max - min) * percent))
                    else
                        value = value or math.floor(min + (max - min) * percent)
                    end
                    
                    library.flags[flag] = value
                    SliderValue.Text = text .. ": " .. tostring(value)
                    SliderFill.Size = UDim2.new(percent, 0, 1, 0)
                    SliderHandle.Position = UDim2.new(percent, -8, 0.5, -8)
                    callback(value)
                end
                
                -- 鼠标事件
                SliderBar.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                        funcs:SetValue()
                    end
                end)
                
                services.UserInputService.InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        funcs:SetValue()
                    end
                end)
                
                services.UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end)
                
                -- 设置初始值
                funcs:SetValue(default)
                
                return funcs
            end
            
            -- 下拉框
            function section.Dropdown(section, text, flag, options, callback)
                local callback = callback or function() end
                local options = options or {}
                assert(text, "No text provided")
                assert(flag, "No flag provided")
                
                library.flags[flag] = nil
                
                local DropdownModule = Instance.new("Frame")
                local DropdownTop = Instance.new("TextButton")
                local DropdownTopC = Instance.new("UICorner")
                local DropdownText = Instance.new("TextLabel")
                local DropdownArrow = Instance.new("ImageLabel")
                local DropdownList = Instance.new("ScrollingFrame")
                local DropdownListL = Instance.new("UIListLayout")
                
                DropdownModule.Name = "DropdownModule"
                DropdownModule.Parent = Objs
                DropdownModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropdownModule.BackgroundTransparency = 1.000
                DropdownModule.BorderSizePixel = 0
                DropdownModule.ClipsDescendants = true
                DropdownModule.Size = UDim2.new(1, 0, 0, 40)
                
                DropdownTop.Name = "DropdownTop"
                DropdownTop.Parent = DropdownModule
                DropdownTop.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
                DropdownTop.BackgroundTransparency = 0.1
                DropdownTop.BorderSizePixel = 0
                DropdownTop.Size = UDim2.new(1, 0, 0, 40)
                DropdownTop.AutoButtonColor = false
                DropdownTop.Font = Enum.Font.GothamSemibold
                DropdownTop.Text = ""
                
                DropdownTopC.CornerRadius = UDim.new(0, 8)
                DropdownTopC.Name = "DropdownTopC"
                DropdownTopC.Parent = DropdownTop
                
                DropdownText.Name = "DropdownText"
                DropdownText.Parent = DropdownTop
                DropdownText.BackgroundTransparency = 1
                DropdownText.Position = UDim2.new(0.05, 0, 0, 0)
                DropdownText.Size = UDim2.new(0.8, 0, 1, 0)
                DropdownText.Font = Enum.Font.GothamSemibold
                DropdownText.Text = text
                DropdownText.TextColor3 = Color3.fromRGB(220, 220, 220)
                DropdownText.TextSize = 14
                DropdownText.TextXAlignment = Enum.TextXAlignment.Left
                
                DropdownArrow.Name = "DropdownArrow"
                DropdownArrow.Parent = DropdownTop
                DropdownArrow.BackgroundTransparency = 1
                DropdownArrow.Position = UDim2.new(0.9, 0, 0.25, 0)
                DropdownArrow.Size = UDim2.new(0, 20, 0, 20)
                DropdownArrow.Image = "rbxassetid://6031091007"
                DropdownArrow.ImageColor3 = Color3.fromRGB(200, 200, 210)
                
                DropdownList.Name = "DropdownList"
                DropdownList.Parent = DropdownTop
                DropdownList.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
                DropdownList.BackgroundTransparency = 0.1
                DropdownList.BorderSizePixel = 0
                DropdownList.Position = UDim2.new(0, 0, 1, 5)
                DropdownList.Size = UDim2.new(1, 0, 0, 0)
                DropdownList.CanvasSize = UDim2.new(0, 0, 0, 0)
                DropdownList.ScrollBarThickness = 2
                DropdownList.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 110)
                DropdownList.Visible = false
                
                DropdownListL.Name = "DropdownListL"
                DropdownListL.Parent = DropdownList
                DropdownListL.SortOrder = Enum.SortOrder.LayoutOrder
                
                local open = false
                local funcs = {}
                
                funcs.AddOption = function(self, option)
                    local Option = Instance.new("TextButton")
                    local OptionC = Instance.new("UICorner")
                    
                    Option.Name = "Option_" .. option
                    Option.Parent = DropdownList
                    Option.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
                    Option.BackgroundTransparency = 0.1
                    Option.BorderSizePixel = 0
                    Option.Size = UDim2.new(1, 0, 0, 30)
                    Option.AutoButtonColor = false
                    Option.Font = Enum.Font.GothamSemibold
                    Option.Text = option
                    Option.TextColor3 = Color3.fromRGB(220, 220, 220)
                    Option.TextSize = 14
                    
                    OptionC.CornerRadius = UDim.new(0, 4)
                    OptionC.Name = "OptionC"
                    OptionC.Parent = Option
                    
                    -- 悬停效果
                    Option.MouseEnter:Connect(function()
                        Tween(Option, {0.2, "Sine", "Out"}, {BackgroundColor3 = Color3.fromRGB(70, 70, 80)})
                    end)
                    
                    Option.MouseLeave:Connect(function()
                        Tween(Option, {0.2, "Sine", "Out"}, {BackgroundColor3 = Color3.fromRGB(60, 60, 70)})
                    end)
                    
                    -- 点击事件
                    Option.MouseButton1Click:Connect(function()
                        DropdownText.Text = text .. ": " .. option
                        library.flags[flag] = option
                        open = false
                        DropdownList.Visible = false
                        DropdownList.Size = UDim2.new(1, 0, 0, 0)
                        Tween(DropdownArrow, {0.2, "Sine", "Out"}, {Rotation = 0})
                        callback(option)
                    end)
                end
                
                funcs.RemoveOption = function(self, option)
                    local option = DropdownList:FindFirstChild("Option_" .. option)
                    if option then
                        option:Destroy()
                    end
                end
                
                funcs.SetOptions = function(self, options)
                    for _, v in next, DropdownList:GetChildren() do
                        if v.Name:match("Option_") then
                            v:Destroy()
                        end
                    end
                    
                    for _, v in next, options do
                        funcs:AddOption(v)
                    end
                end
                
                -- 切换下拉框
                DropdownTop.MouseButton1Click:Connect(function()
                    open = not open
                    DropdownList.Visible = open
                    
                    if open then
                        local height = math.min(#options * 35 + 10, 150)
                        DropdownList.Size = UDim2.new(1, 0, 0, height)
                        DropdownList.CanvasSize = UDim2.new(0, 0, 0, #options * 35)
                        Tween(DropdownArrow, {0.2, "Sine", "Out"}, {Rotation = 180})
                    else
                        DropdownList.Size = UDim2.new(1, 0, 0, 0)
                        Tween(DropdownArrow, {0.2, "Sine", "Out"}, {Rotation = 0})
                    end
                end)
                
                -- 设置初始选项
                funcs:SetOptions(options)
                
                return funcs
            end
            
            return section
        end
        
        return tab
    end
    
    return window
end

return library