Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2702F43BDAE
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Oct 2021 01:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235379AbhJZXRj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Oct 2021 19:17:39 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43286 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231948AbhJZXRj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Oct 2021 19:17:39 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 19QJVEtU012841
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Oct 2021 16:15:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=H6nCISt/0Zf542H6brfZVpxyKuxza9qke+HmWG4TDa4=;
 b=gHE+Q8VdnBIBd6dJCZk/MeW0Slk16nECqugzpq1Gq2ATW42PtISb4kOBkjfp5WHPYepe
 LG+hYIURjMzwvSvQyaRBirkURYfdVlvz2DCiWNDqJBXWqjsoLneUBH0tprw57410hgn8
 7QK3A/wp0agQgJujlH+2DQDLC7FAnOXtpoE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3bxqwd19gm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Oct 2021 16:15:14 -0700
Received: from intmgw006.03.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 26 Oct 2021 16:15:12 -0700
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
        id 92A3C59A1025; Tue, 26 Oct 2021 16:15:10 -0700 (PDT)
From:   Stefan Roesch <shr@fb.com>
To:     <fstests@vger.kernel.org>, <linux-btrfs@vger.kernel.org>,
        <kernel-team@fb.com>
CC:     <shr@fb.com>
Subject: [PATCH v2] btrfs: Add new test for setting the stripe size.
Date:   Tue, 26 Oct 2021 16:15:08 -0700
Message-ID: <20211026231508.2282042-1-shr@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: m-Kqa-zddoFFIeL86ykUCu0HMRKsvk_O
X-Proofpoint-ORIG-GUID: m-Kqa-zddoFFIeL86ykUCu0HMRKsvk_O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-26_07,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015 mlxscore=0
 phishscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2110260127
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Summary:

Add new testcase for testing the new btrfs sysfs knob to change the
stripe size. The new knob uses /sys/fs/btrfs/<UUID>/allocation/<block
type>/stripe_size.

The test case implements three different cases:
- Test allocation with the default stripe size
- Test allocation after increasing the stripe size
- Test allocation when the free space is smaller than the stripe size.

Note: this test needs to force the allocation of space. It uses the
/sys/fs/btrfs/<UUID>/allocation/<block type>/force_chunk_alloc knob.

Testing:
The test has been run with volumes of different sizes.

Signed-off-by: Stefan Roesch <shr@fb.com>
---
V2: - added new functions to common/btrfs and use them in the new test
      - _require_btrfs_sysfs_attr - Make sure btrfs supports a sysfs
        setting
      - _get_btrfs_sysfs_attr - Read sysfs value
      - _set_btrfs_sysfs_attr - Write sysfs value
    - create file system of required size with _scratch_mkfs_sized
    - use shortened error message
    - Remove last logging message
---
 common/btrfs        |  69 ++++++++++
 tests/btrfs/248     | 302 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/248.out |  10 ++
 3 files changed, 381 insertions(+)
 create mode 100755 tests/btrfs/248
 create mode 100644 tests/btrfs/248.out

diff --git a/common/btrfs b/common/btrfs
index ac880bdd..5f19a0b0 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -445,3 +445,72 @@ _scratch_btrfs_is_zoned()
 	[ `_zone_type ${SCRATCH_DEV}` !=3D "none" ] && return 0
 	return 1
 }
