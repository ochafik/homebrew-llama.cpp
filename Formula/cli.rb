class Cli < Formula
  desc "Port of Facebook's LLaMA model in C/C++"
  homepage "https://github.com/ggerganov/llama.cpp"
  url "https://github.com/ochafik/llama.cpp/archive/22040277f15efe4e77a428bf5724ffdbe2a1a888/cli-tmp.tar.gz"
  version "22040277f15efe4e77a428bf5724ffdbe2a1a888"
  sha256 "bb9ed66a9553b4ac4e86706faf36e707b1f1ef19c9c2a845137ee78963a89e0c"

  license "MIT"

  depends_on "cmake" => :build
  depends_on "curl" => :build
  depends_on "openblas" => :build

  def install
    system "cmake", "-B", "build",
      "-DLLAMA_CURL=1",
      "-DLLAMA_OPENBLAS=1",
      "-DLLAMA_CLI=1",
      "-DLLAMA_CCACHE=0",
      "-DLLAMA_METAL_EMBED_LIBRARY=1",
      "-DLLAMA_LTO=1",
      "-DLLAMA_BUILD_TESTS=0",
      "-DCMAKE_INSTALL_PREFIX=#{prefix}",
      *std_cmake_args
    system "cmake", "--build", "build", "-t", "llama-cpp"
    system "cmake", "--install", "build"
  end

  test do
    system "#{bin}/llama-cpp", "commands"
  end
end
