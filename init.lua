-- init.lua
require("config.options") -- 1. 基础选项最先
require("config.lazy") -- 2. 插件管理器
require("config.lsp") -- 3. LSP 配置（依赖插件）
require("config.autocmds") -- 4. 自动命令（可能依赖 LSP）
require("config.keymaps") -- 5. 快捷键（最后，覆盖所有默认映射）
