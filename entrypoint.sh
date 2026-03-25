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
EOF

echo "==========================================="
echo "  MTProto Proxy running on port $PORT"
echo "  Secret: $MTPROTO_SECRET"
echo "==========================================="
echo ""
echo "  After enabling TCP Proxy in Railway,"
echo "  use this link in Telegram (replace HOST and PORT):"
echo ""
echo "  tg://proxy?server=HOST&port=PORT&secret=$MTPROTO_SECRET"
echo ""
echo "==========================================="

exec mtg run /tmp/config.toml
