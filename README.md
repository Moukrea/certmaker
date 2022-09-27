# certmaker

Generate certificates with ease: signed by a self-signed/provided Certification Autoriy or basic (self-signed) certificates.

## TODO

- Use container as a non-root user
- Customize certificates filename on a per domain basis
- Adapt it more for a standalone usage (without Docker)
- Release Docker image for real
- New features as I see fit
- Documentation (classic usage / container)

----

## Basic usage

### From CLI

Assuming the `certmaker` file has been installed to `/usr/local/bin` and the path `/certs` exists on your machine

```shell
certmaker --domain "exemple.com domain.io dev.local"
```

You'll find your Certification Authority and the certificates for `exemple.com`, `domain.io` and `dev.local` within the `/certs` directory

### Docker

```shell
docker run --rm -v "/any/path:/certs" -e DOMAIN="exemple.com domain.io dev.local" ghcr.io/moukrea/certmaker:0.0.1
```

You'll find your Certification Authority and the certificates for `exemple.com`, `domain.io` and `dev.local` within the `/any/path` directory

----

## Environment variables

The tool can process environment variables if ran through the Docker container or through a terminal prompt directly (albeit in this case, it is recommended to use the [CLI options](#cli-options) bellow).

### Options

| Parameter | Default value | Description |
| ---- | ---- | ---- |
| `DOMAIN` | `dev.local` | Domain(s) to sign certificates for |
| `WILDCARD` | `1`/`true` | Enable/Disable wildcards globally for generated certificates |
| `SELF_SIGNED_CA` | `1`/`true` | Enable/Disable self signed CA |
| `PROVIDED_CA` | `1`/`true` | Enable/Disable provided (non-generated) CA |
| `BASIC_CERTS` | `0`/`false` | Enable/Disable basic certificates generation (not signed by a CA) |
| `CA_DURATION` | `7300` (20 years) | Define CA validity duration (in days) |
| `CERT_DURATION` | `397` (maximum) | Define certificates duration (in days) |
| `FALLBACK_OPTIONS` | `1`/`true` | Use options (subject) from CA over certificate if missing (or the opposite) |
| `VERBOSE` | `0`/`false` | Show/Hide verbose informations |
| `FORCE_CA_RENEWAL` | `0`/`false` | Force CA renewal if available |
| `FORCE_CERT_RENEWAL` | `0`/`false` | Force domain(s) certificates renewal if available |
| `FORCE_RENEWAL` | `0`/`false` | Force CA **and** domain(s) certificates renewal if available |
| `TZ` | `UTC` | Timezone settings, only in container _(to get thie right time in logs)_ |
| `PUID` | - | Host user ID, only in container _(to fix certificates ownership)_ |
| `PGID` | - | Host group ID, only in container _(to fix certificates ownership)_ |

### Certification Authority (CA) subject options, superseeded by existing CA (if any)

| Parameter | Default value | Description | Subject setting |
| ---- | ---- | ---- | ---- |
| `CA_SUBJECT` | - | Complete subject (superseeded by individual settings) | - |
| `CA_COUNTRY` | `AU` | Country (Two letters country code) | `countryName`, `C` |
| `CA_STATE` | `Some-State` | State or province name | `stateOrProvinceName`, `ST` |
| `CA_LOCALITY` | - | Locality | `locality`, `L` |
| `CA_ORGANIZATION` | `Internet Widgits Pty Ltd` | Organization | `organizationName`, `O` |
| `CA_ORGANIZATIONAL_UNIT` | - | Organizational-unit | `organizationalUnitName`, `OU` |
| `CA_EMAIL` | - | Email | `emailAddress` |
| `CA_COMMON_NAME` | - | Common name | `commonName`, `CN` |
| `CA_DN_QUALIFIER` | - | Distinguished name qualifier | `dnQualifier` |
| `CA_SERIAL` | - | Serial number | `serialNumber` |
| `CA_TITLE` | - | Title | `title` |
| `CA_SURNAME` | - | Surname | `surname`, `SN` |
| `CA_GIVEN_NAME` | - | Given name | `givenName`, `GN` |
| `CA_INITIALS` | - | Initials | `initials` |
| `CA_PSEUDONYM` | - | Pseudonym | `pseudonym` |
| `CA_GENERATION_QUALIFIER` | - | Generation qualifier | `generationQualifier` |

### Generated certificates subject options, superseeded by existing certificates (if they need renewall)

| Parameter | Default value | Description | Subject setting |
| ---- | ---- | ---- | ---- |
| `CERT_SUBJECT` | - | Complete subject (superseeded by individual settings) | - |
| `CERT_COUNTRY` | `AU` | Country (Two letters country code) | `countryName`, `C` |
| `CERT_STATE` | `Some-State` | State or province name | `stateOrProvinceName`, `ST` |
| `CERT_LOCALITY` | - | Locality | `locality`, `L` |
| `CERT_ORGANIZATION` | `Internet Widgits Pty Ltd` | Organization | `organizationName`, `O` |
| `CERT_ORGANIZATIONAL_UNIT` | - | Organizational-unit | `organizationalUnitName`, `OU` |
| `CERT_EMAIL` | - | Email | `emailAddress` |
| `CERT_COMMON_NAME` | - | Common name | `commonName`, `CN` |
| `CERT_DN_QUALIFIER` | - | Distinguished name qualifier | `dnQualifier` |
| `CERT_SERIAL` | - | Serial number | `serialNumber` |
| `CERT_TITLE` | - | Title | `title` |
| `CERT_SURNAME` | - | Surname | `surname`, `SN` |
| `CERT_GIVEN_NAME` | - | Given name | `givenName`, `GN` |
| `CERT_INITIALS` | - | Initials | `initials` |
| `CERT_PSEUDONYM` | - | Pseudonym | `pseudonym` |
| `CERT_GENERATION_QUALIFIER` | - | Generation qualifier | `generationQualifier` |

----

## CLI options

You can provide command line arguments when you run the tool from a terminal prompt.

### Options

| Short | Long | Args | Description |
| ---- | ---- | ---- | ---- |
| `-h` | `--help` | - | Show help |
| `-v` | `--version` | - | Show script version |
| `-a` | `--domain` | yes | Domain(s) to sign certificates for |
| `-w` | `--no-wildcard` | - | Disable wildcards globally for generated certificates |
| `-y` | `--no-self-signed-ca` | - | Disable self signed CA |
| `-x` | `--no-provided-ca` | - | Disable provided (non-generated) CA |
| `-u` | `--basic-certs` | - | Enable basic certificates generation (not signed by a CA) |
| `-M` | `--ca-duration` | yes | Define CA validity duration (in days) |
| `-m` | `--cert-duration` | yes | Define certificates duration (in days) |
| `-U` | `--fallback-options` | - | Disable options (subject) fallback from CA over certificate if missing (or the opposite) |
| `-V` | `--verbose` | - | Show verbose informations |
| `-K` | `--force-ca-renewal` | - | Force CA renewal if available |
| `-Y` | `--force-cert-renewal` | Force domain(s) certificates renewal if available |
| `-X` | `--force-renewal` | Force CA **and** domain(s) certificates renewal if available |

### Certification Authority (CA) subject options, superseeded by existing CA (if any)

| Short | Long | Args | Description | Subject setting |
| ---- | ---- | ---- | ---- | ---- |
| `-Z` | `--ca-subject` | yes | Complete subject (superseeded by individual settings) | - |
| `-C` | `--ca-country` | yes | Country (Two letters country code) | `countryName`, `C` |
| `-S` | `--ca-state` | yes | State or province name | `stateOrProvinceName`, `ST` |
| `-L` | `--ca-locality` | yes | Locality | `locality`, `L` |
| `-O` | `--ca-organization` | yes | Organization | `organizationName`, `O` |
| `-N` | `--ca-organizational-unit` | yes | Organizational-unit | `organizationalUnitName`, `OU` |
| `-E` | `--ca-email` | yes | Email | `emailAddress` |
| `-D` | `--ca-dn-qualifier` | yes | Distinguished name qualifier | `dnQualifier` |
| `-B` | `--ca-common-name` | yes | Common name | `commonName`, `CN` |
| `-R` | `--ca-serial` | yes | Serial number | `serialNumber` |
| `-T` | `--ca-title` | yes | Title | `title` |
| `-Q` | `--ca-surname` | yes | Surname | `surname`, `SN` |
| `-G` | `--ca-given-name` | yes | Given name | `givenName`, `GN` |
| `-I` | `--ca-initials` | yes | Initials | `initials` |
| `-P` | `--ca-pseudonym` | yes | Pseudonym | `pseudonym` |
| `-F` | `--ca-generation-qualifier` | yes | Generation qualifier | `generationQualifier` |

### Generated certificates subject options, superseeded by existing certificates (if they need renewall)

| Short | Long | Args | Description | Subject setting |
| ---- | ---- | ---- | ---- | ---- |
| `-z` | `--cert-subject` | yes | Complete subject (superseeded by individual settings) | - |
| `-c` | `--cert-country` | yes | Country (Two letters country code) |  `countryName`, `C` |
| `-s` | `--cert-state` | yes | State or province name | `stateOrProvinceName`, `ST` |
| `-l` | `--cert-locality` | yes | Locality | `locality`, `L` |
| `-o` | `--cert-organization` | yes | Organization | `organizationName`, `O` |
| `-n` | `--cert-organizational-unit` | yes | Organizational-unit | `organizationalUnitName`, `OU` |
| `-e` | `--ca-email` | yes | Email | `emailAddress` |
| `-d` | `--cert-dn-qualifier` | yes | Distinguished name qualifier | `dnQualifier` |
| `-b` | `--cert-common-name` | yes | Common name | `commonName`, `CN` |
| `-r` | `--cert-serial` | yes | Serial number | `serialNumber` |
| `-t` | `--cert-title` | yes | Title | `title` |
| `-q` | `--cert-surname` | yes | Surname | `surname`, `SN` |
| `-g` | `--cert-given-name` | yes | Given name | `givenName`, `GN` |
| `-i` | `--cert-initials` | yes | Initials | `initials` |
| `-p` | `--cert-pseudonym` | yes | Pseudonym | `pseudonym` |
| `-f` | `--cert-generation-qualifier` | yes | Generation qualifier | `generationQualifier` |