local lnum = {}

lnum.number = function()
  local gap = "%#ColumnBase0#%="
  local linenumber = string.format("%4d", vim.v.lnum)

  -- if vim.v.virtnum < 0 and vim.v.relnum == 2 then
  --   return ""
  -- end
  -- if vim.v.virtnum < 0 and vim.v.relnum == 1 then
  --   return ""
  -- end
  -- if vim.v.virtnum < 0 and vim.v.relnum == 0 then
  --   return ""
  -- end
  --
  -- if vim.v.virtnum >= 1 and vim.v.relnum == 2 then
  --   return ""
  -- end
  -- if vim.v.virtnum >= 1 and vim.v.relnum == 1 then
  --   return ""
  -- end
  -- if vim.v.virtnum >= 1 and vim.v.relnum == 0 then
  --   return ""
  -- end

  if vim.v.virtnum ~= 0 then
    return "%#ColumnBase0#    "
  end

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
  local character = "🭵"

  -- if vim.v.relnum == 2 then
  --   return "%#ColumnBorder2#" .. character
  -- end
  -- if vim.v.relnum == 1 then
  --   return "%#ColumnBorder1#" .. character
  -- end

  if vim.v.virtnum < 0 and vim.v.relnum == 0 then
    return "%#ColumnBase0#" .. character .. "%#None# "
  end
  if vim.v.virtnum >= 1 and vim.v.relnum == 0 then
    return "%#Column1#" .. character .. "%#None# "
  end

  if vim.v.virtnum ~= 0 then
    return "%#ColumnBase0#" .. character .. "%#None# "
  end

  if vim.v.relnum == 0 then
    return "%#Column0#" .. character .. "%#None# "
  end
  return "%#ColumnBase0#" .. character .. "%#None# "
end

lnum.bootstrap = function()
  local result = ""

  result = lnum.number() .. lnum.border()

  return "%s" .. result
end

return lnum
