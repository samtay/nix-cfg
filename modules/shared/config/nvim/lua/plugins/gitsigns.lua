-- Override gitsigns default keybindings
return {
  "lewis6991/gitsigns.nvim",
  opts = function(_, opts)
    -- Store the original on_attach if it exists
    local original_on_attach = opts.on_attach

    -- Override on_attach to modify keybindings
    opts.on_attach = function(bufnr)
      -- Call the original on_attach first
      if original_on_attach then original_on_attach(bufnr) end

      -- Delete the <Leader>gl binding that AstroNvim sets
      pcall(vim.keymap.del, "n", "<Leader>gl", { buffer = bufnr })

      -- Add git blame to <Leader>gb
      vim.keymap.set("n", "<Leader>gb", function() require("gitsigns").blame_line() end, {
        buffer = bufnr,
        desc = "View Git blame",
      })
    end

    return opts
  end,
}
