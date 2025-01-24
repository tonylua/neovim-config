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
}

require('ollama').setup(ollama_defaults)
