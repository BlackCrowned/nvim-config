local npairs = require("nvim-autopairs")

-- Check tree sitter for pairs
npairs.setup({
    check_ts = true,
})
