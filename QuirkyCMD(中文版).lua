--翻译者:孙坤
--927072454主群
--请加入我们
-- Discord服务器（用于支持的游戏）：https://discord.gg/9w7R9HsBvJ -- 由Cynatica制作 -- QuirkyCMD最棒！
local cloneref = cloneref or function(a) return a end
local coreGui = cloneref(game:GetService("CoreGui"))
local players = cloneref(game:GetService("Players"))
local localPlayer = players.LocalPlayer

local function isElevatedStudioPlugin()
    local s, r = pcall(function()
        return coreGui:GetChildren()
    end)
    return s
end

local gethui = gethui or function()
    local folder
    if isElevatedStudioPlugin() then
        if coreGui:WaitForChild("RobloxGui"):FindFirstChild(".__gethui") then
            folder = coreGui:WaitForChild("RobloxGui"):FindFirstChild(".__gethui")
        else
            folder = Instance.new("Folder")
            folder.Name = '.__gethui'
            folder.Parent = coreGui:WaitForChild("RobloxGui")
        end
    else
        folder = localPlayer:WaitForChild'PlayerGui'
    end
    return folder
end

-- 实例：
local quirkyCMD = Instance.new("ScreenGui")
local main = Instance.new("Frame")
local menu = Instance.new("ImageButton")
local cmdBox = Instance.new("TextBox")
local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
local UICorner = Instance.new("UICorner")
local UICorner_2 = Instance.new("UICorner")
local remotepath = Instance.new("TextLabel")
local UICorner_3 = Instance.new("UICorner")
local mobileOpen = Instance.new("TextButton")
local UICorner_4 = Instance.new("UICorner")
local cmds = Instance.new("Frame")
local UICorner_5 = Instance.new("UICorner")
local closeButton = Instance.new("TextButton")
local UICorner_6 = Instance.new("UICorner")
local cmdList = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local template = Instance.new("TextLabel")
local UIGradient = Instance.new("UIGradient")
local UICorner_7 = Instance.new("UICorner")

-- 属性：
quirkyCMD.Name = "quirkyCMD"
quirkyCMD.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
quirkyCMD.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
quirkyCMD.ResetOnSpawn = false

main.Name = "main"
main.Parent = quirkyCMD
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
main.BorderColor3 = Color3.fromRGB(0, 0, 0)
main.BorderSizePixel = 0
main.Position = UDim2.new(0.5, 0, 0.5, 0)
main.Size = UDim2.new(0, 250, 0, 40)

menu.Name = "menu"
menu.Parent = main
menu.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
menu.BackgroundTransparency = 1.000
menu.BorderColor3 = Color3.fromRGB(0, 0, 0)
menu.BorderSizePixel = 0
menu.Position = UDim2.new(0.811999977, 0, 0.125, 0)
menu.Size = UDim2.new(0, 27, 0, 30)
menu.Image = "rbxassetid://73467005156187"
menu.ImageColor3 = Color3.fromRGB(153, 153, 153)

cmdBox.Name = "cmdBox"
cmdBox.Parent = main
cmdBox.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
cmdBox.BackgroundTransparency = 0.800
cmdBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
cmdBox.BorderSizePixel = 0
cmdBox.Position = UDim2.new(0.163999751, 0, 0, 0)
cmdBox.Size = UDim2.new(0.588, 0, 0.999999642, 0)
cmdBox.Font = Enum.Font.SourceSansBold
cmdBox.PlaceholderColor3 = Color3.fromRGB(103, 103, 103)
cmdBox.PlaceholderText = "QuirkyCMD已加载"
cmdBox.Text = ""
cmdBox.TextColor3 = Color3.fromRGB(103, 103, 103)
cmdBox.TextScaled = true
cmdBox.TextSize = 12.000
cmdBox.TextWrapped = true

UITextSizeConstraint.Parent = cmdBox
UITextSizeConstraint.MaxTextSize = 18

UICorner.CornerRadius = UDim.new(0, 20)
UICorner.Parent = cmdBox

UICorner_2.CornerRadius = UDim.new(0, 16)
UICorner_2.Parent = main

remotepath.Name = "remotepath"
remotepath.Parent = quirkyCMD
remotepath.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
remotepath.BackgroundTransparency = 0.600
remotepath.BorderColor3 = Color3.fromRGB(0, 0, 0)
remotepath.BorderSizePixel = 0
remotepath.Position = UDim2.new(0.395616412, 0, 0.249097273, 0)
remotepath.Size = UDim2.new(0.208000004, 0, 0.0439999998, 0)
remotepath.Text = ""
remotepath.TextColor3 = Color3.fromRGB(255, 255, 255)
remotepath.TextScaled = true
remotepath.TextSize = 14.000
remotepath.TextTransparency = 0.600
remotepath.TextWrapped = true

UICorner_3.CornerRadius = UDim.new(0.400000006, 0)
UICorner_3.Parent = remotepath

mobileOpen.Name = "mobileOpen"
mobileOpen.Parent = quirkyCMD
mobileOpen.AnchorPoint = Vector2.new(1, 0)
mobileOpen.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
mobileOpen.BorderColor3 = Color3.fromRGB(0, 0, 0)
mobileOpen.BorderSizePixel = 0
mobileOpen.Position = UDim2.new(0.999999821, 0, 0.293097287, 0)
mobileOpen.Selectable = false
mobileOpen.Size = UDim2.new(0.056456618, 0, 0.0343623683, 0)
mobileOpen.Visible = false
mobileOpen.Font = Enum.Font.SourceSansBold
mobileOpen.Text = "命令"
mobileOpen.TextColor3 = Color3.fromRGB(200, 200, 200)
mobileOpen.TextScaled = true
mobileOpen.TextSize = 14.000
mobileOpen.TextWrapped = true

UICorner_4.CornerRadius = UDim.new(1, 1)
UICorner_4.Parent = mobileOpen

cmds.Name = "cmds"
cmds.Parent = quirkyCMD
cmds.Active = true
cmds.AnchorPoint = Vector2.new(0.5, 0.5)
cmds.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
cmds.BorderColor3 = Color3.fromRGB(0, 0, 0)
cmds.BorderSizePixel = 0
cmds.Position = UDim2.new(0.5, 0, 0.5, 0)
cmds.Size = UDim2.new(0.0883912593, 0, 0.287559688, 0)
cmds.Visible = false

UICorner_5.CornerRadius = UDim.new(0, 16)
UICorner_5.Parent = cmds

closeButton.Name = "closeButton"
closeButton.Parent = cmds
closeButton.Active = false
closeButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
closeButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
closeButton.BorderSizePixel = 0
closeButton.Position = UDim2.new(0.306886673, 0, -7.849561e-08, 0)
closeButton.Size = UDim2.new(0.386227101, 0, 0.0566039979, 0)
closeButton.Font = Enum.Font.SourceSansBold
closeButton.Text = "关闭"
closeButton.TextColor3 = Color3.fromRGB(159, 159, 159)
closeButton.TextSize = 14.000
closeButton.TextWrapped = true

UICorner_6.CornerRadius = UDim.new(0.400000006, 0)
UICorner_6.Parent = closeButton

cmdList.Name = "cmdList"
cmdList.Parent = cmds
cmdList.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
cmdList.BorderColor3 = Color3.fromRGB(0, 0, 0)
cmdList.BorderSizePixel = 0
cmdList.Position = UDim2.new(0, 0, 0.0566038229, 0)
cmdList.Size = UDim2.new(0.999999881, 0, 0.943396211, 0)
cmdList.AutomaticCanvasSize = Enum.AutomaticSize.Y
cmdList.CanvasSize = UDim2.new()
cmdList.ScrollBarImageColor3 = Color3.fromRGB(200, 200, 200)

UIListLayout.Parent = cmdList
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

template.Name = "template"
template.Parent = cmdList
template.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
template.BackgroundTransparency = 1.000
template.BorderColor3 = Color3.fromRGB(0, 0, 0)
template.BorderSizePixel = 0
template.Position = UDim2.new(0, 0, 0.032717593, 0)
template.Size = UDim2.new(0.999999821, 0, 0.323825359, 0)
template.Font = Enum.Font.SourceSans
template.Text = "错误，请联系Cynatica。你可能执行了两次QuirkyCMD。"
template.TextColor3 = Color3.fromRGB(200, 200, 200)
template.TextScaled = true
template.TextSize = 14.000
template.TextWrapped = true

UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.58, Color3.fromRGB(229, 229, 229)), ColorSequenceKeypoint.new(0.78, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))}
UIGradient.Parent = template

UICorner_7.CornerRadius = UDim.new(0, 10)
UICorner_7.Parent = cmdList

-- 脚本：
local function JPZSSO_fake_script()
    local script = Instance.new('LocalScript', main)
    local gui = script.Parent
    gui.Active = true
    gui.Selectable = true
    local UserInputService = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")
    local dragging = false
    local dragStart
    local startPos
    local targetPos
    local dragSpeed = 8
    local function lerpVec2(a, b, t)
        return a:Lerp(b, t)
    end
    RunService.Heartbeat:Connect(function(dt)
        if not targetPos then return end
        local pos = gui.Position
        local newX = lerpVec2(Vector2.new(pos.X.Offset, 0), Vector2.new(targetPos.X.Offset, 0), dt * dragSpeed).X
        local newY = lerpVec2(Vector2.new(0, pos.Y.Offset), Vector2.new(0, targetPos.Y.Offset), dt * dragSpeed).Y
        gui.Position = UDim2.new(pos.X.Scale, newX, pos.Y.Scale, newY)
    end)
    local function startDrag(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = gui.Position
            local conn
            conn = input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                    conn:Disconnect()
                end
            end)
        end
    end
    gui.InputBegan:Connect(startDrag)
    for i, child in gui:GetChildren() do
        if child.Name == "menu" and child:IsA("ImageButton") then
            child.InputBegan:Connect(startDrag)
        end
    end
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            targetPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end
coroutine.wrap(JPZSSO_fake_script)()

local function CAHA_fake_script()
    local script = Instance.new('LocalScript', main)
    local frame = script.Parent
    local TweenService = game:GetService("TweenService")
    local originalSize = UDim2.new(0, 60, 0, 40)
    local expandedSize = UDim2.new(0, 250, 0, 40)
    frame.Size = originalSize
    local menu = frame:FindFirstChild("menu")
    local commandsBtn = nil
    if menu then
        local selection = menu:FindFirstChild("selection")
        if selection then
            commandsBtn = selection:FindFirstChild("commands")
        end
    end
    local cmdBox = frame:FindFirstChild("cmdBox")
    local cmdList = frame:FindFirstChild("cmdList")
    local template = cmdList and cmdList:FindFirstChild("template")
    local tweenTime = 0.45
    local outTweenTime = 0.45
    local easingStyle = Enum.EasingStyle.Quad
    local easingDir = Enum.EasingDirection.Out
    local cmdListOriginalPosition = cmdList and cmdList.Position
    local cmdListHiddenPosition = cmdListOriginalPosition and UDim2.new(cmdListOriginalPosition.X.Scale, cmdListOriginalPosition.X.Offset, cmdListOriginalPosition.Y.Scale + 1, cmdListOriginalPosition.Y.Offset)
    local cmdListOriginalTransparency = cmdList and cmdList.BackgroundTransparency or 0
    local templateOriginalPosition = template and template.Position
    local templateHiddenPosition = templateOriginalPosition and UDim2.new(templateOriginalPosition.X.Scale, templateOriginalPosition.X.Offset, templateOriginalPosition.Y.Scale + 1, templateOriginalPosition.Y.Offset)
    local templateOriginalTransparency = template and template.TextTransparency or 0
    local templateOriginalBGTransparency = template and template.BackgroundTransparency or 0
    local cmdBoxOriginalBG = cmdBox and (cmdBox.BackgroundTransparency or 0) or 0
    local cmdBoxOriginalText = cmdBox and (cmdBox.TextTransparency or 0) or 0
    if cmdBox then
        cmdBox.Visible = false
        cmdBox.BackgroundTransparency = 1
        cmdBox.TextTransparency = 1
    end
    if cmdList then
        if cmdListHiddenPosition then
            cmdList.Position = cmdListHiddenPosition
        end
        cmdList.Visible = false
        cmdList.BackgroundTransparency = 1
    end
    if template then
        if templateHiddenPosition then
            template.Position = templateHiddenPosition
        end
        template.Visible = false
        template.TextTransparency = 1
        template.BackgroundTransparency = 1
    end
    local cmdBoxBGtween, cmdBoxTextTween, frameTween, btnTween
    local cmdListTween, templateTween, templateBGTween
    local function cancelCmdBoxTweens()
        if cmdBoxBGtween then cmdBoxBGtween:Cancel() cmdBoxBGtween = nil end
        if cmdBoxTextTween then cmdBoxTextTween:Cancel() cmdBoxTextTween = nil end
    end
    local function cancelFrameTween()
        if frameTween then frameTween:Cancel() frameTween = nil end
    end
    local function cancelBtnTween()
        if btnTween then btnTween:Cancel() btnTween = nil end
    end
    local function cancelCmdListTween()
        if cmdListTween then cmdListTween:Cancel() cmdListTween = nil end
    end
    local function cancelTemplateTweens()
        if templateTween then templateTween:Cancel() templateTween = nil end
        if templateBGTween then templateBGTween:Cancel() templateBGTween = nil end
    end
    local function setChildrenVisibility(visible)
        for _, child in frame:GetChildren() do
            if child ~= menu and child ~= script and child:IsA("GuiObject") and child ~= cmdBox and child ~= cmdList then
                child.Visible = visible
            end
        end
    end
    local function tweenCmdBoxIn(onComplete)
        if not cmdBox then if onComplete then onComplete() end return end
        cancelCmdBoxTweens()
        cmdBox.Visible = true
        cmdBox.BackgroundTransparency = 1
        cmdBox.TextTransparency = 1
        local tweenInfo = TweenInfo.new(tweenTime, easingStyle, easingDir)
        cmdBoxBGtween = TweenService:Create(cmdBox, tweenInfo, {BackgroundTransparency = cmdBoxOriginalBG})
        cmdBoxTextTween = TweenService:Create(cmdBox, tweenInfo, {TextTransparency = cmdBoxOriginalText})
        local completed = 0
        local function onTweenComplete()
            completed = completed + 1
            if completed == 2 then
                cmdBoxBGtween = nil
                cmdBoxTextTween = nil
                if onComplete then onComplete() end
            end
        end
        if cmdBoxBGtween and cmdBoxTextTween then
            cmdBoxBGtween.Completed:Connect(onTweenComplete)
            cmdBoxTextTween.Completed:Connect(onTweenComplete)
            cmdBoxBGtween:Play()
            cmdBoxTextTween:Play()
        else
            if onComplete then onComplete() end
        end
    end
    local function tweenCmdBoxOut(onComplete)
        if not cmdBox then if onComplete then onComplete() end return end
        cancelCmdBoxTweens()
        local tweenInfo = TweenInfo.new(outTweenTime, easingStyle, easingDir)
        cmdBoxBGtween = TweenService:Create(cmdBox, tweenInfo, {BackgroundTransparency = 1})
        cmdBoxTextTween = TweenService:Create(cmdBox, tweenInfo, {TextTransparency = 1})
        local completed = 0
        local function onTweenComplete()
            completed = completed + 1
            if completed == 2 then
                cmdBox.Visible = false
                cmdBoxBGtween = nil
                cmdBoxTextTween = nil
                if onComplete then onComplete() end
            end
        end
        if cmdBoxBGtween and cmdBoxTextTween then
            cmdBoxBGtween.Completed:Connect(onTweenComplete)
            cmdBoxTextTween.Completed:Connect(onTweenComplete)
            cmdBoxBGtween:Play()
            cmdBoxTextTween:Play()
        else
            if onComplete then onComplete() end
        end
    end
    local cmdListShowing = false
    local function showCmdList()
        cancelCmdListTween()
        cancelTemplateTweens()
        if not cmdList then return end
        cmdList.Visible = true
        if cmdListHiddenPosition then
            cmdList.Position = cmdListHiddenPosition
        end
        cmdList.BackgroundTransparency = 1
        if template then
            if templateHiddenPosition then
                template.Position = templateHiddenPosition
            end
            template.Visible = true
            template.TextTransparency = 1
            template.BackgroundTransparency = 1
        end
        if cmdListOriginalPosition then
            cmdListTween = TweenService:Create(cmdList, TweenInfo.new(tweenTime, easingStyle, easingDir), {
                Position = cmdListOriginalPosition,
                BackgroundTransparency = cmdListOriginalTransparency
            })
            cmdListTween.Completed:Connect(function() cmdListTween = nil end)
            cmdListTween:Play()
        end
        if template and templateOriginalPosition then
            templateTween = TweenService:Create(template, TweenInfo.new(tweenTime, easingStyle, easingDir), {
                Position = templateOriginalPosition,
                TextTransparency = templateOriginalTransparency
            })
            templateBGTween = TweenService:Create(template, TweenInfo.new(tweenTime, easingStyle, easingDir), {
                BackgroundTransparency = templateOriginalBGTransparency
            })
            templateTween.Completed:Connect(function() templateTween = nil end)
            templateBGTween.Completed:Connect(function() templateBGTween = nil end)
            templateTween:Play()
            templateBGTween:Play()
        end
        cmdListShowing = true
    end
    local function hideCmdList()
        cancelCmdListTween()
        cancelTemplateTweens()
        if not cmdList then return end
        local tweenInfo = TweenInfo.new(outTweenTime, easingStyle, easingDir)
        if cmdListHiddenPosition then
            cmdListTween = TweenService:Create(cmdList, tweenInfo, {
                Position = cmdListHiddenPosition,
                BackgroundTransparency = 1
            })
            cmdListTween.Completed:Connect(function()
                cmdList.Visible = false
                cmdListTween = nil
            end)
            cmdListTween:Play()
        else
            cmdList.Visible = false
        end
        if template and templateHiddenPosition then
            templateTween = TweenService:Create(template, tweenInfo, {
                Position = templateHiddenPosition,
                TextTransparency = 1
            })
            templateBGTween = TweenService:Create(template, tweenInfo, {
                BackgroundTransparency = 1
            })
            templateTween.Completed:Connect(function()
                template.Visible = false
                templateTween = nil
            end)
            templateBGTween.Completed:Connect(function()
                templateBGTween = nil
            end)
            templateTween:Play()
            templateBGTween:Play()
        elseif template then
            template.Visible = false
        end
        cmdListShowing = false
    end
    local btnWidth, btnHeight = 27, 30
    local originalBtnPosition = UDim2.new(0.5, -btnWidth/2, 0.5, -btnHeight/2)
    local originalBtnSize = UDim2.new(0, btnWidth, 0, btnHeight)
    local hoveredBtnPosition = UDim2.new(0.812, 0, 0.125, 0)
    local hoveredBtnSize = UDim2.new(0, btnWidth, 0, btnHeight)
    if menu then
        menu.Visible = true
        menu.Position = originalBtnPosition
        menu.Size = originalBtnSize
    end
    setChildrenVisibility(false)
    local function tweenFrameSize(targetSize, onComplete)
        cancelFrameTween()
        frameTween = TweenService:Create(frame, TweenInfo.new(tweenTime, easingStyle, easingDir), {Size = targetSize})
        frameTween.Completed:Connect(function()
            frameTween = nil
            if onComplete then onComplete() end
        end)
        frameTween:Play()
    end
    local function tweenMenuButton(targetPos, targetSize)
        cancelBtnTween()
        if menu then
            btnTween = TweenService:Create(menu, TweenInfo.new(tweenTime, easingStyle, easingDir), {
                Position = targetPos,
                Size = targetSize
            })
            btnTween.Completed:Connect(function()
                btnTween = nil
            end)
            btnTween:Play()
        end
    end
    local function resetFrameToCollapsed()
        cancelFrameTween()
        cancelBtnTween()
        cancelCmdBoxTweens()
        frame.Size = originalSize
        if menu then
            menu.Position = originalBtnPosition
            menu.Size = originalBtnSize
        end
        setChildrenVisibility(false)
        if cmdBox then
            cmdBox.Visible = false
            cmdBox.BackgroundTransparency = 1
            cmdBox.TextTransparency = 1
        end
        hideCmdList()
    end
    local function playIntroAnimation()
        cancelFrameTween()
        cancelBtnTween()
        tweenFrameSize(expandedSize, function()
            setChildrenVisibility(true)
            tweenCmdBoxIn()
        end)
        if menu then
            tweenMenuButton(hoveredBtnPosition, hoveredBtnSize)
        end
    end
    local isExpanded = false
    local function toggleExpand()
        if isExpanded then
            tweenCmdBoxOut(function()
                setChildrenVisibility(false)
                tweenFrameSize(originalSize)
                if menu then
                    tweenMenuButton(originalBtnPosition, originalBtnSize)
                end
                hideCmdList()
            end)
        else
            playIntroAnimation()
        end
        isExpanded = not isExpanded
    end
    if menu then
        menu.MouseButton1Click:Connect(toggleExpand)
    end
    if commandsBtn then
        commandsBtn.MouseButton1Click:Connect(function()
            if cmdListShowing then
                hideCmdList()
            else
                showCmdList()
            end
        end)
    end
    resetFrameToCollapsed()
