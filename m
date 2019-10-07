Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4305ACDE54
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 11:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfJGJlN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 05:41:13 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57664 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfJGJlM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Oct 2019 05:41:12 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x979d0la065541;
        Mon, 7 Oct 2019 09:41:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2019-08-05; bh=mQ4Pr5bXawH34/BdLD74IVvqIYnW5NOAZ+RvAxw2jNo=;
 b=W0RAQNsBMgxMclZHydTIdJ8vnVeiNwwBDiXqzWL+cksytXCxaT30JPJscv4daiTpmIb9
 3jGcCO5lHTHlOCuINiAlEAzUSQ3VaOONB41KqqTRXjH4J+d69FT9Rr0h7Mka0bAj2YBk
 1OnLrPXHT7UzQYfj4u4YaoeisJE3Pr1lhVHDEqgRwYnmoOp8SdAkSVBOVzuDRcDe7DUw
 TIjC21hY8PppO0wHGS6t+E6IXQoEtdSzDX+QCdlucVgkua0K8RpTwYcFrh079MO02waQ
 zxETFF+hKprHWu8EqDzeRphI9dk8YSBegaJ2m6PDXCAB06oQJsf/BS9F7+LPNWwgc1Ey Gw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2vejku5pru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Oct 2019 09:41:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x979cSWK093944;
        Mon, 7 Oct 2019 09:41:10 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2vf4ph739q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Oct 2019 09:41:10 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x979f8Hg019175;
        Mon, 7 Oct 2019 09:41:09 GMT
Received: from localhost.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Oct 2019 02:41:07 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] fstest: btrfs/196: test for alien btrfs-devices
Date:   Mon,  7 Oct 2019 17:41:00 +0800
Message-Id: <20191007094101.784-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
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
if the missed device contians someother btrfs.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/196     | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/196.out | 25 +++++++++++++++++
 tests/btrfs/group   |  1 +
 3 files changed, 103 insertions(+)
 create mode 100755 tests/btrfs/196
 create mode 100644 tests/btrfs/196.out

diff --git a/tests/btrfs/196 b/tests/btrfs/196
new file mode 100755
index 000000000000..e35cdce492e5
--- /dev/null
+++ b/tests/btrfs/196
@@ -0,0 +1,77 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2019 Oracle.  All Rights Reserved.
+#
+# FS QA Test 196
+#
+# Test stale and alien btrfs-device in the fs devices list.
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
+	$BTRFS_UTIL_PROG device add -f "$device_1" "$TEST_DIR"
+
+	device_2=$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
+	_mount -o degraded $device_2 $SCRATCH_MNT
+	# Check if missing device is reported as in the 196.out
+	$BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT | \
+						_filter_btrfs_filesystem_show
+
+	$BTRFS_UTIL_PROG device remove "$device_1" "$TEST_DIR"
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
diff --git a/tests/btrfs/196.out b/tests/btrfs/196.out
new file mode 100644
index 000000000000..311ae9e2f46a
--- /dev/null
+++ b/tests/btrfs/196.out
@@ -0,0 +1,25 @@
+QA output created by 196
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
index 3ce6fa4628d8..c86ea2516397 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -198,3 +198,4 @@
 193 auto quick qgroup enospc limit
 194 auto volume
 195 auto volume
+196 auto quick volume
-- 
1.8.3.1

