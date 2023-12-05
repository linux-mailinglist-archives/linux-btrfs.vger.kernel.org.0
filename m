Return-Path: <linux-btrfs+bounces-662-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A50F0805B4E
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 18:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6DC61C2105E
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 17:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE0768B8C;
	Tue,  5 Dec 2023 17:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ODZIjeHt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC2A122;
	Tue,  5 Dec 2023 09:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701798428; x=1733334428;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=t25s7OpZGFDlhQFDfE919RsW2ZGCcg2o6K96+AfSesU=;
  b=ODZIjeHtBnDLKImdM0CXCHGgDkDBkCc1fwjh2T4M65zabtbtZQqOlrmk
   gro0nN9Yu9Qlpch+Imxm1RlEEFGQi0b9gg41ogP6xvYo7f5d5ee78wpvu
   6mMpG8Z/7F0nry+08NjtgO5EEj3OXT8gJf+RPDAJ2FRrWVqzbG7/EetEP
   owd6NMQNy0IRMFMKwnbYbugja0+AqmrUH4F4TSdAUN+OSMalxmBLlmCt6
   OHONJEnHHpRWzbUwy31m6J1Krg+5lO7d7HfjMbAVf+tRo2i55ml/re+vK
   EMiAfzS26wejtBWs6+sZHGaLSaBJPWAxmJhJ8GqaQc31+BEKMz6Z0QF9C
   Q==;
X-CSE-ConnectionGUID: EBiPorKQR8SQxahd+8fRQw==
X-CSE-MsgGUID: tNVPaMLKTLWCp/WU2rnuSA==
X-IronPort-AV: E=Sophos;i="6.04,252,1695657600"; 
   d="scan'208";a="3944962"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Dec 2023 01:47:08 +0800
IronPort-SDR: MNknaOVLKWoyJP8ZTn8ytxOLY+aK7vFzXf/ZNx1fiJvQ5JjLj1lEnwQvbT171OpVCKQF+sxiyu
 Mss+LKhlCibg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Dec 2023 08:52:29 -0800
IronPort-SDR: 9+NspR7ZgmWWft8woZORUC+qd5Mwm1zM6rwHUK28cYucZZ2h3qWKz+C2a2gA56Smvc5ZsK6ybm
 +52V7VzIrt9g==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 05 Dec 2023 09:47:08 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Tue, 05 Dec 2023 09:47:04 -0800
Subject: [PATCH v3 4/7] btrfs: add fstest for 8k write spanning two stripes
 on raid-stripe-tree
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-btrfs-raid-v3-4-0e857a5439a2@wdc.com>
References: <20231205-btrfs-raid-v3-0-0e857a5439a2@wdc.com>
In-Reply-To: <20231205-btrfs-raid-v3-0-0e857a5439a2@wdc.com>
To: Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>
Cc: Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701798423; l=5600;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=t25s7OpZGFDlhQFDfE919RsW2ZGCcg2o6K96+AfSesU=;
 b=hc1J/3860CXff3qv4CID4HClxQTPMSlXm/CnK9It+zt3g9sgJOUwnMuRLoQ8oc3md/RsKID7v
 nR44/rqHoXQDiuLwBlwIp42VHbkmqWQcbsKrgCXLLVsGAcFQjP6nbvY
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Add a test-case writing 8k to a raid-stripe-tree formatted filesystem with
one stripe pre-filled to 60k so the 8k are split into a 4k write finishing
stripe 1 and a 4k write starting the next stripe.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 tests/btrfs/305     | 58 +++++++++++++++++++++++++++++++++++++
 tests/btrfs/305.out | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 140 insertions(+)

