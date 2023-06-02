lvim.plugins = {
  -- Colourschemes
  { "catppuccin/nvim" },
  { "rose-pine/neovim" },
  {
    "folke/tokyonight.nvim",
    config = function()
      require('tokyonight').setup({
        style = 'moon',
        transparent = true
      })
    end
  },
  -- Plugins
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestions = { enabled = false },
        panel = { enabled = false },
      })
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  { 'jose-elias-alvarez/typescript.nvim' },
  {
    'folke/todo-comments.nvim',
    event = 'BufRead',
    config = function()
      require('todo-comments').setup()
    end
  },
  { 'christoomey/vim-tmux-navigator' },
  {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup()
    end
  },
  {
    'folke/persistence.nvim',
    event = 'BufReadPre',
    config = function()
      require('persistence').setup({
        dir = vim.fn.expand(vim.fn.stdpath 'state' .. '/sessions/'),
        options = { 'buffers', 'curdir', 'tabpages', 'winsize' }
      })
    end
  },
  { 'MunifTanjim/prettier.nvim' },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        "css",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "scss",
        "html",
        "lua",
        "vim",
      }, {
        RGB = true,
        RRGGBB = true,
        names = true,
        RRGGBBAA = true,
        rgb_fn = true,
        hsl_fn = true,
        css = true,
        css_fn = false,
      })
    end,
  },
  {
    "folke/noice.nvim",
    event = 'VeryLazy',
    opts = {},
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("noice").setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        presets = {
          bottom_search = true,         -- use a classic bottom cmdline for search
          command_palette = true,       -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          lsp_doc_border = false,       -- add a border to hover docs and signature help
          inc_rename = true,
        }
      })
    end
  },
  {
    "smjonas/inc-rename.nvim",
    config = function()
      require("inc_rename").setup()
    end
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        default_component_configs = {
          git_status = {
            align = "float",
          }
        },
        window = {
          width = 30,
          mappings = {
            ["l"] = "open",
            ["a"] = {
              "add",
              config = {
                show_path = "relative",
              },
            },
            ["A"] = {
              "add_directory",
              config = {
                show_path = "relative",
              },
            },
          },
        },
        buffers = {
          follow_current_file = true,
        },
        filesystem = {
          follow_current_file = true,
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_by_name = {
              "node_modules"
            },
            never_show = {
              ".DS_Store",
              "thumbs.db"
            },
          },
        },
      })
    end
  },
  {
    "stevearc/dressing.nvim",
    config = function()
      require("dressing").setup({
        input = { enabled = false },
      })
    end,
  },
  {
    'rcarriga/nvim-notify',
    config = function()
      require("notify").setup({
        render = "compact",
        stages = "slide",
        timeout = 7500,
      })
    end
  },
  {
    'AckslD/swenv.nvim',
    config = function()
      require('swenv').setup({
        get_venvs = function(venvs_path)
          return require('swenv.api').get_venvs(venvs_path)
        end,
        venvs_path = vim.fn.expand('.'),
      })
    end,
  },
  {
    "dimaportenko/telescope-simulators.nvim",
    config = function()
      require('simulators').setup({
        android_emulator = false,
        ios_simulator = true
      })
    end
  },
  {
    url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require('lsp_lines').setup()
    end
  },
  {
    "f-person/git-blame.nvim",
  },
  -- {
  --   'echasnovski/mini.indentscope',
  --   version = false,
  --   config = function()
  --     require('mini.indentscope').setup({
  --       options = {
  --         indent_at_cursor = false,
  --         try_as_border = true
  --       }
  --     })
  --   end
  -- },
  -- {
  --   "akinsho/toggleterm.nvim",
  --   version = "*",
  --   opts = {
  --     open_mapping = [[<c-t>]],
  --   }
  -- }
}

table.insert(lvim.plugins, {
  "zbirenbaum/copilot-cmp",
  event = "InsertEnter",
  dependencies = { "zbirenbaum/copilot.lua" },
  config = function()
    vim.defer_fn(function()
      require('copilot').setup()
      local cmp = require('copilot_cmp')
      cmp.setup({
        formatters = {
          insert_text = require('copilot_cmp.format').remove_existing
        }
      })
    end, 100)
  end,
})
