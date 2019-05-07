<?php

function display($file) {
    $page = file_get_contents("index.html");
    $content = file_get_contents($file);
    echo str_replace("__CONTENT__", $content, $page);
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
