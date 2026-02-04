Return-Path: <linux-btrfs+bounces-21353-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNFZOwP3gmlVfwMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21353-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 08:36:35 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 972A2E2BA3
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 08:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FB02303FAAC
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Feb 2026 07:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE21838E5D1;
	Wed,  4 Feb 2026 07:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="D/XM72qh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44CE27E04C
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Feb 2026 07:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770190578; cv=none; b=onUqmTR7DwZU5P8GgpJIR7YY3fxNSKPUT5Hvvlees0scGPfQY/18Znz1PbOkHtXA1aHS2V1doVSu6wJvbjd46geb4FXu87B1E4tm6nWr3xH8iILPjqBoYMGaqrl73McfJZ1TUt2IAPFLYSdMP0sfgnAIefsF4ZWFOlMGi1ZiUnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770190578; c=relaxed/simple;
	bh=+oXGplEmdwbJ574iOP2aKl05rHZP1jpNP1ujjwiwDHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pmOtX2rKRn2vstWREAYrJkByN3zPhUScatG4Pv/RcBlCR4C3nDpXXlSRGcFJtD4GKHtpA32qZ/PEBUmQJoA2lQWor2UICdt4k9hmInwMd0dmsgwL2WPNsF1ffomJ1rQ6Yfo5AT1lwP4plgyigbyUQPstS4G+M/o7pY456wdDdog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=D/XM72qh; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1770190577; x=1801726577;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+oXGplEmdwbJ574iOP2aKl05rHZP1jpNP1ujjwiwDHE=;
  b=D/XM72qhvphz15ap6kfBFJTNaYc31ARx3qSK5cLutqHNIGb6NP5u5ZJL
   JXRM/Yt7SKYg12UaCw2Kb7uih8lPGdMvRDag1ZThOdPCacXEuGa2Av1rc
   27olr45TvURVcBHoguG62HJ6f1oLOlgP5ExW9EfAdbIl6GQYu9HpMHugN
   g+ZmMVp3euBEKEEs/0pDFYcdwkERhVYIQr0x0Yy5JTs0rPXB+pIacQQtM
   x7sLttbwDX8zBYwvsBgRRKN5WxHN9mAPQIB7zoLEJ0Hu686jQVAvajgkg
   qROlGkH4BqCLcCo92XVoq5mHWSPgkhui5oYI3/0Tnexw9qy+WeSknW/Zn
   Q==;
X-CSE-ConnectionGUID: JEJJT31pRL+qEtqix1aw9Q==
X-CSE-MsgGUID: 8vyRd75dQPmHrgO/TTr4UA==
X-IronPort-AV: E=Sophos;i="6.21,272,1763395200"; 
   d="scan'208";a="139250041"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2026 15:36:17 +0800
IronPort-SDR: 6982f6f1_QW01h5tbUhsT9BzQXqfS7Ras2Xk6BuxHoiVOErBUqotjU2N
 syzTVISRwFEcmXUt2Pi9MsPuCQcEhVQVHoxtAxg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Feb 2026 23:36:17 -0800
WDCIronportException: Internal
Received: from wdap-p2d7qjs7w9.ad.shared (HELO naota-xeon) ([10.224.106.65])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Feb 2026 23:36:17 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 1/1] btrfs: tests: zoned: add selftest for zoned code
Date: Wed,  4 Feb 2026 16:31:25 +0900
Message-ID: <20260204073125.3173982-2-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204073125.3173982-1-naohiro.aota@wdc.com>
References: <20260204073125.3173982-1-naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21353-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[wdc.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[naohiro.aota@wdc.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wdc.com:email,wdc.com:dkim,wdc.com:mid]
X-Rspamd-Queue-Id: 972A2E2BA3
X-Rspamd-Action: no action

Add a test function for the zoned code, for now it tests
btrfs_load_block_group_by_raid_type() with various test cases. The
load_zone_info_tests[] array defines the test cases.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/Makefile            |   4 +
 fs/btrfs/tests/btrfs-tests.c |   3 +
 fs/btrfs/tests/btrfs-tests.h |   8 +
 fs/btrfs/tests/zoned-tests.c | 676 +++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.c             |   3 +
 5 files changed, 694 insertions(+)
 create mode 100644 fs/btrfs/tests/zoned-tests.c

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index 975104b74486..b2b97fdbc7ab 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -46,3 +46,7 @@ btrfs-$(CONFIG_BTRFS_FS_RUN_SANITY_TESTS) += tests/free-space-tests.o \
 	tests/free-space-tree-tests.o tests/extent-map-tests.o \
 	tests/raid-stripe-tree-tests.o tests/delayed-refs-tests.o \
 	tests/chunk-allocation-tests.o
+
+ifeq ($(CONFIG_BLK_DEV_ZONED),y)
+btrfs-$(CONFIG_BTRFS_FS_RUN_SANITY_TESTS) += tests/zoned-tests.o
+endif
diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
index 7f13c05d3736..7a450117440b 100644
--- a/fs/btrfs/tests/btrfs-tests.c
+++ b/fs/btrfs/tests/btrfs-tests.c
@@ -307,6 +307,9 @@ int btrfs_run_sanity_tests(void)
 		}
 	}
 	ret = btrfs_test_extent_map();
