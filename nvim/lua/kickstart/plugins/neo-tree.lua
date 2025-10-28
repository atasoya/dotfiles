-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '<leader>b', ':Neotree toggle<CR>', desc = 'NeoTree toggle', silent = true },
  },
  opts = {
    filesystem = {
      filtered_items = {
        visible = true, -- This is what you want: If you set this to `true`, then "ALL" files will be shown.
        hide_dotfiles = false, -- This is what you want: If you set this to `false`, then "ALL" files will be shown.
        hide_gitignored = false, -- This is what you want: If you set this to `false`, then "ALL" files will be shown.
        hide_hidden = false, -- This is what you want: If you set this to `false`, then "ALL" files will be shown.
        hide_by_name = {
          -- '.DS_Store',
          -- 'thumbs.db'
        },
        hide_by_pattern = { -- uses glob style patterns
          -- '*.meta',
          -- '*/src/*/tsconfig.json',
        },
        always_show = { -- remains visible even if other settings would normally hide it
          -- '.gitignored',
        },
        never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
          -- '.DS_Store',
          -- 'thumbs.db'
        },
        never_show_by_pattern = { -- uses glob style patterns
          -- '.null-ls_*',
        },
      },
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
}
