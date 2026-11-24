return {
  "milanglacier/minuet-ai.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    provider = "openai_fim_compatible",
    n_completions = 2,
    context_window = 512,
    provider_options = {
      openai_fim_compatible = {
        end_point = "http://192.168.50.6:1234/v1/completions",
        model = "qwen2.5-coder-7b-instruct",
        name = "LM Studio",
        api_key = "TERM",
      },
    },
  },
}
