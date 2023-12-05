Return-Path: <linux-btrfs+bounces-663-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DAA805B4F
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 18:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA1B61C21077
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 17:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F9F6A32B;
	Tue,  5 Dec 2023 17:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XOpgxvWu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7F3188;
	Tue,  5 Dec 2023 09:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701798429; x=1733334429;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=4gvMjZyYXF4pEgxkZppRwNbOOMIgqNyuJZ6mJK51WJg=;
  b=XOpgxvWueLJ+ixA4dbS9LiMwp1et267FKvdAau/3WIFuFHIZPb/haWlE
   V0b20Dpjkp2brXmgmCHLSScUCCG+vULQGnD58o26Cy3DOUdZ5vsvmXpqK
   rb4ccngo1i0xWmuGi+oDWTjuQzM77m9YEMOp4MhDYMFZCpfgqgmgtQ/mF
   wBbfwHM86iklV4NV//FSSJchT6CSYYggmTr2aUjWQKWe2fr52DA00bPA1
   nFZ+UdBQBMP0R6IXm05Vsc9WQLF4q1zsSvoHIBp0d2qMlj1OdlKzTQbwX
   cJgmK/VK2PhkKC+6mVYiAZeP0NgocFvZ29R/XW6GE6Y/UQtcFKjjRLIU7
   g==;
X-CSE-ConnectionGUID: o0K5u6BmTi2p4J0uVzKSYQ==
X-CSE-MsgGUID: LzZVqUGpRH2x7zR9JBa7SQ==
X-IronPort-AV: E=Sophos;i="6.04,252,1695657600"; 
   d="scan'208";a="3944965"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Dec 2023 01:47:09 +0800
IronPort-SDR: zPXPJiQ6QtROQS/MYhK6vtVnfxB9TT3Ih1p4JluysGvzQegYAOFFpgfWWUAdip1tDscnukCbSl
 dCBPYYaxNZQw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Dec 2023 08:52:30 -0800
IronPort-SDR: qBUxn3yuXhAtNGdaTlLCQmn3LzcJHj/vi4ooosieZCS78Aj+fIgAKDIg10oCDsEFHZdil1MJuq
 j35JQEAJOZVQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 05 Dec 2023 09:47:09 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Tue, 05 Dec 2023 09:47:05 -0800
Subject: [PATCH v3 5/7] btrfs: add fstest for writing to a file at an
 offset with RST
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-btrfs-raid-v3-5-0e857a5439a2@wdc.com>
References: <20231205-btrfs-raid-v3-0-0e857a5439a2@wdc.com>
In-Reply-To: <20231205-btrfs-raid-v3-0-0e857a5439a2@wdc.com>
To: Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>
Cc: Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701798423; l=5202;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=4gvMjZyYXF4pEgxkZppRwNbOOMIgqNyuJZ6mJK51WJg=;
 b=X+PicZqoUHo/JjFjsfVwhc0ly5Z6deGONm2MEyG0sHGnhF3kAGr8QosPYbT0EbE2zl/zo/TJH
 WzmNpBRXcnMDmOwQP4ugckofcX/giwItiQVANMFd9Axv3mZizQsUSbz
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Add a fstest writing 4k at offset 64k to a file with one RAID tripe
already pre-filled for a raid-stripe-tree formatted file system.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 tests/btrfs/306     | 56 +++++++++++++++++++++++++++++++++++++++
 tests/btrfs/306.out | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 131 insertions(+)

diff --git a/tests/btrfs/306 b/tests/btrfs/306
new file mode 100755
index 000000000000..55808a11cf85
--- /dev/null
+++ b/tests/btrfs/306
@@ -0,0 +1,56 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 Western Digital Cooperation.  All Rights Reserved.
+#
+# FS QA Test 304
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


