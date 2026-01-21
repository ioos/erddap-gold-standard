[![](https://img.shields.io/badge/GitHub-Pages-blue)](https://ioos.github.io/erddap-gold-standard/) [![](https://img.shields.io/badge/ERDDAP-Deployed-green)](https://standards.sensors.ioos.us/erddap/index.html)

# Overview

Example datasets and configuration for ERDDAP.

Uses the [ERDDAP Docker image](https://github.com/axiom-data-science/docker-erddap).

You can view this setup live at <https://standards.sensors.ioos.us/erddap/index.html>.

Documentation can be found at <https://ioos.github.io/erddap-gold-standard/>.

## Making ERDDAP Publicly Accessible

### URL Construction Behavior

As of ERDDAP 2.28.0, `useHeadersForUrl` defaults to `true`. When enabled, ERDDAP
uses the incoming request’s `Host` and protocol headers to construct URLs,
assuming a correctly configured reverse proxy.

The `ERDDAP_baseUrl` and `ERDDAP_baseHttpsUrl` settings are still used when ERDDAP
generates URLs outside the context of an HTTP request (for example, in emailed
reports or background tasks).

This repository's Docker compose file is configured to work on localhost by
default. To make ERDDAP reachable from a public IP address or domain name,
follow these simple steps:

- Set the host and ports used to build ERDDAP's public URLs. You can do this
  by creating a `.env` file in the same directory as `docker-compose.yml` or
  by exporting the variables in your shell before running `docker-compose up`.

  Example `.env` (replace with your public domain or IP):

  ERDDAP_HOST=example.org
  HOST_HTTP_PORT=8080
  HOST_HTTPS_PORT=443

  The compose file uses these values to set the ERDDAP_baseUrl and
  ERDDAP_baseHttpsUrl environment variables inside the container. Sensible
  defaults keep localhost behavior working without any changes.

- Make sure DNS for your domain points to the machine running the container.
  If the machine is behind a router, configure port forwarding for the ports
  you chose (for example, 80/443 or a custom port) to the host running the
  container.

- Use HTTPS in production. Obtain and install a TLS certificate (for example,
  via Let's Encrypt) for your domain. You can terminate TLS at a reverse
  proxy (nginx, Traefik, Caddy) in front of the ERDDAP container, or configure
  a proxy service to forward HTTPS to the container's HTTP port. ERDDAP itself
  should be left unchanged.

For more detailed ERDDAP deployment guidance (security, reverse proxies,
certificates and recommended production practices), see the upstream ERDDAP
documentation: https://erddap.github.io/
