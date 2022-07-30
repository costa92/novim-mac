-- 基础配置
require("basic")

-- 快捷键映射
require("keybindings")


require("plugins")

require("colorscheme")
-- 自动命令
require("autocmds")

-- 插件配置
require("plugin-config.nvim-tree")
require("plugin-config.bufferline")
require("plugin-config.lualine")
        
require("plugin-config.dashboard")

-- //高亮  ：TSInstall
require("plugin-config.nvim-treesitter")
require("plugin-config.comment")
require("plugin-config.fidget")

-- 格式化插件
require("plugin-config.neoformat")
require("plugin-config.switch")


-- 内置LSP
require("lsp.setup")
require("lsp.cmp")
require("lsp.ui")
-- 格式化
-- require("lsp.formatter")
require("lsp.null-ls")
-- VimspectorInstall
-- https://puremourning.github.io/vimspector/configuration.html#remote-debugging-support
require("spector.vimspector")
