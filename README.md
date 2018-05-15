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
- [chrome](https://github.com/SeleniumHQ/docker-selenium)

## Running with Docker-Compose

Add the example `docker-compose.yml` file to your project and run `docker-compose up`. If you open a browser session to `localhost:8000`, you will guided through the initial setup.

The following scripts are available in this image;
- behat (`docker-compose exec web behat @mysite`). Open a VNC-session at :5900 to look at the browser executing the tests.
- sspak (`docker-compose exec web sspak load <filename>`)
- sake (`docker-compose exec web sake dev/build`)
- shell (`docker-compose exec web shell`)

NOTE: A default `_ss_environment.php` file has been provided that expects a database server with the specific hostname `db`. CMS Admin username and password is set to root/root. All emails send out by the application are caught by mailctacher. Browse to `localhost:1080` to see those emails.

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
