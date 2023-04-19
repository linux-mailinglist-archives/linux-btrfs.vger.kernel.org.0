Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523C86E838F
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 23:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbjDSVW5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 17:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjDSVW4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 17:22:56 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A9876BD
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:22:29 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id op30so1106070qvb.3
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1681939256; x=1684531256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xz8gpPaByzawAWuecubJhEojv5oZuLnDMLW4n8G5Ikk=;
        b=SO+xpz7s/GDz4q1tB7Jjr+LcJUzgU497VQEMtdlikctbJJBnfYOS2yZGHE3T1teY+W
         TmkeJ1LSmSRL9mJJ+OhLC7dR97LrsH0v/Tt79rChT949By9rznT7eZ+Ojd8HEvX1blQ2
         Gca2Yd66m5wc+oiQEQ0ho+B2qW7Aw7BxGYg85Vd9kbqJGpiK7l4H8euzHWmxgOtezelO
         YKZOlWvvNQv8X3X+EO14SLMuWiFuDvfrp0YBJoU0zitKiEH/yOJPn2I+NJ6vyHiKfyrv
         ESaPQ/NN1CgT/R28HTa8i9raPDszimcVwxqfu5p79Ov1l37c2VCujRnpetVM7oJAn6kO
         2ETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681939256; x=1684531256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xz8gpPaByzawAWuecubJhEojv5oZuLnDMLW4n8G5Ikk=;
        b=lIRFvq3Oqfr87wvMwiBG2fsYXuz/jTONLhxQMecO+eAX4Q28PmpdrqRQlyYb+T9O26
         fWubOK8KlmchxuNCv3erm/09FHrI1td2ZFbCM/uiEWCMz8309AcNfds07ugyQeTL3cYm
         P1B4apv1tte+qEBvT7N1DgUPRBl5cQQWl8AUSEny22ItbF/s26qMYM/SH6GO8XhlWgxv
         q/F1jHwCEu6TAjibiN8TJ/I479fdaqSUnyVYFKjcBUBfaX7yZN/pnyrvQnu2t8Xm0ElL
         q/QWlgmyqRJeHY83QRpT1rFrOAcKlnoJk8I5yG8zGBu5TCC7PjXuy6Yulhhd2DFwOCeY
         e5/Q==
X-Gm-Message-State: AAQBX9e9zLfETAqoaAFjKsl53AiKf/oELtmI+m4XwEjfXJTB0t8tviFg
        I+BN8FOor8Y5qNth2fhC717oefm8Dpi2groTplnFBw==
X-Google-Smtp-Source: AKy350bGaRsaoIltxUxa4hWK3pbdvfMwZgH48UFup1ZqWWxxq0tmvkIUwWSHZsfiLYFKL8v7P60WTg==
X-Received: by 2002:ad4:4eae:0:b0:5ca:83ed:12be with SMTP id ed14-20020ad44eae000000b005ca83ed12bemr37095458qvb.21.1681939256435;
        Wed, 19 Apr 2023 14:20:56 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id pr27-20020a056214141b00b005dd8b9345f8sm4570844qvb.144.2023.04.19.14.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:20:56 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 02/10] btrfs-progs: bring root->state into btrfs-progs
Date:   Wed, 19 Apr 2023 17:20:42 -0400
Message-Id: <c7e604aca3db88c138c0fab04fccfc909035c0c9.1681939107.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681939107.git.josef@toxicpanda.com>
References: <cover.1681939107.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We changed from members in the root for all the different flags to a
bit based flag system.  In order to make syncing the kernel code into
btrfs-progs easier go ahead and sync in the bits we use and update all
the users of the old ->track_dirty and ->ref_cows to use the state bits.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c                |  3 +-
 kernel-shared/ctree.c       | 22 ++++++++-----
 kernel-shared/ctree.h       | 66 +++++++++++++++++++++++++++++++++++--
 kernel-shared/disk-io.c     | 21 ++++++------
 kernel-shared/extent-tree.c | 10 +++---
 5 files changed, 94 insertions(+), 28 deletions(-)

