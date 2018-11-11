function colorPalette()
	local oldColor, color
	oldColor = term.getBackgroundColor()
	if oldColor == colors.gray then
		color = colors.lightGray
	else
		color = colors.gray
	end

	local oldTextColor = term.getTextColor()
	if term.getBackgroundColor() == colors.white then
		term.setTextColor(colors.black)
	else
		term.setTextColor(colors.white)
	end

	return oldColor, color, oldTextColor
end
function getCenter(xSize, ySize)
	if not x or y then
		x,y = term.getSize()
	end
	if not xSize then
		xSize = 0
	end
	if not ySize then
		ySize = 0
	end
	x = math.floor(x/2 - xSize/2)
	y = math.floor(y/2 - ySize/2)
	
	return x,y
end
function readLine( _sReplaceChar, _size )
    term.setCursorBlink( true )

    local sLine = ""
    local nHistoryPos
    local nPos = 0
    if _sReplaceChar then
        _sReplaceChar = string.sub( _sReplaceChar, 1, 1 )
    end

    if _size == nil then
    	_size = 99
    end

    local w = term.getSize()
    local sx = term.getCursorPos()

    local function redraw( _bClear )
        local nScroll = 0
        if sx + nPos >= w then
            nScroll = (sx + nPos) - w
        end

        local cx,cy = term.getCursorPos()
        term.setCursorPos( sx, cy )
        local sReplace = (_bClear and " ") or _sReplaceChar
        if sReplace then
            write( string.rep( sReplace, math.max( string.len(sLine) - nScroll, 0 ) ) )
        else
            write( string.sub( sLine, nScroll + 1 ) )
        end

        term.setCursorPos( sx + nPos - nScroll, cy )
    end
    
    redraw()

    while true do
        local sEvent, param = os.pullEvent()
        if sEvent == "char" and string.len(sLine) ~= _size then
            redraw( true )
            sLine = string.sub( sLine, 1, nPos ) .. param .. string.sub( sLine, nPos + 1 )
            nPos = nPos + 1
            redraw()
        elseif sEvent == "key" then
            if param == keys.enter then
                break
            elseif param == keys.left then
                if nPos > 0 then
                    redraw( true )
                    nPos = nPos - 1
                    redraw()
                end
            elseif param == keys.right then               
                if nPos < string.len(sLine) then
                    redraw( true )
                    nPos = nPos + 1
                    redraw()
                end
            elseif param == keys.backspace then
                if nPos > 0 then
                    redraw( true )
                    sLine = string.sub( sLine, 1, nPos - 1 ) .. string.sub( sLine, nPos + 1 )
                    nPos = nPos - 1
                    redraw()
                end
            elseif param == keys.home then
                if nPos > 0 then
                    redraw( true )
                    nPos = 0
                    redraw()
                end
            elseif param == keys.delete then
                if nPos < string.len(sLine) then
                    redraw( true )
                    sLine = string.sub( sLine, 1, nPos ) .. string.sub( sLine, nPos + 2 )                
                    redraw()
                end
            elseif param == keys["end"] then
                if nPos < string.len(sLine ) then
                    redraw( true )
                    nPos = string.len(sLine)
                    redraw()
                end
            end
        elseif sEvent == "term_resize" then
            w = term.getSize()
            redraw()
        elseif sEvent == "mouse_click" then
        	break
        end
    end

    local cx, cy = term.getCursorPos()
    term.setCursorBlink( false )
    term.setCursorPos( w + 1, cy )
    print()
    
    return sLine
end
function drawPixelG(xPos, yPos, xSize, ySize, color)
	local oldColor = term.getBackgroundColor()
	term.setBackgroundColor(color)
	for i = xPos, xSize+xPos-1, 1 do
		for g = yPos, ySize+yPos-1, 1 do
			term.setCursorPos(i,g)
			write(" ")
		end
	end
	term.setBackgroundColor(oldColor)
end
function drawPixel(xPos, yPos, color)
	local oldColor = term.getBackgroundColor()
	term.setBackgroundColor(color)
	term.setCursorPos(xPos,yPos)
	write(" ")
	term.setBackgroundColor(oldColor)