+
+# Print the content of /sys/fs/btrfs/$UUID/$ATTR
+#
+# All arguments are necessary, and in this order:
+#  - mnt: mount point name, e.g. $SCRATCH_MNT
+#  - attr: path name under /sys/fs/btrfs/$uuid/$attr
+#
+# Usage example:
+#   _get_btrfs_sysfs_attr /mnt/scratch allocation/data/stripe_size
+_get_btrfs_sysfs_attr()
+{
+	local mnt=3D$1
+	local attr=3D$2
+
+	if [ ! -e "$mnt" -o -z "$attr" ];then
+		_fail "Usage: _get_btrfs_sysfs_attr <mounted_directory> <attr>"
+	fi
+
+	local uuid=3D$(findmnt -n -o UUID ${mnt})
+	cat /sys/fs/btrfs/${uuid}/${attr}
+}
+
+# Write "content" into /sys/fs/btrfs/$UUID/$ATTR
+#
+# All arguments are necessary, and in this order:
+#  - mnt: mount point name, e.g. $SCRATCH_MNT
+#  - attr: path name under /sys/fs/btrfs/$uuid/$attr
+#  - content: the content of $attr
+#
+# Usage example:
+#   _set_btrfs_sysfs_attr /mnt/scratch allocation/data/stripe_size
+_set_btrfs_sysfs_attr()
+{
+	local mnt=3D$1
+	shift
+	local attr=3D$1
+	shift
+	local content=3D"$*"
+
+	if [ ! -e "$mnt" -o -z "$attr" -o -z "$content" ];then
+		_fail "Usage: _set_btrfs_sysfs_attr <mounted_directory> <attr> <conten=
t>"
+	fi
+
+	local uuid=3D$(findmnt -n -o UUID ${mnt})
+	echo "$content" > /sys/fs/btrfs/${uuid}/${attr}
+}
+
+# Verify if the sysfs entry in /sys/fs/btrfs/$UUID/$ATTR exists
+#
+# All arguments are necessary, and in this order:
+#  - mnt: mount point name, e.g. $SCRATCH_MNT
+#  - attr: path name under /sys/fs/btrfs/$uuid/$attr
+#
+# Usage example:
+#   _require_btrfs_sysfs_attr /mnt/scratch allocation/data/stripe_size
+_require_btrfs_sysfs_attr()
+{
+	local mnt=3D$1
+	local attr=3D$2
+
+	if [ ! -e "$mnt" -o -z "$attr" ];then
+		_fail "Usage: _get_btrfs_sysfs_attr <mounted_directory> <attr>"
+	fi
+
+	local uuid=3D$(findmnt -n -o UUID ${mnt})
+	if [[ ! -e  /sys/fs/btrfs/${uuid}/${attr} ]]; then
+			_notrun "Btrfs does not support sysfs $attr"
+	fi
+}
diff --git a/tests/btrfs/248 b/tests/btrfs/248
new file mode 100755
index 00000000..02438e02
--- /dev/null
+++ b/tests/btrfs/248
@@ -0,0 +1,302 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 Facebook.  All Rights Reserved.
+#
+# FS QA Test 250
+#
+# Test the new /sys/fs/btrfs/<uuid>/allocation/<block-type>/stripe_size
+# setting. This setting allows the admin to change the stripe size
+# setting for the next allocation.
+#
+# Test 1:
+#   Allocate storage for all three block types (data, metadata and syste=
m)
+#   with the default stripe size.
+#
+# Test 2:
+#   Set a new stripe size to double the default size and allocate space
+#   for all new block types with the new stripe size.
+#
+# Test 3:
+#   Pick an allocation size that is used in a loop and make sure the las=
t
+#   allocation cannot be partially fullfilled.
+#
+# Note: Variable naming uses the following convention: if a variable nam=
e
+#       ends in "_B" then its a byte value, if it ends in "_MB" then the
+#       value is in megabytes.
+#
+. ./common/preamble
+_begin_fstest auto
+
+test_file=3D"${TEST_DIR}/${seq}"
+seq=3D`basename $0`
+seqres=3D"${RESULT_DIR}/${seq}"
+
+# Override the default cleanup function.
+_cleanup()
+{
+	cd /
+	rm -f "$test_file"
+}
+
+# Parse a size string which is in the format "XX.XXMib".
+#
+# Parameters:
+#   - (IN)    Block group type (Data, Metadata, System)
+#   - (INOUT) Variable to store block group size in MB
+#
+_parse_size_string() {
+	local SIZE=3D$(echo "$1" | awk 'match($0, /([0-9.]+)/) { print substr($=
0, RSTART, RLENGTH) }')
+        eval $2=3D"${SIZE%.*}"
+}
+
+# Determine the size of the device in MB.
+#
+# Parameters:
+#   - (INOUT) Variable to store device size in MB
+#
+_device_size() {
+	btrfs fi show ${SCRATCH_MNT} --mbytes | grep devid >> $seqres.full
+	local SIZE=3D$(btrfs fi show ${SCRATCH_MNT} --mbytes | grep devid)
+	_parse_size_string $(echo "${SIZE}" | awk '{print $4}') SIZE_ALLOC
+	eval $1=3D${SIZE_ALLOC%.*}
+}
+
+# Determine the free space of a block group in MB.
+#
+# Parameters:
+#   - (INOUT) Variable to store free space in MB
+#
+_free_space() {
+	local SIZE=3D$(btrfs fi show ${SCRATCH_MNT} --mbytes | grep devid)
+	_parse_size_string $(echo "${SIZE}" | awk '{print $4}') SIZE_ALLOC
+	_parse_size_string $(echo "${SIZE}" | awk '{print $6}') SIZE_USED
+	eval $1=3D$(expr ${SIZE_ALLOC} - ${SIZE_USED})
+}
+
+# Determine how much space in MB has been allocated to a block group.
+#
+# Parameters:
+#   - (IN)    Block group type (Data, Metadata, System)
+#   - (INOUT) Variable to store block group size in MB
+#
+_alloc_size() {
+	local SIZE_STRING=3D$(btrfs filesystem df ${SCRATCH_MNT} -m | grep  "$1=
" | awk '{print $3}')
+	_parse_size_string ${SIZE_STRING} BLOCK_GROUP_SIZE
+        eval $2=3D"${BLOCK_GROUP_SIZE}"
+}
+
+. ./common/filter
+_supported_fs btrfs
+_require_test
+_require_scratch
+_require_btrfs_fs_sysfs
+
+# Delete log file if it exists.
+rm -f "${seqres}.full"
+
+# Make filesystem.
+_require_scratch_size $((10 * 1024 * 1024)) #kB
+_scratch_mkfs_sized $((10 * 1024 * 1024 * 1024)) >> $seqres.full 2>&1
+_scratch_mount >> $seqres.full 2>&1
+
+# Get UUID of device.
+UUID=3D"$(findmnt -n -o UUID ${SCRATCH_MNT})"
+echo "UUID =3D ${UUID}" >> ${seqres}.full
+
+# Check if there is sufficient sysfs support.
+_require_btrfs_sysfs_attr ${SCRATCH_MNT} allocation/metadata/stripe_size
+_require_btrfs_sysfs_attr ${SCRATCH_MNT} allocation/metadata/force_chunk=
_alloc
+
+# Get free space.
+_free_space  FREE_SPACE_MB
+_device_size DEVICE_SIZE_MB
+
+echo "free space =3D ${FREE_SPACE_MB}" >> ${seqres}.full
+
+# Get stripe sizes.
+echo "Capture default stripe sizes."
+FIRST_DATA_STRIPE_SIZE_B=3D$(_get_btrfs_sysfs_attr ${SCRATCH_MNT} alloca=
tion/data/stripe_size)
+FIRST_METADATA_STRIPE_SIZE_B=3D$(_get_btrfs_sysfs_attr ${SCRATCH_MNT} al=
location/metadata/stripe_size)
+FIRST_SYSTEM_STRIPE_SIZE_B=3D$(_get_btrfs_sysfs_attr ${SCRATCH_MNT} allo=
cation/system/stripe_size)
+
+echo "Data stripe size    =3D ${FIRST_DATA_STRIPE_SIZE_B}"     >> ${seqr=
es}.full
+echo "Metaata stripe size =3D ${FIRST_METADATA_STRIPE_SIZE_B}" >> ${seqr=
es}.full
+echo "System stripe size  =3D ${FIRST_SYSTEM_STRIPE_SIZE_B}"   >> ${seqr=
es}.full
+
+INIT_ALLOC_SIZE_MB=3D$(expr \( ${FIRST_DATA_STRIPE_SIZE_B} + ${METADATA_=
STRIP_SIZE} + ${FIRST_SYSTEM_STRIPE_SIZE_B} \) / 1024 / 1024)
+echo "Allocation size for initial allocation =3D $INIT_ALLOC_SIZE_MB" >>=
 $seqres.full
+
+# Check if there is enough free space.
+echo "Check free space."
+
+#
+# Do first allocation with the default stripe sizes for the different bl=
ock
+# types.
+#
+echo "First allocation."
+_alloc_size "Data"     DATA_SIZE_START_MB
+_alloc_size "Metadata" METADATA_SIZE_START_MB
+_alloc_size "System"   SYSTEM_SIZE_START_MB
+
+echo "Block group Data alloc size     =3D ${DATA_SIZE_START_MB}"     >> =
$seqres.full
+echo "Block group Metadata alloc size =3D ${METADATA_SIZE_START_MB}" >> =
$seqres.full
+echo "Block group System alloc size   =3D ${SYSTEM_SIZE_START_MB}"   >> =
$seqres.full
+
+_set_btrfs_sysfs_attr ${SCRATCH_MNT} allocation/data/force_chunk_alloc 1
+_set_btrfs_sysfs_attr ${SCRATCH_MNT} allocation/metadata/force_chunk_all=
oc 1
+_set_btrfs_sysfs_attr ${SCRATCH_MNT} allocation/system/force_chunk_alloc=
 1
+
+_alloc_size "Data"     FIRST_DATA_SIZE_MB
+_alloc_size "Metadata" FIRST_METADATA_SIZE_MB
+_alloc_size "System"   FIRST_SYSTEM_SIZE_MB
+
+echo "First block group Data alloc size     =3D ${FIRST_DATA_SIZE_MB}"  =
   >> ${seqres}.full
+echo "First block group Metadata alloc size =3D ${FIRST_METADATA_SIZE_MB=
}" >> ${seqres}.full
+echo "First block group System alloc size   =3D ${FIRST_SYSTEM_SIZE_MB}"=
   >> ${seqres}.full
