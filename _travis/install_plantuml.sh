#!/bin/bash
set -e

wget --retry-connrefused --no-check-certificate http://ftp.stw-bonn.de/debian/pool/main/p/plantuml/plantuml_8039-1_all.deb
sudo dpkg -i plantuml_8039-1_all.deb
rm -rf plantuml_8039-1_all.deb
