return {
  "L3MON4D3/LuaSnip",
  config = function(plugin, opts)
    -- include the default astronvim config that calls the setup call
    require "astronvim.plugins.configs.luasnip"(plugin, opts)
  end,
}
