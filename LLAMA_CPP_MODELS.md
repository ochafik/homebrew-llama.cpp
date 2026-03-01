# Qwen3.5 Model Reference for homebrew-llama.cpp

This document lists available GGUF quantizations for Qwen3.5 model families, with RAM tier recommendations.

## RAM Tier Recommendations

| Tier | Available Budget | Dense Model (Qwen3.5-27B) | MoE Model | GPU Memory (iogpu MB) |
|------|-----------------|---------------------------|-----------|----------------------|
| **24 GB** | 18 GB | UD-Q4_K_XL (16.7 GB) | *(none — too large)* | 18432 |
| **36 GB** | 30 GB | UD-Q6_K_XL (23.1 GB) | 35B-A3B UD-Q6_K_XL (30.3 GB) | 30720 |
| **128 GB** | 122 GB | UD-Q8_K_XL (32.4 GB) | 122B-A10B UD-Q6_K_XL (105 GB) | 124928 |
| **256 GB** | 250 GB | UD-Q8_K_XL (32.4 GB) | 397B-A17B UD-Q4_K_XL (219 GB) | 256000 |
| **512 GB** | 506 GB | UD-Q8_K_XL (32.4 GB) | 397B-A17B UD-Q8_K_XL (462 GB) | 518144 |

**Budget** = Total RAM - 6 GB (reserved for OS and other processes).

**Selection criteria**: Prefer UD (Unsloth Dynamic) variants, largest quant that fits, minimum Q4_K_M.

## GPU Memory Configuration

To allocate GPU memory on macOS (requires reboot or `sudo`):

```bash
sudo sysctl iogpu.wired_limit_mb=<value>
```

The model tier formulae install a `llama-cpp-setup-Xgb` script that runs this for you.

## Download Patterns

