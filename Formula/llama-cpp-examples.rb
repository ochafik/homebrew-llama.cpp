class LlamaCppExamples < Formula
  desc "Port of Facebook's LLaMA model in C/C++"
  homepage "https://github.com/ggerganov/llama.cpp"

  url "https://github.com/ggerganov/llama.cpp.git",
    revision: "663300ca2933cf6513e93b74c8cfe66984247512"
  version "663300ca2933cf6513e93b74c8cfe66984247512"

  head "https://github.com/ggerganov/llama.cpp.git"

  license "MIT"

  depends_on "cmake" => :build
  depends_on "curl" => :build
  depends_on "openblas" => :build
  depends_on :macos

  def install
    system "cmake", "-B", "build",
      "-DLLAMA_BUILD_TESTS=0",
      "-DLLAMA_BUILD_EXAMPLES=1",
      "-DLLAMA_BUILD_SERVER=1",
      "-DLLAMA_CCACHE=0",
      "-DLLAMA_CURL=1",
      "-DLLAMA_OPENBLAS=1",
      "-DLLAMA_METAL_EMBED_LIBRARY=1",
      "-DLLAMA_LTO=1",
      "-DCMAKE_INSTALL_PREFIX=#{prefix}",
      *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"

    bin.install "build/bin/baby-llama" => "llama-cpp-baby-llama"
    bin.install "build/bin/batched" => "llama-cpp-batched"
    bin.install "build/bin/batched-bench" => "llama-cpp-batched-bench"
    bin.install "build/bin/beam-search" => "llama-cpp-beam-search"
    bin.install "build/bin/benchmark" => "llama-cpp-benchmark"
    bin.install "build/bin/convert-llama2c-to-ggml" => "llama-cpp-convert-llama2c-to-ggml"
    bin.install "build/bin/embedding" => "llama-cpp-embedding"
    bin.install "build/bin/eval-callback" => "llama-cpp-eval-callback"
    bin.install "build/bin/export-lora" => "llama-cpp-export-lora"
    bin.install "build/bin/finetune" => "llama-cpp-finetune"
    # bin.install "build/bin/gbnf-validator" => "llama-cpp-gbnf-validator"
    bin.install "build/bin/gguf" => "llama-cpp-gguf"
    bin.install "build/bin/gguf-split" => "llama-cpp-gguf-split"
    bin.install "build/bin/gritlm" => "llama-cpp-gritlm"
    bin.install "build/bin/imatrix" => "llama-cpp-imatrix"
    bin.install "build/bin/infill" => "llama-cpp-infill"
    bin.install "build/bin/llama-bench" => "llama-cpp-llama-bench"
    bin.install "build/bin/llava-cli" => "llama-cpp-llava-cli"
    bin.install "build/bin/lookahead" => "llama-cpp-lookahead"
    bin.install "build/bin/lookup" => "llama-cpp-lookup"
    bin.install "build/bin/lookup-create" => "llama-cpp-lookup-create"
    bin.install "build/bin/lookup-merge" => "llama-cpp-lookup-merge"
    bin.install "build/bin/lookup-stats" => "llama-cpp-lookup-stats"
    bin.install "build/bin/main" => "llama-cpp-main"
    bin.install "build/bin/parallel" => "llama-cpp-parallel"
    bin.install "build/bin/passkey" => "llama-cpp-passkey"
    bin.install "build/bin/perplexity" => "llama-cpp-perplexity"
    bin.install "build/bin/quantize" => "llama-cpp-quantize"
    bin.install "build/bin/quantize-stats" => "llama-cpp-quantize-stats"
    bin.install "build/bin/retrieval" => "llama-cpp-retrieval"
    bin.install "build/bin/server" => "llama-cpp-server"
    bin.install "build/bin/speculative" => "llama-cpp-speculative"
    bin.install "build/bin/tokenize" => "llama-cpp-tokenize"
    bin.install "build/bin/train-text-from-scratch" => "llama-cpp-train-text-from-scratch"
  end

  test do
    system "#{bin}/llama-cpp-main", "--help"
  end
end
