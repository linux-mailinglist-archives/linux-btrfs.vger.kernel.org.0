Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDBC4AE254
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Feb 2022 20:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236908AbiBHTfQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Feb 2022 14:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386104AbiBHTfQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Feb 2022 14:35:16 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC33C0612C0
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Feb 2022 11:35:15 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 218E6oC8022685
        for <linux-btrfs@vger.kernel.org>; Tue, 8 Feb 2022 11:35:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=5pIhHQ4fEk7bw7x4V8ak+ixPRtFx7xD2je7heUo7daM=;
 b=WJpSvRT3hHJI285MB6Nbyc3Nfps0i1noLDhkqxfDJo+JaK46M6PIX9yzlZDxXpCXE0OL
 KGG53miDXHGsyHI9BN01FY1EKCZrCNVYmiV8LL2DrREijn93YbM4xxpKfTsWnteQC3vF
 ZMQ3t6mi+w9ZTKbbWxsfc+pnmETMDieSrqM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e3ess5v3d-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Feb 2022 11:35:15 -0800
Received: from twshared14630.35.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Feb 2022 11:35:13 -0800
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
        id 33D3AA7B5727; Tue,  8 Feb 2022 11:32:55 -0800 (PST)
From:   Stefan Roesch <shr@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <fstests@vger.kernel.org>,
        <kernel-team@fb.com>
CC:     <shr@fb.com>
Subject: [PATCH v1] btrfs: Add new test for setting the chunk size.
Date:   Tue, 8 Feb 2022 11:32:52 -0800
Message-ID: <20220208193252.500915-1-shr@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Mj3-TApsEcNIT9wUkM9Kz9lQDMp78vY4
X-Proofpoint-ORIG-GUID: Mj3-TApsEcNIT9wUkM9Kz9lQDMp78vY4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_06,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202080115
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add new testcase for testing the new btrfs sysfs knob to change the
chunk size. The new knob uses /sys/fs/btrfs/<UUID>/allocation/<block
type>/chunk_size.

The test case implements three different cases:
- Test allocation with the default chunk size
- Test allocation after increasing the chunk size
- Test allocation when the free space is smaller than the chunk size.

Note: this test needs to force the allocation of space. It uses the
/sys/fs/btrfs/<UUID>/allocation/<block type>/force_chunk_alloc knob.

Testing:
The test has been run with volumes of different sizes.

Signed-off-by: Stefan Roesch <shr@fb.com>
---
 tests/btrfs/257     | 273 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/257.out |  10 ++
 2 files changed, 283 insertions(+)
 create mode 100755 tests/btrfs/257
 create mode 100644 tests/btrfs/257.out

