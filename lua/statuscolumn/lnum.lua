local lnum = {}

lnum.number = function()
  local gap = "%="
  local linenumber = string.format("%4d", vim.v.lnum)

  if vim.v.relnum == 2 then
    return gap .. "%#Column2#" .. linenumber
  end
  if vim.v.relnum == 1 then
    return gap .. "%#Column1#" .. linenumber
  end
  if vim.v.relnum == 0 then
    return gap .. "%#Column0#" .. linenumber
  end
  return gap .. "%#ColumnBase0#" .. linenumber
end

lnum.border = function()
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

lnum.bootstrap = function(options)
  local result = ""

  if not options.enable_border then
    result = lnum.number() .. " "
  else
    result = lnum.number() .. lnum.border()
  end
  return "%s" .. result
end

return lnum
