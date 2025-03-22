local relnum = {}

relnum.number = function()
  local gap = "%="
  local relnumber = string.format("%4d", vim.v.relnum)
  local linenumber = string.format("%4d", vim.v.lnum)

  if vim.v.relnum == 2 then
    return gap .. "%#Column2#" .. relnumber
  end
  if vim.v.relnum == 1 then
    return gap .. "%#Column1#" .. relnumber
  end
  if vim.v.relnum == 0 then
    return gap .. "%#Column0#" .. linenumber
  end
  return gap .. "%#ColumnBase0#" .. relnumber
end

relnum.border = function()
  local character = " ▏"

  if vim.v.relnum == 2 then
    return "%#ColumnBorder2#" .. character
  end
  if vim.v.relnum == 1 then
    return "%#ColumnBorder1#" .. character
  end
  if vim.v.relnum == 0 then
    return "%#ColumnBorder0#" .. character
  end
  return "%#ColumnBase1#" .. character
end

relnum.bootstrap = function(options)
  local result = ""

  if not options.enable_border then
    result = relnum.number() .. " "
  else
    result = relnum.number() .. relnum.border()
  end

  return "%s" .. result
end

return relnum