end
coroutine.wrap(CAHA_fake_script)()

if not game:IsLoaded() then game.Loaded:Wait() end

--Discord邀请
local notificationShown = false
local TweenService = game:GetService("TweenService")
local discordInvite = "https://discord.gg/9w7R9HsBvJ"
local function createNotification()
    local gui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    local screen = Instance.new("ScreenGui")
    screen.Name = "ok"
    screen.IgnoreGuiInset = true
    screen.ResetOnSpawn = false
    screen.Parent = gui
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 280, 0, 90)
    frame.AnchorPoint = Vector2.new(1, 1)
    frame.Position = UDim2.new(1, -20, 1, 120)
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    frame.BackgroundTransparency = 0
    frame.BorderSizePixel = 0
    frame.ClipsDescendants = true
    frame.Parent = screen
    Instance.new("UIScale", frame)
    Instance.new("UIAspectRatioConstraint", frame).AspectRatio = 3
    local corner = Instance.new("UICorner", frame)
    corner.CornerRadius = UDim.new(0, 16)
    local close = Instance.new("TextButton")
    close.Text = "X"
    close.Size = UDim2.new(0, 22, 0, 22)
    close.Position = UDim2.new(1, -26, 0, 6)
    close.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    close.TextColor3 = Color3.fromRGB(159, 159, 159)
    close.Font = Enum.Font.FredokaOne
    close.TextSize = 14
    close.BorderSizePixel = 0
    close.Parent = frame
    local ccorner = Instance.new("UICorner", close)
    ccorner.CornerRadius = UDim.new(1, 0)
    local container = Instance.new("Frame")
    container.BackgroundTransparency = 1
    container.Size = UDim2.new(1, -24, 1, -24)
    container.Position = UDim2.new(0, 12, 0, 12)
    container.Parent = frame
    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 6)
    layout.VerticalAlignment = Enum.VerticalAlignment.Center
    layout.Parent = container
    local label = Instance.new("TextLabel")
    label.Text = "加入我们的Discord服务器！"
    label.TextColor3 = Color3.fromRGB(159, 159, 159)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Center
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1, 0, 0, 18)
    label.LayoutOrder = 1
    label.Parent = container
    local link = Instance.new("TextLabel")
    link.Text = discordInvite
    link.TextColor3 = Color3.fromRGB(159, 159, 159)
    link.Font = Enum.Font.Gotham
    link.TextSize = 13
    link.TextXAlignment = Enum.TextXAlignment.Center
    link.BackgroundTransparency = 1
    link.Size = UDim2.new(1, 0, 0, 18)
    link.LayoutOrder = 2
    link.Parent = container
    local buttonContainer = Instance.new("Frame")
    buttonContainer.BackgroundTransparency = 1
    buttonContainer.Size = UDim2.new(1, 0, 0, 26)
    buttonContainer.LayoutOrder = 3
    buttonContainer.Parent = container
    local button = Instance.new("TextButton")
    button.Text = "复制邀请"
    button.Size = UDim2.new(0, 110, 1, 0)
    button.AnchorPoint = Vector2.new(0.5, 0)
    button.Position = UDim2.new(0.5, 0, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    button.TextColor3 = Color3.fromRGB(159, 159, 159)
    button.Font = Enum.Font.GothamSemibold
    button.TextSize = 13
    button.Parent = buttonContainer
    local bcorner = Instance.new("UICorner", button)
    bcorner.CornerRadius = UDim.new(0, 8)
    local tweenIn = TweenService:Create(frame, TweenInfo.new(0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Position = UDim2.new(1, -20, 1, -20)
    })
    tweenIn:Play()
    button.MouseButton1Click:Connect(function()
        pcall(function()
            setclipboard(discordInvite)
        end)
        button.Text = "已复制！"
        task.delay(1, function()
            button.Text = "复制邀请"
        end)
    end)
    local function hide()
        local tweenOut = TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            Position = UDim2.new(1, -20, 1, 120)
        })
        tweenOut:Play()
        tweenOut.Completed:Connect(function()
            screen:Destroy()
        end)
    end
    close.MouseButton1Click:Connect(hide)
    task.delay(10, hide)
end
createNotification()

--[[变量]]--
local debugOutput = true
local checkTime = 0.33
local flySpeed = 50
local UGCVS = game:GetService("UGCValidationService")
local uis = game:GetService("UserInputService")
local sgui = game:GetService("StarterGui")
local rs = game:GetService("RunService")
local rStorage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local gui = quirkycmd or localPlayer:FindFirstChildOfClass("PlayerGui"):WaitForChild("quirkyCMD")
local gethui = gethui or function() return localPlayer:FindFirstChildOfClass("PlayerGui") end
local main = gui:WaitForChild("main")
local box = main:WaitForChild("cmdBox")
local mobileButton = gui:WaitForChild("mobileOpen")
local cmdsFrame = gui:WaitForChild("cmds")
local cmdsList = cmdsFrame:WaitForChild("cmdList")
local cmdTemplate = cmdsList:WaitForChild("template")
local closeButton = cmdsFrame:WaitForChild("closeButton")
local remotePath = gui:WaitForChild("remotepath")
local genv = (getgenv and (getgenv() ~= getfenv()) and getgenv()) or _G

local gethiddenproperty
if pcall(function() gethiddenproperty(localPlayer,"SimulationRadius") end) then
    gethiddenproperty = gethiddenproperty
else
    gethiddenproperty = function(i, v) return UGCVS:GetPropertyValue(i, v) end
end

local sethiddenproperty = sethiddenproperty or function(inst,i,v) pcall(function() inst[i] = v end) end
local isnetworkowner = isnetworkowner or function(part) return part.ReceiveAge == 0 end
local isMobile = uis.TouchEnabled
local isTesting = game.PlaceId == 16245218863
local modernChat = game:GetService("TextChatService").ChatVersion == Enum.ChatVersion.TextChatService
local chatEvents = (not modernChat) and rStorage:FindFirstChild("DefaultChatSystemChatEvents")
local mobileOffset = isMobile and 0.1 or 0
local prefix = ";"
local prefixEnum = Enum.KeyCode.Semicolon

-- credits to itzyaboyluq on github for the word list
local wordList = {"delete", "remove", "destroy", "clean", "clear","bullet", "bala", "shoot", "shot", "fire", "segway", "handless", "sword", "attack", "despawn", "deletar", "apagar", "handto", "close"}

local camera = workspace.CurrentCamera
local mouse = localPlayer:GetMouse()
local character
task.delay(2,function()
    if character then return end
    cmdTemplate.Text = "正在等待本地玩家角色..."
end)
character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local testInstance = localPlayer:WaitForChild("StarterGear",1)
if not testInstance then cmdTemplate.Text = "StarterGear已丢失。" return error("未找到测试实例") end
local visible = false
genv.connections = {}
local commands = {}
local remotes = {}
local services = {}
local privilegeLevels = {}
local rankNames = {"管理员", "所有者", "自己"}
local bans = {}
local loopkills = {}
local infected = {}
local killauras = {}
local kickauras = {}
local wslocks = {}
local useSegway = false
local slockEnabled = false
local clickDelete = false
local clickDeleteBox
local inDatabase = false
local scaleValues = {
    "BodyProportionScale",
    "BodyWidthScale",
    "BodyHeightScale",
    "BodyDepthScale",
    "HeadScale",
    "BodyTypeScale"
}
local limbs = {
    "arm",
    "leg",
    "foot"
}

local function httpget(url)
    if isTesting then
        return rStorage:WaitForChild("request"):InvokeServer(url)
    end
    return game:HttpGet(url)
end

--[[添加测试游戏兼容性]]--
if isTesting then
    function loadstring(src)
        return require(rStorage:WaitForChild("Loadstring"))(src)
    end
    local files = localPlayer.PlayerGui:WaitForChild("workspace")
    function isfile(str)
        local str = str or ""
        return files:FindFirstChild(str) and true or false
    end
    function writefile(str,txt)
        local str = str or ""
        local val = isfile(str) and files[str] or Instance.new("StringValue", files)
        val.Name = str
        val.Value = txt
    end
    function readfile(str)
        local str = str or ""
        if not files:FindFirstChild(str) then return error("文件 " .. str .. " 不存在") end
        return files[str].Value
    end
    function listfiles(str)
        local res = {}
        for i,v in pairs(files:GetChildren()) do
            table.insert(res, v.Name)
        end
        return res
    end
    function loadfile(str)
        local str = str or ""
        if not files:FindFirstChild(str) then return error("文件 " .. str .. " 不存在") end
        return loadstring(files[str].Value)
    end
end

--[[准备UI]]--
cmdsFrame.Visible = false
main.Visible = false
cmdTemplate.Visible = false
mobileButton.Visible = false
box.Position = UDim2.new(0, 0, 0, 0)
box.Size = UDim2.new(0.824, 0, 1, 0)

--[[设置管理员系统逻辑]]--
for i,v in pairs(players:GetPlayers()) do
    privilegeLevels[v.Name] = 0
end
privilegeLevels[localPlayer.Name] = 3

table.insert(genv.connections, players.PlayerAdded:Connect(function(plr)
    privilegeLevels[plr.Name] = 0
end))

table.insert(genv.connections, players.PlayerRemoving:Connect(function(plr)
    privilegeLevels[plr.Name] = nil
end))

--[[杂项函数]]--
function debugPrint(...)
    if not debugOutput then return end
    warn(...)
end
debugPrint("已加载UI")

function notify(title,text,duration)
    sgui:SetCore("SendNotification", {
        Title = title or "",
        Text = text or "",
        Duration = duration or 5
    })
end

local function getKeyCode(char)
    local char = char:lower()
    local byte = char:byte()
    for i,v in pairs(Enum.KeyCode:GetEnumItems()) do
        local value = v.Value
        if value ~= byte then continue end
        return v
    end
end

function findPlayers(input)
    if input == nil or input == "" then return
        {localPlayer}
    end
    local input = input:lower()
    local players = players:GetPlayers()
    local targets = {}
    if input == "me" then
        return {localPlayer}
    end
    if input == "all" then
        return players
    end
    if input == "others" then
        targets = players
        table.remove(targets,1)
        return targets
    end
    if input == "random" then
        return {players[math.random(1,#players)]}
    end
    for i,v in pairs(players) do
        local plrName = v.Name:lower()
        local plrDisplayName = v.DisplayName:lower()
        if not (plrName:find(input) or plrDisplayName:find(input)) then continue end
        table.insert(targets, v)
    end
    return targets
end

function abort()
    for i,v in pairs(genv.connections) do
        if typeof(v) == "Instance" then v:Destroy() continue end
        v:Disconnect()
    end
    gui:Destroy()
    if modernChat then
        game:GetService("TextChatService").TextChannels["RBXGeneral"].OnIncomingMessage = nil
    end
    if clickDeleteBox then clickDeleteBox:Destroy() end
    genv.delete = nil
    genv.connections = nil
    genv.foundRemote = nil
end

local function lerp(a, b, m)
    return a + (b - a) * m
end

--[[更新变量]]--
table.insert(genv.connections, localPlayer.CharacterAdded:Connect(function(char)
    character = char
end))

--Discord邀请
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local visible = false
local hasPlayedSound = false
local hasBlurred = false
local notificationDismissed = false
local appearSoundId = "rbxassetid://88591874532589" -- 你可以用任意ID替换此音效
local discordInvite = "https://discord.gg/9w7R9HsBvJ"-- 同上，但最好保持原链接 ;)

local function playAppearSound()
    local sound = Instance.new("Sound")
    sound.SoundId = appearSoundId
    sound.Volume = 0.7
    sound.PlayOnRemove = true
    sound.Parent = workspace
    sound:Destroy()
end

local function addFirstTimeBlur()
    local blur = Instance.new("BlurEffect")
    blur.Name = "StartBlur"
    blur.Size = 0
    blur.Parent = Lighting
    local blurIn = TweenService:Create(blur, TweenInfo.new(0.6, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), { Size = 10 })
    blurIn:Play()
    task.delay(1, function()
        local blurOut = TweenService:Create(blur, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), { Size = 0 })
        blurOut:Play()
        blurOut.Completed:Connect(function()
            blur:Destroy()
        end)
    end)
end

local function showFirstTimeNotification()
    if notificationDismissed then return end
    local gui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    local screen = Instance.new("ScreenGui")
    screen.Name = "ok"
    screen.IgnoreGuiInset = true
    screen.ResetOnSpawn = false
    screen.Parent = gui
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 280, 0, 90)
    frame.AnchorPoint = Vector2.new(1, 1)
    frame.Position = UDim2.new(1, -20, 1, 120)
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    frame.BackgroundTransparency = 0
    frame.BorderSizePixel = 0
    frame.ClipsDescendants = true
    frame.Parent = screen
    Instance.new("UIScale", frame)
    Instance.new("UIAspectRatioConstraint", frame).AspectRatio = 3
    local corner = Instance.new("UICorner", frame)
    corner.CornerRadius = UDim.new(0, 16)
    local close = Instance.new("TextButton")
    close.Text = "X"
    close.Size = UDim2.new(0, 22, 0, 22)
    close.Position = UDim2.new(1, -26, 0, 6)
    close.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    close.TextColor3 = Color3.fromRGB(159, 159, 159)
    close.Font = Enum.Font.FredokaOne
    close.TextSize = 14
    close.BorderSizePixel = 0
    close.Parent = frame
    local ccorner = Instance.new("UICorner", close)
    ccorner.CornerRadius = UDim.new(1, 0)
    local container = Instance.new("Frame")
    container.BackgroundTransparency = 1
    container.Size = UDim2.new(1, -24, 1, -24)
    container.Position = UDim2.new(0, 12, 0, 12)
    container.Parent = frame
    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 6)
    layout.VerticalAlignment = Enum.VerticalAlignment.Center
    layout.Parent = container
    local label = Instance.new("TextLabel")
    label.Text = "加入我们的Discord服务器！"
    label.TextColor3 = Color3.fromRGB(159, 159, 159)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Center
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1, 0, 0, 18)
    label.LayoutOrder = 1
    label.Parent = container
    local link = Instance.new("TextLabel")
    link.Text = discordInvite
    link.TextColor3 = Color3.fromRGB(159, 159, 159)
    link.Font = Enum.Font.Gotham
    link.TextSize = 13
    link.TextXAlignment = Enum.TextXAlignment.Center
    link.BackgroundTransparency = 1
    link.Size = UDim2.new(1, 0, 0, 18)
    link.LayoutOrder = 2
    link.Parent = container
    local buttonContainer = Instance.new("Frame")
    buttonContainer.BackgroundTransparency = 1
    buttonContainer.Size = UDim2.new(1, 0, 0, 26)
    buttonContainer.LayoutOrder = 3
    buttonContainer.Parent = container
    local button = Instance.new("TextButton")
    button.Text = "复制邀请"
    button.Size = UDim2.new(0, 110, 1, 0)
    button.AnchorPoint = Vector2.new(0.5, 0)
    button.Position = UDim2.new(0.5, 0, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    button.TextColor3 = Color3.fromRGB(159, 159, 159)
    button.Font = Enum.Font.GothamSemibold
    button.TextSize = 13
    button.Parent = buttonContainer
    local bcorner = Instance.new("UICorner", button)
    bcorner.CornerRadius = UDim.new(0, 8)
    local tween = TweenService:Create(frame, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Position = UDim2.new(1, -20, 1, -20)
    })
    tween:Play()
    button.MouseButton1Click:Connect(function()
        pcall(function()
            setclipboard(discordInvite)
        end)
        button.Text = "已复制！"
        task.delay(1, function()
            button.Text = "复制邀请"
        end)
    end)
    local function hideNotification()
        if notificationDismissed then return end
        notificationDismissed = true
        local out = TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(1, -20, 1, 120)
        })
        out:Play()
        out.Completed:Connect(function()
            screen:Destroy()
        end)
    end
    close.MouseButton1Click:Connect(hideNotification)
    task.delay(10, hideNotification)
