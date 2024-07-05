Return-Path: <linux-btrfs+bounces-6231-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4894D928B62
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2024 17:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDE431F229D5
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2024 15:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3208816EBE3;
	Fri,  5 Jul 2024 15:14:04 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD7116D4F7;
	Fri,  5 Jul 2024 15:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720192443; cv=none; b=bUjwnOLUaqn6FelKfF6Aul6qg5+LRwcoGIeFwztZBu+r8135i/3y/65MKicsshXFeKYyKEoW4pcYJafNV1e2Gud0zYGofpRiZfIGT7P9/kA9f1PLlqA9E10iT0WRvuZZEmjn29xMlPJpIoxAMq6SbQCQqTONBtL69tWPY8Pc8TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720192443; c=relaxed/simple;
	bh=/3l1jXBu0VpItMhctO55F8Gr7ik+tgM/KNLoI2d0PZA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L7NQZuJ7k9lOiKx8mxUvub199Og/IH81gqVT/j8+SWWznkwDw43ZnxSjEwYuZCEo6mN/mjBJfRxi5leHONn45QtIKetG95yVt9R0IkjHChAwbjpa48hbV5nKl7nvHNeIpNj/0c8dVNKG8HCS8lkMx00/ATqgWwjSkY2sW5yWfjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a72988749f0so239721466b.0;
        Fri, 05 Jul 2024 08:14:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720192440; x=1720797240;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aZNMpxbYZfZkGHpatVbKT88mSuPlBT+CABFw4C25AbE=;
        b=w2jK4JCL0Nv+NN+lhG8EGsOojm3WFopHdVlj1HgIPaF+Izwia4xYNDOnOvdTgRGe8X
         0y9HoE088R6ML67PK/FYKEJfNtNyM9iJFHckQYnUy0A0kmJo6PEO/xyYnE7eBEqos/fM
         2+vLKjU4p4LIdO/hs4Q6bvFtZqhpXLB8ZvycM22BU5rIm8qteeTayx8YNvyiomP9A4xO
         due8yWF2B4oeWYOI+ZO1zHtSFaTm/ojQbMdWBLLjyWY7B8glHM55mWMNqZFqfP+aiSWS
         Xw9vH3YHAGL73XM6ZEqMZK7GdEuDNA2dn4ntAk/eEg+1FhYFAllmAKMXxZYbmuZ5nYT0
         0Q5g==
X-Forwarded-Encrypted: i=1; AJvYcCXCUhv+xhJ8FsioUljDGd1sjIE2hnJySGlpT3x1p5QKL1VQpZSGw+r0NCoEA78VgUK3+wPsQttm6CwqCdQU82YLeD1AcUO8CaYra4Ye
X-Gm-Message-State: AOJu0Yx1OtDnfAo1qn7b0ixtLF4Na3oBPT6IYZ/F38+WOs4VKMpbU8zk
	QWK5QGYKHYs1n7debbCr6IxXMhuC8ovhGcdvi7nQxbmw1flWL62OU+NIBA==
X-Google-Smtp-Source: AGHT+IFZYebBd7ET2GyP0gUoP/PU5eToH1JLr7N88xojaervcPl+0o2BweeiZIsT7eTYOUjVzv5GrQ==
X-Received: by 2002:a17:907:60d3:b0:a72:b4c9:2be8 with SMTP id a640c23a62f3a-a77ba7279a7mr425387366b.72.1720192439975;
        Fri, 05 Jul 2024 08:13:59 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f72f3200fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f72f:3200:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72aaf6336csm686226566b.70.2024.07.05.08.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 08:13:59 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Fri, 05 Jul 2024 17:13:50 +0200
