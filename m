Return-Path: <linux-btrfs+bounces-710-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D9C806CC7
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Dec 2023 11:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 068161C20996
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Dec 2023 10:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41D6315AF;
	Wed,  6 Dec 2023 10:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CFAP7ONl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D9812B;
	Wed,  6 Dec 2023 02:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701860188; x=1733396188;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=MJZC83rDWYcbfUlPKVg8Wc0vqsaklNBLXvL1F+kDsIs=;
  b=CFAP7ONloMqydYSDctTUU/bJQsMvVbDxW2SeHTQtuoXe/LwiQp3o2qOq
   C48GVLmLW+OA1rXfn7CvqBI2808KZl9mU1kG7S3W4DvYB/+WOhjOkutF8
   hAkw4KBK7I6ENLHFzHcVIuDHn98nP5P7fpVMCG+LbKBjQgN+d3B7uTF85
   0dTc0L8y7aKXW+aUYjMvv3XZCZWsD6AihWN69EevvetcRG2td8DREVQif
   TeXVgG6dMeCin3l6QewoCGHuGKc+gSJStgQgCs08nreY1Nbg8Y+YUQxHs
   JQIqjCuyItOipdx+ES32yLm47eAGbxTLAVMy9L4HUX7Q+/1dOgzjD9aMO
   w==;
X-CSE-ConnectionGUID: 903NSeM6SueSJiMRDOMG+g==
X-CSE-MsgGUID: rUH+h8C5QFiShHShFZ0LRw==
X-IronPort-AV: E=Sophos;i="6.04,255,1695657600"; 
   d="scan'208";a="4119721"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Dec 2023 18:56:28 +0800
IronPort-SDR: y9WRCkjOMJ2P3vGj5spGskUzqr7mIsU7CTQkW7cCjuyjcGRtJsDPtLRvr/OMoYympLIted4NeZ
 unUcd3AQTToQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Dec 2023 02:07:29 -0800
IronPort-SDR: EVun0atj9iUgXPMPfl9ObG5qXG3Xh3B5+6bl7OcnYQVCeehV54Vx4ZZlKiV2wR2LaiROOnTQDw
 IhyMOSLQiyGg==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Dec 2023 02:56:27 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Wed, 06 Dec 2023 02:56:20 -0800
Subject: [PATCH v4 8/8] btrfs: add fstest for overwriting a file partially
 with RST
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231206-btrfs-raid-v4-8-578284dd3a70@wdc.com>
References: <20231206-btrfs-raid-v4-0-578284dd3a70@wdc.com>
In-Reply-To: <20231206-btrfs-raid-v4-0-578284dd3a70@wdc.com>
To: Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>
Cc: Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701860179; l=6792;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=MJZC83rDWYcbfUlPKVg8Wc0vqsaklNBLXvL1F+kDsIs=;
 b=GuVSXJKMO5bN+hVMYj0/FdcQZyz4XmtzPp8j2kuuB4doRe2lBv7AnLfqaTmP1K94IWOnZUiQD
 YFY3Gyhu6EUAVQ7WUKTU1L8CIV/HLlyvWg8/fKLzfT7+jrxxucFJuwO
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Add a test writing 128k to an empty file with one stripe already
pre-filled on-disk. Then overwrite a portion of the file in the middle.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 tests/btrfs/308     |  59 +++++++++++++++++++++++++++++
 tests/btrfs/308.out | 106 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 165 insertions(+)

diff --git a/tests/btrfs/308 b/tests/btrfs/308
new file mode 100755
index 000000000000..5f9cc183c5ec
--- /dev/null
+++ b/tests/btrfs/308
@@ -0,0 +1,59 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 Western Digital Cooperation.  All Rights Reserved.
+#
+# FS QA Test 308
+#
+# Test on-disk layout of RAID Stripe Tree Metadata by writing 128k to an empty
+# file on a filesystem that has one stripe already pre-filled. Afterwards
+# overwrite a portion of the file.
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
+_require_btrfs_no_nodatacow
+
+test_128k_write_overwrite()
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
+	$XFS_IO_PROG -fc "pwrite -W 0 32k" "$SCRATCH_MNT/bar" | _filter_xfs_io
+	$XFS_IO_PROG -fc "pwrite -W 0 128k" "$SCRATCH_MNT/foo" | _filter_xfs_io
+	$XFS_IO_PROG -fc "pwrite -W 64k 8k" "$SCRATCH_MNT/foo" | _filter_xfs_io
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
+echo "= Test 128k write to empty file with 1st stripe partially prefilled then overwrite ="
+test_128k_write_overwrite raid0 2
+test_128k_write_overwrite raid1 2
+test_128k_write_overwrite raid10 4
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/308.out b/tests/btrfs/308.out
new file mode 100644
index 000000000000..c93a3a43b248
--- /dev/null
+++ b/tests/btrfs/308.out
@@ -0,0 +1,106 @@
+QA output created by 308
+= Test 128k write to empty file with 1st stripe partially prefilled then overwrite =
+==== Testing raid0 ====
+wrote 32768/32768 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 8192/8192 bytes at offset 65536
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
+	item 0 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 24
+			encoding: RAID0
+			stripe 0 devid 1 physical XXXXXXXXX
+	item 1 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 24
+			encoding: RAID0
+			stripe 0 devid 1 physical XXXXXXXXX
+	item 2 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 24
+			encoding: RAID0
+			stripe 0 devid 2 physical XXXXXXXXX
+	item 3 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 24
+			encoding: RAID0
+			stripe 0 devid 1 physical XXXXXXXXX
+	item 4 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 24
+			encoding: RAID0
+			stripe 0 devid 1 physical XXXXXXXXX
+total bytes XXXXXXXX
+bytes used XXXXXX
+uuid <UUID>
+==== Testing raid1 ====
+wrote 32768/32768 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 8192/8192 bytes at offset 65536
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
+	item 0 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 40
+			encoding: RAID1
+			stripe 0 devid 1 physical XXXXXXXXX
+			stripe 1 devid 2 physical XXXXXXXXX
+	item 1 key (XXXXXX RAID_STRIPE 131072) itemoff XXXXX itemsize 40
+			encoding: RAID1
+			stripe 0 devid 1 physical XXXXXXXXX
+			stripe 1 devid 2 physical XXXXXXXXX
+	item 2 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 40
+			encoding: RAID1
+			stripe 0 devid 1 physical XXXXXXXXX
+			stripe 1 devid 2 physical XXXXXXXXX
+total bytes XXXXXXXX
+bytes used XXXXXX
+uuid <UUID>
+==== Testing raid10 ====
+wrote 32768/32768 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 8192/8192 bytes at offset 65536
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
+	item 0 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 40
+			encoding: RAID10
+			stripe 0 devid 1 physical XXXXXXXXX
+			stripe 1 devid 2 physical XXXXXXXXX
+	item 1 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 40
+			encoding: RAID10
+			stripe 0 devid 1 physical XXXXXXXXX
+			stripe 1 devid 2 physical XXXXXXXXX
+	item 2 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 40
+			encoding: RAID10
+			stripe 0 devid 3 physical XXXXXXXXX
+			stripe 1 devid 4 physical XXXXXXXXX
+	item 3 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 40
+			encoding: RAID10
+			stripe 0 devid 1 physical XXXXXXXXX
+			stripe 1 devid 2 physical XXXXXXXXX
+	item 4 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 40
+			encoding: RAID10
+			stripe 0 devid 1 physical XXXXXXXXX
+			stripe 1 devid 2 physical XXXXXXXXX
+total bytes XXXXXXXX
+bytes used XXXXXX
+uuid <UUID>

-- 
2.43.0


