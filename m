Return-Path: <linux-btrfs+bounces-918-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C35A381103D
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 12:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 236A4B210FC
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 11:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B56F250E2;
	Wed, 13 Dec 2023 11:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DI/7im5h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EC812B;
	Wed, 13 Dec 2023 03:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702467344; x=1734003344;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=v/ZFE5dui/VpK3mip31D422Shp0/m06qNUb94e9oJWI=;
  b=DI/7im5hEOLdOfyus9PJHPWGhc0qorzY2AvfRIpuA5bd5Awb0MD/eUCU
   sEkrWe8N2lclrZ6P5xcepat9mXoiPsQMnqWcJz4aWeDvpPExexxWSNyIW
   qQhR401aCF7gvGwDHzFrJvZ9yPL/rAi3bBLMM8czqeAQCU7gBPtHPl5o9
   LLRSm9zdSLA2kmUy164odpmVQMw/3ciMMWXAsVsr5a1+v1siNyoJBAaUH
   4V2mhsoJopxQe+dWl7Ivacw+XmbfZnGESxau8Ov6aXEs2r/zCEoh/gMZt
   RepQeYPBjoLNAYmUrDz8wG0x9P13ugDVAMoH2NpBfHROWDbzZYi7bbkXq
   Q==;
X-CSE-ConnectionGUID: uTmsL0CZQ0qG+keRJHYk7g==
X-CSE-MsgGUID: n9I6fufoS1yrrB72/SuIog==
X-IronPort-AV: E=Sophos;i="6.04,272,1695657600"; 
   d="scan'208";a="4718840"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2023 19:35:33 +0800
IronPort-SDR: +YtdtvjqHi1ghYTaWcxPSvcnsqBgthTzG2xkXvGgT8x0Q5DTqEDIxA0F6wJLZ+n2dgwzZu454V
 KKkOgg3RAvwA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Dec 2023 02:40:45 -0800
IronPort-SDR: h75W+29eekO1iF8YnG8D8H25sq1W/Q5CdU/QDKiGlrSrBd0llVf3m/bjlad0mAtMPCdE4puw44
 3Hk3s/8dWUzw==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Dec 2023 03:35:33 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Wed, 13 Dec 2023 03:35:28 -0800
Subject: [PATCH v6 7/9] btrfs: add fstest for writing to a file at an
 offset with RST
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231213-btrfs-raid-v6-7-913738861069@wdc.com>
References: <20231213-btrfs-raid-v6-0-913738861069@wdc.com>
In-Reply-To: <20231213-btrfs-raid-v6-0-913738861069@wdc.com>
To: Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>
Cc: Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702467323; l=5441;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=v/ZFE5dui/VpK3mip31D422Shp0/m06qNUb94e9oJWI=;
 b=b2ncUv197SasLNuQfqj2P8RwJALsITdE6fnPxDYyTtSMz0MJlUvG5AVcvnOZhU60W5lOruttK
 6MkISTHx0ppCwDo4DgoyuMKYUR8xGfQThHFO8zkWMjmDx1Ohv+756Pv
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Add a fstest writing 4k at offset 64k to a file with one RAID tripe
already pre-filled for a raid-stripe-tree formatted file system.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 tests/btrfs/306     | 61 +++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/306.out | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 136 insertions(+)

diff --git a/tests/btrfs/306 b/tests/btrfs/306
new file mode 100755
index 000000000000..2cadeac68268
--- /dev/null
+++ b/tests/btrfs/306
@@ -0,0 +1,61 @@
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
+_require_btrfs_free_space_tree
+_require_btrfs_no_compress
+
+test _get_page_size -eq 4096 || _notrun "this tests requires 4k pagesize"
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


