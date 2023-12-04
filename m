Return-Path: <linux-btrfs+bounces-561-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0E98034C1
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 14:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7919280ABB
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 13:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739602554F;
	Mon,  4 Dec 2023 13:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="q1pl2fPP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A61423B;
	Mon,  4 Dec 2023 05:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701696339; x=1733232339;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=YNpmRMEKHZVnVD0dNtGJOvoR99Yv/K6r9YAe1acPrx4=;
  b=q1pl2fPP9KMmjiM0g01BtAZCIpYvw10vv7WnxHhZRLwy8haQPYqgJQwY
   kSShLZ+yYqFEzg6uTgWbNpkd2U2J7b4+2Mjou1CR9TJQcPpXK+HHFgFRh
   ZYzRf5/Bxdk1RVRSnxCG1p7kLS+s56EUjWnMqoUl1EtK3mUFKuWZ7MGZv
   nn9hZKFFBWxAdS3z/GSmTtGcZZ0vTlU3PG6ixhWb3x/23LS89yY3uXpul
   kbu/oCpkCmmlTf7mjW8ENIj0CGxqCcagf6VfUxjskR6YtjBUUlRFBNQer
   Ftpj5Qivh7sZeQCJq9/xGmx3WyrX6/TrkL/mfmfK1AmtiC7kzl/sAOvUT
   A==;
X-CSE-ConnectionGUID: KAsHWfkfRDGh5TLb0GFIzQ==
X-CSE-MsgGUID: hOl9s7ijTYKNmgdEmzp8rg==
X-IronPort-AV: E=Sophos;i="6.04,249,1695657600"; 
   d="scan'208";a="3929125"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2023 21:25:16 +0800
IronPort-SDR: tCy/lqpa6OgIpQteIqetPqYIOApzNUvuXwVTL7pl4Pds1d4krWPyJOSNLIBPj7HRF+j2XgP/tK
 +AKLMAnakXGA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Dec 2023 04:36:19 -0800
IronPort-SDR: RQuNeRdXlKh8fSTrkOYA52+tOKrqDXEPCVXuaTFkoJ9MWC1X597xfwA0sHfSAOvnA8Tdj8XPP3
 cqNYqro/3bkQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Dec 2023 05:25:15 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Mon, 04 Dec 2023 05:25:07 -0800
Subject: [PATCH 4/7] btrfs: add fstests to write 128k to a RST filesystem
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231204-btrfs-raid-v1-4-b254eb1bcff8@wdc.com>
References: <20231204-btrfs-raid-v1-0-b254eb1bcff8@wdc.com>
In-Reply-To: <20231204-btrfs-raid-v1-0-b254eb1bcff8@wdc.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701696311; l=4439;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=YNpmRMEKHZVnVD0dNtGJOvoR99Yv/K6r9YAe1acPrx4=;
 b=c1T2qOi/vL0vCYBmCrgS8kchBLS+9YXH3s9aYGCBiZSEiYKx/vn+5qL9xAgwQTcQQ8CtKsZp1
 kYUst/fgcJ1A4Y5jnbkcro3t86txpsbvzgjh+/bqVlNqCH9eZwtV1eO
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Add a test writing 128k to a file on an empty filesystem formatted with a
raid-stripe-tree.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 tests/btrfs/305     | 55 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/305.out | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 120 insertions(+)

diff --git a/tests/btrfs/305 b/tests/btrfs/305
new file mode 100755
index 000000000000..8b84fccd692b
--- /dev/null
+++ b/tests/btrfs/305
@@ -0,0 +1,55 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 Western Digital Cooperation.  All Rights Reserved.
+#
+# FS QA Test 305
+#
+# Test on-disk layout of RAID Stripe Tree Metadata
+#
+. ./common/preamble
+_begin_fstest auto quick raid remount volume raid-stripe-tree
+
+. ./common/filter
+. ./common/filter.btrfs
+
+_supported_fs btrfs
+_require_test
+_require_btrfs_command inspect-internal dump-tree
+_require_btrfs_mkfs_feature "raid-stripe-tree"
+_require_scratch_dev_pool 4
+_require_xfs_io_command "pwrite"
+_require_xfs_io_command "fsync"
+_require_btrfs_fs_feature "raid_stripe_tree"
+
+test_128k_write()
+{
+	profile=$1
+	ndevs=$2
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


