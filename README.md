# homebrew-llama.cpp

Homebrew tap for [llama.cpp](https://github.com/ochafik/llama.cpp) with MCP and web UI support, plus Qwen3.5 model presets for various Mac RAM tiers.

## Quick Start

```bash
brew tap ochafik/llama.cpp
brew install llama-cpp
```

This builds llama.cpp from the `web-ui-mcp` branch with Metal GPU acceleration, and sets up:
- All llama.cpp binaries (`llama-server`, `llama-cli`, etc.)
- A random API key at `$(brew --prefix)/var/llama-cpp/api-key.txt`
- Log rotation via newsyslog

## Running as a Service

```bash
brew services start ochafik/llama.cpp/llama-cpp
```

The server starts on `http://127.0.0.1:8080` with `--offline` mode and API key authentication.

```bash
# Test the server
curl -H "Authorization: Bearer $(cat $(brew --prefix)/var/llama-cpp/api-key.txt)" \
  http://127.0.0.1:8080/v1/models
```

## Model Presets

Pre-configured model tiers that download optimal Qwen3.5 quantizations for your Mac's RAM:

| Formula | RAM | Dense Model | MoE Model |
|---------|-----|-------------|-----------|
| `qwen35-models-24gb` | 24 GB | 27B UD-Q4_K_XL (16.7 GB) | — |
| `qwen35-models-36gb` | 36 GB | 27B UD-Q6_K_XL (23.1 GB) | 35B-A3B UD-Q6_K_XL (30.3 GB) |
| `qwen35-models-128gb` | 128 GB | 27B UD-Q8_K_XL (32.4 GB) | 122B-A10B UD-Q6_K_XL (105 GB) |
| `qwen35-models-256gb` | 256 GB | 27B UD-Q8_K_XL (32.4 GB) | 397B-A17B UD-Q4_K_XL (219 GB) |
| `qwen35-models-512gb` | 512 GB | 27B UD-Q8_K_XL (32.4 GB) | 397B-A17B UD-Q8_K_XL (462 GB) |

### Install a model tier

```bash
# Example: 128 GB Mac
brew install qwen35-models-128gb

# Configure GPU memory allocation
llama-cpp-setup-128gb

# Start the server with a model
llama-server --offline \
  --api-key-file $(brew --prefix)/var/llama-cpp/api-key.txt \
  -hf unsloth/Qwen3.5-122B-A10B-GGUF:UD-Q6_K_XL \
  -ngl 99
```

Models are cached in `~/.cache/llama.cpp/`.

See [LLAMA_CPP_MODELS.md](LLAMA_CPP_MODELS.md) for the full quant reference tables.

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).
