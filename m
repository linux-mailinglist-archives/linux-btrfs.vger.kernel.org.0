Return-Path: <linux-btrfs+bounces-740-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D01E8083C2
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Dec 2023 10:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15DA42840CC
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Dec 2023 09:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C47F34187;
	Thu,  7 Dec 2023 09:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DV+WgIpx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F20C10B;
	Thu,  7 Dec 2023 01:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701939820; x=1733475820;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=JKyzbkyBQxpoPUlEiTlUYHc8QByvt8/ka9+9zx7dhk8=;
  b=DV+WgIpxypHZVvda4HZ8loPXpMT6UxcmCg4Bj4D/5xiuEcJBvRgt9IDE
   9hDILADOG5n2DgghpiWNAr1E8eW3f2DdaUrSkVYVid7ofQMsYl5aUS/oP
   gZlWP+8rvNlUTxpO7kXgGicfknrbQYzq6XYwLAxFEuQQaXtHiJaBAQ83x
   RjAAM04Jyu2J3NivjQJMIQQz1Rhalq4OjASpe965cBtUFYG9BCHEinujV
   IaGBAjJe2ILLoBhNrBXgsIGVf64qgBprOcQDoAJM4EUfzmG8KdYv/Eryj
   FoOpQuxXkOmmH9IYCdRG7nGNS7nE90PSLlOEdSveiygcHJbUIUI9Arjeg
   g==;
X-CSE-ConnectionGUID: X+wBNUERT0SqGaKXN1t+/w==
X-CSE-MsgGUID: 9vC2SDvCSZeZ1D+S/p6W3w==
X-IronPort-AV: E=Sophos;i="6.04,256,1695657600"; 
   d="scan'208";a="4272778"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Dec 2023 17:03:39 +0800
IronPort-SDR: 7xEZM6/N0kqG/K4sB53/lp/15tS/AX10gYWmcenUx+SYTXqHIv1hASuUz3juT06ROkt944CgBO
 qWkS+WGIxKLg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Dec 2023 00:14:40 -0800
IronPort-SDR: bb80HUguoGYh2yP125t0CGVSLdlvdf3JzhoekTiRLAEt7YpFuy/QSA943fOooEla7b5pmASzFk
 t0qSTWzXYbhw==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Dec 2023 01:03:39 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Thu, 07 Dec 2023 01:03:32 -0800
Subject: [PATCH v5 5/9] btrfs: add fstest for stripe-tree metadata with 4k
 write
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231207-btrfs-raid-v5-5-44aa1affe856@wdc.com>
References: <20231207-btrfs-raid-v5-0-44aa1affe856@wdc.com>
In-Reply-To: <20231207-btrfs-raid-v5-0-44aa1affe856@wdc.com>
To: Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>
Cc: Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701939810; l=4208;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=JKyzbkyBQxpoPUlEiTlUYHc8QByvt8/ka9+9zx7dhk8=;
 b=MhnwMgLUHbbsdnchLEEBC+o8Z7pKPhmMmeFR8Y97scDB9rnSEfn0UThZDzK2nNgw+X9wBccrI
 EmA64Ylrb8WBdGtFRTjyzFGLrRUkSvqc4md7WFys0aeLOYGiUbRZfB6
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Test a simple 4k write on all RAID profiles currently supported with the
raid-stripe-tree.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 tests/btrfs/304     | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/304.out | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 114 insertions(+)

diff --git a/tests/btrfs/304 b/tests/btrfs/304
new file mode 100755
index 000000000000..7774a1bd74d0
--- /dev/null
+++ b/tests/btrfs/304
@@ -0,0 +1,56 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 Western Digital Cooperation.  All Rights Reserved.
+#
+# FS QA Test 304
+#
+# Test on-disk layout of RAID Stripe Tree Metadata writing 4k to a new file on
+# a pristine file system.
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
+test_4k_write()
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
+	$XFS_IO_PROG -fc "pwrite 0 4k" "$SCRATCH_MNT/foo" | _filter_xfs_io
+
+	_scratch_cycle_mount
+	md5sum "$SCRATCH_MNT/foo" | _filter_scratch
+
+	_scratch_unmount
+
+	$BTRFS_UTIL_PROG inspect-internal dump-tree -t raid_stripe $SCRATCH_DEV_POOL |\
+		_filter_btrfs_version |  _filter_stripe_tree
+
+	_scratch_dev_pool_put
+}
+
+echo "= Test basic 4k write ="
+test_4k_write raid0 2
+test_4k_write raid1 2
+test_4k_write raid10 4
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/304.out b/tests/btrfs/304.out
new file mode 100644
index 000000000000..48036efbf0cf
--- /dev/null
+++ b/tests/btrfs/304.out
@@ -0,0 +1,58 @@
+QA output created by 304
+= Test basic 4k write =
+==== Testing raid0 ====
+wrote 4096/4096 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+5fed275e7617a806f94c173746a2a723  SCRATCH_MNT/foo
+
+raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0) 
+leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_TREE
+leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
+checksum stored <CHECKSUM>
+checksum calced <CHECKSUM>
+fs uuid <UUID>
+chunk uuid <UUID>
+	item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 24
+			encoding: RAID0
+			stripe 0 devid 1 physical XXXXXXXXX
+total bytes XXXXXXXX
+bytes used XXXXXX
+uuid <UUID>
+==== Testing raid1 ====
+wrote 4096/4096 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+5fed275e7617a806f94c173746a2a723  SCRATCH_MNT/foo
+
+raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0) 
+leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_TREE
+leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
+checksum stored <CHECKSUM>
+checksum calced <CHECKSUM>
+fs uuid <UUID>
+chunk uuid <UUID>
+	item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
+			encoding: RAID1
+			stripe 0 devid 1 physical XXXXXXXXX
+			stripe 1 devid 2 physical XXXXXXXXX
+total bytes XXXXXXXX
+bytes used XXXXXX
+uuid <UUID>
+==== Testing raid10 ====
+wrote 4096/4096 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+5fed275e7617a806f94c173746a2a723  SCRATCH_MNT/foo
+
+raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0) 
+leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_TREE
+leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
+checksum stored <CHECKSUM>
+checksum calced <CHECKSUM>
+fs uuid <UUID>
+chunk uuid <UUID>
+	item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
+			encoding: RAID10
+			stripe 0 devid 1 physical XXXXXXXXX
+			stripe 1 devid 2 physical XXXXXXXXX
+total bytes XXXXXXXX
+bytes used XXXXXX
+uuid <UUID>

-- 
2.43.0


