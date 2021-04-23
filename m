Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207CE36910E
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Apr 2021 13:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234353AbhDWL1V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Apr 2021 07:27:21 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:21581 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234057AbhDWL1U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Apr 2021 07:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619177204; x=1650713204;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bxiPv/1BNGAdoDbko2VzFXpcz1eDsMxIlem4AaAkOM8=;
  b=iYY+rSanSEPO5j5NC7g+18RzduVWu6enOt6KxHqV4nHML8Lc/CxGgnDm
   EfuWgNr0zqv+FklaqjHrz7jLARZUIYfHx8W8TMwb3JwyqKIyZWajJr/uP
   54tRw5qmGevx0J6C1qZjQ/6M9b7hy2UoiIOMJ40rcA/mIgfL6ibHCVuIG
   V91AKkb133X3quvSFgC++rf981yHmBxpiwcWZgfemFZc2ofQJQM/L88I6
   ZIRCv+vANdIaeoFcqjgCEgwkMsKrLDmFj0srHovYTD5vVdeJIs/C3iA6l
   AaeCF+NHDJF5Qgma8BFIeG0PMzhEttw5Ylg8L9kr103lEWSIuclzlrYKn
   A==;
IronPort-SDR: QaylUxn/kiMFy6haPXb+x4fnK3oxrkfbx6HyRNXOkgYoxmXAP4GTNIlDv5I3N3jf8C0azndyiL
 YmJ5OO7XfATPqcQxQwPRUP/7tPJpCZ9cLroUVz3Xn/SZ5UCcISlsNC8HBQZe/BgY5ZiqBccNeR
 tvGAPse9Pk4CL2dnnVaM7MuksVKzccmNlEnEhrWq6nnDNwg12BfEPu0guaHDPd6mga0gDnqOog
 ISgz7Y6jzsK3FLRzHUFRPqbyURgOvSxs2iWhYwS6JF9ZP9BUmhYIXAkX/B6yWp2FuHsVUS9YEV
 P98=
X-IronPort-AV: E=Sophos;i="5.82,245,1613404800"; 
   d="scan'208";a="165365032"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Apr 2021 19:26:44 +0800
IronPort-SDR: toB5FTCOMNoloflTg9Qm/JpxTTpnzWwLe2nJi8b73HvmGJaxjNwmu6FRf+c3/3970okZT9VqK6
 Lxt3Cc07D+o7kB1qi3iYk2jKI+vndQixeFA/AAj3QRY8lpeS58Ge0YV/enLRNf4RwGGD186IwH
 R7RKwTddVWv6kDcPd5KhWUmoKvm477F9kFh/3pW/TbNGJyr2VcubJWhytC0VDAR+W+m8R5b9pU
 FWyoSs23PbYvBkLBUSnJ/gyfY6QjF35H9Bq3qRhwB6aDTab1lPwgapcSYlYEd/sovEPow1PlTR
 aKJq6xsJtRwzJ2fkTh1c9NMl
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 04:07:18 -0700
IronPort-SDR: +uWgW7CzCdFOdTjyT1ynXrt2FLLVoaxrSpoFpxE9UOYhzsF4jKpaMZda5NVr5OnBvmN4/Q3xHn
 HtG+Fj8AcoitDWg3o3031cRkKcjGDlesDt8VpOQvlIxJrvKym04KeucNp1yKMF0EQb+iqdThTw
 BOOtOG/z+71ELOkczm29pomZpZngWMYJk9v2O/PwLQ1/mcO2vxU8dCZA6X6D3Gq4mgP6cHvSWy
 0LGjYtznqV0tJsrj8+0YIskkEByZrkFcyFVInDXLbvPKhNnnJKtL35wjVGdKtyEFKP+BroycTY
 coI=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Apr 2021 04:26:43 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Eryu Guan <guan@eryu.me>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 4/4] btrfs: add test for zone auto reclaim
Date:   Fri, 23 Apr 2021 20:26:34 +0900
Message-Id: <20210423112634.6067-5-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210423112634.6067-1-johannes.thumshirn@wdc.com>
References: <20210423112634.6067-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a test for the patch titled "btrfs: zoned: automatically reclaim
zones".

This test creates a two file on a newly created FS in a way that when we
delete the first one, an auto reclaim process will be triggered by the FS.

After the reclaim process, it verifies that the data was moved to another
zone and old zone was successfully reset.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 common/config       |   1 +
 tests/btrfs/236     | 102 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/236.out |   2 +
 tests/btrfs/group   |   1 +
 4 files changed, 106 insertions(+)
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
index 000000000000..18964699f68e
--- /dev/null
+++ b/tests/btrfs/236
@@ -0,0 +1,102 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 Western Digital Corporation.  All Rights Reserved.
+#
+# FS QA Test 236
+#
+# Test that zone autoreclaim works as expected, that is: if the dirty
+# threashold is exceeded the data gets relocated to new block group and the
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
+_scratch_mount -o commit=5
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
+$XFS_IO_PROG -fdc "pwrite -W 0 $fill_size" $SCRATCH_MNT/$seq.test1 >> $seqres.full
+$XFS_IO_PROG -fdc "pwrite -W 0 $rest" $SCRATCH_MNT/$seq.test2 >> $seqres.full
+sleep 5
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
+sleep 10
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
+	_fail "New zone same as old zone"
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
2.30.0

