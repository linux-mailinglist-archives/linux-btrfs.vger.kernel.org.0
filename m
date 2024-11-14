Return-Path: <linux-btrfs+bounces-9669-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 569979C92BB
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 20:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 161CF283F3A
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 19:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D811ABEBA;
	Thu, 14 Nov 2024 19:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="DQUvtUWh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318FF1AB52B
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 19:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731614280; cv=none; b=r/1tMaNQAHUFENxpvkVI8HwV46bCPvYx/WqEFg/iuydkUxsl6mzB5Tzf5nn85wCjsg3azgXxN/SWG/zY3mzv8CLlM9jjX4slYtH0idNHQiLd8zlY241B4FRd31Kw776/ZHyiiCYYwH2uGbItOxI1T9KDEr9lOAl+jjbko8/YU0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731614280; c=relaxed/simple;
	bh=p0/0GH5H4nSiLS0ecNjxgLZlCgBxMWtyKIwdx/Iy02U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g072bY5lRzSFCdRJ/k9NfMD73D7GTVcKkzM4K2LmzigQlfY1glTA3xZVBQUwvvThXHSyqEv0w5NuFVijjdy3Um0/zoKfnPzzgaMPfEV1hfaAF4vE+N3b8OPi/HTJRgPkg3shGJiTqrfODg7RD8Ghuf/c8MoBuhaoLO2cXoa4KDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=DQUvtUWh; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e2974743675so1016433276.1
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 11:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731614277; x=1732219077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cTTFgm7uBnjnehGvebySy7kY3NSymulAflNGDFsIVeg=;
        b=DQUvtUWhWRZ6uR3KW4sZA2Ids4nRfF5QQolTQ894K5M3fVk+yx/bhmdCakifXREBCu
         MHQn+/dd2SSjf1LEW96sdC5Q7Wy6e7uSjvLyD22CEjS02MnwfmjtQIei0zJfuCxrVcmX
         FzCNepqOSITaLglrpZvjetsIKzqHQ1UesRysKEm/NZmgx6Jx2j71d5fXgcUhzt4wZUpz
         CaxTHdQjwqKiLn/srcoLPFMAt+OMLNHqjVXybHBFNFfWj3Di2iR0c5x0+jWdcxqIdqef
         uTG7Zy1nZJUtAxLZABh/djXGD3suxms4CiQnOeOnridWZMl4cuBcafEH0rNPjhcSFvE3
         lRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731614277; x=1732219077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTTFgm7uBnjnehGvebySy7kY3NSymulAflNGDFsIVeg=;
        b=QyGzoHwcFDCy9W6w3Xo9jrteUcCcmxIUSOtACLVQ7g4+jkslhs8MhVCea4a5LM6JhM
         612h3q6HN6t8HJ6RzHGq5PmBadU1cz7AdIWwMtqtevC9zPbmbOpQXClWRNbXc3uCKSjl
         cZgYsIF/9iRoQ0KdkAshZ3JQHYUo3tF7Izi22frxLvi8Vg4dx3mkqd2EMBSj7DJNooZH
         mdT+jQ9ewXQd+DGNQrxwxQrBsBgVbJhiLlcCxZ4ns+j+BmZOEUQRGlejat/ZYWY7m4K8
         S8TIl+mI9LS6tB3O3/8vjZrDsHU4UvZkkYbq+QCZValAJrylgmD2Uwjs6SRyXDd0I9wg
         m19w==
X-Gm-Message-State: AOJu0Yyl++D4T9mAzhDYmuicLbGg1pISlE5OmhinGanp6oJb7MVp60em
	Lza4qIskMZ+n/37yOK2cmXniQZqBgS1/oQ/vkZOHWfLsFFlu+K6nAGDcrbfKxGYQBWtGq/z6HHO
	b
X-Google-Smtp-Source: AGHT+IGArxFhX37aKpsqYRDFtfL8qhIwyRhahg58IbvDAuCbu/7rHH4V39vJMdV8RCSmuQI1RFq5Hg==
X-Received: by 2002:a05:6902:2b92:b0:e35:e2cb:e6be with SMTP id 3f1490d57ef6-e3826395a23mr66435276.32.1731614276508;
        Thu, 14 Nov 2024 11:57:56 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e3815477ca6sm489019276.57.2024.11.14.11.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 11:57:55 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 2/2] btrfs: add delayed ref self tests
Date: Thu, 14 Nov 2024 14:57:49 -0500
Message-ID: <78564483832375111f2d9541678cffa5d3c0c30a.1731614132.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731614132.git.josef@toxicpanda.com>
References: <cover.1731614132.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The recent fix for a stupid mistake I made uncovered the fact that we
don't have adequate testing in the delayed refs code, as it took a
pretty extensive and long running stress test to uncover something that
a unit test would have uncovered right away.

Fix this by adding a delayed refs self test suite.  This will validate
that the btrfs_ref transformation does the correct thing, that we do the
correct thing when merging delayed refs, and that we get the delayed
refs in the order that we expect.  These are all crucial to how the
delayed refs operate.

I introduced various bugs (including the original bug) into the delayed
refs code to validate that these tests caught all of the shenanigans
that I could think of.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/Makefile                   |    2 +-
 fs/btrfs/delayed-ref.c              |   14 +-
 fs/btrfs/tests/btrfs-tests.c        |   18 +
 fs/btrfs/tests/btrfs-tests.h        |    6 +
 fs/btrfs/tests/delayed-refs-tests.c | 1012 +++++++++++++++++++++++++++
 5 files changed, 1048 insertions(+), 4 deletions(-)
 create mode 100644 fs/btrfs/tests/delayed-refs-tests.c

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index 3cfc440c636c..2d5f0482678b 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -44,4 +44,4 @@ btrfs-$(CONFIG_BTRFS_FS_RUN_SANITY_TESTS) += tests/free-space-tests.o \
 	tests/extent-buffer-tests.o tests/btrfs-tests.o \
 	tests/extent-io-tests.o tests/inode-tests.o tests/qgroup-tests.o \
 	tests/free-space-tree-tests.o tests/extent-map-tests.o \
