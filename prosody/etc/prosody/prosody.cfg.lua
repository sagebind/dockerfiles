-- Core configuration.
daemonize = false
pidfile = "/var/run/prosody/prosody.pid"
use_libevent = true
plugin_paths = {"/srv/prosody/modules"}
log = {
    debug = nil;
    info = "*console";
}

-- Set admin accounts.
if os.getenv("ADMINS") then
    local jids = {}
    for jid in string.gmatch(os.getenv("ADMINS"), "([^,]+)") do
        table.insert(jids, jid)
    end
    admins = jids
else
    admins = {}
end

modules_enabled = {
    "admin_adhoc"; -- administration via an XMPP client that supports ad-hoc commands
    "admin_message"; -- admin console over XMPP
    "announce"; -- Send announcement to all online users
    "blocklist";
    "bosh"; -- support for web clients
    "carbons"; -- live multi device syncing
    "csi"; -- client state indication for mobile
    "dialback"; -- s2s dialback support
    "disco"; -- Service discovery
    "filter_chatstates"; -- csi chat states
    "groups"; -- Shared roster support
    "mam"; -- message archiving
    "pep"; -- Enables users to publish their mood, activity, playing music and more
    "ping"; -- Replies to XMPP pings with pongs
    "posix"; -- POSIX functionality, sends server to background, enables syslog, etc.
    "private"; -- Private XML storage (for room bookmarks, etc.)
    "register"; -- Allow users to register on this server using a client and change passwords
    "roster"; -- Allow users to have a roster. Recommended ;)
    "saslauth"; -- Authentication for clients and servers. Recommended if you want to log in.
    "smacks"; -- unstable client connection support, for users out in the boonies
    "throttle_presence"; -- csi presence
    "time"; -- Let others know the time here on this server
    "tls"; -- secure TLS on c2s/s2s connections
    "uptime"; -- Report how long server has been running
    "vcard"; -- Allow users to set vCards
    "version"; -- Replies to server version requests
}

-- Configure security and SSL/TLS encryption.
authentication = "internal_hashed"
allow_registration = (os.getenv("ALLOW_REGISTRATION") == "true")
c2s_require_encryption = true
s2s_require_encryption = true
s2s_secure_auth = false
s2s_secure_domains = {"jabber.org"}
https_certificate = "/etc/certs/"..os.getenv("HOST")..".crt"

-- Configure storage backend.
default_storage = "sql"
sql = {
    driver = "SQLite3";
    database = "/data/prosody.sqlite";
}
storage = {
    archive2 = "sql";
}

-- Preserve message history forever.
archive_expires_after = "never"

-- Define the virtual host.
VirtualHost(os.getenv("HOST"))
ssl = {
    key = "/etc/certs/"..os.getenv("HOST")..".key";
    certificate = "/etc/certs/"..os.getenv("HOST")..".crt";
}

---Set up a MUC (multi-user chat) room server on conference.example.com:
if os.getenv("MUC_HOST") then
    Component(os.getenv("MUC_HOST"))("muc")
end
