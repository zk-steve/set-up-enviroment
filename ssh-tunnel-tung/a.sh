docker compose run --rm openvpn ovpn_genconfig -u tcp://vpn.thanhtunguet.info:61820
docker compose run --rm openvpn ovpn_initpki

export CLIENTNAME="duc"
docker compose run --rm openvpn easyrsa build-client-full $CLIENTNAME nopass
docker compose run --rm openvpn ovpn_getclient $CLIENTNAME > $CLIENTNAME.ovpn
192.168.255.1