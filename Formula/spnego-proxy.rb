class SpnegoProxy < Formula
  desc "SPNEGO/Kerberos authenticating HTTP proxy"
  homepage "https://github.com/andrewesweet/spnego-proxy"
  url "https://github.com/andrewesweet/spnego-proxy/archive/refs/tags/v1.2.6.tar.gz"
  sha256 "e72f36c52304555eeb1ddc550f34f8e424e63413a51fd56281d6dd017d18cba5"
  license "MIT"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "1"
    ldflags = %W[
      -s -w
      -X main.version=#{version}
      -X main.commit=HEAD
    ]
    system "go", "build", *std_go_args(ldflags:)
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/spnego-proxy -version")
  end
end
