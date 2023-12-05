Return-Path: <linux-btrfs+bounces-661-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C453F805B4C
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 18:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51E761F21D70
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 17:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374E468EB4;
	Tue,  5 Dec 2023 17:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="M/H+HRGM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC89818F;
	Tue,  5 Dec 2023 09:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701798427; x=1733334427;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Y9EXjlti+5WseWTI6MzBguBOleH+YIzjaLKCtaO5Rz8=;
  b=M/H+HRGMs5TA6SWwDADoVLvtfvJtuwABmAs+KtxiKHw/TSNPP/swQWUg
   A64vWSjJERvSqzeBfcTaAEaIUOw4TjmkslwxO1onIjMd73gOwgyTkEhGR
   K0mJcT4zAmeA9WNwKqMDSoS3wb7FPQW3hsC/hkMreYB2RpeC9v74UQ7vh
   rM9o2OziaKmqci4lQW1MH273IExUXy0j//gOvmGMiTJbmyQIQR6Mca8wE
   rH61v/zKU5enVWk2Bx+hHcy/xMM45yxpZ7SHPHjyzK4jtwhBuO8U/DA3V
   80JuiUEAIl/M5Vapollwueuxhc5NPa/+ca7YmTurVOndsvaN07FfPwvBN
   g==;
X-CSE-ConnectionGUID: MQ4quvSWSxGeCkiqqVvidg==
X-CSE-MsgGUID: ADL03WQhTE+VLr9fNBqffQ==
X-IronPort-AV: E=Sophos;i="6.04,252,1695657600"; 
   d="scan'208";a="3944957"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Dec 2023 01:47:07 +0800
IronPort-SDR: Xyb05o5Lr+UKpblc8jhoUy2zgoCq3mSmVFFNIpRrazkePOmHuu2M4VoMSHgt0Qh+hIQdLDbTaT
 RILwEbLMaYYg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Dec 2023 08:52:28 -0800
IronPort-SDR: AlgkmIeZDJ89L6jDY8lyy0jDc4SUhR92soxvFKUDEgxZ9kLcSUAgNZFPlCGTo0SJ24anklK0P1
 sayc+0xEVgrQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 05 Dec 2023 09:47:07 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Tue, 05 Dec 2023 09:47:03 -0800
Subject: [PATCH v3 3/7] btrfs: add fstest for stripe-tree metadata with 4k
 write
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-btrfs-raid-v3-3-0e857a5439a2@wdc.com>
References: <20231205-btrfs-raid-v3-0-0e857a5439a2@wdc.com>
In-Reply-To: <20231205-btrfs-raid-v3-0-0e857a5439a2@wdc.com>
To: Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>
Cc: Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701798423; l=4097;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=Y9EXjlti+5WseWTI6MzBguBOleH+YIzjaLKCtaO5Rz8=;
 b=NEpjW8MFDnaz31YVk59FtG+zXwJNgGkF5s5qUpJX8rQVClCOz6vb/RntkleooA6YlIiVpoLWG
 QYkOVtQFLShCZ3N7pJyG6b3K3mX6aR+SBWhPIYgKvu5+F9kF+LoYc/M
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Test a simple 4k write on all RAID profiles currently supported with the
raid-stripe-tree.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 tests/btrfs/304     | 53 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/304.out | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 111 insertions(+)

diff --git a/tests/btrfs/304 b/tests/btrfs/304
new file mode 100755
index 000000000000..b773168ca3c0
--- /dev/null
+++ b/tests/btrfs/304
@@ -0,0 +1,53 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 Western Digital Cooperation.  All Rights Reserved.
+#
+# FS QA Test 302
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


