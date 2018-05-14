# How to use this image.

## Requirements

- [*Docker*](https://docs.docker.com/)
- [*Docker Compose*](https://docs.docker.com/compose/overview/)

## Builds

### Versions

There hasn't been released a specific version yet.

## Environment Info

This image comes pre-packaged with a the default php extensions and configurations found on [SilverStripe Platform](https://platform.silverstripe.com). It also comes with some tooling pre-installed for ease-of-use.

### Build Tools

- [xdebug](https://xdebug.org/)
- [sspak](https://github.com/silverstripe/sspak)
- [composer](https://getcomposer.org/)
- [npm](https://www.npmjs.com/)
- [compass](http://compass-style.org/)
- [wkhtmltopdf](https://wkhtmltopdf.org/)
- [gosu](https://github.com/tianon/gosu)
- [behat](http://behat.org/)
- [sake](https://docs.silverstripe.org/en/4/developer_guides/cli/)

## Running with Docker-Compose

Add the example `docker-compose.yml` file to your project and run `docker-compose up`. If you open a browser session to `localhost:8000`, you will guided through the initial setup.

The following scripts are available in this image;
- behat (`docker-compose exec web behat @mysite`)
- sspak (`docker-compose exec web sspak load <filename>`)
- sake (`docker-compose exec web sake dev/build`)
- shell (`docker-compose exec web shell`)

This image can also be run directly with docker. However it will need to be linked with a database in order for SilverStripe to successfully build.

```bash
docker run -p 3306:3306 --name db mysql
docker run -p 80:80 -v /path/to/project:/var/www/html --link db --name project1 govtnz/silverstripe-web-container:1.0
```

NOTE: A default `_ss_environment.php` file has been provided that expects a database server with the specific hostname `db`


# License

View [license information](http://php.net/license/) for the software contained in this image.

# Supported Docker versions

This image is officially supported on Docker version 18.03.1-ce.

Support is provided on a best-effort basis.

Please see [the Docker installation documentation](https://docs.docker.com/installation/) for details on how to upgrade your Docker daemon.

# User Feedback

## Issues

If you have any problems with or questions about this image, please contact us through a [GitHub issue](https://github.com/govtnz/silverstripe-php/issues). 

## Contributing

You are invited to contribute new features, fixes, or updates, large or small; we are always thrilled to receive pull requests, and do our best to process them as fast as we can.

Before you start to code, we recommend discussing your plans through a [GitHub issue](https://github.com/govtnz/silverstripe-php/issues), especially for more ambitious contributions. This gives other contributors a chance to point you in the right direction, give you feedback on your design, and help you find out if someone else is working on the same thing.

# Credits

 - Brett Tasker       - [https://github.com/brettt89](https://github.com/brettt89)
 - Franco Springveldt - [https://github.com/fspringveldt](https://github.com/fspringveldt)
