<?php

ini_set('output_buffering', 'off');
ini_set('zlib.output_compression',0);
set_time_limit(5);

header('Content-Type: text/html; charset=utf-8');
header('Cache-Control: no-cache');

//var_dump($_POST);
//var_dump($_REQUEST);
//var_dump($_SERVER);

//$url = $_REQUEST['url'];
$method = $_SERVER['REQUEST_METHOD'];

$root = '/var/www/html/';

if ($method === 'GET') {
//    if (file_exists($root . ".needs-setup")) {
        if (!file_exists($root . "framework")) {
            echo file_get_contents("composer.html");
        } else {
            echo file_get_contents("setup_database.html");
        }
//    } else {
//        echo file_get_contents("dashboard.html");
//    }
}

if ($method === 'POST') {
    $action = isset($_POST['action']) ? $_POST['action'] : '';

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
                runCommand("/usr/bin/runas /usr/local/bin/sspak load " . $path);
                runCommand("/usr/bin/runas /usr/local/bin/sake dev/build 2>&1 ");

                @unlink($root . ".needs-setup");
                echo "<a href='/'>Open site</a>";
                exit();
            } else {
                echo "There was an error uploading the file, please try again!";
                exit();
            }
        }
    } else if (isset($_POST['composer_install'])) {
        echo "Please wait...<br/>"; flush();

        runCommand("/usr/bin/runas /usr/local/bin/composer -v install 2>&1 ");
        echo "<a href='/_setup'>Setup database</a>";
        exit();
    } else if ($action === 'empty_db' || isset($_POST['setup_empty_db'])) {
        echo "Please wait...<br/>"; flush();

        deleteDb();
        runCommand("/usr/bin/runas /usr/local/bin/sake dev/build 2>&1 ");
        runCommand("/usr/bin/runas /usr/local/bin/sake dev/tasks/Solr_Configure 2>&1 ");
        runCommand("/usr/bin/runas /usr/local/bin/sake dev/tasks/Solr_Reindex 2>&1 ");
        echo "<a href='/'>Open site</a>";
        @unlink($root . ".needs-setup");
        exit();
    } else if ($action === 'use_existing_db' || isset($_POST['use_existing_db'])) {
        echo file_get_contents("rundevbuild.html");
        exit();
    } else if (isset($_POST['run_dev_build'])) {
        echo "Please wait...<br/>"; flush();

        runCommand("/usr/bin/runas /usr/local/bin/sake dev/build 2>&1 ");
        runCommand("/usr/bin/runas /usr/local/bin/sake dev/tasks/Solr_Configure 2>&1 ");
        echo "<a href='/'>Open site</a>";
        @unlink($root . ".needs-setup");
        exit();
    } else if (isset($_POST['finish'])) {
        @unlink($root . ".needs-setup");
        header('Location: /');
        exit();
    } else if ($action === "load_sspak") {
        echo file_get_contents("load_sspak.html");
        exit();
    }

    header('Location: /');
    exit();
}

function deleteDb() {
    $conn = new mysqli("db", "root", "root");

    $sql = "DROP DATABASE SS_cwp";
    $result = $conn->query($sql);
    $conn->close();
}

function runCommand($cmd) {
    $descriptorspec = array(
        0 => array("pipe", "r"),   // stdin is a pipe that the child will read from
        1 => array("pipe", "w"),   // stdout is a pipe that the child will write to
        2 => array("pipe", "w")    // stderr is a pipe that the child will write to
    );

    while (@ob_end_flush());
    ini_set('implicit_flush', true);
    ob_implicit_flush(true);

    $process = proc_open($cmd, $descriptorspec, $pipes, "/var/www/html");
    if (!is_resource($process)) {
        die ('Could not execute script');
    }

    echo "<script>";
    echo "var scrollInterval = setInterval(function() {";
    echo "document.body.scrollTop = document.body.scrollHeight;";
    echo "}, 500);";
    echo "</script>";

    echo "<pre>";
    if (is_resource($process)) {
        while(!feof($pipes[1])){
            echo fgets($pipes[1]);
            ob_flush();
            flush();
        }
    }
    echo "</pre>";

    proc_close($process);
}

ob_end_flush();