end

---------------------------------------------
contextMenu = {}
function contextMenu:new(xPos,yPos,table)

	local lenght = string.len(table[1])
	for i = 1, #table do
		element = string.len(table[i])
		if element > lenght then
			lenght = element
		end
	end

	local oldColor, color = colorPalette()

	local arg = {}
		arg.xPos = xPos
		arg.yPos = yPos
		arg.table = table
		arg.oldColor = oldColor
		arg.color = color
		arg.oldTextColor = oldTextColor
		arg.lenght = lenght

	function arg:draw(sel)
		term.setCursorPos(self.xPos,self.yPos)
		for i = 1, #table do
			if i ~= sel then
				term.setBackgroundColor(self.oldColor)
				for g = 1, self.lenght+1 do
					write(" ")
				end
				term.setCursorPos(self.xPos,self.yPos+i-1)
				write(" " ..self.table[i])
				term.setCursorPos(self.xPos,self.yPos+i)
			else
				term.setCursorPos(self.xPos+1,self.yPos+i-1)
				term.setBackgroundColor(self.color)
				for g = 1, self.lenght do
					write(" ")
				end
				term.setCursorPos(self.xPos,self.yPos+i-1)
				write(">" ..self.table[i])
				term.setCursorPos(self.xPos,self.yPos+i)
			end
		end
	end

	function arg:use()
		self:draw(1)
		self.oldColor = term.getBackgroundColor()
		local ch
		local function keyboard()
			term.setCursorPos(self.xPos+1,self.yPos)
			local cursorPos = 0
			while true do

				local event, button, x, y = os.pullEvent()

				if event == "key" then 
					if button == 200 and cursorPos ~= 0 or event == "mouse_scroll" and button == -1 and cursorPos ~= 0 then
						term.setCursorPos(self.xPos,self.yPos+cursorPos)

						cursorPos = cursorPos - 1
						self:draw(cursorPos+1)

					elseif button == 208 and cursorPos ~= #table-1 then
						term.setCursorPos(self.xPos,self.yPos+cursorPos)

						cursorPos = cursorPos + 1
						self:draw(cursorPos+1)
					elseif button == 28 then
						ch = self.table[cursorPos+1]
						break
					end
				elseif event == "mouse_scroll" then
					if button == -1 and cursorPos ~= 0 then
						term.setCursorPos(self.xPos,self.yPos+cursorPos)

						cursorPos = cursorPos - 1
						self:draw(cursorPos+1)

					elseif button == 1 and cursorPos ~= #table-1 then
						term.setCursorPos(self.xPos,self.yPos+cursorPos)

						cursorPos = cursorPos + 1
						self:draw(cursorPos+1)
					elseif button == 28 then
						ch = self.table[cursorPos+1]
						break
					end
				elseif event == "mouse_click" then
					if y >= self.yPos and y <= self.yPos+#self.table-1 and x <= self.xPos+self.lenght and x >= self.xPos then
						self:draw(y-self.yPos+1)
						sleep(0.3)
						ch = self.table[y-self.yPos+1]
						break
					end
				end
				term.setCursorPos(self.xPos,self.yPos+cursorPos)
			end
		end
		keyboard()
		term.setBackgroundColor(self.oldColor)
		return ch
	end
    setmetatable(arg, self)
    self.__index = self; return arg
end
---------------------------------------------
tumbler = {}
function tumbler:new(xPos,yPos,table,table1)
	local tHistory = {}
	local oldColor, color, oldTextColor = colorPalette()
	if table1 then
		tHistory = table1
	end

	local arg = {}
		arg.xPos = xPos
		arg.yPos = yPos
		arg.table = table
		arg.table1 = table1
		arg.tHistory = tHistory
		arg.oldColor = oldColor
		arg.color = color
		arg.oldTextColor = oldTextColor

	function arg:draw()
		for i = 1, #self.table do
			term.setCursorPos(self.xPos+2, self.yPos+i-1)
			write(table[i])
		end
		term.setBackgroundColor(self.color)
		for i = 1, #self.table do
			term.setCursorPos(self.xPos, self.yPos+i-1)
			if self.tHistory[i] == true then
				write("O")
			else
				write(" ")
			end
		end
	term.setBackgroundColor(self.oldColor)
	term.setTextColor(self.oldTextColor)
	end
	function  tumbler:use()
		self:draw()
		while true do
			local event, button, x, y = os.pullEvent("mouse_click")
			if y-self.yPos+1 <= #self.table and y-self.yPos+1 >= 1 and x == self.xPos then
				if self.tHistory[y-yPos+1] == false or self.tHistory[y-yPos+1] == nil then
					self.tHistory = {}
					self.tHistory[y-self.yPos+1] = true
				end
			else
				return self.tHistory
			end
			self:draw()
		end
	end
	setmetatable(arg, self)
	self.__index = self; return arg
