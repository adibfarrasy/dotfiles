return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {},
    config = function()
      local highlight = {
        'Aqua',
        'Violet',
        'Green',
        'Orange',
        'Blue',
        'Yellow',
        'Red',
      }

      local hooks = require 'ibl.hooks'
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, 'Red', { fg = '#8a605f' })
        vim.api.nvim_set_hl(0, 'Yellow', { fg = '#938365' })
        vim.api.nvim_set_hl(0, 'Blue', { fg = '#909895' })
        vim.api.nvim_set_hl(0, 'Orange', { fg = '#8b6d59' })
        vim.api.nvim_set_hl(0, 'Green', { fg = '#696849' })
        vim.api.nvim_set_hl(0, 'Violet', { fg = '#938089' })
        vim.api.nvim_set_hl(0, 'Aqua', { fg = '#7c897c' })
      end)

      require('ibl').setup { indent = { highlight = highlight } }
    end,
  },
}
