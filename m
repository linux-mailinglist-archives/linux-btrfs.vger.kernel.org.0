Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDA036FC9C
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Apr 2021 16:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbhD3Oky (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Apr 2021 10:40:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44588 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbhD3Oku (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Apr 2021 10:40:50 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13UEEH53009539;
        Fri, 30 Apr 2021 14:39:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=bKgANIXG14/eWkDe2ohT7wcb4dNM06EF/6W1V0BZEWo=;
 b=ZdqT7XYR1nPJ1+UJWrjSSAmFmtOXdww9MghI/pro5g21x9op2/dWEDUgrxO4P9RI3xpI
 xLEtpuu3NfkWm/iI0tHRNF9k52NQchhWhmVfo8ToX7se4RqhuTD946K3if4vfh+kSQMS
 i9m3WjM/4pFDB/4nnS17sFeEkF+cXG1El+vlvh1Youvg5WCEFe+3sD5Mc0nwFD2YjUYg
 aaT0lHEOwPO6VQXELqZWPummLtvIg+JUwCFVv3vLEGa/pPTn8/X2RJ4SchN5RcdQT4wN
 8zQaih3woO+CmkPqK8H2Cp3guEeo6q6dKtwqRvmRpu7o0chr6YVAR/vtA/EPFCNabR1b SA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 385aeq7xbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Apr 2021 14:39:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13UEawf5102029;
        Fri, 30 Apr 2021 14:39:52 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 3848f2kfaq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Apr 2021 14:39:51 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13UEdpvx031285;
        Fri, 30 Apr 2021 14:39:51 GMT
Received: from localhost.localdomain (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 30 Apr 2021 07:39:50 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: add fstrim test case on the sprout device
Date:   Fri, 30 Apr 2021 22:39:24 +0800
Message-Id: <96fe1c0c8747d24ad6c45bc3f0a5551b8e1ebbde.1619793258.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <d6fcae756c5ce47da3527e5db4760d676420d950.1619783910.git.anand.jain@oracle.com>
References: <d6fcae756c5ce47da3527e5db4760d676420d950.1619783910.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9970 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104300101
X-Proofpoint-ORIG-GUID: XvZUbTdCDemPLSLWpl24WDY1bhAKfMdQ
X-Proofpoint-GUID: XvZUbTdCDemPLSLWpl24WDY1bhAKfMdQ
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9970 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1011 suspectscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104300100
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add fstrim test case on the sprout device, verify seed device
integrity.

Needs kernel patch [1] to pass the test case.
[1]
  btrfs: fix unmountable seed device after fstrim

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/236     | 72 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/236.out |  5 ++++
 tests/btrfs/group   |  1 +
 3 files changed, 78 insertions(+)
 create mode 100755 tests/btrfs/236
 create mode 100644 tests/btrfs/236.out

diff --git a/tests/btrfs/236 b/tests/btrfs/236
new file mode 100755
index 000000000000..599892bebf10
--- /dev/null
+++ b/tests/btrfs/236
@@ -0,0 +1,72 @@
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
+_mount $seed $SCRATCH_MNT 2>&1 | _filter_scratch
+md5sum $SCRATCH_MNT/foo | _filter_scratch
+
+$BTRFS_UTIL_PROG device add -f $sprout $SCRATCH_MNT
+_scratch_unmount
+
+# Now remount
+_mount $sprout $SCRATCH_MNT
+$XFS_IO_PROG -f -c "pwrite -S 0xcd 0 1M" $SCRATCH_MNT/bar > /dev/null
+
+fstrim $SCRATCH_MNT
+
+_scratch_unmount
+_mount $seed $SCRATCH_MNT 2>&1 | _filter_scratch
+md5sum $SCRATCH_MNT/foo | _filter_scratch
+_scratch_unmount
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/236.out b/tests/btrfs/236.out
new file mode 100644
index 000000000000..2929d39395a8
--- /dev/null
+++ b/tests/btrfs/236.out
@@ -0,0 +1,5 @@
+QA output created by 236
+mount: SCRATCH_MNT: WARNING: device write-protected, mounted read-only.
+096003817ad2638000a6836e55866697  SCRATCH_MNT/foo
+mount: SCRATCH_MNT: WARNING: device write-protected, mounted read-only.
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

