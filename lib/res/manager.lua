manager = {}

function manager:new()

    local obj = {}
        obj.list = {}

  function obj:add(object)
    self.list[#self.list+1] = object
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

        local function onClick(xC, yC)
            for i = #self.list, 1, -1 do
                local xO, yO, xP, yP

                xO = self.list[i].arg.form.x
                yO = self.list[i].arg.form.y
                xP = self.list[i].arg.form.width + xO - 1
                yP = self.list[i].arg.form.height + yO - 1
                if xC >= xO and xC <= xP and yC >= yO and yC <= yP and self.list[i].arg.form.visible == true then
                    return self.list[i]
                end
            end
            return nil
        end

        self:redraw()

        local event, button, x, y = os.pullEvent()
        if x and y and onClick(x, y) then

            local currentObj = onClick(x, y)

            if event == "mouse_click" then
                currentObj:touch(x, y)
            elseif event == "mouse_scroll" then
                currentObj:scroll(x, y, button)
            end

        end
    end

  function obj:getName(i)
    return self.list[i].arg.name
  end

  setmetatable(obj, self)
  self.__index = self; return obj
end
