<?php

define('SS_ENVIRONMENT_TYPE', 'dev');
define('SS_SEND_ALL_EMAILS_TO', 'null@null');

define('SS_DATABASE_SERVER', 'db');
define('SS_DATABASE_USERNAME','root');
define('SS_DATABASE_PASSWORD','root');

define('SS_DATABASE_NAME', 'SS_cwp');

define('SS_DEFAULT_ADMIN_USERNAME','root');
define('SS_DEFAULT_ADMIN_PASSWORD','root');

define('SOLR_SERVER', 'search');
define('SOLR_INDEXSTORE_PATH', '/index/data');

global $_FILE_TO_URL_MAPPING;
$_FILE_TO_URL_MAPPING['/var/www/html'] = 'http://localhost';
