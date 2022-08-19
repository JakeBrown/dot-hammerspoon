hyper = {"cmd", "ctrl", "alt", "shift"}


hs.application.enableSpotlightForNameSearches(true)

function AskforReboot()
    test = hs.chooser.new(RebootIfChoice)
    test:rows(2)
    test:choices({
            {["text"] = "Abort", ["subText"] = ""},
            {["text"] = "Quit Current", ["subText"] = ""},
            {["text"] = "Quit All", ["subText"] = ""}
            })
    test:show()
end
function RebootIfChoice(input)
    -- local  = input.uuid
    if input.text == "Quit Current" then
        hs.alert.show("Quitting current")
        hs.application.frontmostApplication():kill()
    elseif input.text == "Quit All" then
        hs.alert.show("Quitting all")
        QuitAll()
    elseif input.text == "Abort" then
        hs.alert.show("Aborting")
    end
    
end

hs.hotkey.bind({"cmd"}, "q", function()
    -- hs.dialog.blockAlert("Main message.", "Please enter something:", "OK", "Cancel", "NSCriticalAlertStyle")
    AskforReboot()
end)

hs.hotkey.bind(hyper, "n", function()
    hs.alert.show(hs.application.frontmostApplication():name())
    hs.alert.show(hs.screen.allScreens()[1]:name())
end)

hs.hotkey.bind(hyper, "l", function()
    hs.caffeinate.lockScreen()
end)

hs.hotkey.bind(hyper, "Left", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    f.x = max.x
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
    win:setFrame(f)
end)

hs.hotkey.bind(hyper, "Right", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    f.x = max.x + max.w / 2
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
    win:setFrame(f)
end)

hs.hotkey.bind(hyper, "Up", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    f.x = max.x
    f.y = max.y
    f.w = max.w
    f.h = max.h
    win:setFrame(f)
end)

hs.hotkey.bind(hyper, "o", function()
    hs.application.open("Safari")
    hs.application.open("iTerm")
    hs.application.open("Sublime Text")
    hs.application.open("OmniFocus")
    hs.application.open("Visual Studio Code")
    hs.application.open("Obsidian")
    hs.application.open("Microsoft Teams")
    hs.application.open("Microsoft Outlook")
    hs.application.open("DEVONthink 3")
    hs.application.open("Finder")
    hs.application.open("Drafts")
    hs.application.open("Calendar")
    hs.alert.show("Done")
end)

hs.hotkey.bind({}, "F13", function()
    out = hs.application.open("iTerm")
end)

hs.hotkey.bind({}, "F14", function()
    out = hs.application.open("Safari")
end)

hs.hotkey.bind({}, "F15", function()
    hs.application.open("Obsidian")
end)

hs.hotkey.bind({}, "F16", function()
    hs.application.open("Drafts")
end)


function QuitAll()
    a = hs.application.find("iTerm")
    if (a ~= nil) then
        a:kill()
    end
    a = hs.application.find("Sublime Text")
    if (a ~= nil) then
        a:kill()
    end
    a = hs.application.find("Omnifocus")
    if (a ~= nil) then
        a:kill()
    end
    a = hs.application.find("Code")
    if (a ~= nil) then
        a:kill()
    end
    a = hs.application.find("Obsidian")
    if (a ~= nil) then
        a:kill()
    end
    a = hs.application.find("Microsoft Teams")
    if (a ~= nil) then
        a:kill()
    end
    a = hs.application.find("Microsoft Outlook")
    if (a ~= nil) then
        a:kill()
    end
    a = hs.application.find("DEVONthink 3")
    if (a ~= nil) then
        a:kill()
    end
    a = hs.application.find("Finder")
    if (a ~= nil) then
        a:kill()
    end
    a = hs.application.find("Drafts")
    if (a ~= nil) then
        a:kill()
    end
    a = hs.application.find("Safari")
    if (a ~= nil) then
        a:kill()
    end
    hs.caffeinate.lockScreen()
end

local laptopScreen = "Studio Display"
local windowLayout = {{"Safari", nil, laptopScreen, hs.layout.maximized, nil, nil},

                      {"Code", nil, laptopScreen, hs.layout.maximized, nil, nil},

                      {"iTerm2", nil, laptopScreen, hs.layout.left50, nil, nil},
                      {"Sublime Text", nil, laptopScreen, hs.layout.right50, nil, nil},

                      {"Obsidian", nil, laptopScreen, hs.layout.left50, nil, nil},
                      {"Drafts", nil, laptopScreen, hs.layout.right50, nil, nil},

                      {"DEVONthink 3", nil, laptopScreen, hs.layout.left50, nil, nil},
                      {"Finder", nil, laptopScreen, hs.layout.right50, nil, nil},

                      {"Microsoft Teams", nil, laptopScreen, hs.layout.left50, nil, nil},
                      {"Microsoft Outlook", nil, laptopScreen, hs.layout.right50, nil, nil},

                      {"OmniFocus", nil, laptopScreen, hs.layout.left50, nil, nil},
                      {"Calendar", nil, laptopScreen, hs.layout.right50, nil, nil}}

hs.hotkey.bind(hyper, "Down", function()
    hs.layout.apply(windowLayout)
end)

hs.spaces.watcher.new(function()
    if hs.screen.allScreens()[1]:name()==laptopScreen then
        hs.layout.apply(windowLayout)
    end
end):start()

hs.hotkey.bind(hyper, "v", function()
    hs.eventtap.keyStrokes(hs.pasteboard.getContents())
end)

function reloadConfig(files)
    doReload = false
    for _, file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()

caffeine = hs.menubar.new()
function setCaffeineDisplay(state)
    if state then
        caffeine:setTitle("💊")
    else
        caffeine:setTitle("🌙")
    end
end

function caffeineClicked()
    setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
end

if caffeine then
    caffeine:setClickCallback(caffeineClicked)
    setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
end




hs.alert.show("Config loaded")

