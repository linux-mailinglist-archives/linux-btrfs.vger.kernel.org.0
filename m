Return-Path: <linux-btrfs+bounces-8359-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A635E98B4F1
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 08:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EBDF1F23D9D
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 06:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F061BC084;
	Tue,  1 Oct 2024 06:55:15 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2B463D;
	Tue,  1 Oct 2024 06:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727765715; cv=none; b=QgG94VhclBOZmtivquAySIUW5qW5dBwDXu3oEundxqjDTjlmwjeVub6wKz5eQo81AouqNVjwjG4zW26m6JD1QwC51Ni6FavLcaGDPb1n8MsZzgBjlWeIj30uGAXrxkR2QYRQGSK0XoVXYnykfzHGm0q4HeNePBHW+g7R64C8KqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727765715; c=relaxed/simple;
	bh=GOyyeDyj6fWzhxggBF5mXpZut9yBjmt2NC3bnGngILQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iNVmqXMDsnu8N19znfNfIjhWgliNfstdQxVTW2qQVQVpxiol2Ch4zvMfRdXG2EbJdPwSJUadQYKrNBMHN9AHx1xLk7f34TJZt/V0zTQFWppI24Bj0WDK9xRzr1pOcxEeTyP7p4DDfKUkD7VxfGwMI/OYGu1+QlqS6LAzSNYG6T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cb7a2e4d6so45846125e9.0;
        Mon, 30 Sep 2024 23:55:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727765712; x=1728370512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YVm9zO0hmmG8VhSJT1OhUAoYywpRh6CGJTKtcu5ADIU=;
        b=eXdZkKoUlrx36eHIF8cJoqgc2Zv97zRYwksL/yjFq6XHyoraq5dpLWJMhEPWrQQMIh
         BZbV/QHr3F/rVdTbSOdCwcaTq1eBlTjDo5lO0uhrTyJsdDVgG+kmDu/mTT/TIY+9x3B3
         UoeezLQAYC9VzFXMeh1TW+GmPfc2TEFEta7fr5ASlTzSMMc0cjcLKA4nvsiwjHGY4XSk
         LD0tJlGgfonOdIQC5cy7t8h1TY3z8+oJjDqOyG86g04rCETENx+0YKCu1vuWOz2zvTep
         uBztkuxGLoDqjbECjOYd0mHpGqaGA9mzmZXm7f3eh7g4MxkgchctxqvhovZjF03EG4C5
         y4Uw==
X-Forwarded-Encrypted: i=1; AJvYcCUBo3mkpixKgCaY5spkn1vKBXvi2enyE1a0OZjpeUz0P5E+Kshr8T9Q3UCVWZSwSUdFjgsYIJfNrOBENmbd@vger.kernel.org, AJvYcCWJTfVT2QeAQ0Arp+VI58JKVNWIqeFPWZ9uSsEYyPz2VnszhncStl8l1nkS6qGrnvkbv7NNUCgHwODXPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXzc/qkMvIt7GjpDGHcs1X0YL7WfTbFogCfJNzfEg/tDwVRXmZ
	tnzjhQ+cHizG76GviAPqAxCaSJZdx/qzr5MbXJfU/9UbvlL72YwZ
X-Google-Smtp-Source: AGHT+IH+aoGP+iO4PeEcbkncB0Ts6hCuoastxodeI1T4zW3DTSD4BeI6W3LIJ1a2USlVo5jrYHTmLg==
X-Received: by 2002:a05:600c:3ca6:b0:42c:b750:19d8 with SMTP id 5b1f17b1804b1-42f5840b379mr117052085e9.4.1727765711308;
        Mon, 30 Sep 2024 23:55:11 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f71aeb00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f71a:eb00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57e30621sm126960045e9.47.2024.09.30.23.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 23:55:10 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM)
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2] btrfs: tests: add selftests for RAID stripe-tree
Date: Tue,  1 Oct 2024 08:54:38 +0200
Message-ID: <20241001065451.2378-1-jth@kernel.org>
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
 fs/btrfs/tests/raid-stripe-tree-tests.c | 285 ++++++++++++++++++++++++
 fs/btrfs/volumes.c                      |   6 +-
 fs/btrfs/volumes.h                      |   5 +
 8 files changed, 307 insertions(+), 6 deletions(-)
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
index 000000000000..7b6380d3a44c
--- /dev/null
+++ b/fs/btrfs/tests/raid-stripe-tree-tests.c
@@ -0,0 +1,285 @@
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
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	io_stripe.dev = btrfs_device_by_devid(fs_info->fs_devices, 0);
+
+	for (int i = 0; i < RST_TEST_NUM_DEVICES; i++) {
+		struct btrfs_io_stripe *stripe = &bioc->stripes[i];
+		struct btrfs_device *dev;
+
+		dev = btrfs_device_by_devid(fs_info->fs_devices, i);
+		if (!dev) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		stripe->dev = dev;
+		stripe->physical = logical + i * SZ_1G;
+	}
+
+	ret = btrfs_insert_one_raid_extent(trans, bioc);
+	if (ret)
+		goto out;
+
+	io_stripe.dev = btrfs_device_by_devid(fs_info->fs_devices, 0);
+	if (!io_stripe.dev) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = btrfs_get_raid_extent_offset(fs_info, logical, &len, map_type, 0,
+					   &io_stripe);
+	if (ret)
+		goto out;
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
+		struct btrfs_device *dev;
+
+		dev = btrfs_device_by_devid(fs_info->fs_devices, i);
+		if (!dev) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		stripe->dev = dev;
+		stripe->physical = SZ_1G + logical + i * SZ_1G;
+	}
+
+	ret = btrfs_insert_one_raid_extent(trans, bioc);
+	if (ret)
+		goto out;
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
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	bioc->map_type = map_type;
+	bioc->size = SZ_64K;
+
+	for (int i = 0; i < RST_TEST_NUM_DEVICES; i++) {
+		struct btrfs_io_stripe *stripe = &bioc->stripes[i];
+		struct btrfs_device *dev;
+
+		dev = btrfs_device_by_devid(fs_info->fs_devices, i);
+		if (!dev) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		stripe->dev = dev;
+		stripe->physical = logical + i * SZ_1G;
+	}
+
+	ret = btrfs_insert_one_raid_extent(trans, bioc);
+	if (ret)
+		goto out;
+
+	io_stripe.dev = btrfs_device_by_devid(fs_info->fs_devices, 0);
+	if (!io_stripe.dev) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = btrfs_get_raid_extent_offset(fs_info, logical, &len, map_type, 0,
+					   &io_stripe);
+	if (ret)
+		goto out;
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
+		if (ret)
+			goto out;
+	}
+
+out:
+	return ret;
+}
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 668138451f7c..6ff64a30349f 100644
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


