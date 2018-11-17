textBox = {}

extended(textBox, simple)

function textBox:init()
	self.textShow = 1
end

function textBox:redraw()

	self:initText()

  local x,y = 1,1
	local min

	if #self.textArray < self.arg.form.height then
		min = #self.textArray
	else
		min = self.arg.form.height
	end

  self.form.setCursorPos(x,y)
  self:body()
  self.form.setTextColor(self.arg.obj.textColor)

	local n = 1

  for i = self.textShow, min+self.textShow-1, 1 do
		self.form.setCursorPos(1,n)
		self.form.write(self.textArray[i])
		n = n + 1
  end

	for i = 1, self.arg.form.width-1, 1 do
		self.form.setCursorPos(i,self.arg.form.height)
		self.form.write("-")
	end

	self.form.setCursorPos(self.arg.form.width,1)
	self.form.write("^")
	self.form.setCursorPos(self.arg.form.width,self.arg.form.height-1)
	self.form.write("v")
	self.form.setCursorPos(self.arg.form.width,self.arg.form.height)
	self.form.write("#")

end

function textBox:initText()

	self.textArray = {}

	local text = self.arg.obj.text
	local str = ""
	local x, y = 1, 1

	while x ~= string.len(text)+1 do
		for i = 1, self.arg.form.width-1, 1 do
			if x == string.len(text)+1  then
				break
			end

			if string.sub(text, x,x) == string.char(92) then
				if string.sub(text, x+1,x+1) == "n" then
					x = x + 2
					break
				end
			end

			str = str ..string.sub(text, x, x)
			x = x + 1
		end

		self.textArray[y] = str
		str = ""
		y = y + 1
	end
end



function textBox:touch(x,y)
	if x == self.arg.form.x + self.arg.form.width-1 and y == self.arg.form.y + self.arg.form.height-1 then
		local event, button, x, y = os.pullEvent("mouse_up")
		if (x ~= self.arg.form.x + self.arg.form.width-1 or y ~= self.arg.form.y + self.arg.form.height-1) and (x-self.arg.form.x+1 >= 3 and y-self.arg.form.y+1 >= 3) then
			self.arg.form.width = x-self.arg.form.x+1
			self.arg.form.height = y-self.arg.form.y+1
			self.textShow = 1
		else
			self.textShow = 1
			if x-self.arg.form.x+1 < 3 then
				self.arg.form.width = 3
			else
				self.arg.form.width = x-self.arg.form.x+1
			end

			if y-self.arg.form.y+1 < 3 then
				self.arg.form.height = 3
			else
				self.arg.form.height = y-self.arg.form.y+1
			end
		end
	elseif x == self.arg.form.x + self.arg.form.width-1 and y == self.arg.form.y then
		local event, button, x, y = os.pullEvent("mouse_up")
		if self.textShow ~= 1 then
			self.textShow = self.textShow - 1
		end
	elseif x == self.arg.form.x + self.arg.form.width-1 and y == self.arg.form.y + self.arg.form.height-2 then
		local event, button, x, y = os.pullEvent("mouse_up")
		if self.textShow < #self.textArray-self.arg.form.height+2 then
			self.textShow = self.textShow + 1
		end
	end
end

function textBox:scroll(x, y, dir)
	if dir == 1 then
		if self.textShow < #self.textArray-self.arg.form.height+2 then
			self.textShow = self.textShow + 1
		end
	elseif dir == -1 then
		if self.textShow ~= 1 then
			self.textShow = self.textShow - 1
		end
	end
end
