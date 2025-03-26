import { setupManifest } from '@start9labs/start-sdk'

export const manifest = setupManifest({
  id: 'spaces',
  title: 'Spaces',
  license: 'apache',
  wrapperRepo: 'https://github.com/horologger/spaces-startos',
  upstreamRepo: 'https://github.com/horologger/spaces',
  supportSite: 'https://github.com/horologger/spaces/issues',
  marketingSite: 'https://github.com/horologger/spaces',
  donationUrl: null,
  description: {
    short: 'Scalable & Permissionless Bitcoin Identities',
    long: 'Spaces empowers users with a sovereign Bitcoin identity, anchored securely on the Bitcoin blockchain.',
  },
  volumes: ['main'],
  images: { btcshell: { source: { dockerTag: 'horologger/spaces:v0.0.7' } } },
  hardwareRequirements: {},
  alerts: {
    install: null,
    update: null,
    uninstall: null,
    restore: null,
    start: null,
    stop: null,
  },
  dependencies: {
    bitcoind: {
      description: 'Spaces uses Bitcoin for all its needs',
      optional: false,
      s9pk: '../bitcoind-startos/bitcoind.s9pk', // @TODO
    },
  },
})
