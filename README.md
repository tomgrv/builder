<!-- @format -->

# Builder/Runner for CI systems

[![StyleI](https://github.styleci.io/repos/143454979/shield?style=flat&branch=master)](https://github.styleci.io/repos/143454979) [![Docker](https://badgen.net/docker/pulls/tomgrv/ci-builder?icon=docker)](https://hub.docker.com/repository/docker/tomgrv/ci-builder) [![Licence](https://badgen.net/github/license/tomgrv/ci-builder)]()

[![Commitizen friendly](https://img.shields.io/badge/commitizen-friendly-brightgreen.svg)](http://commitizen.github.io/cz-cli/) [![semantic-release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg)](https://github.com/semantic-release/semantic-release)

[![Buy me a coffee](https://badgen.net/badge/buymeacoffe/tomgrv/yellow?icon=buymeacoffee)](https://buymeacoffee.com/tomgrv)

## Docker image

Alpine 3.8 image with :

-   php 7 available as `php`
-   dotnet core 2.1 available as `dotnet`

Available development tools:

-   [Composer Package Manager](https://getcomposer.org/) available as `composer`
-   [GitTools/GitVersion](https://github.com/GitTools/GitVersion) available as `dotnet-gitversion` (latest)
-   [squizlabs/PHP_CodeSniffer](https://github.com/squizlabs/PHP_CodeSniffer) available as `phpcs`
-   [Node Package Manager](https://www.npmjs.com) available as `npm`

## CI Configuration files

Corresponding config files are provided in folders

### Gitlab / Laravel

Deployment is handled with [lorisleiva/laravel-deployer](https://github.com/lorisleiva/laravel-deployer) package.

Some variables to set in Gitlab CI variable folder:

-   `SSH_PRIVATE_KEY` to access target servers. You need to set corresponding public key on all your servers.
-   `HOSTNAME_SERVER_BETA` to deploy `develop` branch automaticaly
-   `HOSTNAME_SERVER_STAGING` to deploy `master` branch automaticaly
-   `HOSTNAME_SERVER_PRODUCTION` to deploy `master` branch **on demand**

### Gitlab / Node

Publishing is handled with [release-it](https://www.npmjs.com/package/release-it) package
File can be referenced within every gitlab project:

```yaml
include:
    - project: 'tomgrv/ci-builder'
      ref: master
      file: '/templates/node/.gitlab-ci.yml'
```

`Package.json` is parsed for `GitVersion_*` variable replacement before each job:

```js
{
  "name": "package-name",
  "version": "${GitVersion_SemVer}",
  "description": "This is package Description for version ${GitVersion_InformationalVersion}",
  "main": "src/index.js",
  ...
}
```

Some variables to set in Gitlab CI variable folder:

-   `NPM_TOKEN` to package & publish `master` branch on https://npmjs.com
-   `GITHUB_TOKEN` to package & publish `master` branch on https://github.com automaticaly
-   `GITLAB_TOKEN` to package & publish `master` branch on https://gitlab.com automaticaly
