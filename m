Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66263E00A0
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2019 11:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731368AbfJVJZF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Oct 2019 05:25:05 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54146 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731338AbfJVJZF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Oct 2019 05:25:05 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9M9JQ5Y164890;
        Tue, 22 Oct 2019 09:25:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=TTDUDGA+xUbWFenEHqMe8ssh8AZ9zp1tANn8Rd/JG/c=;
 b=Trgpc/1of955SFzri/6TXH52seRJciM/jAoL524iCU43Ue9HQVo7hhaqkXQd8LTd8GEF
 pIJ0YV/VPg0dNrAveGA14RvpbvlLsk2L7P1TUiavnoDx4lBnARpNParZKemh+JZZKL2D
 120Y+FXXw+wveQrjBTQHZmueA3FlM7XcgAj8VzfYg22GHAg/1pwDH2nEKVo7tSMaLTFB
 V4Y8mvQ30nMnIjaLvskxGXqMTwaIyWJxoKxmO9I21iIJhGwS/rpGw6RuG4alTnpaCw6a
 S6yRrwymqXZuLQjxrh+pYw2aAnU/v0ojqC57z91pote6bRO/KCZZ5HgEknsTsN8RTt+s Vg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2vqu4qn5fc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Oct 2019 09:25:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9M9NJ1q156542;
        Tue, 22 Oct 2019 09:25:02 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2vsx22bgeq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Oct 2019 09:25:02 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9M9P1Kb017779;
        Tue, 22 Oct 2019 09:25:01 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Oct 2019 02:25:01 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/2] fstest: btrfs/198: test for alien devices
Date:   Tue, 22 Oct 2019 17:24:50 +0800
Message-Id: <1571736290-23576-2-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571736290-23576-1-git-send-email-anand.jain@oracle.com>
References: <20191007094101.784-1-anand.jain@oracle.com>
 <1571736290-23576-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9417 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910220087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9417 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910220087
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Test if btrfs.ko sucessfully identifies and reports the missing device,
if the missed device contians no btrfs magic string.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: Comments added to list kernel patch required to pass the test case
    Fix copy and paste error in the comment

 tests/btrfs/198     | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/198.out | 25 +++++++++++++++++
 tests/btrfs/group   |  1 +
 3 files changed, 105 insertions(+)
 create mode 100755 tests/btrfs/198
 create mode 100644 tests/btrfs/198.out

diff --git a/tests/btrfs/198 b/tests/btrfs/198
new file mode 100755
index 000000000000..c4c651b310c8
--- /dev/null
+++ b/tests/btrfs/198
@@ -0,0 +1,79 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2019 Oracle.  All Rights Reserved.
+#
+# FS QA Test 198
+#
+# Test stale and alien non-btrfs device in the fs devices list.
+#  Bug fixed in:
+#    btrfs: remove identified alien device in open_fs_devices
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
+. ./common/filter.btrfs
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs generic
+_supported_os Linux
+_require_command "$WIPEFS_PROG" wipefs
+_require_scratch
+_require_scratch_dev_pool 4
+
+workout()
+{
+	raid=$1
+	device_nr=$2
+
+	echo $raid
+	_scratch_dev_pool_get $device_nr
+
+	_scratch_pool_mkfs "-d$raid -m$raid" >> $seqres.full 2>&1 || \
+							_fail "mkfs failed"
+
+	# Make device_1 a free btrfs device for the raid created above by
+	# clearing its superblock
+
+	# don't test with the first device as auto fs check (_check_scratch_fs)
+	# picks the first device
+	device_1=$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
+	$WIPEFS_PROG -a $device_1 >> $seqres.full 2>&1
+
+	device_2=$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
+	_mount -o degraded $device_2 $SCRATCH_MNT
+	# Check if missing device is reported as in the 196.out
+	$BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT | \
+						_filter_btrfs_filesystem_show
+
+	_scratch_unmount
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
diff --git a/tests/btrfs/198.out b/tests/btrfs/198.out
new file mode 100644
index 000000000000..af904a39efd6
--- /dev/null
+++ b/tests/btrfs/198.out
@@ -0,0 +1,25 @@
+QA output created by 198
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
index 208720efba61..94961044f1fe 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -200,3 +200,4 @@
 195 auto volume
 196 auto metadata log volume
 197 auto quick volume
+198 auto quick volume
-- 
1.8.3.1

