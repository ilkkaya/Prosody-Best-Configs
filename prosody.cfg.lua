admins = { ibrahim }

modules_enabled = {
	"roster"; -- Allow users to have a roster. Recommended ;)
	"saslauth"; -- Authentication for clients and servers. Recommended if you want to log in.
	"tls"; -- Add support for secure TLS on c2s/s2s connections
	"dialback"; -- s2s dialback support
	"disco"; -- Service discovery
	"carbons"; -- Keep multiple clients in sync
	"pep"; -- Enables users to publish their mood, activity, playing music and more
	"private"; -- Private XML storage (for room bookmarks, etc.)
	"blocklist"; -- Allow users to block communications with other users
	"vcard"; -- Allow users to set vCards
	"version"; -- Replies to server version requests
	"uptime"; -- Report how long server has been running
	"time"; -- Let others know the time here on this server
	"ping"; -- Replies to XMPP pings with pongs
	"register"; -- Allow users to register on this server using a client and change passwords
	--"mam"; -- Store messages in an archive and allow users to access it
	"admin_adhoc"; -- Allows administration via an XMPP client that supports ad-hoc commands
	--"admin_telnet"; -- Opens telnet console interface on localhost port 5582
	--"bosh"; -- Enable BOSH clients, aka "Jabber over HTTP"
	--"websocket"; -- XMPP over WebSockets
	--"http_files"; -- Serve static files from a directory over HTTP
	--"limits"; -- Enable bandwidth limiting for XMPP connections
	--"groups"; -- Shared roster support
	--"server_contact_info"; -- Publish contact information for this service
	--"announce"; -- Send announcement to all online users
	--"welcome"; -- Welcome users who register accounts
	--"watchregistrations"; -- Alert admins of registrations
	--"motd"; -- Send a message to users when they log in
	--"legacyauth"; -- Legacy authentication. Only used by some old clients and bots.
	--"proxy65"; -- Enables a file transfer proxy service which clients behind NAT can use
}

modules_disabled = {
	-- "offline"; -- Store offline messages
	--"c2s"; -- Handle client connections
	--"s2s"; -- Handle server-to-server connections
	-- "posix"; -- POSIX functionality, sends server to background, enables syslog, etc.
}

allow_registration = false
c2s_require_encryption = true
s2s_require_encryption = true
s2s_secure_auth = true
--s2s_insecure_domains = { "insecure.example" }
--s2s_secure_domains = { "jabber.org" }

pidfile = "/var/run/prosody/prosody.pid"
authentication = "internal_hashed"
archive_expires_after = "1w"

log = {
	info = "/var/log/prosody/prosody.log";
	error = "/var/log/prosody/prosody.err";
}


certificates = "/etc/prosody/certs"

VirtualHost "localhost"
	ssl = {
		key = "certs/localhost.key";
		certificate = "certs/localhost.crt";
	}
          
VirtualHost "serverdomain"
        ssl = {
                key = "/etc/prosody/certs/serverdomain.key";
                certificate = "/etc/prosody/certs/serverdomain.crt";
                dhparam = "/etc/prosody/certs/dh-4096.pem";
                options = {"no_sslv2", "no_sslv3"};
                curve = "secp521r1";
                ciphers = "EECDH+ECDSA+AESGCM:EECDH+aRSA+AESGCM:EECDH+ECDSA+SHA512:EECDH+ECDSA+SHA384:EECDH+ECDSA+SHA256:ECDH+AESGCM:ECDH+AES256:DH+AESGCM:DH+AES256:RSA+AESGCM:!aNULL:!eNULL:!LOW:!RC4:!3DES:!MD5:!EXP:!PSK:!SRP:!DSS";  
        }
--Component "serverdomain" "muc"

tls_policy = {
  s2s = {
    cipher = "AESGCM"; -- Require AESGCM ciphers
    protocol = "TLSv1.[12]"; -- and TLSv1.1 or 1.2
    authentication = "RSA"; -- with RSA authentication
  };
}
