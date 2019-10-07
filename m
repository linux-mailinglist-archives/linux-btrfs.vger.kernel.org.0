Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08B51CDE55
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 11:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfJGJlN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 05:41:13 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60904 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbfJGJlN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Oct 2019 05:41:13 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x979cvlg055199;
        Mon, 7 Oct 2019 09:41:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=AojLel+cPconoxV02mAHyeYmwxKj/dmsHdHrftvP2og=;
 b=H3vXndKHDH/oAMZIs+UOHfvsi+/xoTvi6L1S0Qv3epVqsb5AOThuSA5lg9WWimYQTMwL
 mXHGJCLN8YU7ohd/+wgyJ4P/bEJfVv3x6kQEODTXsVEmHKM8SoEkjf/wrHNhIf4AEzdT
 55uioKUgWeyjkosC6K0ncyLrrAezjI+A8Wt7dW3fzJI8VsZ0qdLf96yLShU0FlURevm0
 JK1DJAirzjtgwekYU90tU+a/3BmM1hYIkQ6Nt8LbIt/N2IQQVRFuQv2QTa+newWtHU64
 qd364l3qC9F2K+8VZZ65O5JrkhZLvWkakNCFqhtFugplZwmS5P1x8cGWbOaXVi2iY3vR nw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2vektr5ftq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Oct 2019 09:41:11 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x979cQYN077583;
        Mon, 7 Oct 2019 09:41:11 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2vg1ytjmnd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Oct 2019 09:41:11 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x979fAkN013233;
        Mon, 7 Oct 2019 09:41:10 GMT
Received: from localhost.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Oct 2019 02:41:10 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] fstest: btrfs/197: test for alien devices
Date:   Mon,  7 Oct 2019 17:41:01 +0800
Message-Id: <20191007094101.784-2-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191007094101.784-1-anand.jain@oracle.com>
References: <20191007094101.784-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9402 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910070097
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9402 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910070097
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Test if btrfs.ko sucessfully identifies and reports the missing device,
if the missed device contians no btrfs magic string.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/197     | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/197.out | 25 +++++++++++++++++
 tests/btrfs/group   |  1 +
 3 files changed, 105 insertions(+)
 create mode 100755 tests/btrfs/197
 create mode 100644 tests/btrfs/197.out

diff --git a/tests/btrfs/197 b/tests/btrfs/197
new file mode 100755
index 000000000000..82e1a299ca43
--- /dev/null
+++ b/tests/btrfs/197
@@ -0,0 +1,79 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2019 Oracle.  All Rights Reserved.
+#
+# FS QA Test 197
+#
+# Test stale and alien device in the fs devices list.
+# Similar to the testcase btrfs/196 except that here the alien device no more
+# contains the btrfs superblock.
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
+	# Make device_1 an alien btrfs device for the raid created above by
+	# adding it to the $TEST_DIR
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
index c86ea2516397..f2eac5c20712 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -199,3 +199,4 @@
 194 auto volume
 195 auto volume
 196 auto quick volume
+197 auto quick volume
-- 
1.8.3.1