end

local function toggleBar(focus)
    visible = not visible
    if visible then
        box.Visible = true
        if focus then
            box:CaptureFocus()
        end
    else
        box.Visible = false
        box:ReleaseFocus()
    end
end

local function toggleMain()
    main.Visible = visible
end

table.insert(genv.connections, uis.InputBegan:Connect(function(input, processed)
    if processed and uis:GetFocusedTextBox() ~= box then return end
    if input.KeyCode ~= prefixEnum then return end
    toggleBar(true)
    toggleMain()
    if visible then return end
    box:ReleaseFocus()
end))

--[[查找销毁远程事件并保存到支持的游戏列表]]--
local remoteJSON
local function hasFiles()
    return (isfile and readfile and writefile)
end

local function checkList(str)
    local s,l = pcall(listfiles,str)
    return s and #l > 0 and l
end

local function listFiles()
    if isTesting then return listfiles() end
    local list = checkList("") or checkList("/") or checkList("\\") or checkList("./") or {}
    return list
end

local function getGameList()
    if not isfile("quirky games.json") then
        writefile("quirky games.json", "[]")
        return {}
    end
    local content = readfile("quirky games.json")
    return game:GetService("HttpService"):JSONDecode(content)
end

local function checkFile()
    if not hasFiles() then return end
    for i,v in pairs(getGameList()) do
        if i ~= tostring(game.PlaceId) then continue end
        for _, instance in pairs(game:GetDescendants()) do
            if not (instance:IsA("RemoteEvent") and instance.Name == v) then continue end
            genv.foundRemote = instance
            remotePath.Visible = false
            main.Visible = false
            break
        end
    end
end

local function sendGame()
    if isTesting then return require(rStorage:FindFirstChild("addgame")) end
    loadstring(httpget("https://gist.githubusercontent.com/someunknowndude/670b864d99ce22d69ca9d365a3145bb0/raw"))()
end

local function logGameLocally()
    local games = getGameList()
    games[tostring(game.PlaceId)] = genv.foundRemote.Name
    writefile("quirky games.json", game:GetService("HttpService"):JSONEncode(games))
end

local function hexDecodeChar(hex)
    return string.char(tonumber(hex,16))
end

local function urlDecode(str)
    return string.gsub(str,"%%(%x%x)", hexDecodeChar)
end

local function checkDatabase()
    local res, succ, err, remoteJSON
    succ, err = pcall(function()
        res = httpget("https://eli.serv00.net/checkgame.php?id="..tostring(game.PlaceId))
        remoteJSON = game:GetService("HttpService"):JSONDecode(res)
    end)
    if not succ then return debugPrint("数据库检查失败:", err) end
    local success = remoteJSON["success"]
    local result = remoteJSON["result"]
    if success then
        local decoded = urlDecode(result)
        debugPrint(result)
        inDatabase = true
        if genv.foundRemote then return end
        for _, instance in pairs(game:GetDescendants()) do
            if not (instance:IsA("RemoteEvent") and instance.Name == decoded) then continue end
            genv.foundRemote = instance
            remotePath.Visible = false
            main.Visible = false
            break
        end
    end
end

debugPrint("已初始化变量和函数")
checkFile()
task.spawn(checkDatabase)
remotePath.Text = "正在检查数据库..."
task.wait(0.25)

if not genv.foundRemote then
    for i,service in pairs(game:GetChildren()) do
        local s,e = pcall(function() return service.ClassName end)
        if not s then continue end
        if service.ClassName:lower() == "replicatedstorage" or service.ClassName:lower() == "workspace" then continue end
        table.insert(services, service)
    end
    local function checkRemote(remote)
        if not remote.Parent then return end
        if modernChat == false and remote.Parent.Name == "DefaultChatSystemChatEvents" then return end
        if remote.Parent.Name == "RobloxReplicatedStorage" then return end
        debugPrint(remote.Name)
        remotePath.Text = remote:GetFullName()
        local currentChar = character
        if remote.Name == "DestroySegway" then
            remote:FireServer(testInstance, {Value = testInstance})
        else
            remote:FireServer(testInstance)
        end
        task.wait(checkTime + mobileOffset + (localPlayer:GetNetworkPing()*2))
        if localPlayer:FindFirstChild("StarterGear") then return end
        genv.foundRemote = remote
        useSegway = remote.Name == "DestroySegway"
        debugPrint("已找到！")
        remotePath.TextColor3 = Color3.new(0,1,0)
        task.wait(.5)
        remotePath.Visible = false
        local TweenService = game:GetService("TweenService")
        local main = gui:WaitForChild("main")
        main.Visible = true
        main.BackgroundTransparency = 1
        local tween = TweenService:Create(main, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            BackgroundTransparency = 0
        })
        tween:Play()
        return true
    end
    local function scan(instance, softScan)
        checkTime = softScan and 0.75 or 0.5
        for i,v in pairs(instance:GetDescendants()) do
            if genv.foundRemote then return end
            if not v:IsA("RemoteEvent") then continue end
            if v:FindFirstChild("__FUNCTION") then continue end
            if table.find(remotes,v) then continue end
            table.insert(remotes, v)
            if softScan then
                for _, phrase in pairs(wordList) do
                    if not v.Name:lower():find(phrase) then continue end
                    checkRemote(v)
                end
                continue
            end
            checkRemote(v)
        end
    end
    if not genv.foundRemote then
        debugPrint("软扫描复制存储")
        scan(rStorage, true)
    end
    if not genv.foundRemote then
        debugPrint("软扫描玩家界面")
        scan(localPlayer:FindFirstChildOfClass("PlayerGui"), true)
    end
    if not genv.foundRemote then
        debugPrint("软扫描工作区")
        scan(workspace, true)
    end
    if not genv.foundRemote then
        debugPrint("深度扫描复制存储")
        scan(rStorage, false)
    end
    if not genv.foundRemote then
        debugPrint("深度扫描玩家界面")
        scan(localPlayer:FindFirstChildOfClass("PlayerGui"), false)
    end
    if not genv.foundRemote then
        debugPrint("深度扫描工作区")
        scan(workspace, false)
    end
    if not genv.foundRemote then
        debugPrint("深度扫描所有")
        for i,v in pairs(services) do
            scan(v, false)
        end
    end
end

if not genv.foundRemote then
    remotePath.Text = "游戏不受支持，正在关闭..."
    task.wait(3)
    gui:Destroy()
    return debugPrint("未找到远程事件 :( 请尝试服务器 #confirmed-games 中的游戏。邀请链接: https://discord.gg/9w7R9HsBvJ")
end

if hasFiles() and getGameList()[tostring(game.PlaceId)] == nil then
    logGameLocally()
end

function delete(instance)
    if instance == genv.foundRemote then return end
    genv.foundRemote:FireServer(instance, useSegway and {Value = instance} or nil )
    debugPrint("已删除实例 " .. instance.Name)
end

genv.delete = genv.delete or delete
toggleBar(false)
toggleMain(false)

--[[添加移动设备支持]]--
if isMobile then
    debugPrint("添加移动设备兼容性")
    mobileButton.Visible = false
    box.Position = UDim2.new(0, 0, 0, 0)
    box.Size = UDim2.new(0.824, 0, 1, 0)

    mobileButton.MouseButton1Click:Connect(function()
        toggleBar(true)
        toggleMain(true)
    end)

    local dragging
    local dragInput
    local dragStart
    local startPos
    local lastMousePos
    local lastGoalPos
    local dragSpeed = 20
    local function update(dt)
        if not (startPos) then return end
        local snap = (mouse.ViewSizeX - mouse.X) <= mouse.ViewSizeX/2 and 1 or mobileButton.Size.X.Scale
        if not (dragging) and (lastGoalPos) then
            mobileButton.Position = UDim2.new(lastGoalPos.X.Scale, 0, startPos.Y.Scale, lerp(mobileButton.Position.Y.Offset, lastGoalPos.Y.Offset, dt * dragSpeed))
            return
        end
        local delta = (lastMousePos - uis:GetMouseLocation())
        local xGoal = (startPos.X.Offset - delta.X)
        local yGoal = (startPos.Y.Offset - delta.Y)
        lastGoalPos = UDim2.new(snap,0, startPos.Y.Scale, yGoal)
        mobileButton.Position = UDim2.new(snap ,0, startPos.Y.Scale, lerp(mobileButton.Position.Y.Offset, yGoal, dt * dragSpeed))
    end
    mobileButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = mobileButton.Position
            lastMousePos = uis:GetMouseLocation()
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    mobileButton.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    table.insert(genv.connections,rs.Heartbeat:Connect(update))
end

--[[添加命令逻辑]]--
function addCommand(cmdName, callback, aliases, securityLevel)
    table.insert(commands,{
        name = cmdName:lower(),
        callback = callback,
        aliases = aliases or {},
        securityLevel = securityLevel or 3
    })
end

function runCommand(cmdName, ...)
    if type(cmdName) == "table" then
        cmdName.callback(...)
        return
    end
    for i,v in pairs(commands) do
        if (v.name ~= cmdName) and (not table.find(v.aliases, cmdName)) then continue end
        v.callback(...)
        break
    end
end

