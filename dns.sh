#!/bin/bash

echo "
address=/dev/127.0.0.1" >> /usr/local/etc/dnsmasq.conf

sudo cp /usr/local/Cellar/dnsmasq/2.73/homebrew.mxcl.dnsmasq.plist /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist
launchctl unload /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist
launchctl load /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist

sudo mkdir -p /etc/resolver
sudo tee /etc/resolver/dev >/dev/null <<EOF
nameserver 127.0.0.1
EOF

# Check that .dev names work
ping -c 1 this.is.a.test.dev
ping -c 1 iam.the.walrus.dev