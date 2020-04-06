Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC66C19F551
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Apr 2020 14:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbgDFMAl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Apr 2020 08:00:41 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47594 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgDFMAl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Apr 2020 08:00:41 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 036Bws35046510
        for <linux-btrfs@vger.kernel.org>; Mon, 6 Apr 2020 12:00:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=YvrPtbhkfOvzNJGBgb8NX74fEeshnOwtpHBfiNBbBz4=;
 b=fI0OOzAU0KWrE36ZebLfNmT8pU0BU3Re4463UhugIXWvWiNOewiWc9+uLMN55I6lLD6v
 LItDQP0juRoLbgAkTtuMnpP7kca/m6FofEDsO5u9WWm7smQdYTkyfBc66i5FsJV4u4oN
 6GU2jUHhYuySPSyfN0TNTvfGk6UbeaqVInBuGnkZklmkNOyCg9q+unKjScyItuS7ijC1
 daG1GycMHVjIpbCEPakTLg+sP5D25BnRxJ6AzoM6F1/mMa1aVwgLeEY8qILpBS0EwJjk
 48rBLyCi9EB5J7E22qo3cYXuq5PRoqZPCrRLl0dOTsgDo+CeWGy3+guYa/xlH3eenGPW HQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 306jvmx9n8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Apr 2020 12:00:39 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 036BwN9n039410
        for <linux-btrfs@vger.kernel.org>; Mon, 6 Apr 2020 12:00:39 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 30839pusn3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Apr 2020 12:00:39 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 036C0cXR029395
        for <linux-btrfs@vger.kernel.org>; Mon, 6 Apr 2020 12:00:38 GMT
Received: from tp.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 Apr 2020 05:00:38 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] fstests: btrfs test read from disks of different generation
Date:   Mon,  6 Apr 2020 20:00:26 +0800
Message-Id: <1586174426-6016-1-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1552995330-28927-2-git-send-email-anand.jain@oracle.com>
References: <1552995330-28927-2-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 suspectscore=1 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004060105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=1
 mlxlogscore=999 mlxscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060105
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Verify file read from disks assembled with different generations.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
(Not yet for the integration, prerequisites are not yet integrated)

v2: rebase.
    use the sysfs interface to set the read_policy instead of mount

 tests/btrfs/210     | 147 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/210.out |  12 +++++
 tests/btrfs/group   |   1 +
 3 files changed, 160 insertions(+)
 create mode 100755 tests/btrfs/210
 create mode 100644 tests/btrfs/210.out

