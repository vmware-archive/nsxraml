#!/bin/bash

#
# Copyright © 2015-2016 VMware, Inc. All Rights Reserved.
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
# Generate dynamic HTML docs with raml2html
#
raml2html -i $(pwd)/nsxvapi.raml -o $(pwd)/html-version/nsxvapi.html
#
# Generate staic HTML docs with raml-fleece
#
raml-fleece $(pwd)/nsxvapi.raml --template-index $(pwd)/templates/raml-fleece/index.handlebars --template-resource $(pwd)/templates/raml-fleece/resource.handlebars --template-main $(pwd)/templates/raml-fleece/main.handlebars --style $(pwd)/templates/raml-fleece/style.less > $(pwd)/html-version/nsxvapi-static.html
#
# Generate MD docs
#
raml2md -i $(pwd)/nsxvapi.raml -o $(pwd)/md-version/nsxvapi.md
#
# Generate Postman collections
#
raml2postman -s $(pwd)/nsxvapi.raml -o $(pwd)/postman-collection/nsxvapi.json -g

