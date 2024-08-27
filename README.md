<p align="center">
  <img src="spaces-logo.png" alt="Project Logo" width="21%">
</p>

# Spaces for StartOS

[Spaces](https://nwc.dev/) allows for sustained interaction between Bitcoin lightning wallets and apps. Once an app connection is created, the app can request payments through a Spaces relay. This repository creates the `s9pk` package that is installed to run `Spaces` on [StartOS](https://github.com/Start9Labs/start-os/).

## Dependencies

Prior to building the `spaces` package, it's essential to configure your build environment for StartOS services. You can find instructions on how to set up the appropriate build environment in the [Developer Docs](https://docs.start9.com/latest/developer-docs/packaging).

- [docker](https://docs.docker.com/get-docker)
- [docker-buildx](https://docs.docker.com/buildx/working-with-buildx/)
- [deno](https://deno.land/)
- [make](https://www.gnu.org/software/make/)
- [start-sdk](https://github.com/Start9Labs/start-os/tree/sdk/core)
- [yq](https://mikefarah.gitbook.io/yq)

## Cloning

Clone the **Spaces** package repository locally.

```
git clone https://github.com/horologger/spaces-startos.git
cd spaces-startos
```

## Building

To build the **Spaces** service as a universal package, run the following command:

```
make
```

Alternatively the package can be built for individual architectures by specifying the architecture as follows:

```
# for amd64
make x86
```
or
```
# for arm64
make arm
```

## Installing (on StartOS)

Before installation, define `host: https://server-name.local` in your `~/.embassy/config.yaml` config file then run the following commands to determine successful install:

> :information_source: Change server-name.local to your Start9 server address

```
start-cli auth login
#Enter your StartOS password
make install
```

**Tip:** You can also install the `spaces.s9pk` by sideloading it under the **StartOS > System > Sideload a Service** section.

## Verify Install

Go to your StartOS Services page, select **Spaces** and start the service.

**Done!**