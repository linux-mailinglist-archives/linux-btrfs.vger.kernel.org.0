Return-Path: <linux-btrfs+bounces-708-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1206C806CC4
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Dec 2023 11:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA9AF281A5C
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Dec 2023 10:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9448530FBD;
	Wed,  6 Dec 2023 10:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZNRgky0F"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF779C;
	Wed,  6 Dec 2023 02:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701860186; x=1733396186;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=2x2wGtgWmS/xJUHNe4QuZYwvNXtZNE3K89rAEDi8uCQ=;
  b=ZNRgky0FlwFjWjgv1+NDF7Ry4DzzeS7jrFNgxt4PuOsBbLOAFZ1HKyEk
   atQWhSBhLzU8ms3cnbMGNisgFHAzKTbY6JSSrEyuxfMtQR3X6T+8MMo2D
   UTUJ+MO016koQEa3va9JzWpB9ONiFi38PkKpCLXww4085AvE/4B2qzrvT
   SijVNnd2BUjfKO/E28zA0Q3zoD0k7UYk9QyDK1plYj8nStuyR81RN+bmb
   NWylRlZTsjp0I810AI6PZ7knmnGAemTbKT5FIMjS/mIaYIgy2YhdmdVym
   nq6iDuDlMZPLRk/+Y1yfnqHN9Ej5n1q+CyyRiqi5TwCYOlhZISBCWcfH7
   A==;
X-CSE-ConnectionGUID: ev5Wc07YSF2qrLHX6ER1sQ==
X-CSE-MsgGUID: 6av8uyPJQaOzRYQNBE13qw==
X-IronPort-AV: E=Sophos;i="6.04,255,1695657600"; 
   d="scan'208";a="4119718"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Dec 2023 18:56:26 +0800
IronPort-SDR: iAbXdGwhaIvqRAwphro0lL+rovCEQwk9zj1kleK57W+reT9aS8aYxrGkI7TS+gOdyX7KY7ykLm
 ZjuyiDpGEvPw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Dec 2023 02:07:27 -0800
IronPort-SDR: uwK6VOmetSVvPUX17v0hl8j4RilBgZJ1oU3rj8FEfHjuWAsCkXl6CQ8raAFmjZsu1UWKMScgzm
 8QaAw6f45TzQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Dec 2023 02:56:25 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Wed, 06 Dec 2023 02:56:18 -0800
Subject: [PATCH v4 6/8] btrfs: add fstest for writing to a file at an
 offset with RST
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231206-btrfs-raid-v4-6-578284dd3a70@wdc.com>
References: <20231206-btrfs-raid-v4-0-578284dd3a70@wdc.com>
In-Reply-To: <20231206-btrfs-raid-v4-0-578284dd3a70@wdc.com>
To: Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>
Cc: Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701860179; l=5279;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=2x2wGtgWmS/xJUHNe4QuZYwvNXtZNE3K89rAEDi8uCQ=;
 b=RvN2ejfDIODQmTYkJNzlfp/a0c0pEYr8vveVlb6JF1EepEyofOZ9c9IHfVZF6y4HeycuLQruS
 nGVRY17DhMDBSws7c6moOvqIaOMDo1olWkX+Mmd7SlKb9WUH5o9vqtU
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Add a fstest writing 4k at offset 64k to a file with one RAID tripe
already pre-filled for a raid-stripe-tree formatted file system.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 tests/btrfs/306     | 58 +++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/306.out | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 133 insertions(+)

diff --git a/tests/btrfs/306 b/tests/btrfs/306
new file mode 100755
index 000000000000..9bbc1170f7ed
--- /dev/null
+++ b/tests/btrfs/306
@@ -0,0 +1,58 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 Western Digital Cooperation.  All Rights Reserved.
+#
+# FS QA Test 306
+#
+# Test on-disk layout of RAID Stripe Tree Metadata by writing 4k to an emppty
+# file at offset 64k with one stripe pre-filled on an otherwise pristine
+# filesystem.
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
+_require_btrfs_no_compress
+
+test_4k_write_64koff()
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
+	# precondition one stripe
+	$XFS_IO_PROG -fc "pwrite 0 64k" "$SCRATCH_MNT/bar" | _filter_xfs_io
+
+	$XFS_IO_PROG -fc "pwrite 64k 4k" "$SCRATCH_MNT/foo" | _filter_xfs_io
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
+echo "= Test 4k write to an empty file at offset 64k with one stripe prefilled ="
+test_4k_write_64koff raid0 2
+test_4k_write_64koff raid1 2
+test_4k_write_64koff raid10 4
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/306.out b/tests/btrfs/306.out
new file mode 100644
index 000000000000..8031cddb79f7
--- /dev/null
+++ b/tests/btrfs/306.out
@@ -0,0 +1,75 @@
+QA output created by 306
+= Test 4k write to an empty file at offset 64k with one stripe prefilled =
+==== Testing raid0 ====
+wrote 65536/65536 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 4096/4096 bytes at offset 65536
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+381b0e7d72cb4f75286fe2b445e8d92a  SCRATCH_MNT/foo
+
+raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0) 
+leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_TREE
+leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
+checksum stored <CHECKSUM>
+checksum calced <CHECKSUM>
+fs uuid <UUID>
+chunk uuid <UUID>
+	item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 24
+			encoding: RAID0
+			stripe 0 devid 1 physical XXXXXXXXX
+	item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 24
+			encoding: RAID0
+			stripe 0 devid 2 physical XXXXXXXXX
+total bytes XXXXXXXX
+bytes used XXXXXX
+uuid <UUID>
+==== Testing raid1 ====
+wrote 65536/65536 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 4096/4096 bytes at offset 65536
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+381b0e7d72cb4f75286fe2b445e8d92a  SCRATCH_MNT/foo
+
+raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0) 
+leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_TREE
+leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
+checksum stored <CHECKSUM>
+checksum calced <CHECKSUM>
+fs uuid <UUID>
+chunk uuid <UUID>
+	item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 40
+			encoding: RAID1
+			stripe 0 devid 1 physical XXXXXXXXX
+			stripe 1 devid 2 physical XXXXXXXXX
+	item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
+			encoding: RAID1
+			stripe 0 devid 1 physical XXXXXXXXX
+			stripe 1 devid 2 physical XXXXXXXXX
+total bytes XXXXXXXX
+bytes used XXXXXX
+uuid <UUID>
+==== Testing raid10 ====
+wrote 65536/65536 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 4096/4096 bytes at offset 65536
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+381b0e7d72cb4f75286fe2b445e8d92a  SCRATCH_MNT/foo
+
+raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0) 
+leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_TREE
+leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
+checksum stored <CHECKSUM>
+checksum calced <CHECKSUM>
+fs uuid <UUID>
+chunk uuid <UUID>
+	item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 40
+			encoding: RAID10
+			stripe 0 devid 1 physical XXXXXXXXX
+			stripe 1 devid 2 physical XXXXXXXXX
+	item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
+			encoding: RAID10
+			stripe 0 devid 3 physical XXXXXXXXX
+			stripe 1 devid 4 physical XXXXXXXXX
+total bytes XXXXXXXX
+bytes used XXXXXX
+uuid <UUID>

-- 
2.43.0


