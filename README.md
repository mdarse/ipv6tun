# ipv6tun
IPv6 Tunnel Broker daemon for Mac OS X

An IPv6 tunnel make it possible to access the IPv6 side of the Internet when the current internet service provider doesn't comes (yet?) with native support. This project aims to make it easier to setup and use such tunnel on Mac OS X.

Right now, tunnels were only tested with [Hurricane Electric's Tunnel Broker service](https://tunnelbroker.net), but it should work with other providers too.

## Public client address update
ipv6tun can take care of updating the client side IPv4 address of the tunnel on the provider side. This feature is optional and only supported with Hurricane Electric at the moment. Support for SixXS is being considered.

## FAQ

- **What kind of tunnel is this?**

This project makes creates `6in4` tunnels using `gif` interfaces (which support is built-in OSX).

## Install
In the project directory:
```shell
$ sudo make install
```
This copies the `ipv6tun` executable to `/usr/local` and a configuration file at `/usr/local/etc/ipv6tun.conf`. It also take take care of registering with the system in order to keep the tunnel working in case of network change:
- Wi-Fi toggle
- Ethernet (un)plug
- DHCP lease expiry
- etc

## Configuration and usage
The configuration is done with a single configuration file. Relevant information should be provided by your tunnel broker.

```ini
# In /usr/local/etc/ipv6tun.conf
ipv6_wan_address=<put_here_the_client_ipv6_address>
ipv6_default_route=<put_here_the_server_ipv6_address>
remote_ipv4_address=<put_here_the_server_ipv4_address>
tunnelbroker_update_enabled=no # Put to "yes" to enable feature
tunnelbroker_tunnel_id=000000
tunnelbroker_account_name=somebody
tunnelbroker_update_key=secret
```

Once configuration is done tunnel can be made `up` or `down` with respectively `$ ipv6tun up` or `$ ipv6tun down`. Tunnel status persist across reboots.
