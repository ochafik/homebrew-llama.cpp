class Qwen35Models128gb < Formula
  desc "Qwen3.5 model preset for 128 GB RAM Macs"
  homepage "https://github.com/ochafik/homebrew-llama.cpp"
  url "https://github.com/ochafik/homebrew-llama.cpp/archive/refs/heads/main.tar.gz"
  version "0.1.0"
  license "MIT"

  depends_on "ochafik/llama.cpp/llama-cpp"

  def install
    (bin/"llama-cpp-setup-128gb").write <<~EOS
      #!/bin/bash
      set -e
      echo "Setting GPU memory limit to 124928 MB for 128 GB configuration..."
      sudo sysctl iogpu.wired_limit_mb=124928
      echo "Done. You may need to restart for changes to take full effect."
    EOS
    (bin/"llama-cpp-setup-128gb").chmod 0755
  end

  def post_install
    llama_cli = Formula["llama-cpp"].opt_bin/"llama-cli"

    ohai "Downloading Qwen3.5-27B UD-Q8_K_XL (32.4 GB)..."
    system llama_cli, "-hf", "unsloth/Qwen3.5-27B-GGUF:UD-Q8_K_XL",
           "-p", "hey", "-n", "1", "-no-cnv"

    ohai "Downloading Qwen3.5-122B-A10B UD-Q6_K_XL (105 GB)..."
    system llama_cli, "-hf", "unsloth/Qwen3.5-122B-A10B-GGUF:UD-Q6_K_XL",
           "-p", "hey", "-n", "1", "-no-cnv"
  end

  def caveats
    <<~EOS
      Models are cached in ~/.cache/llama.cpp/

      This tier includes:
        - Qwen3.5-27B UD-Q8_K_XL (32.4 GB) — dense model
        - Qwen3.5-122B-A10B UD-Q6_K_XL (105 GB) — MoE (10B active)

      To configure GPU memory for this tier:
        llama-cpp-setup-128gb

      To start the server with the MoE model:
        llama-server --offline \\
          --api-key-file #{HOMEBREW_PREFIX}/var/llama-cpp/api-key.txt \\
          -hf unsloth/Qwen3.5-122B-A10B-GGUF:UD-Q6_K_XL \\
          -ngl 99
    EOS
  end

  test do
    assert_predicate bin/"llama-cpp-setup-128gb", :exist?
  end
end
