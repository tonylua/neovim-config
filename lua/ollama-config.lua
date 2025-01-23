local ollama_defaults = {
  model = "qwen2.5-coder:latest",
  url = "http://127.0.0.1:11434",
  serve = {
    on_start = false,
    command = "ollama",
    args = { "serve" },
    stop_command = "pkill",
    stop_args = { "-SIGTERM", "ollama" },
  },
  -- View the actual default prompts in ./lua/ollama/prompts.lua
  -- prompts = {
    -- Sample_Prompt = {
    --   prompt = "This is a sample prompt that receives $input and $sel(ection), among others.",
    --   input_label = "> ",
    --   model = "mistral",
    --   action = "display",
    -- }
  -- }
}

require('ollama').setup(ollama_defaults)
