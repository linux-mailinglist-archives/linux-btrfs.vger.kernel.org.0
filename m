Return-Path: <linux-btrfs+bounces-921-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 566C081103F
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 12:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1233282260
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 11:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45A6250FA;
	Wed, 13 Dec 2023 11:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fSnr4J4Q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5041610F;
	Wed, 13 Dec 2023 03:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702467346; x=1734003346;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=c7K6ye4ECrk/rqwJG0NQWH5K0hRc0hdL/n5pdDiHpm4=;
  b=fSnr4J4QP8x7vcEAc8EwmaiInKFALsKe6F2D9cFSb5RG54IASaIrsj1H
   /pOnB2hGE1tCqCqy91DT9EWlT5kH2pJBrMZUH6hwNgVd3I7f/SNO6/0a7
   aCCAfWCLcYEp1npewDuHwBXZAXYj08LemzUennB32A4G1F7S5voozAG+2
   xHwuCkitzJ1xPavvtIb3QhFgRdEkkUiF2n3gLniHZ4z5gEq37E7DPKJyN
   kuD38jWVscJ4RmoKIHkjIG7/COpFlkumIAUDNjlsciKJU92z8qWMsGnIx
   GeyCw5O2GBCDFSgu1Qdp7L1OttRGnf5W1lPG87GRKo0O6NVe8BR18fTaD
   Q==;
X-CSE-ConnectionGUID: NP17EFZpTQiOn2O4+mlZkw==
X-CSE-MsgGUID: 3oERq7KfRKemlpkhyZsZWQ==
X-IronPort-AV: E=Sophos;i="6.04,272,1695657600"; 
   d="scan'208";a="4718849"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2023 19:35:35 +0800
IronPort-SDR: b3KTwXrLmCMyb7qDUouoOxblHL/h5oyOUFhBxctN0ddANPrwP3pe4dLZFVkUxeU64wFAB492wu
 Bga8XH+T8+5A==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Dec 2023 02:40:47 -0800
IronPort-SDR: As73M59qLiEn53nmEZo9dSBU3AHWSwQSbne23nGJ/jyk0ZLvfp85QevgSi/4SDANM/3uZzlmen
 1t8YRBSJHMrw==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Dec 2023 03:35:36 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Wed, 13 Dec 2023 03:35:30 -0800
Subject: [PATCH v6 9/9] btrfs: add fstest for overwriting a file partially
 with RST
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231213-btrfs-raid-v6-9-913738861069@wdc.com>
References: <20231213-btrfs-raid-v6-0-913738861069@wdc.com>
In-Reply-To: <20231213-btrfs-raid-v6-0-913738861069@wdc.com>
To: Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>
Cc: Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702467323; l=6953;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=c7K6ye4ECrk/rqwJG0NQWH5K0hRc0hdL/n5pdDiHpm4=;
 b=O3cFdJLqNsHKfVPoX5Bo6JH/xDstDFVDvBt5OuNvKGcS1fPLP9i1RBTcNwVVkg361sbWFzyTN
 +ikUVW4z+GQBUgdKjttQmHyjXYdOxBrH+bULwQ2pNbPc+dtBOzweyMy
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Add a test writing 128k to an empty file with one stripe already
pre-filled on-disk. Then overwrite a portion of the file in the middle.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 tests/btrfs/308     |  62 ++++++++++++++++++++++++++++++
 tests/btrfs/308.out | 106 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 168 insertions(+)

diff --git a/tests/btrfs/308 b/tests/btrfs/308
new file mode 100755
index 000000000000..e5210fdfe2bd
--- /dev/null
+++ b/tests/btrfs/308
@@ -0,0 +1,62 @@
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
+_require_btrfs_free_space_tree
+_require_btrfs_no_compress
+_require_btrfs_no_nodatacow
+
+test _get_page_size -eq 4096 || _notrun "this tests requires 4k pagesize"
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


