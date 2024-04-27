# nebula-docker

Docker image for nebula a scalable overlay networking tool with a focus on performance, simplicity and security.

---

![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/infinityofspace/nebula-docker/docker-publish-release.yml?style=flat-square) ![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/infinityofspace/nebula-docker/docker-publish-nightly.yml?style=flat-square)

---

### Table of contents:

1. [About](#about)
2. [Usage](#usage)
    1. [Prebuild image](#prebuild-image)
    2. [From source](#from-source)
    3. [Configuration](#configuration) 
3. [License](License)

## About

This project provides prebuild docker images for the architectures `amd64`, `arm64/v8`, `arm/v7` of nebula.
Moreover this project provides multiple bash scripts to support first setup and configuration of a nebula mesh network.
Nebula is a scalable overlay networking tool with a focus on performance, simplicity and security.
For more information about nebula check out the [original repository](https://github.com/slackhq/nebula).

## Usage

You can either use pre-built images or build them from source.

### Prebuild image

The following docker tags are supported:

- latest: matches latest version
- nightly: build every 3 days from the main source branches, might contain unstable features
- dev: build every change on dev branch, this version is not intended for any use except development

You can pull the image with the following command:

```commandline
docker pull ghcr.io/infinityofspace/nebula-docker:latest
```

### From source

To build the image from source use the following commands:

```commandline
git clone https://github.com/infinityofspace/nebula-docker.git
cd nebula-docker && docker build -t nebula-docker:latest .
```

### Configuration

The scripts directory contains multiple helper scripts to support the first setup of your nebula mesh network.
To use the scripts you have to download them first, to do this use the following command:

```commandline
git clone https://github.com/infinityofspace/nebula-docker.git && cd nebula-docker/scripts
```

In the scripts directory are 3 different scripts for different purposes.
The `setup.sh` script helps you generate a certificate authority and can optionally support the setup of node certificates and keys or config files.
The second script `setup_nodes.sh` helps with the generation of node certificates and keys.
Finally, the `generate_config.sh` script supports the generation of a basic config for the nodes of the network.

You can usage any script by executing the script and follow the instructions.

## License

[MIT](License) - Copyright (c) 2024 Marvin Heptner