diff --git a/tests/btrfs/257 b/tests/btrfs/257
new file mode 100755
index 00000000..00a099a5
--- /dev/null
+++ b/tests/btrfs/257
@@ -0,0 +1,273 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 Facebook.  All Rights Reserved.
+#
+# FS QA Test 257
+#
+# Test the new /sys/fs/btrfs/<uuid>/allocation/<block-type>/chunk_size
+# setting. This setting allows the admin to change the chunk size
+# setting for the next allocation.
+#
+# Test 1:
+#   Allocate storage for all three block types (data, metadata and syste=
m)
+#   with the default chunk size.
+#
+# Test 2:
+#   Set a new chunk size to double the default size and allocate space
+#   for all new block types with the new chunk size.
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
+seq=3D`basename $0`
+seqres=3D"${RESULT_DIR}/${seq}"
+
+# Parse a size string which is in the format "XX.XXMib".
+#
+# Parameters:
+#   - (IN)    Block group type (Data, Metadata, System)
+#   - (INOUT) Variable to store block group size in MB
+#
+parse_size_string() {
+	local SIZE=3D$(echo "$1" | $AWK_PROG 'match($0, /([0-9.]+)/) { print su=
bstr($0, RSTART, RLENGTH) }')
+	eval $2=3D"${SIZE%.*}"
+}
+
+# Determine the size of the device in MB.
+#
+# Parameters:
+#   - (INOUT) Variable to store device size in MB
+#
+device_size() {
+	$BTRFS_UTIL_PROG filesystem show ${SCRATCH_MNT} --mbytes | grep devid >=
> $seqres.full
+	local SIZE=3D$($BTRFS_UTIL_PROG filesystem show ${SCRATCH_MNT} --mbytes=
 | grep devid)
+	parse_size_string $(echo "${SIZE}" | awk '{print $4}') SIZE_ALLOC
+	eval $1=3D${SIZE_ALLOC%.*}
+}
+
+# Determine the free space of a block group in MB.
+#
+# Parameters:
+#   - (INOUT) Variable to store free space in MB
+#
+free_space() {
+	local SIZE=3D$($BTRFS_UTIL_PROG filesystem show ${SCRATCH_MNT} --mbytes=
 | grep devid)
+	parse_size_string $(echo "${SIZE}" | awk '{print $4}') SIZE_ALLOC
+	parse_size_string $(echo "${SIZE}" | awk '{print $6}') SIZE_USED
+	eval $1=3D$(expr ${SIZE_ALLOC} - ${SIZE_USED})
+}
+
+# Determine how much space in MB has been allocated to a block group.
+#
+# Parameters:
+#   - (IN)    Block group type (Data, Metadata, System)
+#   - (INOUT) Variable to store block group size in MB
+#
+alloc_size() {
+	local SIZE_STRING=3D$($BTRFS_UTIL_PROG filesystem df ${SCRATCH_MNT} -m =
| grep  "$1" | awk '{print $3}')
+	parse_size_string ${SIZE_STRING} BLOCK_GROUP_SIZE
+	eval $2=3D"${BLOCK_GROUP_SIZE}"
+}
+
+. ./common/filter
+_supported_fs btrfs
+_require_test
+_require_scratch
+
+# Delete log file if it exists.
+rm -f "${seqres}.full"
+
+# Make filesystem. 10GB is needed to test different chunk sizes for
+# metadata and data and the default size for volumes > 5GB is different.
+_scratch_mkfs_sized $((10 * 1024 * 1024 * 1024)) >> $seqres.full 2>&1
+_scratch_mount >> $seqres.full 2>&1
+
+# Check if there is sufficient sysfs support.
+_require_fs_sysfs allocation/metadata/chunk_size
+_require_fs_sysfs allocation/metadata/force_chunk_alloc
+
+# Get free space.
+free_space  FREE_SPACE_MB
+device_size DEVICE_SIZE_MB
+
+echo "free space =3D ${FREE_SPACE_MB}MB" >> ${seqres}.full
+
+# If device is a symbolic link, get block device.
+SCRATCH_BDEV=3D$(_real_dev $SCRATCH_DEV)
+
+# Get chunk sizes.
+echo "Capture default chunk sizes."
+FIRST_DATA_CHUNK_SIZE_B=3D$(_get_fs_sysfs_attr ${SCRATCH_BDEV} allocatio=
n/data/chunk_size)
+FIRST_METADATA_CHUNK_SIZE_B=3D$(_get_fs_sysfs_attr ${SCRATCH_BDEV} alloc=
ation/metadata/chunk_size)
+
+echo "Orig Data chunk size    =3D ${FIRST_DATA_CHUNK_SIZE_B}"     >> ${s=
eqres}.full
+echo "Orig Metaata chunk size =3D ${FIRST_METADATA_CHUNK_SIZE_B}" >> ${s=
eqres}.full
+
+INIT_ALLOC_SIZE_MB=3D$(expr \( ${FIRST_DATA_CHUNK_SIZE_B} + ${FIRST_META=
DATA_CHUNK_SIZE_B} \) / 1024 / 1024)
+echo "Allocation size for initial allocation =3D ${INIT_ALLOC_SIZE_MB}MB=
" >> $seqres.full
+
+#
+# Do first allocation with the default chunk sizes for the different blo=
ck
+# types.
+#
+echo "First allocation."
+alloc_size "Data"     DATA_SIZE_START_MB
+alloc_size "Metadata" METADATA_SIZE_START_MB
+
+echo "Block group Data alloc size     =3D ${DATA_SIZE_START_MB}MB"     >=
> $seqres.full
+echo "Block group Metadata alloc size =3D ${METADATA_SIZE_START_MB}MB" >=
> $seqres.full
+
+_set_fs_sysfs_attr ${SCRATCH_BDEV} allocation/data/force_chunk_alloc 1
+_set_fs_sysfs_attr ${SCRATCH_BDEV} allocation/metadata/force_chunk_alloc=
 1
+
+alloc_size "Data"     FIRST_DATA_SIZE_MB
+alloc_size "Metadata" FIRST_METADATA_SIZE_MB
+
+echo "First block group Data alloc size     =3D ${FIRST_DATA_SIZE_MB}MB"=
     >> ${seqres}.full
