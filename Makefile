PREFIX = /usr/local
CONFIG_FILE = $(PREFIX)/etc/ipv6tun.conf
LAUNCH_DAEMON_PLIST = fr.mathieudarse.ipv6tun.NetworkChange.plist
LAUNCH_DAEMON_DIR = /Library/LaunchDaemons

.PHONY: build link install uninstall

build:
	@true

link:
	ln -sf $(abspath ipv6tun) $(PREFIX)/sbin/ipv6tun
	-ln -s $(abspath ipv6tun.conf) $(PREFIX)/etc/ipv6tun.conf
	ln -sf $(abspath $(LAUNCH_DAEMON_PLIST)) $(LAUNCH_DAEMON_DIR)/$(LAUNCH_DAEMON_PLIST)
	launchctl load -w $(LAUNCH_DAEMON_DIR)/$(LAUNCH_DAEMON_PLIST)

install:
	cp -f ipv6tun $(PREFIX)/sbin/
	cp -n ipv6tun.conf $(PREFIX)/etc/ || true
	cp -f $(LAUNCH_DAEMON_PLIST) $(LAUNCH_DAEMON_DIR)
	launchctl load -w $(LAUNCH_DAEMON_DIR)/$(LAUNCH_DAEMON_PLIST)

uninstall:
	$(RM) /usr/local/sbin/ipv6tun
# Only remove config if it wasn't changed
	cmp -s ipv6tun.conf $(CONFIG_FILE) && $(RM) $(CONFIG_FILE) || true
	-launchctl unload -w $(LAUNCH_DAEMON_DIR)/$(LAUNCH_DAEMON_PLIST)
	$(RM) $(LAUNCH_DAEMON_DIR)/$(LAUNCH_DAEMON_PLIST)
	$(RM) -r $(PREFIX)/var/lib/ipv6tun
