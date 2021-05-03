Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA3B53713FE
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 May 2021 13:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbhECLJK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 May 2021 07:09:10 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48354 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbhECLJJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 May 2021 07:09:09 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 143B05tq063717;
        Mon, 3 May 2021 11:08:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=rgvVAQLaTK+P7CbaqYhf0iJJKCDu9s+Xrh8fYLTYJ84=;
 b=z81PHZboKJlIXj9OACARHUs42bepTbD3T9oKwVkYVAaryRvkzSiyxLpjaw8f3rZYoVJ+
 a3I1QlBPgaDVKk/7ehoZq6XfUbr5mbrfDQMuK+c7GkcQu597He/37vnQzufwiPeAe6Q1
 W+G1/58soRKMPIF694QsFkg0AsL1T65PfnTbQdLiCXDCihCpnTEQ04Mu7KwpWqOj+OuG
 xH3mv5WroNRiINiEXoRV7ZpqaMfafNebosX1aLo1QOZHPa/tmYspua9yKNymn9U0j/PC
 QR6hXglhUvrt4EPNIaZ+x4qwItITweN9bHi7mOmSMn5FG4azkEy35hYz2vdwooV2rA05 Zw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 388xxmu8j4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 11:08:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 143B0DNL136757;
        Mon, 3 May 2021 11:08:12 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 388xt27ukh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 11:08:12 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 143B8AEw025773;
        Mon, 3 May 2021 11:08:10 GMT
Received: from localhost.localdomain (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 May 2021 04:08:10 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, fdmanana@suse.com
Subject: [PATCH v3] btrfs: add fstrim test case on the sprout device
Date:   Mon,  3 May 2021 19:08:00 +0800
Message-Id: <2426455f382feec9352d48f5912278c30dc06210.1620039369.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <96fe1c0c8747d24ad6c45bc3f0a5551b8e1ebbde.1619793258.git.anand.jain@oracle.com>
References: <96fe1c0c8747d24ad6c45bc3f0a5551b8e1ebbde.1619793258.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9972 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105030075
X-Proofpoint-GUID: 8Rql6p4AzgAqqLYwylhtepUQPoLRxG_j
X-Proofpoint-ORIG-GUID: 8Rql6p4AzgAqqLYwylhtepUQPoLRxG_j
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9972 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105030075
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add fstrim test case on the sprout device, verify seed device
integrity.

 btrfs: fix unmountable seed device after fstrim

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v3:
  Drop useless write into the sprout device as we are testing the effect of
     fstrim run in the sprout on the seed device.
v2:
  Add _require_fstrim and _require_batched_discard.
  Use FSTRIM_PROG.
  Use _filter_ro_mount to handle the difference in output in different
     mount(8) version.
  Call _scratch_dev_pool_put.
  Add _check_btrfs_filesystem $seed to check the whole seed fs.
  Update in-code comments.

 tests/btrfs/236     | 79 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/236.out |  5 +++
 tests/btrfs/group   |  1 +
 3 files changed, 85 insertions(+)
 create mode 100755 tests/btrfs/236
 create mode 100644 tests/btrfs/236.out

diff --git a/tests/btrfs/236 b/tests/btrfs/236
new file mode 100755
index 000000000000..1fcb3aab8c0c
--- /dev/null
+++ b/tests/btrfs/236
@@ -0,0 +1,79 @@
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

