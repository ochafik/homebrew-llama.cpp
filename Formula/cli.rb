class Cli < Formula
  desc "Port of Facebook's LLaMA model in C/C++"
  homepage "https://github.com/ggerganov/llama.cpp"
  url "https://github.com/ochafik/llama.cpp/archive/d328b08a4550effc6e3e2180db2bcd107781816e/cli-tmp.tar.gz"
  version "d328b08a4550effc6e3e2180db2bcd107781816e"
  sha256 "68f589bf4ae921cc3a487a7f84e785020d6528f9d3ab69ea51d5e59c8254b227"

  license "MIT"

  depends_on "cmake" => :build
  depends_on "curl" => :build
  depends_on "openblas" => :build
  depends_on "ccache" => :build

  def install
    system "cmake", "-B", "build",
      "-DLLAMA_CURL=1",
      "-DLLAMA_OPENBLAS=1",
      "-DLLAMA_CLI=1",
      "-DLLAMA_CCACHE=0",
      "-DLLAMA_METAL_EMBED_LIBRARY=1",
      "-DLLAMA_LTO=1",
      "-DLLAMA_BUILD_TESTS=0",
      *std_cmake_args
    system "cmake", "--build", "build", "-t", "llama-cpp"
    system "cmake", "--install", "build"
  end

  test do
    system "#{bin}/llama-cpp", "commands"
  end
end