+echo "First block group Metadata alloc size =3D ${FIRST_METADATA_SIZE_MB=
}MB" >> ${seqres}.full
+
+free_space FREE_SPACE_AFTER
+echo "Free space after first allocation =3D ${FREE_SPACE_AFTER}MB" >> ${=
seqres}.full
+
+#
+# Do allocation with the doubled chunk sizes for the different block typ=
es.
+#
+echo "Second allocation."
+SECOND_DATA_CHUNK_SIZE_B=3D$(expr ${FIRST_DATA_CHUNK_SIZE_B} \* 2)
+SECOND_METADATA_CHUNK_SIZE_B=3D$(expr ${FIRST_METADATA_CHUNK_SIZE_B} \* =
2)
+
+echo "Second block group Data calc alloc size     =3D ${SECOND_DATA_CHUN=
K_SIZE_B}"     >> $seqres.full
+echo "Second block group Metadata calc alloc size =3D ${SECOND_METADATA_=
CHUNK_SIZE_B}" >> $seqres.full
+
+# Stripe size is limited to 10% of device size.
+if [[ ${SECOND_DATA_CHUNK_SIZE_B} -gt $(expr ${DEVICE_SIZE_MB} \* 10 \* =
1024 \* 1024 / 100) ]]; then
+	SECOND_DATA_CHUNK_SIZE_B=3D$(expr ${DEVICE_SIZE_MB} \* 10 / 100 \* 1024=
 \* 1024)
+fi
+if [[ ${SECOND_METADATA_CHUNK_SIZE_B} -gt $(expr ${DEVICE_SIZE_MB} \* 10=
 \* 1024 \* 1024 / 100) ]]; then
+	SECOND_METADATA_CHUNK_SIZE_B=3D$(expr ${DEVICE_SIZE_MB} \* 10 / 100 \* =
1024 \* 1024)
+fi
+
+echo "Second block group Data alloc size     =3D ${SECOND_DATA_CHUNK_SIZ=
E_B}"     >> $seqres.full
+echo "Second block group Metadata alloc size =3D ${SECOND_METADATA_CHUNK=
_SIZE_B}" >> $seqres.full
+
+_set_fs_sysfs_attr ${SCRATCH_BDEV} allocation/data/chunk_size ${SECOND_D=
ATA_CHUNK_SIZE_B}
+_set_fs_sysfs_attr ${SCRATCH_BDEV} allocation/metadata/chunk_size ${SECO=
ND_METADATA_CHUNK_SIZE_B}
+
+SECOND_DATA_CHUNK_SIZE_READ_B=3D$(_get_fs_sysfs_attr ${SCRATCH_BDEV} all=
ocation/data/chunk_size)
+SECOND_METADATA_CHUNK_SIZE_READ_B=3D$(_get_fs_sysfs_attr ${SCRATCH_BDEV}=
 allocation/metadata/chunk_size)
+
+_set_fs_sysfs_attr ${SCRATCH_BDEV} allocation/data/force_chunk_alloc 1
+echo "Allocated data chunk" >> $seqres.full
+_set_fs_sysfs_attr ${SCRATCH_BDEV} allocation/metadata/force_chunk_alloc=
 1
+echo "Allocated metadata chunk" >> $seqres.full
+
+alloc_size "Data"     SECOND_DATA_SIZE_MB
+alloc_size "Metadata" SECOND_METADATA_SIZE_MB
+alloc_size "System"   SECOND_SYSTEM_SIZE_MB
+
+echo "Calculate request size so last memory allocation cannot be complet=
ely fullfilled."
+free_space FREE_SPACE_MB
+
+# Find request size whose space allocation cannot be completely fullfill=
ed.
+THIRD_DATA_CHUNK_SIZE_MB=3D$(expr 256)
+until [ ${THIRD_DATA_CHUNK_SIZE_MB} -gt $(expr 7 \* 1024) ]; do
+	if [ $((FREE_SPACE_MB%THIRD_DATA_CHUNK_SIZE_MB)) -ne 0 ]; then
+		break
+	fi
+	THIRD_DATA_CHUNK_SIZE_MB=3D$((THIRD_DATA_CHUNK_SIZE_MB+256))
+done
+
+if [[ ${THIRD_DATA_CHUNK_SIZE_MB} -eq $(expr 7 \* 1024) ]]; then
+	_fail "Cannot find allocation size for partial block allocation."
+fi
+
+THIRD_DATA_CHUNK_SIZE_B=3D$(expr ${THIRD_DATA_CHUNK_SIZE_MB} \* 1024 \* =
1024)
+echo "Allocation size in mb    =3D ${THIRD_DATA_CHUNK_SIZE_MB}" >> ${seq=
res}.full
+echo "Allocation size in bytes =3D ${THIRD_DATA_CHUNK_SIZE_B}"  >> ${seq=
res}.full
+
+#
+# Do allocation until free space is exhausted.
+#
+echo "Third allocation."
+_set_fs_sysfs_attr ${SCRATCH_BDEV} allocation/data/chunk_size ${THIRD_DA=
TA_CHUNK_SIZE_B}
+
+free_space FREE_SPACE_MB
+while [ $FREE_SPACE_MB -gt $THIRD_DATA_CHUNK_SIZE_MB ]
+do
+	alloc_size "Data" THIRD_DATA_SIZE_MB
+	_set_fs_sysfs_attr ${SCRATCH_BDEV} allocation/data/force_chunk_alloc 1
+
+	free_space FREE_SPACE_MB
+done
+
+alloc_size "Data" FOURTH_DATA_SIZE_MB
+
+#
+# Force chunk allocation of system block type must fail.
+#
+echo "Force allocation of system block type must fail."
+_set_fs_sysfs_attr ${SCRATCH_BDEV} allocation/system/force_chunk_alloc 1=
 2>/dev/null
