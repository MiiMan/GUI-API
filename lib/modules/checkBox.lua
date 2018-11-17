checkBox = {}

extended(checkBox, simple)


function checkBox:redraw()
    self:body()
    self.form.setTextColor(self.arg.obj.textColor)
    self.form.setCursorPos(1,1)
    self.form.setBackgroundColor(self.arg.obj.firstBackgroundColor)
    if self.arg.obj.position == true then
        self.form.write("X")
    else
        self.form.write(" ")
    end
    self.form.setCursorPos(2,1)
    self.form.setBackgroundColor(self.arg.form.color)
    self.form.write(self.arg.obj.text)
end


function checkBox:touch(x,y)
    if x == self.arg.form.x and y == self.arg.form.y then
        if self.arg.obj.position == true then
            self.arg.obj.position = false
        else
            self.arg.obj.position = true
        end
    end
end
