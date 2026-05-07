-- config/autocmds.lua
local function enable_inlay_hints(bufnr)
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return
  end
  vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  vim.notify("Inlay hints enabled for buffer " .. bufnr, vim.log.levels.INFO, { title = "LSP" })
end

local function setup_inlay_hints(client, bufnr)
  if not client.server_capabilities.inlayHintProvider then
    return
  end

  -- 创建临时自动命令组
  local progress_group = vim.api.nvim_create_augroup("LspProgress_" .. client.name .. "_" .. bufnr, {})

  -- 设置超时保护（10秒后无论如何都尝试开启）
  local timeout = vim.defer_fn(function()
    if vim.api.nvim_buf_is_valid(bufnr) then
      vim.notify("Inlay hints enabled via timeout for " .. client.name, vim.log.levels.WARN, { title = "LSP" })
      enable_inlay_hints(bufnr)
    end
    pcall(vim.api.nvim_del_augroup_by_id, progress_group)
  end, 10000)

  -- 监听 LSP 进度事件
  vim.api.nvim_create_autocmd("LspProgress", {
    group = progress_group,
    buffer = bufnr,
    callback = function(args)
      local data = args.data
      if data.client_id ~= client.id then
        return
      end

      local value = data.params.value

      -- 检查各种可能的完成状态
      local is_complete = false

      -- rust-analyzer: Indexing 完成
      if value.kind == "end" and value.title == "Indexing" then
        is_complete = true
      end

      -- 通用：workDoneProgress 完成
      if value.kind == "end" and (value.title == "Server Started" or value.message == "Ready") then
        is_complete = true
      end

      -- 某些 LSP 的初始化完成信号
      if value.percentage == 100 then
        is_complete = true
      end

      if is_complete then
        timeout:close()
        enable_inlay_hints(bufnr)
        pcall(vim.api.nvim_del_augroup_by_id, progress_group)
      end
    end,
  })
end

-- LspAttach 事件处理
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if client then
      setup_inlay_hints(client, args.buf)
    end

    local opts = { buffer = args.buf, remap = false }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "gk", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, opts)
  end,
})

-- 不需要再安装 "neovim/nvim-lspconfig" 插件
-- 直接在你的 init.lua 或对应的配置文件中添加以下代码

-- ============================================
-- LSP 配置（Neovim 0.12 内置 API）
-- ============================================

-- 1. 定义各个 LSP 服务器的配置
vim.lsp.config.clangd = {
  cmd = { "clangd", "--background-index", "--clang-tidy", "--fallback-style=WebKit" },
  filetypes = { "c", "cpp" },
  root_markers = { ".git", "compile_commands.json", "Makefile" },
}

vim.lsp.config.vtsls = {
  cmd = { "vtsls", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_markers = { "package.json", "tsconfig.json", ".git" },
  settings = {
    vtsls = {
      autoUseWorkspaceTsdk = true,
    },
    typescript = {
      inlayHints = {
        parameterNames = { enabled = "all" },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
    },
    javascript = {
      inlayHints = {
        parameterNames = { enabled = "all" },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
    },
  },
}

vim.lsp.config.rust_analyzer = {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml", ".git" },
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = {
        enable = true,
        command = "clippy",
      },
      -- 可选：启用更多 inlay hints
      inlayHints = {
        bindingModeHints = { enable = true },
        chainingHints = { enable = true },
        closureReturnTypeHints = { enable = "always" },
        lifetimeElisionHints = { enable = "always" },
        maxLength = 25,
        parameterHints = { enable = true },
        reborrowHints = { enable = "always" },
        renderColons = true,
        typeHints = { enable = true },
      },
    },
  },
}

vim.lsp.config.lua_ls = {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
  settings = {
    Lua = {
      diagnostics = { enable = false },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  },
}

vim.lsp.config.bashls = {
  cmd = { "bash-language-server", "start" },
  filetypes = { "sh", "bash" },
  root_markers = { ".git", ".bashrc" },
}

vim.lsp.config.html = {
  cmd = { "vscode-html-language-server", "--stdio" },
  filetypes = { "html", "htmldjango" },
  root_markers = { "package.json", ".git" },
}

vim.lsp.config.cssls = {
  cmd = { "vscode-css-language-server", "--stdio" },
  filetypes = { "css", "scss", "less" },
  root_markers = { "package.json", ".git" },
}

vim.lsp.config.jsonls = {
  cmd = { "vscode-json-language-server", "--stdio" },
  filetypes = { "json", "jsonc" },
  root_markers = { "package.json", ".git" },
}

vim.lsp.config.yamlls = {
  cmd = { "yaml-language-server", "--stdio" },
  filetypes = { "yaml", "yml" },
  root_markers = { ".git", ".yamllint" },
  settings = {
    yaml = {
      schemas = {
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
        ["https://json.schemastore.org/prettierrc.json"] = ".prettierrc.yml",
      },
    },
  },
}

-- 2. 启用需要的 LSP 服务器
vim.lsp.enable("clangd")
vim.lsp.enable("vtsls")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("lua_ls")
vim.lsp.enable("bashls")
vim.lsp.enable("html")
vim.lsp.enable("cssls")
vim.lsp.enable("jsonls")
vim.lsp.enable("yamlls")

-- ============================================
-- 可选：设置 LSP 日志级别（调试用）
-- ============================================
-- vim.lsp.set_log_level("debug")