diff --git a/tests/btrfs/210 b/tests/btrfs/210
new file mode 100755
index 000000000000..df51ab584688
--- /dev/null
+++ b/tests/btrfs/210
@@ -0,0 +1,147 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2019 Oracle.  All Rights Reserved.
+#
+# FS QA Test ?
+#
+# Test read on raid1 assembled with disks of different generations.
+#  Steps:
+#   . Use btrfs snapshot on the test_dir to create disk images of
+#     different generations (lets say generation a and generation b).
+#   . Mount one disk from generation a and another disk from generation
+#     b, and verify the file md5sum.
+#  Note: readmirror feature (in the btrfs ml) helps to reproduce the
+#     problem consistently.
+#  Fix-by: kernel patch
+#   NA
+#  Temp workaroud fix for two disk raid1:
+#   [PATCH] btrfs: fix read corrpution on disks of different generation
+#  Needs read_policy patch-set to test:
+#   [PATCH v7 0/5] readmirror feature (sysfs and in-memory only approach; with new read_policy device)
+
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
+	_scratch_unmount > /dev/null 2>&1
+	_destroy_loop_device $dev1
+	_destroy_loop_device $dev2
+	btrfs subvolume delete $img_subvol > /dev/null 2>&1
+	btrfs subvolume delete $img_subvol_at_gen_a > /dev/null 2>&1
+	[[ -z $scratch_dev_pool_saved ]] || \
+			SCRATCH_DEV_POOL="$scratch_dev_pool_saved"
+	_scratch_dev_pool_put
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
+_supported_fs generic
+_supported_os Linux
+_require_test
+_require_scratch_dev_pool 2
+_require_btrfs_forget_or_module_loadable
+
+_btrfs_forget_or_module_reload
+
+_scratch_dev_pool_get 2
+scratch_dev_pool_saved=""
+
+img_subvol=$TEST_DIR/img_subvol
+img_subvol_at_gen_a=$TEST_DIR/img_subvol_at_gen_a
+dev1_img=$img_subvol/d1
+dev2_img=$img_subvol/d2
+dev1_img_at_gen_a=$img_subvol_at_gen_a/d1
+dev2_img_at_gen_a=$img_subvol_at_gen_a/d2
+
+$BTRFS_UTIL_PROG subvolume create $img_subvol >> /dev/null 2>&1 || \
+					_fail "subvol create failed"
+
+$XFS_IO_PROG -f -c "pwrite -S 0xdd 0 256m" $dev1_img >> /dev/null 2>&1
+$XFS_IO_PROG -f -c "pwrite -S 0xdd 0 256m" $dev2_img >> /dev/null 2>&1
+
+dev1=$(_create_loop_device $dev1_img)
+dev2=$(_create_loop_device $dev2_img)
+
+scratch_dev_pool_saved="$SCRATCH_DEV_POOL"
+SCRATCH_DEV_POOL="$dev1 $dev2"
+_scratch_pool_mkfs -U 12345678-1234-1234-1234-123456789abc -d raid1 -m raid1 >>\
+		$seqres.full 2>&1 || _fail  "mkfs failed on $SCRATCH_DEV_POOL"
+
+
+_mount "-o max_inline=0,nodatacow,device=$dev1" $dev2 $SCRATCH_MNT || \
+					_fail "mount for gen a failed"
+
+$XFS_IO_PROG -f -c "pwrite -S 0xaa 0 4K" $SCRATCH_MNT/foobar >> /dev/null 2>&1
+
+echo md5sum at generation aa
+md5sum $SCRATCH_MNT/foobar | _filter_scratch
+echo
+_scratch_unmount
+
+$BTRFS_UTIL_PROG subvolume snapshot $img_subvol $img_subvol_at_gen_a \
+		>> /dev/null 2>&1 || _fail "subvol create failed"
+
+_mount "-o max_inline=0,nodatacow,device=$dev1" $dev2 $SCRATCH_MNT || \
+					_fail "mount for gen b failed"
+
+$XFS_IO_PROG -f -c "pwrite -S 0xbb 0 4K" $SCRATCH_MNT/foobar >> /dev/null 2>&1
+
+echo md5sum at generation bb
+md5sum $SCRATCH_MNT/foobar | _filter_scratch
+echo
+
+_scratch_unmount
+
+_destroy_loop_device $dev1
+_destroy_loop_device $dev2
+
+_test_unmount
+_btrfs_forget_or_module_reload
+_test_mount
+
+dev1=$(_create_loop_device $dev1_img_at_gen_a)
+dev2=$(_create_loop_device $dev2_img)
+
+_mount "-o ro,device=$dev1" $dev2 $SCRATCH_MNT || _fail "mount at gen ab failed"
+
+SCRATCH_SYSFS_PATH="/sys/fs/btrfs/12345678-1234-1234-1234-123456789abc"
+
+devid_for_read=$($BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT| grep $dev1 |\
+							awk '{print $2}')
+echo 1 > $SCRATCH_SYSFS_PATH/devinfo/$devid_for_read/read_preferred
+echo "device" > $SCRATCH_SYSFS_PATH/read_policy
+
+echo md5sum at generation ab read from devid=$devid_for_read
+md5sum $SCRATCH_MNT/foobar | _filter_scratch
+
+echo 1 > /proc/sys/vm/drop_caches
+echo 0 > $SCRATCH_SYSFS_PATH/devinfo/$devid_for_read/read_preferred
+devid_for_read=$($BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT| grep $dev2 |\
+							awk '{print $2}')
+echo 1 > $SCRATCH_SYSFS_PATH/devinfo/$devid_for_read/read_preferred
+
+echo
+echo md5sum at generation ab read from devid=$devid_for_read
+md5sum $SCRATCH_MNT/foobar | _filter_scratch
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/210.out b/tests/btrfs/210.out
new file mode 100644
index 000000000000..b55030fea1fa
--- /dev/null
+++ b/tests/btrfs/210.out
@@ -0,0 +1,12 @@
+QA output created by 210
+md5sum at generation aa
+3e4309c7cc81f23d45e260a8f13ca860  SCRATCH_MNT/foobar
+
+md5sum at generation bb
+055a2a7342c0528969e1b6e32aadeee3  SCRATCH_MNT/foobar
+
+md5sum at generation ab read from devid=1
+055a2a7342c0528969e1b6e32aadeee3  SCRATCH_MNT/foobar
+
+md5sum at generation ab read from devid=2
+055a2a7342c0528969e1b6e32aadeee3  SCRATCH_MNT/foobar
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 657ec548159b..3f71ce235d96 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -212,3 +212,4 @@
 207 auto rw raid
 208 auto quick subvol
 209 auto quick log
+210 auto quick volume
-- 
1.8.3.1

