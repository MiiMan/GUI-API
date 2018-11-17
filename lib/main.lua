local path = "lib"
local res = "res"
local modules = "modules"

local resList = fs.list(path .."/" ..res)
local moduleList = fs.list(path .."/" ..modules)

for _, file in ipairs(resList) do
    dofile(path .."/" ..res .."/" ..file)
end

for _, file in ipairs(moduleList) do
    dofile(path .."/" ..modules .."/" ..file)
end