+
+_free_space FREE_SPACE_AFTER
+echo "Free space after first allocation =3D ${FREE_SPACE_AFTER}" >> ${se=
qres}.full
+
+#
+# Do allocation with the doubled stripe sizes for the different block ty=
pes.
+#
+echo "Second allocation."
+SECOND_DATA_STRIPE_SIZE_B=3D$(expr ${FIRST_DATA_STRIPE_SIZE_B} \* 2)
+SECOND_METADATA_STRIPE_SIZE_B=3D$(expr ${FIRST_METADATA_STRIPE_SIZE_B} \=
* 2)
+SECOND_SYSTEM_STRIPE_SIZE_B=3D$(expr ${FIRST_SYSTEM_STRIPE_SIZE_B} \* 2)
+
+# Stripe size is limited to 10% of device size.
+if [[ ${SECOND_DATA_STRIPE_SIZE_B} -gt $(expr ${DEVICE_SIZE_MB} \* 10 / =
100) ]]; then
+	SECOND_DATA_STRIPE_SIZE_B=3D$(expr ${DEVICE_SIZE_MB} \* 10 / 100 \* 102=
4 \* 1024)
+fi
+if [[ ${SECOND_METADATA_STRIPE_SIZE_B} -gt $(expr ${DEVICE_SIZE_MB} \* 1=
0 / 100) ]]; then
+	SECOND_METADATA_STRIPE_SIZE_B=3D$(expr ${DEVICE_SIZE_MB} \* 10 / 100 \*=
 1024 \* 1024)
