local inspect = require('lib/inspect')

return function()
  -- public functions
  local log, draw

  -- private functions
  local nameToIndex, forEachIndex, inspectUserdata, countNewLines

  -- private variables
  local names = {}
  local variables = {}

  log = function(name, variable)
    local index = nameToIndex(name)
    if index then
      names[index] = name
      variables[index] = variable
    else
      names[#names + 1] = name
      variables[#variables + 1] = variable
    end
  end

  draw = function()
    local counter = 0
    for index, _ in pairs(names) do
      forEachIndex(index, counter)
      counter = counter + 1 + countNewLines(variables[index])
    end
  end

  nameToIndex = function(search)
    local index
    for i, name in pairs(names) do
      if name == search then
         index = i
      end
    end
    return index
  end

  forEachIndex = function(index, counter)
    local text = ''
    text = text .. names[index]
    text = text .. ' -> '
    text = text .. type(variables[index])
    text = text .. ' '
    text = text .. inspectUserdata(variables[index])

    love.graphics.setColor(0, 0, 0)
    love.graphics.print(text, 10, 14 * counter)
  end

  inspectUserdata = function(variable)
    if type(variable) == 'userdata' then
      return inspect(getmetatable(variable))
    else
      return inspect(variable)
    end
  end

  countNewLines = function(variable)
    local output = inspectUserdata(variable)
    local _, count = output:gsub('\n', '\n')
    return count
  end

  return {
    log = log,
    draw = draw,
  }
end
