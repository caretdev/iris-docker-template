#!/bin/bash

iris start $ISC_PACKAGE_INSTANCENAME quietly
 
cat << EOF | iris session $ISC_PACKAGE_INSTANCENAME -U %SYS
do ##class(%SYSTEM.Process).CurrentDirectory("$PWD")
new $namespace
$@
quit 
if '\$Get(sc, 1) do ##class(%SYSTEM.Process).Terminate(, 1)
do ##class(SYS.Container).QuiesceForBundling()
do ##class(Security.Users).Create("${USERNAME}", "%ALL", "${PASSWORD}")
halt
EOF

exit=$?

iris stop $ISC_PACKAGE_INSTANCENAME quietly

exit $exit