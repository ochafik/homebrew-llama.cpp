class LlamaCpp < Formula
  desc "LLM inference in C/C++ (with MCP and web UI support)"
  homepage "https://github.com/ochafik/llama.cpp"
  url "https://github.com/ochafik/llama.cpp.git",
      branch: "web-ui-mcp"
  version "0.1.0"
  license "MIT"
  head "https://github.com/ochafik/llama.cpp.git", branch: "web-ui-mcp"

  depends_on "cmake" => :build
  depends_on "pkgconf" => :build
  depends_on "openssl@3"

  def install
    args = %W[
      -DBUILD_SHARED_LIBS=ON
      -DCMAKE_INSTALL_RPATH=#{rpath}
      -DGGML_ACCELERATE=#{OS.mac? ? "ON" : "OFF"}
      -DGGML_ALL_WARNINGS=OFF
      -DGGML_BLAS=ON
      -DGGML_BLAS_VENDOR=#{OS.mac? ? "Apple" : "OpenBLAS"}
      -DGGML_CCACHE=OFF
      -DGGML_LTO=ON
      -DGGML_METAL=#{(OS.mac? && !Hardware::CPU.intel?) ? "ON" : "OFF"}
      -DGGML_METAL_EMBED_LIBRARY=#{OS.mac? ? "ON" : "OFF"}
      -DGGML_NATIVE=#{build.bottle? ? "OFF" : "ON"}
      -DLLAMA_ALL_WARNINGS=OFF
      -DLLAMA_OPENSSL=ON
    ]
    args << "-DLLAMA_METAL_MACOSX_VERSION_MIN=#{MacOS.version}" if OS.mac?

    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"

    libexec.install bin.children
    bin.install_symlink libexec.children.select { |file|
                          file.executable? && !file.basename.to_s.start_with?("test-")
                        }

    # Install newsyslog config for log rotation
    (etc/"newsyslog.d").mkpath
    (etc/"newsyslog.d/llama-cpp.conf").write <<~EOS
      # logfilename                              [owner:group] mode count size(KB) when  flags [/pid_file] [sig_num]
      #{var}/log/llama-cpp.log                                 644  5     51200    *     GJ
    EOS
  end

  def post_install
    (var/"llama-cpp").mkpath
    (var/"log").mkpath

    # Generate a random API key if one doesn't exist
    api_key_file = var/"llama-cpp/api-key.txt"
    unless api_key_file.exist?
      require "securerandom"
      api_key_file.write SecureRandom.hex(32)
      api_key_file.chmod 0600
    end
  end

  service do
    run [opt_bin/"llama-server", "--offline",
         "--api-key-file", var/"llama-cpp/api-key.txt",
         "--host", "127.0.0.1", "--port", "8080", "-ngl", "99"]
    keep_alive crashed: true
    working_dir var/"llama-cpp"
    log_path var/"log/llama-cpp.log"
    error_log_path var/"log/llama-cpp.log"
    environment_variables PATH: std_service_path_env
  end

  def caveats
    <<~EOS
      An API key has been generated at:
        #{var}/llama-cpp/api-key.txt

      To start the llama-server service:
        brew services start ochafik/llama.cpp/llama-cpp

      The server will listen on http://127.0.0.1:8080

      To test the server:
        curl -H "Authorization: Bearer $(cat #{var}/llama-cpp/api-key.txt)" \\
          http://127.0.0.1:8080/v1/models

      Log rotation is configured at:
        #{etc}/newsyslog.d/llama-cpp.conf
    EOS
  end

  test do
    system bin/"llama-cli", "--help"
  end
end
