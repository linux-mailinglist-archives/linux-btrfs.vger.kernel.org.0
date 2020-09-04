Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C275625D7B6
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Sep 2020 13:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730100AbgIDLpr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Sep 2020 07:45:47 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38993 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729741AbgIDLpp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Sep 2020 07:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599219944; x=1630755944;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OP41+imeDLCrE562RGVpZzj+97bXjqQCfyh9xDQReAA=;
  b=o9Ll4bbFbph+nef6TdqReJ75i9icaJPYlBB0OsQoBw7ZsZVa4/BNfXNi
   QwytPUuEhf6Ue2kG8ys5wtIMs/fa6kfrUd2PK6/TuI+f771rrqulLh1Ph
   1vX11AmtCCODm/MZAc/qyAc0jg5qeq+pOJV6naK/DVcH69fpIEmvNojTG
   TOKr63+vXvGrE6qAxGpoiiaRRAFFLbeSy4tawY0OyVyPcFVt6f4fQ+uA6
   r/ddicvZbHWxgS2w9hfZjOR68hocZ5S4kevvJ0OHw6gXM75hYbrGtHsUN
   b5afEKfIvU/PCi1MeC8guTKYtmL2T/+lfpwg6bSp59tyZzbjbz4VMJqXM
   w==;
IronPort-SDR: Expvl78z2n1hwLi14H6jjmrGcau17OTMv9c5larTCqNPZzk6pmCy5xsQVlprIzsfy7JF/RS8zX
 4gU+aFKuTWpUylr0XqFWGz6T7pYTLUlli5neDLbzYySMFytuwYnccSTRA50MGGqnBUT1lvE5dh
 At0+njBBu/LS3bQeQUay/7Xf6gylJzXsTIXcfDT/tnrlqnbsOgvHpCzDgnpV87k//XKmr30euj
 xK9lDB92ReOIxkshyd5Du9ak60QpV024Jtw3EfXn/5PVSe0KrzfIiUfX/DT51A4+TY/M6pWbuN
 Gzs=
X-IronPort-AV: E=Sophos;i="5.76,389,1592841600"; 
   d="scan'208";a="146569193"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Sep 2020 19:45:41 +0800
IronPort-SDR: kmfVkvGCfHcA4ontG2bKVHDKWiEKLLisDsPp4KONkPZO48MWOVfacs3qGHBwrrI9df10DteKqm
 TlezdhtLcSTw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 04:32:13 -0700
IronPort-SDR: 4UaQe8xoFL4/1RmcSFNEXdH5hdxAzmEFR6teucEtrX8CxLweWkSFaGoGXQwnE6g6JYRaq9kcs3
 FG1pC6+CGS7Q==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Sep 2020 04:45:39 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs/154: remove test for fix that never landed
Date:   Fri,  4 Sep 2020 20:45:30 +0900
Message-Id: <20200904114530.21746-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The btrfs/154 testcase fails if the kernel patch "btrfs: handle
dynamically reappearing missing device" isn't applied, but this patch was
never merged into the upstream kernel.

Delete the test so we have one less testcase that will always fail.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 tests/btrfs/154     | 169 --------------------------------------------
 tests/btrfs/154.out |  10 ---
 tests/btrfs/group   |   1 -
 3 files changed, 180 deletions(-)
 delete mode 100755 tests/btrfs/154
 delete mode 100644 tests/btrfs/154.out

