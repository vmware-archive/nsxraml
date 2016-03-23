#!/bin/bash

#
# Copyright © 2015 VMware, Inc. All Rights Reserved.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy 
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights 
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell 
# copies of the Software, and to permit persons to whom the Software is 
# furnished to do so, subject to the following conditions: The above copyright 
# notice and this permission notice shall be included in all copies or 
# substantial portions of the Software.  
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING 
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS 
# IN THE SOFTWARE.
#
# Generate HTML and MD docs and Postman collection for NSX 6.1.4
#
raml2html -i $(pwd)/nsxvapiv614.raml -o $(pwd)/html-version/nsxvapiv614.html
raml2md -i $(pwd)/nsxvapiv614.raml -o $(pwd)/md-version/nsxvapiv614.md
raml2postman -s $(pwd)/nsxvapiv614.raml -o $(pwd)/postman-collection/nsxvapiv614.json -g
#
# Generate HTML and MD docs and Postman collection for NSX 6.1.6
#
raml2html -i $(pwd)/nsxvapiv616.raml -o $(pwd)/html-version/nsxvapiv616.html
raml2md -i $(pwd)/nsxvapiv616.raml -o $(pwd)/md-version/nsxvapiv616.md
raml2postman -s $(pwd)/nsxvapiv616.raml -o $(pwd)/postman-collection/nsxvapiv616.json -g
#
# Generate HTML and MD docs and Postman collection for NSX 6.2.2
#
raml2html -i $(pwd)/nsxvapiv622.raml -o $(pwd)/html-version/nsxvapiv622.html
raml2md -i $(pwd)/nsxvapiv622.raml -o $(pwd)/md-version/nsxvapiv622.md
raml2postman -s $(pwd)/nsxvapiv622.raml -o $(pwd)/postman-collection/nsxvapiv622.json -g