Models are hosted on Hugging Face by [Unsloth](https://huggingface.co/unsloth). Download with:

```bash
# Short form (if quant name is unambiguous)
llama-cli -hf unsloth/Qwen3.5-27B-GGUF:UD-Q4_K_XL -p hey -n 1 -no-cnv

# Long form (explicit file)
llama-cli --hf-repo unsloth/Qwen3.5-27B-GGUF --hf-file Qwen3.5-27B-UD-Q4_K_XL.gguf -p hey -n 1 -no-cnv
```

Models are cached in `~/.cache/llama.cpp/`.

---

## Qwen3.5-27B (Dense, 27B parameters)

Source: `unsloth/Qwen3.5-27B-GGUF`

| Quant | Size | Notes |
|-------|------|-------|
| Q2_K | 10.5 GB | |
| Q3_K_S | 12.4 GB | |
| Q3_K_M | 13.3 GB | |
| Q3_K_L | 14.2 GB | |
| Q4_0 | 15.3 GB | |
| Q4_K_S | 15.5 GB | |
| Q4_K_M | 16.2 GB | |
| UD-Q4_K_XL | 16.7 GB | Unsloth Dynamic |
| Q5_0 | 18.5 GB | |
| Q5_K_S | 18.5 GB | |
| Q5_K_M | 18.9 GB | |
| Q6_K | 21.8 GB | |
| UD-Q6_K_XL | 23.1 GB | Unsloth Dynamic |
| Q8_0 | 28.3 GB | |
| UD-Q8_K_XL | 32.4 GB | Unsloth Dynamic |
| BF16 | 53.8 GB | |

---

## Qwen3.5-35B-A3B (MoE, 3B active / 35B total)

Source: `unsloth/Qwen3.5-35B-A3B-GGUF`

| Quant | Size | Notes |
|-------|------|-------|
| IQ2_XXS | 9.76 GB | |
| Q2_K | 12.3 GB | |
| Q3_K_S | 14.7 GB | |
| Q3_K_M | 15.8 GB | |
| Q3_K_L | 17.0 GB | |
| Q4_0 | 18.5 GB | |
| Q4_K_S | 18.8 GB | |
| Q4_K_M | 19.6 GB | |
| Q5_0 | 22.5 GB | |
| Q5_K_S | 22.5 GB | |
| Q5_K_M | 23.0 GB | |
| Q6_K | 26.5 GB | |
| UD-Q6_K_XL | 30.3 GB | Unsloth Dynamic |
| Q8_K_XL | 38.7 GB | |

---

## Qwen3.5-122B-A10B (MoE, 10B active / 122B total)

Source: `unsloth/Qwen3.5-122B-A10B-GGUF`

| Quant | Size | Notes |
|-------|------|-------|
| TQ1_0 | 29.5 GB | |
| TQ2_0 | 38.9 GB | |
| IQ2_XXS | 33.1 GB | |
| IQ2_XS | 36.2 GB | |
| IQ2_S | 37.7 GB | |
| IQ2_M | 40.7 GB | |
| IQ3_XXS | 44.4 GB | |
| Q2_K | 42.5 GB | |
| IQ3_XS | 47.1 GB | |
| IQ3_S | 49.7 GB | |
| IQ3_M | 51.2 GB | |
| Q3_K_S | 51.2 GB | |
| IQ4_XS | 53.5 GB | |
| Q3_K_M | 55.0 GB | |
| Q3_K_L | 59.2 GB | |
| IQ4_NL | 56.5 GB | |
| Q4_0 | 64.5 GB | |
| Q4_K_S | 65.3 GB | |
| Q4_K_M | 68.1 GB | |
| UD-Q4_K_XL | 70.3 GB | Unsloth Dynamic |
| Q5_0 | 78.3 GB | |
| Q5_K_S | 78.5 GB | |
| Q5_K_M | 80.1 GB | |
| Q6_K | 92.3 GB | |
| UD-Q6_K_XL | 105 GB | Unsloth Dynamic |
| Q8_0 | 119 GB | |
| UD-Q8_K_XL | 141 GB | Unsloth Dynamic |
| BF16 | 244 GB | |

---

## Qwen3.5-397B-A17B (MoE, 17B active / 397B total)

Source: `unsloth/Qwen3.5-397B-A17B-GGUF`

| Quant | Size | Notes |
|-------|------|-------|
| TQ1_0 | 94.2 GB | |
| TQ2_0 | 124 GB | |
| IQ2_XXS | 107 GB | |
| IQ2_XS | 117 GB | |
| IQ2_S | 122 GB | |
| IQ2_M | 131 GB | |
| IQ3_XXS | 143 GB | |
| Q2_K | 137 GB | |
| IQ3_XS | 152 GB | |
| IQ3_S | 160 GB | |
| IQ3_M | 165 GB | |
| Q3_K_S | 165 GB | |
| IQ4_XS | 173 GB | |
| Q3_K_M | 177 GB | |
| Q3_K_L | 190 GB | |
| IQ4_NL | 182 GB | |
| Q4_0 | 208 GB | |
| Q4_K_S | 210 GB | |
| Q4_K_M | 219 GB | |
| UD-Q4_K_XL | 219 GB | Unsloth Dynamic |
| Q5_0 | 252 GB | |
| Q5_K_S | 253 GB | |
| Q5_K_M | 258 GB | |
| Q6_K | 298 GB | |
| UD-Q6_K_XL | 310 GB | Unsloth Dynamic |
| Q8_0 | 386 GB | |
| UD-Q8_K_XL | 462 GB | Unsloth Dynamic |
| BF16 | 793 GB | |

---

## Nemotron-3-Nano-30B-A3B (MoE, 3B active / 30B total)

Source: `unsloth/Nemotron-3-Nano-30B-A3B-GGUF`

| Quant | Size | Notes |
|-------|------|-------|
| IQ2_XXS | 18.1 GB | |
| IQ2_XS | 19.4 GB | |
| IQ2_S | 20.2 GB | |
| IQ2_M | 21.4 GB | |
| Q2_K | 20.3 GB | |
| IQ3_XXS | 22.7 GB | |
| IQ3_XS | 24.3 GB | |
| IQ3_S | 25.5 GB | |
| IQ3_M | 25.6 GB | |
| Q3_K_S | 25.5 GB | |
| IQ4_XS | 27.3 GB | |
| Q3_K_M | 27.5 GB | |
| Q3_K_L | 29.2 GB | |
| Q4_0 | 31.4 GB | |
| Q4_K_S | 31.7 GB | |
| Q4_K_M | 33.2 GB | |
| Q5_0 | 38.2 GB | |
| Q5_K_S | 38.2 GB | |
| Q5_K_M | 39.1 GB | |
| Q6_K | 45.3 GB | |
| Q8_0 | 58.7 GB | |
| BF16 | 63.2 GB | |
