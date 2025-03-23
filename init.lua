local map = vim.keymap.set

-- Install lazy.nvim (plugin manager)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin setup
require("lazy").setup({
    -- LSP (Language Server Protocol)
    { "neovim/nvim-lspconfig" },

    { "hrsh7th/nvim-cmp" }, -- Autocompletion
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-cmdline" },
    { "simrat39/rust-tools.nvim" }, -- Rust-specific tools
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = { "nvim-lua/plenary.nvim" },
    },                                 -- Syntax highlighting
    { "nvim-telescope/telescope.nvim" }, -- Fuzzy Finder,
    { "nvim-tree/nvim-tree.lua" },
    { "nvim-tree/nvim-web-devicons" },
    {
        "folke/tokyonight.nvim",
        config = function()
            vim.cmd.colorscheme("tokyonight")
        end,
    },

    {
        "nvimtools/none-ls.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        dependencies = { "nvimtools/none-ls-extras.nvim" },
    },

    {
        "kampfkarren/selene",
        dependencies = {
            "neovim/nvim-lspconfig", -- Optional, for LSP integration
        },
    },

    {
        -- Git 状态显示（左侧标记 + 变更预览）
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                signs = {
                    add = { text = "│" },
                    change = { text = "│" },
                    delete = { text = "_" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "~" },
                },
                current_line_blame = true, -- 显示当前行的 Git 提交信息
            })
        end,
    },

    -- Git 交互界面（`G`、`Gdiffsplit`、`Gblame`）
    "tpope/vim-fugitive",

    {
        -- Git Diff 视图（查看变更历史）
        "sindrets/diffview.nvim",
        config = function()
            require("diffview").setup({})
        end,
    },

    {
        -- 解决 Git 冲突
        "akinsho/git-conflict.nvim",
        config = function()
            require("git-conflict").setup()
        end,
    },

    {
        -- Git UI（LazyGit）
        "kdheepak/lazygit.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },

    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({})
        end,
    },

    -- file searching
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
})

require("nvim-tree").setup({
    view = {
        width = 30,
        side = "left",
        adaptive_size = true,
    },
    renderer = {
        icons = {
            show = {
                git = true,
                folder = true,
                file = true,
            },
        },
    },
    git = {
        enable = true,
    },
})

-- Add Treesitter for syntax highlighting
require("nvim-treesitter.configs").setup({
    ensure_installed = { "rust", "javascript", "typescript", "tsx", "html", "css" },
    highlight = { enable = true },
    indent = { enable = true }, -- Auto-indent support
})

-- Enable LSP
local lspconfig = require("lspconfig")

lspconfig.lua_ls.setup({
    on_init = function(client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if
                path ~= vim.fn.stdpath("config")
                and (vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc"))
            then
                return
            end
        end

        client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
            runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME,
                    -- Depending on the usage, you might want to add additional paths here.
                    -- "${3rd}/luv/library"
                    -- "${3rd}/busted/library",
                },
                -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
                -- library = vim.api.nvim_get_runtime_file("", true)
            },
        })
    end,
    settings = {
        Lua = {},
    },
})

lspconfig.bashls.setup({
    cmd = { "bash-language-server", "start" }, -- Command to start the server
    filetypes = { "sh", "bash" },            -- Filetypes to associate with bashls
    settings = {
        bash = {
            shellcheck = {
                enable = true, -- Enable shellcheck integration for linting
            },
        },
    },
})

lspconfig.yamlls.setup({
    cmd = { "yaml-language-server", "--stdio" }, -- Command to start the YAML Language Server
    filetypes = { "yaml", "yml" },             -- Supported filetypes for YAML
    settings = {
        yaml = {
            schemas = {                                                             -- Optional: Link your YAML files to schema validation
                ["http://json.schemastore.org/github-workflow"] = "/.github/workflows/*", -- Example for GitHub Actions
                ["http://json.schemastore.org/ansible-playbook-2.0"] = "/ansible/**/*.yml", -- Example for Ansible
            },
        },
    },
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
})

local on_attach = function(_, bufnr)
    -- 按键映射（可选）
    local opts = { noremap = true, silent = true, buffer = bufnr }
    map("n", "gk", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    map("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
end

-- Rust LSP 配置
require("rust-tools").setup({
    server = {
        on_attach = on_attach,
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = { command = "clippy" },
                cargo = {
                    allFeatures = true,
                },
                diagnostics = {
                    enable = true,
                },
            },
        },
    },
})

lspconfig.ts_ls.setup({ on_attach = on_attach, capabilities = require("cmp_nvim_lsp").default_capabilities() })
lspconfig.cssls.setup({ on_attach = on_attach, capabilities = require("cmp_nvim_lsp").default_capabilities() })
lspconfig.html.setup({ on_attach = on_attach, capabilities = require("cmp_nvim_lsp").default_capabilities() })

local cmp = require("cmp")

cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = {
        ["<C-i>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
    },
})

