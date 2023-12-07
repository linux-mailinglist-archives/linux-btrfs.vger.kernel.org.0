Return-Path: <linux-btrfs+bounces-741-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DB28083C4
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Dec 2023 10:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4C0A1F22748
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Dec 2023 09:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47419341BB;
	Thu,  7 Dec 2023 09:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NE9AY+Xs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E60137;
	Thu,  7 Dec 2023 01:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701939821; x=1733475821;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=t8dCyWWC7xAZUQhzWr4IjVYXy3dHXATj5/yYhqVe9mA=;
  b=NE9AY+Xs+W89v54+399L64nf9KM5dsaNI2Zu4Z/ZIP3GG5Lq1DvFDGv2
   b6eAACAJ77gvPTQ/Li3VH0cOil3agekFkCg3WIqWNeON0C1Ljc+KJ/2fd
   tmOMuKUxEOHgSR82qQIv++m6DouELJ/v0gMimFdTFcjtKbfyJJSZw67OM
   4iyCy9a1SGcSjh2/kuMkQ6zUCcTtLwENhZ+MMjsBweRBCDpcjYkXkbnZS
   R0DZ9J0f5SJrKrRLLWj9knACpgFEn/FDDGE+0iOJLkBijAbEfEYr6vhNa
   xzt2YsfqQDa7HHNIyia8PXIJvZSktzptrKfVQksB52Af9fRovZ3P3d3+C
   g==;
X-CSE-ConnectionGUID: lv0PElHKQJKFcI0pXFrZHg==
X-CSE-MsgGUID: JTCf0ALvT2OVktNFOKf9dw==
X-IronPort-AV: E=Sophos;i="6.04,256,1695657600"; 
   d="scan'208";a="4272781"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Dec 2023 17:03:41 +0800
IronPort-SDR: tKnmhdZ/kgimG3ETGV94k+fapamnJM5itkyAEMqAyzWajA88FQb6uTFWf0LnShqJMNnUCVWp2j
 niL7KvoWVJHA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Dec 2023 00:14:41 -0800
IronPort-SDR: idUsRYYqEyfPx+QJpW2xBkYfhwxctvyD09jkLxxqwCntwiT5D6qivk9Pjg1e1uKkGFDlhsz3cx
 3kTFM20uJ3IQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Dec 2023 01:03:40 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Thu, 07 Dec 2023 01:03:33 -0800
Subject: [PATCH v5 6/9] btrfs: add fstest for 8k write spanning two stripes
 on raid-stripe-tree
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231207-btrfs-raid-v5-6-44aa1affe856@wdc.com>
References: <20231207-btrfs-raid-v5-0-44aa1affe856@wdc.com>
In-Reply-To: <20231207-btrfs-raid-v5-0-44aa1affe856@wdc.com>
To: Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>
Cc: Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701939810; l=5710;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=t8dCyWWC7xAZUQhzWr4IjVYXy3dHXATj5/yYhqVe9mA=;
 b=BhUr8u/ISEzj3RQfDrUSLHOT1At1WA7m+HobFrYBoeBE/LlfnIkbvg3JyNDHLsN1lqeXSiCd1
 Qq3nSxf7lfCCFPgcw2huVicvdMQfIFPO8OYxxORcLXIh62P6I459B/o
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Add a test-case writing 8k to a raid-stripe-tree formatted filesystem with
one stripe pre-filled to 60k so the 8k are split into a 4k write finishing
stripe 1 and a 4k write starting the next stripe.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 tests/btrfs/305     | 61 +++++++++++++++++++++++++++++++++++++++
 tests/btrfs/305.out | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 143 insertions(+)

diff --git a/tests/btrfs/305 b/tests/btrfs/305
new file mode 100755
index 000000000000..df8a12ab9a6a
--- /dev/null
+++ b/tests/btrfs/305
@@ -0,0 +1,61 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 Western Digital Cooperation.  All Rights Reserved.
+#
+# FS QA Test 305
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
+_require_btrfs_fs_feature "free_space_tree"
+_require_btrfs_free_space_tree
+_require_btrfs_no_compress
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


