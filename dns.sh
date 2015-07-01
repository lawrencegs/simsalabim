#!/bin/bash

echo "
address=/dev/127.0.0.1" >> /usr/local/etc/dnsmasq.conf

launchctl load /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist
launchctl unload /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist

sudo mkdir -p /etc/resolver
sudo tee /etc/resolver/dev >/dev/null <<EOF
nameserver 127.0.0.1
EOF

# Make sure you haven't broken your DNS.
ping -c 1 www.google.com
# Check that .dev names work
ping -c 1 this.is.a.test.dev
ping -c 1 iam.the.walrus.dev