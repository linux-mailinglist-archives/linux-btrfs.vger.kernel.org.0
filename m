Return-Path: <linux-btrfs+bounces-633-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B096805511
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 13:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A03E1C20D9D
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 12:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC6D61FD9;
	Tue,  5 Dec 2023 12:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CGb7SdVg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0205124;
	Tue,  5 Dec 2023 04:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701780317; x=1733316317;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=TsibjB9rL/e2eyCJwTCPlgSHmlSJ69QQAWOIpWJkQ6E=;
  b=CGb7SdVgu1yAjYLeca3dAXGm+GHFgzm/ZN9YDZFAJhNfaOaBXrdBhwJO
   TzqpiayKlL0MJTF5mKwojA9qisB1oLINuagcaT+GaTiuz+36lzw2Z3i5i
   nUs6iy0isohg7j1p0YozbRSF1XMSmXIFyRRa8uKPZdBpXPfQb5+MwApa2
   4gR3xWSnblaG9RSgPRxZSmNbHEh7ePj2TZ0QJ2stTFAwlnWtxZ82bzgKk
   FYU6+dOxxnlXBdehuetIBWuKZdmmGlIqMrJQ9wAvkfsF4SqHXNLK8qekT
   MfvEJYcTgR9GqpQnykZxKsntY7Qtd0bTIuZgXlUySWk5QS+HuI6dUT7aG
   w==;
X-CSE-ConnectionGUID: +zG4AehDR82nvi29j6o8cg==
X-CSE-MsgGUID: 9ZLdY8qkRL6zwXRx3cRKYg==
X-IronPort-AV: E=Sophos;i="6.04,252,1695657600"; 
   d="scan'208";a="4043921"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Dec 2023 20:45:17 +0800
IronPort-SDR: hvQYp2+ctS/z812rPTAHIWVs0kOlRjbKCh0LVZjuTmk1CZ0EkkeN2r8/MfiV2AqWuFetzO3Gbn
 5Q2TJ1fw8EzA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Dec 2023 03:56:19 -0800
IronPort-SDR: EKSq3DcERl2qwyobXOG/pcRv5y0BChtlcT2ecvI8Sp2cQJWONbGZVTaxaOhr8T8fEselPKENEH
 JqFlBd7jUowA==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 05 Dec 2023 04:45:17 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Tue, 05 Dec 2023 04:45:11 -0800
Subject: [PATCH v2 5/7] btrfs: add fstest for writing to a file at an
 offset with RST
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-btrfs-raid-v2-5-25f80eea345b@wdc.com>
References: <20231205-btrfs-raid-v2-0-25f80eea345b@wdc.com>
In-Reply-To: <20231205-btrfs-raid-v2-0-25f80eea345b@wdc.com>
To: Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>
Cc: Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701780310; l=5182;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=TsibjB9rL/e2eyCJwTCPlgSHmlSJ69QQAWOIpWJkQ6E=;
 b=8vDUOn/ofX+a1DjpkwWrVeSphFG7nnqbTzseOzBNpUkOKNwJbc7i2Audr300iSPvq4oBH6dSr
 HouhodDHK13DPjtzpZLzj7TY7VDBpyE+rAqtVrGEYwtfI2kWD99flhH
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Add a fstest writing 4k at offset 64k to a file with one RAID tripe
already pre-filled for a raid-stripe-tree formatted file system.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 tests/btrfs/304     | 56 +++++++++++++++++++++++++++++++++++++++
 tests/btrfs/304.out | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 131 insertions(+)

diff --git a/tests/btrfs/304 b/tests/btrfs/304
new file mode 100755
index 000000000000..a95cfbac1e1b
--- /dev/null
+++ b/tests/btrfs/304
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
+	_scratch_pool_mkfs -d $profile -m $profile
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
diff --git a/tests/btrfs/304.out b/tests/btrfs/304.out
new file mode 100644
index 000000000000..e94deec1ab21
--- /dev/null
+++ b/tests/btrfs/304.out
@@ -0,0 +1,75 @@
+QA output created by 304
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


