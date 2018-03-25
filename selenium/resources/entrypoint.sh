#!/bin/bash

cd /selenium-server-standalone/bin
exec java -Dwebdriver.chrome.driver=/chromedriver -jar selenium-server-standalone.jar