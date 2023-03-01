#!/bin/sh

# Copyright 2019-2020 Azul Systems, Inc.  All Rights Reserved.
# DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
#
# This code is free software; you can redistribute it and/or modify it under
# the terms of the GNU General Public License version 2 only, as published by
# the Free Software Foundation.
#
# This code is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE.  See the GNU General Public License version 2 for more
# details (a copy is included in the LICENSE file that accompanied this code).
#
# You should have received a copy of the GNU General Public License version 2
# along with this work; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
#
# Please contact Azul Systems, 385 Moffett Park Drive, Suite 115, Sunnyvale,
# CA 94089 USA or visit www.azul.com if you need additional information or
# have any questions.


##
## @test Test.sh
## @summary check work of multiple selectNow() + C/R peaceful coexistence
## @compile Test.java
## @run shell/timeout=120 Test.sh
##

set -x

set +e
${TESTJAVA}/bin/java -cp ${TESTCLASSPATH} -XX:CRaCCheckpointTo=cr Test 1
e=$?

set -e
[ $e -eq 137 ]

${TESTJAVA}/bin/java -XX:CRaCRestoreFrom=cr
echo "PASSED 1"


# check conformity (no C/R)

${TESTJAVA}/bin/java -cp ${TESTCLASSPATH} Test 2
echo "PASSED 2"

