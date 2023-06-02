reload('user.plugins')
reload('user.which-key')
reload('user.autocmds')
-- reload('user.toggleterm')
--[[
 THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
 `lvim` is the global options object
]]
-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = false
vim.opt.termguicolors = true

-- disable virtual text as it's redundant due to lsp_lines
vim.diagnostic.config({
  virtual_text = false
})
vim.diagnostic.config({
  virtual_lines = {
    highlight_whole_line = false
  }
})
lvim.colorscheme = "tokyonight"

vim.g.python_host_prog = '/Users/stefanlogue/.pyenv/versions/nvim3/bin/python'
vim.g.python3_host_prog = '/Users/stefanlogue/.pyenv/versions/nvim3/bin/python'

-- general
lvim.log.level = "info"
lvim.format_on_save = {
  enabled = true,
  pattern = "*.lua,*.ts,*.tsx,*.js,*.jsx,*.json,*.rs,*.go,*.py",
  timeout = 1000,
}
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<C-q>"] = ":q<cr>"
lvim.keys.normal_mode["<S-e>"] = ":Neotree toggle<cr>"
-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- -- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

-- -- Change theme settings
-- lvim.colorscheme = "lunar"

-- Lualine config
vim.g.gitblame_display_virtual_text = 0 -- Disable virtual text
local git_blame = require('gitblame')

local components = require("lvim.core.lualine.components")
lvim.builtin.lualine.style = "default"
lvim.builtin.lualine.sections.lualine_a = { "mode" }
lvim.builtin.lualine.sections.lualine_b = { "branch" }
lvim.builtin.lualine.sections.lualine_c = {
  components.diff,
  {
    git_blame.get_current_blame_text,
    cond = git_blame.is_blame_text_available
  }

}
lvim.builtin.lualine.sections.lualine_x = {
  components.diagnostics,
  components.lsp,
  components.python_env,
  components.filetype,
  components.spaces
}
lvim.builtin.lualine.sections.lualine_y = { "progress" }
lvim.builtin.lualine.sections.lualine_z = {
  components.location,
}

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.terminal.open_mapping = "<C-t>"
lvim.builtin.nvimtree.active = false -- NOTE: using neo-tree
-- lvim.builtin.nvimtree.setup.view.side = "left"
-- lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

-- lvim.builtin.treesitter.ignore_install = { "haskell" }

-- -- always installed on startup, useful for parsers without a strict filetype
lvim.builtin.treesitter.ensure_installed = { "comment", "markdown_inline", "make", "regex", "bash", "javascript", "json",
  "python", "lua", "typescript", "tsx", "css", "rust", "yaml", "go" }

-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "yamlls", "rust_analyzer" })

local yamllsOpts = {
  settings = {
    yaml = {
      schemaStore = {
        enable = true
      },
      customTags = {
        "!Base64",
        "!Cidr",
        "!And",
        "!Equals",
        "!If",
        "!Not",
        "!Or",
        "!Condition",
        "!FindInMap",
        "!GetAtt",
        "!GetAtt",
        "!GetAZs",
        "!ImportValue",
        "!Join",
        "!Select",
        "!Split",
        "!Sub",
        "!Transform",
        "!Ref",
      }
    }
  }
}
local rustAnalyzerOpts = {
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true
      }
    }
  }
}
local lspManager = require("lvim.lsp.manager")
lspManager.setup("yamlls", yamllsOpts)
lspManager.setup("rust_analyzer", rustAnalyzerOpts)

-- --- disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "yamlls" })
-- local opts = {
--   settings = {
--     yaml = {
--       schemaStore = {
--         enabled = true
--       }
--     }
--   }
-- } -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("yamlls", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- linters and formatters <https://www.lunarvim.org/docs/languages#lintingformatting>
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  --   { command = "stylua" },
  {
    command = "prettier",
    extra_args = { "--print-width", "80" },
    filetypes = { "typescript", "typescriptreact", "json" },
  },
  {
    command = "black",
    filetypes = { "python" },
  },
  {
    command = "rustfmt",
    filetypes = { "rust" },
  },
  {
    command = "gofmt",
    filetypes = { "go" },
  }
}
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "eslint", filetypes = { "typescript", "typescriptreact" } },
  { command = "flake8", filetypes = { "python" } },
  {
    command = "shellcheck",
    args = { "--severity", "warning" },
  },
}

-- -- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>
-- lvim.plugins = {
--     {
--       "folke/trouble.nvim",
--       cmd = "TroubleToggle",
--     },
-- }

-- -- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
