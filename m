Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFE321D429
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jul 2020 13:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbgGMLAg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jul 2020 07:00:36 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46410 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727890AbgGMLAg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jul 2020 07:00:36 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06DAw2vk126308;
        Mon, 13 Jul 2020 11:00:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=DeKsFHBQb6a/5X9HR/exaAS+b3sjY4j4JCfrUfPa2Cc=;
 b=vW/EQV0r39WSFVd4XWECVbCtwBCaaHt05nrrMgM/KuGm4nLKrnIsKEfjLJbmK4uftucG
 qqZi7eO1XSOxZuUbvZIgJ/wZvpgk8RdDLvTLXAbIqvy2yqWYmwOp2DDA0jTCq4A8fZlH
 5zKB6emdBabcqFKcP3JNGMSo9aQ6P+NtxwyP+5yzKYzAhCbKWUtmxFztz+igYtOu84U4
 yDY48M1NNLoI0fvGxU5Af5tFHmOxo444ol2vSGmuOi95DOpjET1OMaqlkKqZMudPectq
 tsvaOxCjkss5X2ziXj4GvKTBdX7z0boDEFZmVBirnuyBOwqhLYV2Pz5GS0M7gXN13xy7 Cw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 3274uqxcsj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Jul 2020 11:00:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06DAvpbn140638;
        Mon, 13 Jul 2020 11:00:28 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 327q0m64d5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jul 2020 11:00:28 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06DB0QZq014029;
        Mon, 13 Jul 2020 11:00:26 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Jul 2020 04:00:25 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, josef@toxicpanda.com,
        nborisov@suse.com
Subject: [PATCH v2] fstests: btrfs test if show_devname returns sprout device
Date:   Mon, 13 Jul 2020 19:00:17 +0800
Message-Id: <20200713110017.66825-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <6dcd6b3c-06a9-51a7-988b-63cb254d7749@suse.com>
References: <6dcd6b3c-06a9-51a7-988b-63cb254d7749@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9680 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 suspectscore=13
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007130083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9680 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 suspectscore=13 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007130083
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Test if the show_devname() returns sprout device instead of seed device.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: check for presence of needed sprout device.

 common/filter       |  8 ++++++
 tests/btrfs/215     | 59 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/215.out |  2 ++
 tests/btrfs/group   |  1 +
 4 files changed, 70 insertions(+)
 create mode 100755 tests/btrfs/215
 create mode 100644 tests/btrfs/215.out

diff --git a/common/filter b/common/filter
index 2477f3860151..992783aba187 100644
--- a/common/filter
+++ b/common/filter
@@ -284,6 +284,14 @@ _filter_test_dir()
 	    -e "s,\B$TEST_DEV,TEST_DEV,g"
 }
 
+_filter_devs()
+{
+	local filter_devs
+
+	filter_devs=$(echo $1 | sed -e 's/\s\+/\\\|/g')
+	sed -e "s,$filter_devs,SCRATCH_DEV,g"
+}
+
 _filter_scratch()
 {
 	# SCRATCH_DEV may be a prefix of SCRATCH_MNT (e.g. /mnt, /mnt/ovl-mnt)
diff --git a/tests/btrfs/215 b/tests/btrfs/215
new file mode 100755
index 000000000000..cf5e360d14b1
--- /dev/null
+++ b/tests/btrfs/215
@@ -0,0 +1,59 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 Oracle.  All Rights Reserved.
+#
+# FS QA Test 215
+#
+# Test if the show_devname() returns sprout device instead of seed device.
+#
+# Fixed in kernel patch:
+#   btrfs: btrfs_show_devname don't traverse into the seed fsid
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
+_supported_fs btrfs
+_supported_os Linux
+_require_scratch_dev_pool 2
+
+_scratch_dev_pool_get 2
+
+seed=$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
+sprout=$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
+
+_mkfs_dev $seed
+$BTRFS_TUNE_PROG -S 1 $seed
+_mount $seed $SCRATCH_MNT >> $seqres.full 2>&1
+cat /proc/self/mounts | grep $seed >> $seqres.full
+$BTRFS_UTIL_PROG device add -f $sprout $SCRATCH_MNT
+cat /proc/self/mounts | grep $sprout >> $seqres.full
+
+# check if the show_devname() returns the sprout device instead of seed device.
+cat /proc/self/mounts | grep $SCRATCH_MNT | awk '{print $1}' | \
+							_filter_devs $sprout
+
+_scratch_dev_pool_put
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/215.out b/tests/btrfs/215.out
new file mode 100644
index 000000000000..ed3207851653
--- /dev/null
+++ b/tests/btrfs/215.out
@@ -0,0 +1,2 @@
+QA output created by 215
+SCRATCH_DEV
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 505665b54d61..76c8b78d08f9 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -217,3 +217,4 @@
 212 auto balance dangerous
 213 auto balance dangerous
 214 auto quick send snapshot
+215 auto quick seed
-- 
2.25.1