+	if (ret)
+		goto out;
+	ret = btrfs_test_zoned();
 
 out:
 	btrfs_destroy_test_fs();
diff --git a/fs/btrfs/tests/btrfs-tests.h b/fs/btrfs/tests/btrfs-tests.h
index b03d85a6e5ef..c7abcfb804bb 100644
--- a/fs/btrfs/tests/btrfs-tests.h
+++ b/fs/btrfs/tests/btrfs-tests.h
@@ -48,6 +48,14 @@ int btrfs_test_raid_stripe_tree(u32 sectorsize, u32 nodesize);
 int btrfs_test_extent_map(void);
 int btrfs_test_delayed_refs(u32 sectorsize, u32 nodesize);
 int btrfs_test_chunk_allocation(u32 sectorsize, u32 nodesize);
+#ifdef CONFIG_BLK_DEV_ZONED
+int btrfs_test_zoned(void);
+#else
+static inline int btrfs_test_zoned(void)
+{
+	return 0;
+}
+#endif
 struct inode *btrfs_new_test_inode(void);
 struct btrfs_fs_info *btrfs_alloc_dummy_fs_info(u32 nodesize, u32 sectorsize);
 void btrfs_free_dummy_fs_info(struct btrfs_fs_info *fs_info);
diff --git a/fs/btrfs/tests/zoned-tests.c b/fs/btrfs/tests/zoned-tests.c
new file mode 100644
index 000000000000..6eb5220933d5
--- /dev/null
+++ b/fs/btrfs/tests/zoned-tests.c
@@ -0,0 +1,676 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Western Digital Corporation or its affiliates.
+ */
+
+#include <linux/cleanup.h>
+#include <linux/sizes.h>
+
+#include "btrfs-tests.h"
+#include "../space-info.h"
+#include "../volumes.h"
+#include "../zoned.h"
+
+#define WP_MISSING_DEV ((u64)-1)
+#define WP_CONVENTIONAL ((u64)-2)
+#define ZONE_SIZE SZ_256M
+
+#define HALF_STRIPE_LEN (BTRFS_STRIPE_LEN >> 1)
+
+struct load_zone_info_test_vector {
+	u64 raid_type;
+	u64 num_stripes;
+	u64 alloc_offsets[8];
+	u64 last_alloc;
+	u64 bg_length;
+	bool degraded;
+
+	int expected_result;
+	u64 expected_alloc_offset;
+
+	const char *description;
+};
+
+struct zone_info {
+	u64 physical;
+	u64 capacity;
+	u64 alloc_offset;
+};
+
+static int test_load_zone_info(struct btrfs_fs_info *fs_info,
+			       struct load_zone_info_test_vector *test)
+{
+	struct btrfs_block_group *bg __free(btrfs_free_dummy_block_group) = NULL;
+	struct btrfs_chunk_map *map __free(btrfs_free_chunk_map) = NULL;
+	struct zone_info AUTO_KFREE(zone_info);
+	unsigned long AUTO_KFREE(active);
+	int i, ret;
+
+	bg = btrfs_alloc_dummy_block_group(fs_info, test->bg_length);
+	if (!bg) {
+		test_std_err(TEST_ALLOC_BLOCK_GROUP);
+		return -ENOMEM;
+	}
+
+	map = btrfs_alloc_chunk_map(test->num_stripes, GFP_KERNEL);
+	if (!map) {
+		test_std_err(TEST_ALLOC_EXTENT_MAP);
+		return -ENOMEM;
+	}
+
+	zone_info = kcalloc(test->num_stripes, sizeof(*zone_info), GFP_KERNEL);
+	if (!zone_info) {
+		test_err("cannot allocate zone info");
+		return -ENOMEM;
+	}
+
+	active = bitmap_zalloc(test->num_stripes, GFP_KERNEL);
+	if (!zone_info) {
+		test_err("cannot allocate active bitmap");
+		return -ENOMEM;
+	}
+
+	map->type = test->raid_type;
+	map->num_stripes = test->num_stripes;
+	if (test->raid_type == BTRFS_BLOCK_GROUP_RAID10)
+		map->sub_stripes = 2;
+	for (i = 0; i < test->num_stripes; i++) {
+		zone_info[i].physical = 0;
+		zone_info[i].alloc_offset = test->alloc_offsets[i];
+		zone_info[i].capacity = ZONE_SIZE;
+		if (zone_info[i].alloc_offset && zone_info[i].alloc_offset < ZONE_SIZE)
+			__set_bit(i, active);
+	}
+	if (test->degraded)
+		btrfs_set_opt(fs_info->mount_opt, DEGRADED);
+	else
+		btrfs_clear_opt(fs_info->mount_opt, DEGRADED);
+
+	ret = btrfs_load_block_group_by_raid_type(bg, map, zone_info, active,
+						  test->last_alloc);
+
+	if (ret != test->expected_result) {
+		test_err("unexpected return value: ret %d expected %d", ret,
+			 test->expected_result);
+		return -EINVAL;
+	}
+
+	if (!ret && bg->alloc_offset != test->expected_alloc_offset) {
+		test_err("unexpected alloc_offset: alloc_offset %llu expected %llu",
+			 bg->alloc_offset, test->expected_alloc_offset);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+struct load_zone_info_test_vector load_zone_info_tests[] = {
+	/* SINGLE */
+	{
+		.description = "SINGLE: load write pointer from sequential zone",
+		.raid_type = 0,
+		.num_stripes = 1,
+		.alloc_offsets = {
+			SZ_1M,
+		},
+		.expected_alloc_offset = SZ_1M,
+	},
+	/*
+	 * SINGLE block group on a conventional zone sets last_alloc outside of
+	 * btrfs_load_block_group_*(). Do not test that case.
+	 */
+
+	/* DUP */
+	/* Normal case */
+	{
+		.description = "DUP: having matching write pointers",
+		.raid_type = BTRFS_BLOCK_GROUP_DUP,
+		.num_stripes = 2,
+		.alloc_offsets = {
+			SZ_1M, SZ_1M,
+		},
+		.expected_alloc_offset = SZ_1M,
+	},
+	/*
+	 * One sequential zone and one conventional zone, having matching
+	 * last_alloc.
+	 */
+	{
+		.description = "DUP: seq zone and conv zone, matching last_alloc",
+		.raid_type = BTRFS_BLOCK_GROUP_DUP,
+		.num_stripes = 2,
+		.alloc_offsets = {
+			SZ_1M, WP_CONVENTIONAL,
+		},
+		.last_alloc = SZ_1M,
+		.expected_alloc_offset = SZ_1M,
+	},
+	/*
+	 * One sequential and one conventional zone, but having smaller
+	 * last_alloc than write pointer.
+	 */
+	{
+		.description = "DUP: seq zone and conv zone, smaller last_alloc",
+		.raid_type = BTRFS_BLOCK_GROUP_DUP,
+		.num_stripes = 2,
+		.alloc_offsets = {
+			SZ_1M, WP_CONVENTIONAL,
+		},
+		.last_alloc = 0,
+		.expected_alloc_offset = SZ_1M,
+	},
+	/* Error case: having different write pointers. */
+	{
+		.description = "DUP: fail: different write pointers",
+		.raid_type = BTRFS_BLOCK_GROUP_DUP,
+		.num_stripes = 2,
+		.alloc_offsets = {
+			SZ_1M, SZ_2M,
+		},
+		.expected_result = -EIO,
+	},
+	/* Error case: partial missing device should not happen on DUP. */
+	{
+		.description = "DUP: fail: missing device",
+		.raid_type = BTRFS_BLOCK_GROUP_DUP,
+		.num_stripes = 2,
+		.alloc_offsets = {
+			SZ_1M, WP_MISSING_DEV,
+		},
+		.expected_result = -EIO,
+	},
+	/*
+	 * Error case: one sequential and one conventional zone, but having larger
+	 * last_alloc than write pointer.
+	 */
+	{
+		.description = "DUP: fail: seq zone and conv zone, larger last_alloc",
+		.raid_type = BTRFS_BLOCK_GROUP_DUP,
+		.num_stripes = 2,
+		.alloc_offsets = {
+			SZ_1M, WP_CONVENTIONAL,
+		},
+		.last_alloc = SZ_2M,
+		.expected_result = -EIO,
+	},
+
+	/* RAID1 */
+	/* Normal case */
+	{
+		.description = "RAID1: having matching write pointers",
+		.raid_type = BTRFS_BLOCK_GROUP_RAID1,
+		.num_stripes = 2,
+		.alloc_offsets = {
+			SZ_1M, SZ_1M,
+		},
+		.expected_alloc_offset = SZ_1M,
+	},
+	/*
+	 * One sequential zone and one conventional zone, having matching
+	 * last_alloc.
+	 */
+	{
+		.description = "RAID1: seq zone and conv zone, matching last_alloc",
+		.raid_type = BTRFS_BLOCK_GROUP_RAID1,
+		.num_stripes = 2,
+		.alloc_offsets = {
+			SZ_1M, WP_CONVENTIONAL,
+		},
+		.last_alloc = SZ_1M,
+		.expected_alloc_offset = SZ_1M,
+	},
+	/*
+	 * One sequential and one conventional zone, but having smaller
+	 * last_alloc than write pointer.
+	 */
+	{
+		.description = "RAID1: seq zone and conv zone, smaller last_alloc",
+		.raid_type = BTRFS_BLOCK_GROUP_RAID1,
+		.num_stripes = 2,
+		.alloc_offsets = {
+			SZ_1M, WP_CONVENTIONAL,
+		},
+		.last_alloc = 0,
+		.expected_alloc_offset = SZ_1M,
+	},
+	/* Partial missing device should be recovered on DEGRADED mount */
+	{
+		.description = "RAID1: fail: missing device on DEGRADED",
+		.raid_type = BTRFS_BLOCK_GROUP_RAID1,
+		.num_stripes = 2,
+		.alloc_offsets = {
+			SZ_1M, WP_MISSING_DEV,
+		},
+		.degraded = true,
+		.expected_alloc_offset = SZ_1M,
+	},
+	/* Error case: having different write pointers. */
+	{
+		.description = "RAID1: fail: different write pointers",
+		.raid_type = BTRFS_BLOCK_GROUP_RAID1,
+		.num_stripes = 2,
+		.alloc_offsets = {
+			SZ_1M, SZ_2M,
+		},
+		.expected_result = -EIO,
+	},
+	/*
+	 * Partial missing device is not allowed on non-DEGRADED mount never happen
+	 * as it is rejected beforehand.
+	 */
+	/*
+	 * Error case: one sequential and one conventional zone, but having larger
+	 * last_alloc than write pointer.
+	 */
+	{
+		.description = "RAID1: fail: seq zone and conv zone, larger last_alloc",
+		.raid_type = BTRFS_BLOCK_GROUP_RAID1,
+		.num_stripes = 2,
+		.alloc_offsets = {
+			SZ_1M, WP_CONVENTIONAL,
+		},
+		.last_alloc = SZ_2M,
+		.expected_result = -EIO,
+	},
+
+	/* RAID0 */
+	/* Normal case */
+	{
+		.description = "RAID0: initial partial write",
+		.raid_type = BTRFS_BLOCK_GROUP_RAID0,
+		.num_stripes = 4,
+		.alloc_offsets = {
+			HALF_STRIPE_LEN, 0, 0, 0,
+		},
+		.expected_alloc_offset = HALF_STRIPE_LEN,
+	},
+	{
+		.description = "RAID0: while in second stripe",
+		.raid_type = BTRFS_BLOCK_GROUP_RAID0,
+		.num_stripes = 4,
+		.alloc_offsets = {
+			BTRFS_STRIPE_LEN * 2, BTRFS_STRIPE_LEN + HALF_STRIPE_LEN,
+			BTRFS_STRIPE_LEN, BTRFS_STRIPE_LEN,
+		},
+		.expected_alloc_offset = BTRFS_STRIPE_LEN * 5 + HALF_STRIPE_LEN,
+	},
+	{
+		.description = "RAID0: one stripe advanced",
+		.raid_type = BTRFS_BLOCK_GROUP_RAID0,
+		.num_stripes = 2,
+		.alloc_offsets = {
+			SZ_1M + BTRFS_STRIPE_LEN, SZ_1M,
+		},
+		.expected_alloc_offset = SZ_2M + BTRFS_STRIPE_LEN,
+	},
+	/* Error case: having different write pointers. */
+	{
+		.description = "RAID0: fail: disordered stripes",
+		.raid_type = BTRFS_BLOCK_GROUP_RAID0,
+		.num_stripes = 4,
+		.alloc_offsets = {
+			BTRFS_STRIPE_LEN, BTRFS_STRIPE_LEN * 2,
+			BTRFS_STRIPE_LEN, BTRFS_STRIPE_LEN,
+		},
+		.expected_result = -EIO,
+	},
+	{
+		.description = "RAID0: fail: far distance",
+		.raid_type = BTRFS_BLOCK_GROUP_RAID0,
+		.num_stripes = 4,
+		.alloc_offsets = {
+			BTRFS_STRIPE_LEN * 3, BTRFS_STRIPE_LEN,
+			BTRFS_STRIPE_LEN, BTRFS_STRIPE_LEN,
+		},
+		.expected_result = -EIO,
+	},
+	{
+		.description = "RAID0: fail: too many partial write",
+		.raid_type = BTRFS_BLOCK_GROUP_RAID0,
+		.num_stripes = 4,
+		.alloc_offsets = {
+			HALF_STRIPE_LEN, HALF_STRIPE_LEN, 0, 0,
+		},
+		.expected_result = -EIO,
+	},
+	/*
+	 * Error case: Partial missing device is not allowed even on non-DEGRADED
+	 * mount.
+	 */
+	{
+		.description = "RAID0: fail: missing device on DEGRADED",
+		.raid_type = BTRFS_BLOCK_GROUP_RAID0,
+		.num_stripes = 2,
+		.alloc_offsets = {
+			SZ_1M, WP_MISSING_DEV,
+		},
+		.degraded = true,
+		.expected_result = -EIO,
+	},
+
+	/*
+	 * One sequential zone and one conventional zone, having matching
+	 * last_alloc.
+	 */
+	{
+		.description = "RAID0: seq zone and conv zone, partially written stripe",
+		.raid_type = BTRFS_BLOCK_GROUP_RAID0,
+		.num_stripes = 2,
+		.alloc_offsets = {
+			SZ_1M, WP_CONVENTIONAL,
+		},
+		.last_alloc = SZ_2M - SZ_4K,
+		.expected_alloc_offset = SZ_2M - SZ_4K,
+	},
+	{
+		.description = "RAID0: conv zone and seq zone, partially written stripe",
+		.raid_type = BTRFS_BLOCK_GROUP_RAID0,
+		.num_stripes = 2,
+		.alloc_offsets = {
+			WP_CONVENTIONAL, SZ_1M,
+		},
+		.last_alloc = SZ_2M + SZ_4K,
+		.expected_alloc_offset = SZ_2M + SZ_4K,
+	},
+	/*
+	 * Error case: one sequential and one conventional zone, but having larger
+	 * last_alloc than write pointer.
+	 */
+	{
+		.description = "RAID0: fail: seq zone and conv zone, larger last_alloc",
+		.raid_type = BTRFS_BLOCK_GROUP_RAID0,
+		.num_stripes = 2,
+		.alloc_offsets = {
+			SZ_1M, WP_CONVENTIONAL,
+		},
+		.last_alloc = SZ_2M + BTRFS_STRIPE_LEN * 2,
+		.expected_result = -EIO,
+	},
+
+	/* RAID0, 4 stripes with seq zones and conv zones. */
+	{
+		.description = "RAID0: stripes [2, 2, ?, ?] last_alloc = 6",
+		.raid_type = BTRFS_BLOCK_GROUP_RAID0,
+		.num_stripes = 4,
+		.alloc_offsets = {
+			BTRFS_STRIPE_LEN * 2, BTRFS_STRIPE_LEN * 2,
+			WP_CONVENTIONAL, WP_CONVENTIONAL,
+		},
+		.last_alloc = BTRFS_STRIPE_LEN * 6,
+		.expected_alloc_offset = BTRFS_STRIPE_LEN * 6,
+	},
+	{
+		.description = "RAID0: stripes [2, 2, ?, ?] last_alloc = 7.5",
+		.raid_type = BTRFS_BLOCK_GROUP_RAID0,
+		.num_stripes = 4,
+		.alloc_offsets = {
+			BTRFS_STRIPE_LEN * 2, BTRFS_STRIPE_LEN * 2,
+			WP_CONVENTIONAL, WP_CONVENTIONAL,
+		},
+		.last_alloc = BTRFS_STRIPE_LEN * 7 + HALF_STRIPE_LEN,
+		.expected_alloc_offset = BTRFS_STRIPE_LEN * 7 + HALF_STRIPE_LEN,
+	},
+	{
+		.description = "RAID0: stripes [3, ?, ?, ?] last_alloc = 1",
+		.raid_type = BTRFS_BLOCK_GROUP_RAID0,
+		.num_stripes = 4,
+		.alloc_offsets = {
+			BTRFS_STRIPE_LEN * 3, WP_CONVENTIONAL,
+			WP_CONVENTIONAL, WP_CONVENTIONAL,
+		},
+		.last_alloc = BTRFS_STRIPE_LEN,
+		.expected_alloc_offset = BTRFS_STRIPE_LEN * 9,
+	},
+	{
+		.description = "RAID0: stripes [2, ?, 1, ?] last_alloc = 5",
+		.raid_type = BTRFS_BLOCK_GROUP_RAID0,
+		.num_stripes = 4,
+		.alloc_offsets = {
+			BTRFS_STRIPE_LEN * 2, WP_CONVENTIONAL,
+			BTRFS_STRIPE_LEN, WP_CONVENTIONAL,
+		},
+		.last_alloc = BTRFS_STRIPE_LEN * 5,
+		.expected_alloc_offset = BTRFS_STRIPE_LEN * 5,
+	},
+	{
+		.description = "RAID0: fail: stripes [2, ?, 1, ?] last_alloc = 7",
+		.raid_type = BTRFS_BLOCK_GROUP_RAID0,
+		.num_stripes = 4,
+		.alloc_offsets = {
+			BTRFS_STRIPE_LEN * 2, WP_CONVENTIONAL,
+			BTRFS_STRIPE_LEN, WP_CONVENTIONAL,
+		},
+		.last_alloc = BTRFS_STRIPE_LEN * 7,
+		.expected_result = -EIO,
+	},
+
+	/* RAID10 */
+	/* Normal case */
+	{
+		.description = "RAID10: initial partial write",
+		.raid_type = BTRFS_BLOCK_GROUP_RAID10,
+		.num_stripes = 4,
+		.alloc_offsets = {
+			HALF_STRIPE_LEN, HALF_STRIPE_LEN, 0, 0,
+		},
+		.expected_alloc_offset = HALF_STRIPE_LEN,
+	},
+	{
+		.description = "RAID10: while in second stripe",
+		.raid_type = BTRFS_BLOCK_GROUP_RAID10,
+		.num_stripes = 8,
+		.alloc_offsets = {
+			BTRFS_STRIPE_LEN * 2, BTRFS_STRIPE_LEN * 2,
+			BTRFS_STRIPE_LEN + HALF_STRIPE_LEN,
+			BTRFS_STRIPE_LEN + HALF_STRIPE_LEN,
+			BTRFS_STRIPE_LEN, BTRFS_STRIPE_LEN,
+			BTRFS_STRIPE_LEN, BTRFS_STRIPE_LEN,
+		},
+		.expected_alloc_offset = BTRFS_STRIPE_LEN * 5 + HALF_STRIPE_LEN,
+	},
+	{
+		.description = "RAID10: one stripe advanced",
+		.raid_type = BTRFS_BLOCK_GROUP_RAID10,
+		.num_stripes = 4,
+		.alloc_offsets = {
+			SZ_1M + BTRFS_STRIPE_LEN, SZ_1M + BTRFS_STRIPE_LEN,
+			SZ_1M, SZ_1M,
+		},
+		.expected_alloc_offset = SZ_2M + BTRFS_STRIPE_LEN,
+	},
+	{
+		.description = "RAID10: one stripe advanced, with conventional zone",
+		.raid_type = BTRFS_BLOCK_GROUP_RAID10,
+		.num_stripes = 4,
+		.alloc_offsets = {
+			SZ_1M + BTRFS_STRIPE_LEN, WP_CONVENTIONAL,
+			WP_CONVENTIONAL, SZ_1M,
+		},
+		.expected_alloc_offset = SZ_2M + BTRFS_STRIPE_LEN,
+	},
+	/* Error case: having different write pointers. */
+	{
+		.description = "RAID10: fail: disordered stripes",
+		.raid_type = BTRFS_BLOCK_GROUP_RAID10,
+		.num_stripes = 8,
+		.alloc_offsets = {
+			BTRFS_STRIPE_LEN, BTRFS_STRIPE_LEN,
+			BTRFS_STRIPE_LEN * 2, BTRFS_STRIPE_LEN * 2,
+			BTRFS_STRIPE_LEN, BTRFS_STRIPE_LEN,
+			BTRFS_STRIPE_LEN, BTRFS_STRIPE_LEN,
+		},
+		.expected_result = -EIO,
+	},
+	{
+		.description = "RAID10: fail: far distance",
+		.raid_type = BTRFS_BLOCK_GROUP_RAID10,
+		.num_stripes = 8,
+		.alloc_offsets = {
+			BTRFS_STRIPE_LEN * 3, BTRFS_STRIPE_LEN * 3,
+			BTRFS_STRIPE_LEN, BTRFS_STRIPE_LEN,
+			BTRFS_STRIPE_LEN, BTRFS_STRIPE_LEN,
+			BTRFS_STRIPE_LEN, BTRFS_STRIPE_LEN,
+		},
+		.expected_result = -EIO,
+	},
+	{
+		.description = "RAID10: fail: too many partial write",
+		.raid_type = BTRFS_BLOCK_GROUP_RAID10,
+		.num_stripes = 8,
+		.alloc_offsets = {
+			HALF_STRIPE_LEN, HALF_STRIPE_LEN,
+			HALF_STRIPE_LEN, HALF_STRIPE_LEN,
+			0, 0, 0, 0,
+		},
+		.expected_result = -EIO,
+	},
+	/*
+	 * Error case: Partial missing device in RAID0 level is not allowed even on
+	 * non-DEGRADED mount.
+	 */
+	{
+		.description = "RAID10: fail: missing device on DEGRADED",
+		.raid_type = BTRFS_BLOCK_GROUP_RAID10,
+		.num_stripes = 4,
+		.alloc_offsets = {
+			SZ_1M, SZ_1M,
+			WP_MISSING_DEV, WP_MISSING_DEV,
+		},
+		.degraded = true,
+		.expected_result = -EIO,
+	},
+
+	/*
+	 * One sequential zone and one conventional zone, having matching
+	 * last_alloc.
+	 */
+	{
+		.description = "RAID10: seq zone and conv zone, partially written stripe",
+		.raid_type = BTRFS_BLOCK_GROUP_RAID10,
+		.num_stripes = 4,
+		.alloc_offsets = {
+			SZ_1M, SZ_1M,
+			WP_CONVENTIONAL, WP_CONVENTIONAL,
+		},
+		.last_alloc = SZ_2M - SZ_4K,
+		.expected_alloc_offset = SZ_2M - SZ_4K,
+	},
+	{
+		.description = "RAID10: conv zone and seq zone, partially written stripe",
+		.raid_type = BTRFS_BLOCK_GROUP_RAID10,
+		.num_stripes = 4,
+		.alloc_offsets = {
+			WP_CONVENTIONAL, WP_CONVENTIONAL,
+			SZ_1M, SZ_1M,
+		},
+		.last_alloc = SZ_2M + SZ_4K,
+		.expected_alloc_offset = SZ_2M + SZ_4K,
+	},
+	/*
+	 * Error case: one sequential and one conventional zone, but having larger
+	 * last_alloc than write pointer.
+	 */
+	{
+		.description = "RAID10: fail: seq zone and conv zone, larger last_alloc",
+		.raid_type = BTRFS_BLOCK_GROUP_RAID10,
+		.num_stripes = 4,
+		.alloc_offsets = {
+			SZ_1M, SZ_1M,
+			WP_CONVENTIONAL, WP_CONVENTIONAL,
+		},
+		.last_alloc = SZ_2M + BTRFS_STRIPE_LEN * 2,
+		.expected_result = -EIO,
+	},
+
+	/* RAID10, 4 stripes with seq zones and conv zones. */
+	{
+		.description = "RAID10: stripes [2, 2, ?, ?] last_alloc = 6",
+		.raid_type = BTRFS_BLOCK_GROUP_RAID10,
+		.num_stripes = 8,
+		.alloc_offsets = {
+			BTRFS_STRIPE_LEN * 2, BTRFS_STRIPE_LEN * 2,
+			BTRFS_STRIPE_LEN * 2, BTRFS_STRIPE_LEN * 2,
+			WP_CONVENTIONAL, WP_CONVENTIONAL,
+			WP_CONVENTIONAL, WP_CONVENTIONAL,
+		},
+		.last_alloc = BTRFS_STRIPE_LEN * 6,
+		.expected_alloc_offset = BTRFS_STRIPE_LEN * 6,
+	},
+	{
+		.description = "RAID10: stripes [2, 2, ?, ?] last_alloc = 7.5",
+		.raid_type = BTRFS_BLOCK_GROUP_RAID10,
+		.num_stripes = 8,
+		.alloc_offsets = {
+			BTRFS_STRIPE_LEN * 2, BTRFS_STRIPE_LEN * 2,
+			BTRFS_STRIPE_LEN * 2, BTRFS_STRIPE_LEN * 2,
+			WP_CONVENTIONAL, WP_CONVENTIONAL,
+			WP_CONVENTIONAL, WP_CONVENTIONAL,
+		},
+		.last_alloc = BTRFS_STRIPE_LEN * 7 + HALF_STRIPE_LEN,
+		.expected_alloc_offset = BTRFS_STRIPE_LEN * 7 + HALF_STRIPE_LEN,
+	},
+	{
+		.description = "RAID10: stripes [3, ?, ?, ?] last_alloc = 1",
+		.raid_type = BTRFS_BLOCK_GROUP_RAID10,
+		.num_stripes = 8,
+		.alloc_offsets = {
+			BTRFS_STRIPE_LEN * 3, BTRFS_STRIPE_LEN * 3,
+			WP_CONVENTIONAL, WP_CONVENTIONAL,
+			WP_CONVENTIONAL, WP_CONVENTIONAL,
+			WP_CONVENTIONAL, WP_CONVENTIONAL,
+		},
+		.last_alloc = BTRFS_STRIPE_LEN,
+		.expected_alloc_offset = BTRFS_STRIPE_LEN * 9,
+	},
+	{
+		.description = "RAID10: stripes [2, ?, 1, ?] last_alloc = 5",
+		.raid_type = BTRFS_BLOCK_GROUP_RAID10,
+		.num_stripes = 8,
+		.alloc_offsets = {
+			BTRFS_STRIPE_LEN * 2, BTRFS_STRIPE_LEN * 2,
+			WP_CONVENTIONAL, WP_CONVENTIONAL,
+			BTRFS_STRIPE_LEN, BTRFS_STRIPE_LEN,
+			WP_CONVENTIONAL, WP_CONVENTIONAL,
+		},
+		.last_alloc = BTRFS_STRIPE_LEN * 5,
+		.expected_alloc_offset = BTRFS_STRIPE_LEN * 5,
+	},
+	{
+		.description = "RAID10: fail: stripes [2, ?, 1, ?] last_alloc = 7",
+		.raid_type = BTRFS_BLOCK_GROUP_RAID10,
+		.num_stripes = 8,
+		.alloc_offsets = {
+			BTRFS_STRIPE_LEN * 2, BTRFS_STRIPE_LEN * 2,
+			WP_CONVENTIONAL, WP_CONVENTIONAL,
+			BTRFS_STRIPE_LEN, BTRFS_STRIPE_LEN,
+			WP_CONVENTIONAL, WP_CONVENTIONAL,
+		},
+		.last_alloc = BTRFS_STRIPE_LEN * 7,
+		.expected_result = -EIO,
+	},
+};
+
+int btrfs_test_zoned(void)
+{
+	struct btrfs_fs_info *fs_info __free(btrfs_free_dummy_fs_info) = NULL;
+	int ret;
+
+	test_msg("running zoned tests. error messages are expected.");
+
+	fs_info = btrfs_alloc_dummy_fs_info(PAGE_SIZE, PAGE_SIZE);
+	if (!fs_info) {
+		test_std_err(TEST_ALLOC_FS_INFO);
+		return -ENOMEM;
+	}
+
+	for (int i = 0; i < ARRAY_SIZE(load_zone_info_tests); i++) {
+		ret = test_load_zone_info(fs_info, &load_zone_info_tests[i]);
+		if (ret) {
+			test_err("test case \"%s\" failed",
+				 load_zone_info_tests[i].description);
+			return ret;
+		}
+	}
+
+	return 0;
+}
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index ad8621587fd2..ae6f61bcefca 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2377,6 +2377,9 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 	if (!btrfs_is_zoned(block_group->fs_info))
 		return true;
 
+	if (unlikely(btrfs_is_testing(fs_info)))
+		return true;
+
 	map = block_group->physical_map;
 
 	spin_lock(&fs_info->zone_active_bgs_lock);
-- 
2.53.0


