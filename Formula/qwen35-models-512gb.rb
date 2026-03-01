class Qwen35Models512gb < Formula
  desc "Qwen3.5 model preset for 512 GB RAM Macs"
  homepage "https://github.com/ochafik/homebrew-llama.cpp"
  url "https://github.com/ochafik/homebrew-llama.cpp/archive/refs/heads/main.tar.gz"
  version "0.1.0"
  license "MIT"

  depends_on "ochafik/llama.cpp/llama-cpp"

  def install
    (bin/"llama-cpp-setup-512gb").write <<~EOS
      #!/bin/bash
      set -e
      echo "Setting GPU memory limit to 518144 MB for 512 GB configuration..."
      sudo sysctl iogpu.wired_limit_mb=518144
      echo "Done. You may need to restart for changes to take full effect."
    EOS
    (bin/"llama-cpp-setup-512gb").chmod 0755
  end

  def post_install
    llama_cli = Formula["llama-cpp"].opt_bin/"llama-cli"

    ohai "Downloading Qwen3.5-27B UD-Q8_K_XL (32.4 GB)..."
    system llama_cli, "-hf", "unsloth/Qwen3.5-27B-GGUF:UD-Q8_K_XL",
           "-p", "hey", "-n", "1", "-no-cnv"

    ohai "Downloading Qwen3.5-397B-A17B UD-Q8_K_XL (462 GB)..."
    system llama_cli, "-hf", "unsloth/Qwen3.5-397B-A17B-GGUF:UD-Q8_K_XL",
           "-p", "hey", "-n", "1", "-no-cnv"
  end

  def caveats
    <<~EOS
      Models are cached in ~/.cache/llama.cpp/

      This tier includes:
        - Qwen3.5-27B UD-Q8_K_XL (32.4 GB) — dense model
        - Qwen3.5-397B-A17B UD-Q8_K_XL (462 GB) — MoE (17B active)

      To configure GPU memory for this tier:
        llama-cpp-setup-512gb

      To start the server with the MoE model:
        llama-server --offline \\
          --api-key-file #{HOMEBREW_PREFIX}/var/llama-cpp/api-key.txt \\
          -hf unsloth/Qwen3.5-397B-A17B-GGUF:UD-Q8_K_XL \\
          -ngl 99
    EOS
  end

  test do
    assert_predicate bin/"llama-cpp-setup-512gb", :exist?
  end
end