diff --git a/tests/btrfs/154 b/tests/btrfs/154
deleted file mode 100755
index 321bbee99099..000000000000
--- a/tests/btrfs/154
+++ /dev/null
@@ -1,169 +0,0 @@
-#! /bin/bash
-# SPDX-License-Identifier: GPL-2.0
-# Copyright (c) 2017 Oracle.  All Rights Reserved.
-#
-# FS QA Test 154
-#
-# Test for reappearing missing device functionality.
-#   This test will fail without the btrfs kernel patch
-#   [PATCH] btrfs: handle dynamically reappearing missing device
-#
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
-
-here=`pwd`
-tmp=/tmp/$$
-status=1	# failure is the default!
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
-. ./common/module
-
-# remove previous $seqres.full before test
-rm -f $seqres.full
-
-# real QA test starts here
-
-_supported_fs btrfs
-_supported_os Linux
-_require_scratch_dev_pool 2
-_require_btrfs_forget_or_module_loadable
-
-_scratch_dev_pool_get 2
-
-DEV1=`echo $SCRATCH_DEV_POOL | awk '{print $1}'`
-DEV2=`echo $SCRATCH_DEV_POOL | awk '{print $2}'`
-
-echo DEV1=$DEV1 >> $seqres.full
-echo DEV2=$DEV2 >> $seqres.full
-
-# Balance won't be successful if filled too much
-DEV1_SZ=`blockdev --getsize64 $DEV1`
-DEV2_SZ=`blockdev --getsize64 $DEV2`
-
-# get min
-MAX_FS_SZ=`echo -e "$DEV1_SZ\n$DEV2_SZ" | sort -n | head -1`
-# Need disks with more than 2G
-if [ $MAX_FS_SZ -lt 2000000000 ]; then
-	_scratch_dev_pool_put
-	_notrun "Smallest dev size $MAX_FS_SZ, Need at least 2G"
-fi
-
-MAX_FS_SZ=100000000
-bs="1M"
-COUNT=$(($MAX_FS_SZ / 1000000))
-CHECKPOINT1=0
-CHECKPOINT2=0
-
-setup()
-{
-	echo >> $seqres.full
-	echo "MAX_FS_SZ=$MAX_FS_SZ COUNT=$COUNT" >> $seqres.full
-	echo "setup"
-	echo "-----setup-----" >> $seqres.full
-	_scratch_pool_mkfs "-mraid1 -draid1" >> $seqres.full 2>&1
-	_scratch_mount >> $seqres.full 2>&1
-	dd if=/dev/urandom of="$SCRATCH_MNT"/tf bs=$bs count=1 \
-					>>$seqres.full 2>&1
-	_run_btrfs_util_prog filesystem show -m ${SCRATCH_MNT}
-	_run_btrfs_util_prog filesystem df $SCRATCH_MNT
-	COUNT=$(( $COUNT - 1 ))
-	echo "unmount" >> $seqres.full
-	_scratch_unmount
-}
-
-degrade_mount_write()
-{
-	echo >> $seqres.full
-	echo "--degraded mount: max_fs_sz $max_fs_sz bytes--" >> $seqres.full
-	echo
-	echo "degraded mount"
-
-	echo "clean btrfs ko" >> $seqres.full
-	# un-scan the btrfs devices
-	_btrfs_forget_or_module_reload
-	_mount -o degraded $DEV1 $SCRATCH_MNT >>$seqres.full 2>&1
-	cnt=$(( $COUNT/10 ))
-	dd if=/dev/urandom of="$SCRATCH_MNT"/tf1 bs=$bs count=$cnt \
-					>>$seqres.full 2>&1
-	COUNT=$(( $COUNT - $cnt ))
-	_run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
-	_run_btrfs_util_prog filesystem df $SCRATCH_MNT
-	CHECKPOINT1=`md5sum $SCRATCH_MNT/tf1`
-	echo $SCRATCH_MNT/tf1:$CHECKPOINT1 >> $seqres.full
-}
-
-scan_missing_dev_and_write()
-{
-	echo >> $seqres.full
-	echo "--scan missing $DEV2--" >> $seqres.full
-	echo
-	echo "scan missing dev and write"
-
-	_run_btrfs_util_prog device scan $DEV2
-
-	echo >> $seqres.full
-
-	_run_btrfs_util_prog filesystem show -m ${SCRATCH_MNT}
-	_run_btrfs_util_prog filesystem df ${SCRATCH_MNT}
-
-	dd if=/dev/urandom of="$SCRATCH_MNT"/tf2 bs=$bs count=$COUNT \
-						>>$seqres.full 2>&1
-	CHECKPOINT2=`md5sum $SCRATCH_MNT/tf2`
-	echo $SCRATCH_MNT/tf2:$CHECKPOINT2 >> $seqres.full
-}
-
-balance_convert()
-{
-	echo >> $seqres.full
-	echo "----- run balance -----" >> $seqres.full
-	echo
-	echo "run balance"
-
-	_run_btrfs_balance_start -dconvert=raid1 \
-				 -mconvert=raid1 $SCRATCH_MNT >> $seqres.full
-}
-
-verify()
-{
-	echo >> $seqres.full
-	echo "--mount reconstructed dev only and check md5sum--" >> $seqres.full
-	echo
-	echo "mount reconstructed dev only and check md5sum"
-	echo "unmount" >> $seqres.full
-
-	_scratch_unmount
-	_btrfs_forget_or_module_reload
-	_mount -o degraded $DEV2 $SCRATCH_MNT >>$seqres.full 2>&1
-	verify_checkpoint1=`md5sum $SCRATCH_MNT/tf1`
-	verify_checkpoint2=`md5sum $SCRATCH_MNT/tf2`
-
-	if [ "$verify_checkpoint1" != "$CHECKPOINT1" ]; then
-		echo "checkpoint1 on reappeared disk does not match after balance"
-	fi
-
-	if [ "$verify_checkpoint2" != "$CHECKPOINT2" ]; then
-		echo "checkpoint2 on reappeared disk does not match after balance"
-	fi
-}
-
-setup
-degrade_mount_write
-scan_missing_dev_and_write
-balance_convert
-verify
-
-$UMOUNT_PROG $DEV2
-_scratch_dev_pool_put
-
-status=0
-exit
diff --git a/tests/btrfs/154.out b/tests/btrfs/154.out
deleted file mode 100644
index 4a4939d448aa..000000000000
--- a/tests/btrfs/154.out
+++ /dev/null
@@ -1,10 +0,0 @@
-QA output created by 154
-setup
-
-degraded mount
-
-scan missing dev and write
-
-run balance
-
-mount reconstructed dev only and check md5sum
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 3295856d0c8c..1016989d4511 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -156,7 +156,6 @@
 151 auto quick volume
 152 auto quick metadata qgroup send
 153 auto quick qgroup limit
-154 auto quick volume balance
 155 auto quick send
 156 auto quick trim balance
 157 auto quick raid
-- 
2.26.2