diff --git a/tests/btrfs/305 b/tests/btrfs/305
new file mode 100755
index 000000000000..db449167a58e
--- /dev/null
+++ b/tests/btrfs/305
@@ -0,0 +1,58 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 Western Digital Cooperation.  All Rights Reserved.
+#
+# FS QA Test 303
+#
+# Test on-disk layout of RAID Stripe Tree Metadata by writing 8k to a new file
+# with a filesystem prepropulated, so that 4k of the write are written to the
+# 1st stripe and 4k start a new stripe.
+#
+. ./common/preamble
+_begin_fstest auto quick raid remount volume raid-stripe-tree
+
+. ./common/filter
+. ./common/filter.btrfs
+
+_supported_fs btrfs
+_require_btrfs_command inspect-internal dump-tree
+_require_btrfs_mkfs_feature "raid-stripe-tree"
+_require_scratch_dev_pool 4
+_require_btrfs_fs_feature "raid_stripe_tree"
+
+test_8k_new_stripe()
+{
+	local profile=$1
+	local ndevs=$2
+
+	_scratch_dev_pool_get $ndevs
+
+	echo "==== Testing $profile ===="
+	_scratch_pool_mkfs -d $profile -m $profile -O raid-stripe-tree
+	_scratch_mount
+
+	# Fill the first stripe up to 64k - 4k
+	$XFS_IO_PROG -fc "pwrite 0 60k" -c fsync "$SCRATCH_MNT/bar" | _filter_xfs_io
+
+	# The actual 8k write
+	$XFS_IO_PROG -fc "pwrite 0 8k" "$SCRATCH_MNT/foo" | _filter_xfs_io
+
+	_scratch_cycle_mount
+	md5sum "$SCRATCH_MNT/foo" | _filter_scratch
+
+	_scratch_unmount
+
+	$BTRFS_UTIL_PROG inspect-internal dump-tree -t raid_stripe $SCRATCH_DEV_POOL |\
+		_filter_btrfs_version | _filter_stripe_tree
+
+	_scratch_dev_pool_put
+}
+
+echo "= Test 8k write to a new file so that 4k start a new stripe ="
+test_8k_new_stripe raid0 2
+test_8k_new_stripe raid1 2
+test_8k_new_stripe raid10 4
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/305.out b/tests/btrfs/305.out
new file mode 100644
index 000000000000..7460501ef40b
--- /dev/null
+++ b/tests/btrfs/305.out
@@ -0,0 +1,82 @@
+QA output created by 305
+= Test 8k write to a new file so that 4k start a new stripe =
+==== Testing raid0 ====
+wrote 61440/61440 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 8192/8192 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+9d3940adb41dd525e008a847e01b15f4  SCRATCH_MNT/foo
+
+raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0) 
+leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_TREE
+leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
+checksum stored <CHECKSUM>
+checksum calced <CHECKSUM>
+fs uuid <UUID>
+chunk uuid <UUID>
+	item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 24
+			encoding: RAID0
+			stripe 0 devid 1 physical XXXXXXXXX
+	item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 24
+			encoding: RAID0
+			stripe 0 devid 1 physical XXXXXXXXX
+	item 2 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 24
+			encoding: RAID0
+			stripe 0 devid 2 physical XXXXXXXXX
+total bytes XXXXXXXX
+bytes used XXXXXX
+uuid <UUID>
+==== Testing raid1 ====
+wrote 61440/61440 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 8192/8192 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+9d3940adb41dd525e008a847e01b15f4  SCRATCH_MNT/foo
+
+raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0) 
+leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_TREE
+leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
+checksum stored <CHECKSUM>
+checksum calced <CHECKSUM>
+fs uuid <UUID>
+chunk uuid <UUID>
+	item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 40
+			encoding: RAID1
+			stripe 0 devid 1 physical XXXXXXXXX
+			stripe 1 devid 2 physical XXXXXXXXX
+	item 1 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 40
+			encoding: RAID1
+			stripe 0 devid 1 physical XXXXXXXXX
+			stripe 1 devid 2 physical XXXXXXXXX
+total bytes XXXXXXXX
+bytes used XXXXXX
+uuid <UUID>
+==== Testing raid10 ====
+wrote 61440/61440 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 8192/8192 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+9d3940adb41dd525e008a847e01b15f4  SCRATCH_MNT/foo
+
+raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0) 
+leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_TREE
+leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
+checksum stored <CHECKSUM>
+checksum calced <CHECKSUM>
+fs uuid <UUID>
+chunk uuid <UUID>
+	item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 40
+			encoding: RAID10
+			stripe 0 devid 1 physical XXXXXXXXX
+			stripe 1 devid 2 physical XXXXXXXXX
+	item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
+			encoding: RAID10
+			stripe 0 devid 1 physical XXXXXXXXX
+			stripe 1 devid 2 physical XXXXXXXXX
+	item 2 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
+			encoding: RAID10
+			stripe 0 devid 3 physical XXXXXXXXX
+			stripe 1 devid 4 physical XXXXXXXXX
+total bytes XXXXXXXX
+bytes used XXXXXX
+uuid <UUID>

-- 
2.43.0


