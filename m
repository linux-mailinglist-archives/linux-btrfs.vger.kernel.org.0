Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F053914E823
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2020 06:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbgAaFKG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jan 2020 00:10:06 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:50074 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbgAaFKG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jan 2020 00:10:06 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00V53gNo176207;
        Fri, 31 Jan 2020 05:10:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=PpJddWG5PTFOr4BNsLm3+I8GexC5CT13HShUZrkVoKM=;
 b=ai56bGuqRQj62sb6O4WlM5F7wqG8eIWGF/dmsIetwLbS8mq4/qiFeoSMjNAQ7TWvZECn
 r4bmfbmOm/E/uyhjfOXS9U/l6rXf/OEQIemME5zw/H1B0hdh1y3VnPxbMWBVHgx1uz2J
 ybyYx6Pa5MemJgb38LAgTyozPptrze8+bEPOej+IyjJ2HiVyuFjYEhQ+K3NaOSY9WKwB
 EEVZ3qLIbk8KEkyznldwcQWQ6IZ0uOD7T/bVvxUOWnjj3evpBfOctuBCroJdoYKJAR81
 OBTcAjGT3evUv2QNHR0nYsq13ditHXHYHWRf0vOgs/V4ZotXjb+Krdp3D5dBDQD7+LRl Dg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2xrearr0tn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jan 2020 05:10:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00V53jlN088066;
        Fri, 31 Jan 2020 05:10:03 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2xva6pp3ks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jan 2020 05:10:03 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00V5A30V012370;
        Fri, 31 Jan 2020 05:10:03 GMT
Received: from localhost.localdomain (/183.90.36.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 Jan 2020 21:10:02 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: test unaligned punch hole at ENOSPC
Date:   Fri, 31 Jan 2020 13:09:57 +0800
Message-Id: <20200131050957.3491-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <526051b1-4a48-fd40-c8dc-af7e1b399111@gmx.com>
References: <526051b1-4a48-fd40-c8dc-af7e1b399111@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9516 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001310044
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9516 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001310044
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Try to punch hole with unaligned size and offset when the FS is
full and mounted with nodatacow option.
Mainly holes are punched at locations which are unaligned
with the file extent boundaries when the FS is full by data.
As the punching holes at unaligned location will involve
truncating blocks instead of just dropping the extents, it shall
involve reserving data and metadata space for delalloc and so data
alloc fails as the FS is full.

btrfs_punch_hole()
 btrfs_truncate_block()
   btrfs_check_data_free_space() <-- ENOSPC

We don't fail punch hole if the holes are aligned with the file
extent boundaries as it shall involve just dropping the related
extents, without truncating data extent blocks.

Link: https://patchwork.kernel.org/patch/11357415/
Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Eryu Guan <guaneryu@gmail.com>
(cherry picked from commit 4c2c678cd56a81a210cb16f9f9347073e91e2fb0)
Signed-off-by: Anand Jain <anand.jain@oracle.com>

Conflicts:
	tests/btrfs/group
---
Its decided to bring back this test case, now the problem is better understood
and the fix is available in the ML as in [Link].
v2: mention nodatacow option used in the testcase in the commit log.

 tests/btrfs/172     | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/172.out |  2 ++
 tests/btrfs/group   |  1 +
 3 files changed, 76 insertions(+)
 create mode 100755 tests/btrfs/172
 create mode 100644 tests/btrfs/172.out

diff --git a/tests/btrfs/172 b/tests/btrfs/172
new file mode 100755
index 000000000000..0dffb2dff40b
--- /dev/null
+++ b/tests/btrfs/172
@@ -0,0 +1,73 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2018 Oracle. All Rights Reserved.
+#
+# FS QA Test 172
+#
+# Test if the unaligned (by size and offset) punch hole is successful when FS
+# is at ENOSPC.
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs btrfs
+_supported_os Linux
+_require_scratch
+_require_xfs_io_command "fpunch"
+
+_scratch_mkfs_sized $((256 * 1024 *1024)) >> $seqres.full
+
+# max_inline ensures data is not inlined within metadata extents
+_scratch_mount "-o max_inline=0,nodatacow"
+
+cat /proc/self/mounts | grep $SCRATCH_DEV >> $seqres.full
+$BTRFS_UTIL_PROG filesystem df $SCRATCH_MNT >> $seqres.full
+
+extent_size=$(_scratch_btrfs_sectorsize)
+unalign_by=512
+echo extent_size=$extent_size unalign_by=$unalign_by >> $seqres.full
+
+$XFS_IO_PROG -f -c "pwrite -S 0xab 0 $((extent_size * 10))" \
+					$SCRATCH_MNT/testfile >> $seqres.full
+
+echo "Fill all space available for data and all unallocated space." >> $seqres.full
+dd status=none if=/dev/zero of=$SCRATCH_MNT/filler bs=512 >> $seqres.full 2>&1
+
+hole_offset=0
+hole_len=$unalign_by
+$XFS_IO_PROG -c "fpunch $hole_offset $hole_len" $SCRATCH_MNT/testfile
+
+hole_offset=$(($extent_size + $unalign_by))
+hole_len=$(($extent_size - $unalign_by))
+$XFS_IO_PROG -c "fpunch $hole_offset $hole_len" $SCRATCH_MNT/testfile
+
+hole_offset=$(($extent_size * 2 + $unalign_by))
+hole_len=$(($extent_size * 5))
+$XFS_IO_PROG -c "fpunch $hole_offset $hole_len" $SCRATCH_MNT/testfile
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/btrfs/172.out b/tests/btrfs/172.out
new file mode 100644
index 000000000000..ce2de3f0d107
--- /dev/null
+++ b/tests/btrfs/172.out
@@ -0,0 +1,2 @@
+QA output created by 172
+Silence is golden
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 4b64bf8b6d2f..697b6a38ea00 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -174,6 +174,7 @@
 169 auto quick send
 170 auto quick snapshot
 171 auto quick qgroup
+172 auto quick punch
 173 auto quick swap
 174 auto quick swap
 175 auto quick swap volume
-- 
1.8.3.1

