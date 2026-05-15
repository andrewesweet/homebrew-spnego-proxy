class SpnegoProxy < Formula
  desc "SPNEGO/Kerberos authenticating HTTP proxy"
  homepage "https://github.com/andrewesweet/spnego-proxy"
  url "https://github.com/andrewesweet/spnego-proxy/archive/refs/tags/v1.3.0.tar.gz"
  sha256 "614e3de6b91a88a4c1fd854d8b8f3e1c1efbc6809213b043264d699005ba08f4"
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