local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        -- Shell scripts
        null_ls.builtins.formatting.shfmt,

        -- 🖊️ Formatters
        null_ls.builtins.formatting.stylua, -- Lua
        null_ls.builtins.formatting.prettier, -- JS/TS/HTML/CSS
        null_ls.builtins.formatting.black, -- Python
        null_ls.builtins.formatting.shfmt, -- Shell

        -- 🔍 Linters
        require("none-ls.diagnostics.eslint_d"), -- JavaScript/TypeScript
        null_ls.builtins.diagnostics.selene,

        -- 🔧 Code Actions (auto-fixes)
        null_ls.builtins.code_actions.gitsigns, -- Git staging actions
        require("none-ls.code_actions.eslint_d"), -- JavaScript/TypeScript
    },
})

vim.api.nvim_create_autocmd({ "BufWritePre", "BufWritePost" }, {
    pattern = { "*.js", "*.ts", "*.jsx", "*.tsx", "*.rs", "*.py", "*.sh", "*.html", "*.css", "*.lua", "*.json" },
    callback = function()
        vim.lsp.buf.format({ async = false }) -- Format before saving
        -- Update diagnostics (run linting)
        vim.diagnostic.setqflist()        -- Update quickfix list with linting diagnostics
    end,
})

-- Git 状态（左侧标记 + 变更操作）
map("n", "]c", "<cmd>Gitsigns next_hunk<CR>", { desc = "跳到下一个 Git 变更" })
map("n", "[c", "<cmd>Gitsigns prev_hunk<CR>", { desc = "跳到上一个 Git 变更" })
map("n", "<leader>hp", "<cmd>Gitsigns preview_hunk<CR>", { desc = "预览 Git 变更" })
map("n", "<leader>hs", "<cmd>Gitsigns stage_hunk<CR>", { desc = "阶段（Stage）变更" })
map("n", "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<CR>", { desc = "撤销（Undo）变更" })

-- Git 交互（Fugitive）
map("n", "<leader>gs", "<cmd>Git<CR>", { desc = "打开 Git 状态界面" })
map("n", "<leader>gc", "<cmd>Git commit<CR>", { desc = "Git 提交" })
map("n", "<leader>gp", "<cmd>Git push<CR>", { desc = "Git 推送" })
map("n", "<leader>gl", "<cmd>Git pull<CR>", { desc = "Git 拉取" })
map("n", "<leader>gd", "<cmd>Gdiffsplit<CR>", { desc = "Git Diff 视图" })
map("n", "<leader>gb", "<cmd>Gblame<CR>", { desc = "Git Blame" })

-- Git 变更历史（Diffview）
map("n", "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", { desc = "当前文件 Git 变更历史" })
map("n", "<leader>go", "<cmd>DiffviewOpen<CR>", { desc = "打开 Git Diff 视图" })
map("n", "<leader>gq", "<cmd>DiffviewClose<CR>", { desc = "关闭 Git Diff 视图" })

-- Git 冲突解决
map("n", "<leader>co", "<cmd>GitConflictChooseOurs<CR>", { desc = "选择本地版本" })
map("n", "<leader>ct", "<cmd>GitConflictChooseTheirs<CR>", { desc = "选择远程版本" })
map("n", "<leader>cb", "<cmd>GitConflictChooseBase<CR>", { desc = "选择基准版本" })
map("n", "<leader>cn", "<cmd>GitConflictNextConflict<CR>", { desc = "跳到下一个冲突" })

-- LazyGit UI
map("n", "<leader>lg", "<cmd>LazyGit<CR>", { desc = "打开 LazyGit" })

-- Preview markdown
map("n", "<leader>mp", "<cmd>!glow %<CR>", { desc = "Preview Markdown in terminal" })

-- Toggle tree log
map("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

local telescope = require("telescope")
telescope.setup({
    defaults = {
        -- Your default options here
        mappings = {
            i = {
                ["<C-n>"] = "move_selection_next",
                ["<C-p>"] = "move_selection_previous",
            },
        },
    },
})

-- search filename or content
map("n", "<leader>ff", ":Telescope find_files<CR>", { noremap = true, silent = true })
map("n", "<leader>fg", ":Telescope live_grep<CR>", { silent = true })

-- Set custom colors for blame text
vim.api.nvim_set_hl(0, "GitsignsCurrentLineBlame", { fg = "#ff79c6", bg = "#282a36" })

vim.opt.number = true
vim.opt.tabstop = 4      -- 设定 Tab 宽度为 4
vim.opt.shiftwidth = 4   -- 自动缩进的宽度也是 4
vim.opt.expandtab = true -- 使用空格替代 Tab

vim.diagnostic.config({
    virtual_text = false,         -- Disable inline text
    float = { border = "rounded" }, -- Use a floating window
})

vim.keymap.set("n", "K", function()
    vim.diagnostic.open_float(nil, { border = "rounded" })
end, { noremap = true, silent = true })
