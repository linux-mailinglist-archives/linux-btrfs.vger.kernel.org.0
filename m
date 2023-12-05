Return-Path: <linux-btrfs+bounces-634-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6F4805513
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 13:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A52D7B20D88
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 12:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8EC65EB6;
	Tue,  5 Dec 2023 12:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lHqeDWtv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2627120;
	Tue,  5 Dec 2023 04:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701780318; x=1733316318;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=VwXVUK59GoSFm7hUfF/gj25JjQ0QqDyn97ZRS5tO/QU=;
  b=lHqeDWtvpJXyoGojUItXnjQk1ca1/DcWveqgssG3bQTJHgYi9UOQNlKA
   gxTTm0ZJSJKagmwVnXrCzFY6+KMVQoYT7WsemaO9tSmmX7qewqWvN/Mwt
   2kWxxxuZha4X9psGw7HV1v26KWvVoi0oXmQ5+IxU4lnLFJzQ4lVaZj+aF
   2CBNO+CNv6sj09YT0UfVliX8y+GoFr5W9no2QqCaSqnU4U0RwaECyo7B5
   LGYzaVtd5llv6jeCHOykBqsEh/ZZ8mMmWdCf7X91jAndMFukXNJJ+rQf5
   RewHHwSQeAU3RL9CepoP/9NetZHOME8lt4+eci/33NgLuIg5kxzsjG4uO
   g==;
X-CSE-ConnectionGUID: 2x2k0RJIRmiJ1w8R7Bmqqw==
X-CSE-MsgGUID: kNfw3ApYQ1KuoeUZnCRf7Q==
X-IronPort-AV: E=Sophos;i="6.04,252,1695657600"; 
   d="scan'208";a="4043927"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Dec 2023 20:45:18 +0800
IronPort-SDR: tYYCt49v/bAhGQGtya9CmrCZxFCqZEtQaZCn0+lq5/dVdSyi1/YNTWs/ZUJtP3edCjrkURgtFD
 Upy02mqAuvdA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Dec 2023 03:56:20 -0800
IronPort-SDR: ibGTaZuSdryJcTFhqb6nyQp+i8jtsQm5achtRzBLTIgy6wm8u8nKLQIEL2Cpre/eRjioivd2Q0
 wA4W3N0YB4Bw==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 05 Dec 2023 04:45:18 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Tue, 05 Dec 2023 04:45:12 -0800
Subject: [PATCH v2 6/7] btrfs: add fstests to write 128k to a RST
 filesystem
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-btrfs-raid-v2-6-25f80eea345b@wdc.com>
References: <20231205-btrfs-raid-v2-0-25f80eea345b@wdc.com>
In-Reply-To: <20231205-btrfs-raid-v2-0-25f80eea345b@wdc.com>
To: Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>
Cc: Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701780310; l=4423;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=VwXVUK59GoSFm7hUfF/gj25JjQ0QqDyn97ZRS5tO/QU=;
 b=PH35EttU+8i8T8WO3/buW6VxhyZxM+yGR4eLutcq/HMjD+SvyNev4IRwrDATzin4kU7IW/r8o
 HR1fvq9M2/0DwlWNMVv1/gB9q9aGHKVxk4XHw5Bdyzzh0oYxoWtoZ8Z
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Add a test writing 128k to a file on an empty filesystem formatted with a
raid-stripe-tree.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 tests/btrfs/305     | 53 +++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/305.out | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 118 insertions(+)

diff --git a/tests/btrfs/305 b/tests/btrfs/305
new file mode 100755
index 000000000000..362ae1966f4f
--- /dev/null
+++ b/tests/btrfs/305
@@ -0,0 +1,53 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 Western Digital Cooperation.  All Rights Reserved.
+#
+# FS QA Test 305
+#
+# Test on-disk layout of RAID Stripe Tree Metadata by writing 128k to a new
+# file on a pristine filesystem
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
+test_128k_write()
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
+	$XFS_IO_PROG -fc "pwrite 0 128k" "$SCRATCH_MNT/foo" | _filter_xfs_io
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
+echo "= Test 128k write to empty file  ="
+test_128k_write raid0 2
+test_128k_write raid1 2
+test_128k_write raid10 4
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/305.out b/tests/btrfs/305.out
new file mode 100644
index 000000000000..0dbd3beca77f
--- /dev/null
+++ b/tests/btrfs/305.out
@@ -0,0 +1,65 @@
+QA output created by 305
+= Test 128k write to empty file  =
+==== Testing raid0 ====
+wrote 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+d48858312a922db7eb86377f638dbc9f  SCRATCH_MNT/foo
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
+	item 1 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 24
+			encoding: RAID0
+			stripe 0 devid 2 physical XXXXXXXXX
+total bytes XXXXXXXX
+bytes used XXXXXX
+uuid <UUID>
+==== Testing raid1 ====
+wrote 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+d48858312a922db7eb86377f638dbc9f  SCRATCH_MNT/foo
+
+raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0) 
+leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_TREE
+leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
+checksum stored <CHECKSUM>
+checksum calced <CHECKSUM>
+fs uuid <UUID>
+chunk uuid <UUID>
+	item 0 key (XXXXXX RAID_STRIPE 131072) itemoff XXXXX itemsize 40
+			encoding: RAID1
+			stripe 0 devid 1 physical XXXXXXXXX
+			stripe 1 devid 2 physical XXXXXXXXX
+total bytes XXXXXXXX
+bytes used XXXXXX
+uuid <UUID>
+==== Testing raid10 ====
+wrote 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+d48858312a922db7eb86377f638dbc9f  SCRATCH_MNT/foo
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
+	item 1 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 40
+			encoding: RAID10
+			stripe 0 devid 3 physical XXXXXXXXX
+			stripe 1 devid 4 physical XXXXXXXXX
+total bytes XXXXXXXX
+bytes used XXXXXX
+uuid <UUID>

-- 
2.43.0