+fi
+if [[ ${SECOND_SYSTEM_STRIPE_SIZE_B} -gt $(expr ${DEVICE_SIZE_MB} \* 10 =
/ 100) ]]; then
+	SECOND_SYSTEM_STRIPE_SIZE_B=3D$(expr ${DEVICE_SIZE_MB} \* 10 / 100 \* 1=
024 \* 1024)
+fi
+
+_set_btrfs_sysfs_attr ${SCRATCH_MNT} allocation/data/stripe_size ${SECON=
D_DATA_STRIPE_SIZE_B}
+_set_btrfs_sysfs_attr ${SCRATCH_MNT} allocation/metadata/stripe_size ${S=
ECOND_METADATA_STRIPE_SIZE_B}
+_set_btrfs_sysfs_attr ${SCRATCH_MNT} allocation/system/stripe_size ${SEC=
OND_SYSTEM_STRIPE_SIZE_B}
+
+SECOND_DATA_STRIPE_SIZE_READ_B=3D$(cat /sys/fs/btrfs/${UUID}/allocation/=
data/stripe_size)
+SECOND_METADATA_STRIPE_SIZE_READ_B=3D$(cat /sys/fs/btrfs/${UUID}/allocat=
ion/metadata/stripe_size)
+SECOND_SYSTEM_STRIPE_SIZE_READ_B=3D$(cat /sys/fs/btrfs/${UUID}/allocatio=
n/system/stripe_size)
+
+_set_btrfs_sysfs_attr ${SCRATCH_MNT} allocation/data/force_chunk_alloc 1
+_set_btrfs_sysfs_attr ${SCRATCH_MNT} allocation/metadata/force_chunk_all=
oc 1
+_set_btrfs_sysfs_attr ${SCRATCH_MNT} allocation/system/force_chunk_alloc=
 1
