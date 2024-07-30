## Puppet CI container image

## Tools
- puppet
- puppet-lint
- librarian-puppet
- onceover
- r10k


## Bundled scripts

### build-puppetfile.sh

Builds `Puppetfile` from `Puppetfile.in` resolving exact dependency versions including any subdependencies. Essentially produces a dependency lock file.

<details>
  <summary>Example</summary>

The following `Puppetfile.in`
```
forge "https://forge.puppet.com"

mod 'puppet-firewalld'
mod 'puppetlabs-augeas_core'
mod 'puppetlabs-apt'
mod 'puppetlabs-git'
mod 'puppetlabs-java'
mod 'puppetlabs-lvm'
mod 'puppetlabs-mysql'
mod 'puppetlabs-ntp'
mod 'puppetlabs-postgresql'
mod 'puppetlabs-stdlib'
mod 'puppetlabs-vcsrepo'
mod 'puppetlabs-sshkeys_core'
mod 'puppetlabs-mount_core'
mod 'puppetlabs-docker'
mod 'puppet-nginx'
mod 'puppet-postfix'
mod 'puppet-selinux'
mod 'puppet-systemd'
mod 'puppet-tuned'
mod 'thias-bind'
mod 'thias-sysctl'
mod 'puppet-augeasproviders_pam'
```

would result in the following `Puppetfile`
```
# This file was auto-generated from Puppetfile.in.
# See build-puppetfile.sh for more info.

forge "https://forge.puppet.com"

mod 'puppet-alternatives', '5.1.0'
mod 'puppet-archive', '7.1.0'
mod 'puppet-augeasproviders_core', '4.1.0'
mod 'puppet-augeasproviders_pam', '4.0.0'
mod 'puppet-firewalld', '5.0.0'
mod 'puppet-nginx', '6.0.0'
mod 'puppet-postfix', '4.4.0'
mod 'puppet-selinux', '4.1.0'
mod 'puppet-systemd', '7.1.0'
mod 'puppet-tuned', '1.0.0'
mod 'puppetlabs-apt', '9.4.0'
mod 'puppetlabs-augeas_core', '1.5.0'
mod 'puppetlabs-concat', '9.0.2'
mod 'puppetlabs-docker', '10.0.1'
mod 'puppetlabs-git', '0.5.0'
mod 'puppetlabs-inifile', '6.1.1'
mod 'puppetlabs-java', '11.0.0'
mod 'puppetlabs-lvm', '2.3.0'
mod 'puppetlabs-mailalias_core', '1.2.0'
mod 'puppetlabs-mount_core', '1.3.0'
mod 'puppetlabs-mysql', '16.0.0'
mod 'puppetlabs-ntp', '10.1.0'
mod 'puppetlabs-postgresql', '10.3.0'
mod 'puppetlabs-powershell', '6.0.0'
mod 'puppetlabs-pwshlib', '1.1.1'
mod 'puppetlabs-reboot', '5.0.0'
mod 'puppetlabs-sshkeys_core', '2.5.0'
mod 'puppetlabs-stdlib', '9.6.0'
mod 'puppetlabs-vcsrepo', '6.1.0'
mod 'thias-bind', '0.5.6'
mod 'thias-sysctl', '1.0.7'
```
</details>

## Developing

See [DEVELOPING.md](DEVELOPING.md) for local development setup instructions.
