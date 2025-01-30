local lnum = {}

lnum.column = function()
  local gap = "%="

  if vim.v.relnum == 2 then
    return gap .. "%#Column2#" .. vim.v.lnum
  end
  if vim.v.relnum == 1 then
    return gap .. "%#Column1#" .. vim.v.lnum
  end
  if vim.v.relnum == 0 then
    return gap .. "%#Column0#" .. vim.v.lnum
  end
  return gap .. "%#ColumnBase0#" .. vim.v.lnum
end

lnum.border = function()
  local character = "│"

  --if vim.v.relnum == 2 then
  --  return "%#ColumnBorder2#" .. character
  --end
  --if vim.v.relnum == 1 then
  --  return "%#ColumnBorder1#" .. character
  --end
  if vim.v.relnum == 0 then
    return "%#ColumnBorder0#" .. "¦"
  end
  return "%#ColumnBase1#" .. character
end

lnum.bootstrap = function(options)
  local result = ""

  if not options.enable_border then
    result = lnum.column() .. " "
  else
    result = lnum.column() .. lnum.border()
  end
  return "%s" .. result
end

return lnum
