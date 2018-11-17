local background = {
    name = "background",
    form = {x = 1,y = 1, width = 51, height = 19, color = colors.white, visible = true}
}

local text = {
    name = "text",
    obj = {text = "", textColor = colors.lightGray},
    form = {x = 3,y = 4, width = 15, height = 1, color = colors.gray, visible = true}
    }

local xPos,yPos = 3,6
local buttons = {
    {
        name = "1",
        obj = {text = "1", textColor = colors.white, touch = function() text.obj.text = text.obj.text ..1 end},
        form = {x = xPos,y = yPos, width = 5, height = 3, color = colors.blue, visible = true}
        },
    {
        name = "2",
        obj = {text = "2", textColor = colors.white, touch = function() text.obj.text = text.obj.text ..2 end},
        form = {x = xPos+5,y = yPos, width = 5, height = 3, color = colors.blue, visible = true}
        },
    {
        name = "3",
        obj = {text = "3", textColor = colors.white, touch = function() text.obj.text = text.obj.text ..3 end},
        form = {x = xPos+10,y = yPos, width = 5, height = 3, color = colors.blue, visible = true}
        },
    {
        name = "4",
        obj = {text = "4", textColor = colors.white, touch = function() text.obj.text = text.obj.text ..4 end},
        form = {x = xPos,y = yPos+3, width = 5, height = 3, color = colors.blue, visible = true}
        },
    {
        name = "5",
        obj = {text = "5", textColor = colors.white, touch = function() text.obj.text = text.obj.text ..5 end},
        form = {x = xPos+5,y = yPos+3, width = 5, height = 3, color = colors.blue, visible = true}
        },
    {
        name = "6",
        obj = {text = "6", textColor = colors.white, touch = function() text.obj.text = text.obj.text ..6 end},
        form = {x = xPos+10,y = yPos+3, width = 5, height = 3, color = colors.blue, visible = true}
        },
    {
        name = "7",
        obj = {text = "7", textColor = colors.white, touch = function() text.obj.text = text.obj.text ..7 end},
        form = {x = xPos,y = yPos+6, width = 5, height = 3, color = colors.blue, visible = true}
        },
    {
        name = "8",
        obj = {text = "8", textColor = colors.white, touch = function() text.obj.text = text.obj.text ..8 end},
        form = {x = xPos+5,y = yPos+6, width = 5, height = 3, color = colors.blue, visible = true}
        },
    {
        name = "9",
        obj = {text = "9", textColor = colors.white, touch = function() text.obj.text = text.obj.text ..9 end},
        form = {x = xPos+10,y = yPos+6, width = 5, height = 3, color = colors.blue, visible = true}
        },
    {
        name = ">",
        obj = {text = ">", textColor = colors.white, touch = function()
        if text.obj.text == "2512" then
        pas = true
        else
        text.obj.text = ""
        end
        end
        },
        form = {x = xPos,y = yPos+9, width = 5, height = 3, color = colors.green, visible = true}
        },
    {
        name = "0",
        obj = {text = "0", textColor = colors.white, touch = function() text.obj.text = text.obj.text ..0 end},
        form = {x = xPos+5,y = yPos+9, width = 5, height = 3, color = colors.blue, visible = true}
        },
    {
        name = "C",
        obj = {text = "C", textColor = colors.white, touch = function() text.obj.text = "" end},
        form = {x = xPos+10,y = yPos+9, width = 5, height = 3, color = colors.red, visible = true}
        },
}

indicator = {
    name = "ind",
    obj = {text = "", textColor = colors.white, touch = function() end},
    form = {x = 51,y = 19, width = 1, height = 1, color = colors.red, visible = true}
    }

close = {
    name = "close",
    obj = {text = "Close", textColor = colors.white},
    form = {x = 33,y = 15, width = 15, height = 3, color = colors.blue, visible = false}
    }

close.obj.touch = function()
    pas = false
    text.obj.text = ""
    close.form.visible = false
    indicator.form.color = colors.red

    redstone.setOutput("left", false)
end

c = manager:new()
c:add(simple:new(background))
c:add(textField:new(text))
c:add(button:new(indicator))
c:add(button:new(close))
for i = 1, #buttons, 1 do
    c:add(button:new(buttons[i]))
end

function update()
    if pas == true and text.obj.text == "2512" then
        indicator.form.color = colors.green
        close.form.visible = true
        redstone.setOutput("left", true)
    end
end


while true do
    update()
    c:use()
end
