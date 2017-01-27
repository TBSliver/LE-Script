# LE Script

Simple script setup for Lets Encrypt.

# Usage

Initial setup is done by running the setup script:

```
setup.sh
```

This script assumes you have perl installed on your server, with a version of
atleast 5.10.

After this, you will need to perform some configuration changes to your current
server setup. Assuming you dont have an SSL certificate already set up for your
server, if you add the following to your configuration, modifying the paths to
point to the correct folders inside this repo.

## Server Configuration

These are some example configurations for some popular web servers - the basic idea however is to serve the challenge-root folder as a static file, with no way of browsing it (for security)

### Apache

This is assuming you are running Apache 2.2 - inside your VirtualHost entry, add the following (or an equivalent):

```
  <Directory "/path/to/challenge-root/">
    Options -Indexes
    Allow from all
    Order allow,deny
  </Directory>
  Alias /.well-known/acme-challenge/ /path/to/challenge-root/
```

### Nginx

*Currently un-tested* - Please let me know if it works, or if it requires changes!

```
location ^~ /.well-known/acme-challenge/ {
  default_type "text/plain";
  root /path/to/challenge-root/;
}

location = /.well-known/acme-challenge/ {
  return 404;
}
```

## Configuration File

Copy the `config.json.example` file to `config.json` and edit it as you require for your sites.

## Run Script

After all this, run the `getssl` script. If you run it as is, you will be
running against the staging LE servers - the certificates it gets will not be
trusted. However it is a good way of making sure your config is correct:

```
./getssl
```

If you run the script with the argument `live` then it will run against the
production LE servers. The certificates it generates will be valid and trusted.

```
./getssl live
```

## Installing Certs

The final step is to set up your new SSL Certificates, and move the
modifications you performed earlier into the `443` (or SSL side) of your web
server configuration, and add a redirect which redirects ALL trafic to the
HTTPS endpoint. Done!

# Support

This comes with minimal support - if people find it useful, great. If you have
issues, ask in the GH issues and I will endevour to answer when time permits.

If these scripts crash your server, revoke your certificates, or eat your dog,
I take no responsibility - While the greatest care has been taken for these
scripts to work, it is on the user to read and understand what they are doing.

# Technology Used

* [cpanm](https://p3rl.org/App::cpanminus)
* [Crypt::LE](https://p3rl.org/Crypt::LE)
* [Lets Encrypt](https://letsencrypt.org)
