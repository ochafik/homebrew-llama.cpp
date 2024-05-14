class Cli < Formula
  desc "Port of Facebook's LLaMA model in C/C++"
  homepage "https://github.com/ggerganov/llama.cpp"

  url "https://github.com/ochafik/llama.cpp.git",
    revision: "663300ca2933cf6513e93b74c8cfe66984247512"
  version "663300ca2933cf6513e93b74c8cfe66984247512"

  head "https://github.com/ochafik/llama.cpp.git",
    branch: "cli"

  license "MIT"

  depends_on "cmake" => :build
  depends_on "curl" => :build
  depends_on "openblas" => :build
  depends_on :macos

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

    bin.install "build/bin/llama-cpp" => "llama-cpp"
  end

  test do
    system "#{bin}/llama-cpp", "commands"
  end
end
