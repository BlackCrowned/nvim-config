vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Allow moving selection in visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '>-2<CR>gv=gv")

-- Keep past register after pasting
vim.keymap.set('x', '<leader>p', '"_dP')

-- Replace current word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Chmod +x the current file
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Telescope
local telescope = require("telescope.builtin")
vim.keymap.set('n', '<leader>ff', telescope.find_files, {})
vim.keymap.set('n', '<leader>fa', function() telescope.find_files({ hidden = true }) end, {})
vim.keymap.set('n', '<leader>fg', telescope.find_files, {})
vim.keymap.set('n', '<leader>fr', telescope.live_grep, {})
vim.keymap.set('n', '<leader>fb', telescope.buffers, {})
vim.keymap.set('n', '<leader>fh', telescope.help_tags, {})

vim.keymap.set('n', '<leader>fs', function()
  telescope.grep_string({ search = vim.fn.input("Grep > ") })
end, {})

-- Vim Tree
local nvim_tree = require("nvim-tree.api")
vim.keymap.set('n', '<leader>nt', function() nvim_tree.tree.toggle({ path = vim.fn.getcwd() }) end, {})
-- Chad Tree
-- vim.keymap.set('n', '<leader>nt', vim.fn.CHADopen, {})

-- Harpoon
local harpoon_mark = require("harpoon.mark")
local harpoon_ui = require("harpoon.ui")

vim.keymap.set('n', '<leader>a', harpoon_mark.add_file)
vim.keymap.set('n', '<C-e>', harpoon_ui.toggle_quick_menu)

vim.keymap.set('n', '1', function() harpoon_ui.nav_file(1) end)
vim.keymap.set('n', '2', function() harpoon_ui.nav_file(2) end)
vim.keymap.set('n', '3', function() harpoon_ui.nav_file(3) end)
vim.keymap.set('n', '4', function() harpoon_ui.nav_file(4) end)

-- Undotree
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

-- Fugitive
vim.keymap.set('n', '<leader>gs', vim.cmd.Git)

