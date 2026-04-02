class SpnegoProxy < Formula
  desc "SPNEGO/Kerberos authenticating HTTP proxy"
  homepage "https://github.com/andrewesweet/spnego-proxy"
  url "https://github.com/andrewesweet/spnego-proxy/archive/refs/tags/v1.2.4.tar.gz"
  sha256 "b7900e337eab5a1d9d8ce767c2f837839680330969ef5617f1cd884e2cfa381a"
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
