Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 514673705B7
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 May 2021 07:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbhEAFSy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 May 2021 01:18:54 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39358 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhEAFSx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 1 May 2021 01:18:53 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1415FFXH066695;
        Sat, 1 May 2021 05:18:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=CMaFeuOFuLe7LJe/gXcb0JnwS6iLS8ZE/YHLX22Gr2g=;
 b=XrqrY0OLJ5ClXro3kxpV3s5wIXkheEWOe3GaEuOrkk8IRzJvRJD0D5No626Iy4DqD10L
 GiZNhWKhqW0BcgIVHFs/ibIkX21da15UYA33TzYanl7niMDfoASdXosjsPTj2MS463qP
 IgGG8RrKkJ5vcUHvfkiFOM097M7z/BMY9vXUmg9+X7swZOTYlkPGt5cxBnGJxl78z3vs
 SqSNTeg7joG1eBK2fVr7mfpUxBhrK6lGGAX+IPqGpHOON2DTf0IsdhTXMioK7Nk9kYPo
 TcPWUMvTHi4x9v3ouMxjrvdB8O7oEBWwwMQjUSiTxy6NSRmUHXzuLbkFqJQMcGfX3mju oA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 388xxmr2dv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 01 May 2021 05:18:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1415B14b051746;
        Sat, 1 May 2021 05:18:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 388w1amuey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 01 May 2021 05:18:00 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1415I0eQ072115;
        Sat, 1 May 2021 05:18:00 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 388w1amueg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 01 May 2021 05:18:00 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 1415Hwl0013357;
        Sat, 1 May 2021 05:17:59 GMT
Received: from localhost.localdomain (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 30 Apr 2021 22:17:58 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
        fdmanana@suse.com
Subject: [PATCH v2] btrfs: add fstrim test case on the sprout device
Date:   Sat,  1 May 2021 13:17:26 +0800
Message-Id: <7ff015576992de7e8d6ff554c27c420a9ffa1595.1619800208.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <96fe1c0c8747d24ad6c45bc3f0a5551b8e1ebbde.1619793258.git.anand.jain@oracle.com>
References: <96fe1c0c8747d24ad6c45bc3f0a5551b8e1ebbde.1619793258.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: m5PmAlcp5a6DZyr7Zj0ZusvaFaW2FvBK
X-Proofpoint-ORIG-GUID: m5PmAlcp5a6DZyr7Zj0ZusvaFaW2FvBK
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9970 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105010036
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add fstrim test case on the sprout device, verify seed device
integrity.

 btrfs: fix unmountable seed device after fstrim

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2:
  Add _require_fstrim and _require_batched_discard.
  Use FSTRIM_PROG.
  Use _filter_ro_mount to handle the difference in output in different
     mount(8) version.
  Call _scratch_dev_pool_put.
  Add _check_btrfs_filesystem $seed to check the whole seed fs.
  Update in-code comments.

 tests/btrfs/236     | 81 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/236.out |  5 +++
 tests/btrfs/group   |  1 +
 3 files changed, 87 insertions(+)
 create mode 100755 tests/btrfs/236
 create mode 100644 tests/btrfs/236.out

diff --git a/tests/btrfs/236 b/tests/btrfs/236
new file mode 100755
index 000000000000..aac27fac06dd
--- /dev/null
+++ b/tests/btrfs/236
@@ -0,0 +1,81 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 Oracle. All Rights Reserved.
+#
+# FS QA Test 236
+#
+# Check seed device integrity after fstrim on the sprout device.
+#
+#  Kernel bug is fixed by the commit:
+#    btrfs: fix unmountable seed device after fstrim
+
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
+_require_command "$BTRFS_TUNE_PROG" btrfstune
+_require_fstrim
+_require_scratch_dev_pool 2
+_scratch_dev_pool_get 2
+
+seed=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}')
+sprout=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}')
+
+_mkfs_dev $seed
+_mount $seed $SCRATCH_MNT
+
+$XFS_IO_PROG -f -c "pwrite -S 0xab 0 1M" $SCRATCH_MNT/foo > /dev/null
+_scratch_unmount
+$BTRFS_TUNE_PROG -S 1 $seed
+
+# Mount the seed device and add the rw device
+_mount $seed $SCRATCH_MNT 2>&1 | _filter_ro_mount | _filter_scratch
+md5sum $SCRATCH_MNT/foo | _filter_scratch
+
+$BTRFS_UTIL_PROG device add -f $sprout $SCRATCH_MNT
+_scratch_unmount
+
+# Now remount writeable sprout device, create some data and run fstrim
+_mount $sprout $SCRATCH_MNT
+_require_batched_discard $SCRATCH_MNT
+
+$XFS_IO_PROG -f -c "pwrite -S 0xcd 0 1M" $SCRATCH_MNT/bar > /dev/null
+
+$FSTRIM_PROG $SCRATCH_MNT
+
+_scratch_unmount
+
+# Verify seed device is all ok
+_mount $seed $SCRATCH_MNT 2>&1 | _filter_ro_mount | _filter_scratch
+md5sum $SCRATCH_MNT/foo | _filter_scratch
+_scratch_unmount
+
+_check_btrfs_filesystem $seed
+
+_scratch_dev_pool_put
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/236.out b/tests/btrfs/236.out
new file mode 100644
index 000000000000..01699b8fc291
--- /dev/null
+++ b/tests/btrfs/236.out
@@ -0,0 +1,5 @@
+QA output created by 236
+mount: device write-protected, mounting read-only
+096003817ad2638000a6836e55866697  SCRATCH_MNT/foo
+mount: device write-protected, mounting read-only
+096003817ad2638000a6836e55866697  SCRATCH_MNT/foo
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 331dd432fac3..5032259244e0 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -238,3 +238,4 @@
 233 auto quick subvolume
 234 auto quick compress rw
 235 auto quick send
+236 auto quick seed trim
-- 
2.27.0

