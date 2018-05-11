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

if ($method === 'GET') {
    echo file_get_contents("install.html");
}

if ($method === 'POST') {
    $myfile = fopen("/var/www/html/.setup-done", "w") or die("Unable to open file!");
    fclose($myfile);

    if (isset($_POST['install_yes'])) {
        setup();
        exit();
    }

    header('Location: /?t=0');
    exit();
}


function setup() {
    runCommand("/usr/bin/runas /usr/local/bin/composer -v install 2>&1 ");
    runCommand("/usr/bin/runas /usr/local/bin/sake dev/build 2>&1 ");
    runCommand("/usr/bin/runas /usr/local/bin/sake dev/tasks/Solr_Configure 2>&1 ");
    runCommand("/usr/bin/runas /usr/local/bin/sake dev/tasks/Solr_Reindex 2>&1 ");

    echo "<a href='/'>Open site</a>";
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
