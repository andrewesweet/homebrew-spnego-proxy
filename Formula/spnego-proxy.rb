class SpnegoProxy < Formula
  desc "SPNEGO/Kerberos authenticating HTTP proxy"
  homepage "https://github.com/andrewesweet/spnego-proxy"
  url "https://github.com/andrewesweet/spnego-proxy/archive/refs/tags/v1.3.9.tar.gz"
  sha256 "0f8edc84ba693fa2b6f3b85717608145fa2604718e59ade8448ecad422b6ec0e"
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
