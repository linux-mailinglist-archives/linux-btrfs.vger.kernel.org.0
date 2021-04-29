Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4F936EAA9
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Apr 2021 14:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236754AbhD2MkU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Apr 2021 08:40:20 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:45888 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236938AbhD2MkS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Apr 2021 08:40:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619699971; x=1651235971;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vxaPir7928BbUOJiKHU92zkPE8Em9pMKzb1hQ4ncNFI=;
  b=M+nNjSgv5ULGNE7xpgJGzaQy32WFILpGVdu2DAogbcFMJrAWns6xzL+F
   b4cbE5kXJU/JVKKE4pBGJNo+tlM/Q2l5g46CJvx5z3BlsKCd29SZLT5aq
   yjvA5PnRDC6xmCUE6+DUY//yltV1ZPt83gPcxkiCalsDQC/5oKxD1r7ih
   xQp6XNfuRf8IJnu0MmqRBvKhM+FJ+d3P6lu3NGGqiPEqPXgwUwx/nBBxM
   YLtBh1pyau2e0vJB+IoDY0jyJetIan1nfklsGWC3SCtCIJ45n/fEwAmXa
   zjmYuQIusTfnCbg6krdOoXmGTg38QPA30bk0xVul5XfthUVKrPse8iX5W
   g==;
IronPort-SDR: sf69dRsK5QbjXSZyMo2pj0XtM5CyRJfJ31mO/nxXpDSHmrSmRuULmMA3XExBeg5Eaj3ka1OmHp
 SKOG7jzn0FXUiWmJsTuWJAJ7T5ImKBmTk6deqhjaqnvPVM8ECs3bwl4nDi1vxfmNxERVk89rAM
 nEo+232Elyk+fhweFaL8tlntMsTpvu0aFLVtVouGDj8jZEBLCJahsB5MDkaM4h39kNKYdKMfc4
 brt3SKlK9B3ttCvsOKXmXenRRNJ4ZZ5K1Pd/xug5EsiFvfflMklJzeGB8c1Q/beiPdGHGISZjT
 lT8=
X-IronPort-AV: E=Sophos;i="5.82,259,1613404800"; 
   d="scan'208";a="171197737"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2021 20:39:31 +0800
IronPort-SDR: IOrvMcEPRys3xe4qgaaO/v2SYb9xvqfP0USz7zi/Yn/Pmz88nxImhX4D4MSKP2mEKjR4bLt2lJ
 n7YBmQ+sbKCHUR0KNVfMt5ivZCKN4FDF0Huv3VXgar1ZKK1Lg4UGkRBKwU9NHiDMLzxtxLoFj3
 u9bnytUjR528zHqoa7agVITF9FF5BvXxoW5PQt+1rGwwN58Gva5oMNJPqupLtIrjaTexq/b++4
 TpVXmtBdIwT+fnaqzJ6hbcfZEd+L8qXxVWZ30+IsyBJkdptfus8rAsMHfx/5UVtKLHPBX0Hbkv
 eJv2PuOtiWnEnFCyYbr0acAC
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 05:19:50 -0700
IronPort-SDR: EZ1IvEt/OeYAudlXOXcbJ63XhNThrKhmhzLzRgfX4pdUePXVwSR9HR2ivcHUS5bHBEYOV7PuyF
 Xxm1CuWYa+RVvx5/VHlkJoVrr97Uzvf3/NIdK/1HByiH1rIOvUhG1hlpB30VagchvnY8jgbZJf
 ry3EbxqXDx0HmHfm4lAjbGmuDpJ7cusN7BHHg0QyBEIHesU0Iwj9/uD4G6oMnkwNeWuTe+gQSu
 6nzdex/ftapMe09suly/Qqc6hELjZ9dVCJQkNLLeCkgN99rESKK9k4zQoLK6YJq4Jvb1j5Haxx
 ldg=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Apr 2021 05:39:32 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Eryu Guan <guan@eryu.me>, linux-btrfs@vger.kernel.org
