Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01AA427D31F
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Sep 2020 17:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbgI2Pub (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Sep 2020 11:50:31 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56908 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728494AbgI2Pub (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 11:50:31 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08TFn36e001488;
        Tue, 29 Sep 2020 15:50:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=MEyKnqNEOVpcqbP0/cFq72+2P2WJg+rIs5b+g6B99VU=;
 b=aSpmZawbkQ2bwex6k1cUZiqRz+QZ0qpX1ct6xijHfGOTzHUrKM4KA02XsQ39bQcxoHcO
 q+Umt3cUc1XRSD3tzeyF8rnpMd24pQvSsmKRxU8G4fIfRT+sZoD02tDY7/lHHebdDCEh
 FuFbdoE+ugvSKL/qziJ7jMexotlvJDi/wslvxcxd2T7IUDrrYUdpTpu5l5qryZvt00Op
 22RhsJ+QiRhG0Bj/pckG4gODEwuy31GBNpJecwgqSGAre0Uecg0uYjlbyNqduLu1Ow+X
 ua6qNhOg58oUO7WR628aemmqAXeEOceafq5FrOQRpQXj6ryVnpwo7Y0AZjCHSGEg1Wz5 KQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 33sx9n3nvh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Sep 2020 15:50:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08TFUq57176590;
        Tue, 29 Sep 2020 15:50:27 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 33uv2e39rx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Sep 2020 15:50:26 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08TFoPeq010716;
        Tue, 29 Sep 2020 15:50:25 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 29 Sep 2020 08:50:24 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, josef@toxicpanda.com,
        guaneryu@gmail.com, johannes.thumshirn@wdc.com
Subject: [PATCH] fstests: delete btrfs/064 it makes no sense
Date:   Tue, 29 Sep 2020 23:50:15 +0800
Message-Id: <f36fdfad33395cbf99520479b162590935f3cfd1.1601394562.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=13 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009290135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=13
 phishscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 clxscore=1011
 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009290136
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs/064 aimed to test balance and replace concurrency while the stress
test is running in the background.

However, as the balance and the replace operation are mutually
exclusive, so they can never run concurrently.

So long this test case is showed successful because the btrfs replace's
return error was captured only into seqfull.out.

 ERROR: ioctl(DEV_REPLACE_START) '/mnt/scratch': add/delete/balance/replace/resize operation in progress

Reported-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/064     | 105 --------------------------------------------
 tests/btrfs/064.out |   2 -
 2 files changed, 107 deletions(-)
 delete mode 100755 tests/btrfs/064
 delete mode 100644 tests/btrfs/064.out

diff --git a/tests/btrfs/064 b/tests/btrfs/064
deleted file mode 100755
index 683a69f113bf..000000000000
--- a/tests/btrfs/064
+++ /dev/null
@@ -1,105 +0,0 @@
-#! /bin/bash
-# SPDX-License-Identifier: GPL-2.0
-# Copyright (C) 2014 Red Hat Inc. All rights reserved.
-#
-# FSQA Test No. btrfs/064
-#
-# Run btrfs balance and replace operations simultaneously with fsstress
-# running in background.
-#
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
-
-here=`pwd`
-tmp=/tmp/$$
-status=1
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
-_cleanup()
-{
-	cd /
-	rm -f $tmp.*
-}
-
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
-
-# real QA test starts here
-_supported_fs btrfs
-# we check scratch dev after each loop
-_require_scratch_nocheck
-_require_scratch_dev_pool 5
-_require_scratch_dev_pool_equal_size
-_btrfs_get_profile_configs replace
-
-rm -f $seqres.full
-
-run_test()
-{
-	local mkfs_opts=$1
-	local saved_scratch_dev_pool=$SCRATCH_DEV_POOL
-
-	echo "Test $mkfs_opts" >>$seqres.full
-
-	# remove the last device from the SCRATCH_DEV_POOL list so
-	# _scratch_pool_mkfs won't use all devices in pool
-	local last_dev="`echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $NF}'`"
-	SCRATCH_DEV_POOL=`echo $SCRATCH_DEV_POOL | sed -e "s# *$last_dev *##"`
-	_scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
-	# make sure we created btrfs with desired options
-	if [ $? -ne 0 ]; then
-		echo "mkfs $mkfs_opts failed"
-		SCRATCH_DEV_POOL=$saved_scratch_dev_pool
-		return
-	fi
-	_scratch_mount >>$seqres.full 2>&1
-	SCRATCH_DEV_POOL=$saved_scratch_dev_pool
-
-	args=`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d $SCRATCH_MNT/stressdir`
-	echo "Run fsstress $args" >>$seqres.full
-	$FSSTRESS_PROG $args >/dev/null 2>&1 &
-	fsstress_pid=$!
-
-	echo -n "Start balance worker: " >>$seqres.full
-	_btrfs_stress_balance $SCRATCH_MNT >/dev/null 2>&1 &
-	balance_pid=$!
-	echo "$balance_pid" >>$seqres.full
-
-	echo -n "Start replace worker: " >>$seqres.full
-	_btrfs_stress_replace $SCRATCH_MNT >>$seqres.full 2>&1 &
-	replace_pid=$!
-	echo "$replace_pid" >>$seqres.full
-
-	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
-	wait $fsstress_pid
-	kill $balance_pid $replace_pid
-	wait
-	# wait for the balance and replace operations to finish
-	while ps aux | grep "balance start" | grep -qv grep; do
-		sleep 1
-	done
-	while ps aux | grep "replace start" | grep -qv grep; do
-		sleep 1
-	done
-
-	echo "Scrub the filesystem" >>$seqres.full
-	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
-	if [ $? -ne 0 ]; then
-		echo "Scrub find errors in \"$mkfs_opts\" test" | tee -a $seqres.full
-	fi
-
-	_scratch_unmount
-	# we called _require_scratch_nocheck instead of _require_scratch
-	# do check after test for each profile config
-	_check_scratch_fs
-}
-
-echo "Silence is golden"
-for t in "${_btrfs_profile_configs[@]}"; do
-	run_test "$t"
-done
-
-status=0
-exit
diff --git a/tests/btrfs/064.out b/tests/btrfs/064.out
deleted file mode 100644
index d90765460090..000000000000
--- a/tests/btrfs/064.out
+++ /dev/null
@@ -1,2 +0,0 @@
-QA output created by 064
-Silence is golden
-- 
2.25.1

