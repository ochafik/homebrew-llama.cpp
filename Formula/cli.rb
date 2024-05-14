class Cli < Formula
  desc "Port of Facebook's LLaMA model in C/C++"
  homepage "https://github.com/ggerganov/llama.cpp"
  url "https://github.com/ochafik/llama.cpp/archive/refs/heads/cli-tmp.tar.gz"
  version "d10a913f2175a3fbdbfffb2e20816a9bf955b377"
  sha256 "341f41ea00b01bb38852da1c43874597ae4f5e4a8f11c1f50c2de741846382d4"
  license "MIT"

  depends_on "cmake" => :build
  depends_on "curl" => :build
  depends_on "openblas" => :build

  def install
    system "cmake", "-B", "build",
      "-DLLAMA_CURL=1",
      "-DLLAMA_OPENBLAS=1",
      "-DLLAMA_CLI=1",
      "-DLLAMA_METAL_EMBED_LIBRARY=1",
      "-DLLAMA_LTO=1",
      *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system "#{bin}/llama-cpp", "commands"
  end
end
