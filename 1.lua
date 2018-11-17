

arg = {
name = "TextBox 1",
obj = {text = "", textColor = colors.lightGray},
form = {x = 2,y = 2, width = 49, height = 15, color = colors.black, visible = true}
}

arg2 = {
name = "sim",
form = {x = 1,y = 1, width = 51, height = 19, color = colors.white, visible = true}}
a = simple:new(arg2)
b = textBox:new(arg)
butt1 = {name = "button1",
obj = {text = "Push", textColor = colors.white, touch = function() arg.obj.text = arg.obj.text.. rd.obj.line end},
form = {x = 41,y = 17, width = 11, height = 3, color = colors.green, visible = true}}

butt2 = {name = "button2",
obj = {text = "Dont Push", textColor = colors.white, touch = function() arg.obj.textColor = colors.red end},
form = {x = 7,y = 17, width = 11, height = 3, color = colors.red, visible = true}}

butt3 = {name = "button3",
obj = {text = "<", textColor = colors.white, touch = function() butt1.form.x = butt1.form.x-1 end},
form = {x = 1,y = 17, width = 3, height = 3, color = colors.blue, visible = true}}

butt4 = {name = "button3",
obj = {text = ">", textColor = colors.white, touch = function() butt1.form.x = butt1.form.x+1 end},
form = {x = 4,y = 17, width = 3, height = 3, color = colors.blue, visible = true}}



check = {name = "checkBox",
obj = {text = "Show", textColor = colors.lightGray, position = true, firstBackgroundColor = colors.black},
form = {x = 26,y = 18, width = 11, height = 1, color = colors.gray, visible = false}}

rd = {name = "readBox",
obj = {textColor = colors.lightGray, line = ""},
form = {x = 19,y = 18, width = 20, height = 1, color = colors.gray, visible = true}}


d = button:new(butt1)
del = button:new(butt2)
c = manager:new()
c:add(a)
c:add(b)
c:add(d)
c:add(del)
c:add(button:new(butt3))
c:add(button:new(butt4))
c:add(checkBox:new(check))
c:add(readBox:new(rd))
while true do
    c:use()
    if check.obj.position == false then
        butt2.form.visible = false
    else
        butt2.form.visible = true
    end
end
c:redraw()
