#!/bin/bash

raml2html -i $(pwd)/nsxvapiv614.raml -o $(pwd)/html-version/nsxvapiv614.html
raml2md -i $(pwd)/nsxvapiv614.raml -o $(pwd)/md-version/nsxvapiv614.md
raml2postman -s $(pwd)/nsxvapiv614.raml -o $(pwd)/postman-collection/nsxvapiv614.json -g