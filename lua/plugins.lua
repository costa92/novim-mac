-- 自动安装 Packer.nvim
-- 插件安装目录
-- ~/.local/share/nvim/site/pack/packer/
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local paccker_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
  vim.notify("正在安装Pakcer.nvim，请稍后...")
  paccker_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    -- "https://github.com/wbthomason/packer.nvim",
    "https://gitcode.net/mirrors/wbthomason/packer.nvim",
    install_path,
  })

  -- https://github.com/wbthomason/packer.nvim/issues/750
  local rtp_addition = vim.fn.stdpath("data") .. "/site/pack/*/start/*"
  if not string.find(vim.o.runtimepath, rtp_addition) then
    vim.o.runtimepath = rtp_addition .. "," .. vim.o.runtimepath
  end
  vim.notify("Pakcer.nvim 安装完毕")
end


-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  vim.notify("没有安装 packer.nvim")
  return
end


packer.startup({
   function(use)
    -- Packer 可以升级自己
    use("wbthomason/packer.nvim")

    -- nvim-tree
    use({
      "kyazdani42/nvim-tree.lua",
      requires = "kyazdani42/nvim-web-devicons",
    }) 
    -- bufferline
    use({
      "akinsho/bufferline.nvim",
      requires = { "kyazdani42/nvim-web-devicons", "moll/vim-bbye" },
    })
    -- lualine
    use({
      "nvim-lualine/lualine.nvim",
      requires = { "kyazdani42/nvim-web-devicons" },
    })
        
    -- telescope
    use({
      "nvim-telescope/telescope.nvim",
      requires = { "nvim-lua/plenary.nvim" },
    })
    -- telescope extensions
    use("LinArcX/telescope-env.nvim")
    use("nvim-telescope/telescope-ui-select.nvim")

    -- 方法聚焦
    use({
        "SmiteshP/nvim-gps",
        requires = "nvim-treesitter/nvim-treesitter",
        config = function()
        require("nvim-gps").setup()
        --  require('goto-preview').setup {}
        end
     })

    -- dashboard-nvim
    use("glepnir/dashboard-nvim")

    -- //引用的方法使用弹框显示，而不是跳转tab
    use({
        "rmagatti/goto-preview",
        config = function()
        require("goto-preview").setup {}
        end
    })    
    -- go 语法工具 
    use("fatih/vim-go")
    
    use("Shougo/deoplete.nvim")
    --   错误美化
    use({
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
                require("trouble").setup {}
        end
    })

    -- 代码格式化
    use("sbdchd/neoformat")
    use({
        "AndrewRadev/switch.vim",
        event = {"BufRead", "BufNewFile"}
    })

   --------------------- LSP --------------------
   use({"williamboman/nvim-lsp-installer"})
   -- lsp 加载进度ui 
   use("j-hui/fidget.nvim")
   -- use("arkav/lualine-lsp-progress")
   -- use({ "williamboman/nvim-lsp-installer", commit = "36b44679f7cc73968dbb3b09246798a19f7c14e0" })
   -- Lspconfig
   use({"neovim/nvim-lspconfig"})  
   -- 补全引擎
   use("hrsh7th/nvim-cmp")
   -- Snippet 引擎
   use("hrsh7th/vim-vsnip")
   -- 补全源
  use("hrsh7th/cmp-vsnip")
  use("hrsh7th/cmp-nvim-lsp") -- { name = nvim_lsp }
  use("hrsh7th/cmp-buffer") -- { name = 'buffer' },
  use("hrsh7th/cmp-path") -- { name = 'path' }
  use("hrsh7th/cmp-cmdline") -- { name = 'cmdline' }
  use("hrsh7th/cmp-nvim-lsp-signature-help") -- { name = 'nvim_lsp_signature_help' }
 
                
  -- //拼写建议
  use("f3fora/cmp-spell")
  
  -- 常见编程语言代码段
  use("rafamadriz/friendly-snippets")
  
  -- UI 增强
  use("onsails/lspkind-nvim")
  use("tami5/lspsaga.nvim")
  -- TypeScript 增强
  use({ "jose-elias-alvarez/nvim-lsp-ts-utils", requires = "nvim-lua/plenary.nvim" })
  -- Lua 增强
  use("folke/lua-dev.nvim")  
  -- JSON 增强
  use("b0o/schemastore.nvim")
  
  use({"jose-elias-alvarez/null-ls.nvim", requires = "nvim-lua/plenary.nvim"})
  -- Rust 增强
  use("simrat39/rust-tools.nvim")
  use({"michaelb/sniprun", run = "bash ./install.sh"})
  use("nvim-lua/plenary.nvim")
  use("windwp/nvim-spectre")
 
  -- gruvbox theme
  use {
     "ellisonleao/gruvbox.nvim",
     requires = {"rktjmp/lush.nvim"}
  }
  use("junegunn/fzf.vim")
  use({ "akinsho/toggleterm.nvim" })
  -- Comment
  use("numToStr/Comment.nvim")
 
  -- nvim-autopairs
  use("windwp/nvim-autopairs")               
  use("windwp/nvim-ts-autotag")
  -- git
  use({"lewis6991/gitsigns.nvim"})
                
 if paccker_bootstrap then
      packer.sync()
    end
  end,
  config = {
    -- 锁定插件版本在snapshots目录
    -- snapshot_path = require("packer.util").join_paths(vim.fn.stdpath("config"), "snapshots"),
    -- 这里锁定插件版本在v1，不会继续更新插件
    -- snapshot = "v1",

    -- 最大并发数
    max_jobs = 16,
    -- 自定义源
    git = {
      -- default_url_format = "https://hub.fastgit.xyz/%s",
      -- default_url_format = "https://mirror.ghproxy.com/https://github.com/%s",
      -- default_url_format = "https://gitcode.net/mirrors/%s",
      -- default_url_format = "https://gitclone.com/github.com/%s",
    },
    -- display = {
    -- 使用浮动窗口显示
    --   open_fn = function()
    --     return require("packer.util").float({ border = "single" })
    --   end,
    -- },
  },
})


