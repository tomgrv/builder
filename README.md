# ci-builder

## Docker image

Alpine 3.8 image with :

- php 7 available as `php`
- dotnet core 2.2 available as `dotnet`

Available development tools:

- [Composer Package Manager](https://getcomposer.org/) available as `composer`
- [GitTools/GitVersion](https://github.com/GitTools/GitVersion) available as `gv` (5.0.2-beta1.71)
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