-	tests/raid-stripe-tree-tests.o
+	tests/raid-stripe-tree-tests.o tests/delayed-refs-tests.o
diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 63e0a7f660da..3ec0468d1d94 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -93,6 +93,9 @@ void btrfs_update_delayed_refs_rsv(struct btrfs_trans_handle *trans)
 	u64 num_bytes;
 	u64 reserved_bytes;
 
+	if (btrfs_is_testing(fs_info))
+		return;
+
 	num_bytes = btrfs_calc_delayed_ref_bytes(fs_info, trans->delayed_ref_updates);
 	num_bytes += btrfs_calc_delayed_ref_csum_bytes(fs_info,
 						       trans->delayed_ref_csum_deletions);
@@ -1261,6 +1264,7 @@ void btrfs_destroy_delayed_refs(struct btrfs_transaction *trans)
 {
 	struct btrfs_delayed_ref_root *delayed_refs = &trans->delayed_refs;
 	struct btrfs_fs_info *fs_info = trans->fs_info;
+	bool testing = btrfs_is_testing(fs_info);
 
 	spin_lock(&delayed_refs->lock);
 	while (true) {
@@ -1290,7 +1294,7 @@ void btrfs_destroy_delayed_refs(struct btrfs_transaction *trans)
 		spin_unlock(&delayed_refs->lock);
 		mutex_unlock(&head->mutex);
 
-		if (pin_bytes) {
+		if (!testing && pin_bytes) {
 			struct btrfs_block_group *bg;
 
 			bg = btrfs_lookup_block_group(fs_info, head->bytenr);
@@ -1322,12 +1326,16 @@ void btrfs_destroy_delayed_refs(struct btrfs_transaction *trans)
 			btrfs_error_unpin_extent_range(fs_info, head->bytenr,
 				head->bytenr + head->num_bytes - 1);
 		}
-		btrfs_cleanup_ref_head_accounting(fs_info, delayed_refs, head);
+		if (!testing)
+			btrfs_cleanup_ref_head_accounting(fs_info, delayed_refs,
+							  head);
 		btrfs_put_delayed_ref_head(head);
 		cond_resched();
 		spin_lock(&delayed_refs->lock);
 	}
-	btrfs_qgroup_destroy_extent_records(trans);
+
+	if (!testing)
+		btrfs_qgroup_destroy_extent_records(trans);
 
 	spin_unlock(&delayed_refs->lock);
 }
diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
index e607b5d52fb1..a8549c5685ad 100644
--- a/fs/btrfs/tests/btrfs-tests.c
+++ b/fs/btrfs/tests/btrfs-tests.c
@@ -142,6 +142,11 @@ struct btrfs_fs_info *btrfs_alloc_dummy_fs_info(u32 nodesize, u32 sectorsize)
 	fs_info->nodesize = nodesize;
 	fs_info->sectorsize = sectorsize;
 	fs_info->sectorsize_bits = ilog2(sectorsize);
+
+	/* CRC32C csum size. */
+	fs_info->csum_size = 4;
+	fs_info->csums_per_leaf = BTRFS_MAX_ITEM_SIZE(fs_info) /
+		fs_info->csum_size;
 	set_bit(BTRFS_FS_STATE_DUMMY_FS_INFO, &fs_info->fs_state);
 
 	test_mnt->mnt_sb->s_fs_info = fs_info;
@@ -247,6 +252,16 @@ void btrfs_free_dummy_block_group(struct btrfs_block_group *cache)
 	kfree(cache);
 }
 
+void btrfs_init_dummy_transaction(struct btrfs_transaction *trans,
+				  struct btrfs_fs_info *fs_info)
+{
+	memset(trans, 0, sizeof(*trans));
+	trans->fs_info = fs_info;
+	xa_init(&trans->delayed_refs.head_refs);
+	xa_init(&trans->delayed_refs.dirty_extents);
+	spin_lock_init(&trans->delayed_refs.lock);
+}
+
 void btrfs_init_dummy_trans(struct btrfs_trans_handle *trans,
 			    struct btrfs_fs_info *fs_info)
 {
@@ -295,6 +310,9 @@ int btrfs_run_sanity_tests(void)
 			ret = btrfs_test_raid_stripe_tree(sectorsize, nodesize);
 			if (ret)
 				goto out;
+			ret = btrfs_test_delayed_refs(sectorsize, nodesize);
+			if (ret)
+				goto out;
 		}
 	}
 	ret = btrfs_test_extent_map();
diff --git a/fs/btrfs/tests/btrfs-tests.h b/fs/btrfs/tests/btrfs-tests.h
index b524ecf2f452..713f1b26222b 100644
--- a/fs/btrfs/tests/btrfs-tests.h
+++ b/fs/btrfs/tests/btrfs-tests.h
@@ -6,6 +6,8 @@
 #ifndef BTRFS_TESTS_H
 #define BTRFS_TESTS_H
 
+#include <linux/types.h>
+
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 int btrfs_run_sanity_tests(void);
 
@@ -31,6 +33,7 @@ extern const char *test_error[];
 
 struct btrfs_root;
 struct btrfs_trans_handle;
+struct btrfs_transaction;
 
 int btrfs_test_extent_buffer_operations(u32 sectorsize, u32 nodesize);
 int btrfs_test_free_space_cache(u32 sectorsize, u32 nodesize);
@@ -40,6 +43,7 @@ int btrfs_test_qgroups(u32 sectorsize, u32 nodesize);
 int btrfs_test_free_space_tree(u32 sectorsize, u32 nodesize);
 int btrfs_test_raid_stripe_tree(u32 sectorsize, u32 nodesize);
 int btrfs_test_extent_map(void);
+int btrfs_test_delayed_refs(u32 sectorsize, u32 nodesize);
 struct inode *btrfs_new_test_inode(void);
 struct btrfs_fs_info *btrfs_alloc_dummy_fs_info(u32 nodesize, u32 sectorsize);
 void btrfs_free_dummy_fs_info(struct btrfs_fs_info *fs_info);
