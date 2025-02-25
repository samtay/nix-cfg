return {
  "rcarriga/nvim-notify",
  config = function(plugin, opts)
    require "astronvim.plugins.configs.notify"(plugin, opts)
    local palette = require("gruvbox").palette
    require("notify").setup {
      background_colour = vim.go.background == "light" and palette.light0 or palette.dark0,
      merge_duplicates = true,
    }
  end,
}
