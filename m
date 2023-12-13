Return-Path: <linux-btrfs+bounces-917-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F7681103B
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 12:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9FE9B21119
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 11:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A9C24B41;
	Wed, 13 Dec 2023 11:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gbFo6c57"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507E112F;
	Wed, 13 Dec 2023 03:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702467342; x=1734003342;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=PVzeiQ/I5Y/CN+btHXiXPZLrxdaj722ZejTSdHska2M=;
  b=gbFo6c57q8UahAI8JGpDy6NgH8gFfAAberIUBvyX/HzsA8F+R/atxEPw
   qust6WmF/ZroW/HUcb4840bw9RFirjH2KbnAE0B5qKPPZTV3Shf6CFv++
   v3VMPFRYEcC0dPVMGZ+un1I1b1M0fHa1dVa/F9r/i6AElXzN8ohaF9tFG
   Yt3w11KpLLZGGWDfSPBQdol4TpOmO2S/B9Sggu3g4ZtsI0cqNx6ZJll5F
   NbroFPFLr3gAoAybtf4JowB5ShayNn9gUTkQCi1/1gSXf1a63KTb2pl13
   fAcIbFEGORh0vE+S6RVNHbmRs87N2HvOLrpcj7whADlgLDzmXbPN27YFS
   g==;
X-CSE-ConnectionGUID: Cg/6MCBzQiaChl1QSjmU9w==
X-CSE-MsgGUID: w8oOy3jfQqenbTEqKI57hg==
X-IronPort-AV: E=Sophos;i="6.04,272,1695657600"; 
   d="scan'208";a="4718835"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2023 19:35:30 +0800
IronPort-SDR: ZJKOTqXpOYst1HdcNqqUuFGjIHPc5k4raz0E4fyDw0oQx2BolzYFHar6gmh3gEDzvT2Qv9XwnT
 rWL+1IklcO2A==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Dec 2023 02:40:42 -0800
IronPort-SDR: ecB7GJubt6Hq4AEHiao7hbg1juAQ89hp6zD4J0Eh+BdP+Gy2qDjTwfNyVurxVNcr6GTKQDY1yv
 d3kMumHyq4kA==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Dec 2023 03:35:30 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Wed, 13 Dec 2023 03:35:26 -0800
Subject: [PATCH v6 5/9] btrfs: add fstest for stripe-tree metadata with 4k
 write
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231213-btrfs-raid-v6-5-913738861069@wdc.com>
References: <20231213-btrfs-raid-v6-0-913738861069@wdc.com>
In-Reply-To: <20231213-btrfs-raid-v6-0-913738861069@wdc.com>
To: Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>
Cc: Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702467323; l=4337;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=PVzeiQ/I5Y/CN+btHXiXPZLrxdaj722ZejTSdHska2M=;
 b=KMfEZ2aLb9C1SjJBVojgfvbe7Edi0Lutzw/kSQYZAjNP0gmahQJcAPD7bYjP4cAkY/dyOfryW
 NhY0DwhQDbvAiw0MZESZehxOonlpja0O+wM4m30hd4qrSYZkM3OFahX
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Test a simple 4k write on all RAID profiles currently supported with the
raid-stripe-tree.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 tests/btrfs/304     | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/304.out | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/tests/btrfs/304 b/tests/btrfs/304
new file mode 100755
index 000000000000..05a4ae32639d
--- /dev/null
+++ b/tests/btrfs/304
@@ -0,0 +1,58 @@
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
+test _get_page_size -eq 4096 || _notrun "this tests requires 4k pagesize"
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


