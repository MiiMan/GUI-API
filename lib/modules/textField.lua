textField = {}

extended(textField, simple)

function textField:redraw()
    self:body()

    self.form.setCursorPos(1,1)
    self.form.setTextColor(self.arg.obj.textColor)
    self.form.write(self.arg.obj.text)
end
