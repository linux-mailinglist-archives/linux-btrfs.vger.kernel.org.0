Return-Path: <linux-btrfs+bounces-5821-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB76C90F245
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2024 17:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77E492844CB
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2024 15:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E76152166;
	Wed, 19 Jun 2024 15:35:09 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5046152787;
	Wed, 19 Jun 2024 15:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718811308; cv=none; b=L/SEAjqaTTRRbdmJyrFF35OFUGrabqfa6cfIq51RlC+vcjIKGaMBYvnZhKNHmynJBfQSzM4mikCDimmpBo3qVJF2DNhJXzVDfPg/XUfJyU1SBAUjUuGTeijFsF59tK402qfhamz5WAt8YB18L0gXjZ0oMmnVrX+OWnzhwkbGf8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718811308; c=relaxed/simple;
	bh=PqGfVgSKEswFDJImaCkU9nFS8FadtWNV9A7d+JcshWI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FFRKNu0sItDU0t+ClA0whrSdRbQEZdfzFY9Af9mv6Uy2HyWIapKtwcQi2of+73+vrDwgewDjh8GTicC/fMduinx9HR/U/ATWzVcHiSVgqKY6MbVLFDHgp6cYvL3RBstOhVKdZF8SU++jl8mVsyRXXUbe4hvdVPtN1IwT9XqA4Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52bbf73f334so6450665e87.2;
        Wed, 19 Jun 2024 08:35:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718811305; x=1719416105;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qWmeWy8UxjtIb9YgNlFSXTYkhGxKGeO3sXg54+ZDFxY=;
        b=dKyUwCZkbdYrbE7MgYpDp3enewE6e7U1+HFDVkWPEWjOMRtXjSbPG00oXhlYSlCy67
         5kh9ypjDZZQWtr5TsnOyxmdNxDDVfbwramsGj570Z1rhqwVw+fHttPduPis5CFhygIUC
         kTJxGjfDmuH7e0J2yGUrqnvmFq3ZsLKBLUB2XPyQ4Nt79iYbxtVo+L3lUyUiLE7t3UNA
         0OxqQiXKsN2ATKHl2COzke776YzDEfzaQcgoKqzOIB59TFgCfJ57yoP+nTJb5xpmrjO6
         7oqGPSzHicgoXOTny2QGWM2Hu1Lw0xE4ELP4n33a5bpn3b3jx59pz22/czxGM287xb5x
         k/5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWiuz/ZPKanTSDQEnv7avKPVZKGFTejF5VaDwat8vIQZvWG/m7BLRSxQKHrIm2qi2t1fjNO7nfn37nWtGc3w1jOHUYTDhXTrf2EV2wI
X-Gm-Message-State: AOJu0YzlFP/4TuL6BGahnu0pKbRUkJRSsHRiqrL0rWtBrkpBfqvUUC+l
	s68B/Y5CYJooosvrpSWTDGBeq/NJa057RREac3h5lyiMSKxsHbCFZPtFjQ==
X-Google-Smtp-Source: AGHT+IFaNkddFO//wttWe5Ej93KWbro2csj+NV8Gvzw+iKJ9ZL5kGcXpIXSj3X9i8V04Nl/NewgvqA==
X-Received: by 2002:ac2:5a0c:0:b0:52c:785f:ae23 with SMTP id 2adb3069b0e04-52ccaa5cff4mr1611830e87.24.1718811304989;
        Wed, 19 Jun 2024 08:35:04 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f7110500fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f711:500:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286fe9263sm268882135e9.15.2024.06.19.08.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 08:35:04 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Wed, 19 Jun 2024 17:34:54 +0200
Subject: [PATCH v2 4/4] btrfs: stripe-tree: add selftests
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240619-b4-rst-updates-v2-4-89c34d0d5298@kernel.org>
References: <20240619-b4-rst-updates-v2-0-89c34d0d5298@kernel.org>
In-Reply-To: <20240619-b4-rst-updates-v2-0-89c34d0d5298@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=10060; i=jth@kernel.org;
 h=from:subject:message-id; bh=dcEj42HcJ3gyL1dHjpCKO791Dhsa/HLhBapf/qaKJgE=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaQV/VqoxK15SZr1UeVUrZntC/9klk3NvDRJxSV/f59X0
 XYm7+LsjlIWBjEuBlkxRZbjobb7JUyPsE859NoMZg4rE8gQBi5OAZiIVCIjw65LVtdzmpxjVBKc
 OIosds1V6zzGpL/gldHb1O51Njsn3WBk2H2+JmMfXzF3Z8ZBg5BHPM8Z22X/3o84vM3Rpv7FtlX
 yzAA=
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
 fs/btrfs/tests/raid-stripe-tree-tests.c | 258 ++++++++++++++++++++++++++++++++
 6 files changed, 271 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index 50b19d15e956..79690d746781 100644
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
index 64e36b46cbab..c5c2f19387ff 100644
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
index 000000000000..9a5848c4a1c4
--- /dev/null
+++ b/fs/btrfs/tests/raid-stripe-tree-tests.c
@@ -0,0 +1,258 @@
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
+	ret = btrfs_delete_raid_extent(&trans, logical, SZ_16K);
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
+	}
+
+	ret = btrfs_insert_one_raid_extent(&trans, bioc);
+	if (ret)
+		goto out;
+	ret = btrfs_delete_raid_extent(&trans, logical, SZ_8K);
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
+	test_msg("running raid-stripe-tree tests");
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
+	btrfs_set_super_incompat_flags(fs_info->super_copy,
+				       BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE);
+	root->root_key.objectid = BTRFS_RAID_STRIPE_TREE_OBJECTID;
+	root->root_key.type = BTRFS_ROOT_ITEM_KEY;
+	root->root_key.offset = 0;
+	btrfs_global_root_insert(root);
+	fs_info->stripe_root = root;
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


