Return-Path: <linux-btrfs+bounces-8424-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B03198D0E3
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 12:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 581F1282612
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 10:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348DE1E501C;
	Wed,  2 Oct 2024 10:12:15 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC001FA5;
	Wed,  2 Oct 2024 10:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727863934; cv=none; b=lrCAfLqatIfjJxBrAT0SCa/B3W1N6V/3oDPzwTocAU0wuyoci303S10XzIox0kyyYvMvKjZlrGYmQx4mwh0ZZrdOy7FblDpWTh5B5pW/DYAe2jV6ifude23p9woup3r5exRlPt8i+2TRA7u8sXGt58Z1Y9iPnqR+ssPlfqpY3Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727863934; c=relaxed/simple;
	bh=T/48nWYDRgQVq8lerq9dbty7BdzbPvdj/FuGFgHDMZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hh4U/Rjvse1S6iZdejThIPmhJ1nj1rgQNydQqEDXnmHCu9m4aHq0oejkwb0LzHyv8Fdz8mvIa3txOTSWRxb7RF9sYXGdEjIbHuQzOrcNy2FKpzbap5ZGFNZSVZT8lL5DdzIEg43LTCarWWvBw0Z3N2oqSJWy1dYX7KLBg1g4DJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37cd3419937so3358399f8f.0;
        Wed, 02 Oct 2024 03:12:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727863931; x=1728468731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m1NCg6Cx85PfqT+5C/oSePgIJX88YwTlmNLDviS6BLE=;
        b=BCdK0o8pWYRrh6CPzon2YvG401XbNnLMQRlx89fuErqLMsHhjz3K+B37zDcrGIHBzj
         tymMjWpm3JMmIiOm320h8uxHawdVLoow9VYTK10JKgPfkh+NJID5XvHMZI7UukqdLUnr
         o966gdhOZ2Q84N2LvZrxzw9bvWA775RPUE8WeuXn5oSzU3QpPAQmMA6Bpo0wm6OEDDHi
         3Duzf+bk7NnH93WnUXBQoAg0DyfRxkTzqySyCSyWLjm5bMR+GnqExDRreavgb/wzR8b0
         EkS1Omsl3+53m0Wf3ugaLg8ZYalaIOxaoU51R+6o+2S8rbeNUSnk+LvvQUDuCoCtj4gh
         Q+lw==
X-Forwarded-Encrypted: i=1; AJvYcCUh5CA5lmFXhXi9KZmYP6m4mbGxe60ElSz4C8OT5WOtmEuXHioVCH0iPAWZNT6iTHhJgza92dNaU2wGSQ==@vger.kernel.org, AJvYcCXwVAz+hCl3vy2UXBE/hgTghzyBpvdoH0hc30lNcqK89PgWK5WfqJvChh8Q0gB8VokeFY9mojDA/9lImlaZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw50KJcg6sBc6lpWQdHPI4MzEI20OZj+TuNxCKvha0PVSfw+bcM
	ByT/swHIlD0hXRxem2vgbFpwvu+3cXdofXshENfmR8jVX8W+1j19
X-Google-Smtp-Source: AGHT+IHcbLs+9DzSgTlfm0dIGIvsnRJDiIMm1dxIS05yl+sRUOVlMxi/rkmnXNnNI9Nmo6bQu1nW8g==
X-Received: by 2002:a05:6000:11c7:b0:37c:d507:aac9 with SMTP id ffacd0b85a97d-37cfb8d02ffmr1257754f8f.17.1727863930617;
        Wed, 02 Oct 2024 03:12:10 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f71aeb00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f71a:eb00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd574268bsm13574706f8f.97.2024.10.02.03.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 03:12:10 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM)
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3] btrfs: tests: add selftests for RAID stripe-tree
Date: Wed,  2 Oct 2024 12:11:48 +0200
Message-ID: <20241002101200.14543-1-jth@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Add first stash of very basic self tests for the RAID stripe-tree.

