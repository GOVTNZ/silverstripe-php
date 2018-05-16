<?php

//error_reporting(E_ALL);
//ini_set('display_errors', 1);

require_once '_functions.php';

define("ROOT", "/var/www/html/");

ini_set('output_buffering', 'off');
ini_set('zlib.output_compression',0);
set_time_limit(5);

header('Content-Type: text/html; charset=utf-8');
header('Cache-Control: no-cache');

$method = $_SERVER['REQUEST_METHOD'];

if ($method === 'GET') {
    if (!file_exists(ROOT . "framework")) {
        display("composer.html");
    } else {
        display("setup_database.html");
    }
} else if ($method === 'POST') {
    $action = isset($_POST['action']) ? $_POST['action'] : '';

    if (!empty($action)) {
        if ($action === 'upload') {
            if(! empty($_FILES['uploaded_file'])) {
                echo "Please wait...<br/>"; flush();

                $path = "/tmp/";
                $path = $path . basename( $_FILES['uploaded_file']['name']);

                $tmpName = $_FILES['uploaded_file']['tmp_name'];

                $result = true;
                if (!is_uploaded_file($path)) {
                    rename($tmpName, $path);
                } else {
                    $result = move_uploaded_file($tmpName, $path);
                }

                if($result) {
                    runCommand("/usr/local/bin/sspak load " . $path);
                    runCommand("/usr/local/bin/sake dev/build 2>&1 ");

                    @unlink(ROOT . "assets/.needs-setup");
                    echo "<a href='/'>Open site</a>";
                    exit();
                } else {
                    echo "There was an error uploading the file, please try again!";
                    exit();
                }
            }

        } else if ($action === 'empty_db') {
            echo "Please wait...<br/>"; flush();

            deleteDb();
            runCommand("/usr/local/bin/sake dev/build 2>&1 ");
            runCommand("/usr/local/bin/sake dev/tasks/Solr_Configure 2>&1 ");
            runCommand("/usr/local/bin/sake dev/tasks/Solr_Reindex 2>&1 ");
            echo "<a href='/'>Open site</a>";
            @unlink(ROOT . "assets/.needs-setup");
            exit();

        } else if ($action === 'use_existing_db') {
            display("rundevbuild.html");
            exit();
        } else if ($action === "load_sspak") {
            display("load_sspak.html");
            exit();
        }

    } else {

        if (isset($_POST['composer_install'])) {
            echo "Please wait...<br/>"; flush();

            runCommand("/usr/bin/runas /usr/local/bin/composer -v install 2>&1 ");
            echo "<a href='/_setup'>Setup database</a>";
            exit();

        } else if (isset($_POST['run_dev_build'])) {
            echo "Please wait...<br/>"; flush();

            runCommand("/usr/local/bin/sake dev/build 2>&1 ");
            runCommand("/usr/local/bin/sake dev/tasks/Solr_Configure 2>&1 ");
            echo "<a href='/'>Open site</a>";
            @unlink(ROOT . "assets/.needs-setup");
            exit();

        } else if (isset($_POST['finish'])) {

            @unlink(ROOT . "assets/.needs-setup");
            header('Location: /');
            exit();

        }
    }

    header('Location: /');
    exit();
}

ob_end_flush();