@@ -49,6 +53,8 @@ btrfs_alloc_dummy_block_group(struct btrfs_fs_info *fs_info, unsigned long lengt
 void btrfs_free_dummy_block_group(struct btrfs_block_group *cache);
 void btrfs_init_dummy_trans(struct btrfs_trans_handle *trans,
 			    struct btrfs_fs_info *fs_info);
+void btrfs_init_dummy_transaction(struct btrfs_transaction *trans,
+				  struct btrfs_fs_info *fs_info);
 struct btrfs_device *btrfs_alloc_dummy_device(struct btrfs_fs_info *fs_info);
 #else
 static inline int btrfs_run_sanity_tests(void)
diff --git a/fs/btrfs/tests/delayed-refs-tests.c b/fs/btrfs/tests/delayed-refs-tests.c
new file mode 100644
index 000000000000..9b469791c20a
--- /dev/null
+++ b/fs/btrfs/tests/delayed-refs-tests.c
@@ -0,0 +1,1012 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/sizes.h>
+#include "btrfs-tests.h"
+#include "../transaction.h"
+#include "../delayed-ref.h"
+#include "../extent-tree.h"
+
+#define FAKE_ROOT_OBJECTID 256
+#define FAKE_BYTENR 0
+#define FAKE_LEVEL 1
+#define FAKE_INO 256
+#define FAKE_FILE_OFFSET 0
+#define FAKE_PARENT SZ_1M
+
+struct ref_head_check {
+	u64 bytenr;
+	u64 num_bytes;
+	int ref_mod;
+	int total_ref_mod;
+	int must_insert;
+};
+
+struct ref_node_check {
+	u64 bytenr;
+	u64 num_bytes;
+	int ref_mod;
+	enum btrfs_delayed_ref_action action;
+	u8 type;
+	u64 parent;
+	u64 root;
+	u64 owner;
+	u64 offset;
+};
+
+static enum btrfs_ref_type ref_type_from_disk_ref_type(u8 type)
+{
+	if ((type == BTRFS_TREE_BLOCK_REF_KEY) ||
+	    (type == BTRFS_SHARED_BLOCK_REF_KEY))
+		return BTRFS_REF_METADATA;
+	return BTRFS_REF_DATA;
+}
+
+static void delete_delayed_ref_head(struct btrfs_trans_handle *trans,
+				    struct btrfs_delayed_ref_head *head)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_delayed_ref_root *delayed_refs =
+		&trans->transaction->delayed_refs;
+
+	spin_lock(&delayed_refs->lock);
+	spin_lock(&head->lock);
+	btrfs_delete_ref_head(fs_info, delayed_refs, head);
+	spin_unlock(&head->lock);
+	spin_unlock(&delayed_refs->lock);
+
+	btrfs_delayed_ref_unlock(head);
+	btrfs_put_delayed_ref_head(head);
+}
+
+static void delete_delayed_ref_node(struct btrfs_delayed_ref_head *head,
+				    struct btrfs_delayed_ref_node *node)
+{
+	rb_erase_cached(&node->ref_node, &head->ref_tree);
+	RB_CLEAR_NODE(&node->ref_node);
+	if (!list_empty(&node->add_list))
+		list_del_init(&node->add_list);
+	btrfs_put_delayed_ref(node);
+}
+
+static int validate_ref_head(struct btrfs_delayed_ref_head *head,
+			     struct ref_head_check *check)
+{
+	if (head->bytenr != check->bytenr) {
+		test_err("invalid bytenr have: %llu want: %llu", head->bytenr,
+			 check->bytenr);
+		return -EINVAL;
+	}
+
+	if (head->num_bytes != check->num_bytes) {
+		test_err("invalid num_bytes have: %llu want: %llu",
+			 head->num_bytes, check->num_bytes);
+		return -EINVAL;
+	}
+
+	if (head->ref_mod != check->ref_mod) {
+		test_err("invalid ref_mod have: %d want: %d", head->ref_mod,
+			 check->ref_mod);
+		return -EINVAL;
+	}
+
+	if (head->total_ref_mod != check->total_ref_mod) {
+		test_err("invalid total_ref_mod have: %d want: %d",
+			 head->total_ref_mod, check->total_ref_mod);
+		return -EINVAL;
+	}
+
+	if (head->must_insert_reserved != check->must_insert) {
+		test_err("invalid must_insert have: %d want: %d",
+			 head->must_insert_reserved, check->must_insert);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int validate_ref_node(struct btrfs_delayed_ref_node *node,
+			     struct ref_node_check *check)
+{
+	if (node->bytenr != check->bytenr) {
+		test_err("invalid bytenr have: %llu want: %llu", node->bytenr,
+			 check->bytenr);
+		return -EINVAL;
+	}
+
+	if (node->num_bytes != check->num_bytes) {
+		test_err("invalid num_bytes have: %llu want: %llu",
+			 node->num_bytes, check->num_bytes);
+		return -EINVAL;
+	}
+
+	if (node->ref_mod != check->ref_mod) {
+		test_err("invalid ref_mod have: %d want: %d", node->ref_mod,
+			 check->ref_mod);
+		return -EINVAL;
+	}
+
+	if (node->action != check->action) {
+		test_err("invalid action have: %d want: %d", node->action,
+			 check->action);
+		return -EINVAL;
+	}
+
+	if (node->parent != check->parent) {
+		test_err("invalid parent have: %llu want: %llu", node->parent,
+			 check->parent);
+		return -EINVAL;
+	}
+
+	if (node->ref_root != check->root) {
+		test_err("invalid root have: %llu want: %llu", node->ref_root,
+			 check->root);
+		return -EINVAL;
+	}
+
+	if (node->type != check->type) {
+		test_err("invalid type have: %d want: %d", node->type,
+			 check->type);
+		return -EINVAL;
+	}
+
+	if (btrfs_delayed_ref_owner(node) != check->owner) {
+		test_err("invalid owner have: %llu want: %llu",
+			 btrfs_delayed_ref_owner(node), check->owner);
+		return -EINVAL;
+	}
+
+	if (btrfs_delayed_ref_offset(node) != check->offset) {
+		test_err("invalid offset have: %llu want: %llu",
+			 btrfs_delayed_ref_offset(node), check->offset);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int simple_test(struct btrfs_trans_handle *trans,
+		       struct ref_head_check *head_check,
+		       struct ref_node_check *node_check)
+{
+	struct btrfs_delayed_ref_root *delayed_refs =
+		&trans->transaction->delayed_refs;
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_delayed_ref_head *head;
+	struct btrfs_delayed_ref_node *node;
+	struct btrfs_ref ref = {
+		.type = ref_type_from_disk_ref_type(node_check->type),
+		.action = node_check->action,
+		.parent = node_check->parent,
+		.ref_root = node_check->root,
+		.bytenr = node_check->bytenr,
+		.num_bytes = fs_info->nodesize,
+	};
+	int ret;
+
+	if (ref.type == BTRFS_REF_METADATA)
+		btrfs_init_tree_ref(&ref, node_check->owner, node_check->root,
+				    false);
+	else
+		btrfs_init_data_ref(&ref, node_check->owner, node_check->offset,
+				    node_check->root, true);
+
+	if (ref.type == BTRFS_REF_METADATA)
+		ret = btrfs_add_delayed_tree_ref(trans, &ref, NULL);
+	else
+		ret = btrfs_add_delayed_data_ref(trans, &ref, 0);
+	if (ret) {
+		test_err("failed ref action %d", ret);
+		return ret;
+	}
+
+	head = btrfs_select_ref_head(fs_info, delayed_refs);
+	if (IS_ERR_OR_NULL(head)) {
+		if (IS_ERR(head))
+			test_err("failed to select delayed ref head: %ld",
+				 PTR_ERR(head));
+		else
+			test_err("failed to find delayed ref head");
+		return -EINVAL;
+	}
+
+	ret = -EINVAL;
+	if (validate_ref_head(head, head_check))
+		goto out;
+
+	spin_lock(&head->lock);
+	node = btrfs_select_delayed_ref(head);
+	spin_unlock(&head->lock);
+	if (!node) {
+		test_err("failed to select delayed ref");
+		goto out;
+	}
+
+	if (validate_ref_node(node, node_check))
+		goto out;
+	ret = 0;
+out:
+	btrfs_unselect_ref_head(delayed_refs, head);
+	btrfs_destroy_delayed_refs(trans->transaction);
+	return ret;
+}
+
+/*
+ * These are simple tests, make sure that our btrfs_ref's get turned into the
+ * appropriate btrfs_delayed_ref_node based on their settings and action.
+ */
+static int simple_tests(struct btrfs_trans_handle *trans)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct ref_head_check head_check = {
+		.bytenr = FAKE_BYTENR,
+		.num_bytes = fs_info->nodesize,
+		.ref_mod = 1,
+		.total_ref_mod = 1,
+	};
+	struct ref_node_check node_check = {
+		.bytenr = FAKE_BYTENR,
+		.num_bytes = fs_info->nodesize,
+		.ref_mod = 1,
+		.action = BTRFS_ADD_DELAYED_REF,
+		.type = BTRFS_TREE_BLOCK_REF_KEY,
+		.parent = 0,
+		.root = FAKE_ROOT_OBJECTID,
+		.owner = FAKE_LEVEL,
+		.offset = 0,
+	};
+
+	if (simple_test(trans, &head_check, &node_check)) {
+		test_err("single add tree block failed");
+		return -EINVAL;
+	}
+
+	node_check.type = BTRFS_EXTENT_DATA_REF_KEY;
+	node_check.owner = FAKE_INO;
+	node_check.offset = FAKE_FILE_OFFSET;
+
+	if (simple_test(trans, &head_check, &node_check)) {
+		test_err("single add extent data failed");
+		return -EINVAL;
+	}
+
+	node_check.parent = FAKE_PARENT;
+	node_check.type = BTRFS_SHARED_BLOCK_REF_KEY;
+	node_check.owner = FAKE_LEVEL;
+	node_check.offset = 0;
+
+	if (simple_test(trans, &head_check, &node_check)) {
+		test_err("single add shared block failed");
+		return -EINVAL;
+	}
+
+	node_check.type = BTRFS_SHARED_DATA_REF_KEY;
+	node_check.owner = FAKE_INO;
+	node_check.offset = FAKE_FILE_OFFSET;
+
+	if (simple_test(trans, &head_check, &node_check)) {
+		test_err("single add shared data failed");
+		return -EINVAL;
+	}
+
+	head_check.ref_mod = -1;
+	head_check.total_ref_mod = -1;
+	node_check.action = BTRFS_DROP_DELAYED_REF;
+	node_check.type = BTRFS_TREE_BLOCK_REF_KEY;
+	node_check.owner = FAKE_LEVEL;
+	node_check.offset = 0;
+	node_check.parent = 0;
+
+	if (simple_test(trans, &head_check, &node_check)) {
+		test_err("single drop tree block failed");
+		return -EINVAL;
+	}
+
+	node_check.type = BTRFS_EXTENT_DATA_REF_KEY;
+	node_check.owner = FAKE_INO;
+	node_check.offset = FAKE_FILE_OFFSET;
+
+	if (simple_test(trans, &head_check, &node_check)) {
+		test_err("single drop extent data failed");
+		return -EINVAL;
+	}
+
+	node_check.parent = FAKE_PARENT;
+	node_check.type = BTRFS_SHARED_BLOCK_REF_KEY;
+	node_check.owner = FAKE_LEVEL;
+	node_check.offset = 0;
+	if (simple_test(trans, &head_check, &node_check)) {
+		test_err("single drop shared block failed");
+		return -EINVAL;
+	}
+
+	node_check.type = BTRFS_SHARED_DATA_REF_KEY;
+	node_check.owner = FAKE_INO;
+	node_check.offset = FAKE_FILE_OFFSET;
+	if (simple_test(trans, &head_check, &node_check)) {
+		test_err("single drop shared data failed");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
+ * Merge tests, validate that we do delayed ref merging properly, the ref counts
+ * all end up properly, and delayed refs are deleted once they're no longer
+ * needed.
+ */
+static int merge_tests(struct btrfs_trans_handle *trans,
+		       enum btrfs_ref_type type)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_delayed_ref_head *head = NULL;
+	struct btrfs_delayed_ref_node *node;
+	struct btrfs_ref ref = {
+		.type = type,
+		.action = BTRFS_ADD_DELAYED_REF,
+		.parent = 0,
+		.ref_root = FAKE_ROOT_OBJECTID,
+		.bytenr = FAKE_BYTENR,
+		.num_bytes = fs_info->nodesize,
+	};
+	struct ref_head_check head_check = {
+		.bytenr = FAKE_BYTENR,
+		.num_bytes = fs_info->nodesize,
+		.ref_mod = 0,
+		.total_ref_mod = 0,
+	};
+	struct ref_node_check node_check = {
+		.bytenr = FAKE_BYTENR,
+		.num_bytes = fs_info->nodesize,
+		.ref_mod = 2,
+		.action = BTRFS_ADD_DELAYED_REF,
+		.parent = 0,
+		.root = FAKE_ROOT_OBJECTID,
+	};
+	int ret;
+
+	/*
+	 * First add a ref and then drop it, make sure we get a head ref with a
+	 * 0 total ref mod and no nodes.
+	 */
+	if (type == BTRFS_REF_METADATA) {
+		node_check.type = BTRFS_TREE_BLOCK_REF_KEY;
+		node_check.owner = FAKE_LEVEL;
+		btrfs_init_tree_ref(&ref, FAKE_LEVEL, FAKE_ROOT_OBJECTID, false);
+	} else {
+		node_check.type = BTRFS_EXTENT_DATA_REF_KEY;
+		node_check.owner = FAKE_INO;
+		node_check.offset = FAKE_FILE_OFFSET;
+		btrfs_init_data_ref(&ref, FAKE_INO, FAKE_FILE_OFFSET,
+				    FAKE_ROOT_OBJECTID, true);
+	}
+
+	if (type == BTRFS_REF_METADATA)
+		ret = btrfs_add_delayed_tree_ref(trans, &ref, NULL);
+	else
+		ret = btrfs_add_delayed_data_ref(trans, &ref, 0);
+	if (ret) {
+		test_err("failed ref action %d", ret);
+		return ret;
+	}
+
+	ref.action = BTRFS_DROP_DELAYED_REF;
+	if (type == BTRFS_REF_METADATA)
+		ret = btrfs_add_delayed_tree_ref(trans, &ref, NULL);
+	else
+		ret = btrfs_add_delayed_data_ref(trans, &ref, 0);
+	if (ret) {
+		test_err("failed ref action %d", ret);
+		goto out;
+	}
+
+	head = btrfs_select_ref_head(fs_info, &trans->transaction->delayed_refs);
+	if (IS_ERR_OR_NULL(head)) {
+		if (IS_ERR(head))
+			test_err("failed to select delayed ref head: %ld",
+				 PTR_ERR(head));
+		else
+			test_err("failed to find delayed ref head");
+		head = NULL;
+		goto out;
+	}
+
+	ret = -EINVAL;
+	if (validate_ref_head(head, &head_check)) {
+		test_err("single add and drop failed");
+		goto out;
+	}
+
+	spin_lock(&head->lock);
+	node = btrfs_select_delayed_ref(head);
+	spin_unlock(&head->lock);
+	if (node) {
+		test_err("found node when none should exist");
+		goto out;
+	}
+
+	delete_delayed_ref_head(trans, head);
+	head = NULL;
+
+	/*
+	 * Add a ref, then add another ref, make sure we get a head ref with a
+	 * 2 total ref mod and 1 node.
+	 */
+	ref.action = BTRFS_ADD_DELAYED_REF;
+	if (type == BTRFS_REF_METADATA)
+		ret = btrfs_add_delayed_tree_ref(trans, &ref, NULL);
+	else
+		ret = btrfs_add_delayed_data_ref(trans, &ref, 0);
+	if (ret) {
+		test_err("failed ref action %d", ret);
+		goto out;
+	}
+
+	if (type == BTRFS_REF_METADATA)
+		ret = btrfs_add_delayed_tree_ref(trans, &ref, NULL);
+	else
+		ret = btrfs_add_delayed_data_ref(trans, &ref, 0);
+	if (ret) {
+		test_err("failed ref action %d", ret);
+		goto out;
+	}
+
+	head = btrfs_select_ref_head(fs_info, &trans->transaction->delayed_refs);
+	if (IS_ERR_OR_NULL(head)) {
+		if (IS_ERR(head))
+			test_err("failed to select delayed ref head: %ld",
+				 PTR_ERR(head));
+		else
+			test_err("failed to find delayed ref head");
+		head = NULL;
+		goto out;
+	}
+
+	head_check.ref_mod = 2;
+	head_check.total_ref_mod = 2;
+	ret = -EINVAL;
+	if (validate_ref_head(head, &head_check)) {
+		test_err("double add failed");
+		goto out;
+	}
+
+	spin_lock(&head->lock);
+	node = btrfs_select_delayed_ref(head);
+	spin_unlock(&head->lock);
+	if (!node) {
+		test_err("failed to select delayed ref");
+		goto out;
+	}
+
+	if (validate_ref_node(node, &node_check)) {
+		test_err("node check failed");
+		goto out;
+	}
+
+	delete_delayed_ref_node(head, node);
+
+	spin_lock(&head->lock);
+	node = btrfs_select_delayed_ref(head);
+	spin_unlock(&head->lock);
+	if (node) {
+		test_err("found node when none should exist");
+		goto out;
+	}
+	delete_delayed_ref_head(trans, head);
+	head = NULL;
+
+	/* Add two drop refs, make sure they are merged properly. */
+	ref.action = BTRFS_DROP_DELAYED_REF;
+	if (type == BTRFS_REF_METADATA)
+		ret = btrfs_add_delayed_tree_ref(trans, &ref, NULL);
+	else
+		ret = btrfs_add_delayed_data_ref(trans, &ref, 0);
+	if (ret) {
+		test_err("failed ref action %d", ret);
+		goto out;
+	}
+
+	if (type == BTRFS_REF_METADATA)
+		ret = btrfs_add_delayed_tree_ref(trans, &ref, NULL);
+	else
+		ret = btrfs_add_delayed_data_ref(trans, &ref, 0);
+	if (ret) {
+		test_err("failed ref action %d", ret);
+		goto out;
+	}
+
+	head = btrfs_select_ref_head(fs_info, &trans->transaction->delayed_refs);
+	if (IS_ERR_OR_NULL(head)) {
+		if (IS_ERR(head))
+			test_err("failed to select delayed ref head: %ld",
+				 PTR_ERR(head));
+		else
+			test_err("failed to find delayed ref head");
+		goto out;
+	}
+
+	head_check.ref_mod = -2;
+	head_check.total_ref_mod = -2;
+	ret = -EINVAL;
+	if (validate_ref_head(head, &head_check)) {
+		test_err("double drop failed");
+		goto out;
+	}
+
+	node_check.action = BTRFS_DROP_DELAYED_REF;
+	spin_lock(&head->lock);
+	node = btrfs_select_delayed_ref(head);
+	spin_unlock(&head->lock);
+	if (!node) {
+		test_err("failed to select delayed ref");
+		goto out;
+	}
+
+	if (validate_ref_node(node, &node_check)) {
+		test_err("node check failed");
+		goto out;
+	}
+
+	delete_delayed_ref_node(head, node);
+
+	spin_lock(&head->lock);
+	node = btrfs_select_delayed_ref(head);
+	spin_unlock(&head->lock);
+	if (node) {
+		test_err("found node when none should exist");
+		goto out;
+	}
+	delete_delayed_ref_head(trans, head);
+	head = NULL;
+
+	/* Add multiple refs, then drop until we go negative again. */
+	ref.action = BTRFS_ADD_DELAYED_REF;
+	for (int i = 0; i < 10; i++) {
+		if (type == BTRFS_REF_METADATA)
+			ret = btrfs_add_delayed_tree_ref(trans, &ref, NULL);
+		else
+			ret = btrfs_add_delayed_data_ref(trans, &ref, 0);
+		if (ret) {
+			test_err("failed ref action %d", ret);
+			goto out;
+		}
+	}
+
+	ref.action = BTRFS_DROP_DELAYED_REF;
+	for (int i = 0; i < 12; i++) {
+		if (type == BTRFS_REF_METADATA)
+			ret = btrfs_add_delayed_tree_ref(trans, &ref, NULL);
+		else
+			ret = btrfs_add_delayed_data_ref(trans, &ref, 0);
+		if (ret) {
+			test_err("failed ref action %d", ret);
+			goto out;
+		}
+	}
+
+	head = btrfs_select_ref_head(fs_info, &trans->transaction->delayed_refs);
+	if (IS_ERR_OR_NULL(head)) {
+		if (IS_ERR(head))
+			test_err("failed to select delayed ref head: %ld",
+				 PTR_ERR(head));
+		else
+			test_err("failed to find delayed ref head");
+		head = NULL;
+		ret = -EINVAL;
+		goto out;
+	}
+
+	head_check.ref_mod = -2;
+	head_check.total_ref_mod = -2;
+	ret = -EINVAL;
+	if (validate_ref_head(head, &head_check)) {
+		test_err("double drop failed");
+		goto out;
+	}
+
+	spin_lock(&head->lock);
+	node = btrfs_select_delayed_ref(head);
+	spin_unlock(&head->lock);
+	if (!node) {
+		test_err("failed to select delayed ref");
+		goto out;
+	}
+
+	if (validate_ref_node(node, &node_check)) {
+		test_err("node check failed");
+		goto out;
+	}
+
+	delete_delayed_ref_node(head, node);
+
+	spin_lock(&head->lock);
+	node = btrfs_select_delayed_ref(head);
+	spin_unlock(&head->lock);
+	if (node) {
+		test_err("found node when none should exist");
+		goto out;
+	}
+
+	delete_delayed_ref_head(trans, head);
+	head = NULL;
+
+	/* Drop multiple refs, then add until we go positive again. */
+	ref.action = BTRFS_DROP_DELAYED_REF;
+	for (int i = 0; i < 10; i++) {
+		if (type == BTRFS_REF_METADATA)
+			ret = btrfs_add_delayed_tree_ref(trans, &ref, NULL);
+		else
+			ret = btrfs_add_delayed_data_ref(trans, &ref, 0);
+		if (ret) {
+			test_err("failed ref action %d", ret);
+			goto out;
+		}
+	}
+
+	ref.action = BTRFS_ADD_DELAYED_REF;
+	for (int i = 0; i < 12; i++) {
+		if (type == BTRFS_REF_METADATA)
+			ret = btrfs_add_delayed_tree_ref(trans, &ref, NULL);
+		else
+			ret = btrfs_add_delayed_data_ref(trans, &ref, 0);
+		if (ret) {
+			test_err("failed ref action %d", ret);
+			goto out;
+		}
+	}
+
+	head = btrfs_select_ref_head(fs_info, &trans->transaction->delayed_refs);
+	if (IS_ERR_OR_NULL(head)) {
+		if (IS_ERR(head))
+			test_err("failed to select delayed ref head: %ld",
+				 PTR_ERR(head));
+		else
+			test_err("failed to find delayed ref head");
+		ret = -EINVAL;
+		head = NULL;
+		goto out;
+	}
+
+	head_check.ref_mod = 2;
+	head_check.total_ref_mod = 2;
+	ret = -EINVAL;
+	if (validate_ref_head(head, &head_check)) {
+		test_err("add and drop to positive failed");
+		goto out;
+	}
+
+	node_check.action = BTRFS_ADD_DELAYED_REF;
+	spin_lock(&head->lock);
+	node = btrfs_select_delayed_ref(head);
+	spin_unlock(&head->lock);
+	if (!node) {
+		test_err("failed to select delayed ref");
+		goto out;
+	}
+
+	if (validate_ref_node(node, &node_check)) {
+		test_err("node check failed");
+		goto out;
+	}
+
+	delete_delayed_ref_node(head, node);
+
+	spin_lock(&head->lock);
+	node = btrfs_select_delayed_ref(head);
+	spin_unlock(&head->lock);
+	if (node) {
+		test_err("found node when none should exist");
+		goto out;
+	}
+	delete_delayed_ref_head(trans, head);
+	head = NULL;
+
+	/*
+	 * Add a bunch of refs with different roots and parents, then drop them
+	 * all, make sure everything is properly merged.
+	 */
+	ref.action = BTRFS_ADD_DELAYED_REF;
+	for (int i = 0; i < 50; i++) {
+		if (!(i % 2)) {
+			ref.parent = 0;
+			ref.ref_root = FAKE_ROOT_OBJECTID + i;
+		} else {
+			ref.parent = FAKE_PARENT + (i * fs_info->nodesize);
+		}
+		if (type == BTRFS_REF_METADATA)
+			ret = btrfs_add_delayed_tree_ref(trans, &ref, NULL);
+		else
+			ret = btrfs_add_delayed_data_ref(trans, &ref, 0);
+		if (ret) {
+			test_err("failed ref action %d", ret);
+			goto out;
+		}
+	}
+
+	ref.action = BTRFS_DROP_DELAYED_REF;
+	for (int i = 0; i < 50; i++) {
+		if (!(i % 2)) {
+			ref.parent = 0;
+			ref.ref_root = FAKE_ROOT_OBJECTID + i;
+		} else {
+			ref.parent = FAKE_PARENT + (i * fs_info->nodesize);
+		}
+		if (type == BTRFS_REF_METADATA)
+			ret = btrfs_add_delayed_tree_ref(trans, &ref, NULL);
+		else
+			ret = btrfs_add_delayed_data_ref(trans, &ref, 0);
+		if (ret) {
+			test_err("failed ref action %d", ret);
+			goto out;
+		}
+	}
+
+	head = btrfs_select_ref_head(fs_info, &trans->transaction->delayed_refs);
+	if (IS_ERR_OR_NULL(head)) {
+		if (IS_ERR(head))
+			test_err("failed to select delayed ref head: %ld",
+				 PTR_ERR(head));
+		else
+			test_err("failed to find delayed ref head");
+		head = NULL;
+		ret = -EINVAL;
+		goto out;
+	}
+
+	head_check.ref_mod = 0;
+	head_check.total_ref_mod = 0;
+	ret = -EINVAL;
+	if (validate_ref_head(head, &head_check)) {
+		test_err("add and drop multiple failed");
+		goto out;
+	}
+
+	spin_lock(&head->lock);
+	node = btrfs_select_delayed_ref(head);
+	spin_unlock(&head->lock);
+	if (node) {
+		test_err("found node when none should exist");
+		goto out;
+	}
+	ret = 0;
+out:
+	if (head)
+		btrfs_unselect_ref_head(&trans->transaction->delayed_refs, head);
+	btrfs_destroy_delayed_refs(trans->transaction);
+	return ret;
+}
+
+/*
+ * Basic test to validate we always get the add operations first followed by any
+ * delete operations.
+ */
+static int select_delayed_refs_test(struct btrfs_trans_handle *trans)
+{
+	struct btrfs_delayed_ref_root *delayed_refs =
+		&trans->transaction->delayed_refs;
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_delayed_ref_head *head = NULL;
+	struct btrfs_delayed_ref_node *node;
+	struct btrfs_ref ref = {
+		.type = BTRFS_REF_METADATA,
+		.action = BTRFS_DROP_DELAYED_REF,
+		.parent = 0,
+		.ref_root = FAKE_ROOT_OBJECTID,
+		.bytenr = FAKE_BYTENR,
+		.num_bytes = fs_info->nodesize,
+	};
+	struct ref_head_check head_check = {
+		.bytenr = FAKE_BYTENR,
+		.num_bytes = fs_info->nodesize,
+		.ref_mod = 0,
+		.total_ref_mod = 0,
+	};
+	struct ref_node_check node_check = {
+		.bytenr = FAKE_BYTENR,
+		.num_bytes = fs_info->nodesize,
+		.ref_mod = 1,
+		.action = BTRFS_ADD_DELAYED_REF,
+		.type = BTRFS_TREE_BLOCK_REF_KEY,
+		.parent = 0,
+		.owner = FAKE_LEVEL,
+		.offset = 0,
+	};
+	int ret;
+
+	/* Add the drop first. */
+	btrfs_init_tree_ref(&ref, FAKE_LEVEL, FAKE_ROOT_OBJECTID, false);
+	ret = btrfs_add_delayed_tree_ref(trans, &ref, NULL);
+	if (ret) {
+		test_err("failed ref action %d", ret);
+		return ret;
+	}
+
+	/*
+	 * Now add the add, and make it a different root so it's logically later
+	 * in the rb tree.
+	 */
+	ref.action = BTRFS_ADD_DELAYED_REF;
+	ref.ref_root = FAKE_ROOT_OBJECTID + 1;
+	ret = btrfs_add_delayed_tree_ref(trans, &ref, NULL);
+	if (ret) {
+		test_err("failed ref action %d", ret);
+		goto out;
+	}
+
+	head = btrfs_select_ref_head(fs_info, delayed_refs);
+	if (IS_ERR_OR_NULL(head)) {
+		if (IS_ERR(head))
+			test_err("failed to select delayed ref head: %ld",
+				 PTR_ERR(head));
+		else
+			test_err("failed to find delayed ref head");
+		ret = -EINVAL;
+		head = NULL;
+		goto out;
+	}
+
+	ret = -EINVAL;
+	if (validate_ref_head(head, &head_check)) {
+		test_err("head check failed");
+		goto out;
+	}
+
+	spin_lock(&head->lock);
+	node = btrfs_select_delayed_ref(head);
+	spin_unlock(&head->lock);
+	if (!node) {
+		test_err("failed to select delayed ref");
+		goto out;
+	}
+
+	node_check.root = FAKE_ROOT_OBJECTID + 1;
+	if (validate_ref_node(node, &node_check)) {
+		test_err("node check failed");
+		goto out;
+	}
+	delete_delayed_ref_node(head, node);
+
+	spin_lock(&head->lock);
+	node = btrfs_select_delayed_ref(head);
+	spin_unlock(&head->lock);
+	if (!node) {
+		test_err("failed to select delayed ref");
+		goto out;
+	}
+
+	node_check.action = BTRFS_DROP_DELAYED_REF;
+	node_check.root = FAKE_ROOT_OBJECTID;
+	if (validate_ref_node(node, &node_check)) {
+		test_err("node check failed");
+		goto out;
+	}
+	delete_delayed_ref_node(head, node);
+	delete_delayed_ref_head(trans, head);
+	head = NULL;
+
+	/*
+	 * Now we're going to do the same thing, but we're going to have an add
+	 * that gets deleted because of a merge, and make sure we still have
+	 * another add in place.
+	 */
+	ref.action = BTRFS_DROP_DELAYED_REF;
+	ref.ref_root = FAKE_ROOT_OBJECTID;
+	ret = btrfs_add_delayed_tree_ref(trans, &ref, NULL);
+	if (ret) {
+		test_err("failed ref action %d", ret);
+		goto out;
+	}
+
+	ref.action = BTRFS_ADD_DELAYED_REF;
+	ref.ref_root = FAKE_ROOT_OBJECTID + 1;
+	ret = btrfs_add_delayed_tree_ref(trans, &ref, NULL);
+	if (ret) {
+		test_err("failed ref action %d", ret);
+		goto out;
+	}
+
+	ref.action = BTRFS_DROP_DELAYED_REF;
+	ret = btrfs_add_delayed_tree_ref(trans, &ref, NULL);
+	if (ret) {
+		test_err("failed ref action %d", ret);
+		goto out;
+	}
+
+	ref.action = BTRFS_ADD_DELAYED_REF;
+	ref.ref_root = FAKE_ROOT_OBJECTID + 2;
+	ret = btrfs_add_delayed_tree_ref(trans, &ref, NULL);
+	if (ret) {
+		test_err("failed ref action %d", ret);
+		goto out;
+	}
+
+	head = btrfs_select_ref_head(fs_info, delayed_refs);
+	if (IS_ERR_OR_NULL(head)) {
+		if (IS_ERR(head))
+			test_err("failed to select delayed ref head: %ld",
+				 PTR_ERR(head));
+		else
+			test_err("failed to find delayed ref head");
+		ret = -EINVAL;
+		head = NULL;
+		goto out;
+	}
+
+	ret = -EINVAL;
+	if (validate_ref_head(head, &head_check)) {
+		test_err("head check failed");
+		goto out;
+	}
+
+	spin_lock(&head->lock);
+	node = btrfs_select_delayed_ref(head);
+	spin_unlock(&head->lock);
+	if (!node) {
+		test_err("failed to select delayed ref");
+		goto out;
+	}
+
+	node_check.action = BTRFS_ADD_DELAYED_REF;
+	node_check.root = FAKE_ROOT_OBJECTID + 2;
+	if (validate_ref_node(node, &node_check)) {
+		test_err("node check failed");
+		goto out;
+	}
+	delete_delayed_ref_node(head, node);
+
+	spin_lock(&head->lock);
+	node = btrfs_select_delayed_ref(head);
+	spin_unlock(&head->lock);
+	if (!node) {
+		test_err("failed to select delayed ref");
+		goto out;
+	}
+
+	node_check.action = BTRFS_DROP_DELAYED_REF;
+	node_check.root = FAKE_ROOT_OBJECTID;
+	if (validate_ref_node(node, &node_check)) {
+		test_err("node check failed");
+		goto out;
+	}
+	delete_delayed_ref_node(head, node);
+	ret = 0;
+out:
+	if (head)
+		btrfs_unselect_ref_head(delayed_refs, head);
+	btrfs_destroy_delayed_refs(trans->transaction);
+	return ret;
+}
+
+int btrfs_test_delayed_refs(u32 sectorsize, u32 nodesize)
+{
+	struct btrfs_transaction transaction;
+	struct btrfs_trans_handle trans;
+	struct btrfs_fs_info *fs_info;
+	int ret;
+
+	test_msg("running delayed refs tests");
+
+	fs_info = btrfs_alloc_dummy_fs_info(nodesize, sectorsize);
+	if (!fs_info) {
+		test_std_err(TEST_ALLOC_FS_INFO);
+		return -ENOMEM;
+	}
+	btrfs_init_dummy_trans(&trans, fs_info);
+	btrfs_init_dummy_transaction(&transaction, fs_info);
+	trans.transaction = &transaction;
+
+	ret = simple_tests(&trans);
+	if (!ret) {
+		test_msg("running delayed refs merg tests on metadata refs");
+		ret = merge_tests(&trans, BTRFS_REF_METADATA);
+	}
+
+	if (!ret) {
+		test_msg("running delayed refs merg tests on data refs");
+		ret = merge_tests(&trans, BTRFS_REF_DATA);
+	}
+
+	if (!ret)
+		ret = select_delayed_refs_test(&trans);
+	btrfs_free_dummy_fs_info(fs_info);
+	return ret;
+}
-- 
2.43.0


