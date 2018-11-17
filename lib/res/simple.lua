simple = {}

function simple:new(_arg)

    local obj = {}
        obj.arg = _arg
        obj.form = window.create(term.current(), _arg.form.x, _arg.form.y, _arg.form.width, _arg.form.height, false)

    function obj:body()
		self.form.reposition(self.arg.form.x, self.arg.form.y, self.arg.form.width, self.arg.form.height)
        self.form.setBackgroundColor(self.arg.form.color)
        self.form.setVisible(self.arg.form.visible)
        self.form.clear()
        self.form.redraw()
    end

    function simple:touch()
    end

    function simple:scroll()
    end

    function simple:redraw()
      self:body()
    end

	function simple:init()
	end


    self:init()
    setmetatable(obj, self)
    self.__index = self; return obj
end