More test cases will follow exercising the tree.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
Changes to v2:
* Fix update test-case
* Remove local btrfs_device variables (Filipe)
* Add prints to see where a test-case failed (Filipe)

Link to v2:
https://lore.kernel.org/linux-btrfs/20241001065451.2378-1-jth@kernel.org

Changes to v1:
* Fix build errors with CONFIG_BTRFS_FS_RUN_SANITY_TESTS=n
* Document expectations from the test cases

Link to v1:
https://lore.kernel.org/linux-btrfs/20240930104054.12290-1-jth@kernel.org

 fs/btrfs/Makefile                       |   3 +-
 fs/btrfs/raid-stripe-tree.c             |   5 +-
 fs/btrfs/raid-stripe-tree.h             |   5 +
 fs/btrfs/tests/btrfs-tests.c            |   3 +
 fs/btrfs/tests/btrfs-tests.h            |   1 +
 fs/btrfs/tests/raid-stripe-tree-tests.c | 315 ++++++++++++++++++++++++
 fs/btrfs/volumes.c                      |   6 +-
 fs/btrfs/volumes.h                      |   5 +
 8 files changed, 337 insertions(+), 6 deletions(-)
 create mode 100644 fs/btrfs/tests/raid-stripe-tree-tests.c

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index 87617f2968bc..3cfc440c636c 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -43,4 +43,5 @@ btrfs-$(CONFIG_FS_VERITY) += verity.o
 btrfs-$(CONFIG_BTRFS_FS_RUN_SANITY_TESTS) += tests/free-space-tests.o \
 	tests/extent-buffer-tests.o tests/btrfs-tests.o \
 	tests/extent-io-tests.o tests/inode-tests.o tests/qgroup-tests.o \
-	tests/free-space-tree-tests.o tests/extent-map-tests.o
+	tests/free-space-tree-tests.o tests/extent-map-tests.o \
+	tests/raid-stripe-tree-tests.o
diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 4c859b550f6c..b7787a8e4af2 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -108,8 +108,9 @@ static int update_raid_extent_item(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-static int btrfs_insert_one_raid_extent(struct btrfs_trans_handle *trans,
-					struct btrfs_io_context *bioc)
+EXPORT_FOR_TESTS
+int btrfs_insert_one_raid_extent(struct btrfs_trans_handle *trans,
+				 struct btrfs_io_context *bioc)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_key stripe_key;
diff --git a/fs/btrfs/raid-stripe-tree.h b/fs/btrfs/raid-stripe-tree.h
index 1ac1c21aac2f..541836421778 100644
--- a/fs/btrfs/raid-stripe-tree.h
+++ b/fs/btrfs/raid-stripe-tree.h
@@ -28,6 +28,11 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
 int btrfs_insert_raid_extent(struct btrfs_trans_handle *trans,
 			     struct btrfs_ordered_extent *ordered_extent);
 
+#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
+int btrfs_insert_one_raid_extent(struct btrfs_trans_handle *trans,
+				 struct btrfs_io_context *bioc);
+#endif
+
 static inline bool btrfs_need_stripe_tree_update(struct btrfs_fs_info *fs_info,
 						 u64 map_type)
 {
diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
index ce50847e1e01..18e1ab4a0914 100644
--- a/fs/btrfs/tests/btrfs-tests.c
+++ b/fs/btrfs/tests/btrfs-tests.c
@@ -291,6 +291,9 @@ int btrfs_run_sanity_tests(void)
 			ret = btrfs_test_free_space_tree(sectorsize, nodesize);
 			if (ret)
 				goto out;
+			ret = btrfs_test_raid_stripe_tree(sectorsize, nodesize);
+			if (ret)
+				goto out;
 		}
 	}
 	ret = btrfs_test_extent_map();
