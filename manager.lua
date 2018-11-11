manager = {}

function manager:new()

  local obj = {}
    obj.list = {}
    obj.focus = nil

  function obj:add(object)
    self.list[#self.list+1] = object
		object:init()
  end

  function obj:getID(objectName)
    for i = #self.list, 1, -1 do
      if self.list[i].arg.name == objectName then
        return i
      end
    end
  end

  function obj:remove(objectName)
    table.remove(self.list, self:getID(objectName))
  end

  function obj:redraw()
    for i = 1, #self.list, 1 do
      self.list[i]:redraw()
    end
  end

  function obj:use()

    self:redraw()

    local event, button, x, y = os.pullEvent()
		if event == "mouse_click" then
	    local xO, yO, xP, yP
	    for i = #self.list, 1, -1 do
	      xO = self.list[i].arg.form.x
	      yO = self.list[i].arg.form.y
	      xP = self.list[i].arg.form.width + xO
	      yP = self.list[i].arg.form.height + yO

	      if x >= xO and x <= xP and y >= yO and y <= yP then
	        self.list[i]:touch(x,y)
	        break
	      end
	    end
		end
  end

  function obj:getName(i)
    return self.list[i].arg.name
  end

  setmetatable(obj, self)
  self.__index = self; return obj
end