+
+#
+# Verification of initial allocation.
+#
+echo "Verify first allocation."
+FIRST_DATA_CHUNK_SIZE_MB=3D$(expr ${FIRST_DATA_CHUNK_SIZE_B} / 1024 / 10=
24)
+FIRST_METADATA_CHUNK_SIZE_MB=3D$(expr ${FIRST_METADATA_CHUNK_SIZE_B} / 1=
024 / 1024)
+
+# if [[ $(expr ${FIRST_DATA_CHUNK_SIZE_MB} + ${DATA_SIZE_START_MB}) -ne =
$(expr ${FIRST_DATA_SIZE_MB}) ]]; then
+if [[ $(expr ${FIRST_DATA_CHUNK_SIZE_MB} + ${DATA_SIZE_START_MB}) -ne ${=
FIRST_DATA_SIZE_MB} ]]; then
+	echo "tInitial data allocation not correct."
+fi
+
+if [[ $(expr ${FIRST_METADATA_CHUNK_SIZE_MB} + ${METADATA_SIZE_START_MB}=
) -ne ${FIRST_METADATA_SIZE_MB} ]]; then
+	echo "Initial metadata allocation not correct."
+fi
+
+#
+# Verification of second allocation.
+#
+echo "Verify second allocation."
+SECOND_DATA_CHUNK_SIZE_MB=3D$(expr ${SECOND_DATA_CHUNK_SIZE_B} / 1024 / =
1024)
+SECOND_METADATA_CHUNK_SIZE_MB=3D$(expr ${SECOND_METADATA_CHUNK_SIZE_B} /=
 1024 / 1024)
+
+if [[ ${SECOND_DATA_CHUNK_SIZE_B} -ne ${SECOND_DATA_CHUNK_SIZE_READ_B} ]=
]; then
+	echo "Value written to allocation/data/chunk_size and read value are di=
fferent."
+fi
+
+if [[ ${SECOND_METADATA_CHUNK_SIZE_B} -ne ${SECOND_METADATA_CHUNK_SIZE_R=
EAD_B} ]]; then
+	echo "Value written to allocation/metadata/chunk_size and read value ar=
e different."
+fi
+
+if [[ $(expr ${SECOND_DATA_CHUNK_SIZE_MB} + ${FIRST_DATA_SIZE_MB}) -ne $=
{SECOND_DATA_SIZE_MB} ]]; then
+	echo "Data allocation after chunk size change not correct."
+fi
+
+if [[ $(expr ${SECOND_METADATA_CHUNK_SIZE_MB} + ${FIRST_METADATA_SIZE_MB=
}) -ne ${SECOND_METADATA_SIZE_MB} ]]; then
+	echo "Metadata allocation after chunk size change not correct."
+fi
+
+#
+# Verification of third allocation.
+#
+echo "Verify third allocation."
+if [[ ${FREE_SPACE_MB} -gt ${THIRD_DATA_CHUNK_SIZE_MB} ]]; then
+	echo "Free space after allocating over memlimit is too high."
+fi
+
+# The + 1 is required as 1MB is always kept as free space.
+if [[ $(expr ${THIRD_DATA_CHUNK_SIZE_MB} + ${THIRD_DATA_SIZE_MB} + 1) -l=
e $(expr ${FOURTH_DATA_SIZE_MB}) ]]; then
+	echo "Allocation until out of memory: last memory allocation size is no=
t correct."
+fi
+
+status=3D0
+exit
+
diff --git a/tests/btrfs/257.out b/tests/btrfs/257.out
new file mode 100644
index 00000000..49be3b16
--- /dev/null
+++ b/tests/btrfs/257.out
@@ -0,0 +1,10 @@
+QA output created by 257
+Capture default chunk sizes.
+First allocation.
+Second allocation.
+Calculate request size so last memory allocation cannot be completely fu=
llfilled.
+Third allocation.
+Force allocation of system block type must fail.
+Verify first allocation.
+Verify second allocation.
+Verify third allocation.

base-commit: d8dee1222ecdfa1cff1386a61248e587eb3b275d
--=20
2.30.2