Cc:     fstests@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 2/2] btrfs: add test for zone auto reclaim
Date:   Thu, 29 Apr 2021 21:39:27 +0900
Message-Id: <20210429123927.11778-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210429123927.11778-1-johannes.thumshirn@wdc.com>
References: <20210429123927.11778-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a test for commit 18bb8bbf13c1 ("btrfs: zoned: automatically reclaim
zones").

This test creates a two file on a newly created FS in a way that when we
delete the first one, an auto reclaim process will be triggered by the FS.

After the reclaim process, it verifies that the data was moved to another
zone and old zone was successfully reset.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 common/config       |   1 +
 tests/btrfs/236     | 103 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/236.out |   2 +
 tests/btrfs/group   |   1 +
 4 files changed, 107 insertions(+)
 create mode 100755 tests/btrfs/236
 create mode 100644 tests/btrfs/236.out

diff --git a/common/config b/common/config
index a47e462c7792..1a26934985dd 100644
--- a/common/config
+++ b/common/config
@@ -226,6 +226,7 @@ export FSVERITY_PROG="$(type -P fsverity)"
 export OPENSSL_PROG="$(type -P openssl)"
 export ACCTON_PROG="$(type -P accton)"
 export E2IMAGE_PROG="$(type -P e2image)"
+export BLKZONE_PROG="$(type -P blkzone)"
 
 # use 'udevadm settle' or 'udevsettle' to wait for lv to be settled.
 # newer systems have udevadm command but older systems like RHEL5 don't.
diff --git a/tests/btrfs/236 b/tests/btrfs/236
new file mode 100755
index 000000000000..a96665183a84
--- /dev/null
+++ b/tests/btrfs/236
@@ -0,0 +1,103 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 Western Digital Corporation.  All Rights Reserved.
+#
+# FS QA Test 236
+#
+# Test that zone autoreclaim works as expected, that is: if the dirty
+# threshold is exceeded the data gets relocated to new block group and the
+# old block group gets deleted. On block group deletion, the underlying device
+# zone also needs to be reset.
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
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+_supported_fs btrfs
+_require_scratch
+_require_btrfs_command inspect-internal dump-tree
+_require_btrfs_command filesystem sync
+_require_command "$BLKZONE_PROG" blkzone
+_require_zoned_device "$SCRATCH_DEV"
+
+get_data_bg()
+{
+	$BTRFS_UTIL_PROG inspect-internal dump-tree -t CHUNK $SCRATCH_DEV |\
+		grep -A 1 "CHUNK_ITEM" | grep -B 1 "type DATA" |\
+		grep -Eo "CHUNK_ITEM [[:digit:]]+" | cut -d ' ' -f 2
+}
+
+zonesize=$(cat /sys/block/$(_short_dev $SCRATCH_DEV)/queue/chunk_sectors)
+zonesize=$((zonesize << 9))
+
+_scratch_mkfs >/dev/null 2>&1
+_scratch_mount -o commit=1 # 1s commit time to speed up test
+
+uuid=$(findmnt -n -o UUID "$SCRATCH_MNT")
+reclaim_threshold=75
+echo $reclaim_threshold > /sys/fs/btrfs/"$uuid"/bg_reclaim_threshold
+fill_percent=$((reclaim_threshold + 2))
+rest_percent=$((90 - fill_percent)) # make sure we're not creating a new BG
+fill_size=$((zonesize * fill_percent / 100))
+rest=$((zonesize * rest_percent / 100))
+
+# step 1, fill FS over $fillsize
+$XFS_IO_PROG -fc "pwrite 0 $fill_size" $SCRATCH_MNT/$seq.test1 >> $seqres.full
+$XFS_IO_PROG -fc "pwrite 0 $rest" $SCRATCH_MNT/$seq.test2 >> $seqres.full
+$BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT
+
+zones_before=$($BLKZONE_PROG report $SCRATCH_DEV | grep -v -e em -e nw | wc -l)
+echo "Before reclaim: $zones_before zones open" >> $seqres.full
+old_data_zone=$(get_data_bg)
+old_data_zone=$((old_data_zone >> 9))
+printf "Old data zone 0x%x\n" $old_data_zone >> $seqres.full
+
+# step 2, delete the 1st $fill_size sized file to trigger reclaim
+rm $SCRATCH_MNT/$seq.test1
+$BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT
+sleep 2 # 1 transaction commit for 'rm' and 1 for balance
+
+# check that we don't have more zones open than before
+zones_after=$($BLKZONE_PROG report $SCRATCH_DEV | grep -v -e em -e nw | wc -l)
+echo "After reclaim: $zones_after zones open" >> $seqres.full
+
+# Check that old data zone was reset
+old_wptr=$($BLKZONE_PROG report -o $old_data_zone -c 1 $SCRATCH_DEV |\
+	grep -Eo "wptr 0x[[:xdigit:]]+" | cut -d ' ' -f 2)
+if [ "$old_wptr" != "0x000000" ]; then
+	_fail "Old wptr still at $old_wptr"
+fi
+
+new_data_zone=$(get_data_bg)
+new_data_zone=$((new_data_zone >> 9))
+printf "New data zone 0x%x\n" $new_data_zone >> $seqres.full
+
+# Check that data was really relocated to a different zone
+if [ $old_data_zone -eq $new_data_zone ]; then
+	echo "New zone same as old zone"
+fi
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/btrfs/236.out b/tests/btrfs/236.out
new file mode 100644
index 000000000000..b6b6e0cad9a7
--- /dev/null
+++ b/tests/btrfs/236.out
@@ -0,0 +1,2 @@
+QA output created by 236
+Silence is golden
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 331dd432fac3..62c9c761e974 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -238,3 +238,4 @@
 233 auto quick subvolume
 234 auto quick compress rw
 235 auto quick send
+236 auto quick balance
-- 
2.31.1

