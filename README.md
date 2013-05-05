This is an iOS port of the Ruby-based [HealthDataStandards project](https://github.com/projectcypress/health-data-standards), which is designed to generate and consume HITSP C32, CCDA, ASTM CCR, QRDA Category I and PQRI.
Currently, this port is targeted just for importing CCDA documents and modeling patient records.

Environment
===========

This project has been built with Xcode Version 4.6.2 (4H1003). The test suite is written using OCUnit and can be executed with cmd+u.

XML parsing is enabled by Google's GDataXMLNode, which is built on top of libxml2.
GDataXmlNode.m and GDataXmlNode.h are available in the Source/XMLSupport directory of the [gdata-objective-c project](https://code.google.com/p/gdata-objectivec-client/).

License
=======

Copyright 2013 The MITRE Corporation.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