diff --git a/fs/btrfs/tests/btrfs-tests.h b/fs/btrfs/tests/btrfs-tests.h
index dc2f2ab15fa5..61bcadaf2036 100644
--- a/fs/btrfs/tests/btrfs-tests.h
+++ b/fs/btrfs/tests/btrfs-tests.h
@@ -37,6 +37,7 @@ int btrfs_test_extent_io(u32 sectorsize, u32 nodesize);
 int btrfs_test_inodes(u32 sectorsize, u32 nodesize);
 int btrfs_test_qgroups(u32 sectorsize, u32 nodesize);
 int btrfs_test_free_space_tree(u32 sectorsize, u32 nodesize);
+int btrfs_test_raid_stripe_tree(u32 sectorsize, u32 nodesize);
 int btrfs_test_extent_map(void);
 struct inode *btrfs_new_test_inode(void);
 struct btrfs_fs_info *btrfs_alloc_dummy_fs_info(u32 nodesize, u32 sectorsize);
diff --git a/fs/btrfs/tests/raid-stripe-tree-tests.c b/fs/btrfs/tests/raid-stripe-tree-tests.c
new file mode 100644
index 000000000000..94f3cd9d2661
--- /dev/null
+++ b/fs/btrfs/tests/raid-stripe-tree-tests.c
@@ -0,0 +1,315 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Western Digital Corporation or its affiliates.
+ */
+
+#include <linux/sizes.h>
+#include "../fs.h"
+#include "../disk-io.h"
+#include "../transaction.h"
+#include "../volumes.h"
+#include "../raid-stripe-tree.h"
+#include "btrfs-tests.h"
+
+#define RST_TEST_NUM_DEVICES	2
+#define RST_TEST_RAID1_TYPE	(BTRFS_BLOCK_GROUP_DATA | BTRFS_BLOCK_GROUP_RAID1)
+
+typedef int (*test_func_t)(struct btrfs_trans_handle *trans);
+
+static struct btrfs_device *btrfs_device_by_devid(struct btrfs_fs_devices *fs_devices,
+						  u64 devid)
+{
+	struct btrfs_device *dev;
+
+	list_for_each_entry(dev, &fs_devices->devices, dev_list) {
+		if (dev->devid == devid)
+			return dev;
+	}
+
+	return NULL;
+}
+
+/*
+ * Test a 64k RST write on a 2 disk RAID1 at a logical address of 1M and then
+ * overwrite the whole range giving it new physical address at an offset of 1G.
+ * The intent of this test is to exercise the 'update_raid_extent_item()'
+ * function called be btrfs_insert_one_raid_extent().
+ */
+static int test_create_update_delete(struct btrfs_trans_handle *trans)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_io_context *bioc;
+	struct btrfs_io_stripe io_stripe = { };
+	u64 map_type = RST_TEST_RAID1_TYPE;
+	u64 logical = SZ_1M;
+	u64 len = SZ_64K;
+	int ret;
+
+	bioc = alloc_btrfs_io_context(fs_info, logical, RST_TEST_NUM_DEVICES);
+	if (!bioc) {
+		test_err("failed to allocate a btrfs_io_context");
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	io_stripe.dev = btrfs_device_by_devid(fs_info->fs_devices, 0);
+	bioc->map_type = map_type;
+	bioc->size = len;
+
+	for (int i = 0; i < RST_TEST_NUM_DEVICES; i++) {
+		struct btrfs_io_stripe *stripe = &bioc->stripes[i];
+
+		stripe->dev = btrfs_device_by_devid(fs_info->fs_devices, i);
+		if (!stripe->dev) {
+			test_err("cannot find device with devid %d", i);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		stripe->physical = logical + i * SZ_1G;
+	}
+
+	ret = btrfs_insert_one_raid_extent(trans, bioc);
+	if (ret) {
+		test_err("inserting RAID extent failed: %d", ret);
+		goto out;
+	}
+
+	io_stripe.dev = btrfs_device_by_devid(fs_info->fs_devices, 0);
+	if (!io_stripe.dev) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = btrfs_get_raid_extent_offset(fs_info, logical, &len, map_type, 0,
+					   &io_stripe);
+	if (ret) {
+		test_err("lookup for RAID extent [%llu, %llu] failed", logical,
+			 logical + len);
+		goto out;
+	}
+
+	if (io_stripe.physical != logical) {
+		test_err("invalid physical address, expected %llu, got %llu",
+			 logical, io_stripe.physical);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (len != SZ_64K) {
+		test_err("invalid stripe length, expected %llu, got %llu",
+			 (u64)SZ_64K, len);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	for (int i = 0; i < RST_TEST_NUM_DEVICES; i++) {
+		struct btrfs_io_stripe *stripe = &bioc->stripes[i];
+
+		stripe->dev = btrfs_device_by_devid(fs_info->fs_devices, i);
+		if (!stripe->dev) {
+			test_err("cannot find device with devid %d", i);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		stripe->physical = SZ_1G + logical + i * SZ_1G;
+	}
+
+	ret = btrfs_insert_one_raid_extent(trans, bioc);
+	if (ret) {
+		test_err("updating RAID extent failed: %d", ret);
+		goto out;
+	}
+
+	ret = btrfs_get_raid_extent_offset(fs_info, logical, &len, map_type, 0,
+					   &io_stripe);
+	if (ret) {
+		test_err("lookup for RAID extent [%llu, %llu] failed", logical,
+			 logical + len);
+		goto out;
+	}
+
+	if (io_stripe.physical != logical + SZ_1G) {
+		test_err("invalid physical address, expected %llu, got %llu",
+			 logical + SZ_1G, io_stripe.physical);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (len != SZ_64K) {
+		test_err("invalid stripe length, expected %llu, got %llu",
+			 (u64)SZ_64K, len);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = btrfs_delete_raid_extent(trans, logical, len);
+	if (ret)
+		test_err("deleting RAID extent [%llu, %llu] failed", logical,
+			 logical + len);
+
+out:
+	btrfs_put_bioc(bioc);
+	return ret;
+}
+
+/*
+ * Test a simple 64k RST write on a 2 disk RAID1 at a logical address of 1M.
+ * The "physical" copy on device 0 is at 1M, on device 1 it is at 1G+1M.
+ */
+static int test_simple_create_delete(struct btrfs_trans_handle *trans)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_io_context *bioc;
+	struct btrfs_io_stripe io_stripe = { };
+	u64 map_type = RST_TEST_RAID1_TYPE;
+	u64 logical = SZ_1M;
+	u64 len = SZ_64K;
+	int ret;
+
+	bioc = alloc_btrfs_io_context(fs_info, logical, RST_TEST_NUM_DEVICES);
+	if (!bioc) {
+		test_err("failed to allocate a btrfs_io_context");
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	bioc->map_type = map_type;
+	bioc->size = SZ_64K;
+
+	for (int i = 0; i < RST_TEST_NUM_DEVICES; i++) {
+		struct btrfs_io_stripe *stripe = &bioc->stripes[i];
+
+		stripe->dev = btrfs_device_by_devid(fs_info->fs_devices, i);
+		if (!stripe->dev) {
+			test_err("cannot find device with devid %d", i);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		stripe->physical = logical + i * SZ_1G;
+	}
+
+	ret = btrfs_insert_one_raid_extent(trans, bioc);
+	if (ret) {
+		test_err("inserting RAID extent failed: %d", ret);
+		goto out;
+	}
+
+	io_stripe.dev = btrfs_device_by_devid(fs_info->fs_devices, 0);
+	if (!io_stripe.dev) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = btrfs_get_raid_extent_offset(fs_info, logical, &len, map_type, 0,
+					   &io_stripe);
+	if (ret)  {
+		test_err("lookup for RAID extent [%llu, %llu] failed", logical,
+			 logical + len);
+		goto out;
+	}
+
+	if (io_stripe.physical != logical) {
+		test_err("invalid physical address, expected %llu, got %llu",
+			 logical, io_stripe.physical);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (len != SZ_64K) {
+		test_err("invalid stripe length, expected %llu, got %llu",
+			 (u64)SZ_64K, len);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = btrfs_delete_raid_extent(trans, logical, len);
+	if (ret)
+		test_err("deleting RAID extent [%llu, %llu] failed", logical,
+			 logical + len);
+
+out:
+	btrfs_put_bioc(bioc);
+	return ret;
+}
+
+test_func_t tests[] = {
+	test_simple_create_delete,
+	test_create_update_delete,
+};
+
+static int run_test(test_func_t test, u32 sectorsize, u32 nodesize)
+{
+	struct btrfs_trans_handle trans;
+	struct btrfs_fs_info *fs_info;
+	struct btrfs_root *root = NULL;
+	int ret;
+
+	fs_info = btrfs_alloc_dummy_fs_info(sectorsize, nodesize);
+	if (!fs_info) {
+		test_std_err(TEST_ALLOC_FS_INFO);
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	root = btrfs_alloc_dummy_root(fs_info);
+	if (IS_ERR(root)) {
+		test_std_err(TEST_ALLOC_ROOT);
+		ret = PTR_ERR(root);
+		goto out;
+	}
+	btrfs_set_super_compat_ro_flags(root->fs_info->super_copy,
+		BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE);
+	root->root_key.objectid = BTRFS_RAID_STRIPE_TREE_OBJECTID;
+	root->root_key.type = BTRFS_ROOT_ITEM_KEY;
+	root->root_key.offset = 0;
+	fs_info->stripe_root = root;
+	root->fs_info->tree_root = root;
+
+	root->node = alloc_test_extent_buffer(root->fs_info, nodesize);
+	if (IS_ERR(root->node)) {
+		test_std_err(TEST_ALLOC_EXTENT_BUFFER);
+		ret = PTR_ERR(root->node);
+		goto out;
+	}
+	btrfs_set_header_level(root->node, 0);
+	btrfs_set_header_nritems(root->node, 0);
+	root->alloc_bytenr += 2 * nodesize;
+
+	for (int i = 0; i < RST_TEST_NUM_DEVICES; i++) {
+		struct btrfs_device *dev;
+
+		dev = btrfs_alloc_dummy_device(fs_info);
+		dev->devid = i;
+	}
+
+	btrfs_init_dummy_trans(&trans, root->fs_info);
+	ret = test(&trans);
+	if (ret)
+		goto out;
+
+out:
+	btrfs_free_dummy_root(root);
+	btrfs_free_dummy_fs_info(fs_info);
+
+	return ret;
+}
+
+int btrfs_test_raid_stripe_tree(u32 sectorsize, u32 nodesize)
+{
+	int ret = 0;
+
+	test_msg("running RAID stripe-tree tests");
+	for (int i = 0; i < ARRAY_SIZE(tests); i++) {
+		ret = run_test(tests[i], sectorsize, nodesize);
+		if (ret) {
+			test_err("test-case %ps failed with %d\n", tests[i], ret);
+			goto out;
+		}
+	}
+
+out:
+	return ret;
+}
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 9a0fcebf34da..35c4d151b5b0 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6022,9 +6022,9 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
 	return preferred_mirror;
 }
 
-static struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs_info *fs_info,
-						       u64 logical,
-						       u16 total_stripes)
+EXPORT_FOR_TESTS
+struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs_info *fs_info,
+						u64 logical, u16 total_stripes)
 {
 	struct btrfs_io_context *bioc;
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 26e35fc1c8fd..3ebb3c2732b0 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -840,4 +840,9 @@ bool btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical);
 bool btrfs_pinned_by_swapfile(struct btrfs_fs_info *fs_info, void *ptr);
 const u8 *btrfs_sb_fsid_ptr(const struct btrfs_super_block *sb);
 
+#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
+struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs_info *fs_info,
+						u64 logical, u16 total_stripes);
+#endif
+
 #endif
-- 
2.43.0


