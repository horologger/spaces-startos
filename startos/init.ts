import { sdk } from './sdk'
import { exposedStore } from './store'
import { setDependencies } from './dependencies'
import { setInterfaces } from './interfaces'
import { versions } from './versions'
import { actions } from './actions'
import { utils } from '@start9labs/start-sdk'
import { generateRpcUserDependent } from 'bitcoind-startos/startos/actions/generateRpcUserDependent'
import { resetPassword } from './actions/resetPassword'
import { randomPassword } from './utils'

// **** Install ****
const install = sdk.setupInstall(async ({ effects }) => {
  const btcUsername = `spaces_${utils.getDefaultString({ charset: 'a-z,A-Z', len: 8 })}`
  const btcPassword = utils.getDefaultString(randomPassword())

  await sdk.action.requestOwn(effects, resetPassword, 'critical', {
    reason: 'Needed to obtain Spaces UI password',
  })

  await sdk.action.request(
    effects,
    'bitcoind',
    generateRpcUserDependent,
    'critical',
    {
      input: {
        kind: 'partial',
        value: {
          username: btcUsername,
          password: btcPassword,
        },
      },
      reason: 'Spaces needs an RPC user in Bitcoin',
    },
  )

  await sdk.store.setOwn(effects, sdk.StorePath, {
    password: null,
    btcAuth: {
      username: btcUsername,
      password: btcPassword,
    },
  })
})

// **** Uninstall ****
const uninstall = sdk.setupUninstall(async ({ effects }) => {})

/**
 * Plumbing. DO NOT EDIT.
 */
export const { packageInit, packageUninit, containerInit } = sdk.setupInit(
  versions,
  install,
  uninstall,
  setInterfaces,
  setDependencies,
  actions,
  exposedStore,
)
