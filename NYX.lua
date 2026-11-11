--[[
    NYX EGG FINDER ULTRA
    Visual-only interface prototype
    Version 1.0
]]

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local USER_KEY = "Raytescript1020012"
local ADMIN_KEY = "NYX-ADMIN-DEMO"
local KEY_LINK = "https://is.gd/4nvARi"

local MIN_RATE = 100

local Eggs = {
    {Name="Celestial Sovereign", Rate=2400, Rarity="DIVINO"},
    {Name="Void Crown Egg", Rate=850, Rarity="SECRETO"},
    {Name="Prismatic Dragon", Rate=420, Rarity="MITICO"},
    {Name="Solar Titan", Rate=180, Rarity="LEGENDARIO"},
    {Name="Ancient Ember", Rate=105, Rarity="EPICO"}
}

local function create(class, props, parent)
    local obj = Instance.new(class)
    for k,v in pairs(props) do
        obj[k] = v
    end
    obj.Parent = parent
    return obj
end

local gui = create("ScreenGui", {
    Name="NYX_EGG_FINDER",
    ResetOnSpawn=false
}, PlayerGui)

local keyFrame = create("Frame", {
    Size=UDim2.fromOffset(310,190),
    Position=UDim2.new(0.5,-155,0.5,-95),
    BackgroundColor3=Color3.fromRGB(12,17,23)
},gui)

create("UICorner",{CornerRadius=UDim.new(0,12)},keyFrame)

create("TextLabel",{
    Size=UDim2.new(1,0,0,45),
    BackgroundTransparency=1,
    Text="NYX KEY SYSTEM",
    TextColor3=Color3.fromRGB(65,230,155),
    TextSize=22,
    Font=Enum.Font.GothamBold
},keyFrame)

local input = create("TextBox",{
    Size=UDim2.new(1,-30,0,38),
    Position=UDim2.fromOffset(15,55),
    BackgroundColor3=Color3.fromRGB(28,37,46),
    PlaceholderText="Enter your KEY",
    Text="",
    TextColor3=Color3.new(1,1,1),
    Font=Enum.Font.Gotham,
    TextSize=14,
    ClearTextOnFocus=false
},keyFrame)

local getKey = create("TextButton",{
    Size=UDim2.fromOffset(130,35),
    Position=UDim2.fromOffset(15,105),
    Text="GET KEY",
    BackgroundColor3=Color3.fromRGB(25,125,85),
    TextColor3=Color3.new(1,1,1),
    Font=Enum.Font.GothamBold,
    TextSize=13
},keyFrame)

local verify = create("TextButton",{
    Size=UDim2.fromOffset(130,35),
    Position=UDim2.fromOffset(165,105),
    Text="VERIFY",
    BackgroundColor3=Color3.fromRGB(35,85,125),
    TextColor3=Color3.new(1,1,1),
    Font=Enum.Font.GothamBold,
    TextSize=13
},keyFrame)

local message = create("TextLabel",{
    Size=UDim2.new(1,-20,0,25),
    Position=UDim2.fromOffset(10,150),
    BackgroundTransparency=1,
    Text="Waiting for KEY...",
    TextColor3=Color3.fromRGB(180,190,200),
    TextSize=11
},keyFrame)

getKey.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(KEY_LINK)
    end
    message.Text="KEY link copied. Open it in your browser."
end)

local function openPanel()
    keyFrame:Destroy()

    local panel = create("Frame",{
        Size=UDim2.fromOffset(320,380),
        Position=UDim2.new(0.5,-160,0.5,-190),
        BackgroundColor3=Color3.fromRGB(12,17,23),
        Active=true
    },gui)

    create("UICorner",{CornerRadius=UDim.new(0,12)},panel)

    local title = create("TextLabel",{
        Size=UDim2.new(1,-55,0,45),
        BackgroundTransparency=1,
        Text="NYX EGG FINDER",
        TextColor3=Color3.fromRGB(65,230,155),
        TextSize=18,
        Font=Enum.Font.GothamBold
    },panel)

    local close = create("TextButton",{
        Size=UDim2.fromOffset(40,35),
        Position=UDim2.new(1,-45,0,5),
        Text="X",
        BackgroundColor3=Color3.fromRGB(100,35,40),
        TextColor3=Color3.new(1,1,1)
    },panel)

    local list = create("TextLabel",{
        Size=UDim2.new(1,-20,1,-105),
        Position=UDim2.fromOffset(10,65),
        BackgroundColor3=Color3.fromRGB(20,28,36),
        TextColor3=Color3.new(1,1,1),
        TextSize=13,
        Font=Enum.Font.Gotham,
        TextXAlignment=Enum.TextXAlignment.Left,
        TextYAlignment=Enum.TextYAlignment.Top
    },panel)

    local scan = create("TextButton",{
        Size=UDim2.new(1,-20,0,35),
        Position=UDim2.fromOffset(10,320),
        Text="SCAN EGGS 100B+",
        BackgroundColor3=Color3.fromRGB(25,125,85),
        TextColor3=Color3.new(1,1,1),
        Font=Enum.Font.GothamBold
    },panel)

    local function refresh()
        local output="VISUAL DEMO - SAMPLE DATA\n\n"
        for _,egg in ipairs(Eggs) do
            if egg.Rate >= MIN_RATE then
                output=output..egg.Name..
                    "\n"..egg.Rarity..
                    " | "..egg.Rate.."B/s\n\n"
            end
        end
        list.Text=output
    end

    scan.MouseButton1Click:Connect(refresh)
    close.MouseButton1Click:Connect(function()
        panel.Visible=false
    end)

    local reopen=create("TextButton",{
        Size=UDim2.fromOffset(75,35),
        Position=UDim2.new(1,-85,0.5,0),
        Text="NYX OPEN",
        Visible=false,
        BackgroundColor3=Color3.fromRGB(25,125,85),
        TextColor3=Color3.new(1,1,1)
    },gui)

    close.MouseButton1Click:Connect(function()
        reopen.Visible=true
    end)

    reopen.MouseButton1Click:Connect(function()
        panel.Visible=true
        reopen.Visible=false
    end)

    refresh()
end

verify.MouseButton1Click:Connect(function()
    if input.Text==USER_KEY or input.Text==ADMIN_KEY then
        openPanel()
    else
        message.Text="Invalid KEY"
    end
end)