end
---------------------------------------------
local readString = {}
function readString:new( xPos, yPos, _sReplaceChar, _size, color, text)
	local arg = {}
		arg.xPos = xPos
		arg.yPos = yPos
		arg._sReplaceChar = _sReplaceChar
		arg._size = _size
		arg.color = color
		arg.text = text
	function arg:draw()
		drawPixelG(self.xPos,self.yPos, self._size, 1, self.color)
	end
	function arg:use()
		self:draw()
		local function textDraw(color)
			if arg.text then
				if color ~= colors.gray then
					term.setTextColor(colors.gray)
					write(arg.text)
				else
					term.setTextColor(colors.black)
					write(arg.text)
				end
				term.setCursorPos(self.xPos,self.yPos)
			end
		end
		term.setCursorPos(self.xPos,self.yPos)
		local oldColor = term.getBackgroundColor()
		term.setBackgroundColor(self.color)
		local oldTextColor = term.getTextColor()
		if term.getBackgroundColor() == colors.white then
			textDraw(colors.black)
			term.setTextColor(colors.black)
		else
			textDraw(colors.white)
			term.setTextColor(colors.white)
		end
		local result = readLine(self._sReplaceChar,self._size)
		term.setTextColor(oldTextColor)
		return result
	end
	setmetatable(arg, self)
	self.__index = self; return arg
end
function loadFunction(var)
	if var == "contextMenu" then
		return contextMenu
	elseif var == "tumbler" then
		return tumbler
	elseif var == "readString" then
		return readString
	end
end
-----------------------------------------------------
function winAnimation(black)
	local xSize, ySize = term.getSize()
	if black == "b" then
		term.setBackgroundColor(colors.black)
		term.clear()
		sleep(0.03)
	elseif black == "w" then
		term.setBackgroundColor(colors.white)
		term.clear()
		sleep(0.03)
	end
	term.setBackgroundColor(colors.lightGray)
	term.clear()
	sleep(0.03)
	term.setBackgroundColor(colors.gray)
	term.clear()
	sleep(0.03)
	term.setBackgroundColor(colors.lightGray)
	term.clear()
	sleep(0.03)
	term.setBackgroundColor(colors.white)
	term.clear()
	sleep(0.03)
end

function nameBar(text)
	local secondColor = colors.gray
	local textColor = colors.white
	local oldColor = term.getBackgroundColor()
	local oldTextColor = term.getTextColor()
	local xSize, ySize = term.getSize()

	term.clear()
	drawPixelG(1, 1, xSize, 1, secondColor)
	term.setCursorPos(2,1)
	term.setBackgroundColor(secondColor)
	term.setTextColor(textColor)
	write(text)
	term.setBackgroundColor(oldColor)
	term.setTextColor(oldTextColor)
end

function waitForUser()
	sleep(0.1)
	local event = os.pullEvent()
	if event == "key" or event == "mouse_click" then
		return
	end
end

function writeOnCenter(text)
	local x,y = getCenter(string.len(text),1)
	term.setCursorPos(x,y)
	write(text)
end

function findInTable(table, str)
	for i = 1, #table do
		if table[i] == str then
			return i
		end
	end
	return nil
end

function getLongestElement(table)
	local len = 0
	for i = 1, #table do
		if string.len(table[i]) > len then
			len = string.len(table[i])
		end
	end
	return len
end
