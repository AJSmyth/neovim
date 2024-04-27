return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
            "--query-driver=/nix/store/4ycw7ac13d4nzgqnzm2w1b92dfg2a5h9-gcc-arm-embedded-13.2.rel1/bin/arm-none-eabi-gcc",
          },
        },
      },
    },
  },
}
