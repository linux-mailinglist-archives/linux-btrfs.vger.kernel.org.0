Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDFD225657
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jul 2020 05:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgGTD4N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Jul 2020 23:56:13 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35744 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbgGTD4N (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Jul 2020 23:56:13 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06K3rH2F080949;
        Mon, 20 Jul 2020 03:56:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=6XAjsqu1NZRRTDKfocWL/kOEPpFBo13XzXOAYGDf67k=;
 b=t3ULx0e5gOhS1lXG+ML2pLrG/ECqARiYfiLChUAbqiI8SKK6+EI3zWxDzDGH5gU857zC
 2Fu4hLpBb6PTNu4W1ByDrISqLo71xBcWBPQqt5lBzpYdxz/ZH0V1QvLCmI5GyMCa6uDO
 sQBTbuJeo0HJHmgZ4B8AIT+bduFpFQQFFFt8ff8Kk8k57Keb4OOiSzPc11rhJ+WdSJ31
 bhZS1X9DZXjWZMxY2EDoWITh3D1wCM6HfaGVALnZHkUzyG+qy7Uip/IlqmYPhFIwuTvl
 GOMRAQSVJcFvGW9B0ZU5WIwJ7oQZIbI/OtQKzh7hTieGLStXMWkCK673H0CPguwLkN+W Jw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 32bs1m4e1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Jul 2020 03:56:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06K3ls5G132146;
        Mon, 20 Jul 2020 03:56:05 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 32cqm83vdf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jul 2020 03:56:05 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06K3u3rg013231;
        Mon, 20 Jul 2020 03:56:04 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 Jul 2020 03:56:03 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     fstests@vger.kernel.org, guan@eryu.me, nborisov@suse.com
Subject: [PATCH v3] fstests: btrfs test if show_devname returns sprout device
Date:   Mon, 20 Jul 2020 11:55:54 +0800
Message-Id: <20200720035554.5549-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200719151928.GB2557159@desktop>
References: <20200719151928.GB2557159@desktop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9687 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007200027
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9687 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 bulkscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 clxscore=1011
 spamscore=0 mlxscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007200027
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Test if the show_devname() returns sprout device instead of seed device.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: check for presence of needed sprout device.
v3: check for not presence of needed sprout device and break the
silence.

 tests/btrfs/215     | 63 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/215.out |  2 ++
 tests/btrfs/group   |  1 +
 3 files changed, 66 insertions(+)
 create mode 100755 tests/btrfs/215
 create mode 100644 tests/btrfs/215.out

diff --git a/tests/btrfs/215 b/tests/btrfs/215
new file mode 100755
index 000000000000..5be6d0f60192
--- /dev/null
+++ b/tests/btrfs/215
@@ -0,0 +1,63 @@
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
+dev=$(grep $SCRATCH_MNT /proc/self/mounts | $AWK_PROG '{print $1}')
+
+if [ "$sprout" != "$dev" ]; then
+	echo "Unexpected device: $dev"
+fi
+echo "Silence is golden"
+
+_scratch_dev_pool_put
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/215.out b/tests/btrfs/215.out
new file mode 100644
index 000000000000..0a11773bbb32
--- /dev/null
+++ b/tests/btrfs/215.out
@@ -0,0 +1,2 @@
+QA output created by 215
+Silence is golden
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