diff --git a/check/main.c b/check/main.c
index 99ff3bc3..45e3442d 100644
--- a/check/main.c
+++ b/check/main.c
@@ -63,6 +63,7 @@
 #include "check/qgroup-verify.h"
 #include "check/clear-cache.h"
 #include "kernel-shared/uapi/btrfs.h"
+#include "kernel-lib/bitops.h"
 
 /* Global context variables */
 struct btrfs_fs_info *gfs_info;
@@ -467,7 +468,7 @@ static void record_root_in_trans(struct btrfs_trans_handle *trans,
 				 struct btrfs_root *root)
 {
 	if (root->last_trans != trans->transid) {
-		root->track_dirty = 1;
+		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
 		root->last_trans = trans->transid;
 		root->commit_root = root->node;
 		extent_buffer_get(root->node);
diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 911ec51c..cfbcc689 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -20,6 +20,7 @@
 #include "kernel-shared/disk-io.h"
 #include "kernel-shared/transaction.h"
 #include "kernel-shared/print-tree.h"
+#include "kernel-lib/bitops.h"
 #include "crypto/crc32c.h"
 #include "common/internal.h"
 #include "common/messages.h"
@@ -119,7 +120,8 @@ void btrfs_release_path(struct btrfs_path *p)
 
 void add_root_to_dirty_list(struct btrfs_root *root)
 {
-	if (root->track_dirty && list_empty(&root->dirty_list)) {
+	if (test_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state) &&
+	    list_empty(&root->dirty_list)) {
 		list_add(&root->dirty_list,
 			 &root->fs_info->dirty_cowonly_roots);
 	}
@@ -155,9 +157,10 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 	memcpy(new_root, root, sizeof(*new_root));
 	new_root->root_key.objectid = new_root_objectid;
 
-	WARN_ON(root->ref_cows && trans->transid !=
-		root->fs_info->running_transaction->transid);
-	WARN_ON(root->ref_cows && trans->transid != root->last_trans);
+	WARN_ON(test_bit(BTRFS_ROOT_SHAREABLE, &root->state) &&
+		trans->transid != root->fs_info->running_transaction->transid);
+	WARN_ON(test_bit(BTRFS_ROOT_SHAREABLE, &root->state) &&
+		trans->transid != root->last_trans);
 
 	level = btrfs_header_level(buf);
 	if (level == 0)
@@ -219,7 +222,7 @@ int btrfs_create_root(struct btrfs_trans_handle *trans,
 
 	btrfs_setup_root(new_root, fs_info, objectid);
 	if (!is_fstree(objectid))
-		new_root->track_dirty = 1;
+		set_bit(BTRFS_ROOT_TRACK_DIRTY, &new_root->state);
 	add_root_to_dirty_list(new_root);
 
 	new_root->objectid = objectid;
@@ -332,7 +335,7 @@ static int btrfs_block_can_be_shared(struct btrfs_root *root,
 	 * snapshot and the block was not allocated by tree relocation,
 	 * we know the block is not shared.
 	 */
-	if (root->ref_cows &&
+	if (test_bit(BTRFS_ROOT_SHAREABLE, &root->state) &&
 	    buf != root->node && buf != root->commit_root &&
 	    (btrfs_header_generation(buf) <=
 	     btrfs_root_last_snapshot(&root->root_item) ||
@@ -446,9 +449,10 @@ int __btrfs_cow_block(struct btrfs_trans_handle *trans,
 	struct btrfs_disk_key disk_key;
 	int level;
 
-	WARN_ON(root->ref_cows && trans->transid !=
-		root->fs_info->running_transaction->transid);
-	WARN_ON(root->ref_cows && trans->transid != root->last_trans);
+	WARN_ON(test_bit(BTRFS_ROOT_SHAREABLE, &root->state) &&
+		trans->transid != root->fs_info->running_transaction->transid);
+	WARN_ON(test_bit(BTRFS_ROOT_SHAREABLE, &root->state) &&
+		trans->transid != root->last_trans);
 
 	level = btrfs_header_level(buf);
 
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 8de1fba4..84acefef 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -388,6 +388,68 @@ static inline bool btrfs_is_zoned(const struct btrfs_fs_info *fs_info)
 	return fs_info->zoned != 0;
 }
 
+/*
+ * The state of btrfs root
+ */
+enum {
+	/*
+	 * btrfs_record_root_in_trans is a multi-step process, and it can race
+	 * with the balancing code.   But the race is very small, and only the
+	 * first time the root is added to each transaction.  So IN_TRANS_SETUP
+	 * is used to tell us when more checks are required
+	 */
+	BTRFS_ROOT_IN_TRANS_SETUP,
+
+	/*
+	 * Set if tree blocks of this root can be shared by other roots.
+	 * Only subvolume trees and their reloc trees have this bit set.
+	 * Conflicts with TRACK_DIRTY bit.
+	 *
+	 * This affects two things:
+	 *
+	 * - How balance works
+	 *   For shareable roots, we need to use reloc tree and do path
+	 *   replacement for balance, and need various pre/post hooks for
+	 *   snapshot creation to handle them.
+	 *
+	 *   While for non-shareable trees, we just simply do a tree search
+	 *   with COW.
+	 *
+	 * - How dirty roots are tracked
+	 *   For shareable roots, btrfs_record_root_in_trans() is needed to
+	 *   track them, while non-subvolume roots have TRACK_DIRTY bit, they
+	 *   don't need to set this manually.
+	 */
+	BTRFS_ROOT_SHAREABLE,
+	BTRFS_ROOT_TRACK_DIRTY,
+	BTRFS_ROOT_IN_RADIX,
+	BTRFS_ROOT_ORPHAN_ITEM_INSERTED,
+	BTRFS_ROOT_DEFRAG_RUNNING,
+	BTRFS_ROOT_FORCE_COW,
+	BTRFS_ROOT_MULTI_LOG_TASKS,
+	BTRFS_ROOT_DIRTY,
+	BTRFS_ROOT_DELETING,
+
+	/*
+	 * Reloc tree is orphan, only kept here for qgroup delayed subtree scan
+	 *
+	 * Set for the subvolume tree owning the reloc tree.
+	 */
+	BTRFS_ROOT_DEAD_RELOC_TREE,
+	/* Mark dead root stored on device whose cleanup needs to be resumed */
+	BTRFS_ROOT_DEAD_TREE,
+	/* The root has a log tree. Used for subvolume roots and the tree root. */
+	BTRFS_ROOT_HAS_LOG_TREE,
+	/* Qgroup flushing is in progress */
+	BTRFS_ROOT_QGROUP_FLUSHING,
+	/* We started the orphan cleanup for this root. */
+	BTRFS_ROOT_ORPHAN_CLEANUP,
+	/* This root has a drop operation that was started previously. */
+	BTRFS_ROOT_UNFINISHED_DROP,
+	/* This reloc root needs to have its buffers lockdep class reset. */
+	BTRFS_ROOT_RESET_LOCKDEP_CLASS,
+};
+
 /*
  * in ram representation of the tree.  extent_root is used for all allocations
  * and for the extent tree extent_root root.
@@ -401,9 +463,7 @@ struct btrfs_root {
 	u64 objectid;
 	u64 last_trans;
 
-	int ref_cows;
-	int track_dirty;
-
+	unsigned long state;
 
 	u32 type;
 	u64 last_inode_alloc;
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 030bc780..44462d8f 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -32,6 +32,7 @@
 #include "crypto/crc32c.h"
 #include "common/utils.h"
 #include "kernel-shared/print-tree.h"
+#include "kernel-lib/bitops.h"
 #include "common/rbtree-utils.h"
 #include "common/device-scan.h"
 #include "common/device-utils.h"
@@ -491,8 +492,7 @@ void btrfs_setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
 {
 	root->node = NULL;
 	root->commit_root = NULL;
-	root->ref_cows = 0;
-	root->track_dirty = 0;
+	root->state = 0;
 
 	root->fs_info = fs_info;
 	root->objectid = objectid;
@@ -654,9 +654,9 @@ out:
 	}
 insert:
 	if (root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID)
-		root->track_dirty = 1;
+		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
 	if (is_fstree(root->root_key.objectid))
-		root->ref_cows = 1;
+		set_bit(BTRFS_ROOT_SHAREABLE, &root->state);
 	return root;
 }
 
@@ -1062,7 +1062,7 @@ static int load_global_roots_objectid(struct btrfs_fs_info *fs_info,
 			free(root);
 			break;
 		}
-		root->track_dirty = 1;
+		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
 
 		ret = btrfs_global_root_insert(fs_info, root);
 		if (ret) {
@@ -1099,7 +1099,7 @@ static int load_global_roots_objectid(struct btrfs_fs_info *fs_info,
 			root->root_key.objectid = objectid;
 			root->root_key.type = BTRFS_ROOT_ITEM_KEY;
 			root->root_key.offset = i;
-			root->track_dirty = 1;
+			set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
 			root->node = btrfs_find_create_tree_block(fs_info, 0);
 			if (!root->node) {
 				free(root);
@@ -1232,7 +1232,8 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info, u64 root_tree_bytenr,
 			error("couldn't load block group tree");
 			return -EIO;
 		}
-		fs_info->block_group_root->track_dirty = 1;
+		set_bit(BTRFS_ROOT_TRACK_DIRTY,
+			&fs_info->block_group_root->state);
 	}
 
 	ret = btrfs_find_and_setup_root(root, fs_info,
@@ -1242,7 +1243,7 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info, u64 root_tree_bytenr,
 		printk("Couldn't setup device tree\n");
 		return -EIO;
 	}
-	fs_info->dev_root->track_dirty = 1;
+	set_bit(BTRFS_ROOT_TRACK_DIRTY, &fs_info->dev_root->state);
 
 	ret = btrfs_find_and_setup_root(root, fs_info,
 					BTRFS_UUID_TREE_OBJECTID,
@@ -1251,7 +1252,7 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info, u64 root_tree_bytenr,
 		free(fs_info->uuid_root);
 		fs_info->uuid_root = NULL;
 	} else {
-		fs_info->uuid_root->track_dirty = 1;
+		set_bit(BTRFS_ROOT_TRACK_DIRTY, &fs_info->uuid_root->state);
 	}
 
 	ret = btrfs_find_and_setup_root(root, fs_info,
@@ -2355,7 +2356,7 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 
 	extent_buffer_get(root->node);
 	root->commit_root = root->node;
-	root->track_dirty = 1;
+	set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
 
 	root->root_item.flags = 0;
 	root->root_item.byte_limit = 0;
diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 2a71b97a..8f3477bf 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -1471,7 +1471,7 @@ static int __btrfs_mod_ref(struct btrfs_trans_handle *trans,
 	nritems = btrfs_header_nritems(buf);
 	level = btrfs_header_level(buf);
 
-	if (!root->ref_cows && level == 0)
+	if (!test_bit(BTRFS_ROOT_SHAREABLE, &root->state) && level == 0)
 		return 0;
 
 	if (inc)
@@ -2359,11 +2359,11 @@ int btrfs_reserve_extent(struct btrfs_trans_handle *trans,
 	}
 
 	/*
-	 * Also preallocate metadata for csum tree and fs trees (root->ref_cows
-	 * already set), as they can consume a lot of metadata space.
-	 * Pre-allocate to avoid unexpected ENOSPC.
+	 * Also preallocate metadata for csum tree and fs trees
+	 * (BTRFS_ROOT_SHAREABLE already set) as they can consume a lot of
+	 * metadata space.  Pre-allocate to avoid unexpected ENOSPC.
 	 */
-	if (root->ref_cows ||
+	if (test_bit(BTRFS_ROOT_SHAREABLE, &root->state) ||
 	    root->root_key.objectid == BTRFS_CSUM_TREE_OBJECTID) {
 		if (!(profile & BTRFS_BLOCK_GROUP_METADATA)) {
 			ret = do_chunk_alloc(trans, info,
-- 
2.40.0

