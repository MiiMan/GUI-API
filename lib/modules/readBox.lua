readBox = {}

extended(readBox, simple)

function readBox:init()
    self.cursorPos = 0
end

function readBox:redraw()
    self:body()
    self.form.setTextColor(self.arg.obj.textColor)
    self.form.setCursorPos(1,1)
    self.form.write(self.arg.obj.line)
    self.form.setCursorPos(self.cursorPos+1,1)
end

function readBox:touch()
    self:redraw()
    while true do
        local sEvent, param = os.pullEvent()
        term.setCursorBlink(true)
        if sEvent == "char" then
            self.arg.obj.line = string.sub( self.arg.obj.line, 1, self.cursorPos ) .. param .. string.sub( self.arg.obj.line, self.cursorPos + 1 )
            self.cursorPos = self.cursorPos + 1
            self:redraw()
        elseif sEvent == "key" then
            if param == keys.enter then
                term.setCursorBlink(false)
                break
            elseif param == keys.left then
                if self.cursorPos > 0 then
                    self.cursorPos = self.cursorPos - 1
                    self:redraw()
                end
            elseif param == keys.right then
                if self.cursorPos < string.len(self.arg.obj.line) then
                    self.cursorPos = self.cursorPos + 1
                    self:redraw()
                end
            elseif param == keys.backspace then
                if self.cursorPos > 0 then
                    self.arg.obj.line = string.sub( self.arg.obj.line, 1, self.cursorPos - 1 ) .. string.sub( self.arg.obj.line, self.cursorPos + 1 )
                    self.cursorPos = self.cursorPos - 1
                    self:redraw()
                end
            end
        elseif sEvent == "mouse_click" then
            term.setCursorBlink(false)
            break
        end
    end
end
