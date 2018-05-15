# How to use this image.

This image - together with a `docker-compose.yml` and a `behat-docker.yml` file provides you with the complete infrastructure to run a Silverstripe CWP website. It contains the webserver, database server as well as 
the following;
- solr server, to provide a fulltext-search option
- selenium server, for running the behat tests
- mailcatcher, to display all mail send by the application

## Getting started

1. clone a Silverstripe project
2. add the example `docker-compose.yml` and the `behat-docker.yml` to your project (see `examples` directory)
3. run `docker-compose up`
4. browse to `localhost:8000` and finish the setup (note: you can always go back to `localhost:8000/_setup` to reset the database)

### Running behat tests

1. open a VNC session to `localhost:5900`
2. start `docker-compose exec web behat @mysite`


## Environment Info

This image comes pre-packaged with the default php extensions and configurations found on [SilverStripe Platform](https://platform.silverstripe.com). It also includes some tooling pre-installed for ease-of-use.

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

Add the example `docker-compose.yml` file to your project and run `docker-compose up`. Then open a browser session at  `localhost:8000`, and you will be guided through the initial setup.

The following scripts are available in this image;
- behat (`docker-compose exec web behat @mysite`). Open a VNC-session at :5900 to look at the browser executing the tests.
- sspak (`docker-compose exec web sspak load <filename>`)
- sake (`docker-compose exec web sake dev/build`)
- shell (`docker-compose exec web shell`)

NOTE: A default `_ss_environment.php` file has been provided that expects a database server with the specific hostname `db`. CMS Admin username and password is set to root/root. All emails sent out by the application are caught by mailctacher. Browse to `localhost:1080` to see those emails.

# License

View [license information](http://php.net/license/) for the software contained in this image.

# Supported Docker versions

This image is officially supported on Docker version 18.03.1-ce.

Support is provided on a best-effort basis.

Please see [the Docker installation documentation](https://docs.docker.com/installation/) for details on how to upgrade your Docker daemon.

# User Feedback

## Issues

If you have any problems or questions about this image, please contact us through a [GitHub issue](https://github.com/govtnz/silverstripe-php/issues). 

## Contributing

You are invited to contribute new features, fixes, or updates, large or small; we are always thrilled to receive pull requests, and do our best to process them as fast as we can.

Before you start to code, we recommend discussing your plans through a [GitHub issue](https://github.com/govtnz/silverstripe-php/issues), especially for more ambitious contributions. This gives other contributors a chance to point you in the right direction, give you feedback on your design, and help you find out if someone else is working on the same thing.

# Credits
Based on the work of `brettt89`
