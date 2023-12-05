Return-Path: <linux-btrfs+bounces-632-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A40C4805510
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 13:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCD49B20D24
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 12:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F9161FC8;
	Tue,  5 Dec 2023 12:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JsIy9b+j"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CF910F;
	Tue,  5 Dec 2023 04:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701780316; x=1733316316;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=kgKvbSZKh/K3z/aAEwo5FZa/vZnvGjn2gcGXhWOMP9k=;
  b=JsIy9b+j01iX0giqFX7ZsiqFUA/aWqbHwKifx5KVv6UHj2lEEzIUFxz3
   zSNTVU08vmK8k+yRu/kHg1S0iFg966UB2jjLy+XcUU41G/kA6OzdaFZPJ
   qAC9EkdyDOAvsFPrBnlhHl9MMcddSdMvL89cXfP8PFG4o5kY+FlwY+RiS
   fk6AslAvI375ofXi5lLjEwBBr89WXY+rXUZQbPrsZptNvu63Pyhg+paeV
   wKK3HWAx0qphhBzIgWOhCwk5AP6xF7RWkFNLqn6LCeBCmw0jfhLyWuQLb
   SOvraEkMculY0eYxrfNj1mZKhJ4OUguyujsrbo9Hjg8Lxl85cpsXFjvjZ
   w==;
X-CSE-ConnectionGUID: QIdcn4jkSkWOpGFyD4HA2A==
X-CSE-MsgGUID: yM5A6yLhT66w4uIIwEGm2g==
X-IronPort-AV: E=Sophos;i="6.04,252,1695657600"; 
   d="scan'208";a="4043918"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Dec 2023 20:45:16 +0800
IronPort-SDR: qAZO5J7KHWbmklP17wqudcazG9bJT1QIge49VQaZOfwQ/uNncZ3odJH299Mm3oiOZobdfGJIqZ
 xRRVyfyT93bQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Dec 2023 03:56:18 -0800
IronPort-SDR: lcAkGO+bY8hTFLpmA1jLm4b8JYHepYkEsyHC5kEBeDFYfZC+RlnsDB7zp/U3njeA/Yfauw2aBs
 jc6Ow/YLDqWQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 05 Dec 2023 04:45:16 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Tue, 05 Dec 2023 04:45:10 -0800
Subject: [PATCH v2 4/7] btrfs: add fstest for 8k write spanning two stripes
 on raid-stripe-tree
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-btrfs-raid-v2-4-25f80eea345b@wdc.com>
References: <20231205-btrfs-raid-v2-0-25f80eea345b@wdc.com>
In-Reply-To: <20231205-btrfs-raid-v2-0-25f80eea345b@wdc.com>
To: Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>
Cc: Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701780310; l=5580;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=kgKvbSZKh/K3z/aAEwo5FZa/vZnvGjn2gcGXhWOMP9k=;
 b=h6XpaY0iVO+Crg44FNOyGzWkTT0BLA7kj8NeGAu1sN4+cV0o+weYwZ0KH/keVHVkDmYfHRY5k
 74xD7fJgTRhAuH53hqEnyTOGZrQIMSA64YqmLpTa3P+m7ObwFkRX5ik
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Add a test-case writing 8k to a raid-stripe-tree formatted filesystem with
one stripe pre-filled to 60k so the 8k are split into a 4k write finishing
stripe 1 and a 4k write starting the next stripe.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 tests/btrfs/303     | 58 +++++++++++++++++++++++++++++++++++++
 tests/btrfs/303.out | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 140 insertions(+)

diff --git a/tests/btrfs/303 b/tests/btrfs/303
new file mode 100755
index 000000000000..9f3a5df16423
--- /dev/null
+++ b/tests/btrfs/303
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
+	_scratch_pool_mkfs -d $profile -m $profile
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
diff --git a/tests/btrfs/303.out b/tests/btrfs/303.out
new file mode 100644
index 000000000000..1259d0f4a587
--- /dev/null
+++ b/tests/btrfs/303.out
@@ -0,0 +1,82 @@
+QA output created by 303
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


