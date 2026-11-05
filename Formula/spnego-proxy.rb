class SpnegoProxy < Formula
  desc "SPNEGO/Kerberos authenticating HTTP proxy"
  homepage "https://github.com/andrewesweet/spnego-proxy"
  url "https://github.com/andrewesweet/spnego-proxy/archive/refs/tags/v1.3.7.tar.gz"
  sha256 "9bd8275546dcabc3e52b88441ad3a008c9a391a7a68812e28d725d9338998998"
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
