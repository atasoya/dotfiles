-- LazyGit integration for Neovim
-- Provides a floating terminal with lazygit

return {
  'kdheepak/lazygit.nvim',
  -- optional for floating window border decoration
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = {
    { '<leader>gg', ':LazyGit<CR>', desc = 'Open [G]it interface' },
    { '<leader>gf', ':LazyGitFilter<CR>', desc = 'Open [G]it [F]ilter' },
    { '<leader>gc', ':LazyGitConfig<CR>', desc = 'Open [G]it [C]onfig' },
  },
  config = function()
    -- Optional: Configure lazygit behavior
    vim.g.lazygit_floating_window_winblend = 0 -- transparency of floating window
    vim.g.lazygit_floating_window_scaling_factor = 0.9 -- scaling factor for floating window
    vim.g.lazygit_floating_window_corner_chars = { '╭', '╮', '╰', '╯' } -- customize lazygit popup window corner characters
    vim.g.lazygit_floating_window_use_plenary = 0 -- use plenary.nvim to manage floating window if available
    vim.g.lazygit_use_neovim_remote = 1 -- fallback to 0 if neovim-remote is not available
  end,
}


