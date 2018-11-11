button = {}

extended(button, simple)

function button:redraw()

  local x = math.ceil(self.arg.form.width/2 - string.len(self.arg.obj.text)/2)+1
	local y = math.ceil(self.arg.form.height/2)
  self:body()
  self.form.setTextColor(self.arg.obj.textColor)
  self.form.setCursorPos(x,y)
  self.form.write(self.arg.obj.text)
end

function button:touch()
  self.arg.obj.touch()
end
