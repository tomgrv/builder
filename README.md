# ci-builder

## Docker image

Alpine 3.8 image with :

- php 7 available as `php`
- dotnet core 2.2 available as `dotnet`

Available development tools:

- [Composer Package Manager](https://getcomposer.org/) available as `composer`
- [GitTools/GitVersion](https://github.com/GitTools/GitVersion) available as `dotnet-gitversion` (latest)
- [squizlabs/PHP_CodeSniffer](https://github.com/squizlabs/PHP_CodeSniffer) available as `phpcs`
- [Node Package Manager](https://www.npmjs.com) available as `npm`

## CI Configuration files

Corresponding config files are provided in folders

### Gitlab / Laravel

Deployment is handled with [lorisleiva/laravel-deployer](https://github.com/lorisleiva/laravel-deployer) package

Some variables to set in Gitlab CI variable folder:

- `SSH_PRIVATE_KEY` to access target servers. You need to set corresponding public key on all your servers.
- `HOSTNAME_SERVER_BETA` to deploy `develop` branch automaticaly
- `HOSTNAME_SERVER_STAGING` to deploy `master` branch automaticaly
- `HOSTNAME_SERVER_PRODUCTION` to deploy `master` branch **on demand**

### Gitlab / Node

Publishing is handled with [release-it](https://www.npmjs.com/package/release-it) package

File can be referenced within every gitlab project:

```yaml
include:
  - project: "tomgrv/ci-builder"
    ref: master
    file: "/tempaltes/node/.gitlab-ci.yml"
```

`Package.json` is parsed for `GitVersion_*` variable replacement before each job:

```json
{
  "name": "package-name",
  "version": "${GitVersion_SemVer}",
  "description": "This is package Description for version ${GitVersion_InformationalVersion}",
  "main": "src/index.js",
  ...
}
```

Some variables to set in Gitlab CI variable folder:

- `NPM_TOKEN` to package & publish `master` branch on https://npmjs.com
- `GITHUB_TOKEN` to package & publish `master` branch on https://github.com automaticaly
- `GITLAB_TOKEN` to package & publish `master` branch on https://gitlab.com automaticaly
