#!/bin/bash

iris start $ISC_PACKAGE_INSTANCENAME quietly
 
/bin/echo -e "" \
  "do \$system.Process.CurrentDirectory(\"$PWD\")\n" \
  "$@\n" \
  "if '\$Get(sc) do \$System.Process.Terminate(, 1)" \
  "do ##class(SYS.Container).QuiesceForBundling()\n" \
  "do ##class(SYS.Container).SetMonitorStateOK(\"irisowner\")\n" \
  "halt" \
| iris session $ISC_PACKAGE_INSTANCENAME -U %SYS
exit=$?

iris stop $ISC_PACKAGE_INSTANCENAME quietly

exit $exit