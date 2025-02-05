-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  -- This shows Discord that you are writing in Neovim...
  -- "andweeb/presence.nvim",

  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  -- == Examples of Overriding Plugins ==

  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        "                                  ░░   ░░░   ░░                                ",
        "                            ░░░  ░░░░░░░░░░░░░░░  ░░░                          ",
        "                            ░░░░░░░░░░░░░░░░░░░░░░░░░                          ",
        "                       ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░                     ",
        "      ░            ░   ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░             ░░░   ░ ",
        "  ░░  ░░░░         ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░       ░░░░░   ░░",
        " ░░░  ░░░░░        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░      ░░░░░░  ░░░",
        " ░░░░░ ░░░░░   ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ░░░░░░░░░░░░",
        " ░░░░░░░░░░░    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░   ░░░░░░░░░░ ",
        "   ░░░░░░░░  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ░░░░░░░   ",
        "     ░░░░░░  ░░░░░░░░░░░░░░░░░░░░▒▓▒  ░░░░░░░▒▓░ ░░░░░░░░░░░░░░░░░░░ ░░░░      ",
        "        ░░░░  ░░░░░░░░░░░░░░░░░░░▒█▓   ░░░░░ ▓█▓   ░░░░░░░░░░░░░░░░░░░░        ",
        "          ░░░░░░░░░░░░░░░░░░░░░░░ ░     ░░░░  ░    ░░░░░░░░░░░░░░░░░░░         ",
        "          ░░░░░░░░░░░░░░░░░░░░░░░      ░░░░░░     ░░░░░░░░░░░░░░░░░░░░░        ",
        "         ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ░░░░░░░       ",
        "          ░░░░░  ░    ░░░░░░░░░░░░░░░░░░    ░░░░░░░░░░░░░░░     ░░ ░░░░        ",
        "            ░░░░  ░           ░░░░░░░░░░░░░░░░░░░░░░           ░  ░░░░         ",
        "              ░░░                                             ░   ░░░          ",
        "                ░░                                               ░░            ",
        "                  ░░                                            ░░             ",
        "                   ░                                                           ",
      }
      local get_icon = require("astroui").get_icon
      opts.section.buttons.val = {
        opts.button("LDR n  ", get_icon("FileNew", 2, true) .. "New File  "),
        opts.button("LDR f f", get_icon("Search", 2, true) .. "Find File  "),
        opts.button("LDR f r", get_icon("DefaultFile", 2, true) .. "Recents  "),
        opts.button("LDR /  ", get_icon("WordFile", 2, true) .. "Find Word  "),
        opts.button("LDR f '", get_icon("Bookmarks", 2, true) .. "Bookmarks  "),
        opts.button("LDR S l", get_icon("Refresh", 2, true) .. "Last Session  "),
      }
      return opts
    end,
  },

  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = false },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      -- include the default astronvim config that calls the setup call
      require "astronvim.plugins.configs.luasnip"(plugin, opts)
      -- load snippets paths
      require("luasnip.loaders.from_vscode").lazy_load {
        paths = { vim.fn.stdpath "config" .. "/snippets" },
      }
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },

  -- show dotfiles by default
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
        },
      },
    },
  },

  -- my shit
  {
    "ledger/vim-ledger",
    ft = { "ledger", "journal" },
    config = function()
      vim.api.nvim_create_augroup("ledger", { clear = false })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = "ledger",
        callback = function() vim.cmd "LedgerAlignBuffer" end,
        desc = "Align on decimal point",
      })
    end,
  },
  "NoahTheDuke/vim-just",
  "inkarkat/vim-ingo-library",
  "inkarkat/vim-SyntaxRange",

  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      local actions = require "telescope.actions"
      local layout = require "telescope.actions.layout"
      opts.defaults.mappings.i["<TAB>"] = actions.move_selection_next
      opts.defaults.mappings.i["<S-TAB>"] = actions.move_selection_previous
      opts.defaults.mappings.n["h"] = actions.results_scrolling_left
      opts.defaults.mappings.n["l"] = actions.results_scrolling_right
      opts.defaults.mappings.i["<C-p>"] = layout.toggle_preview
      opts.defaults.path_display = { "filename_first" }
      opts.defaults.layout_strategy = "vertical"
      opts.defaults.layout_config = {
        prompt_position = "bottom",
        height = 0.95,
        preview_cutoff = 0,
      }
    end,
  },

  -- customizing community packs
  {
    "zbirenbaum/copilot.lua",
    opts = {
      suggestion = {
        keymap = {
          accept = "<C-CR>",
          accept_word = false,
          accept_line = false,
          next = "<C-.>",
          prev = "<C-,>",
        },
      },
    },
  },
  {
    "gruvbox.nvim",
    opts = {
      italic = {
        comments = true,
      },
    },
  },
  -- {
  --   "mrcjkb/haskell-tools.nvim",
  --   config = function()
  --     vim.g.haskell_tools = { hls = { cmd = function() return { "static-ls", "" } end } }
  --   end,
  -- },
  -- This plugin is wack, better off with a couple small custom functions
  { "psiska/telescope-hoogle.nvim" },
  { "alx741/yesod.vim" },
  {
    "stevearc/conform.nvim",
    opts = {
      notify_on_error = true,
      format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then return end
        return { timeout_ms = 1000, lsp_format = "fallback" }
      end,
      formatters_by_ft = {
        haskell = { "mwb_format", "fourmolu", stop_after_first = true },
        -- javascript = { "prettier", "prettierd", stop_after_first = true },
      },
      formatters = {
        mwb_format = {
          command = "run-format",
          args = { "--stdio" },
        },
      },
    },
  },
}
