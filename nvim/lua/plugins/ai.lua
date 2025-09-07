return {
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.api.nvim_set_keymap("i", "<C-g>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim" },
    },
    opts = {
      debug = false,
    },
    keys = {
      { "<leader>cc", "<cmd>CopilotChat<cr>", desc = "Open Copilot Chat" },
      { "<leader>ce", "<cmd>CopilotChatExplain<cr>", desc = "Explain code" },
      { "<leader>cr", "<cmd>CopilotChatReview<cr>", desc = "Review code" },
      { "<leader>cf", "<cmd>CopilotChatFix<cr>", desc = "Fix code" },
      { "<leader>co", "<cmd>CopilotChatOptimize<cr>", desc = "Optimize code" },
    },
  },
}
