local function rojo_project()
  return vim.fs.root(0, function(name)
    return name:match("%.project.json$")
  end)
end

if rojo_project() then
  vim.filetype.add({
    extension = {
      lua = function(path)
        return path:match(".nvim.lua$") and "lua" or "luau"
      end,
    },
  })
end

local function create_capabilities()
  local capabilities = vim.tbl_deep_extend(
    "force",
    vim.lsp.protocol.make_client_capabilities(),
    require("cmp_nvim_lsp").default_capabilities()
  )

  return vim.tbl_deep_extend("force", capabilities, {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
  })
end

local capabilities = create_capabilities()

return {
  {
    "lopi-py/luau-lsp.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("luau-lsp").setup({
        platform = {
          type = "roblox",
        },
        types = {
          roblox_security_level = "PluginSecurity",
        },
        sourcemap = {
          enabled = true,
          autogenerate = true,
          rojo_project_file = "default.project.json",
        },
        server = {
          capabilities = capabilities,
          settings = {
            ["luau-lsp"] = {
              completion = {
                imports = {
                  enabled = true,
                  suggestServices = true,
                  suggestRequires = true,
                },
              },
            },
          },
        },
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "luau_lsp",
          "tsserver",
        },
      })

      require("mason-lspconfig").setup_handlers({
        luau_lsp = function() end,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("lspconfig").lua_ls.setup({
        capabilities = capabilities,
      })

      require("lspconfig").tsserver.setup({
        capabilities = capabilities,
      })

      local function map(mode, lhs, rhs)
        vim.keymap.set(mode, lhs, rhs, {})
      end

      map("n", "gd", vim.lsp.buf.definition)
      map("n", "gD", vim.lsp.buf.declaration)
      map("n", "gr", vim.lsp.buf.references)
      map("n", "K", vim.lsp.buf.hover)
      map("n", "<leader>r", vim.lsp.buf.rename)
      map("n", "<leader>ca", vim.lsp.buf.code_action)
    end,
  },
}
