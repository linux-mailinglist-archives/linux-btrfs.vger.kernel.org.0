Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E913DE009F
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2019 11:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731354AbfJVJZC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Oct 2019 05:25:02 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40050 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731338AbfJVJZC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Oct 2019 05:25:02 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9M9JUJv168695;
        Tue, 22 Oct 2019 09:25:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=+4DBS/We5EWItBWim6LSzmXmbDW/pAN9sEe03pSrR3w=;
 b=HgUj5m+UbS935zHTd6fgSgtunJeKodZhpkxn4HZoMa2d0Cy7f3pUSwDrzSXzlIjji7js
 9R8M1bMKHY6n5WgNp6evD5BHPQcsGUqweJDDuqBdyop5uK3xm60fkeis77LA59TVMfHm
 WcCiAiFBsT9xtCZ4i2u8XIfLMvpBP6giVcPdVkjNQaa81tFM6XZRANkAoqWptfTJaMts
 MqVC18PshGhWLI2oXaTsJ3mxekIL3zSl5+rlGod7rL0geqRv+09DBm5SXIawfCJYPLUf
 EMx+j2gAuulsWEknYAhy/0wqn0WC8eiEJ1yeq+qxuFJrmA6aP7EcdRtfphKt+4hW+sDf cw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2vqtepnber-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Oct 2019 09:25:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9M9NKNt156598;
        Tue, 22 Oct 2019 09:25:00 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2vsx22bgcn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Oct 2019 09:25:00 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9M9OxMW002852;
        Tue, 22 Oct 2019 09:24:59 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Oct 2019 02:24:59 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/2] fstest: btrfs/197: test for alien btrfs-devices
Date:   Tue, 22 Oct 2019 17:24:49 +0800
Message-Id: <1571736290-23576-1-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20191007094101.784-1-anand.jain@oracle.com>
References: <20191007094101.784-1-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9417 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910220087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9417 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910220087
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Test if btrfs.ko sucessfully identifies and reports the missing device,
if the missed device contians someother btrfs.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: Comments updated with the required kernel patch to pass this test.
    Use spare device instead of test_mnt to create an alien btrfs device.
    Fix comment, remove ref to 196.
    Fix _supported_fs generic

 tests/btrfs/197     | 88 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/197.out | 25 +++++++++++++++
 tests/btrfs/group   |  1 +
 3 files changed, 114 insertions(+)
 create mode 100755 tests/btrfs/197
 create mode 100644 tests/btrfs/197.out

diff --git a/tests/btrfs/197 b/tests/btrfs/197
new file mode 100755
index 000000000000..9019df1a4897
--- /dev/null
+++ b/tests/btrfs/197
@@ -0,0 +1,88 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2019 Oracle.  All Rights Reserved.
+#
+# FS QA Test 197
+#
+# Test stale and alien btrfs-device in the fs devices list.
+#  Bug fixed in the kernel patch:
+#   btrfs: include non-missing as a qualifier for the latest_bdev
+#   btrfs: remove identified alien btrfs device in open_fs_devices
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
+	rm -rf $TEST_DIR/$seq.mnt
+	cd /
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/filter.btrfs
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_os Linux
+_supported_fs btrfs
+_require_scratch
+_require_scratch_dev_pool 5
+
+workout()
+{
+	raid=$1
+	device_nr=$2
+
+	echo $raid
+	_scratch_dev_pool_get $device_nr
+	_spare_dev_get
+
+	_mkfs_dev $SPARE_DEV
+	mkdir -p $TEST_DIR/$seq.mnt
+	_mount $SPARE_DEV $TEST_DIR/$seq.mnt
+
+	_scratch_pool_mkfs "-d$raid -m$raid" >> $seqres.full 2>&1 || \
+							_fail "mkfs failed"
+
+	# Make device_1 an alien btrfs device for the raid created above by
+	# adding it to the $TEST_DIR
+
+	# don't test with the first device as auto fs check (_check_scratch_fs)
+	# picks the first device
+	device_1=$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
+	$BTRFS_UTIL_PROG device add -f "$device_1" "$TEST_DIR/$seq.mnt"
+
+	device_2=$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
+	_mount -o degraded $device_2 $SCRATCH_MNT
+	# Check if missing device is reported as in the .out
+	$BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT | \
+						_filter_btrfs_filesystem_show
+
+	$BTRFS_UTIL_PROG device remove "$device_1" "$TEST_DIR/$seq.mnt"
+	umount $TEST_DIR/$seq.mnt
+	_scratch_unmount
+	_spare_dev_put
+	_scratch_dev_pool_put
+}
+
+workout "raid1" "2"
+workout "raid5" "3"
+workout "raid6" "4"
+workout "raid10" "4"
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/197.out b/tests/btrfs/197.out
new file mode 100644
index 000000000000..79237b854b5a
--- /dev/null
+++ b/tests/btrfs/197.out
@@ -0,0 +1,25 @@
+QA output created by 197
+raid1
+Label: none  uuid: <UUID>
+	Total devices <NUM> FS bytes used <SIZE>
+	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
+	*** Some devices missing
+
+raid5
+Label: none  uuid: <UUID>
+	Total devices <NUM> FS bytes used <SIZE>
+	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
+	*** Some devices missing
+
+raid6
+Label: none  uuid: <UUID>
+	Total devices <NUM> FS bytes used <SIZE>
+	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
+	*** Some devices missing
+
+raid10
+Label: none  uuid: <UUID>
+	Total devices <NUM> FS bytes used <SIZE>
+	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
+	*** Some devices missing
+
diff --git a/tests/btrfs/group b/tests/btrfs/group
index c2ab3e7de9b6..208720efba61 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -199,3 +199,4 @@
 194 auto volume
 195 auto volume
 196 auto metadata log volume
+197 auto quick volume
-- 
1.8.3.1

