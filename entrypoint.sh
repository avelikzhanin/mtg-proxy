#!/bin/sh
set -e

PORT=${PORT:-8443}

# Generate secret if not provided via env var
if [ -z "$MTPROTO_SECRET" ]; then
  MTPROTO_SECRET=$(mtg generate-secret --hex google.com)
fi

# Write config
cat > /tmp/config.toml <<EOF
secret = "$MTPROTO_SECRET"
bind-to = "0.0.0.0:$PORT"

[network]
dns = "https://1.1.1.1"
EOF

echo "==========================================="
echo "  MTProto Proxy running on port $PORT"
echo "  Secret: $MTPROTO_SECRET"
echo "  DNS: Cloudflare DoH (1.1.1.1)"
echo "==========================================="

exec mtg run /tmp/config.toml
