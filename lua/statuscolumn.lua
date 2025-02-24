local lnum = require("statuscolumn.lnum")
local relnum = require("statuscolumn.relnum")
local colors = require("statuscolumn.colors")
local statuscolumn = {}

local function defaults(options)
  return {
    enable_border = options.enable_border or false,
    gradient_hl = options.gradient_hl or "Special",
  }
end

function statuscolumn.setup(options)
  statuscolumn.options = defaults(options)
  colors.init(statuscolumn.options.gradient_hl)

  statuscolumn.init_lnum = function()
    return lnum.bootstrap(statuscolumn.options)
  end

  statuscolumn.init_relnum = function()
    return relnum.bootstrap(statuscolumn.options)
  end

  local augroup = vim.api.nvim_create_augroup("StatusColumn", { clear = true })

  vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    group = augroup,
    callback = function(ev)
      local bufnr = ev.buf
      if vim.bo[bufnr].buftype == "" and vim.bo[bufnr].filetype ~= "" then
        vim.opt_local.relativenumber = true
        vim.opt_local.statuscolumn = "%!v:lua.require('statuscolumn').init_lnum()"

        vim.keymap.set("n", "<leader>cr", "<cmd>Lazy reload statuscolumn.nvim<CR>", { desc = "Reload StatusColumn" })
        vim.keymap.set(
          "n",
          "<leader>ct",
          "<cmd>lua require('statuscolumn').toggle()<CR>",
          { desc = "Toggle Rel-number" }
        )
      else
        vim.opt_local.statuscolumn = ""
      end
    end,
  })
end

local lnum_state = true

statuscolumn.toggle = function()
  if lnum_state then
    vim.opt_local.statuscolumn = "%!v:lua.require('statuscolumn').init_relnum()"
    lnum_state = false
  else
    vim.opt_local.statuscolumn = "%!v:lua.require('statuscolumn').init_lnum()"
    lnum_state = true
  end
end

function statuscolumn.is_configured()
  return statuscolumn.options ~= nil
end

function statuscolumn.test_msg()
  vim.notify("Statuscolumn is loaded (test)")
end

statuscolumn.options = nil

return statuscolumn
