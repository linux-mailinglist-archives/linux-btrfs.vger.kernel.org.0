Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA09B21CEFE
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jul 2020 07:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgGMFtB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jul 2020 01:49:01 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48438 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgGMFtB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jul 2020 01:49:01 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06D5kxf4020118;
        Mon, 13 Jul 2020 05:49:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=F7ciWW6b+BO+j7o2GUNr9GS45wKoxZIfcFGqiyZWQVQ=;
 b=mZRAJvoV0pLDVoW7opi4QlnemrGVo7hkPardK7Sli9WpyvGLCG3cnQ7xz+UncoIsZxqe
 r5W416kZ5t7c/UQ5+mYyOw3i7GdrOXB9haDmvf1e8sNDvRzC4pBFRoCiwslxlEpfHn5A
 RXpI8QPvKPPBBO1GkgFVS3iJn2QBd4qmt11C9AH/sPzST/APGBSvk9/k6sa3BC7KBvwH
 he5sqrJ+lxcP3uufFLwkMx+w//PHiLGWvLiaRlXjV6XEu8PpceNTwBp853kmzAQXHlxZ
 XaygK8rwZls3XyrkU76DVZGjb3p8GJpGZ2mPMMDMQ9CYRFvxdlrhbXCsHf6fg6pa6VaL 3w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 3275ckvw2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Jul 2020 05:48:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06D5bTgl167658;
        Mon, 13 Jul 2020 05:48:59 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 327q0ktuhq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jul 2020 05:48:59 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06D5mwnl012213;
        Mon, 13 Jul 2020 05:48:58 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 12 Jul 2020 22:48:57 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, josef@toxicpanda.com
Subject: [PATCH] fstests: btrfs test if show_devname returns sprout device
Date:   Mon, 13 Jul 2020 13:48:47 +0800
Message-Id: <20200713054847.10080-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200710063738.28368-1-anand.jain@oracle.com>
References: <20200710063738.28368-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9680 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 suspectscore=13
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007130042
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9680 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=13 priorityscore=1501
 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 clxscore=1011 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007130043
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Test if the show_devname() returns sprout device instead of seed device.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/215     | 59 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/215.out |  2 ++
 tests/btrfs/group   |  1 +
 3 files changed, 62 insertions(+)
 create mode 100755 tests/btrfs/215
 create mode 100644 tests/btrfs/215.out

diff --git a/tests/btrfs/215 b/tests/btrfs/215
new file mode 100755
index 000000000000..19eb68437567
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
+# Requires kernel patch:
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
+#must fail
+cat /proc/self/mounts | grep $seed
+
+_scratch_dev_pool_put
+
+echo "Silence is golden"
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