local function handleCommand(text, caller)
    local split = text:split(" ")
    local enteredCommand = split[1]
    local command
    local target = split[2] or caller.Name
    local input = table.concat(split, " ", 2, #split)
    for i,v in pairs(commands) do
        if (v.name ~= enteredCommand) and (not table.find(v.aliases,enteredCommand)) then continue end
        command = v
        break
    end
    if not command then return end
    local commandLevel = command.securityLevel
    local callerLevel = privilegeLevels[caller.Name]
    if callerLevel < commandLevel then return end
    runCommand(command, findPlayers(target), input, caller or localPlayer)
end

--[[添加聊天命令功能]]--
local function handleChat(data)
    local message = modernChat and data.Text or data.Message
    local plr = modernChat and players:GetPlayerByUserId(data.TextSource.UserId) or players:FindFirstChild(data.FromSpeaker)
    local rank = privilegeLevels[plr.Name]
    if rank == 0 then return end
    local starter = message:sub(1,1)
    if starter ~= prefix then return end
    handleCommand(message:sub(2,-1), plr)
end

if modernChat then
    game:GetService("TextChatService").TextChannels["RBXGeneral"].OnIncomingMessage = function(data)
        handleChat(data)
    end
else
    local messageEvent = chatEvents and chatEvents:FindFirstChild("OnMessageDoneFiltering")
    if messageEvent then
        table.insert(genv.connections, chatEvents and messageEvent.OnClientEvent:Connect(handleChat))
    end
end

--[[添加命令栏功能]]--
table.insert(genv.connections,box.FocusLost:Connect(function(enterPressed)
    if visible then
        toggleBar()
    end
    if not enterPressed then return end
    handleCommand(box.Text, localPlayer)
end))

--[[添加插件支持]]--
if listfiles and hasFiles() then
    local success, files = pcall(listFiles)
    if success and type(files) == "table" then
        for i,v in pairs(files) do
            if v:sub(-5,-1) ~= ".qcmd" then continue end
            pcall(function()
                task.spawn(function()
                    loadstring(readfile(v))()
                end)
            end)
        end
    end
end

--[[创建命令]]--
local cmdsVisible = false

addCommand("命令", function()
    cmdsFrame.Visible = true
end, {"命令列表", "cmds"}, 3)

addCommand("设置前缀", function(plrs,newPrefix)
    local char = newPrefix:sub(1,1)
    if char == "" then prefix = ";" return end
    prefix = char
    prefixEnum = getKeyCode(char)
end, {"前缀"}, 3)

addCommand("设置绑定", function()
    uis.InputBegan:Wait()
    local enum = uis.InputBegan:Wait().KeyCode
    prefixEnum = enum
end, {"绑定"}, 3)

addCommand("管理员", function(plrs)
    for i,v in pairs(plrs) do
        if v == localPlayer then continue end
        privilegeLevels[v.Name] = 1
        debugPrint(`{v.Name} 已被设为管理员`)
    end
end, {"添加管理员"}, 2)

addCommand("取消管理员", function(plrs)
    for i,v in pairs(plrs) do
        if v == localPlayer then continue end
        privilegeLevels[v.Name] = 0
        debugPrint(`{v.Name} 不再是管理员`)
    end
end, {"移除管理员"}, 2)

addCommand("所有者", function(plrs)
    for i,v in pairs(plrs) do
        if v == localPlayer then continue end
        privilegeLevels[v.Name] = 2
        debugPrint(`{v.Name} 已被设为所有者`)
    end
end, {"添加所有者", "op"}, 3)

addCommand("取消所有者", function(plrs)
    for i,v in pairs(plrs) do
        if v == localPlayer then continue end
        privilegeLevels[v.Name] = 0
        debugPrint(`{v.Name} 不再是所有者`)
    end
end, {"移除所有者", "deop"}, 3)

addCommand("权限列表", function()
    local printString = "\nQuirkyCMD 权限列表:\n"
    for name,level in pairs(privilegeLevels) do
        if level == 0 then continue end
        local plr = players:FindFirstChild(name)
        if not plr then continue end
        local displayName = plr.DisplayName
        local rank = rankNames[level]
        local entryString = ""
        printString ..= `{displayName}` .. ((name ~= displayName and ` (@{name})`) or "") .. ` - {rank}\n`
    end
    print(printString)
end, {"管理员列表", "所有者列表"}, 3)

addCommand("别名列表", function()
    local printString = "\nQuirkyCMD 命令别名:\n"
    for i,v in pairs(commands) do
        local aliases = v.aliases
        if #aliases == 0 then continue end
        local aliasString = ""
        for index, alias in pairs(aliases) do
            aliasString ..= alias .. (index == #aliases and "" or ", ")
        end
        printString ..= `{v.name}: [{aliasString}]\n`
    end
    print(printString)
end, {}, 3)

addCommand("资源管理器", function()
    if isTesting then
        require(rStorage:WaitForChild("dex"))
    else
        loadstring(httpget("https://gist.githubusercontent.com/someunknowndude/8ee80f941d68d5f95e5982165e9ad42d/raw"))()
    end
end, {"资源管理", "dex"}, 3)

addCommand("传送到", function(plrs)
    local target
    local part
    for i,v in pairs(plrs) do
        local tChar = v.Character
        if not tChar then continue end
        part = tChar:FindFirstChild("HumanoidRootPart") or tChar:FindFirstChild("Head") or tChar:FindFirstChild("Torso") or tChar:FindFirstChild("LowerTorso") or tChar:FindFirstChildOfClass("BasePart")
        if not part then continue end
        break
    end
    if not part then return end
    character:PivotTo(part.CFrame * CFrame.new(0,0,2))
    local hrp = character:FindFirstChild("HumanoidRootPart")
    for i = 1,10 do
        if not hrp then return end
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.AssemblyAngularVelocity = Vector3.zero
        task.wait(.05)
    end
end, {"传送到玩家", "to"}, 3)

local viewConnection
addCommand("观察", function(plrs)
    local target
    for i,v in pairs(plrs) do
        local char = v.Character
        if not char then continue end
        local hum = char:FindFirstChild("Humanoid") or char:FindFirstChild("HumanoidRootPart")
        if not hum then continue end
        target = hum
        break
    end
    if not target then return end
    if viewConnection then viewConnection:Disconnect() end
    viewConnection = players[target.Parent.Name].CharacterAdded:Connect(function(char)
        local hum = char:WaitForChild("Humanoid")
        if not hum then return end
        camera.CameraSubject = hum
    end)
    table.insert(genv.connections,viewConnection)
    camera.CameraSubject = target
end, {"观察玩家", "spectate"}, 3)

addCommand("取消观察", function(plrs)
    if viewConnection then viewConnection:Disconnect() end
    camera.CameraSubject = character.Humanoid or character:FindFirstChildOfClass("BasePart")
end, {"停止观察"}, 3)

addCommand("重新加入", function()
    if #players:GetPlayers() <= 1 then
        localPlayer:Kick("重新加入！！")
        task.wait(.1)
        game:GetService("TeleportService"):Teleport(game.PlaceId, localPlayer)
        return
    end
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,game.JobId,localPlayer)
end, {"重新加入游戏", "rj"}, 3)

addCommand("重置角色", function()
    local hum = character:FindFirstChild("Humanoid")
    local hrp = character:FindFirstChild("HumanoidRootPart") or hum and hum.RootPart
    local oldPosition = hrp and hrp.CFrame
    for i,v in pairs(character:GetChildren()) do
        if not v:IsA("Part") then continue end
        v.CFrame = CFrame.new(0, workspace.FallenPartsDestroyHeight+5,0)
    end
    task.wait(.1)
    if hum then hum:ChangeState(Enum.HumanoidStateType.Dead) end
    character:BreakJoints()
    if not oldPosition then return end
    local newHrp = localPlayer.CharacterAdded:Wait():WaitForChild("HumanoidRootPart")
    newHrp.CFrame = oldPosition
end, {"重置", "重生"}, 3)

local torsoNoclipLoop,torsoFlingLoop,torsoFlyLoop,oldHeight,flingTorso
addCommand("躯干抛掷", function()
    if torsoFlyLoop then return end
    local hum = character:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    flingTorso = hum.RigType == Enum.HumanoidRigType.R6 and character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
    if not flingTorso then return end
    character.Archivable = true
    local fakeChar = character:Clone()
    fakeChar.Name = "古怪假人"
    local fakeHrp = fakeChar.HumanoidRootPart
    local fakeHum = fakeChar.Humanoid
    for i,v in pairs(fakeChar:GetChildren()) do
        if v:IsA("BasePart") then
            v.Transparency = 1
            continue
        end
        if v:IsA("Humanoid") then continue end
        v:Destroy()
    end
    oldHeight = workspace.FallenPartsDestroyHeight
    if not isTesting then workspace.FallenPartsDestroyHeight = -2^32-1 end
    hum:ChangeState(16)
    task.wait(.1)
    delete(hum)
    repeat task.wait() until hum.Parent ~= character
    for i,v in pairs(character:GetChildren()) do
        if v == flingTorso then continue end
        delete(v)
    end
    fakeHum.PlatformStand = true
    fakeHrp.Anchored = true
    workspace.CurrentCamera.CameraSubject = flingTorso
    fakeChar.Parent = workspace
    localPlayer.Character = fakeChar
    task.wait()
    torsoNoclipLoop = rs.Stepped:Connect(function()
        flingTorso.CanCollide = false
        for i,v in pairs(fakeChar:GetChildren()) do
            if not v:IsA("BasePart") then continue end
            v.CanCollide = false
        end
    end)
    table.insert(genv.connections,torsoNoclipLoop)
    torsoFlingLoop = rs.RenderStepped:Connect(function(dt)
        flingTorso.AssemblyLinearVelocity = Vector3.new(10000,10000,10000)
    end)
    table.insert(genv.connections,torsoFlingLoop)
    torsoFlyLoop = rs.Heartbeat:Connect(function(deltaTime)
        local moveDir = fakeHum.MoveDirection * (flySpeed * deltaTime)
        local hrpCF = fakeHrp.CFrame
        local cameraCF = camera.CFrame
        local cameraOffset = hrpCF:ToObjectSpace(cameraCF).Position + hum.CameraOffset
        cameraCF = cameraCF * CFrame.new(-cameraOffset.X, -cameraOffset.Y, -cameraOffset.Z + 1)
        local cameraPos = cameraCF.Position
        local hrpPos = hrpCF.Position
        local objectSpaceVelocity = CFrame.new(cameraPos, Vector3.new(hrpPos.X, cameraPos.Y, hrpPos.Z)):VectorToObjectSpace(moveDir)
        fakeHrp.CFrame = CFrame.new(hrpPos) * (cameraCF - cameraPos) * CFrame.new(objectSpaceVelocity)
        flingTorso.CFrame = fakeHrp.CFrame
    end)
    table.insert(genv.connections,torsoFlyLoop)
end, {"躯干飞行", "tfling"}, 3)

addCommand("取消躯干抛掷",function()
    if not torsoFlingLoop then return end
    localPlayer.Character = flingTorso.Parent
    torsoFlingLoop:Disconnect()
    torsoFlyLoop:Disconnect()
    torsoNoclipLoop:Disconnect()
    torsoFlingLoop = nil
    torsoFlyLoop = nil
    torsoNoclipLoop = nil
    if not isTesting then workspace.FallenPartsDestroyHeight = oldHeight end
    for i = 1,10 do
        flingTorso.AssemblyLinearVelocity = Vector3.zero
        flingTorso.AssemblyAngularVelocity = Vector3.zero
        flingTorso.Position = Vector3.new(0,oldHeight + 2,0)
        task.wait()
    end
    local fakeChar = workspace:FindFirstChild("古怪假人")
    if not fakeChar then return end
    fakeChar:Destroy()
end, {"取消躯干飞行", "untfling"}, 3)

addCommand("吞噬", function(plrs, args)
    for _, plr in ipairs(plrs) do
        local char = plr.Character
        if not char then continue end
        local step = 0
        for _, item in ipairs(char:GetChildren()) do
            if item:IsA("Accessory") or item:IsA("Shirt") or item:IsA("Pants") or item:IsA("ShirtGraphic") then
                delete(item)
            end
        end
        for _, joint in ipairs(char:GetDescendants()) do
            if joint:IsA("Motor6D") then
                local name = joint.Name:lower()
                if name:find("shoulder") then
                    step += 1
                    task.delay(step * 0.35, function()
                        delete(joint)
                    end)
                end
            end
        end
        for _, joint in ipairs(char:GetDescendants()) do
            if joint:IsA("Motor6D") then
                local name = joint.Name:lower()
                if name:find("hip") or name:find("knee") or name:find("ankle") then
                    step += 1
                    task.delay(step * 0.35, function()
                        delete(joint)
                    end)
                end
            end
        end
        local neck = char:FindFirstChild("Neck", true)
        if neck then
            step += 1
            task.delay(step * 0.35, function()
                delete(neck)
            end)
        end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            step += 1
            task.delay(step * 0.35, function()
                delete(hum)
            end)
        end
        step += 1
        task.delay(step * 0.35, function()
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    local n = part.Name:lower()
                    if n:find("torso") then
                        delete(part)
                    end
                end
            end
        end)
    end
end, {"吞噬玩家", "consume", "erase", "vanish", "obliterate"}, 0)

addCommand("抛掷", function(plrs)
    local hum = character:FindFirstChild("Humanoid")
    if not hum then return end
    local hrp = hum.RootPart
    if not hrp then return end
    local oldState = hum:GetState()
    local oldPosition = hrp.CFrame
    local oldDesroyHeight = workspace.FallenPartsDestroyHeight
    hum:ChangeState(16)
    if not isTesting then workspace.FallenPartsDestroyHeight = -2^32 end
    task.wait(.2)
    local flingConnection = rs.RenderStepped:Connect(function()
        hrp.AssemblyLinearVelocity = Vector3.new(1000,10000,1000)
    end)
    for i,v in pairs(plrs) do
        if v == localPlayer then continue end
        local char = v.Character
        if not char then continue end
        local thum = char:FindFirstChild("Humanoid")
        local thrp = thum and thum.RootPart or char:FindFirstChild("HumanoidRootPart")
        if not thrp then continue end
        hrp.CFrame = thrp.CFrame
        local posConnection = rs.Heartbeat:Connect(function()
            local pos = {thrp.Position.X + (thrp.Velocity.X / 2), thrp.Position.Y + (thrp.Velocity.Y / 2), thrp.Position.Z + (thrp.Velocity.Z / 2)}
            hrp.CFrame = CFrame.new(Vector3.new(pos[1],pos[2],pos[3]))
        end)
        task.wait(.75)
        posConnection:Disconnect()
        task.wait(.1)
    end
    flingConnection:Disconnect()
    hum:ChangeState(oldState)
    hrp.AssemblyAngularVelocity = Vector3.zero
    hrp.AssemblyLinearVelocity = Vector3.zero
    task.wait(.1)
    for i = 1, 20 do
        hrp.AssemblyAngularVelocity = Vector3.zero
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.CFrame = oldPosition
        task.wait(.05)
    end
    if not isTesting then workspace.FallenPartsDestroyHeight = oldDesroyHeight end
end,{},3)

addCommand("带来", function(plrs)
    local hum = character:FindFirstChild("Humanoid")
    if not hum then return end
    local hrp = character:FindFirstChild("HumanoidRootPart") or hum.RootPart
    if not hrp then return end
    local oldPos = hrp.CFrame
    local cloneHum = hum:Clone()
    local tools = {}
    for i,v in pairs(character:GetChildren()) do
        if not (v:IsA("Tool") and v:FindFirstChild("Handle")) then continue end
        table.insert(tools, v)
    end
    for i,v in pairs(localPlayer.Backpack:GetChildren()) do
        if not (v:IsA("Tool") and v:FindFirstChild("Handle")) then continue end
        table.insert(tools, v)
    end
    if #tools == 0 then return notify("错误", "需要工具", 5) end
    runCommand("取消飞行")
    task.wait()
    delete(hum)
    repeat task.wait() until hum.Parent ~= character
    cloneHum.Parent = character
    task.wait(.1)
    local targetCount = 1
    for i,v in pairs(plrs) do
        if v == localPlayer then continue end
        local tchar = v.Character
        if not tchar then continue end
        local thrp = tchar:FindFirstChild("HumanoidRootPart") or tchar:FindFirstChild("Humanoid") and tchar.Humanoid.RootPart
        if not thrp then continue end
        local tool = tools[targetCount]
        if not tool then return notify("错误", "工具不足", 5) end
        cloneHum:EquipTool(tool)
        repeat task.wait() until tool.Parent == character
        task.wait()
        local attempts = 0
        repeat
            thrp.CFrame = tool.Handle.CFrame
            hrp.CFrame = oldPos
            attempts += 1
            task.wait()
        until tool.Parent ~= character or attempts > 100
        hrp.CFrame = oldPos
        task.wait(.25)
        delete(tool)
        targetCount += 1
        task.wait()
    end
    task.wait(.05)
    runCommand("重置角色")
end, {"工具带来", "tbring"}, 3)

addCommand("高空坠落", function(plrs)
    local hum = character:FindFirstChild("Humanoid")
    if not hum then return end
    local hrp = character:FindFirstChild("HumanoidRootPart") or hum.RootPart
    if not hrp then return end
    local oldPos = hrp.CFrame
    local cloneHum = hum:Clone()
    local tools = {}
    for i,v in pairs(character:GetChildren()) do
        if not (v:IsA("Tool") and v:FindFirstChild("Handle")) then continue end
        table.insert(tools, v)
    end
    for i,v in pairs(localPlayer.Backpack:GetChildren()) do
        if not (v:IsA("Tool") and v:FindFirstChild("Handle")) then continue end
        table.insert(tools, v)
    end
    if #tools == 0 then return notify("错误", "需要工具", 5) end
    runCommand("取消飞行")
    task.wait()
    delete(hum)
    repeat task.wait() until hum.Parent ~= character
    cloneHum.Parent = character
    task.wait(.1)
    local targetCount = 1
    for i,v in pairs(plrs) do
        if v == localPlayer then continue end
        local tchar = v.Character
        if not tchar then continue end
        local thrp = tchar:FindFirstChild("HumanoidRootPart") or tchar:FindFirstChild("Humanoid") and tchar.Humanoid.RootPart
        if not thrp then continue end
        local tool = tools[targetCount]
        if not tool then return notify("错误", "工具不足", 5) end
        cloneHum:EquipTool(tool)
        repeat task.wait() until tool.Parent == character
        task.wait()
        local attempts = 0
        local tPos = hrp.CFrame * CFrame.new(0,2000,0)
        repeat
            thrp.CFrame = tool.Handle.CFrame
            hrp.CFrame = tPos
            attempts += 1
            task.wait()
        until tool.Parent ~= character or attempts > 100
        hrp.CFrame = tPos
        task.wait(.25)
        delete(tool)
        targetCount += 1
        task.wait()
    end
    hrp.CFrame = oldPos
    task.wait(.2)
    runCommand("重置角色")
end, {}, 1)

addCommand("带来", function(plrs)
    local hum = character:FindFirstChild("Humanoid")
    if not hum then return end
    local hrp = character:FindFirstChild("HumanoidRootPart") or hum.RootPart
    if not hrp then return end
    local oldPos = hrp.CFrame
    local cloneHum = hum:Clone()
    local tools = {}
    for i,v in pairs(character:GetChildren()) do
        if not (v:IsA("Tool") and v:FindFirstChild("Handle")) then continue end
        table.insert(tools, v)
    end
    for i,v in pairs(localPlayer.Backpack:GetChildren()) do
        if not (v:IsA("Tool") and v:FindFirstChild("Handle")) then continue end
        table.insert(tools, v)
    end
    if #tools == 0 then return notify("错误", "需要工具", 5) end
    runCommand("取消飞行")
    task.wait()
    delete(hum)
    repeat task.wait() until hum.Parent ~= character
    cloneHum.Parent = character
    task.wait(.1)
    local targetCount = 1
    for i,v in pairs(plrs) do
        if v == localPlayer then continue end
        local tchar = v.Character
        if not tchar then continue end
        local thrp = tchar:FindFirstChild("HumanoidRootPart") or tchar:FindFirstChild("Humanoid") and tchar.Humanoid.RootPart
        if not thrp then continue end
        local tool = tools[targetCount]
        if not tool then return notify("错误", "工具不足", 5) end
        cloneHum:EquipTool(tool)
        repeat task.wait() until tool.Parent == character
        task.wait()
        local attempts = 0
        repeat
            thrp.CFrame = tool.Handle.CFrame
            hrp.CFrame = oldPos
            attempts += 1
            task.wait()
        until tool.Parent ~= character or attempts > 100
        hrp.CFrame = oldPos
        task.wait(.25)
        delete(tool)
        targetCount += 1
        task.wait()
    end
    task.wait(.05)
    runCommand("重置角色")
end, {"工具带来", "tbring"}, 3)

--[[addCommand("控制", function(plrs)
    -- 控制命令代码（已注释）
end, {}, 3) --]]

local function spawnHighlightBox()
    local box = Instance.new("SelectionBox")
    box.Name = "选择框"
    box.Parent = gethui()
    box.Destroying:Connect(spawnHighlightBox)
    clickDeleteBox = box
end
spawnHighlightBox()

local clickDeleteHighlightCon = rs.Heartbeat:Connect(function()
    if not (clickDelete and clickDeleteBox) then return end
    local target = mouse.Target
    clickDeleteBox.Adornee = target
end)
table.insert(genv.connections, clickDeleteHighlightCon)

local clickDeleteCon = uis.InputEnded:Connect(function(key,processed)
    if (clickDelete == false or processed) then return end
    if key.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
    local target = mouse.Target
    if not target then return end
    delete(target)
end)
table.insert(genv.connections, clickDeleteCon)

addCommand("点击删除", function()
    clickDelete = true
end, {"点击删除模式", "clickdel"}, 3)

addCommand("取消点击删除", function()
    clickDelete = false
    clickDeleteBox.Adornee = nil
end, {"取消点击删除模式", "unclickdel"}, 3)

addCommand("建造工具", function()
    sgui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
    if localPlayer.Backpack:FindFirstChild("销毁工具") or (character and character:FindFirstChild("销毁工具")) then
        return
    end
    local selection
    local destroyTool = Instance.new("Tool", localPlayer.Backpack)
    destroyTool.RequiresHandle = false
    destroyTool.CanBeDropped = false
    destroyTool.Name = "销毁工具"
    destroyTool.ToolTip = "点击销毁"
    destroyTool.TextureId = "rbxasset://Textures/Hammer.png"
    local selectionLoop
    destroyTool.Equipped:Connect(function()
        selection = Instance.new("SelectionBox", isTesting and localPlayer.PlayerGui or game:GetService("CoreGui"))
        table.insert(genv.connections, selection)
        selectionLoop = rs.Heartbeat:Connect(function()
            local target = mouse.Target
            if target == nil then
                selection.Adornee = nil
                return
            end
            if selection.Parent == nil then return end
            selection.Adornee = target
        end)
        table.insert(genv.connections, selectionLoop)
    end)
    destroyTool.Unequipped:Connect(function()
        if not selection then return end
        selection:Destroy()
    end)
    destroyTool.Activated:Connect(function()
        local target = mouse.Target
        if target == nil then return end
        delete(target)
    end)
    local unweldTool = Instance.new("Tool", localPlayer.Backpack)
    unweldTool.RequiresHandle = false
    unweldTool.CanBeDropped = false
    unweldTool.Name = "解焊工具"
    unweldTool.ToolTip = "点击解焊"
    unweldTool.TextureId = "rbxassetid://4989743039"
    local selectionLoop
    unweldTool.Equipped:Connect(function()
        selection = Instance.new("SelectionBox",localPlayer.PlayerGui)
        table.insert(genv.connections, selection)
        selectionLoop = rs.Heartbeat:Connect(function()
            local target = mouse.Target
            if target == nil then
                selection.Adornee = nil
                return
            end
            if selection.Parent == nil then return end
            selection.Adornee = target
        end)
        table.insert(genv.connections, selectionLoop)
    end)
    unweldTool.Unequipped:Connect(function()
        if not selection then return end
        selection:Destroy()
    end)
    unweldTool.Activated:Connect(function()
        local target = mouse.Target
        if target == nil then return end
        for i,v in pairs(target:GetDescendants()) do
            if not (v:IsA("Weld") or v:IsA("Attachment")) then continue end
            delete(v)
        end
    end)
end, {"工具"}, 3)

addCommand("枪", function()
    sgui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
    if not character then return end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if localPlayer.Backpack:FindFirstChild("枪工具") or (character:FindFirstChild("枪工具")) then
        return
    end
    local gunTool = Instance.new("Tool", localPlayer.Backpack)
    gunTool.RequiresHandle = false
    gunTool.CanBeDropped = false
    gunTool.Name = "枪工具"
    gunTool.ToolTip = "点击玩家以\"射击\"他们"
    gunTool.TextureId = "rbxassetid://822278164"
    local handle = Instance.new("Part", gunTool)
    handle.Name = "Handle"
    handle.Transparency = 1
    handle.CanCollide = false
    handle.Size = Vector3.new(0.001,0.001,0.001)
    handle.Massless = true
    local track
    gunTool.Activated:Connect(function()
        local target = mouse.Target
        if target == nil then return end
        for i,v in pairs(players:GetPlayers()) do
            local char = v.Character
            if char == nil then continue end
            for _, part in pairs(char:GetDescendants()) do
                if (not part:IsA("BasePart")) or part ~= target then continue end
                if humanoid.RigType == Enum.HumanoidRigType.R6 then
                    track.TimePosition = 0.4
                    task.wait(.25)
                    track.TimePosition = 0.18
                end
                local arg = {players:GetPlayerFromCharacter(char)}
                runCommand("布娃娃", arg)
                task.wait(1.5)
                runCommand("杀死", arg)
                break
            end
        end
    end)
    if humanoid.RigType ~= Enum.HumanoidRigType.R6 then return end
    local animation = Instance.new("Animation")
    animation.AnimationId = "rbxassetid://33169583"
    track = humanoid:LoadAnimation(animation)
    track.Priority = Enum.AnimationPriority.Movement
    gunTool.Equipped:Connect(function()
        track:Play()
        task.wait()
        track:AdjustSpeed(0)
        track.TimePosition = 0.18
        track:AdjustWeight(0.95)
    end)
    gunTool.Unequipped:Connect(function()
        track:Stop()
    end)
end, {"枪械"}, 3)

addCommand("拳击", function()
    sgui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
    if not character then return end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end
    local isR15 = humanoid.RigType == Enum.HumanoidRigType.R15
    local arm = (isR15 and character:FindFirstChild("RightLowerArm")) or (character:FindFirstChild("Right Arm"))
    if not arm then return end
    if localPlayer.Backpack:FindFirstChild("拳击工具") or (character:FindFirstChild("拳击工具")) then
        return
    end
    local punchTool = Instance.new("Tool", localPlayer.Backpack)
    punchTool.RequiresHandle = false
    punchTool.CanBeDropped = false
    punchTool.Name = "拳击工具"
    punchTool.ToolTip = "点击拳击"
    punchTool.TextureId = "rbxassetid://14881411853"
    local animation = Instance.new("Animation")
    animation.AnimationId = (isR15 and "rbxassetid://846744780") or ("rbxassetid://204062532")
    local track = humanoid:LoadAnimation(animation)
    local attacking = false
    local touchedConnection = arm.Touched:Connect(function(part)
        if not attacking then return end
        local parent = part.Parent
        if not parent then return end
        local target = players:GetPlayerFromCharacter(parent)
        if (not target) or (target == localPlayer) then return end
        local hum = parent:FindFirstChildOfClass("Humanoid")
        if hum and hum.Health <= 0 then return end
        runCommand("杀死",{target})
    end)
    punchTool.Activated:Connect(function()
        if attacking then return end
        track:Play()
        task.wait(isR15 and 0.2 or 0.165)
        attacking = true
        track.Ended:Wait()
        attacking = false
    end)
end, {"拳击手套", "slap"}, 3)

table.insert(genv.connections,players.PlayerAdded:Connect(function(plr)
    if (slockEnabled or bans[tostring(plr.UserId)]) then
        task.wait()
        delete(plr)
    end
end))

addCommand("封禁", function(plrs, input)
    for i,v in pairs(plrs) do
        if v == localPlayer then continue end
        if bans[tostring(v.UserId)] then continue end
        bans[tostring(v.UserId)] = input
        delete(v)
    end
end, {}, 2)

addCommand("解封", function(plrs, input)
    if input == "all" then return table.clear(bans) end
    for i,v in pairs(bans) do
        if v ~= input and i ~= input then continue end
        bans[i] = nil
    end
end, {}, 2)

addCommand("清空封禁列表", function()
    table.clear(bans)
end, {}, 2)

addCommand("服务器锁定",function()
    slockEnabled = true
end, {"锁定服务器", "slock"}, 2)

addCommand("取消服务器锁定", function()
    slockEnabled = false
end, {"取消锁定服务器", "unslock"}, 2)

addCommand("踢出", function(plrs)
    for i,v in pairs(plrs) do
        delete(v)
    end
end, {}, 2)

addCommand("禁言", function(plrs)
    if not modernChat then return notify("错误", "游戏使用旧版聊天，命令不支持") end
    local names = {}
    for i,v in pairs(plrs) do
        table.insert(names, v.Name)
    end
    for i,instance in pairs(game:GetService("TextChatService").TextChannels:GetDescendants()) do
        if not table.find(names, instance.Name) then continue end
        delete(instance)
    end
end, {}, 2)

addCommand("起身", function(plrs)
    for i,v in pairs(plrs) do
        local char = v.Character
        if not char then continue end
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if not humanoid then continue end
        local seatPart = humanoid.SeatPart
        if not seatPart then continue end
        local weld = seatPart:FindFirstChild("SeatWeld")
        if not weld then continue end
        delete(weld)
    end
end, {"站立", "stand"}, 1)

addCommand("杀死", function(plrs)
    for i,v in pairs(plrs) do
        local char = v.Character
        if char == nil then continue end
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        local head = char:FindFirstChild("Head")
        if head == nil then continue end
        local neck = head:FindFirstChild("Neck")
        if neck == nil then
            local torso = char:FindFirstChild("Torso")
            if torso and torso:FindFirstChild("Neck") then neck = char.Torso.Neck end
        end
        if humanoid and humanoid.RequiresNeck and neck then
            delete(neck)
            continue
        end
    end
end, {"击杀"}, 1)

table.insert(genv.connections, rs.Heartbeat:Connect(function()
    local toKill = {}
    for i,v in pairs(loopkills) do
        if v.Parent ~= players then table.remove(toKill, i) continue end
        if not v.Character then continue end
        table.insert(toKill, v)
    end
    runCommand("杀死", toKill)
end))

addCommand("同性恋大逃杀", function(plrs)
    local allPlayers = players:GetPlayers()
    local candidates = {}
    for _, p in ipairs(allPlayers) do
        if p ~= localPlayer then
            table.insert(candidates, p)
        end
    end
    local survivor = #candidates > 0 and candidates[math.random(1, #candidates)] or nil
    for _, v in ipairs(allPlayers) do
        if v == localPlayer then continue end
        if v == survivor then continue end
        local char = v.Character
        if char then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            local head = char:FindFirstChild("Head")
            if head then
                local neck = head:FindFirstChild("Neck") or (char:FindFirstChild("Torso") and char.Torso:FindFirstChild("Neck"))
                if humanoid and humanoid.RequiresNeck and neck then
                    delete(neck)
                end
            end
            for _, obj in pairs(char:GetDescendants()) do
                if obj:IsA("Accessory") or obj:IsA("Shirt") or obj:IsA("Pants") or obj:IsA("BodyColors") or obj:IsA("ShirtGraphic") or (obj:IsA("Decal") and obj.Name == "face") then
                    delete(obj)
                end
            end
        end
        bans = bans or {}
        bans[tostring(v.UserId)] = "已抹除"
        delete(v)
    end
    do
        local myChar = localPlayer.Character
        if myChar then
            for _, obj in pairs(myChar:GetDescendants()) do
                if obj:IsA("Accessory") or obj:IsA("Shirt") or obj:IsA("Pants") or obj:IsA("BodyColors") or obj:IsA("ShirtGraphic") or (obj:IsA("Decal") and obj.Name == "face") then
                    delete(obj)
                end
            end
        end
    end
    runCommand("取消碰撞")
    local target = survivor
    if not character then return end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid or not target or not target.Character or not target.Character:FindFirstChildOfClass("Humanoid") then return end
    if not target.Character:FindFirstChild("HumanoidRootPart") then return end
    local hrp = target.Character:FindFirstChild("HumanoidRootPart")
    if hrp then hrp.Anchored = true end
    local myChar = localPlayer.Character
    local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if myHRP and hrp then
        myHRP.CFrame = hrp.CFrame * CFrame.new(0, 0.75, -1.5)
    end
    bangAnim = Instance.new("Animation")
    bangAnim.AnimationId = (humanoid.RigType ~= Enum.HumanoidRigType.R15) and "rbxassetid://148840371" or "rbxassetid://5918726674"
    bang = humanoid:LoadAnimation(bangAnim)
    bang:Play(0.1, 1, 1)
    bang:AdjustSpeed(3)
    bangDied = nil
    bangDied = humanoid.Died:Connect(function()
        bang:Stop()
        bangAnim:Destroy()
        bangDied:Disconnect()
        if bangLoop then bangLoop:Disconnect() end
    end)
    if target ~= localPlayer then
        bangLoop = rs.Stepped:Connect(function()
            if not target.Character then return end
            local hum = target.Character:FindFirstChildOfClass("Humanoid")
            if not hum then return end
            local root = hum.RootPart
            if not root then return end
            character:PivotTo(root.CFrame * CFrame.new(0, 0.75, 1.1))
        end)
        table.insert(genv.connections, bangLoop)
    end
    notify("你为什么运行这个命令？需要帮助吗？", "", 5)
end, {"同性恋模式", "lgbtq"}, 3)

addCommand("循环击杀", function(plrs)
    for i,v in pairs(plrs) do
        if table.find(loopkills, v) then continue end
        table.insert(loopkills, v)
    end
end, {}, 1)

addCommand("取消循环击杀", function(plrs, input)
    if input:lower() == "all" then loopkills = {} return end
    for i,v in pairs(loopkills) do
        if not table.find(plrs, v) then continue end
        table.remove(loopkills, i)
    end
end, {}, 1)

addCommand("静默击杀", function(plrs)
    for i,v in pairs(plrs) do
        local char = v.Character
        if char == nil then continue end
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        local head = char:FindFirstChild("Head")
        if not head then continue end
        local neck = head:FindFirstChild("Neck")
        if not neck then
            local torso = char:FindFirstChild("Torso")
            if torso and torso:FindFirstChild("Neck") then neck = char.Torso.Neck end
        end
        if not (humanoid and humanoid.RequiresNeck and neck) then continue end
        delete(neck)
        repeat task.wait() until humanoid.Health <= 0
        delete(char)
    end
end, {"静默杀", "skill"}, 1)

addCommand("裸体", function(plrs)
    for i,v in pairs(plrs) do
        local char = v.Character
        if char == nil then continue end
        local pants = char:FindFirstChild("Pants")
        local shirt = char:FindFirstChild("Shirt")
        local tshirt = char:FindFirstChild("Shirt Graphic")
        if pants then delete(pants) end
        if shirt then delete(shirt) end
        if tshirt then delete(tshirt) end
        for _,instance in pairs(char:GetDescendants()) do
            if not instance:IsA("WrapLayer") then continue end
            delete(instance.Parent.Parent)
        end
    end
end, {"无衣物", "noclothing"}, 1)

addCommand("秃头", function(plrs)
    for i,v in pairs(plrs) do
        local char = v.Character
        if char == nil then continue end
        for _,instance in pairs(char:GetChildren()) do
            if not instance:IsA("Accessory") then continue end
            delete(instance)
        end
    end
end, {"无帽子", "nohats"}, 1)

addCommand("无肢体", function(plrs)
    for i,v in pairs(plrs) do
        local char = v.Character
        if char == nil then continue end
        for _,instance in pairs(char:GetChildren()) do
            for i,v in pairs(limbs) do
                if not instance.Name:lower():find(v) then continue end
                delete(instance)
            end
        end
    end
end, {}, 1)

addCommand("无手臂", function(plrs)
    for i,v in pairs(plrs) do
        local char = v.Character
        if char == nil then continue end
        for _,instance in pairs(char:GetChildren()) do
            if not instance.Name:lower():find("arm") then continue end
            delete(instance)
        end
    end
end, {}, 1)

addCommand("无腿部", function(plrs)
    for i,v in pairs(plrs) do
        local char = v.Character
        if char == nil then continue end
        for _,instance in pairs(char:GetChildren()) do
            if not (instance.Name:lower():find("leg") or instance.Name:lower():find("foot")) then continue end
            delete(instance)
        end
    end
end, {}, 1)

addCommand("无面部", function(plrs)
    for i,v in pairs(plrs) do
        local char = v.Character
        if char == nil then continue end
        local head = char:FindFirstChild("Head")
        if head == nil then continue end
        for _,instance in pairs(head:GetChildren()) do
            if not instance:IsA("Decal") then continue end
            delete(instance)
        end
    end
end, {}, 1)

addCommand("剥夺身份", function(plrs)
    runCommand("无面部",plrs)
    runCommand("裸体", plrs)
    runCommand("秃头", plrs)
end, {"剥夺", "无身份"}, 1)

addCommand("科布洛克斯", function(plrs)
    for i,v in pairs(plrs) do
        local char = v.Character
        if not char then continue end
        local r6Leg = char:FindFirstChild("Right Leg")
        if r6Leg then
            delete(r6Leg)
            continue
        end
        local r15Leg = char:FindFirstChild("RightUpperLeg")
        if not r15Leg then continue end
        delete(r15Leg)
    end
end, {}, 1)

addCommand("方块头", function(plrs)
    for i,v in pairs(plrs) do
        local char = v.Character
        if not char then continue end
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if not (humanoid and humanoid.RigType == Enum.HumanoidRigType.R6) then continue end
        local head = char:FindFirstChild("Head")
        if not head then continue end
        local mesh = head:FindFirstChildOfClass("SpecialMesh")
        if not mesh then continue end
        delete(mesh)
    end
end, {"去网格头"}, 1)

addCommand("方块帽", function(plrs)
    for i,v in pairs(plrs) do
        local char = v.Character
        if not char then continue end
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if not (humanoid and humanoid.RigType == Enum.HumanoidRigType.R6) then continue end
        for i,hat in pairs(humanoid:GetAccessories()) do
            local handle = hat:FindFirstChild("Handle")
            if not handle then continue end
            local mesh = handle:FindFirstChildOfClass("SpecialMesh") or handle:FindFirstChildOfClass("Mesh")
            if not mesh then continue end
            delete(mesh)
        end
    end
end, {"去网格帽"}, 1)

addCommand("方块工具", function(plrs)
    for i,v in pairs(plrs) do
        local char = v.Character
        if not char then continue end
        local handles = {}
        for i,v in pairs(v.Backpack:GetChildren()) do
            if not (v:IsA("Tool") and v:FindFirstChild("Handle")) then continue end
            table.insert(handles, v.Handle)
        end
        for i,v in pairs(char:GetChildren()) do
            if not (v:IsA("Tool") and v:FindFirstChild("Handle")) then continue end
            table.insert(handles, v.Handle)
        end
        for i,handle in pairs(handles) do
            local mesh = handle:FindFirstChildOfClass("SpecialMesh") or handle:FindFirstChildOfClass("Mesh")
            if not mesh then continue end
            delete(mesh)
        end
    end
end, {"去网格工具"}, 1)

addCommand("大帽子", function(plrs)
    for i,v in pairs(plrs) do
        local char = v.Character
        if not char then continue end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum then continue end
        if hum.RigType ~= Enum.HumanoidRigType.R15 then continue end
        local hats = hum:GetAccessories()
        local scalableHats = {}
        for i,v in pairs(hats) do
            local handle = v:FindFirstChild("Handle")
            if not handle then continue end
            local scaleType = handle:FindFirstChild("AvatarPartScaleType")
            if not scaleType then continue end
            table.insert(scalableHats,v)
        end
        if #scalableHats == 0 then continue end
        task.spawn(function()
            for i,value in pairs(scaleValues) do
                for i, hat in pairs(scalableHats) do
                    local handle = hat:FindFirstChild("Handle")
                    if not handle then continue end
                    local ogSize = handle:WaitForChild("OriginalSize")
                    delete(ogSize)
                    repeat task.wait() until ogSize.Parent ~= handle
                end
                local scaleValue = hum:FindFirstChild(value)
                if not scaleValue then continue end
                delete(scaleValue)
                repeat task.wait() until scaleValue.Parent ~= hum
            end
        end)
    end
end, {"重新缩放帽子", "巨型帽"}, 1)

addCommand("重新缩放", function(plrs)
    for i,v in pairs(plrs) do
        local char = v.Character
        if not char then continue end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum then continue end
        if hum.RigType ~= Enum.HumanoidRigType.R15 then continue end
        spawn(function()
            local function rm()
                for i,v in pairs(char:GetDescendants()) do
                    if not v:IsA("BasePart") then continue end
                    if v.Name == "Handle" or v.Name == "Head" then
                        if not char.Head:FindFirstChild("OriginalSize") then continue end
                        delete(char.Head.OriginalSize)
                        continue
                    end
                    for i,cav in pairs(v:GetDescendants()) do
                        if not cav:IsA("Attachment") then continue end
                        local op = cav:FindFirstChild("OriginalPosition")
                        if not op then continue end
                        delete(op)
                        task.wait(.1)
                    end
                    local os = v:FindFirstChild("OriginalSize")
                    if os then
                        delete(os)
                        task.wait(.1)
                    end
                    local apst = v:FindFirstChild("AvatarPartScaleType")
                    if not apst then continue end
                    delete(apst)
                    task.wait(.1)
                end
            end
            for i,v in pairs(scaleValues) do
                rm()
                task.wait(.1)
                local scale = hum:FindFirstChild(v)
                if not scale then continue end
                delete(scale)
                task.wait(.1)
            end
        end)
    end
end, {"变形"}, 1)

addCommand("布娃娃", function(plrs)
    for i,v in pairs(plrs) do
        local char = v.Character
        if char == nil then continue end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp == nil then continue end
        delete(hrp)
    end
end, {"无HRP"}, 1)

addCommand("沉没", function(plrs)
    for i,v in pairs(plrs) do
        local char = v.Character
        if char == nil then continue end
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid == nil then continue end
        delete(humanoid)
    end
end, {"无人形", "nohum","nohumanoid"}, 2)

addCommand("冻结", function(plrs)
    runCommand("布娃娃", plrs)
    runCommand("无动画", plrs)
end, {}, 2)

addCommand("无动画", function(plrs)
    for i,v in pairs(plrs) do
        local char = v.Character
        if char == nil then continue end
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid == nil then continue end
        local animator = humanoid:FindFirstChildOfClass("Animator")
        if animator == nil then continue end
        delete(animator)
        local animate = char:FindFirstChild("Animate")
        if animate == nil then continue end
        delete(animate)
    end
end, {}, 1)

addCommand("隐形", function(plrs)
    local ignoreList = {"UpperTorso", "Head", "HumanoidRootPart", "Humanoid"}
    for i,v in pairs(plrs) do
        local char = v.Character
        if char == nil then continue end
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid == nil then continue end
        if humanoid.RigType ~= Enum.HumanoidRigType.R15 then continue end
        for _,instance in pairs(char:GetChildren()) do
            if table.find(ignoreList, instance.Name) then continue end
            delete(instance)
        end
        if humanoid.RootPart then humanoid.RootPart.Transparency = 0.6 end
    end
end, {"隐身", "invis"}, 1)

addCommand("腿行走", function(plrs)
    local deleteList = {"LeftUpperArm","RightUpperArm"}
    for i,v in pairs(plrs) do
        local char = v.Character
        if char == nil then continue end
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid == nil then continue end
        if humanoid.RigType ~= Enum.HumanoidRigType.R15 then continue end
        local upperTorso = char:FindFirstChild("UpperTorso")
        if upperTorso == nil then continue end
        local waist = upperTorso:FindFirstChild("Waist")
        if waist == nil then continue end
        for _,instance in pairs(char:GetChildren()) do
            if not (table.find(deleteList, instance.Name) or instance:IsA("Accessory")) then continue end
            delete(instance)
        end
        delete(waist)
    end
end, {"分裂"}, 1)

addCommand("假聊天", function(plrs)
    local localPlayer = game:GetService("Players").LocalPlayer
    local rs = game:GetService("RunService")
    local character = localPlayer.Character
    if not character then return end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not (humanoid and hrp) then return end
    local target
    for _, v in pairs(plrs) do
        if v == localPlayer then continue end
        if not v.Character then continue end
        if not v.Character:FindFirstChild("HumanoidRootPart") then continue end
        target = v
        break
    end
    if not target then return end
    runCommand("取消碰撞")
    runCommand("观察", {target})
    task.wait(0.2)
    if humanoid.RigType == Enum.HumanoidRigType.R15 then
        runCommand("隐形", {localPlayer})
    else
        for _, v in pairs(hrp:GetChildren()) do
            delete(v)
        end
        repeat task.wait() until #hrp:GetChildren() == 0
    end
    local followLoop
    followLoop = rs.Heartbeat:Connect(function()
        if not target.Character then return end
        local thrp = target.Character:FindFirstChild("HumanoidRootPart")
        if not thrp then return end
        local predictedCF = CFrame.new(
            thrp.Position.X + thrp.Velocity.X / 4,
            thrp.Position.Y,
            thrp.Position.Z + thrp.Velocity.Z / 4
        )
        hrp.AssemblyAngularVelocity = Vector3.zero
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.CFrame = (predictedCF * CFrame.new(0, 3, -1.5)) * CFrame.Angles(math.rad(90), 0, 0)
    end)
    table.insert(genv.connections, followLoop)
    table.insert(genv.connections, humanoid.Died:Connect(function()
        if followLoop then followLoop:Disconnect() end
        runCommand("取消观察")
    end))
end, {}, 3)

addCommand("无工具", function(plrs)
    for i,v in pairs(plrs) do
        for _, instance in pairs(v:FindFirstChildOfClass("Backpack"):GetChildren()) do
            if not instance:IsA("BackpackItem") then continue end
            delete(instance)
        end
        local char = v.Character
        if char == nil then continue end
        for _, instance in pairs(char:GetChildren()) do
            if not instance:IsA("BackpackItem") then continue end
            delete(instance)
        end
    end
end, {}, 1)

addCommand("抓取工具", function(plrs, input, caller)
    local callChar = caller.Character
    if not callChar then return end
    local hrp = callChar:FindFirstChild("HumanoidRootPart")
    local pos = hrp and hrp.CFrame or callChar:GetPivot()
    if not pos then return end
    local tools = {}
    for i,v in pairs(workspace:GetDescendants()) do
        if not (v:IsA("Tool") and v:FindFirstChild("Handle")) then continue end
        table.insert(tools, v)
    end
    for i,v in pairs(tools) do
        if not v.Handle:FindFirstChildOfClass("TouchTransmitter") then continue end
        v.Handle.CanCollide = false
        v.Handle.CFrame = pos
    end
end, {"获取所有工具"}, 1)

addCommand("给予工具", function(plrs, input, caller)
    local callChar = caller.Character
    if not callChar then return end
    local callHum = callChar:FindFirstChildOfClass("Humanoid")
    if not callHum then return end
    local callHead = callChar:FindFirstChild("Head")
    if not callHead then return end
    local oldPos = caller == localPlayer and callChar:GetPivot()
    local target = plrs[1]
    if not target then return end
    local tChar = target.Character
    if not tChar then return end
    local tHum = tChar:FindFirstChildOfClass("Humanoid")
    if not tHum then return end
    local thrp = tChar:FindFirstChild("HumanoidRootPart")
    local tools = {}
    for i,v in pairs(callChar:GetChildren()) do
        if not (v:IsA("Tool") and v:FindFirstChild("Handle")) then continue end
        table.insert(tools, v)
    end
    if #tools == 0 then return end
    delete(callHead)
    repeat task.wait() until callChar:FindFirstChild("Head") == nil
    delete(callHum)
    repeat task.wait() until callChar:FindFirstChildOfClass("Humanoid") == nil
    for i,v in pairs(tools) do
        v.Handle.CanCollide = false
        v.Handle.CFrame = thrp and thrp.CFrame or tChar:GetPivot()
    end
    if not oldPos then return end
    localPlayer.CharacterAdded:Wait():PivotTo(oldPos)
end, {"给予", "give"}, 1)

addCommand("偷取工具", function(plrs, input, caller)
    local character = caller.Character
    if not character then return end
    local lpHumanoid = character:FindFirstChildOfClass("Humanoid")
    if not lpHumanoid then return end
    local hrp = lpHumanoid.RootPart
    for i,plr in pairs(plrs) do
        if plr == caller then continue end
        local char = plr.Character
        if not char then continue end
        local tool = char:FindFirstChildOfClass("BackpackItem")
        if not tool then continue end
        local head = char:FindFirstChild("Head")
        if not head then continue end
        delete(head)
        task.wait(0.05)
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            delete(humanoid)
        end
        repeat task.wait() until char:FindFirstChildOfClass("Humanoid") == nil
        task.wait(.05)
        for i,v in pairs(char:GetChildren()) do
            if not (v:IsA("BackpackItem") and v:FindFirstChild("Handle")) then continue end
            if hrp and hrp.Parent then
                v.Handle.CFrame = hrp.CFrame
            end
            lpHumanoid:EquipTool(v)
        end
    end
end, {"偷取", "stools"}, 1)

addCommand("丢弃工具", function(plrs)
    for i,v in pairs(plrs) do
        local char = v.Character
        if not char then continue end
        local arm = char:FindFirstChild("Right Arm") or char:FindFirstChild("RightHand")
        if not arm then continue end
        local function deleteArm()
            if not char:FindFirstChildOfClass("Tool") then return end
            task.wait(.1)
            delete(arm)
        end
        table.insert(genv.connections, arm.ChildAdded:Connect(deleteArm))
        local grip = arm:FindFirstChild("RightGrip")
        if not grip then continue end
        delete(grip)
    end
end, {"碰撞工具"}, 1)

addCommand("惩罚", function(plrs)
    for i,v in pairs(plrs) do
        local char = v.Character
        if not char then continue end
        delete(char)
    end
end, {}, 2)

addCommand("碰撞", function(plrs)
    if not character then return end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end
    runCommand("取消碰撞")
    local target
    for i,v in pairs(plrs) do
        if not v.Character then continue end
        if not v.Character:FindFirstChildOfClass("Humanoid") then continue end
        if not v.Character.Humanoid.RootPart then continue end
        target = v
        break
    end
    bangAnim = Instance.new("Animation")
    bangAnim.AnimationId = (humanoid.RigType ~= Enum.HumanoidRigType.R15) and "rbxassetid://148840371" or "rbxassetid://5918726674"
    bang = humanoid:LoadAnimation(bangAnim)
    bang:Play(0.1, 1, 1)
    bang:AdjustSpeed(3)
    bangLoop = nil
    bangDied = nil;bangDied = humanoid.Died:Connect(function()
        bang:Stop()
        bangAnim:Destroy()
        bangDied:Disconnect()
        if bangLoop then bangLoop:Disconnect() end
    end)
    if target == localPlayer then return end
    bangLoop = rs.Stepped:Connect(function()
        if target.Character == nil then return end
        local hum = target.Character:FindFirstChildOfClass("Humanoid")
        if hum == nil then return end
        local root = hum.RootPart
        if root == nil then return end
        character:PivotTo(root.CFrame * CFrame.new(0, 0.75, 1.1))
    end)
    table.insert(genv.connections,bangLoop)
end, {}, 3)

addCommand("取消碰撞", function()
    if bangDied then bangDied:Disconnect() end
    if bang then bang:Stop() end
    if bangAnim then bangAnim:Destroy() end
    if bangLoop then bangLoop:Disconnect() end
end, {}, 3)

addCommand("清空启动器", function()
    local whitelist = {"BubbleChat", "ChatScript", "PlayerScriptsLoader", "RbxCharacterSounds", "PlayerModule"}
    for i,v in pairs(sgui:GetChildren()) do
        delete(v)
    end
    for i,v in pairs(game:GetService("StarterPack"):GetChildren()) do
        delete(v)
    end
    for i,v in pairs(game:GetService("StarterPlayer"):FindFirstChildOfClass("StarterPlayerScripts"):GetChildren()) do
        if table.find(whitelist, v.Name) then continue end
        delete(v)
    end
    for i,v in pairs(game:GetService("StarterPlayer"):FindFirstChildOfClass("StarterCharacterScripts"):GetChildren()) do
        delete(v)
    end
end, {"清空启动器物品"}, 1)

addCommand("清空界面", function()
    for i,v in pairs(sgui:GetChildren()) do
        delete(v)
    end
end,{"清空sgui", "清空界面元素"}, 1)

addCommand("无聊天",function()
    local chatEvents = rStorage:FindFirstChild("DefaultChatSystemChatEvents")
    if chatEvents then return delete(chatEvents) end
    if not modernChat then return end
    for i,v in pairs(game:GetService("TextChatService"):GetChildren()) do
        delete(v)
    end
end, {"破坏聊天"}, 2)

addCommand("无统计", function(plrs)
    for i,v in pairs(plrs) do
        local stats = v:FindFirstChild("leaderstats")
        if stats == nil then continue end
        delete(stats)
    end
end, {}, 1)

addCommand("删除名称", function(plrs, input)
    for i,v in pairs(game:GetDescendants()) do
        local match = v.Name:lower():gsub(" ","")
        if not match:match(input:lower()) then continue end
        delete(v)
    end
end, {}, 2)

addCommand("清空存储",function()
    for i,v in pairs(rStorage:GetChildren()) do
        if (v == genv.foundRemote) or (modernChat == false and v:IsA("Folder") and v.Name == "DefaultChatSystemChatEvents") then continue end
        delete(v)
    end
end, {"清空rs","清空复制存储", "clearreplicatedstorage"}, 1)

addCommand("清空工作区", function()
    for i,v in pairs(workspace:GetChildren()) do
        if players:GetPlayerFromCharacter(v) then continue end
        delete(v)
    end
end, {}, 2)

addCommand("锁定工作区", function()
    for i,v in pairs(workspace:GetChildren()) do
        if players:FindFirstChild(v.Name) then continue end
        local con = v.ChildAdded:Connect(function(instance)
            if players:FindFirstChild(instance.Parent.Name) then return end
            task.wait()
            delete(instance)
        end)
        table.insert(genv.connections,con)
        table.insert(wslocks,con)
    end
    local con = workspace.ChildAdded:Connect(function(instance)
        if players:FindFirstChild(instance.Name) then return end
        task.wait()
        delete(instance)
    end)
    table.insert(genv.connections,con)
    table.insert(wslocks,con)
end, {}, 1)

addCommand("解锁工作区", function()
    for i,v in pairs(wslocks) do
        v:Disconnect()
    end
end, {}, 1)

addCommand("无纹理", function()
    for i,v in pairs(workspace:GetChildren()) do
        if players:GetPlayerFromCharacter(v) then continue end
        if (v:IsA("Decal") or v:IsA("Texture")) then delete(v) end
        for _,instance in pairs(v:GetDescendants()) do
            if not (instance:IsA("Decal") or instance:IsA("Texture")) then continue end
            delete(instance)
        end
    end
end, {}, 1)

addCommand("基板", function()
    if not character then return end
    local hum = character:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    local hrp = hum.RootPart
    if not hrp then return end
    local function isPlate(instance)
        if not (instance:IsA("BasePart")) then return end
        local distance = (instance.Position - hrp.Position).Magnitude
        local size = instance.Size.Magnitude
        if distance <= 7 or size >= 1000 or instance.Name:lower():gsub(" ",""):find("baseplate") then return true end
        return false
    end
    for i,v in pairs(workspace:GetChildren()) do
        if players:GetPlayerFromCharacter(v) then continue end
        if isPlate(v) == false then delete(v) continue end
        for _,instance in pairs(v:GetDescendants()) do
            if isPlate(instance) then continue end
            delete(instance)
        end
    end
end,{"平台"}, 2)

addCommand("无生成点", function()
    for i,v in pairs(workspace:GetDescendants()) do
        if not v:IsA("SpawnLocation") then continue end
        delete(v)
    end
end, {}, 1)

addCommand("解焊工作区", function()
    for i,v in pairs(workspace:GetChildren()) do
        if players:GetPlayerFromCharacter(v) then continue end
        for _, instance in pairs(v:GetDescendants()) do
            if not (instance:IsA("Weld") or instance:IsA("Attachment") or v:IsA("Motor6D")) then continue end
            delete(instance)
        end
        if not (v:IsA("Weld") or v:IsA("Attachment") or v:IsA("Motor6D")) then continue end
        delete(v)
    end
end, {}, 1)

addCommand("无座位", function()
    for i,v in pairs(workspace:GetChildren()) do
        if players:GetPlayerFromCharacter(v) then continue end
        for _, instance in pairs(v:GetDescendants()) do
            if not (instance:IsA("VehicleSeat") or instance:IsA("Seat")) then continue end
            delete(instance)
        end
        if not (v:IsA("VehicleSeat") or v:IsA("Seat")) then continue end
        delete(v)
    end
end, {}, 1)

addCommand("无声音",function()
    for i,v in pairs(game:GetDescendants()) do
        if not v:IsA("Sound") then continue end
        delete(v)
    end
end, {}, 1)

addCommand("无队伍", function()
    for i,v in pairs(game:GetService("Teams")) do
        delete(v)
    end
end, {}, 1)

addCommand("清空照明",function()
    for i,v in pairs(game:GetService("Lighting"):GetChildren()) do
        delete(v)
    end
end, {}, 1)

addCommand("关闭服务器", function()
    for i,v in pairs(players:GetPlayers()) do
        if i == 1 then continue end
        delete(v)
    end
    delete(localPlayer)
end, {}, 2)

addCommand("核弹",function()
    for i,v in pairs(workspace:GetChildren()) do
        delete(v)
    end
    for i,v in pairs(players:GetPlayers()) do
        if i == 1 then continue end
        delete(v)
    end
end, {}, 2)

addCommand("凋零工作区",function(plrs, input)
    local speedInp = input:split(" ")[2]
    local speed = speedInp and tonumber(speedInp) or .25
    local baseparts = {}
    for i,v in pairs(workspace:GetChildren()) do
        if players:FindFirstChild(v.Name) then continue end
        if v:IsA("BasePart") then
            table.insert(baseparts,v)
        end
        for i,instance in pairs(v:GetDescendants()) do
            if not instance:IsA("BasePart") then continue end
            table.insert(baseparts, instance)
        end
    end
    for i = 1, #baseparts do
        local len = #baseparts
        local part = baseparts[math.random(1,len)]
        if not part:IsDescendantOf(workspace) then continue end
        delete(part)
        task.wait(speed)
    end
end, {}, 2)

addCommand("凋零",function(plrs, input)
    local speedInp = input:split(" ")[2]
    local speed = speedInp and tonumber(speedInp) or 1
    local function decay(plr)
        local char = plr.Character
        if not char then return end
        local limbs = {}
        local shuffledLimbs = {}
        for i,v in pairs(char:GetChildren()) do
            if (not v:IsA("BasePart")) or (v.Name:find("Torso") or v.Name == "Head" or v.Name == "HumanoidRootPart") then continue end
            table.insert(limbs, v)
        end
        for i = 1, #limbs do
            local rng = math.random(#limbs)
            table.insert(shuffledLimbs , limbs[rng])
            table.remove(limbs, rng)
        end
        for i,v in pairs(shuffledLimbs) do
            if not char:FindFirstChild(v.Name) then continue end
            if plr.Character ~= char then return end
            delete(v)
            table.remove(limbs,i)
            task.wait(speed)
        end
        local head = char:FindFirstChild("Head")
        if not head then return end
        delete(head)
        task.wait(0.1)
        for i,v in pairs(char:GetChildren()) do
            if not v:IsA("BasePart") then continue end
            delete(v)
        end
    end
    for i,v in pairs(plrs) do
        task.spawn(decay,v)
    end
end, {"衰变"}, 1)

local infectSpeed = 1
local function infectPlayer(plr)
    local char = plr.Character
    if not char then return end
    debugPrint(`{plr.Name} 被感染了`)
    local limbs = {}
    local limbAmount
    local shuffledLimbs = {}
    for i,v in pairs(char:GetChildren()) do
        if (not v:IsA("BasePart")) or (v.Name:find("Torso") or v.Name == "Head" or v.Name == "HumanoidRootPart") then continue end
        table.insert(limbs, v)
    end
    limbAmount = #limbs
    for i = 1, #limbs do
        local rng = math.random(#limbs)
        table.insert(shuffledLimbs , limbs[rng])
        table.remove(limbs, rng)
    end
    for i,v in pairs(shuffledLimbs) do
        task.wait((45/limbAmount) * infectSpeed)
        local infectedIndex = table.find(infected,plr)
        if not char:FindFirstChild(v.Name) then continue end
        if plr.Character ~= char then return end
        delete(v)
        table.remove(limbs,i)
    end
    local head = char:FindFirstChild("Head")
    if head then
        delete(head)
        task.wait(0.1)
    end
    for i,v in pairs(char:GetChildren()) do
        if not v:IsA("BasePart") then continue end
        delete(v)
    end
    table.remove(infected,table.find(infected,plr))
end

table.insert(genv.connections,rs.Heartbeat:Connect(function()
    for i,v in pairs(infected) do
        local char = v.Character
        if not char then continue end
        local hum = char:FindFirstChild("Humanoid")
        if hum and hum.Health <= 0 then table.remove(infected,table.find(infected,v)) continue end
        local hrp = hum and hum.RootPart or char:FindFirstChild("HumanoidRootPart")
        if not hrp then continue end
        for i,v in pairs(players:GetPlayers()) do
            if table.find(infected,v) then continue end
            local tchar = v.Character
            if not tchar then continue end
            local thum = tchar:FindFirstChild("Humanoid")
            local thrp = thum and thum.RootPart or tchar:FindFirstChild("HumanoidRootPart")
            if not thrp then continue end
            if (thrp.Position - hrp.Position).Magnitude >= 5 then continue end
            table.insert(infected, v)
            task.spawn(infectPlayer,v)
        end
    end
end))

addCommand("病毒",function(plrs, input)
    local speedInp = input:split(" ")[2]
    local speed = speedInp and tonumber(speedInp) or 0
    infectSpeed = speed
    for i,v in pairs(plrs) do
        table.insert(infected,v)
        task.spawn(infectPlayer,v)
    end
end, {"感染"}, 1)

addCommand("取消病毒", function(plrs)
    for i,v in pairs(plrs) do
        local index = table.find(infected,v)
        if index then table.remove(infected,index) end
    end
end, {"取消感染", "治愈"}, 1)

table.insert(genv.connections, rs.Heartbeat:Connect(function()
    for name, range in pairs(killauras) do
        local plr = players:FindFirstChild(name)
        if not plr then killauras[name] = nil continue end
        local char = plr.Character
        if not char then continue end
        local pos = char:GetPivot().Position
        for i,v in pairs(players:GetPlayers()) do
            if v == plr then continue end
            local tchar = v.Character
            if not tchar then continue end
            local tpos = tchar:GetPivot().Position
            local distance = (pos - tpos).Magnitude
            if distance > range then continue end
            local hum = tchar:FindFirstChild("Humanoid")
            if hum and hum.Health <= 0 then continue end
            runCommand("杀死",{v})
        end
    end
end))

addCommand("击杀光环",function(plrs, input)
    local plrs = (#plrs > 0 and plrs) or ({localPlayer})
    local split = input:split(" ")
    local range = tonumber(split[#split]) or 10
    for i,v in pairs(plrs) do
        killauras[v.Name] = range
    end
end, {"光环"}, 1)

addCommand("取消击杀光环",function(plrs)
    for i,v in pairs(plrs) do
        killauras[v.Name] = nil
    end
end, {"取消光环"}, 1)

table.insert(genv.connections, rs.Heartbeat:Connect(function()
    for name, range in pairs(kickauras) do
        local plr = players:FindFirstChild(name)
        if not plr then kickauras[name] = nil continue end
        local char = plr.Character
        if not char then continue end
        local pos = char:GetPivot().Position
        for i,v in pairs(players:GetPlayers()) do
            if v == nil or v == plr then continue end
            local tchar = v.Character
            if not tchar then continue end
            local tpos = tchar:GetPivot().Position
            local distance = (pos - tpos).Magnitude
            if distance > range then continue end
            delete(v)
        end
    end
end))

addCommand("踢出光环",function(plrs, input)
    local plrs = (#plrs > 0 and plrs) or ({localPlayer})
    local split = input:split(" ")
    local range = tonumber(split[#split]) or 3
    for i,v in pairs(plrs) do
        kickauras[v.Name] = range
    end
end, {}, 2)

addCommand("取消踢出光环",function(plrs)
    for i,v in pairs(plrs) do
        kickauras[v.Name] = nil
    end
end, {}, 2)

addCommand("关闭", abort, {"退出"}, 3)

local flyLoop
addCommand("飞行",function()
    local hum = character:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    hum.PlatformStand = true
    hrp.Anchored = true
    if flyLoop then flyLoop:Disconnect() end
    flyLoop = rs.Heartbeat:Connect(function(deltaTime)
        local moveDir = hum.MoveDirection * (flySpeed * deltaTime)
        local hrpCF = hrp.CFrame
        local cameraCF = camera.CFrame
        local cameraOffset = hrpCF:ToObjectSpace(cameraCF).Position + hum.CameraOffset
        cameraCF = cameraCF * CFrame.new(-cameraOffset.X, -cameraOffset.Y, -cameraOffset.Z + 1)
        local cameraPos = cameraCF.Position
        local hrpPos = hrpCF.Position
        local objectSpaceVelocity = CFrame.new(cameraPos, Vector3.new(hrpPos.X, cameraPos.Y, hrpPos.Z)):VectorToObjectSpace(moveDir)
        hrp.CFrame = CFrame.new(hrpPos) * (cameraCF - cameraPos) * CFrame.new(objectSpaceVelocity)
    end)
end, {}, 3)

addCommand("取消飞行",function()
    if not flyLoop then return end
    flyLoop:Disconnect()
    local hum = character:FindFirstChildOfClass("Humanoid")
    if hum then hum.PlatformStand = false end
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if hrp then hrp.Anchored = false end
end, {}, 3)

addCommand("飞行速度",function(plrs, input)
    flySpeed = tonumber(input) or 50
end, {}, 3)

addCommand("移动速度", function(plrs, input)
    local speed = tonumber(input) or 16
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return end
    humanoid.WalkSpeed = speed
end, {"速度", "ws"}, 3)

addCommand("跳跃力量", function(plrs, input)
    local jp = tonumber(input) or 50
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return end
    humanoid.JumpPower = jp
end, {"跳跃", "jp"}, 3)

local noclipLoop
addCommand("穿墙", function()
    if noclipLoop then noclipLoop:Disconnect() end
    noclipLoop = rs.Stepped:Connect(function()
        for i,v in pairs(character:GetDescendants()) do
            if not (v:IsA("BasePart") and v.CanCollide) then continue end
            v.CanCollide = false
        end
    end)
end, {"穿墙模式", "nc"}, 3)

addCommand("取消穿墙",function()
    if noclipLoop then noclipLoop:Disconnect() end
end, {"取消穿墙模式", "c"}, 3)

addCommand("帽子轨道",function()
    local char = character
    local hum = char:FindFirstChild("Humanoid")
    if not hum then return end
    local hats = {}
    local mov = {}
    local mov2 = {}
    local function breakJoints(model)
        for i,v in pairs(model:GetDescendants()) do
            if not v:IsA("JointInstance") then continue end
            delete(v)
        end
    end
    local function ftp(str)
        local pt = {}
        if str ~= "me" and str ~= "random" then
            for i, v in pairs(players:GetPlayers()) do
                if v.Name:lower():find(str:lower()) then
                    table.insert(pt, v)
                end
            end
        elseif str == "me" then
            table.insert(pt, localPlayer)
        elseif str == "random" then
            table.insert(pt, players:GetPlayers()[math.random(1, #players:GetPlayers())])
        end
        return pt
    end
    for i,v in pairs(hum:GetAccessories()) do
        local handle = v:FindFirstChild("Handle")
        if not handle then continue end
        table.insert(hats,v)
    end
    for _, v in pairs(hats) do
        local handle = v.Handle
        handle.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
        handle.CanCollide = false
        breakJoints(handle)
        repeat task.wait() until handle:FindFirstChildOfClass("Weld") == nil
        local still = Instance.new("BodyAngularVelocity", handle)
        still.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        still.AngularVelocity = Vector3.new(0, 0, 0)
        local align = Instance.new("AlignPosition", handle)
        align.MaxForce = 1000000
        align.MaxVelocity = math.huge
        align.RigidityEnabled = false
        align.ApplyAtCenterOfMass = true
        align.Responsiveness = 200
        local a0 = Instance.new("Attachment", handle)
        local a1 = Instance.new("Attachment", char.Head)
        align.Attachment0 = a0
        align.Attachment1 = a1
        table.insert(mov, a1)
        table.insert(mov2, still)
    end
    local velocityCon = rs.Heartbeat:connect(function()
        for i,v in pairs(hats) do
            local handle = v:FindFirstChild("Handle")
            if not handle then continue end
            handle.Velocity = Vector3.new(0,30,0)
        end
    end)
    table.insert(genv.connections, velocityCon)
    local par = {}
    local partsFolder = Instance.new("Folder", char)
    partsFolder.Name = "部件文件夹"
    for _, v in pairs(mov) do
        local part = Instance.new("Part", partsFolder)
        part.Anchored = true
        part.Size = Vector3.new(1, 1, 1)
        part.Transparency = 1
        part.CanCollide = false
        table.insert(par, part)
    end
    local rotx = 0
    local rotz = math.pi / 2
    local height = 0
    local heighti = 1
    local offset = 10
    local speed = 0.5
    local mode = 4
    local angular = Vector3.new(0, 0, 0)
    local l = 1
    local alignCon = rs.RenderStepped:Connect(function()
        rotx = rotx + speed / 100
        rotz = rotz + speed / 100
        l = (l >= 360 and 1 or l + speed)
        for i, v in pairs(par) do
            v.CFrame = CFrame.new(char.HumanoidRootPart.Position) * CFrame.fromEulerAnglesXYZ(0, math.rad(l + (360 / #par) * i + speed), 0) * CFrame.new(offset, 0, 0)
        end
        if heighti == 1 then
            height = height + speed / 100
        elseif heighti == 2 then
            height = height - speed / 100
        end
        if height > 2 then
            heighti = 2
        end
        if height < -1 then
            heighti = 1
        end
        if mode == 1 then
            for _, v in pairs(mov) do
                v.Position = Vector3.new(math.sin(rotx) * offset, 0, math.sin(rotz) * offset)
            end
        elseif mode == 2 then
            for _, v in pairs(mov) do
                v.Position = Vector3.new(offset, height, offset)
            end
        elseif mode == 3 then
            for _, v in pairs(mov) do
                v.Position = Vector3.new(math.sin(rotx) * offset, height, math.sin(rotz) * offset)
            end
        elseif mode == 4 then
            for i, v in pairs(mov) do
                v.Position = Vector3.new(char.HumanoidRootPart.CFrame:ToObjectSpace(CFrame.new(par[i].Position)).X, char.HumanoidRootPart.CFrame:ToObjectSpace(CFrame.new(par[i].Position)).Y, char.HumanoidRootPart.CFrame:ToObjectSpace(CFrame.new(par[i].Position)).Z)
            end
        elseif mode == 5 then
            for i, v in pairs(mov) do
                v.Position = Vector3.new((math.sin(rotx)) * offset, height, (math.cos(rotz) - i) * offset)
            end
        elseif mode == 6 then
            for i, v in pairs(mov) do
                v.Position = Vector3.new((math.sin(rotx)) * offset, height, (math.tan(rotz) - i) * offset)
            end
        elseif mode == 7 then
            for i, v in pairs(mov) do
                v.Position = Vector3.new(math.cos(rotx * i) * offset, 0, math.cos(rotz * i) * offset)
            end
        elseif mode == 8 then
            for i, v in pairs(mov) do
                v.Position = Vector3.new(math.sin(rotx) * i * offset, 0, math.sin(rotz) * i * offset)
            end
        elseif mode == 9 then
            pcall(function()
                local so = nil
                for k, b in pairs(char:GetChildren()) do
                    if not b:IsA"Tool" then
                        for h, j in pairs(b:GetDescendants()) do
                            if j:IsA"Sound" then
                                so = j
                            end
                        end
                    end
                end
                if so ~= nil then
                    offset = so.PlaybackLoudness / 35
                    speed = so.PlaybackLoudness / 500
                    angular = Vector3.new(0, so.PlaybackLoudness / 75, 0)
                end
            end)
            for i, v in pairs(mov) do
                v.Position = Vector3.new(char.HumanoidRootPart.CFrame:ToObjectSpace(CFrame.new(par[i].Position)).X, char.HumanoidRootPart.CFrame:ToObjectSpace(CFrame.new(par[i].Position)).Y, char.HumanoidRootPart.CFrame:ToObjectSpace(CFrame.new(par[i].Position)).Z)
            end
        elseif mode == 10 then
            offset = height * 15
            for i, v in pairs(mov) do
                v.Position = Vector3.new(char.HumanoidRootPart.CFrame:ToObjectSpace(CFrame.new(par[i].Position)).X, char.HumanoidRootPart.CFrame:ToObjectSpace(CFrame.new(par[i].Position)).Y, char.HumanoidRootPart.CFrame:ToObjectSpace(CFrame.new(par[i].Position)).Z)
            end
        elseif mode == 11 then
            for i, v in pairs(mov) do
                v.Position = Vector3.new(char.HumanoidRootPart.CFrame:ToObjectSpace(CFrame.new(localPlayer:GetMouse().Hit.p)).X, char.HumanoidRootPart.CFrame:ToObjectSpace(CFrame.new(localPlayer:GetMouse().Hit.p)).Y, char.HumanoidRootPart.CFrame:ToObjectSpace(CFrame.new(localPlayer:GetMouse().Hit.p)).Z) + Vector3.new(char.HumanoidRootPart.CFrame:ToObjectSpace(CFrame.new(par[i].Position)).X, char.HumanoidRootPart.CFrame:ToObjectSpace(CFrame.new(par[i].Position)).Y, char.HumanoidRootPart.CFrame:ToObjectSpace(CFrame.new(par[i].Position)).Z)
            end
        end
        for _, v in pairs(mov2) do
            v.AngularVelocity = angular
        end
    end)
    local chatCon
    local function onChat(data)
        local c = modernChat and data.Text or data
        local plr = modernChat and players:GetPlayerByUserId(data.TextSource.UserId) or localPlayer
        if plr ~= localPlayer then return end
        if c:split(" ")[1] == ".orbit" then
            for _, v in pairs(mov) do
                char = ftp(c:split(" ")[2])[1].Character
                v.Parent = ftp(c:split(" ")[2])[1].Character.HumanoidRootPart
            end
        end
        if c:split(" ")[1] == ".speed" then
            speed = tonumber(c:split(" ")[2])
        end
        if c:split(" ")[1] == ".mode" then
            mode = tonumber(c:split(" ")[2])
        end
        if c:split(" ")[1] == ".offset" then
            offset = tonumber(c:split(" ")[2])
        end
        if c:split(" ")[1] == ".angular" then
            angular = Vector3.new(tonumber(c:split(" ")[2]), tonumber(c:split(" ")[3]), tonumber(c:split(" ")[4]))
        end
    end
    if modernChat then
        game:GetService("TextChatService").TextChannels["RBXGeneral"].OnIncomingMessage = function(data)
            task.spawn(onChat,data)
            handleChat(data)
        end
    else
        chatCon = localPlayer.Chatted:Connect(onChat)
        table.insert(genv.connections, chatCon)
    end
    local diedCon = hum.Died:Connect(function()
        alignCon:Disconnect()
        velocityCon:Disconnect()
        if not modernChat then
            chatCon:Disconnect()
        else
            game:GetService("TextChatService").TextChannels["RBXGeneral"].OnIncomingMessage = function(data)
                handleChat(data)
            end
        end
    end)
    table.insert(genv.connections, diedCon)
end, {}, 3)

local function loadReanim()
    local char = localPlayer.Character or localPlayer.CharacterAdded:Wait()
    local hum = char:WaitForChild("Humanoid")
    local simRadius = gethiddenproperty and gethiddenproperty(localPlayer,"SimulationRadius")
    local requiredRadius = 20
    local isR15 = hum.RigType == Enum.HumanoidRigType.R15
    local forcefield = char:FindFirstChildOfClass("ForceField")
    local fakeHum = hum:Clone()
    local hrp = char:WaitForChild("HumanoidRootPart")
    local hrpCF = hrp.CFrame
    local stopAlign = false
    local stopAntiVoid = false
    local limbs = {}
    local hatHandles = {}
    local reanimConnections = {}
    runCommand("取消穿墙")
    if simRadius and simRadius < requiredRadius then
        repeat
            notify("请等待",`等待更大的模拟半径 ({tostring(math.floor(simRadius))}/{tostring(requiredRadius)})`, 2)
            task.wait(2)
        until gethiddenproperty(localPlayer,"SimulationRadius") >= requiredRadius
        if localPlayer.Character == nil or localPlayer.Character ~= char or hum.Parent == nil or hum.Health <= 0 then return end
    end
    if forcefield then forcefield:Destroy() end
    char.Archivable = true
    local rig = (not isR15) and char:Clone()
    if isR15 then
        local canGetObjects, loadedRig = pcall(function() return game:GetObjects("rbxassetid://18418211383")[1] end)
        local r6Rig = isTesting and rStorage:WaitForChild("R6Rig") or canGetObjects and loadedRig or loadstring(httpget("https://gist.githubusercontent.com/someunknowndude/ad264038a91f7fa11bec2f67dad3feaf/raw"))()
        local humDesc = players:GetCharacterAppearanceAsync(localPlayer.UserId)
        local r6Head = r6Rig.Head
        local r15Head = char.Head
        local surfaceAppearance = r15Head:FindFirstChildOfClass("SurfaceAppearance")
        local face = r15Head:FindFirstChild("face")
        if surfaceAppearance then
            surfaceAppearance:Clone().Parent = r6Head
        else
            --if face then r6Head.face.Texture = face.Texture end
            --r6Head.face.Transparency = 0
        end
        for i,v in pairs(r15Head:GetChildren()) do
            if not v:IsA("Attachment") then continue end
            v:Clone().Parent = r6Head
        end
        for i,v in pairs(humDesc:GetDescendants()) do
            if v:IsA("BodyColors") or v:IsA("CharacterMesh") or v:IsA("ShirtGraphic") then
                v.Parent = r6Rig
                continue
            end
            if v:IsA("Accessory") or v:IsA("Hat") then
                r6Rig:WaitForChild("Humanoid"):AddAccessory(v)
            end
        end
        rig = r6Rig
    else
        local mesh = char.Head:FindFirstChildOfClass("SpecialMesh")
        local face = char.Head:FindFirstChild("face")
        if mesh and face then
            delete(face)
        end
    end
    local rigHRP = rig:WaitForChild("HumanoidRootPart")
    local rigHum = rig:FindFirstChild("Humanoid")
    rig.Name = "复活动作"
    for i,v in pairs(char:GetChildren()) do
        if not v:IsA("BasePart") then continue end
        table.insert(limbs, {v,rig[v.Name]})
    end
    local accessories = hum:GetAccessories()
    local rigAccessories = rigHum:GetAccessories()
    for i,v in pairs(accessories) do
        if not isR15 then
            table.insert(hatHandles,{v.Handle,rigAccessories[i].Handle})
            continue
        end
        for _,rigAcc in pairs(rigAccessories) do
            local handle = rigAcc.Handle
            local mesh = handle:FindFirstChildOfClass("SpecialMesh") or handle
            local texture = handle == mesh and mesh.TextureID or mesh.TextureId
            if not (rigAcc.Name == v.Name and mesh.MeshId == v.Handle.MeshId and texture == v.Handle.TextureID) then continue end
            table.insert(hatHandles,{v.Handle,rigAcc.Handle})
            continue
        end
    end
    local clock = os and os.clock or tick
    local cos = math.cos
    local sin = math.sin
    local cfNew = CFrame.new
    local cfZero = CFrame.identity
    local v3New = Vector3.new
    local v3Zero = Vector3.zero
    local changedMaxSimRad = pcall(sethiddenproperty, localPlayer, "MaximumSimulationRadius", 1000)
    local changedSimRad = pcall(sethiddenproperty, localPlayer, "SimulationRadius", 1000)
    local netlessCF = cfZero
    local sineValue = 0
    local function align(part0, part1, offset)
        if stopAlign then return end
        if part0 and part0.Parent and part1 and part1.Parent then
            local part0_mass = part1.Mass * 5
            part0.AssemblyLinearVelocity = v3New(part1.AssemblyLinearVelocity.X * part0_mass, sineValue, part1.AssemblyLinearVelocity.Z * part0_mass)
            part0.AssemblyAngularVelocity = part1.AssemblyAngularVelocity
            if isnetworkowner(part0) then
                part0.CFrame = part1.CFrame * offset
            end
        end
    end
    local function setCamera(model)
        local oldCamCF = camera.CFrame
        camera.CameraSubject = model.Humanoid
        camera:GetPropertyChangedSignal("CFrame"):Once(function()
            camera.CFrame = oldCamCF
        end)
    end
    local function disableCollisions(model,canTouchAndCast)
        for _, part in next, model:GetDescendants() do
            if part and part:IsA("BasePart") then
                part.CanCollide = false
                part.CanQuery = canTouchAndCast
                part.CanTouch = canTouchAndCast
            end
        end
    end
    local function makeTransparent(model)
        for i,v in pairs(model:GetDescendants()) do
            if not (v:IsA("BasePart") or v:IsA("Decal")) then continue end
            v.Transparency = 1
        end
    end
    local function breakJoints(model)
        for i,v in pairs(model:GetDescendants()) do
            if not v:IsA("JointInstance") then continue end
            delete(v)
        end
    end
    local function removeScripts(model)
        for i,v in pairs(model:GetChildren()) do
            if not (v:IsA("Script") or v:IsA("LocalScript") or v:IsA("ModuleScript") or v.Name == "Animate") then continue end
            delete(v)
        end
    end
    local function removeTouchTriggers(model)
        for i,v in pairs(model:GetDescendants()) do
            if not v:IsA("TouchTransmitter") then continue end
            delete(v)
        end
    end
    local function onPostSim()
        for _, data in next, limbs do
            align(data[1], data[2],netlessCF)
        end
        for _, data in next, hatHandles do
            align(data[1], data[2], netlessCF)
        end
    end
    local function onPreSim()
        netlessCF = cfNew(0.01 * sin(clock()*16), 0, 0.01 * math.cos(clock()*16))
        sineValue = 40 - 3 * sin(clock()*10)
        if stopAntiVoid or rigHRP.Position.Y > (workspace.FallenPartsDestroyHeight + 50) then return end
        rigHRP.CFrame = hrpCF
        rigHRP.AssemblyLinearVelocity = v3Zero
        rigHRP.AssemblyAngularVelocity = v3Zero
    end
    rigHRP.CFrame = hrpCF
    rig.Parent = workspace
    localPlayer.Character = rig
    setCamera(rig)
    rig.Animate.Enabled = false
    rig.Animate.Enabled = true
    hum:ChangeState(Enum.HumanoidStateType.Physics)
    repeat task.wait() until limbs[3][1].CanCollide
    task.wait(0.05)
    delete(hum)
    repeat task.wait() until hum.Parent == nil
    task.wait()
    fakeHum.Parent = char
    task.wait()
    table.insert(reanimConnections, rs.PreSimulation:Connect(onPreSim))
    table.insert(reanimConnections, rs.PostSimulation:Connect(onPostSim))
    table.insert(reanimConnections, rs.Stepped:Connect(function()
        disableCollisions(char,false)
        disableCollisions(rig,true)
    end))
    breakJoints(char)
    makeTransparent(char)
    removeScripts(char)
    removeTouchTriggers(char)
    genv.LoadLibrary = function(lib) return loadstring(httpget("https://raw.githubusercontent.com/Roblox/Core-Scripts/master/CoreScriptsRoot/Libraries/" .. lib .. ".lua"))() end
    local reset = Instance.new("BindableEvent")
    reset.Event:Connect(function()
        if stopAlign then
            local hum = character:FindFirstChildOfClass("Humanoid")
            if not hum then return character:BreakJoints() end
            hum.Health = 0
            return
        end
        notify("重置中", "请等待约6秒", 6)
        stopAntiVoid = true
        rigHRP.Anchored = true
        rigHRP.CFrame = CFrame.new(0,workspace.FallenPartsDestroyHeight + 5,0)
        task.wait(0.5)
        stopAlign = true
        rigHum:ChangeState(Enum.HumanoidStateType.Dead)
        localPlayer.CharacterAdded:Wait()
        rig:Destroy()
        for i,v in pairs(reanimConnections) do
            v:Disconnect()
        end
    end)
    sgui:SetCore("ResetButtonCallback", reset)
    notify("成功！", "复活已加载！")
end

addCommand("复活",function()
    task.spawn(loadReanim)
end, {"复活动作"}, 3)

--[[添加滚动命令列表]]--
local scrollText = "QuirkyCMD由Cynatica制作 | 最佳管理员滥用工具！ | "
if not isMobile then
    scrollText ..= "按 ; 打开/隐藏界面 | "
end
local charCount = 12
local spaces = 0
local scrollSpeed = 0.12 -- 秒/字符
local sample = scrollText..string.rep(" ", spaces)
local displayString = sample:sub(1, charCount)
local strlen = string.len(sample)
local counter = 1
local timer = 0
for i,v in pairs(scrollText:split("")) do
    if v ~= " " then continue end
    spaces += 1
end
table.insert(genv.connections, rs.Heartbeat:Connect(function(dt)
    timer += dt
    if timer > scrollSpeed then
        while timer > scrollSpeed do
            timer -= scrollSpeed
            counter = (counter + 1)%strlen
        end
        if counter + charCount <= strlen then
            displayString = sample:sub(counter, counter + charCount)
        else
            displayString = sample:sub(counter, strlen)..sample:sub(1, counter + charCount - strlen)
        end
    end
    box.PlaceholderText = (("%s"):format(displayString))
end))

--[[按字母顺序排序命令]]--
table.sort(commands, function(a,b)
    return a.name < b.name
end)

--[[命令列表及描述]]--
local cmdData = {
    ["admin"] = "授予或移除管理员权限",
    ["aliases"] = "打印所有命令别名。",
    ["bald"] = "移除角色所有饰品，使其秃头。",
    ["ban"] = "通过用户ID封禁玩家并将其从服务器删除。",
    ["bang"] = "播放'碰撞'动画并附着到目标玩家。",
    ["baseplate"] = "删除工作区中除大型或附近基板外的所有内容。",
    ["bighats"] = "通过删除缩放值和原始大小来放大R15帽子。",
    ["blockhats"] = "移除R6角色的帽子网格。",
    ["blockhead"] = "移除R6角色的头部网格。",
    ["blocktools"] = "移除工具手柄上的所有网格，清理其视觉效果。",
    ["bring"] = "使用工具传送将另一名玩家传送到你身边。",
    ["btools"] = "操纵工具（给予/移除）",
    ["clearbans"] = "清空封禁列表。",
    ["cleargui"] = "从屏幕上移除所有GUI元素（从sgui）。",
    ["clearlighting"] = "删除照明服务的所有子项。",
    ["clearstarter"] = "清除StarterGui、StarterPack和StarterPlayer脚本，白名单项除外。",
    ["clearstorage"] = "删除复制存储中除利用远程事件和聊天文件夹外的所有对象。",
    ["clearws"] = "清除工作区中所有非玩家物品。",
    ["clickdelete"] = "通过鼠标瞄准启用点击删除模式。",
    ["clip"] = "禁用穿墙模式，恢复正常碰撞。",
    ["cmds"] = "显示命令界面",
    ["control"] = "使用工具劫持控制另一名玩家的角色。",
    ["deletename"] = "删除游戏中名称与给定文本匹配的任何对象。",
    ["droptools"] = "玩家装备工具时删除它，模拟掉落和损坏。",
    ["explorer"] = "打开黑暗主题的Dex资源管理器GUI。",
    ["fakechat"] = "让你的角色看起来像在聊天并自动跟随另一名玩家。",
    ["fling"] = "通过接触角色使用物理力抛掷玩家。",
    ["fly"] = "通过操纵角色的根部位位置启用飞行模式。",
    ["flyspeed"] = "设置飞行移动的速度倍率。",
    ["freeze"] = "通过锚定人形并设置平台站立来停止所有角色移动。",
    ["givetools"] = "将你的工具传送到目标玩家位置以强制装备。",
    ["goto"] = "传送到目标玩家的位置。",
    ["grabtools"] = "将工作区中的所有工具拉到你的角色处。",
    ["gun"] = "操纵工具（给予/移除）",
    ["hatorbit"] = "使用物理对齐让你的帽子围绕角色旋转。",
    ["invisible"] = "使用透明度技巧或HRP删除使角色隐形。",
    ["jumppower"] = "设置你人形的跳跃力量。",
    ["kick"] = "将玩家从游戏中删除（客户端）。",
    ["kickaura"] = "自动踢出距离过近的玩家（在指定范围内）。",
    ["kill"] = "删除颈部关节，杀死玩家。",
    ["killaura"] = "基于范围循环自动击杀附近玩家。",
    ["korblox"] = "删除角色的右腿以模拟科布洛克斯头像。",
    ["legwalk"] = "删除上臂、腰部关节和饰品以制作仅腿部行走的骨架。",
    ["lockws"] = "通过在新非玩家对象出现时删除它们来防止其被添加到工作区。",
    ["loopkill"] = "每帧对目标玩家重复执行击杀命令。",
    ["mute"] = "删除玩家的TextChatService文本频道以禁言他们。不适用于旧版聊天。",
    ["naked"] = "移除裤子、衬衫和衬衫图案以及WrapLayer元素，使角色视觉上赤裸。",
    ["noanims"] = "删除玩家的Animator和Animate脚本以完全停止所有动画。",
    ["noarms"] = "删除角色的所有手臂部位（名称中包含'arm'的任何肢体）。",
    ["nochat"] = "删除聊天界面或频道，禁用聊天。",
    ["noclip"] = "禁用所有角色部位的碰撞，允许穿过物体。",
    ["noface"] = "删除玩家头部的所有面部贴花。",
    ["nolegs"] = "从角色中删除腿部和脚部。",
    ["nolimbs"] = "删除所有手臂和腿部。",
    ["noseats"] = "删除工作区中的所有座位和载具座位。",
    ["nosounds"] = "删除整个游戏中的所有声音对象。",
    ["nospawns"] = "删除所有生成点实例。",
    ["nostats"] = "删除玩家的leaderstats文件夹。",
    ["noteams"] = "删除游戏中的所有队伍。",
    ["notextures"] = "删除工作区中的所有贴花和纹理。",
    ["notools"] = "操纵工具（给予/移除）",
    ["nuke"] = "删除所有工作区对象和玩家（本地玩家除外）。",
    ["owner"] = "将玩家提升到权限级别2（所有者）。",
    ["punch"] = "给予玩家一个拳击工具，可以在接触时杀死他人。",
    ["punish"] = "删除目标玩家的整个角色。",
    ["ragdoll"] = "删除玩家的HumanoidRootPart，造成布娃娃效果。",
    ["ranks"] = "打印所有管理员和所有者的列表。",
    ["reanim"] = "启动复活例程（在可见脚本中未完全实现）。",
    ["rejoin"] = "传送玩家（重新加入或切换服务器）",
    ["rescale"] = "删除头像缩放值（高度缩放、宽度缩放等）。",
    ["reset"] = "移动角色部位以杀死玩家并触发重生。",
    ["serverlock"] = "通过在玩家加入时删除他们来防止玩家加入服务器。",
    ["setbind"] = "设置切换命令栏的按键绑定。",
    ["setprefix"] = "更改用于输入命令的前缀。",
    ["shutdown"] = "删除所有玩家（包括本地玩家）以强制关闭。",
    ["silentkill"] = "与杀死相同，但之后还会删除角色。",
    ["sink"] = "删除玩家的人形，禁用移动。",
    ["skydive"] = "将玩家传送到高空并让其坠落。",
    ["stealtools"] = "杀死另一名玩家的角色后窃取其工具。",
    ["stripidentity"] = "对目标执行裸体、秃头和无面部。",
    ["torsofling"] = "使用躯干通过增加速度来抛掷人。",
    ["unadmin"] = "授予或移除管理员权限",
    ["unban"] = "将玩家从封禁列表中移除。",
    ["unbang"] = "停止碰撞动画。",
    ["unclickdelete"] = "禁用点击删除模式。",
    ["unfly"] = "禁用飞行模式并恢复默认移动。",
    ["unkickaura"] = "禁用自动踢出附近玩家。",
    ["unkillaura"] = "禁用自动击杀附近玩家。",
    ["unlockws"] = "停止工作区反创建保护（lockws）。",
    ["unloopkill"] = "将玩家从循环击杀列表中移除。",
    ["unowner"] = "移除玩家的所有者权限。",
    ["unserverlock"] = "禁用服务器锁定。",
    ["unsit"] = "通过删除座位焊接强制玩家站立。",
    ["untorsofling"] = "禁用躯干抛掷模式。",
    ["unview"] = "将摄像机从观察另一名玩家重置。",
    ["unvirus"] = "取消病毒的效果。",
    ["unweldws"] = "删除工作区部件的所有焊接、附件和Motor6D。",
    ["view"] = "将你的摄像机切换到跟随目标玩家。",
    ["virus"] = "用破坏性行为感染玩家或工作区。",
    ["walkspeed"] = "设置你的移动速度。",
    ["wither"] = "随时间慢慢删除玩家的肢体。",
    ["witherws"] = "随时间慢慢删除工作区部件。",
    ["close"] = "通过销毁界面并断开所有事件来安全关闭QuirkyCMD。",
}

--[[正确缩放和创建命令列表及其描述]]--
for _, v in ipairs(commands) do
    local level = v.securityLevel
    local name = v.name
    local clone = cmdTemplate:Clone()
    local desc = cmdData[name:lower()] or "无描述"
    clone.Text = name .. ` ({rankNames[level]}) - ` .. desc
    clone.Font = Enum.Font.Gotham
    clone.TextSize = 13
    clone.TextColor3 = Color3.new(1, 1, 1)
    clone.TextWrapped = true
    clone.TextScaled = false
    clone.TextXAlignment = Enum.TextXAlignment.Left
    clone.TextYAlignment = Enum.TextYAlignment.Top
    clone.LineHeight = 1.1
    clone.Size = UDim2.new(1, 0, 0, 40)
    clone.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    clone.BorderSizePixel = 0
    clone.Visible = true
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = clone
    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, 5)
    padding.PaddingBottom = UDim.new(0, 5)
    padding.PaddingLeft = UDim.new(0, 10)
    padding.PaddingRight = UDim.new(0, 10)
    padding.Parent = clone
    clone.Parent = cmdsList
end

closeButton.MouseButton1Click:Connect(function()
    cmdsFrame.Visible = false
end)

--[[添加拖拽功能]]--
local dragging
local dragInput
local dragStart
local startPos
local lastMousePos
local lastGoalPos
local dragSpeed = 20
local function update(dt)
    if not (startPos) then return end
    if not (dragging) and (lastGoalPos) then
        cmdsFrame.Position = UDim2.new(startPos.X.Scale, lerp(cmdsFrame.Position.X.Offset, lastGoalPos.X.Offset, dt * dragSpeed), startPos.Y.Scale, lerp(cmdsFrame.Position.Y.Offset, lastGoalPos.Y.Offset, dt * dragSpeed))
        return
    end
    local delta = (lastMousePos - uis:GetMouseLocation())
    local xGoal = (startPos.X.Offset - delta.X)
    local yGoal = (startPos.Y.Offset - delta.Y)
    lastGoalPos = UDim2.new(startPos.X.Scale, xGoal, startPos.Y.Scale, yGoal)
    cmdsFrame.Position = UDim2.new(startPos.X.Scale, lerp(cmdsFrame.Position.X.Offset, xGoal, dt * dragSpeed), startPos.Y.Scale, lerp(cmdsFrame.Position.Y.Offset, yGoal, dt * dragSpeed))
end

cmdsFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = cmdsFrame.Position
        lastMousePos = uis:GetMouseLocation()
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

cmdsFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

table.insert(genv.connections,rs.Heartbeat:Connect(update))

--[[发送到游戏记录器]]--
if not inDatabase then
    local function promptCallback(answer)
        if answer == "否" then return end
        local sg = localPlayer:FindFirstChildOfClass("StarterGear")
        if sg then
            delete(sg)
            task.wait(checkTime + mobileOffset)
        end
        if (sg and sg.Parent == localPlayer) or (isTesting == false and game:GetService("GuiService"):GetErrorCode() ~= Enum.ConnectionError.OK) then return notify("记录器错误", "游戏无法记录。", 10) end
        sendGame()
        debugPrint("游戏已发送到服务器")
    end
    local bindable = Instance.new("BindableFunction")
    bindable.OnInvoke = promptCallback
    sgui:SetCore("SendNotification", {
        Title = "QuirkyCMD";
        Text = "你想要记录这个游戏吗？（点击是前请先测试命令）",
        Duration = 300,
        Button1 = "是",
        Button2 = "否",
        Icon = "rbxassetid://73191850208831",
        Callback = bindable
    })
end

debugPrint("QuirkyCMD 加载成功！")