Subject: [PATCH v4 4/7] btrfs: stripe-tree: add selftests
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-b4-rst-updates-v4-4-f3eed3f2cfad@kernel.org>
References: <20240705-b4-rst-updates-v4-0-f3eed3f2cfad@kernel.org>
In-Reply-To: <20240705-b4-rst-updates-v4-0-f3eed3f2cfad@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=11628; i=jth@kernel.org;
 h=from:subject:message-id; bh=fenVcePD9xkTySZuXQQD75LcFDttc4Aqso8ZFozVdB4=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaR18G7ifLR6VUTfRwNVnqS3do8iV1hIbGnL3yI/ndvyh
 K39dNmfHaUsDGJcDLJiiizHQ233S5geYZ9y6LUZzBxWJpAhDFycAjCR52cZGQ4cLI3nz+tq/+Ca
 cXSaksm950slXzIW5J98WZLI8auh3ofhv59Zl53DOtfDb//89OWeEdH32LnX2jabJUX5UmHqJ/8
 vrAA=
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Add self-tests for the RAID stripe tree code.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/Makefile                       |   3 +-
 fs/btrfs/raid-stripe-tree.c             |   3 +-
 fs/btrfs/raid-stripe-tree.h             |   5 +
 fs/btrfs/tests/btrfs-tests.c            |   3 +
 fs/btrfs/tests/btrfs-tests.h            |   1 +
 fs/btrfs/tests/raid-stripe-tree-tests.c | 322 ++++++++++++++++++++++++++++++++
 6 files changed, 335 insertions(+), 2 deletions(-)

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
index d2a6e409b3e8..ba0733c6be76 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -156,7 +156,8 @@ static int replace_raid_extent_item(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-static int btrfs_insert_one_raid_extent(struct btrfs_trans_handle *trans,
+EXPORT_FOR_TESTS
+int btrfs_insert_one_raid_extent(struct btrfs_trans_handle *trans,
 					struct btrfs_io_context *bioc)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
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
index 000000000000..bec7c210c14c
--- /dev/null
+++ b/fs/btrfs/tests/raid-stripe-tree-tests.c
@@ -0,0 +1,322 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Western Digital Corporation.  All rights reserved.
+ */
+#include <linux/array_size.h>
+#include <linux/sizes.h>
+#include <linux/btrfs.h>
+#include <linux/btrfs_tree.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include "btrfs-tests.h"
+#include "../disk-io.h"
+#include "../transaction.h"
+#include "../volumes.h"
+#include "../raid-stripe-tree.h"
+#include "../block-group.h"
+
+static struct btrfs_io_context *alloc_dummy_bioc(struct btrfs_fs_info *fs_info,
+						 u64 logical, u16 total_stripes)
+{
+	struct btrfs_io_context *bioc;
+
+	bioc = kzalloc(sizeof(struct btrfs_io_context) +
+		       sizeof(struct btrfs_io_stripe) * total_stripes,
+		       GFP_KERNEL);
+
+	if (!bioc)
+		return NULL;
+
+	refcount_set(&bioc->refs, 1);
+
+	bioc->fs_info = fs_info;
+	bioc->replace_stripe_src = -1;
+	bioc->full_stripe_logical = (u64)-1;
+	bioc->logical = logical;
+
+	return bioc;
+}
+
+typedef int (*test_func_t)(struct btrfs_fs_info *);
+
+static int test_stripe_tree_delete_tail(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_trans_handle trans;
+	struct btrfs_io_context *bioc;
+	struct btrfs_io_stripe stripe = { };
+	const u64 map_type = BTRFS_BLOCK_GROUP_DATA | BTRFS_BLOCK_GROUP_RAID1;
+	const int total_stripes = btrfs_bg_type_to_factor(map_type);
+	u64 logical = SZ_8K;
+	u64 length = SZ_64K;
+	u64 read_length;
+	int i;
+	int last = 0;
+	int ret;
+
+	btrfs_init_dummy_trans(&trans, fs_info);
+
+	bioc = alloc_dummy_bioc(fs_info, logical, total_stripes);
+	if (!bioc)
+		return -ENOMEM;
+
+	bioc->size = length;
+	bioc->map_type = map_type;
+	for (i = 0; i < total_stripes; ++i) {
+		struct btrfs_device *dev;
+
+		dev = kzalloc(sizeof(struct btrfs_device), GFP_KERNEL);
+		if (!dev) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		dev->devid = i;
+		bioc->stripes[i].dev = dev;
+		bioc->stripes[i].length = length;
+		bioc->stripes[i].physical = i * SZ_8K;
+		last = i;
+	}
+
+	ret = btrfs_insert_one_raid_extent(&trans, bioc);
+	if (ret)
+		goto out;
+
+	ret = btrfs_delete_raid_extent(&trans, logical, SZ_16K);
+	if (ret)
+		goto out;
+
+	stripe.dev = bioc->stripes[last].dev;
+	read_length = length - SZ_16K;
+	ret = btrfs_get_raid_extent_offset(fs_info, logical,
+					   &read_length, map_type, 0, &stripe);
+	if (ret)
+		goto out;
+
+	if (read_length != length - SZ_16K) {
+		test_err("invalid length %llu vs %llu", read_length,
+			 length - SZ_16K);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (stripe.physical != bioc->stripes[last].physical) {
+		test_err("invalid physical %llu vs %llu", stripe.physical,
+			 bioc->stripes[last].physical);
+		ret = -EINVAL;
+	}
+
+out:
+	for (i = 0; i < total_stripes; i++)
+		kfree(bioc->stripes[i].dev);
+
+	kfree(bioc);
+	return ret;
+}
+
+static int test_stripe_tree_delete_front(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_trans_handle trans;
+	struct btrfs_io_context *bioc;
+	const u64 map_type = BTRFS_BLOCK_GROUP_DATA | BTRFS_BLOCK_GROUP_RAID1;
+	const int total_stripes = btrfs_bg_type_to_factor(map_type);
+	u64 logical = SZ_8K;
+	u64 length = SZ_64K;
+	u64 read_length;
+	struct btrfs_io_stripe stripe = { };
+	int i;
+	int last = 0;
+	int ret;
+
+	btrfs_init_dummy_trans(&trans, fs_info);
+
+	bioc = alloc_dummy_bioc(fs_info, logical, total_stripes);
+	if (!bioc)
+		return -ENOMEM;
+
+	bioc->size = length;
+	bioc->map_type = map_type;
+	for (i = 0; i < total_stripes; i++) {
+		struct btrfs_device *dev;
+
+		dev = kzalloc(sizeof(struct btrfs_device), GFP_KERNEL);
+		if (!dev) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		dev->devid = i;
+		bioc->stripes[i].dev = dev;
+		bioc->stripes[i].length = length;
+		bioc->stripes[i].physical = i * SZ_8K;
+		last = i;
+	}
+
+	ret = btrfs_insert_one_raid_extent(&trans, bioc);
+	if (ret)
+		goto out;
+
+	ret = btrfs_delete_raid_extent(&trans, logical, SZ_8K);
+	if (ret)
+		goto out;
+
+	stripe.dev = bioc->stripes[last].dev;
+	read_length = length - SZ_8K;
+	ret = btrfs_get_raid_extent_offset(fs_info, logical + SZ_8K,
+					   &read_length, map_type, 0, &stripe);
+	if (ret)
+		goto out;
+
+	if (read_length != length - SZ_8K) {
+		test_err("invalid length %llu vs %llu", read_length,
+			 length - SZ_8K);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (stripe.physical != bioc->stripes[last].physical + SZ_8K) {
+		test_err("invalid physical %llu vs %llu", stripe.physical,
+			 bioc->stripes[last].physical);
+		ret = -EINVAL;
+	}
+
+out:
+	for (i = 0; i < total_stripes; i++)
+		kfree(bioc->stripes[i].dev);
+
+	kfree(bioc);
+	return ret;
+
+}
+
+static int test_stripe_tree_delete_whole(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_trans_handle trans;
+	struct btrfs_io_context *bioc;
+	const u64 map_type = BTRFS_BLOCK_GROUP_DATA | BTRFS_BLOCK_GROUP_RAID1;
+	const int total_stripes = btrfs_bg_type_to_factor(map_type);
+	u64 logical = SZ_8K;
+	u64 length = SZ_64K;
+	int i;
+	int ret;
+
+	btrfs_init_dummy_trans(&trans, fs_info);
+
+	bioc = alloc_dummy_bioc(fs_info, logical, total_stripes);
+	if (!bioc)
+		return -ENOMEM;
+
+	bioc->size = length;
+	bioc->map_type = map_type;
+	for (i = 0; i < total_stripes; ++i) {
+		struct btrfs_device *dev;
+
+		dev = kzalloc(sizeof(struct btrfs_device), GFP_KERNEL);
+		if (!dev) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		dev->devid = i;
+		bioc->stripes[i].dev = dev;
+		bioc->stripes[i].length = length;
+		bioc->stripes[i].physical = i * SZ_8K;
+	}
+
+	ret = btrfs_insert_one_raid_extent(&trans, bioc);
+	if (ret)
+		goto out;
+
+	ret = btrfs_delete_raid_extent(&trans, logical, length);
+	if (ret)
+		goto out;
+
+	ret = btrfs_header_nritems(fs_info->stripe_root->node);
+	if (ret != 0) {
+		test_err("test failed");
+		ret = -EINVAL;
+	}
+
+out:
+	for (i = 0; i < total_stripes; i++)
+		kfree(bioc->stripes[i].dev);
+
+	kfree(bioc);
+	return ret;
+}
+
+static int test_stripe_tree_delete(struct btrfs_fs_info *fs_info)
+{
+	test_func_t delete_tests[] = {
+		test_stripe_tree_delete_whole,
+		test_stripe_tree_delete_front,
+		test_stripe_tree_delete_tail,
+	};
+	int ret;
+
+	for (int i = 0; i < ARRAY_SIZE(delete_tests); i++) {
+		test_func_t test = delete_tests[i];
+
+		ret = test(fs_info);
+		if (ret)
+			goto out;
+	}
+
+out:
+	return ret;
+}
+
+int btrfs_test_raid_stripe_tree(u32 sectorsize, u32 nodesize)
+{
+	test_func_t tests[] = {
+		test_stripe_tree_delete,
+	};
+	struct btrfs_fs_info *fs_info;
+	struct btrfs_root *root = NULL;
+	int ret = 0;
+
+	test_msg("running raid stripe tree tests");
+
+	fs_info = btrfs_alloc_dummy_fs_info(nodesize, sectorsize);
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
+
+	root->root_key.objectid = BTRFS_RAID_STRIPE_TREE_OBJECTID;
+	root->root_key.type = BTRFS_ROOT_ITEM_KEY;
+	root->root_key.offset = 0;
+	btrfs_global_root_insert(root);
+	root->fs_info->stripe_root = root;
+	root->fs_info->tree_root = root;
+	btrfs_set_super_incompat_flags(fs_info->super_copy,
+				       BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE);
+
+
+	root->node = alloc_test_extent_buffer(fs_info, nodesize);
+	if (IS_ERR(root->node)) {
+		test_std_err(TEST_ALLOC_EXTENT_BUFFER);
+		ret = PTR_ERR(root->node);
+		goto out;
+	}
+	btrfs_set_header_level(root->node, 0);
+	btrfs_set_header_nritems(root->node, 0);
+	root->alloc_bytenr += 2 * nodesize;
+
+	for (int i = 0; i < ARRAY_SIZE(tests); i++) {
+		test_func_t test = tests[i];
+
+		ret = test(fs_info);
+		if (ret)
+			goto out;
+	}
+out:
+	btrfs_free_dummy_root(root);
+	btrfs_free_dummy_fs_info(fs_info);
+	return ret;
+}

-- 
2.43.0