+
+_alloc_size "Data"     SECOND_DATA_SIZE_MB
+_alloc_size "Metadata" SECOND_METADATA_SIZE_MB
+_alloc_size "System"   SECOND_SYSTEM_SIZE_MB
+
+echo "Calculate request size so last memory allocation cannot be complet=
ely fullfilled."
+_free_space FREE_SPACE_MB
+
+# Find request size whose space allocation cannot be completely fullfill=
ed.
+THIRD_DATA_STRIPE_SIZE_MB=3D$(expr 256)
+until [ ${THIRD_DATA_STRIPE_SIZE_MB} -gt $(expr 7 \* 1024) ]
+do
+	if [ $((FREE_SPACE_MB%THIRD_DATA_STRIPE_SIZE_MB)) -ne 0 ]; then
+	       break
+        fi
+	THIRD_DATA_STRIPE_SIZE_MB=3D$((THIRD_DATA_STRIPE_SIZE_MB+256))
+done
+
+if [[ ${THIRD_DATA_STRIPE_SIZE_MB} -eq $(expr 7 \* 1024) ]]; then
+	_fail "Cannot find allocation size for partial block allocation."
+fi
+
+THIRD_DATA_STRIPE_SIZE_B=3D$(expr ${THIRD_DATA_STRIPE_SIZE_MB} \* 1024 \=
* 1024)
+echo "Allocation size in mb    =3D ${THIRD_DATA_STRIPE_SIZE_MB}" >> ${se=
qres}.full
+echo "Allocation size in bytes =3D ${THIRD_DATA_STRIPE_SIZE_B}"  >> ${se=
qres}.full
+
+#
+# Do allocation until free space is exhausted.
+#
+echo "Third allocation."
+_set_btrfs_sysfs_attr ${SCRATCH_MNT} allocation/data/stripe_size ${THIRD=
_DATA_STRIPE_SIZE_B}
+
+_free_space FREE_SPACE_MB
+while [ $FREE_SPACE_MB -gt $THIRD_DATA_STRIPE_SIZE_MB ]
+do
+	_alloc_size "Data" THIRD_DATA_SIZE_MB
+	_set_btrfs_sysfs_attr ${SCRATCH_MNT} allocation/data/force_chunk_alloc =
1
+
+	_free_space FREE_SPACE_MB
+done
+
+_alloc_size "Data" FOURTH_DATA_SIZE_MB
+
+#
+# Verification of initial allocation.
+#
+echo "Verify first allocation."
+FIRST_DATA_STRIPE_SIZE_MB=3D$(expr ${FIRST_DATA_STRIPE_SIZE_B} / 1024 / =
1024)
+FIRST_METADATA_STRIPE_SIZE_MB=3D$(expr ${FIRST_METADATA_STRIPE_SIZE_B} /=
 1024 / 1024)
+FIRST_SYSTEM_STRIPE_SIZE_MB=3D$(expr ${FIRST_SYSTEM_STRIPE_SIZE_B} / 102=
4 / 1024)
+
+# if [[ $(expr ${FIRST_DATA_STRIPE_SIZE_MB} + ${DATA_SIZE_START_MB}) -ne=
 $(expr ${FIRST_DATA_SIZE_MB}) ]]; then
