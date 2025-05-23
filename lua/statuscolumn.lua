local lnum = require("statuscolumn.lnum")
local relnum = require("statuscolumn.relnum")
local colors = require("statuscolumn.colors")
local statuscolumn = {}

local function defaults(options)
  return {
    gradient_hl = options.gradient_hl or "Normal",
  }
end

function statuscolumn.setup(options)
  statuscolumn.options = defaults(options)
  colors.init(statuscolumn.options.gradient_hl)

  statuscolumn.init_lnum = function()
    return lnum.bootstrap()
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
        vim.opt.relativenumber = true
        vim.opt.statuscolumn = "%!v:lua.require('statuscolumn').init_lnum()"
        vim.opt.signcolumn = "yes:1"

        vim.keymap.set("n", "<leader>cr", "<cmd>Lazy reload statuscolumn.nvim<CR>", { desc = "Reload StatusColumn" })
        vim.keymap.set(
          "n",
          "<leader>ct",
          "<cmd>lua require('statuscolumn').toggle()<CR>",
          { desc = "Toggle Rel-number" }
        )
      else
        vim.opt.relativenumber = false
        vim.opt.numberwidth = 1
        vim.opt.signcolumn = "no"
        vim.opt.statuscolumn = "%s"
        vim.opt.diffopt = "internal,foldcolumn:0,filler,followwrap,context:99999"
      end
    end,
  })
end

local lnum_state = true

statuscolumn.toggle = function()
  if lnum_state then
    vim.opt.statuscolumn = "%!v:lua.require('statuscolumn').init_relnum()"
    lnum_state = false
  else
    vim.opt.statuscolumn = "%!v:lua.require('statuscolumn').init_lnum()"
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
