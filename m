Return-Path: <linux-btrfs+bounces-709-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30943806CC6
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Dec 2023 11:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF1B6281A90
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Dec 2023 10:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3233B31599;
	Wed,  6 Dec 2023 10:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Munk1oUv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74CD12F;
	Wed,  6 Dec 2023 02:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701860187; x=1733396187;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=9wWvYkB/5YHkv9U4ir8NMxm7Z2FqMmh8mmA7ZwQF7x0=;
  b=Munk1oUvIMHoepFYASAFyEkL05hCDfwXjaV8IBJhxGsxtZq3seoG9cLm
   I1Xz48Y38rtIyOxuGuF9Lnsp0WFmyb+9sPr+AV4eE1aKDTLVEjMt0/lPa
   NhGRuj/Jff33t5x0A+HnFnymo2f3xRIreN4NWY/hVlMQk1Mlen9YlyzY3
   hWbkqBFmbMf11K710S4SL2/Yk4a57ZntxUZUb1W2el+bN787wCeXsrwOa
   1KJ6NmKZlqZGE3Qmk7Fmk1vsuD1G7jivLDvCf5phulsMHO2TeJUdWHo1F
   DjKKudu39nu+nOnOtw7cEf9B3p65vhvo74mZP1JOMIdL/NaUC3uVsvY1b
   w==;
X-CSE-ConnectionGUID: +EYAZaAlSkmS3ddctMK6MA==
X-CSE-MsgGUID: K7CTCo0zQJOXwEI4mBvAmA==
X-IronPort-AV: E=Sophos;i="6.04,255,1695657600"; 
   d="scan'208";a="4119720"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Dec 2023 18:56:27 +0800
IronPort-SDR: FpyHsk3axlLi18pa2F7swZOiitsDdGXcIbBujZbYu3JKMNpCltUN/+U7+FYO5sO9irFye7bYIO
 XWLs7b5dYdQw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Dec 2023 02:07:28 -0800
IronPort-SDR: v8pXWiP2ycyemhTTwqKxAZ9oLxzgCr47xuqNuLkmDalJt6ZeYb48Lm/pTH8QmnS9GDMi84SQQI
 Mnr6oaK5HNfw==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Dec 2023 02:56:26 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Wed, 06 Dec 2023 02:56:19 -0800
Subject: [PATCH v4 7/8] btrfs: add fstests to write 128k to a RST
 filesystem
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231206-btrfs-raid-v4-7-578284dd3a70@wdc.com>
References: <20231206-btrfs-raid-v4-0-578284dd3a70@wdc.com>
In-Reply-To: <20231206-btrfs-raid-v4-0-578284dd3a70@wdc.com>
To: Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>
Cc: Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701860179; l=4520;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=9wWvYkB/5YHkv9U4ir8NMxm7Z2FqMmh8mmA7ZwQF7x0=;
 b=YcbH6Tg9yIqFg1/0EqpJZKGexdoGmr6IwQOQF2ZoC9d/z4vR0omZ/V7dhXCm28mu30JddupHK
 UjsolomYK2FAr+GQJIYIbu/f3vtaS490fVuyuwBugVHMbH+P+ABZSnU
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Add a test writing 128k to a file on an empty filesystem formatted with a
raid-stripe-tree.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 tests/btrfs/307     | 55 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/307.out | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 120 insertions(+)

diff --git a/tests/btrfs/307 b/tests/btrfs/307
new file mode 100755
index 000000000000..fcca446f0ff7
--- /dev/null
+++ b/tests/btrfs/307
@@ -0,0 +1,55 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 Western Digital Cooperation.  All Rights Reserved.
+#
+# FS QA Test 307
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
+_require_btrfs_fs_feature "free_space_tree"
+_require_btrfs_no_compress
+
+test_128k_write()
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
diff --git a/tests/btrfs/307.out b/tests/btrfs/307.out
new file mode 100644
index 000000000000..b39f3162bff6
--- /dev/null
+++ b/tests/btrfs/307.out
@@ -0,0 +1,65 @@
+QA output created by 307
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