+if [[ $(expr ${FIRST_DATA_STRIPE_SIZE_MB} + ${DATA_SIZE_START_MB}) -ne $=
{FIRST_DATA_SIZE_MB} ]]; then
+	_fail "tInitial data allocation not correct."
+fi
+
+if [[ $(expr ${FIRST_METADATA_STRIPE_SIZE_MB} + ${METADATA_SIZE_START_MB=
}) -ne ${FIRST_METADATA_SIZE_MB} ]]; then
+	_fail "Initial metadata allocation not correct."
+fi
+
+if [[ $(expr ${FIRST_SYSTEM_STRIPE_SIZE_MB} + ${SYSTEM_SIZE_START_MB}) -=
ne ${FIRST_SYSTEM_SIZE_MB} ]]; then
+	_fail "Initial system allocation not correct."
+fi
+
+#
+# Verification of second allocation.
+#
+echo "Verify second allocation."
+SECOND_DATA_STRIPE_SIZE_MB=3D$(expr ${SECOND_DATA_STRIPE_SIZE_B} / 1024 =
/ 1024)
+SECOND_METADATA_STRIPE_SIZE_MB=3D$(expr ${SECOND_METADATA_STRIPE_SIZE_B}=
 / 1024 / 1024)
+SECOND_SYSTEM_STRIPE_SIZE_MB=3D$(expr ${SECOND_SYSTEM_STRIPE_SIZE_B} / 1=
024 / 1024)
+
+if [[ ${SECOND_DATA_STRIPE_SIZE_B} -ne ${SECOND_DATA_STRIPE_SIZE_READ_B}=
 ]]; then
+	_fail "Value written to allocation/data/stripe_size and read value are =
different."
+fi
+
+if [[ ${SECOND_METADATA_STRIPE_SIZE_B} -ne ${SECOND_METADATA_STRIPE_SIZE=
_READ_B} ]]; then
+	_fail "Value written to allocation/metadata/stripe_size and read value =
are different."
+fi
+
+if [[ ${SECOND_SYSTEM_STRIPE_SIZE_B} -ne ${SECOND_SYSTEM_STRIPE_SIZE_REA=
D_B} ]]; then
+	_fail "Value written to allocation/system/stripe_size and read value ar=
e different."
+fi
+
+
+if [[ $(expr ${SECOND_DATA_STRIPE_SIZE_MB} + ${FIRST_DATA_SIZE_MB}) -ne =
${SECOND_DATA_SIZE_MB} ]]; then
+	_fail "Data allocation after stripe size change not correct."
+fi
+
+if [[ $(expr ${SECOND_METADATA_STRIPE_SIZE_MB} + ${FIRST_METADATA_SIZE_M=
B}) -ne ${SECOND_METADATA_SIZE_MB} ]]; then
+	_fail "Metadata allocation after stripe size change not correct."
+fi
+
+if [[ $(expr ${SECOND_SYSTEM_STRIPE_SIZE_MB} + ${FIRST_SYSTEM_SIZE_MB}) =
-ne ${SECOND_SYSTEM_SIZE_MB} ]]; then
+	_fail "System allocation after stripe size change not correct."
+fi
+
+#
+# Verification of third allocation.
+#
+echo "Verify third allocation."
+if [[ ${FREE_SPACE_MB} -gt ${THIRD_DATA_STRIPE_SIZE_MB} ]]; then
+	_fail "Free space after allocating over memlimit is too high."
+fi
+
+# The + 1 is required as 1MB is always kept as free space.
+if [[ $(expr ${THIRD_DATA_STRIPE_SIZE_MB} + ${THIRD_DATA_SIZE_MB} + 1) -=
le $(expr ${FOURTH_DATA_SIZE_MB}) ]]; then
+	_fail "Allocation until out of memory: last memory allocation size is n=
ot correct."
+fi
+
+status=3D0
+exit
+
diff --git a/tests/btrfs/248.out b/tests/btrfs/248.out
new file mode 100644
index 00000000..c95cbcd0
--- /dev/null
+++ b/tests/btrfs/248.out
@@ -0,0 +1,10 @@
+QA output created by 248
+Capture default stripe sizes.
+Check free space.
+First allocation.
+Second allocation.
+Calculate request size so last memory allocation cannot be completely fu=
llfilled.
+Third allocation.
+Verify first allocation.
+Verify second allocation.
+Verify third allocation.
--=20
2.30.2

