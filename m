Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252EA36D432
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Apr 2021 10:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237400AbhD1IrF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Apr 2021 04:47:05 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:48814 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237167AbhD1IrF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Apr 2021 04:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619599581; x=1651135581;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8AeVQ3oUpDhXYLozY6aAJ4OC014yg/1CUL6MaMFNYE0=;
  b=J+xfutdbT6ec7Pmbf/UFCsghG2zQQlyRWJi6rT4W0rJ3Cz3gJ/UxZ6ul
   jyTmh4VRIew3QMZCf9mueDD04H2LUybRkxSLdCHZK2mbgocsXn+aZjvtH
   MADX5p1ndFN5m03+ZBPthmPiea33R70SImsFOEtaBtQ06OjHupVcs1Pvk
   FU4C/3HfCS99Uc+nZ0wUgKEKxkAykEn3J5jSbiz5NT5GgUr1WyJ1vkHup
   tK/2OvMuSeeXnO44JDufBc+OugmtTsSveAjEVWDNR9lfpDj6WLY0Zlmct
   Whgd88eU9ICWR6ambUvelBgqFil5bgHKw2AmuatJaET3LolM14efT6mXF
   w==;
IronPort-SDR: Qp9r5ik2TD2G61p+pHSxxPyZZHcO8NU8qM5qekgTfaHNgLtrutjW7ABhLK/i1l2qzCSYkFK0L4
 WaJ9AkM5cyU5OfIXOyaZ97+2jMRVz+LOATbv2uV2ri/LX6X66e8vzztT8fAgeLHKYkHJ5i/Ge8
 3cA0bK0CcP/T+MzkrAgiRdZIqJ4/U8bHpDbWlWDZ2OlrlyDNGDg6JYP/oixhwTA0iYxOCr8J4R
 neJNTk9aAwj5hjQsZESn7XTALs7n7f6rV7Cvp3rqFys2zQtcZBFXZyJsSue+/QyjpTUcDYJBAx
 yV0=
X-IronPort-AV: E=Sophos;i="5.82,257,1613404800"; 
   d="scan'208";a="167061150"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2021 16:46:21 +0800
IronPort-SDR: fADd4VBwlLKF4fCls7JKkjdMBja4bRjGaCA9OnPGi8Tl3ivciQlEG50B+ytW/AHa7BqdUh5Ahn
 SRlHV79QVmiPLWFFbVIezu40jIJokT4asvL3F/F9vWi9nk+W9uqMVEvtJBEmr6OafD0AqumNlF
 rvtgfC6NgW9VT1TifhyCCqB+gnhOBGbyWx2b/tjm3PT31gTlrxxZ2M3NPk8LkOTdKHwKw2YTw+
 LPMmcSvm8WqHThX9w7Xz2vg+bdIOPoz7ujph7P3HOndcEWlB4v8swti9yf4RkIFIQpj24tIz2J
 gVM32dfsChj5fc9okOPwMgji
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2021 01:26:41 -0700
IronPort-SDR: sHdYZLBh04hKMNowN5NcFtqJ0Bdj9VZ+mPIca+hY7I14lbdyapZy/DoeOvnK/HTWdhVEGwLKIO
 EvAVQQne/xiJnZGvCC93Uw9DQXwIyFP/HJ7GyldLgvKq//ax/xeQwxmQNJA0jQxTfkdSMiCz8m
 vKsXtwCMNW6ULN2KxI/GJG6HSaazU8zMN5LKlKPeVPNZ5t9JtO3N65KRbic2RGbOg7qI7rxm+I
 sfaEbQSvkMkSQQSklpwPz4Up90Wid/ZuDBcInBnmBohP2n5qeFgVYgFghS946sKRatsOHlTNIR
 UUo=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Apr 2021 01:46:21 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Eryu Guan <guan@eryu.me>, linux-btrfs@vger.kernel.org
Cc:     fstests@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 2/2] btrfs: add test for zone auto reclaim
Date:   Wed, 28 Apr 2021 17:46:08 +0900
Message-Id: <20210428084608.21213-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210428084608.21213-1-johannes.thumshirn@wdc.com>
References: <20210428084608.21213-1-johannes.thumshirn@wdc.com>
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
index 000000000000..3be74196ec5d
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
+_scratch_mount -o commit=5 # 5s commit time to speed up test
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
+sleep 5 # need to make sure the transaction got committed
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
+sleep 10 # 1 transaction commit for 'rm' and one for balance
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
2.31.1

