Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D58F785ABD
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 16:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbjHWOeF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 10:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235007AbjHWOeC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 10:34:02 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CEBE6A
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:56 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-59209b12c50so38718617b3.0
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692801236; x=1693406036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5WdiKFb+xyitKxkEcE4CLZu/FEeC1TYOTHzS6mub1Vw=;
        b=IUfHaCreAl6Vv4pzoZlN5l1T/nFZLE3EYwmSh1cuqNuXmXlGfq0RbK+XEPlAcizxrN
         PUA78awhMoBs4tYASAm6khw0hKCkHGjwmt74i1F51qNM7TGVI5OwiDbNgp1dlQ5mbyfC
         0NUUsEXutfYYVR9yQKdaCik2RpfXkK7KE6JOs33qAHHI9WNntxIeXTEsK/nbv7hdXG67
         sWCgyFhJFq+ghqQ+fZFVCgCUKj50vNgvV0OYC27bni5XmcbP0X2eFvclEqRyjcFM5ixj
         4uovw7Hq/+/W4O8G/8McCyZa0proeuLxVH+bwSJp2UbFd2jmgssPOuomoNMuy/mcn2tR
         XSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692801236; x=1693406036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5WdiKFb+xyitKxkEcE4CLZu/FEeC1TYOTHzS6mub1Vw=;
        b=XOUh7mM3+aWOIdUMenPgpEKRF75Dmea5rNFzeEkl4W1AV8Gd+ZAQ59bWh6jO3eVmnn
         v2LLIvGIZCcciV7fbOrD9r5ykyRTs/iaZ82n3sD2e13GG7AtIHkU7QygDiuWNHHE1BvY
         7OQoL6ZMxy2JLESLtzXcUv9I9NrlQYJMCanBRhQ7IH4bcnVf8xGywfeti03XPDsmTDMT
         ILcdXBE6t5ulvRoqwIjEAs0TbxqrcmHGZYjv4wMT12HaC6QTVVmDfS/HBEH7A/1EGTEY
         iPhJFkf27lO9pGhjTcmbRcMICjg2jHZJQiJwEU+pHo5PamQ+xvZFyWoPXUF0qGkGv4EN
         upDQ==
X-Gm-Message-State: AOJu0YyC97EJiH3HOdPOGDFs1FVtPG6PiUk59sV2fQkm29gIELw77vOd
        u2/++qTdn+4ZCbxVqPJ6zh+CbhNRbwOlWbd5uF8=
X-Google-Smtp-Source: AGHT+IG+a0I3t0zX9j/a4h5qVKDj/A/acUpjafHNaHqCgUEa8948t9fusYyC1AewTsCFKpx33u3dBg==
X-Received: by 2002:a81:bf48:0:b0:58d:65d4:72cf with SMTP id s8-20020a81bf48000000b0058d65d472cfmr13463728ywk.24.1692801234114;
        Wed, 23 Aug 2023 07:33:54 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id z3-20020a81c203000000b005899c8e8242sm3338930ywc.138.2023.08.23.07.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:33:53 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 38/38] btrfs-progs: sync ctree.c from kernel
Date:   Wed, 23 Aug 2023 10:33:04 -0400
Message-ID: <db48e0b7fc0ece033ed76135294d4ad761eac418.1692800904.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692800904.git.josef@toxicpanda.com>
References: <cover.1692800904.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This copies the current copy of ctree.c into btrfs-progs.  There are a
few modifications, they are all hi-lighted by a "MODIFIED" tag in the
code.

- The btrfs_path_cachep is a static struct to avoid needing to call
  btrfs_ctree_init to be able to use stuff.
- There is a single page optimization in the search that is not relevant
  in btrfs-progs.
- We have a few warnings around trans->transaction, but we don't have
  this distinction in btrfs-progs yet.
- Obvious include cleanups

The rest is a straight copy, the only "modifications" that I didn't note
were in ctree.h to clean up some of the inline helpers that use
different functions.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.c | 4258 ++++++++++++++++++++++++++++++-----------
 kernel-shared/ctree.h |   50 +-
 2 files changed, 3219 insertions(+), 1089 deletions(-)

diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 866a748f..5333c071 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -1,33 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) 2007 Oracle.  All rights reserved.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public
- * License v2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public
- * License along with this program; if not, write to the
- * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
- * Boston, MA 021110-1307, USA.
+ * Copyright (C) 2007,2008 Oracle.  All rights reserved.
  */
 
 #include "kernel-lib/bitops.h"
-#include "kernel-lib/sizes.h"
-#include "kernel-shared/ctree.h"
-#include "kernel-shared/disk-io.h"
-#include "kernel-shared/transaction.h"
-#include "kernel-shared/print-tree.h"
-#include "kernel-shared/tree-checker.h"
-#include "kernel-shared/volumes.h"
-#include "common/internal.h"
-#include "common/messages.h"
-#include "common/utils.h"
-#include "check/repair.h"
+#include "kernel-lib/trace.h"
+#include "messages.h"
+#include "ctree.h"
+#include "disk-io.h"
+#include "transaction.h"
+#include "print-tree.h"
+#include "locking.h"
+#include "volumes.h"
+#include "tree-mod-log.h"
+#include "tree-checker.h"
+#include "accessors.h"
+#include "file-item.h"
+
+/* MODIFIED: use this instead of calling btrfs_ctree_init. */
+static struct kmem_cache btrfs_path_cache_struct = {
+	.size = sizeof(struct btrfs_path),
+};
+
+static struct kmem_cache *btrfs_path_cachep = &btrfs_path_cache_struct;
 
 static int split_node(struct btrfs_trans_handle *trans, struct btrfs_root
 		      *root, struct btrfs_path *path, int level);
@@ -151,12 +146,19 @@ static inline void copy_leaf_items(const struct extent_buffer *dst,
 			      nr_items * sizeof(struct btrfs_item));
 }
 
-int btrfs_super_csum_size(const struct btrfs_super_block *sb)
+/* This exists for btrfs-progs usages. */
+u16 btrfs_csum_type_size(u16 type)
 {
-	const u16 csum_type = btrfs_super_csum_type(sb);
+	return btrfs_csums[type].size;
+}
 
-	/* csum type is validated at mount time */
-	return btrfs_csums[csum_type].size;
+int btrfs_super_csum_size(const struct btrfs_super_block *s)
+{
+	u16 t = btrfs_super_csum_type(s);
+	/*
+	 * csum type is validated at mount time
+	 */
+	return btrfs_csum_type_size(t);
 }
 
 const char *btrfs_super_csum_name(u16 csum_type)
@@ -182,16 +184,11 @@ size_t __attribute_const__ btrfs_get_num_csums(void)
 	return ARRAY_SIZE(btrfs_csums);
 }
 
-u16 btrfs_csum_type_size(u16 csum_type)
-{
-	return btrfs_csums[csum_type].size;
-}
-
 struct btrfs_path *btrfs_alloc_path(void)
 {
 	might_sleep();
 
-	return kzalloc(sizeof(struct btrfs_path), GFP_NOFS);
+	return kmem_cache_zalloc(btrfs_path_cachep, GFP_NOFS);
 }
 
 /* this also releases the path */
@@ -200,7 +197,7 @@ void btrfs_free_path(struct btrfs_path *p)
 	if (!p)
 		return;
 	btrfs_release_path(p);
-	kfree(p);
+	kmem_cache_free(btrfs_path_cachep, p);
 }
 
 /*
@@ -224,7 +221,6 @@ noinline void btrfs_release_path(struct btrfs_path *p)
 		free_extent_buffer(p->nodes[i]);
 		p->nodes[i] = NULL;
 	}
-	memset(p, 0, sizeof(*p));
 }
 
 /*
@@ -243,47 +239,84 @@ bool __cold abort_should_print_stack(int errno)
 	return true;
 }
 
+/*
+ * safely gets a reference on the root node of a tree.  A lock
+ * is not taken, so a concurrent writer may put a different node
+ * at the root of the tree.  See btrfs_lock_root_node for the
+ * looping required.
+ *
+ * The extent buffer returned by this has a reference taken, so
+ * it won't disappear.  It may stop being the root of the tree
+ * at any time because there are no locks held.
+ */
+struct extent_buffer *btrfs_root_node(struct btrfs_root *root)
+{
+	struct extent_buffer *eb;
+
+	while (1) {
+		rcu_read_lock();
+		eb = rcu_dereference(root->node);
+
+		/*
+		 * RCU really hurts here, we could free up the root node because
+		 * it was COWed but we may not get the new root node yet so do
+		 * the inc_not_zero dance and if it doesn't work then
+		 * synchronize_rcu and try again.
+		 */
+		if (atomic_inc_not_zero(&eb->refs)) {
+			rcu_read_unlock();
+			break;
+		}
+		rcu_read_unlock();
+		synchronize_rcu();
+	}
+	return eb;
+}
+
+/*
+ * Cowonly root (not-shareable trees, everything not subvolume or reloc roots),
+ * just get put onto a simple dirty list.  Transaction walks this list to make
+ * sure they get properly updated on disk.
+ */
 static void add_root_to_dirty_list(struct btrfs_root *root)
 {
-	if (test_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state) &&
-	    list_empty(&root->dirty_list)) {
-		list_add(&root->dirty_list,
-			 &root->fs_info->dirty_cowonly_roots);
+	struct btrfs_fs_info *fs_info = root->fs_info;
+
+	if (test_bit(BTRFS_ROOT_DIRTY, &root->state) ||
+	    !test_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state))
+		return;
+
+	spin_lock(&fs_info->trans_lock);
+	if (!test_and_set_bit(BTRFS_ROOT_DIRTY, &root->state)) {
+		/* Want the extent tree to be the last on the list */
+		if (root->root_key.objectid == BTRFS_EXTENT_TREE_OBJECTID)
+			list_move_tail(&root->dirty_list,
+				       &fs_info->dirty_cowonly_roots);
+		else
+			list_move(&root->dirty_list,
+				  &fs_info->dirty_cowonly_roots);
 	}
+	spin_unlock(&fs_info->trans_lock);
 }
 
-static void root_add_used(struct btrfs_root *root, u32 size)
-{
-        btrfs_set_root_used(&root->root_item,
-                            btrfs_root_used(&root->root_item) + size);
-}
-
-static void root_sub_used(struct btrfs_root *root, u32 size)
-{
-        btrfs_set_root_used(&root->root_item,
-                            btrfs_root_used(&root->root_item) - size);
-}
-
+/*
+ * used by snapshot creation to make a copy of a root for a tree with
+ * a given objectid.  The buffer with the new root node is returned in
+ * cow_ret, and this func returns zero on success or a negative error code.
+ */
 int btrfs_copy_root(struct btrfs_trans_handle *trans,
 		      struct btrfs_root *root,
 		      struct extent_buffer *buf,
 		      struct extent_buffer **cow_ret, u64 new_root_objectid)
 {
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct extent_buffer *cow;
 	int ret = 0;
 	int level;
-	struct btrfs_root *new_root;
 	struct btrfs_disk_key disk_key;
 
-	new_root = kmalloc(sizeof(*new_root), GFP_NOFS);
-	if (!new_root)
-		return -ENOMEM;
-
-	memcpy(new_root, root, sizeof(*new_root));
-	new_root->root_key.objectid = new_root_objectid;
-
 	WARN_ON(test_bit(BTRFS_ROOT_SHAREABLE, &root->state) &&
-		trans->transid != root->fs_info->running_transaction->transid);
+		trans->transid != fs_info->running_transaction->transid);
 	WARN_ON(test_bit(BTRFS_ROOT_SHAREABLE, &root->state) &&
 		trans->transid != root->last_trans);
 
@@ -293,13 +326,11 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 	else
 		btrfs_node_key(buf, &disk_key, 0);
 
-	cow = btrfs_alloc_tree_block(trans, new_root, 0, new_root_objectid,
+	cow = btrfs_alloc_tree_block(trans, root, 0, new_root_objectid,
 				     &disk_key, level, buf->start, 0,
-				     BTRFS_NESTING_NORMAL);
-	if (IS_ERR(cow)) {
-		kfree(new_root);
+				     BTRFS_NESTING_NEW_ROOT);
+	if (IS_ERR(cow))
 		return PTR_ERR(cow);
-	}
 
 	copy_extent_buffer_full(cow, buf);
 	btrfs_set_header_bytenr(cow, cow->start);
@@ -312,14 +343,19 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 	else
 		btrfs_set_header_owner(cow, new_root_objectid);
 
-	write_extent_buffer_fsid(cow, root->fs_info->fs_devices->metadata_uuid);
+	write_extent_buffer_fsid(cow, fs_info->fs_devices->metadata_uuid);
 
 	WARN_ON(btrfs_header_generation(buf) > trans->transid);
-	ret = btrfs_inc_ref(trans, new_root, cow, 0);
-	kfree(new_root);
-
-	if (ret)
+	if (new_root_objectid == BTRFS_TREE_RELOC_OBJECTID)
+		ret = btrfs_inc_ref(trans, root, cow, 1);
+	else
+		ret = btrfs_inc_ref(trans, root, cow, 0);
+	if (ret) {
+		btrfs_tree_unlock(cow);
+		free_extent_buffer(cow);
+		btrfs_abort_transaction(trans, ret);
 		return ret;
+	}
 
 	btrfs_mark_buffer_dirty(cow);
 	*cow_ret = cow;
@@ -329,8 +365,8 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 /*
  * check if the tree block can be shared by multiple trees
  */
-static int btrfs_block_can_be_shared(struct btrfs_root *root,
-			             struct extent_buffer *buf)
+int btrfs_block_can_be_shared(struct btrfs_root *root,
+			      struct extent_buffer *buf)
 {
 	/*
 	 * Tree blocks not in shareable trees and tree roots are never shared.
@@ -350,8 +386,10 @@ static int btrfs_block_can_be_shared(struct btrfs_root *root,
 static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
 				       struct btrfs_root *root,
 				       struct extent_buffer *buf,
-				       struct extent_buffer *cow)
+				       struct extent_buffer *cow,
+				       int *last_ref)
 {
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	u64 refs;
 	u64 owner;
 	u64 flags;
@@ -376,12 +414,20 @@ static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
 	 */
 
 	if (btrfs_block_can_be_shared(root, buf)) {
-		ret = btrfs_lookup_extent_info(trans, trans->fs_info,
-					       buf->start,
+		ret = btrfs_lookup_extent_info(trans, fs_info, buf->start,
 					       btrfs_header_level(buf), 1,
 					       &refs, &flags);
-		BUG_ON(ret);
-		BUG_ON(refs == 0);
+		if (ret)
+			return ret;
+		if (unlikely(refs == 0)) {
+			btrfs_crit(fs_info,
+		"found 0 references for tree block at bytenr %llu level %d root %llu",
+				   buf->start, btrfs_header_level(buf),
+				   btrfs_root_id(root));
+			ret = -EUCLEAN;
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
 	} else {
 		refs = 1;
 		if (root->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID ||
@@ -392,22 +438,25 @@ static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
 	}
 
 	owner = btrfs_header_owner(buf);
-	BUG_ON(!(flags & BTRFS_BLOCK_FLAG_FULL_BACKREF) &&
-	       owner == BTRFS_TREE_RELOC_OBJECTID);
+	BUG_ON(owner == BTRFS_TREE_RELOC_OBJECTID &&
+	       !(flags & BTRFS_BLOCK_FLAG_FULL_BACKREF));
 
 	if (refs > 1) {
 		if ((owner == root->root_key.objectid ||
 		     root->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID) &&
 		    !(flags & BTRFS_BLOCK_FLAG_FULL_BACKREF)) {
 			ret = btrfs_inc_ref(trans, root, buf, 1);
-			BUG_ON(ret);
+			if (ret)
+				return ret;
 
 			if (root->root_key.objectid ==
 			    BTRFS_TREE_RELOC_OBJECTID) {
 				ret = btrfs_dec_ref(trans, root, buf, 0);
-				BUG_ON(ret);
+				if (ret)
+					return ret;
 				ret = btrfs_inc_ref(trans, root, cow, 1);
-				BUG_ON(ret);
+				if (ret)
+					return ret;
 			}
 			new_flags |= BTRFS_BLOCK_FLAG_FULL_BACKREF;
 		} else {
@@ -417,11 +466,13 @@ static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
 				ret = btrfs_inc_ref(trans, root, cow, 1);
 			else
 				ret = btrfs_inc_ref(trans, root, cow, 0);
-			BUG_ON(ret);
+			if (ret)
+				return ret;
 		}
 		if (new_flags != 0) {
 			ret = btrfs_set_disk_extent_flags(trans, buf, new_flags);
-			BUG_ON(ret);
+			if (ret)
+				return ret;
 		}
 	} else {
 		if (flags & BTRFS_BLOCK_FLAG_FULL_BACKREF) {
@@ -430,11 +481,14 @@ static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
 				ret = btrfs_inc_ref(trans, root, cow, 1);
 			else
 				ret = btrfs_inc_ref(trans, root, cow, 0);
-			BUG_ON(ret);
+			if (ret)
+				return ret;
 			ret = btrfs_dec_ref(trans, root, buf, 1);
-			BUG_ON(ret);
+			if (ret)
+				return ret;
 		}
 		btrfs_clear_buffer_dirty(trans, buf);
+		*last_ref = 1;
 	}
 	return 0;
 }
@@ -456,14 +510,24 @@ static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
 			     struct extent_buffer *buf,
 			     struct extent_buffer *parent, int parent_slot,
 			     struct extent_buffer **cow_ret,
-			     u64 search_start, u64 empty_size)
+			     u64 search_start, u64 empty_size,
+			     enum btrfs_lock_nesting nest)
 {
-	struct extent_buffer *cow;
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_disk_key disk_key;
-	int level;
+	struct extent_buffer *cow;
+	int level, ret;
+	int last_ref = 0;
+	int unlock_orig = 0;
+	u64 parent_start = 0;
+
+	if (*cow_ret == buf)
+		unlock_orig = 1;
+
+	btrfs_assert_tree_write_locked(buf);
 
 	WARN_ON(test_bit(BTRFS_ROOT_SHAREABLE, &root->state) &&
-		trans->transid != root->fs_info->running_transaction->transid);
+		trans->transid != fs_info->running_transaction->transid);
 	WARN_ON(test_bit(BTRFS_ROOT_SHAREABLE, &root->state) &&
 		trans->transid != root->last_trans);
 
@@ -474,12 +538,17 @@ static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
 	else
 		btrfs_node_key(buf, &disk_key, 0);
 
-	cow = btrfs_alloc_tree_block(trans, root, 0, root->root_key.objectid,
-				     &disk_key, level, search_start, empty_size,
-				     BTRFS_NESTING_NORMAL);
+	if ((root->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID) && parent)
+		parent_start = parent->start;
+
+	cow = btrfs_alloc_tree_block(trans, root, parent_start,
+				     root->root_key.objectid, &disk_key, level,
+				     search_start, empty_size, nest);
 	if (IS_ERR(cow))
 		return PTR_ERR(cow);
 
+	/* cow is set to blocking by btrfs_init_new_buffer */
+
 	copy_extent_buffer_full(cow, buf);
 	btrfs_set_header_bytenr(cow, cow->start);
 	btrfs_set_header_generation(cow, trans->transid);
@@ -491,38 +560,76 @@ static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
 	else
 		btrfs_set_header_owner(cow, root->root_key.objectid);
 
-	write_extent_buffer_fsid(cow, root->fs_info->fs_devices->metadata_uuid);
+	write_extent_buffer_fsid(cow, fs_info->fs_devices->metadata_uuid);
 
-	WARN_ON(!(buf->flags & EXTENT_BUFFER_BAD_TRANSID) &&
-		btrfs_header_generation(buf) > trans->transid);
+	ret = update_ref_for_cow(trans, root, buf, cow, &last_ref);
+	if (ret) {
+		btrfs_tree_unlock(cow);
+		free_extent_buffer(cow);
+		btrfs_abort_transaction(trans, ret);
+		return ret;
+	}
 
-	update_ref_for_cow(trans, root, buf, cow);
+	if (test_bit(BTRFS_ROOT_SHAREABLE, &root->state)) {
+		ret = btrfs_reloc_cow_block(trans, root, buf, cow);
+		if (ret) {
+			btrfs_tree_unlock(cow);
+			free_extent_buffer(cow);
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
+	}
 
 	if (buf == root->node) {
-		root->node = cow;
-		extent_buffer_get(cow);
+		WARN_ON(parent && parent != buf);
+		if (root->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID ||
+		    btrfs_header_backref_rev(buf) < BTRFS_MIXED_BACKREF_REV)
+			parent_start = buf->start;
 
-		btrfs_free_extent(trans, buf->start, buf->len, 0,
-				  root->root_key.objectid, level, 0);
+		ret = btrfs_tree_mod_log_insert_root(root->node, cow, true);
+		if (ret < 0) {
+			btrfs_tree_unlock(cow);
+			free_extent_buffer(cow);
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
+		atomic_inc(&cow->refs);
+		rcu_assign_pointer(root->node, cow);
+
+		btrfs_free_tree_block(trans, btrfs_root_id(root), buf,
+				      parent_start, last_ref);
 		free_extent_buffer(buf);
 		add_root_to_dirty_list(root);
 	} else {
+		WARN_ON(trans->transid != btrfs_header_generation(parent));
+		ret = btrfs_tree_mod_log_insert_key(parent, parent_slot,
+						    BTRFS_MOD_LOG_KEY_REPLACE);
+		if (ret) {
+			btrfs_tree_unlock(cow);
+			free_extent_buffer(cow);
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
 		btrfs_set_node_blockptr(parent, parent_slot,
 					cow->start);
-		WARN_ON(trans->transid == 0);
 		btrfs_set_node_ptr_generation(parent, parent_slot,
 					      trans->transid);
 		btrfs_mark_buffer_dirty(parent);
-		WARN_ON(btrfs_header_generation(parent) != trans->transid);
-
-		btrfs_free_extent(trans, buf->start, buf->len, 0,
-				  root->root_key.objectid, level, 0);
+		if (last_ref) {
+			ret = btrfs_tree_mod_log_free_eb(buf);
+			if (ret) {
+				btrfs_tree_unlock(cow);
+				free_extent_buffer(cow);
+				btrfs_abort_transaction(trans, ret);
+				return ret;
+			}
+		}
+		btrfs_free_tree_block(trans, btrfs_root_id(root), buf,
+				      parent_start, last_ref);
 	}
-	if (!list_empty(&buf->recow)) {
-		list_del_init(&buf->recow);
-		free_extent_buffer(buf);
-	}
-	free_extent_buffer(buf);
+	if (unlock_orig)
+		btrfs_tree_unlock(buf);
+	free_extent_buffer_stale(buf);
 	btrfs_mark_buffer_dirty(cow);
 	*cow_ret = cow;
 	return 0;
@@ -532,51 +639,91 @@ static inline int should_cow_block(struct btrfs_trans_handle *trans,
 				   struct btrfs_root *root,
 				   struct extent_buffer *buf)
 {
+	if (btrfs_is_testing(root->fs_info))
+		return 0;
+
+	/* Ensure we can see the FORCE_COW bit */
+	smp_mb__before_atomic();
+
+	/*
+	 * We do not need to cow a block if
+	 * 1) this block is not created or changed in this transaction;
+	 * 2) this block does not belong to TREE_RELOC tree;
+	 * 3) the root is not forced COW.
+	 *
+	 * What is forced COW:
+	 *    when we create snapshot during committing the transaction,
+	 *    after we've finished copying src root, we must COW the shared
+	 *    block to ensure the metadata consistency.
+	 */
 	if (btrfs_header_generation(buf) == trans->transid &&
 	    !btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN) &&
 	    !(root->root_key.objectid != BTRFS_TREE_RELOC_OBJECTID &&
-	      btrfs_header_flag(buf, BTRFS_HEADER_FLAG_RELOC)))
+	      btrfs_header_flag(buf, BTRFS_HEADER_FLAG_RELOC)) &&
+	    !test_bit(BTRFS_ROOT_FORCE_COW, &root->state))
 		return 0;
 	return 1;
 }
 
-int btrfs_cow_block(struct btrfs_trans_handle *trans,
+/*
+ * cows a single block, see __btrfs_cow_block for the real work.
+ * This version of it has extra checks so that a block isn't COWed more than
+ * once per transaction, as long as it hasn't been written yet
+ */
+noinline int btrfs_cow_block(struct btrfs_trans_handle *trans,
 		    struct btrfs_root *root, struct extent_buffer *buf,
 		    struct extent_buffer *parent, int parent_slot,
 		    struct extent_buffer **cow_ret,
 		    enum btrfs_lock_nesting nest)
 {
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	u64 search_start;
 	int ret;
-	/*
-	if (trans->transaction != root->fs_info->running_transaction) {
-		printk(KERN_CRIT "trans %llu running %llu\n", trans->transid,
-		       root->fs_info->running_transaction->transid);
-		WARN_ON(1);
-	}
-	*/
-	if (trans->transid != root->fs_info->generation) {
-		printk(KERN_CRIT "trans %llu running %llu\n",
-			(unsigned long long)trans->transid,
-			(unsigned long long)root->fs_info->generation);
-		WARN_ON(1);
-	}
+
+	if (test_bit(BTRFS_ROOT_DELETING, &root->state))
+		btrfs_err(fs_info,
+			"COW'ing blocks on a fs root that's being dropped");
+
+	/* MODIFIED: We don't have trans->transaction. */
+#if 0
+	if (trans->transaction != fs_info->running_transaction)
+		WARN(1, KERN_CRIT "trans %llu running %llu\n",
+		       trans->transid,
+		       fs_info->running_transaction->transid);
+#endif
+
+	if (trans->transid != fs_info->generation)
+		WARN(1, KERN_CRIT "trans %llu running %llu\n",
+		       trans->transid, fs_info->generation);
+
 	if (!should_cow_block(trans, root, buf)) {
 		*cow_ret = buf;
 		return 0;
 	}
 
 	search_start = buf->start & ~((u64)SZ_1G - 1);
+
+	/*
+	 * Before CoWing this block for later modification, check if it's
+	 * the subtree root and do the delayed subtree trace if needed.
+	 *
+	 * Also We don't care about the error, as it's handled internally.
+	 */
+	btrfs_qgroup_trace_subtree_after_cow(trans, root, buf);
 	ret = __btrfs_cow_block(trans, root, buf, parent,
-				 parent_slot, cow_ret, search_start, 0);
+				 parent_slot, cow_ret, search_start, 0, nest);
+
+	trace_btrfs_cow_block(root, buf, *cow_ret);
+
 	return ret;
 }
+ALLOW_ERROR_INJECTION(btrfs_cow_block, ERRNO);
 
 /*
  * helper function for defrag to decide if two blocks pointed to by a
  * node are actually close by
  */
-static __attribute__((unused)) int close_blocks(u64 blocknr, u64 other, u32 blocksize)
+static int close_blocks(u64 blocknr, u64 other, u32 blocksize)
 {
 	if (blocknr < other && other - (blocknr + blocksize) < 32768)
 		return 1;
@@ -585,6 +732,35 @@ static __attribute__((unused)) int close_blocks(u64 blocknr, u64 other, u32 bloc
 	return 0;
 }
 
+#ifdef __LITTLE_ENDIAN
+
+/*
+ * Compare two keys, on little-endian the disk order is same as CPU order and
+ * we can avoid the conversion.
+ */
+static int comp_keys(const struct btrfs_disk_key *disk_key,
+		     const struct btrfs_key *k2)
+{
+	const struct btrfs_key *k1 = (const struct btrfs_key *)disk_key;
+
+	return btrfs_comp_cpu_keys(k1, k2);
+}
+
+#else
+
+/*
+ * compare two keys in a memcmp fashion
+ */
+static int comp_keys(const struct btrfs_disk_key *disk,
+		     const struct btrfs_key *k2)
+{
+	struct btrfs_key k1;
+
+	btrfs_disk_key_to_cpu(&k1, disk);
+
+	return btrfs_comp_cpu_keys(&k1, k2);
+}
+#endif
 
 /*
  * same as comp_keys only with two btrfs_key's
@@ -607,60 +783,151 @@ int __pure btrfs_comp_cpu_keys(const struct btrfs_key *k1, const struct btrfs_ke
 }
 
 /*
- * compare two keys in a memcmp fashion
+ * this is used by the defrag code to go through all the
+ * leaves pointed to by a node and reallocate them so that
+ * disk order is close to key order
  */
-static int btrfs_comp_keys(struct btrfs_disk_key *disk,
-		const struct btrfs_key *k2)
+int btrfs_realloc_node(struct btrfs_trans_handle *trans,
+		       struct btrfs_root *root, struct extent_buffer *parent,
+		       int start_slot, u64 *last_ret,
+		       struct btrfs_key *progress)
 {
-	struct btrfs_key k1;
+	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct extent_buffer *cur;
+	u64 blocknr;
+	u64 search_start = *last_ret;
+	u64 last_block = 0;
+	u64 other;
+	u32 parent_nritems;
+	int end_slot;
+	int i;
+	int err = 0;
+	u32 blocksize;
+	int progress_passed = 0;
+	struct btrfs_disk_key disk_key;
 
-	btrfs_disk_key_to_cpu(&k1, disk);
-	return btrfs_comp_cpu_keys(&k1, k2);
-}
+	/* MODIFIED: We don't have trans->transaction.
+	WARN_ON(trans->transaction != fs_info->running_transaction);
+	*/
+	WARN_ON(trans->transid != fs_info->generation);
 
-static int noinline check_block(struct btrfs_fs_info *fs_info,
-				struct btrfs_path *path, int level)
-{
-	enum btrfs_tree_block_status ret;
+	parent_nritems = btrfs_header_nritems(parent);
+	blocksize = fs_info->nodesize;
+	end_slot = parent_nritems - 1;
 
-	if (path->skip_check_block)
+	if (parent_nritems <= 1)
 		return 0;
-	if (level == 0)
-		ret = __btrfs_check_leaf(path->nodes[0]);
-	else
-		ret = __btrfs_check_node(path->nodes[level]);
-	if (ret == BTRFS_TREE_BLOCK_CLEAN)
-		return 0;
-	return -EIO;
+
+	for (i = start_slot; i <= end_slot; i++) {
+		int close = 1;
+
+		btrfs_node_key(parent, &disk_key, i);
+		if (!progress_passed && comp_keys(&disk_key, progress) < 0)
+			continue;
+
+		progress_passed = 1;
+		blocknr = btrfs_node_blockptr(parent, i);
+		if (last_block == 0)
+			last_block = blocknr;
+
+		if (i > 0) {
+			other = btrfs_node_blockptr(parent, i - 1);
+			close = close_blocks(blocknr, other, blocksize);
+		}
+		if (!close && i < end_slot) {
+			other = btrfs_node_blockptr(parent, i + 1);
+			close = close_blocks(blocknr, other, blocksize);
+		}
+		if (close) {
+			last_block = blocknr;
+			continue;
+		}
+
+		cur = btrfs_read_node_slot(parent, i);
+		if (IS_ERR(cur))
+			return PTR_ERR(cur);
+		if (search_start == 0)
+			search_start = last_block;
+
+		btrfs_tree_lock(cur);
+		err = __btrfs_cow_block(trans, root, cur, parent, i,
+					&cur, search_start,
+					min(16 * blocksize,
+					    (end_slot - i) * blocksize),
+					BTRFS_NESTING_COW);
+		if (err) {
+			btrfs_tree_unlock(cur);
+			free_extent_buffer(cur);
+			break;
+		}
+		search_start = cur->start;
+		last_block = cur->start;
+		*last_ret = search_start;
+		btrfs_tree_unlock(cur);
+		free_extent_buffer(cur);
+	}
+	return err;
 }
 
 /*
- * search for key in the extent_buffer.  The items start at offset p,
- * and they are item_size apart.  There are 'max' items in p.
+ * Search for a key in the given extent_buffer.
  *
- * the slot in the array is returned via slot, and it points to
- * the place where you would insert key if it is not found in
- * the array.
+ * The lower boundary for the search is specified by the slot number @first_slot.
+ * Use a value of 0 to search over the whole extent buffer. Works for both
+ * leaves and nodes.
  *
- * slot may point to max if the key is bigger than all of the keys
+ * The slot in the extent buffer is returned via @slot. If the key exists in the
+ * extent buffer, then @slot will point to the slot where the key is, otherwise
+ * it points to the slot where you would insert the key.
+ *
+ * Slot may point to the total number of items (i.e. one position beyond the last
+ * key) if the key is bigger than the last key in the extent buffer.
+ *
+ * MODIFIED: Removed the in page optimization.
  */
-static int generic_bin_search(struct extent_buffer *eb, unsigned long p,
-			      int item_size, const struct btrfs_key *key,
-			      int max, int *slot)
+int btrfs_bin_search(struct extent_buffer *eb, int first_slot,
+		     const struct btrfs_key *key, int *slot)
 {
-	int low = 0;
-	int high = max;
-	int mid;
+	unsigned long p;
+	int item_size;
+	/*
+	 * Use unsigned types for the low and high slots, so that we get a more
+	 * efficient division in the search loop below.
+	 */
+	u32 low = first_slot;
+	u32 high = btrfs_header_nritems(eb);
 	int ret;
-	unsigned long offset;
-	struct btrfs_disk_key *tmp;
+	const int key_size = sizeof(struct btrfs_disk_key);
+
+	if (unlikely(low > high)) {
+		btrfs_err(eb->fs_info,
+		 "%s: low (%u) > high (%u) eb %llu owner %llu level %d",
+			  __func__, low, high, eb->start,
+			  btrfs_header_owner(eb), btrfs_header_level(eb));
+		return -EINVAL;
+	}
+
+	if (btrfs_header_level(eb) == 0) {
+		p = offsetof(struct btrfs_leaf, items);
+		item_size = sizeof(struct btrfs_item);
+	} else {
+		p = offsetof(struct btrfs_node, ptrs);
+		item_size = sizeof(struct btrfs_key_ptr);
+	}
+
+	while (low < high) {
+		unsigned long offset;
+		struct btrfs_disk_key *tmp;
+		struct btrfs_disk_key unaligned;
+		int mid;
 
-	while(low < high) {
 		mid = (low + high) / 2;
 		offset = p + mid * item_size;
 
-		tmp = (struct btrfs_disk_key *)(eb->data + offset);
-		ret = btrfs_comp_keys(tmp, key);
+		read_extent_buffer(eb, &unaligned, offset, key_size);
+		tmp = &unaligned;
+
+		ret = comp_keys(tmp, key);
 
 		if (ret < 0)
 			low = mid + 1;
@@ -675,61 +942,53 @@ static int generic_bin_search(struct extent_buffer *eb, unsigned long p,
 	return 1;
 }
 
-/*
- * simple bin_search frontend that does the right thing for
- * leaves vs nodes
- */
-int btrfs_bin_search(struct extent_buffer *eb, int first_slot,
-		     const struct btrfs_key *key, int *slot)
+static void root_add_used(struct btrfs_root *root, u32 size)
 {
-	if (btrfs_header_level(eb) == 0)
-		return generic_bin_search(eb,
-					  offsetof(struct btrfs_leaf, items),
-					  sizeof(struct btrfs_item),
-					  key, btrfs_header_nritems(eb),
-					  slot);
-	else
-		return generic_bin_search(eb,
-					  offsetof(struct btrfs_node, ptrs),
-					  sizeof(struct btrfs_key_ptr),
-					  key, btrfs_header_nritems(eb),
-					  slot);
+	spin_lock(&root->accounting_lock);
+	btrfs_set_root_used(&root->root_item,
+			    btrfs_root_used(&root->root_item) + size);
+	spin_unlock(&root->accounting_lock);
 }
 
+static void root_sub_used(struct btrfs_root *root, u32 size)
+{
+	spin_lock(&root->accounting_lock);
+	btrfs_set_root_used(&root->root_item,
+			    btrfs_root_used(&root->root_item) - size);
+	spin_unlock(&root->accounting_lock);
+}
+
+/* given a node and slot number, this reads the blocks it points to.  The
+ * extent buffer is returned with a reference taken (but unlocked).
+ */
 struct extent_buffer *btrfs_read_node_slot(struct extent_buffer *parent,
 					   int slot)
 {
-	struct btrfs_fs_info *fs_info = parent->fs_info;
-	struct extent_buffer *ret;
-	struct btrfs_tree_parent_check check = { 0 };
 	int level = btrfs_header_level(parent);
+	struct btrfs_tree_parent_check check = { 0 };
+	struct extent_buffer *eb;
 
-	if (slot < 0)
-		return NULL;
-	if (slot >= btrfs_header_nritems(parent))
-		return NULL;
+	if (slot < 0 || slot >= btrfs_header_nritems(parent))
+		return ERR_PTR(-ENOENT);
 
-	if (level == 0)
-		return NULL;
+	ASSERT(level);
 
-	check.owner_root = btrfs_header_owner(parent);
-	check.transid = btrfs_node_ptr_generation(parent, slot);
 	check.level = level - 1;
+	check.transid = btrfs_node_ptr_generation(parent, slot);
+	check.owner_root = btrfs_header_owner(parent);
+	check.has_first_key = true;
+	btrfs_node_key_to_cpu(parent, &check.first_key, slot);
 
-	ret = read_tree_block(fs_info, btrfs_node_blockptr(parent, slot),
-			      &check);
-	if (!extent_buffer_uptodate(ret))
-		return ERR_PTR(-EIO);
-
-	if (btrfs_header_level(ret) != level - 1) {
-		error(
-"child eb corrupted: parent bytenr=%llu item=%d parent level=%d child bytenr=%llu child level=%d",
-		      btrfs_header_bytenr(parent), slot, btrfs_header_level(parent),
-		      btrfs_header_bytenr(ret), btrfs_header_level(ret));
-		free_extent_buffer(ret);
+	eb = read_tree_block(parent->fs_info, btrfs_node_blockptr(parent, slot),
+			     &check);
+	if (IS_ERR(eb))
+		return eb;
+	if (!extent_buffer_uptodate(eb)) {
+		free_extent_buffer(eb);
 		return ERR_PTR(-EIO);
 	}
-	return ret;
+
+	return eb;
 }
 
 /*
@@ -752,10 +1011,11 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 	int orig_slot = path->slots[level];
 	u64 orig_ptr;
 
-	if (level == 0)
-		return 0;
+	ASSERT(level > 0);
 
 	mid = path->nodes[level];
+
+	WARN_ON(path->locks[level] != BTRFS_WRITE_LOCK);
 	WARN_ON(btrfs_header_generation(mid) != trans->transid);
 
 	orig_ptr = btrfs_node_blockptr(mid, orig_slot);
@@ -777,48 +1037,82 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 
 		/* promote the child to a root */
 		child = btrfs_read_node_slot(mid, 0);
-		BUG_ON(!extent_buffer_uptodate(child));
-		ret = btrfs_cow_block(trans, root, child, mid, 0, &child,
-				      BTRFS_NESTING_NORMAL);
-		BUG_ON(ret);
+		if (IS_ERR(child)) {
+			ret = PTR_ERR(child);
+			goto out;
+		}
+
+		btrfs_tree_lock(child);
+		ret = btrfs_cow_block(trans, root, child, mid, 0, &child,
+				      BTRFS_NESTING_COW);
+		if (ret) {
+			btrfs_tree_unlock(child);
+			free_extent_buffer(child);
+			goto out;
+		}
+
+		ret = btrfs_tree_mod_log_insert_root(root->node, child, true);
+		if (ret < 0) {
+			btrfs_tree_unlock(child);
+			free_extent_buffer(child);
+			btrfs_abort_transaction(trans, ret);
+			goto out;
+		}
+		rcu_assign_pointer(root->node, child);
 
-		root->node = child;
 		add_root_to_dirty_list(root);
+		btrfs_tree_unlock(child);
+
+		path->locks[level] = 0;
 		path->nodes[level] = NULL;
 		btrfs_clear_buffer_dirty(trans, mid);
+		btrfs_tree_unlock(mid);
 		/* once for the path */
 		free_extent_buffer(mid);
 
 		root_sub_used(root, mid->len);
-
-		ret = btrfs_free_extent(trans, mid->start, mid->len, 0,
-					root->root_key.objectid, level, 0);
+		btrfs_free_tree_block(trans, btrfs_root_id(root), mid, 0, 1);
 		/* once for the root ptr */
-		free_extent_buffer(mid);
-		return ret;
+		free_extent_buffer_stale(mid);
+		return 0;
 	}
 	if (btrfs_header_nritems(mid) >
 	    BTRFS_NODEPTRS_PER_BLOCK(fs_info) / 4)
 		return 0;
 
-	left = btrfs_read_node_slot(parent, pslot - 1);
-	if (extent_buffer_uptodate(left)) {
+	if (pslot) {
+		left = btrfs_read_node_slot(parent, pslot - 1);
+		if (IS_ERR(left)) {
+			ret = PTR_ERR(left);
+			left = NULL;
+			goto out;
+		}
+
+		__btrfs_tree_lock(left, BTRFS_NESTING_LEFT);
 		wret = btrfs_cow_block(trans, root, left,
 				       parent, pslot - 1, &left,
-				       BTRFS_NESTING_NORMAL);
+				       BTRFS_NESTING_LEFT_COW);
 		if (wret) {
 			ret = wret;
-			goto enospc;
+			goto out;
 		}
 	}
-	right = btrfs_read_node_slot(parent, pslot + 1);
-	if (extent_buffer_uptodate(right)) {
+
+	if (pslot + 1 < btrfs_header_nritems(parent)) {
+		right = btrfs_read_node_slot(parent, pslot + 1);
+		if (IS_ERR(right)) {
+			ret = PTR_ERR(right);
+			right = NULL;
+			goto out;
+		}
+
+		__btrfs_tree_lock(right, BTRFS_NESTING_RIGHT);
 		wret = btrfs_cow_block(trans, root, right,
 				       parent, pslot + 1, &right,
-				       BTRFS_NESTING_NORMAL);
+				       BTRFS_NESTING_RIGHT_COW);
 		if (wret) {
 			ret = wret;
-			goto enospc;
+			goto out;
 		}
 	}
 
@@ -838,23 +1132,28 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		if (wret < 0 && wret != -ENOSPC)
 			ret = wret;
 		if (btrfs_header_nritems(right) == 0) {
-			u64 bytenr = right->start;
-			u32 blocksize = right->len;
-
 			btrfs_clear_buffer_dirty(trans, right);
-			free_extent_buffer(right);
+			btrfs_tree_unlock(right);
+			ret = btrfs_del_ptr(trans, root, path, level + 1, pslot + 1);
+			if (ret < 0) {
+				free_extent_buffer_stale(right);
+				right = NULL;
+				goto out;
+			}
+			root_sub_used(root, right->len);
+			btrfs_free_tree_block(trans, btrfs_root_id(root), right,
+					      0, 1);
+			free_extent_buffer_stale(right);
 			right = NULL;
-			btrfs_del_ptr(trans, root, path, level + 1, pslot + 1);
-
-			root_sub_used(root, blocksize);
-			wret = btrfs_free_extent(trans, bytenr, blocksize, 0,
-						 root->root_key.objectid, level,
-						 0);
-			if (wret)
-				ret = wret;
 		} else {
 			struct btrfs_disk_key right_key;
 			btrfs_node_key(right, &right_key, 0);
+			ret = btrfs_tree_mod_log_insert_key(parent, pslot + 1,
+					BTRFS_MOD_LOG_KEY_REPLACE);
+			if (ret < 0) {
+				btrfs_abort_transaction(trans, ret);
+				goto out;
+			}
 			btrfs_set_node_key(parent, &right_key, pslot + 1);
 			btrfs_mark_buffer_dirty(parent);
 		}
@@ -869,11 +1168,19 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		 * otherwise we would have pulled some pointers from the
 		 * right
 		 */
-		BUG_ON(!left);
+		if (unlikely(!left)) {
+			btrfs_crit(fs_info,
+"missing left child when middle child only has 1 item, parent bytenr %llu level %d mid bytenr %llu root %llu",
+				   parent->start, btrfs_header_level(parent),
+				   mid->start, btrfs_root_id(root));
+			ret = -EUCLEAN;
+			btrfs_abort_transaction(trans, ret);
+			goto out;
+		}
 		wret = balance_node_right(trans, mid, left);
 		if (wret < 0) {
 			ret = wret;
-			goto enospc;
+			goto out;
 		}
 		if (wret == 1) {
 			wret = push_node_left(trans, left, mid, 1);
@@ -883,23 +1190,28 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		BUG_ON(wret == 1);
 	}
 	if (btrfs_header_nritems(mid) == 0) {
-		/* we've managed to empty the middle node, drop it */
-		u64 bytenr = mid->start;
-		u32 blocksize = mid->len;
 		btrfs_clear_buffer_dirty(trans, mid);
-		free_extent_buffer(mid);
+		btrfs_tree_unlock(mid);
+		ret = btrfs_del_ptr(trans, root, path, level + 1, pslot);
+		if (ret < 0) {
+			free_extent_buffer_stale(mid);
+			mid = NULL;
+			goto out;
+		}
+		root_sub_used(root, mid->len);
+		btrfs_free_tree_block(trans, btrfs_root_id(root), mid, 0, 1);
+		free_extent_buffer_stale(mid);
 		mid = NULL;
-		btrfs_del_ptr(trans, root, path, level + 1, pslot);
-
-		root_sub_used(root, blocksize);
-		wret = btrfs_free_extent(trans, bytenr, blocksize, 0,
-					 root->root_key.objectid, level, 0);
-		if (wret)
-			ret = wret;
 	} else {
 		/* update the parent key to reflect our changes */
 		struct btrfs_disk_key mid_key;
 		btrfs_node_key(mid, &mid_key, 0);
+		ret = btrfs_tree_mod_log_insert_key(parent, pslot,
+						    BTRFS_MOD_LOG_KEY_REPLACE);
+		if (ret < 0) {
+			btrfs_abort_transaction(trans, ret);
+			goto out;
+		}
 		btrfs_set_node_key(parent, &mid_key, pslot);
 		btrfs_mark_buffer_dirty(parent);
 	}
@@ -907,27 +1219,34 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 	/* update the path */
 	if (left) {
 		if (btrfs_header_nritems(left) > orig_slot) {
-			extent_buffer_get(left);
+			atomic_inc(&left->refs);
+			/* left was locked after cow */
 			path->nodes[level] = left;
 			path->slots[level + 1] -= 1;
 			path->slots[level] = orig_slot;
-			if (mid)
+			if (mid) {
+				btrfs_tree_unlock(mid);
 				free_extent_buffer(mid);
+			}
 		} else {
 			orig_slot -= btrfs_header_nritems(left);
 			path->slots[level] = orig_slot;
 		}
 	}
 	/* double check we haven't messed things up */
-	check_block(root->fs_info, path, level);
 	if (orig_ptr !=
 	    btrfs_node_blockptr(path->nodes[level], path->slots[level]))
 		BUG();
-enospc:
-	if (right)
+out:
+	if (right) {
+		btrfs_tree_unlock(right);
 		free_extent_buffer(right);
-	if (left)
+	}
+	if (left) {
+		if (path->nodes[level] != left)
+			btrfs_tree_unlock(left);
 		free_extent_buffer(left);
+	}
 	return ret;
 }
 
@@ -963,18 +1282,23 @@ static noinline int push_nodes_for_insert(struct btrfs_trans_handle *trans,
 	if (!parent)
 		return 1;
 
-	left = btrfs_read_node_slot(parent, pslot - 1);
-
 	/* first, try to make some room in the middle buffer */
-	if (extent_buffer_uptodate(left)) {
+	if (pslot) {
 		u32 left_nr;
+
+		left = btrfs_read_node_slot(parent, pslot - 1);
+		if (IS_ERR(left))
+			return PTR_ERR(left);
+
+		__btrfs_tree_lock(left, BTRFS_NESTING_LEFT);
+
 		left_nr = btrfs_header_nritems(left);
 		if (left_nr >= BTRFS_NODEPTRS_PER_BLOCK(fs_info) - 1) {
 			wret = 1;
 		} else {
 			ret = btrfs_cow_block(trans, root, left, parent,
 					      pslot - 1, &left,
-					      BTRFS_NESTING_NORMAL);
+					      BTRFS_NESTING_LEFT_COW);
 			if (ret)
 				wret = 1;
 			else {
@@ -987,37 +1311,54 @@ static noinline int push_nodes_for_insert(struct btrfs_trans_handle *trans,
 			struct btrfs_disk_key disk_key;
 			orig_slot += left_nr;
 			btrfs_node_key(mid, &disk_key, 0);
+			ret = btrfs_tree_mod_log_insert_key(parent, pslot,
+					BTRFS_MOD_LOG_KEY_REPLACE);
+			if (ret < 0) {
+				btrfs_tree_unlock(left);
+				free_extent_buffer(left);
+				btrfs_abort_transaction(trans, ret);
+				return ret;
+			}
 			btrfs_set_node_key(parent, &disk_key, pslot);
 			btrfs_mark_buffer_dirty(parent);
 			if (btrfs_header_nritems(left) > orig_slot) {
 				path->nodes[level] = left;
 				path->slots[level + 1] -= 1;
 				path->slots[level] = orig_slot;
+				btrfs_tree_unlock(mid);
 				free_extent_buffer(mid);
 			} else {
 				orig_slot -=
 					btrfs_header_nritems(left);
 				path->slots[level] = orig_slot;
+				btrfs_tree_unlock(left);
 				free_extent_buffer(left);
 			}
 			return 0;
 		}
+		btrfs_tree_unlock(left);
 		free_extent_buffer(left);
 	}
-	right= btrfs_read_node_slot(parent, pslot + 1);
 
 	/*
 	 * then try to empty the right most buffer into the middle
 	 */
-	if (extent_buffer_uptodate(right)) {
+	if (pslot + 1 < btrfs_header_nritems(parent)) {
 		u32 right_nr;
+
+		right = btrfs_read_node_slot(parent, pslot + 1);
+		if (IS_ERR(right))
+			return PTR_ERR(right);
+
+		__btrfs_tree_lock(right, BTRFS_NESTING_RIGHT);
+
 		right_nr = btrfs_header_nritems(right);
-		if (right_nr >= BTRFS_NODEPTRS_PER_BLOCK(root->fs_info) - 1) {
+		if (right_nr >= BTRFS_NODEPTRS_PER_BLOCK(fs_info) - 1) {
 			wret = 1;
 		} else {
 			ret = btrfs_cow_block(trans, root, right,
 					      parent, pslot + 1,
-					      &right, BTRFS_NESTING_NORMAL);
+					      &right, BTRFS_NESTING_RIGHT_COW);
 			if (ret)
 				wret = 1;
 			else {
@@ -1030,6 +1371,14 @@ static noinline int push_nodes_for_insert(struct btrfs_trans_handle *trans,
 			struct btrfs_disk_key disk_key;
 
 			btrfs_node_key(right, &disk_key, 0);
+			ret = btrfs_tree_mod_log_insert_key(parent, pslot + 1,
+					BTRFS_MOD_LOG_KEY_REPLACE);
+			if (ret < 0) {
+				btrfs_tree_unlock(right);
+				free_extent_buffer(right);
+				btrfs_abort_transaction(trans, ret);
+				return ret;
+			}
 			btrfs_set_node_key(parent, &disk_key, pslot + 1);
 			btrfs_mark_buffer_dirty(parent);
 
@@ -1038,12 +1387,15 @@ static noinline int push_nodes_for_insert(struct btrfs_trans_handle *trans,
 				path->slots[level + 1] += 1;
 				path->slots[level] = orig_slot -
 					btrfs_header_nritems(mid);
+				btrfs_tree_unlock(mid);
 				free_extent_buffer(mid);
 			} else {
+				btrfs_tree_unlock(right);
 				free_extent_buffer(right);
 			}
 			return 0;
 		}
+		btrfs_tree_unlock(right);
 		free_extent_buffer(right);
 	}
 	return 1;
@@ -1061,222 +1413,1101 @@ static void reada_for_search(struct btrfs_fs_info *fs_info,
 	struct btrfs_disk_key disk_key;
 	u32 nritems;
 	u64 search;
-	u64 lowest_read;
-	u64 highest_read;
+	u64 target;
 	u64 nread = 0;
-	int direction = path->reada;
-	struct extent_buffer *eb;
+	u64 nread_max;
 	u32 nr;
+	u32 blocksize;
 	u32 nscan = 0;
 
-	if (level != 1)
+	if (level != 1 && path->reada != READA_FORWARD_ALWAYS)
 		return;
 
 	if (!path->nodes[level])
 		return;
 
 	node = path->nodes[level];
-	search = btrfs_node_blockptr(node, slot);
-	eb = btrfs_find_tree_block(fs_info, search, fs_info->nodesize);
-	if (eb) {
-		free_extent_buffer(eb);
-		return;
+
+	/*
+	 * Since the time between visiting leaves is much shorter than the time
+	 * between visiting nodes, limit read ahead of nodes to 1, to avoid too
+	 * much IO at once (possibly random).
+	 */
+	if (path->reada == READA_FORWARD_ALWAYS) {
+		if (level > 1)
+			nread_max = node->fs_info->nodesize;
+		else
+			nread_max = SZ_128K;
+	} else {
+		nread_max = SZ_64K;
 	}
 
-	highest_read = search;
-	lowest_read = search;
+	search = btrfs_node_blockptr(node, slot);
+	blocksize = fs_info->nodesize;
+	if (path->reada != READA_FORWARD_ALWAYS) {
+		struct extent_buffer *eb;
+
+		eb = find_extent_buffer(fs_info, search);
+		if (eb) {
+			free_extent_buffer(eb);
+			return;
+		}
+	}
+
+	target = search;
 
 	nritems = btrfs_header_nritems(node);
 	nr = slot;
-	while(1) {
-		if (direction < 0) {
+
+	while (1) {
+		if (path->reada == READA_BACK) {
 			if (nr == 0)
 				break;
 			nr--;
-		} else if (direction > 0) {
+		} else if (path->reada == READA_FORWARD ||
+			   path->reada == READA_FORWARD_ALWAYS) {
 			nr++;
 			if (nr >= nritems)
 				break;
 		}
-		if (path->reada < 0 && objectid) {
+		if (path->reada == READA_BACK && objectid) {
 			btrfs_node_key(node, &disk_key, nr);
 			if (btrfs_disk_key_objectid(&disk_key) != objectid)
 				break;
 		}
 		search = btrfs_node_blockptr(node, nr);
-		if ((search >= lowest_read && search <= highest_read) ||
-		    (search < lowest_read && lowest_read - search <= 32768) ||
-		    (search > highest_read && search - highest_read <= 32768)) {
-			readahead_tree_block(fs_info, search,
-				     btrfs_node_ptr_generation(node, nr));
-			nread += fs_info->nodesize;
+		if (path->reada == READA_FORWARD_ALWAYS ||
+		    (search <= target && target - search <= 65536) ||
+		    (search > target && search - target <= 65536)) {
+			btrfs_readahead_node_child(node, nr);
+			nread += blocksize;
 		}
 		nscan++;
-		if (path->reada < 2 && (nread > SZ_256K || nscan > 32))
+		if (nread > nread_max || nscan > 32)
 			break;
-		if(nread > SZ_1M || nscan > 128)
-			break;
-
-		if (search < lowest_read)
-			lowest_read = search;
-		if (search > highest_read)
-			highest_read = search;
 	}
 }
 
-int btrfs_find_item(struct btrfs_root *fs_root, struct btrfs_path *found_path,
+static noinline void reada_for_balance(struct btrfs_path *path, int level)
+{
+	struct extent_buffer *parent;
+	int slot;
+	int nritems;
+
+	parent = path->nodes[level + 1];
+	if (!parent)
+		return;
+
+	nritems = btrfs_header_nritems(parent);
+	slot = path->slots[level + 1];
+
+	if (slot > 0)
+		btrfs_readahead_node_child(parent, slot - 1);
+	if (slot + 1 < nritems)
+		btrfs_readahead_node_child(parent, slot + 1);
+}
+
+
+/*
+ * when we walk down the tree, it is usually safe to unlock the higher layers
+ * in the tree.  The exceptions are when our path goes through slot 0, because
+ * operations on the tree might require changing key pointers higher up in the
+ * tree.
+ *
+ * callers might also have set path->keep_locks, which tells this code to keep
+ * the lock if the path points to the last slot in the block.  This is part of
+ * walking through the tree, and selecting the next slot in the higher block.
+ *
+ * lowest_unlock sets the lowest level in the tree we're allowed to unlock.  so
+ * if lowest_unlock is 1, level 0 won't be unlocked
+ */
+static noinline void unlock_up(struct btrfs_path *path, int level,
+			       int lowest_unlock, int min_write_lock_level,
+			       int *write_lock_level)
+{
+	int i;
+	int skip_level = level;
+	bool check_skip = true;
+
+	for (i = level; i < BTRFS_MAX_LEVEL; i++) {
+		if (!path->nodes[i])
+			break;
+		if (!path->locks[i])
+			break;
+
+		if (check_skip) {
+			if (path->slots[i] == 0) {
+				skip_level = i + 1;
+				continue;
+			}
+
+			if (path->keep_locks) {
+				u32 nritems;
+
+				nritems = btrfs_header_nritems(path->nodes[i]);
+				if (nritems < 1 || path->slots[i] >= nritems - 1) {
+					skip_level = i + 1;
+					continue;
+				}
+			}
+		}
+
+		if (i >= lowest_unlock && i > skip_level) {
+			check_skip = false;
+			btrfs_tree_unlock_rw(path->nodes[i], path->locks[i]);
+			path->locks[i] = 0;
+			if (write_lock_level &&
+			    i > min_write_lock_level &&
+			    i <= *write_lock_level) {
+				*write_lock_level = i - 1;
+			}
+		}
+	}
+}
+
+/*
+ * Helper function for btrfs_search_slot() and other functions that do a search
+ * on a btree. The goal is to find a tree block in the cache (the radix tree at
+ * fs_info->buffer_radix), but if we can't find it, or it's not up to date, read
+ * its pages from disk.
+ *
+ * Returns -EAGAIN, with the path unlocked, if the caller needs to repeat the
+ * whole btree search, starting again from the current root node.
+ */
+static int
+read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
+		      struct extent_buffer **eb_ret, int level, int slot,
+		      const struct btrfs_key *key)
+{
+	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct btrfs_tree_parent_check check = { 0 };
+	u64 blocknr;
+	u64 gen;
+	struct extent_buffer *tmp;
+	int ret;
+	int parent_level;
+	bool unlock_up;
+
+	unlock_up = ((level + 1 < BTRFS_MAX_LEVEL) && p->locks[level + 1]);
+	blocknr = btrfs_node_blockptr(*eb_ret, slot);
+	gen = btrfs_node_ptr_generation(*eb_ret, slot);
+	parent_level = btrfs_header_level(*eb_ret);
+	btrfs_node_key_to_cpu(*eb_ret, &check.first_key, slot);
+	check.has_first_key = true;
+	check.level = parent_level - 1;
+	check.transid = gen;
+	check.owner_root = root->root_key.objectid;
+
+	/*
+	 * If we need to read an extent buffer from disk and we are holding locks
+	 * on upper level nodes, we unlock all the upper nodes before reading the
+	 * extent buffer, and then return -EAGAIN to the caller as it needs to
+	 * restart the search. We don't release the lock on the current level
+	 * because we need to walk this node to figure out which blocks to read.
+	 */
+	tmp = find_extent_buffer(fs_info, blocknr);
+	if (tmp) {
+		if (p->reada == READA_FORWARD_ALWAYS)
+			reada_for_search(fs_info, p, level, slot, key->objectid);
+
+		/* first we do an atomic uptodate check */
+		if (btrfs_buffer_uptodate(tmp, gen, 1) > 0) {
+			/*
+			 * Do extra check for first_key, eb can be stale due to
+			 * being cached, read from scrub, or have multiple
+			 * parents (shared tree blocks).
+			 */
+			if (btrfs_verify_level_key(tmp,
+					parent_level - 1, &check.first_key, gen)) {
+				free_extent_buffer(tmp);
+				return -EUCLEAN;
+			}
+			*eb_ret = tmp;
+			return 0;
+		}
+
+		if (p->nowait) {
+			free_extent_buffer(tmp);
+			return -EAGAIN;
+		}
+
+		if (unlock_up)
+			btrfs_unlock_up_safe(p, level + 1);
+
+		/* now we're allowed to do a blocking uptodate check */
+		ret = btrfs_read_extent_buffer(tmp, &check);
+		if (ret) {
+			free_extent_buffer(tmp);
+			btrfs_release_path(p);
+			return -EIO;
+		}
+		if (btrfs_check_eb_owner(tmp, root->root_key.objectid)) {
+			free_extent_buffer(tmp);
+			btrfs_release_path(p);
+			return -EUCLEAN;
+		}
+
+		if (unlock_up)
+			ret = -EAGAIN;
+
+		goto out;
+	} else if (p->nowait) {
+		return -EAGAIN;
+	}
+
+	if (unlock_up) {
+		btrfs_unlock_up_safe(p, level + 1);
+		ret = -EAGAIN;
+	} else {
+		ret = 0;
+	}
+
+	if (p->reada != READA_NONE)
+		reada_for_search(fs_info, p, level, slot, key->objectid);
+
+	tmp = read_tree_block(fs_info, blocknr, &check);
+	if (IS_ERR(tmp)) {
+		btrfs_release_path(p);
+		return PTR_ERR(tmp);
+	}
+	/*
+	 * If the read above didn't mark this buffer up to date,
+	 * it will never end up being up to date.  Set ret to EIO now
+	 * and give up so that our caller doesn't loop forever
+	 * on our EAGAINs.
+	 */
+	if (!extent_buffer_uptodate(tmp))
+		ret = -EIO;
+
+out:
+	if (ret == 0) {
+		*eb_ret = tmp;
+	} else {
+		free_extent_buffer(tmp);
+		btrfs_release_path(p);
+	}
+
+	return ret;
+}
+
+/*
+ * helper function for btrfs_search_slot.  This does all of the checks
+ * for node-level blocks and does any balancing required based on
+ * the ins_len.
+ *
+ * If no extra work was required, zero is returned.  If we had to
+ * drop the path, -EAGAIN is returned and btrfs_search_slot must
+ * start over
+ */
+static int
+setup_nodes_for_search(struct btrfs_trans_handle *trans,
+		       struct btrfs_root *root, struct btrfs_path *p,
+		       struct extent_buffer *b, int level, int ins_len,
+		       int *write_lock_level)
+{
+	struct btrfs_fs_info *fs_info = root->fs_info;
+	int ret = 0;
+
+	if ((p->search_for_split || ins_len > 0) && btrfs_header_nritems(b) >=
+	    BTRFS_NODEPTRS_PER_BLOCK(fs_info) - 3) {
+
+		if (*write_lock_level < level + 1) {
+			*write_lock_level = level + 1;
+			btrfs_release_path(p);
+			return -EAGAIN;
+		}
+
+		reada_for_balance(p, level);
+		ret = split_node(trans, root, p, level);
+
+		b = p->nodes[level];
+	} else if (ins_len < 0 && btrfs_header_nritems(b) <
+		   BTRFS_NODEPTRS_PER_BLOCK(fs_info) / 2) {
+
+		if (*write_lock_level < level + 1) {
+			*write_lock_level = level + 1;
+			btrfs_release_path(p);
+			return -EAGAIN;
+		}
+
+		reada_for_balance(p, level);
+		ret = balance_level(trans, root, p, level);
+		if (ret)
+			return ret;
+
+		b = p->nodes[level];
+		if (!b) {
+			btrfs_release_path(p);
+			return -EAGAIN;
+		}
+		BUG_ON(btrfs_header_nritems(b) == 1);
+	}
+	return ret;
+}
+
+int btrfs_find_item(struct btrfs_root *fs_root, struct btrfs_path *path,
 		u64 iobjectid, u64 ioff, u8 key_type,
 		struct btrfs_key *found_key)
 {
 	int ret;
 	struct btrfs_key key;
 	struct extent_buffer *eb;
-	struct btrfs_path *path;
+
+	ASSERT(path);
+	ASSERT(found_key);
 
 	key.type = key_type;
 	key.objectid = iobjectid;
 	key.offset = ioff;
 
-	if (found_path == NULL) {
-		path = btrfs_alloc_path();
-		if (!path)
-			return -ENOMEM;
-	} else
-		path = found_path;
-
 	ret = btrfs_search_slot(NULL, fs_root, &key, path, 0, 0);
-	if ((ret < 0) || (found_key == NULL))
-		goto out;
+	if (ret < 0)
+		return ret;
 
 	eb = path->nodes[0];
 	if (ret && path->slots[0] >= btrfs_header_nritems(eb)) {
 		ret = btrfs_next_leaf(fs_root, path);
 		if (ret)
-			goto out;
+			return ret;
 		eb = path->nodes[0];
 	}
 
 	btrfs_item_key_to_cpu(eb, found_key, path->slots[0]);
 	if (found_key->type != key.type ||
-			found_key->objectid != key.objectid) {
-		ret = 1;
+			found_key->objectid != key.objectid)
+		return 1;
+
+	return 0;
+}
+
+static struct extent_buffer *btrfs_search_slot_get_root(struct btrfs_root *root,
+							struct btrfs_path *p,
+							int write_lock_level)
+{
+	struct extent_buffer *b;
+	int root_lock = 0;
+	int level = 0;
+
+	if (p->search_commit_root) {
+		b = root->commit_root;
+		atomic_inc(&b->refs);
+		level = btrfs_header_level(b);
+		/*
+		 * Ensure that all callers have set skip_locking when
+		 * p->search_commit_root = 1.
+		 */
+		ASSERT(p->skip_locking == 1);
+
 		goto out;
 	}
 
+	if (p->skip_locking) {
+		b = btrfs_root_node(root);
+		level = btrfs_header_level(b);
+		goto out;
+	}
+
+	/* We try very hard to do read locks on the root */
+	root_lock = BTRFS_READ_LOCK;
+
+	/*
+	 * If the level is set to maximum, we can skip trying to get the read
+	 * lock.
+	 */
+	if (write_lock_level < BTRFS_MAX_LEVEL) {
+		/*
+		 * We don't know the level of the root node until we actually
+		 * have it read locked
+		 */
+		if (p->nowait) {
+			b = btrfs_try_read_lock_root_node(root);
+			if (IS_ERR(b))
+				return b;
+		} else {
+			b = btrfs_read_lock_root_node(root);
+		}
+		level = btrfs_header_level(b);
+		if (level > write_lock_level)
+			goto out;
+
+		/* Whoops, must trade for write lock */
+		btrfs_tree_read_unlock(b);
+		free_extent_buffer(b);
+	}
+
+	b = btrfs_lock_root_node(root);
+	root_lock = BTRFS_WRITE_LOCK;
+
+	/* The level might have changed, check again */
+	level = btrfs_header_level(b);
+
 out:
-	if (path != found_path)
-		btrfs_free_path(path);
+	/*
+	 * The root may have failed to write out at some point, and thus is no
+	 * longer valid, return an error in this case.
+	 */
+	if (!extent_buffer_uptodate(b)) {
+		if (root_lock)
+			btrfs_tree_unlock_rw(b, root_lock);
+		free_extent_buffer(b);
+		return ERR_PTR(-EIO);
+	}
+
+	p->nodes[level] = b;
+	if (!p->skip_locking)
+		p->locks[level] = root_lock;
+	/*
+	 * Callers are responsible for dropping b's references.
+	 */
+	return b;
+}
+
+/*
+ * Replace the extent buffer at the lowest level of the path with a cloned
+ * version. The purpose is to be able to use it safely, after releasing the
+ * commit root semaphore, even if relocation is happening in parallel, the
+ * transaction used for relocation is committed and the extent buffer is
+ * reallocated in the next transaction.
+ *
+ * This is used in a context where the caller does not prevent transaction
+ * commits from happening, either by holding a transaction handle or holding
+ * some lock, while it's doing searches through a commit root.
+ * At the moment it's only used for send operations.
+ */
+static int finish_need_commit_sem_search(struct btrfs_path *path)
+{
+	const int i = path->lowest_level;
+	const int slot = path->slots[i];
+	struct extent_buffer *lowest = path->nodes[i];
+	struct extent_buffer *clone;
+
+	ASSERT(path->need_commit_sem);
+
+	if (!lowest)
+		return 0;
+
+	lockdep_assert_held_read(&lowest->fs_info->commit_root_sem);
+
+	clone = btrfs_clone_extent_buffer(lowest);
+	if (!clone)
+		return -ENOMEM;
+
+	btrfs_release_path(path);
+	path->nodes[i] = clone;
+	path->slots[i] = slot;
+
+	return 0;
+}
+
+static inline int search_for_key_slot(struct extent_buffer *eb,
+				      int search_low_slot,
+				      const struct btrfs_key *key,
+				      int prev_cmp,
+				      int *slot)
+{
+	/*
+	 * If a previous call to btrfs_bin_search() on a parent node returned an
+	 * exact match (prev_cmp == 0), we can safely assume the target key will
+	 * always be at slot 0 on lower levels, since each key pointer
+	 * (struct btrfs_key_ptr) refers to the lowest key accessible from the
+	 * subtree it points to. Thus we can skip searching lower levels.
+	 */
+	if (prev_cmp == 0) {
+		*slot = 0;
+		return 0;
+	}
+
+	return btrfs_bin_search(eb, search_low_slot, key, slot);
+}
+
+static int search_leaf(struct btrfs_trans_handle *trans,
+		       struct btrfs_root *root,
+		       const struct btrfs_key *key,
+		       struct btrfs_path *path,
+		       int ins_len,
+		       int prev_cmp)
+{
+	struct extent_buffer *leaf = path->nodes[0];
+	int leaf_free_space = -1;
+	int search_low_slot = 0;
+	int ret;
+	bool do_bin_search = true;
+
+	/*
+	 * If we are doing an insertion, the leaf has enough free space and the
+	 * destination slot for the key is not slot 0, then we can unlock our
+	 * write lock on the parent, and any other upper nodes, before doing the
+	 * binary search on the leaf (with search_for_key_slot()), allowing other
+	 * tasks to lock the parent and any other upper nodes.
+	 */
+	if (ins_len > 0) {
+		/*
+		 * Cache the leaf free space, since we will need it later and it
+		 * will not change until then.
+		 */
+		leaf_free_space = btrfs_leaf_free_space(leaf);
+
+		/*
+		 * !path->locks[1] means we have a single node tree, the leaf is
+		 * the root of the tree.
+		 */
+		if (path->locks[1] && leaf_free_space >= ins_len) {
+			struct btrfs_disk_key first_key;
+
+			ASSERT(btrfs_header_nritems(leaf) > 0);
+			btrfs_item_key(leaf, &first_key, 0);
+
+			/*
+			 * Doing the extra comparison with the first key is cheap,
+			 * taking into account that the first key is very likely
+			 * already in a cache line because it immediately follows
+			 * the extent buffer's header and we have recently accessed
+			 * the header's level field.
+			 */
+			ret = comp_keys(&first_key, key);
+			if (ret < 0) {
+				/*
+				 * The first key is smaller than the key we want
+				 * to insert, so we are safe to unlock all upper
+				 * nodes and we have to do the binary search.
+				 *
+				 * We do use btrfs_unlock_up_safe() and not
+				 * unlock_up() because the later does not unlock
+				 * nodes with a slot of 0 - we can safely unlock
+				 * any node even if its slot is 0 since in this
+				 * case the key does not end up at slot 0 of the
+				 * leaf and there's no need to split the leaf.
+				 */
+				btrfs_unlock_up_safe(path, 1);
+				search_low_slot = 1;
+			} else {
+				/*
+				 * The first key is >= then the key we want to
+				 * insert, so we can skip the binary search as
+				 * the target key will be at slot 0.
+				 *
+				 * We can not unlock upper nodes when the key is
+				 * less than the first key, because we will need
+				 * to update the key at slot 0 of the parent node
+				 * and possibly of other upper nodes too.
+				 * If the key matches the first key, then we can
+				 * unlock all the upper nodes, using
+				 * btrfs_unlock_up_safe() instead of unlock_up()
+				 * as stated above.
+				 */
+				if (ret == 0)
+					btrfs_unlock_up_safe(path, 1);
+				/*
+				 * ret is already 0 or 1, matching the result of
+				 * a btrfs_bin_search() call, so there is no need
+				 * to adjust it.
+				 */
+				do_bin_search = false;
+				path->slots[0] = 0;
+			}
+		}
+	}
+
+	if (do_bin_search) {
+		ret = search_for_key_slot(leaf, search_low_slot, key,
+					  prev_cmp, &path->slots[0]);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (ins_len > 0) {
+		/*
+		 * Item key already exists. In this case, if we are allowed to
+		 * insert the item (for example, in dir_item case, item key
+		 * collision is allowed), it will be merged with the original
+		 * item. Only the item size grows, no new btrfs item will be
+		 * added. If search_for_extension is not set, ins_len already
+		 * accounts the size btrfs_item, deduct it here so leaf space
+		 * check will be correct.
+		 */
+		if (ret == 0 && !path->search_for_extension) {
+			ASSERT(ins_len >= sizeof(struct btrfs_item));
+			ins_len -= sizeof(struct btrfs_item);
+		}
+
+		ASSERT(leaf_free_space >= 0);
+
+		if (leaf_free_space < ins_len) {
+			int err;
+
+			err = split_leaf(trans, root, key, path, ins_len,
+					 (ret == 0));
+			ASSERT(err <= 0);
+			if (WARN_ON(err > 0))
+				err = -EUCLEAN;
+			if (err)
+				ret = err;
+		}
+	}
+
 	return ret;
 }
 
 /*
- * look for key in the tree.  path is filled in with nodes along the way
- * if key is found, we return zero and you can find the item in the leaf
- * level of the path (level 0)
+ * btrfs_search_slot - look for a key in a tree and perform necessary
+ * modifications to preserve tree invariants.
  *
- * If the key isn't found, the path points to the slot where it should
- * be inserted, and 1 is returned.  If there are other errors during the
- * search a negative error number is returned.
+ * @trans:	Handle of transaction, used when modifying the tree
+ * @p:		Holds all btree nodes along the search path
+ * @root:	The root node of the tree
+ * @key:	The key we are looking for
+ * @ins_len:	Indicates purpose of search:
+ *              >0  for inserts it's size of item inserted (*)
+ *              <0  for deletions
+ *               0  for plain searches, not modifying the tree
  *
- * if ins_len > 0, nodes and leaves will be split as we walk down the
- * tree.  if ins_len < 0, nodes will be merged as we walk down the tree (if
- * possible)
+ *              (*) If size of item inserted doesn't include
+ *              sizeof(struct btrfs_item), then p->search_for_extension must
+ *              be set.
+ * @cow:	boolean should CoW operations be performed. Must always be 1
+ *		when modifying the tree.
+ *
+ * If @ins_len > 0, nodes and leaves will be split as we walk down the tree.
+ * If @ins_len < 0, nodes will be merged as we walk down the tree (if possible)
+ *
+ * If @key is found, 0 is returned and you can find the item in the leaf level
+ * of the path (level 0)
+ *
+ * If @key isn't found, 1 is returned and the leaf level of the path (level 0)
+ * points to the slot where it should be inserted
+ *
+ * If an error is encountered while searching the tree a negative error number
+ * is returned
  */
-int btrfs_search_slot(struct btrfs_trans_handle *trans,
-		struct btrfs_root *root, const struct btrfs_key *key,
-		struct btrfs_path *p, int ins_len, int cow)
+int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
+		      const struct btrfs_key *key, struct btrfs_path *p,
+		      int ins_len, int cow)
 {
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct extent_buffer *b;
 	int slot;
 	int ret;
+	int err;
 	int level;
-	int should_reada = p->reada;
-	struct btrfs_fs_info *fs_info = root->fs_info;
+	int lowest_unlock = 1;
+	/* everything at write_lock_level or lower must be write locked */
+	int write_lock_level = 0;
 	u8 lowest_level = 0;
+	int min_write_lock_level;
+	int prev_cmp;
+
+	might_sleep();
 
 	lowest_level = p->lowest_level;
 	WARN_ON(lowest_level && ins_len > 0);
 	WARN_ON(p->nodes[0] != NULL);
-again:
-	b = root->node;
-	extent_buffer_get(b);
-	while (b) {
-		level = btrfs_header_level(b);
-		if (cow) {
-			int wret;
-			wret = btrfs_cow_block(trans, root, b,
-					       p->nodes[level + 1],
-					       p->slots[level + 1],
-					       &b, BTRFS_NESTING_NORMAL);
-			if (wret) {
-				free_extent_buffer(b);
-				return wret;
-			}
-		}
-		BUG_ON(!cow && ins_len);
-		if (level != btrfs_header_level(b))
-			WARN_ON(1);
-		level = btrfs_header_level(b);
-		p->nodes[level] = b;
-		ret = check_block(fs_info, p, level);
-		if (ret)
-			return -1;
-		ret = btrfs_bin_search(b, 0, key, &slot);
-		if (level != 0) {
-			if (ret && slot > 0)
-				slot -= 1;
-			p->slots[level] = slot;
-			if ((p->search_for_split || ins_len > 0) &&
-			    btrfs_header_nritems(b) >=
-			    BTRFS_NODEPTRS_PER_BLOCK(fs_info) - 3) {
-				int sret = split_node(trans, root, p, level);
-				BUG_ON(sret > 0);
-				if (sret)
-					return sret;
-				b = p->nodes[level];
-				slot = p->slots[level];
-			} else if (ins_len < 0) {
-				int sret = balance_level(trans, root, p,
-							 level);
-				if (sret)
-					return sret;
-				b = p->nodes[level];
-				if (!b) {
-					btrfs_release_path(p);
-					goto again;
-				}
-				slot = p->slots[level];
-				BUG_ON(btrfs_header_nritems(b) == 1);
-			}
-			/* this is only true while dropping a snapshot */
-			if (level == lowest_level)
-				break;
+	BUG_ON(!cow && ins_len);
 
-			if (should_reada)
-				reada_for_search(fs_info, p, level, slot,
-						 key->objectid);
+	/*
+	 * For now only allow nowait for read only operations.  There's no
+	 * strict reason why we can't, we just only need it for reads so it's
+	 * only implemented for reads.
+	 */
+	ASSERT(!p->nowait || !cow);
 
-			b = btrfs_read_node_slot(b, slot);
-			if (!extent_buffer_uptodate(b))
-				return -EIO;
+	if (ins_len < 0) {
+		lowest_unlock = 2;
+
+		/* when we are removing items, we might have to go up to level
+		 * two as we update tree pointers  Make sure we keep write
+		 * for those levels as well
+		 */
+		write_lock_level = 2;
+	} else if (ins_len > 0) {
+		/*
+		 * for inserting items, make sure we have a write lock on
+		 * level 1 so we can update keys
+		 */
+		write_lock_level = 1;
+	}
+
+	if (!cow)
+		write_lock_level = -1;
+
+	if (cow && (p->keep_locks || p->lowest_level))
+		write_lock_level = BTRFS_MAX_LEVEL;
+
+	min_write_lock_level = write_lock_level;
+
+	if (p->need_commit_sem) {
+		ASSERT(p->search_commit_root);
+		if (p->nowait) {
+			if (!down_read_trylock(&fs_info->commit_root_sem))
+				return -EAGAIN;
 		} else {
-			p->slots[level] = slot;
-			if (ins_len > 0 &&
-			    ins_len > btrfs_leaf_free_space(b)) {
-				int sret = split_leaf(trans, root, key,
-						      p, ins_len, ret == 0);
-				BUG_ON(sret > 0);
-				if (sret)
-					return sret;
-			}
-			return ret;
+			down_read(&fs_info->commit_root_sem);
 		}
 	}
+
+again:
+	prev_cmp = -1;
+	b = btrfs_search_slot_get_root(root, p, write_lock_level);
+	if (IS_ERR(b)) {
+		ret = PTR_ERR(b);
+		goto done;
+	}
+
+	while (b) {
+		int dec = 0;
+
+		level = btrfs_header_level(b);
+
+		if (cow) {
+			bool last_level = (level == (BTRFS_MAX_LEVEL - 1));
+
+			/*
+			 * if we don't really need to cow this block
+			 * then we don't want to set the path blocking,
+			 * so we test it here
+			 */
+			if (!should_cow_block(trans, root, b))
+				goto cow_done;
+
+			/*
+			 * must have write locks on this node and the
+			 * parent
+			 */
+			if (level > write_lock_level ||
+			    (level + 1 > write_lock_level &&
+			    level + 1 < BTRFS_MAX_LEVEL &&
+			    p->nodes[level + 1])) {
+				write_lock_level = level + 1;
+				btrfs_release_path(p);
+				goto again;
+			}
+
+			if (last_level)
+				err = btrfs_cow_block(trans, root, b, NULL, 0,
+						      &b,
+						      BTRFS_NESTING_COW);
+			else
+				err = btrfs_cow_block(trans, root, b,
+						      p->nodes[level + 1],
+						      p->slots[level + 1], &b,
+						      BTRFS_NESTING_COW);
+			if (err) {
+				ret = err;
+				goto done;
+			}
+		}
+cow_done:
+		p->nodes[level] = b;
+
+		/*
+		 * we have a lock on b and as long as we aren't changing
+		 * the tree, there is no way to for the items in b to change.
+		 * It is safe to drop the lock on our parent before we
+		 * go through the expensive btree search on b.
+		 *
+		 * If we're inserting or deleting (ins_len != 0), then we might
+		 * be changing slot zero, which may require changing the parent.
+		 * So, we can't drop the lock until after we know which slot
+		 * we're operating on.
+		 */
+		if (!ins_len && !p->keep_locks) {
+			int u = level + 1;
+
+			if (u < BTRFS_MAX_LEVEL && p->locks[u]) {
+				btrfs_tree_unlock_rw(p->nodes[u], p->locks[u]);
+				p->locks[u] = 0;
+			}
+		}
+
+		if (level == 0) {
+			if (ins_len > 0)
+				ASSERT(write_lock_level >= 1);
+
+			ret = search_leaf(trans, root, key, p, ins_len, prev_cmp);
+			if (!p->search_for_split)
+				unlock_up(p, level, lowest_unlock,
+					  min_write_lock_level, NULL);
+			goto done;
+		}
+
+		ret = search_for_key_slot(b, 0, key, prev_cmp, &slot);
+		if (ret < 0)
+			goto done;
+		prev_cmp = ret;
+
+		if (ret && slot > 0) {
+			dec = 1;
+			slot--;
+		}
+		p->slots[level] = slot;
+		err = setup_nodes_for_search(trans, root, p, b, level, ins_len,
+					     &write_lock_level);
+		if (err == -EAGAIN)
+			goto again;
+		if (err) {
+			ret = err;
+			goto done;
+		}
+		b = p->nodes[level];
+		slot = p->slots[level];
+
+		/*
+		 * Slot 0 is special, if we change the key we have to update
+		 * the parent pointer which means we must have a write lock on
+		 * the parent
+		 */
+		if (slot == 0 && ins_len && write_lock_level < level + 1) {
+			write_lock_level = level + 1;
+			btrfs_release_path(p);
+			goto again;
+		}
+
+		unlock_up(p, level, lowest_unlock, min_write_lock_level,
+			  &write_lock_level);
+
+		if (level == lowest_level) {
+			if (dec)
+				p->slots[level]++;
+			goto done;
+		}
+
+		err = read_block_for_search(root, p, &b, level, slot, key);
+		if (err == -EAGAIN)
+			goto again;
+		if (err) {
+			ret = err;
+			goto done;
+		}
+
+		if (!p->skip_locking) {
+			level = btrfs_header_level(b);
+
+			btrfs_maybe_reset_lockdep_class(root, b);
+
+			if (level <= write_lock_level) {
+				btrfs_tree_lock(b);
+				p->locks[level] = BTRFS_WRITE_LOCK;
+			} else {
+				if (p->nowait) {
+					if (!btrfs_try_tree_read_lock(b)) {
+						free_extent_buffer(b);
+						ret = -EAGAIN;
+						goto done;
+					}
+				} else {
+					btrfs_tree_read_lock(b);
+				}
+				p->locks[level] = BTRFS_READ_LOCK;
+			}
+			p->nodes[level] = b;
+		}
+	}
+	ret = 1;
+done:
+	if (ret < 0 && !p->skip_release_on_error)
+		btrfs_release_path(p);
+
+	if (p->need_commit_sem) {
+		int ret2;
+
+		ret2 = finish_need_commit_sem_search(p);
+		up_read(&fs_info->commit_root_sem);
+		if (ret2)
+			ret = ret2;
+	}
+
+	return ret;
+}
+ALLOW_ERROR_INJECTION(btrfs_search_slot, ERRNO);
+
+/*
+ * Like btrfs_search_slot, this looks for a key in the given tree. It uses the
+ * current state of the tree together with the operations recorded in the tree
+ * modification log to search for the key in a previous version of this tree, as
+ * denoted by the time_seq parameter.
+ *
+ * Naturally, there is no support for insert, delete or cow operations.
+ *
+ * The resulting path and return value will be set up as if we called
+ * btrfs_search_slot at that point in time with ins_len and cow both set to 0.
+ */
+int btrfs_search_old_slot(struct btrfs_root *root, const struct btrfs_key *key,
+			  struct btrfs_path *p, u64 time_seq)
+{
+	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct extent_buffer *b;
+	int slot;
+	int ret;
+	int err;
+	int level;
+	int lowest_unlock = 1;
+	u8 lowest_level = 0;
+
+	lowest_level = p->lowest_level;
+	WARN_ON(p->nodes[0] != NULL);
+	ASSERT(!p->nowait);
+
+	if (p->search_commit_root) {
+		BUG_ON(time_seq);
+		return btrfs_search_slot(NULL, root, key, p, 0, 0);
+	}
+
+again:
+	b = btrfs_get_old_root(root, time_seq);
+	if (!b) {
+		ret = -EIO;
+		goto done;
+	}
+	level = btrfs_header_level(b);
+	p->locks[level] = BTRFS_READ_LOCK;
+
+	while (b) {
+		int dec = 0;
+
+		level = btrfs_header_level(b);
+		p->nodes[level] = b;
+
+		/*
+		 * we have a lock on b and as long as we aren't changing
+		 * the tree, there is no way to for the items in b to change.
+		 * It is safe to drop the lock on our parent before we
+		 * go through the expensive btree search on b.
+		 */
+		btrfs_unlock_up_safe(p, level + 1);
+
+		ret = btrfs_bin_search(b, 0, key, &slot);
+		if (ret < 0)
+			goto done;
+
+		if (level == 0) {
+			p->slots[level] = slot;
+			unlock_up(p, level, lowest_unlock, 0, NULL);
+			goto done;
+		}
+
+		if (ret && slot > 0) {
+			dec = 1;
+			slot--;
+		}
+		p->slots[level] = slot;
+		unlock_up(p, level, lowest_unlock, 0, NULL);
+
+		if (level == lowest_level) {
+			if (dec)
+				p->slots[level]++;
+			goto done;
+		}
+
+		err = read_block_for_search(root, p, &b, level, slot, key);
+		if (err == -EAGAIN)
+			goto again;
+		if (err) {
+			ret = err;
+			goto done;
+		}
+
+		level = btrfs_header_level(b);
+		btrfs_tree_read_lock(b);
+		b = btrfs_tree_mod_log_rewind(fs_info, p, b, time_seq);
+		if (!b) {
+			ret = -ENOMEM;
+			goto done;
+		}
+		p->locks[level] = BTRFS_READ_LOCK;
+		p->nodes[level] = b;
+	}
+	ret = 1;
+done:
+	if (ret < 0)
+		btrfs_release_path(p);
+
+	return ret;
+}
+
+/*
+ * Search the tree again to find a leaf with smaller keys.
+ * Returns 0 if it found something.
+ * Returns 1 if there are no smaller keys.
+ * Returns < 0 on error.
+ *
+ * This may release the path, and so you may lose any locks held at the
+ * time you call it.
+ *
+ * This is exported for use inside btrfs-progs, don't un-export it.
+ */
+int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *path)
+{
+	struct btrfs_key key;
+	struct btrfs_key orig_key;
+	struct btrfs_disk_key found_key;
+	int ret;
+
+	btrfs_item_key_to_cpu(path->nodes[0], &key, 0);
+	orig_key = key;
+
+	if (key.offset > 0) {
+		key.offset--;
+	} else if (key.type > 0) {
+		key.type--;
+		key.offset = (u64)-1;
+	} else if (key.objectid > 0) {
+		key.objectid--;
+		key.type = (u8)-1;
+		key.offset = (u64)-1;
+	} else {
+		return 1;
+	}
+
+	btrfs_release_path(path);
+	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+	if (ret <= 0)
+		return ret;
+
+	/*
+	 * Previous key not found. Even if we were at slot 0 of the leaf we had
+	 * before releasing the path and calling btrfs_search_slot(), we now may
+	 * be in a slot pointing to the same original key - this can happen if
+	 * after we released the path, one of more items were moved from a
+	 * sibling leaf into the front of the leaf we had due to an insertion
+	 * (see push_leaf_right()).
+	 * If we hit this case and our slot is > 0 and just decrement the slot
+	 * so that the caller does not process the same key again, which may or
+	 * may not break the caller, depending on its logic.
+	 */
+	if (path->slots[0] < btrfs_header_nritems(path->nodes[0])) {
+		btrfs_item_key(path->nodes[0], &found_key, path->slots[0]);
+		ret = comp_keys(&found_key, &orig_key);
+		if (ret == 0) {
+			if (path->slots[0] > 0) {
+				path->slots[0]--;
+				return 0;
+			}
+			/*
+			 * At slot 0, same key as before, it means orig_key is
+			 * the lowest, leftmost, key in the tree. We're done.
+			 */
+			return 1;
+		}
+	}
+
+	btrfs_item_key(path->nodes[0], &found_key, 0);
+	ret = comp_keys(&found_key, &key);
+	/*
+	 * We might have had an item with the previous key in the tree right
+	 * before we released our path. And after we released our path, that
+	 * item might have been pushed to the first slot (0) of the leaf we
+	 * were holding due to a tree balance. Alternatively, an item with the
+	 * previous key can exist as the only element of a leaf (big fat item).
+	 * Therefore account for these 2 cases, so that our callers (like
+	 * btrfs_previous_item) don't miss an existing item with a key matching
+	 * the previous key we computed above.
+	 */
+	if (ret <= 0)
+		return 0;
 	return 1;
 }
 
 /*
- * Helper to use instead of search slot if no exact match is needed but
+ * helper to use instead of search slot if no exact match is needed but
  * instead the next or previous item should be returned.
  * When find_higher is true, the next higher item is returned, the next lower
  * otherwise.
@@ -1288,65 +2519,115 @@ again:
  * < 0 on error
  */
 int btrfs_search_slot_for_read(struct btrfs_root *root,
-                               const struct btrfs_key *key,
-                               struct btrfs_path *p, int find_higher,
-                               int return_any)
+			       const struct btrfs_key *key,
+			       struct btrfs_path *p, int find_higher,
+			       int return_any)
 {
-        int ret;
-        struct extent_buffer *leaf;
+	int ret;
+	struct extent_buffer *leaf;
 
 again:
-        ret = btrfs_search_slot(NULL, root, key, p, 0, 0);
-        if (ret <= 0)
-                return ret;
-        /*
-	 * A return value of 1 means the path is at the position where the item
-	 * should be inserted. Normally this is the next bigger item, but in
-	 * case the previous item is the last in a leaf, path points to the
-	 * first free slot in the previous leaf, i.e. at an invalid item.
-         */
-        leaf = p->nodes[0];
+	ret = btrfs_search_slot(NULL, root, key, p, 0, 0);
+	if (ret <= 0)
+		return ret;
+	/*
+	 * a return value of 1 means the path is at the position where the
+	 * item should be inserted. Normally this is the next bigger item,
+	 * but in case the previous item is the last in a leaf, path points
+	 * to the first free slot in the previous leaf, i.e. at an invalid
+	 * item.
+	 */
+	leaf = p->nodes[0];
 
-        if (find_higher) {
-                if (p->slots[0] >= btrfs_header_nritems(leaf)) {
-                        ret = btrfs_next_leaf(root, p);
-                        if (ret <= 0)
-                                return ret;
-                        if (!return_any)
-                                return 1;
-                        /*
-			 * No higher item found, return the next lower instead
-                         */
-                        return_any = 0;
-                        find_higher = 0;
-                        btrfs_release_path(p);
-                        goto again;
-                }
-        } else {
-                if (p->slots[0] == 0) {
-                        ret = btrfs_prev_leaf(root, p);
-                        if (ret < 0)
-                                return ret;
-                        if (!ret) {
-                                leaf = p->nodes[0];
-                                if (p->slots[0] == btrfs_header_nritems(leaf))
-                                        p->slots[0]--;
-                                return 0;
-                        }
-                        if (!return_any)
-                                return 1;
-                        /*
-			 * No lower item found, return the next higher instead
-                         */
-                        return_any = 0;
-                        find_higher = 1;
-                        btrfs_release_path(p);
-                        goto again;
-                } else {
-                        --p->slots[0];
-                }
-        }
-        return 0;
+	if (find_higher) {
+		if (p->slots[0] >= btrfs_header_nritems(leaf)) {
+			ret = btrfs_next_leaf(root, p);
+			if (ret <= 0)
+				return ret;
+			if (!return_any)
+				return 1;
+			/*
+			 * no higher item found, return the next
+			 * lower instead
+			 */
+			return_any = 0;
+			find_higher = 0;
+			btrfs_release_path(p);
+			goto again;
+		}
+	} else {
+		if (p->slots[0] == 0) {
+			ret = btrfs_prev_leaf(root, p);
+			if (ret < 0)
+				return ret;
+			if (!ret) {
+				leaf = p->nodes[0];
+				if (p->slots[0] == btrfs_header_nritems(leaf))
+					p->slots[0]--;
+				return 0;
+			}
+			if (!return_any)
+				return 1;
+			/*
+			 * no lower item found, return the next
+			 * higher instead
+			 */
+			return_any = 0;
+			find_higher = 1;
+			btrfs_release_path(p);
+			goto again;
+		} else {
+			--p->slots[0];
+		}
+	}
+	return 0;
+}
+
+/*
+ * Execute search and call btrfs_previous_item to traverse backwards if the item
+ * was not found.
+ *
+ * Return 0 if found, 1 if not found and < 0 if error.
+ */
+int btrfs_search_backwards(struct btrfs_root *root, struct btrfs_key *key,
+			   struct btrfs_path *path)
+{
+	int ret;
+
+	ret = btrfs_search_slot(NULL, root, key, path, 0, 0);
+	if (ret > 0)
+		ret = btrfs_previous_item(root, path, key->objectid, key->type);
+
+	if (ret == 0)
+		btrfs_item_key_to_cpu(path->nodes[0], key, path->slots[0]);
+
+	return ret;
+}
+
+/*
+ * Search for a valid slot for the given path.
+ *
+ * @root:	The root node of the tree.
+ * @key:	Will contain a valid item if found.
+ * @path:	The starting point to validate the slot.
+ *
+ * Return: 0  if the item is valid
+ *         1  if not found
+ *         <0 if error.
+ */
+int btrfs_get_next_valid_item(struct btrfs_root *root, struct btrfs_key *key,
+			      struct btrfs_path *path)
+{
+	if (path->slots[0] >= btrfs_header_nritems(path->nodes[0])) {
+		int ret;
+
+		ret = btrfs_next_leaf(root, path);
+		if (ret)
+			return ret;
+	}
+
+	btrfs_item_key_to_cpu(path->nodes[0], key, path->slots[0]);
+	return 0;
 }
 
 /*
@@ -1355,18 +2636,24 @@ again:
  * This is used after shifting pointers to the left, so it stops
  * fixing up pointers when a given leaf/node is not in slot 0 of the
  * higher levels
+ *
  */
-static void fixup_low_keys(struct btrfs_path *path, struct btrfs_disk_key *key,
-			   int level)
+static void fixup_low_keys(struct btrfs_path *path,
+			   struct btrfs_disk_key *key, int level)
 {
 	int i;
 	struct extent_buffer *t;
+	int ret;
 
 	for (i = level; i < BTRFS_MAX_LEVEL; i++) {
 		int tslot = path->slots[i];
+
 		if (!path->nodes[i])
 			break;
 		t = path->nodes[i];
+		ret = btrfs_tree_mod_log_insert_key(t, tslot,
+						    BTRFS_MOD_LOG_KEY_REPLACE);
+		BUG_ON(ret < 0);
 		btrfs_set_node_key(t, key, tslot);
 		btrfs_mark_buffer_dirty(path->nodes[i]);
 		if (tslot != 0)
@@ -1392,11 +2679,31 @@ void btrfs_set_item_key_safe(struct btrfs_fs_info *fs_info,
 	slot = path->slots[0];
 	if (slot > 0) {
 		btrfs_item_key(eb, &disk_key, slot - 1);
-		BUG_ON(btrfs_comp_keys(&disk_key, new_key) >= 0);
+		if (unlikely(comp_keys(&disk_key, new_key) >= 0)) {
+			btrfs_print_leaf(eb);
+			btrfs_crit(fs_info,
+		"slot %u key (%llu %u %llu) new key (%llu %u %llu)",
+				   slot, btrfs_disk_key_objectid(&disk_key),
+				   btrfs_disk_key_type(&disk_key),
+				   btrfs_disk_key_offset(&disk_key),
+				   new_key->objectid, new_key->type,
+				   new_key->offset);
+			BUG();
+		}
 	}
 	if (slot < btrfs_header_nritems(eb) - 1) {
 		btrfs_item_key(eb, &disk_key, slot + 1);
-		BUG_ON(btrfs_comp_keys(&disk_key, new_key) <= 0);
+		if (unlikely(comp_keys(&disk_key, new_key) <= 0)) {
+			btrfs_print_leaf(eb);
+			btrfs_crit(fs_info,
+		"slot %u key (%llu %u %llu) new key (%llu %u %llu)",
+				   slot, btrfs_disk_key_objectid(&disk_key),
+				   btrfs_disk_key_type(&disk_key),
+				   btrfs_disk_key_offset(&disk_key),
+				   new_key->objectid, new_key->type,
+				   new_key->offset);
+			BUG();
+		}
 	}
 
 	btrfs_cpu_key_to_disk(&disk_key, new_key);
@@ -1406,6 +2713,62 @@ void btrfs_set_item_key_safe(struct btrfs_fs_info *fs_info,
 		fixup_low_keys(path, &disk_key, 1);
 }
 
+/*
+ * Check key order of two sibling extent buffers.
+ *
+ * Return true if something is wrong.
+ * Return false if everything is fine.
+ *
+ * Tree-checker only works inside one tree block, thus the following
+ * corruption can not be detected by tree-checker:
+ *
+ * Leaf @left			| Leaf @right
+ * --------------------------------------------------------------
+ * | 1 | 2 | 3 | 4 | 5 | f6 |   | 7 | 8 |
+ *
+ * Key f6 in leaf @left itself is valid, but not valid when the next
+ * key in leaf @right is 7.
+ * This can only be checked at tree block merge time.
+ * And since tree checker has ensured all key order in each tree block
+ * is correct, we only need to bother the last key of @left and the first
+ * key of @right.
+ */
+static bool check_sibling_keys(struct extent_buffer *left,
+			       struct extent_buffer *right)
+{
+	struct btrfs_key left_last;
+	struct btrfs_key right_first;
+	int level = btrfs_header_level(left);
+	int nr_left = btrfs_header_nritems(left);
+	int nr_right = btrfs_header_nritems(right);
+
+	/* No key to check in one of the tree blocks */
+	if (!nr_left || !nr_right)
+		return false;
+
+	if (level) {
+		btrfs_node_key_to_cpu(left, &left_last, nr_left - 1);
+		btrfs_node_key_to_cpu(right, &right_first, 0);
+	} else {
+		btrfs_item_key_to_cpu(left, &left_last, nr_left - 1);
+		btrfs_item_key_to_cpu(right, &right_first, 0);
+	}
+
+	if (unlikely(btrfs_comp_cpu_keys(&left_last, &right_first) >= 0)) {
+		btrfs_crit(left->fs_info, "left extent buffer:");
+		btrfs_print_tree(left, false);
+		btrfs_crit(left->fs_info, "right extent buffer:");
+		btrfs_print_tree(right, false);
+		btrfs_crit(left->fs_info,
+"bad key order, sibling blocks, left last (%llu %u %llu) right first (%llu %u %llu)",
+			   left_last.objectid, left_last.type,
+			   left_last.offset, right_first.objectid,
+			   right_first.type, right_first.offset);
+		return true;
+	}
+	return false;
+}
+
 /*
  * try to push data from one node into the next node left in the
  * tree.
@@ -1432,9 +2795,8 @@ static int push_node_left(struct btrfs_trans_handle *trans,
 	if (!empty && src_nritems <= 8)
 		return 1;
 
-	if (push_items <= 0) {
+	if (push_items <= 0)
 		return 1;
-	}
 
 	if (empty) {
 		push_items = min(src_nritems, push_items);
@@ -1451,12 +2813,27 @@ static int push_node_left(struct btrfs_trans_handle *trans,
 	} else
 		push_items = min(src_nritems - 8, push_items);
 
+	/* dst is the left eb, src is the middle eb */
+	if (check_sibling_keys(dst, src)) {
+		ret = -EUCLEAN;
+		btrfs_abort_transaction(trans, ret);
+		return ret;
+	}
+	ret = btrfs_tree_mod_log_eb_copy(dst, src, dst_nritems, 0, push_items);
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		return ret;
+	}
 	copy_extent_buffer(dst, src,
 			   btrfs_node_key_ptr_offset(dst, dst_nritems),
 			   btrfs_node_key_ptr_offset(src, 0),
-		           push_items * sizeof(struct btrfs_key_ptr));
+			   push_items * sizeof(struct btrfs_key_ptr));
 
 	if (push_items < src_nritems) {
+		/*
+		 * btrfs_tree_mod_log_eb_copy handles logging the move, so we
+		 * don't need to do an explicit tree mod log operation for it.
+		 */
 		memmove_extent_buffer(src, btrfs_node_key_ptr_offset(src, 0),
 				      btrfs_node_key_ptr_offset(src, push_items),
 				      (src_nritems - push_items) *
@@ -1496,32 +2873,46 @@ static int balance_node_right(struct btrfs_trans_handle *trans,
 	src_nritems = btrfs_header_nritems(src);
 	dst_nritems = btrfs_header_nritems(dst);
 	push_items = BTRFS_NODEPTRS_PER_BLOCK(fs_info) - dst_nritems;
-	if (push_items <= 0) {
+	if (push_items <= 0)
 		return 1;
-	}
 
-	if (src_nritems < 4) {
+	if (src_nritems < 4)
 		return 1;
-	}
 
 	max_push = src_nritems / 2 + 1;
 	/* don't try to empty the node */
-	if (max_push >= src_nritems) {
+	if (max_push >= src_nritems)
 		return 1;
-	}
 
 	if (max_push < push_items)
 		push_items = max_push;
 
+	/* dst is the right eb, src is the middle eb */
+	if (check_sibling_keys(src, dst)) {
+		ret = -EUCLEAN;
+		btrfs_abort_transaction(trans, ret);
+		return ret;
+	}
+
+	/*
+	 * btrfs_tree_mod_log_eb_copy handles logging the move, so we don't
+	 * need to do an explicit tree mod log operation for it.
+	 */
 	memmove_extent_buffer(dst, btrfs_node_key_ptr_offset(dst, push_items),
 				      btrfs_node_key_ptr_offset(dst, 0),
 				      (dst_nritems) *
 				      sizeof(struct btrfs_key_ptr));
 
+	ret = btrfs_tree_mod_log_eb_copy(dst, src, 0, src_nritems - push_items,
+					 push_items);
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		return ret;
+	}
 	copy_extent_buffer(dst, src,
 			   btrfs_node_key_ptr_offset(dst, 0),
 			   btrfs_node_key_ptr_offset(src, src_nritems - push_items),
-		           push_items * sizeof(struct btrfs_key_ptr));
+			   push_items * sizeof(struct btrfs_key_ptr));
 
 	btrfs_set_header_nritems(src, src_nritems - push_items);
 	btrfs_set_header_nritems(dst, dst_nritems + push_items);
@@ -1539,15 +2930,17 @@ static int balance_node_right(struct btrfs_trans_handle *trans,
  *
  * returns zero on success or < 0 on failure.
  */
-static int noinline insert_new_root(struct btrfs_trans_handle *trans,
+static noinline int insert_new_root(struct btrfs_trans_handle *trans,
 			   struct btrfs_root *root,
 			   struct btrfs_path *path, int level)
 {
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	u64 lower_gen;
 	struct extent_buffer *lower;
 	struct extent_buffer *c;
 	struct extent_buffer *old;
 	struct btrfs_disk_key lower_key;
+	int ret;
 
 	BUG_ON(path->nodes[level]);
 	BUG_ON(path->nodes[level-1] != root->node);
@@ -1560,23 +2953,13 @@ static int noinline insert_new_root(struct btrfs_trans_handle *trans,
 
 	c = btrfs_alloc_tree_block(trans, root, 0, root->root_key.objectid,
 				   &lower_key, level, root->node->start, 0,
-				   BTRFS_NESTING_NORMAL);
-
+				   BTRFS_NESTING_NEW_ROOT);
 	if (IS_ERR(c))
 		return PTR_ERR(c);
 
-	memset_extent_buffer(c, 0, 0, sizeof(struct btrfs_header));
+	root_add_used(root, fs_info->nodesize);
+
 	btrfs_set_header_nritems(c, 1);
-	btrfs_set_header_level(c, level);
-	btrfs_set_header_bytenr(c, c->start);
-	btrfs_set_header_generation(c, trans->transid);
-	btrfs_set_header_backref_rev(c, BTRFS_MIXED_BACKREF_REV);
-	btrfs_set_header_owner(c, root->root_key.objectid);
-
-	root_add_used(root, root->fs_info->nodesize);
-
-	write_extent_buffer_fsid(c, root->fs_info->fs_devices->metadata_uuid);
-	write_extent_buffer_chunk_tree_uuid(c, root->fs_info->chunk_tree_uuid);
 	btrfs_set_node_key(c, &lower_key, 0);
 	btrfs_set_node_blockptr(c, 0, lower->start);
 	lower_gen = btrfs_header_generation(lower);
@@ -1587,14 +2970,22 @@ static int noinline insert_new_root(struct btrfs_trans_handle *trans,
 	btrfs_mark_buffer_dirty(c);
 
 	old = root->node;
-	root->node = c;
+	ret = btrfs_tree_mod_log_insert_root(root->node, c, false);
+	if (ret < 0) {
+		btrfs_free_tree_block(trans, btrfs_root_id(root), c, 0, 1);
+		btrfs_tree_unlock(c);
+		free_extent_buffer(c);
+		return ret;
+	}
+	rcu_assign_pointer(root->node, c);
 
 	/* the super has an extra ref to root->node */
 	free_extent_buffer(old);
 
 	add_root_to_dirty_list(root);
-	extent_buffer_get(c);
+	atomic_inc(&c->refs);
 	path->nodes[level] = c;
+	path->locks[level] = BTRFS_WRITE_LOCK;
 	path->slots[level] = 0;
 	return 0;
 }
@@ -1605,36 +2996,51 @@ static int noinline insert_new_root(struct btrfs_trans_handle *trans,
  *
  * slot and level indicate where you want the key to go, and
  * blocknr is the block the key points to.
- *
- * returns zero on success and < 0 on any error
  */
-static int insert_ptr(struct btrfs_trans_handle *trans, struct btrfs_root
-		      *root, struct btrfs_path *path, struct btrfs_disk_key
-		      *key, u64 bytenr, int slot, int level)
+static int insert_ptr(struct btrfs_trans_handle *trans,
+		      struct btrfs_path *path,
+		      struct btrfs_disk_key *key, u64 bytenr,
+		      int slot, int level)
 {
 	struct extent_buffer *lower;
 	int nritems;
+	int ret;
 
 	BUG_ON(!path->nodes[level]);
+	btrfs_assert_tree_write_locked(path->nodes[level]);
 	lower = path->nodes[level];
 	nritems = btrfs_header_nritems(lower);
-	if (slot > nritems)
-		BUG();
-	if (nritems == BTRFS_NODEPTRS_PER_BLOCK(root->fs_info))
-		BUG();
-	if (slot < nritems) {
-		/* shift the items */
+	BUG_ON(slot > nritems);
+	BUG_ON(nritems == BTRFS_NODEPTRS_PER_BLOCK(trans->fs_info));
+	if (slot != nritems) {
+		if (level) {
+			ret = btrfs_tree_mod_log_insert_move(lower, slot + 1,
+					slot, nritems - slot);
+			if (ret < 0) {
+				btrfs_abort_transaction(trans, ret);
+				return ret;
+			}
+		}
 		memmove_extent_buffer(lower,
 			      btrfs_node_key_ptr_offset(lower, slot + 1),
 			      btrfs_node_key_ptr_offset(lower, slot),
 			      (nritems - slot) * sizeof(struct btrfs_key_ptr));
 	}
+	if (level) {
+		ret = btrfs_tree_mod_log_insert_key(lower, slot,
+						    BTRFS_MOD_LOG_KEY_ADD);
+		if (ret < 0) {
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
+	}
 	btrfs_set_node_key(lower, key, slot);
 	btrfs_set_node_blockptr(lower, slot, bytenr);
 	WARN_ON(trans->transid == 0);
 	btrfs_set_node_ptr_generation(lower, slot, trans->transid);
 	btrfs_set_header_nritems(lower, nritems + 1);
 	btrfs_mark_buffer_dirty(lower);
+
 	return 0;
 }
 
@@ -1647,21 +3053,31 @@ static int insert_ptr(struct btrfs_trans_handle *trans, struct btrfs_root
  *
  * returns 0 on success and < 0 on failure
  */
-static int split_node(struct btrfs_trans_handle *trans, struct btrfs_root
-		      *root, struct btrfs_path *path, int level)
+static noinline int split_node(struct btrfs_trans_handle *trans,
+			       struct btrfs_root *root,
+			       struct btrfs_path *path, int level)
 {
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct extent_buffer *c;
 	struct extent_buffer *split;
 	struct btrfs_disk_key disk_key;
 	int mid;
 	int ret;
-	int wret;
 	u32 c_nritems;
 
 	c = path->nodes[level];
 	WARN_ON(btrfs_header_generation(c) != trans->transid);
 	if (c == root->node) {
-		/* trying to split the root, lets make a new one */
+		/*
+		 * trying to split the root, lets make a new one
+		 *
+		 * tree mod log: We don't log_removal old root in
+		 * insert_new_root, because that root buffer will be kept as a
+		 * normal node. We are going to log removal of half of the
+		 * elements below with btrfs_tree_mod_log_eb_copy(). We're
+		 * holding a tree lock on the buffer, which is why we cannot
+		 * race with other tree_mod_log users.
+		 */
 		ret = insert_new_root(trans, root, path, level + 1);
 		if (ret)
 			return ret;
@@ -1669,7 +3085,7 @@ static int split_node(struct btrfs_trans_handle *trans, struct btrfs_root
 		ret = push_nodes_for_insert(trans, root, path, level);
 		c = path->nodes[level];
 		if (!ret && btrfs_header_nritems(c) <
-		    BTRFS_NODEPTRS_PER_BLOCK(root->fs_info) - 3)
+		    BTRFS_NODEPTRS_PER_BLOCK(fs_info) - 3)
 			return 0;
 		if (ret < 0)
 			return ret;
@@ -1681,47 +3097,49 @@ static int split_node(struct btrfs_trans_handle *trans, struct btrfs_root
 
 	split = btrfs_alloc_tree_block(trans, root, 0, root->root_key.objectid,
 				       &disk_key, level, c->start, 0,
-				       BTRFS_NESTING_NORMAL);
+				       BTRFS_NESTING_SPLIT);
 	if (IS_ERR(split))
 		return PTR_ERR(split);
 
-	memset_extent_buffer(split, 0, 0, sizeof(struct btrfs_header));
-	btrfs_set_header_level(split, btrfs_header_level(c));
-	btrfs_set_header_bytenr(split, split->start);
-	btrfs_set_header_generation(split, trans->transid);
-	btrfs_set_header_backref_rev(split, BTRFS_MIXED_BACKREF_REV);
-	btrfs_set_header_owner(split, root->root_key.objectid);
-	write_extent_buffer_fsid(split, root->fs_info->fs_devices->metadata_uuid);
-	write_extent_buffer_chunk_tree_uuid(split, root->fs_info->chunk_tree_uuid);
-
-	root_add_used(root, root->fs_info->nodesize);
+	root_add_used(root, fs_info->nodesize);
+	ASSERT(btrfs_header_level(c) == level);
 
+	ret = btrfs_tree_mod_log_eb_copy(split, c, 0, mid, c_nritems - mid);
+	if (ret) {
+		btrfs_tree_unlock(split);
+		free_extent_buffer(split);
+		btrfs_abort_transaction(trans, ret);
+		return ret;
+	}
 	copy_extent_buffer(split, c,
 			   btrfs_node_key_ptr_offset(split, 0),
 			   btrfs_node_key_ptr_offset(c, mid),
 			   (c_nritems - mid) * sizeof(struct btrfs_key_ptr));
 	btrfs_set_header_nritems(split, c_nritems - mid);
 	btrfs_set_header_nritems(c, mid);
-	ret = 0;
 
 	btrfs_mark_buffer_dirty(c);
 	btrfs_mark_buffer_dirty(split);
 
-	wret = insert_ptr(trans, root, path, &disk_key, split->start,
-			  path->slots[level + 1] + 1,
-			  level + 1);
-	if (wret)
-		ret = wret;
+	ret = insert_ptr(trans, path, &disk_key, split->start,
+			 path->slots[level + 1] + 1, level + 1);
+	if (ret < 0) {
+		btrfs_tree_unlock(split);
+		free_extent_buffer(split);
+		return ret;
+	}
 
 	if (path->slots[level] >= mid) {
 		path->slots[level] -= mid;
+		btrfs_tree_unlock(c);
 		free_extent_buffer(c);
 		path->nodes[level] = split;
 		path->slots[level + 1] += 1;
 	} else {
+		btrfs_tree_unlock(split);
 		free_extent_buffer(split);
 	}
-	return ret;
+	return 0;
 }
 
 /*
@@ -1737,7 +3155,7 @@ static int leaf_space_used(const struct extent_buffer *l, int start, int nr)
 
 	if (!nr)
 		return 0;
-	data_len = btrfs_item_data_end(l, start);
+	data_len = btrfs_item_offset(l, start) + btrfs_item_size(l, start);
 	data_len = data_len - btrfs_item_offset(l, end);
 	data_len += sizeof(struct btrfs_item) * nr;
 	WARN_ON(data_len < 0);
@@ -1751,101 +3169,76 @@ static int leaf_space_used(const struct extent_buffer *l, int start, int nr)
  */
 int btrfs_leaf_free_space(const struct extent_buffer *leaf)
 {
+	struct btrfs_fs_info *fs_info = leaf->fs_info;
 	int nritems = btrfs_header_nritems(leaf);
-	u32 leaf_data_size;
 	int ret;
 
-	BUG_ON(!leaf->fs_info);
-	BUG_ON(leaf->fs_info->nodesize != leaf->len);
-	leaf_data_size = BTRFS_LEAF_DATA_SIZE(leaf->fs_info);
-	ret = leaf_data_size - leaf_space_used(leaf, 0 ,nritems);
+	ret = BTRFS_LEAF_DATA_SIZE(fs_info) - leaf_space_used(leaf, 0, nritems);
 	if (ret < 0) {
-		printk("leaf free space ret %d, leaf data size %u, used %d nritems %d\n",
-		       ret, leaf_data_size, leaf_space_used(leaf, 0, nritems),
-		       nritems);
+		btrfs_crit(fs_info,
+			   "leaf free space ret %d, leaf data size %lu, used %d nritems %d",
+			   ret,
+			   (unsigned long) BTRFS_LEAF_DATA_SIZE(fs_info),
+			   leaf_space_used(leaf, 0, nritems), nritems);
 	}
 	return ret;
 }
 
 /*
- * push some data in the path leaf to the right, trying to free up at
- * least data_size bytes.  returns zero if the push worked, nonzero otherwise
- *
- * returns 1 if the push failed because the other node didn't have enough
- * room, 0 if everything worked out and < 0 if there were major errors.
+ * min slot controls the lowest index we're willing to push to the
+ * right.  We'll push up to and including min_slot, but no lower
  */
-static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
-			   *root, struct btrfs_path *path, int data_size,
-			   int empty)
+static noinline int __push_leaf_right(struct btrfs_trans_handle *trans,
+				      struct btrfs_path *path,
+				      int data_size, int empty,
+				      struct extent_buffer *right,
+				      int free_space, u32 left_nritems,
+				      u32 min_slot)
 {
+	struct btrfs_fs_info *fs_info = right->fs_info;
 	struct extent_buffer *left = path->nodes[0];
-	struct extent_buffer *right;
-	struct extent_buffer *upper;
+	struct extent_buffer *upper = path->nodes[1];
+	struct btrfs_map_token token;
 	struct btrfs_disk_key disk_key;
 	int slot;
 	u32 i;
-	int free_space;
 	int push_space = 0;
 	int push_items = 0;
-	u32 left_nritems;
 	u32 nr;
 	u32 right_nritems;
 	u32 data_end;
 	u32 this_item_size;
-	int ret;
-
-	slot = path->slots[1];
-	if (!path->nodes[1]) {
-		return 1;
-	}
-	upper = path->nodes[1];
-	if (slot >= btrfs_header_nritems(upper) - 1)
-		return 1;
-
-	right = btrfs_read_node_slot(upper, slot + 1);
-	if (!extent_buffer_uptodate(right)) {
-		if (IS_ERR(right))
-			return PTR_ERR(right);
-		return -EIO;
-	}
-	free_space = btrfs_leaf_free_space(right);
-	if (free_space < data_size) {
-		free_extent_buffer(right);
-		return 1;
-	}
-
-	/* cow and double check */
-	ret = btrfs_cow_block(trans, root, right, upper,
-			      slot + 1, &right, BTRFS_NESTING_NORMAL);
-	if (ret) {
-		free_extent_buffer(right);
-		return 1;
-	}
-	free_space = btrfs_leaf_free_space(right);
-	if (free_space < data_size) {
-		free_extent_buffer(right);
-		return 1;
-	}
-
-	left_nritems = btrfs_header_nritems(left);
-	if (left_nritems == 0) {
-		free_extent_buffer(right);
-		return 1;
-	}
 
 	if (empty)
 		nr = 0;
 	else
-		nr = 1;
+		nr = max_t(u32, 1, min_slot);
 
+	if (path->slots[0] >= left_nritems)
+		push_space += data_size;
+
+	slot = path->slots[1];
 	i = left_nritems - 1;
 	while (i >= nr) {
+		if (!empty && push_items > 0) {
+			if (path->slots[0] > i)
+				break;
+			if (path->slots[0] == i) {
+				int space = btrfs_leaf_free_space(left);
+
+				if (space + push_space * 2 > free_space)
+					break;
+			}
+		}
+
 		if (path->slots[0] == i)
-			push_space += data_size + sizeof(struct btrfs_item);
+			push_space += data_size;
 
 		this_item_size = btrfs_item_size(left, i);
-		if (this_item_size + sizeof(struct btrfs_item) + push_space > free_space)
+		if (this_item_size + sizeof(struct btrfs_item) +
+		    push_space > free_space)
 			break;
+
 		push_items++;
 		push_space += this_item_size + sizeof(struct btrfs_item);
 		if (i == 0)
@@ -1853,13 +3246,10 @@ static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
 		i--;
 	}
 
-	if (push_items == 0) {
-		free_extent_buffer(right);
-		return 1;
-	}
+	if (push_items == 0)
+		goto out_unlock;
 
-	if (!empty && push_items == left_nritems)
-		WARN_ON(1);
+	WARN_ON(!empty && push_items == left_nritems);
 
 	/* push left to right */
 	right_nritems = btrfs_header_nritems(right);
@@ -1869,32 +3259,26 @@ static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
 
 	/* make room in the right data area */
 	data_end = leaf_data_end(right);
-	memmove_extent_buffer(right,
-			      btrfs_item_nr_offset(right, 0) + data_end - push_space,
-			      btrfs_item_nr_offset(right, 0) + data_end,
-			      BTRFS_LEAF_DATA_SIZE(root->fs_info) - data_end);
+	memmove_leaf_data(right, data_end - push_space, data_end,
+			  BTRFS_LEAF_DATA_SIZE(fs_info) - data_end);
 
 	/* copy from the left data area */
-	copy_extent_buffer(right, left, btrfs_item_nr_offset(right, 0) +
-		     BTRFS_LEAF_DATA_SIZE(root->fs_info) - push_space,
-		     btrfs_item_nr_offset(left, 0) + leaf_data_end(left), push_space);
+	copy_leaf_data(right, left, BTRFS_LEAF_DATA_SIZE(fs_info) - push_space,
+		       leaf_data_end(left), push_space);
 
-	memmove_extent_buffer(right, btrfs_item_nr_offset(right, push_items),
-			      btrfs_item_nr_offset(right, 0),
-			      right_nritems * sizeof(struct btrfs_item));
+	memmove_leaf_items(right, push_items, 0, right_nritems);
 
 	/* copy the items from left to right */
-	copy_extent_buffer(right, left, btrfs_item_nr_offset(right, 0),
-		   btrfs_item_nr_offset(left, left_nritems - push_items),
-		   push_items * sizeof(struct btrfs_item));
+	copy_leaf_items(right, left, 0, left_nritems - push_items, push_items);
 
 	/* update the item pointers */
+	btrfs_init_map_token(&token, right);
 	right_nritems += push_items;
 	btrfs_set_header_nritems(right, right_nritems);
-	push_space = BTRFS_LEAF_DATA_SIZE(root->fs_info);
+	push_space = BTRFS_LEAF_DATA_SIZE(fs_info);
 	for (i = 0; i < right_nritems; i++) {
-		push_space -= btrfs_item_size(right, i);
-		btrfs_set_item_offset(right, i, push_space);
+		push_space -= btrfs_token_item_size(&token, i);
+		btrfs_set_token_item_offset(&token, i, push_space);
 	}
 
 	left_nritems -= push_items;
@@ -1902,6 +3286,9 @@ static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
 
 	if (left_nritems)
 		btrfs_mark_buffer_dirty(left);
+	else
+		btrfs_clear_buffer_dirty(trans, left);
+
 	btrfs_mark_buffer_dirty(right);
 
 	btrfs_item_key(right, &disk_key, 0);
@@ -1911,36 +3298,260 @@ static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
 	/* then fixup the leaf pointer in the path */
 	if (path->slots[0] >= left_nritems) {
 		path->slots[0] -= left_nritems;
+		if (btrfs_header_nritems(path->nodes[0]) == 0)
+			btrfs_clear_buffer_dirty(trans, path->nodes[0]);
+		btrfs_tree_unlock(path->nodes[0]);
 		free_extent_buffer(path->nodes[0]);
 		path->nodes[0] = right;
 		path->slots[1] += 1;
 	} else {
+		btrfs_tree_unlock(right);
 		free_extent_buffer(right);
 	}
 	return 0;
+
+out_unlock:
+	btrfs_tree_unlock(right);
+	free_extent_buffer(right);
+	return 1;
 }
+
+/*
+ * push some data in the path leaf to the right, trying to free up at
+ * least data_size bytes.  returns zero if the push worked, nonzero otherwise
+ *
+ * returns 1 if the push failed because the other node didn't have enough
+ * room, 0 if everything worked out and < 0 if there were major errors.
+ *
+ * this will push starting from min_slot to the end of the leaf.  It won't
+ * push any slot lower than min_slot
+ */
+static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
+			   *root, struct btrfs_path *path,
+			   int min_data_size, int data_size,
+			   int empty, u32 min_slot)
+{
+	struct extent_buffer *left = path->nodes[0];
+	struct extent_buffer *right;
+	struct extent_buffer *upper;
+	int slot;
+	int free_space;
+	u32 left_nritems;
+	int ret;
+
+	if (!path->nodes[1])
+		return 1;
+
+	slot = path->slots[1];
+	upper = path->nodes[1];
+	if (slot >= btrfs_header_nritems(upper) - 1)
+		return 1;
+
+	btrfs_assert_tree_write_locked(path->nodes[1]);
+
+	right = btrfs_read_node_slot(upper, slot + 1);
+	if (IS_ERR(right))
+		return PTR_ERR(right);
+
+	__btrfs_tree_lock(right, BTRFS_NESTING_RIGHT);
+
+	free_space = btrfs_leaf_free_space(right);
+	if (free_space < data_size)
+		goto out_unlock;
+
+	ret = btrfs_cow_block(trans, root, right, upper,
+			      slot + 1, &right, BTRFS_NESTING_RIGHT_COW);
+	if (ret)
+		goto out_unlock;
+
+	left_nritems = btrfs_header_nritems(left);
+	if (left_nritems == 0)
+		goto out_unlock;
+
+	if (check_sibling_keys(left, right)) {
+		ret = -EUCLEAN;
+		btrfs_abort_transaction(trans, ret);
+		btrfs_tree_unlock(right);
+		free_extent_buffer(right);
+		return ret;
+	}
+	if (path->slots[0] == left_nritems && !empty) {
+		/* Key greater than all keys in the leaf, right neighbor has
+		 * enough room for it and we're not emptying our leaf to delete
+		 * it, therefore use right neighbor to insert the new item and
+		 * no need to touch/dirty our left leaf. */
+		btrfs_tree_unlock(left);
+		free_extent_buffer(left);
+		path->nodes[0] = right;
+		path->slots[0] = 0;
+		path->slots[1]++;
+		return 0;
+	}
+
+	return __push_leaf_right(trans, path, min_data_size, empty, right,
+				 free_space, left_nritems, min_slot);
+out_unlock:
+	btrfs_tree_unlock(right);
+	free_extent_buffer(right);
+	return 1;
+}
+
 /*
  * push some data in the path leaf to the left, trying to free up at
  * least data_size bytes.  returns zero if the push worked, nonzero otherwise
+ *
+ * max_slot can put a limit on how far into the leaf we'll push items.  The
+ * item at 'max_slot' won't be touched.  Use (u32)-1 to make us do all the
+ * items
  */
-static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
-			  *root, struct btrfs_path *path, int data_size,
-			  int empty)
+static noinline int __push_leaf_left(struct btrfs_trans_handle *trans,
+				     struct btrfs_path *path, int data_size,
+				     int empty, struct extent_buffer *left,
+				     int free_space, u32 right_nritems,
+				     u32 max_slot)
 {
+	struct btrfs_fs_info *fs_info = left->fs_info;
 	struct btrfs_disk_key disk_key;
 	struct extent_buffer *right = path->nodes[0];
-	struct extent_buffer *left;
-	int slot;
 	int i;
-	int free_space;
 	int push_space = 0;
 	int push_items = 0;
 	u32 old_left_nritems;
-	u32 right_nritems;
 	u32 nr;
 	int ret = 0;
 	u32 this_item_size;
 	u32 old_left_item_size;
+	struct btrfs_map_token token;
+
+	if (empty)
+		nr = min(right_nritems, max_slot);
+	else
+		nr = min(right_nritems - 1, max_slot);
+
+	for (i = 0; i < nr; i++) {
+		if (!empty && push_items > 0) {
+			if (path->slots[0] < i)
+				break;
+			if (path->slots[0] == i) {
+				int space = btrfs_leaf_free_space(right);
+
+				if (space + push_space * 2 > free_space)
+					break;
+			}
+		}
+
+		if (path->slots[0] == i)
+			push_space += data_size;
+
+		this_item_size = btrfs_item_size(right, i);
+		if (this_item_size + sizeof(struct btrfs_item) + push_space >
+		    free_space)
+			break;
+
+		push_items++;
+		push_space += this_item_size + sizeof(struct btrfs_item);
+	}
+
+	if (push_items == 0) {
+		ret = 1;
+		goto out;
+	}
+	WARN_ON(!empty && push_items == btrfs_header_nritems(right));
+
+	/* push data from right to left */
+	copy_leaf_items(left, right, btrfs_header_nritems(left), 0, push_items);
+
+	push_space = BTRFS_LEAF_DATA_SIZE(fs_info) -
+		     btrfs_item_offset(right, push_items - 1);
+
+	copy_leaf_data(left, right, leaf_data_end(left) - push_space,
+		       btrfs_item_offset(right, push_items - 1), push_space);
+	old_left_nritems = btrfs_header_nritems(left);
+	BUG_ON(old_left_nritems <= 0);
+
+	btrfs_init_map_token(&token, left);
+	old_left_item_size = btrfs_item_offset(left, old_left_nritems - 1);
+	for (i = old_left_nritems; i < old_left_nritems + push_items; i++) {
+		u32 ioff;
+
+		ioff = btrfs_token_item_offset(&token, i);
+		btrfs_set_token_item_offset(&token, i,
+		      ioff - (BTRFS_LEAF_DATA_SIZE(fs_info) - old_left_item_size));
+	}
+	btrfs_set_header_nritems(left, old_left_nritems + push_items);
+
+	/* fixup right node */
+	if (push_items > right_nritems)
+		WARN(1, KERN_CRIT "push items %d nr %u\n", push_items,
+		       right_nritems);
+
+	if (push_items < right_nritems) {
+		push_space = btrfs_item_offset(right, push_items - 1) -
+						  leaf_data_end(right);
+		memmove_leaf_data(right,
+				  BTRFS_LEAF_DATA_SIZE(fs_info) - push_space,
+				  leaf_data_end(right), push_space);
+
+		memmove_leaf_items(right, 0, push_items,
+				   btrfs_header_nritems(right) - push_items);
+	}
+
+	btrfs_init_map_token(&token, right);
+	right_nritems -= push_items;
+	btrfs_set_header_nritems(right, right_nritems);
+	push_space = BTRFS_LEAF_DATA_SIZE(fs_info);
+	for (i = 0; i < right_nritems; i++) {
+		push_space = push_space - btrfs_token_item_size(&token, i);
+		btrfs_set_token_item_offset(&token, i, push_space);
+	}
+
+	btrfs_mark_buffer_dirty(left);
+	if (right_nritems)
+		btrfs_mark_buffer_dirty(right);
+	else
+		btrfs_clear_buffer_dirty(trans, right);
+
+	btrfs_item_key(right, &disk_key, 0);
+	fixup_low_keys(path, &disk_key, 1);
+
+	/* then fixup the leaf pointer in the path */
+	if (path->slots[0] < push_items) {
+		path->slots[0] += old_left_nritems;
+		btrfs_tree_unlock(path->nodes[0]);
+		free_extent_buffer(path->nodes[0]);
+		path->nodes[0] = left;
+		path->slots[1] -= 1;
+	} else {
+		btrfs_tree_unlock(left);
+		free_extent_buffer(left);
+		path->slots[0] -= push_items;
+	}
+	BUG_ON(path->slots[0] < 0);
+	return ret;
+out:
+	btrfs_tree_unlock(left);
+	free_extent_buffer(left);
+	return ret;
+}
+
+/*
+ * push some data in the path leaf to the left, trying to free up at
+ * least data_size bytes.  returns zero if the push worked, nonzero otherwise
+ *
+ * max_slot can put a limit on how far into the leaf we'll push items.  The
+ * item at 'max_slot' won't be touched.  Use (u32)-1 to make us push all the
+ * items
+ */
+static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
+			  *root, struct btrfs_path *path, int min_data_size,
+			  int data_size, int empty, u32 max_slot)
+{
+	struct extent_buffer *right = path->nodes[0];
+	struct extent_buffer *left;
+	int slot;
+	int free_space;
+	u32 right_nritems;
+	int ret = 0;
 
 	slot = path->slots[1];
 	if (slot == 0)
@@ -1949,199 +3560,171 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
 		return 1;
 
 	right_nritems = btrfs_header_nritems(right);
-	if (right_nritems == 0) {
+	if (right_nritems == 0)
 		return 1;
-	}
+
+	btrfs_assert_tree_write_locked(path->nodes[1]);
 
 	left = btrfs_read_node_slot(path->nodes[1], slot - 1);
+	if (IS_ERR(left))
+		return PTR_ERR(left);
+
+	__btrfs_tree_lock(left, BTRFS_NESTING_LEFT);
+
 	free_space = btrfs_leaf_free_space(left);
 	if (free_space < data_size) {
-		free_extent_buffer(left);
-		return 1;
+		ret = 1;
+		goto out;
 	}
 
-	/* cow and double check */
 	ret = btrfs_cow_block(trans, root, left,
 			      path->nodes[1], slot - 1, &left,
-			      BTRFS_NESTING_NORMAL);
+			      BTRFS_NESTING_LEFT_COW);
 	if (ret) {
 		/* we hit -ENOSPC, but it isn't fatal here */
-		free_extent_buffer(left);
-		return 1;
+		if (ret == -ENOSPC)
+			ret = 1;
+		goto out;
 	}
 
-	free_space = btrfs_leaf_free_space(left);
-	if (free_space < data_size) {
-		free_extent_buffer(left);
-		return 1;
+	if (check_sibling_keys(left, right)) {
+		ret = -EUCLEAN;
+		btrfs_abort_transaction(trans, ret);
+		goto out;
 	}
-
-	if (empty)
-		nr = right_nritems;
-	else
-		nr = right_nritems - 1;
-
-	for (i = 0; i < nr; i++) {
-		if (path->slots[0] == i)
-			push_space += data_size + sizeof(struct btrfs_item);
-
-		this_item_size = btrfs_item_size(right, i);
-		if (this_item_size + sizeof(struct btrfs_item) + push_space > free_space)
-			break;
-
-		push_items++;
-		push_space += this_item_size + sizeof(struct btrfs_item);
-	}
-
-	if (push_items == 0) {
-		free_extent_buffer(left);
-		return 1;
-	}
-	if (!empty && push_items == btrfs_header_nritems(right))
-		WARN_ON(1);
-
-	/* push data from right to left */
-	copy_extent_buffer(left, right,
-			   btrfs_item_nr_offset(left, btrfs_header_nritems(left)),
-			   btrfs_item_nr_offset(right, 0),
-			   push_items * sizeof(struct btrfs_item));
-
-	push_space = BTRFS_LEAF_DATA_SIZE(root->fs_info) -
-		     btrfs_item_offset(right, push_items -1);
-
-	copy_extent_buffer(left, right, btrfs_item_nr_offset(left, 0) +
-		     leaf_data_end(left) - push_space,
-		     btrfs_item_nr_offset(right, 0) +
-		     btrfs_item_offset(right, push_items - 1),
-		     push_space);
-	old_left_nritems = btrfs_header_nritems(left);
-	BUG_ON(old_left_nritems == 0);
-
-	old_left_item_size = btrfs_item_offset(left, old_left_nritems - 1);
-	for (i = old_left_nritems; i < old_left_nritems + push_items; i++) {
-		u32 ioff;
-
-		ioff = btrfs_item_offset(left, i);
-		btrfs_set_item_offset(left, i,
-		      ioff - (BTRFS_LEAF_DATA_SIZE(root->fs_info) -
-			      old_left_item_size));
-	}
-	btrfs_set_header_nritems(left, old_left_nritems + push_items);
-
-	/* fixup right node */
-	if (push_items > right_nritems) {
-		printk("push items %d nr %u\n", push_items, right_nritems);
-		WARN_ON(1);
-	}
-
-	if (push_items < right_nritems) {
-		push_space = btrfs_item_offset(right, push_items - 1) -
-						  leaf_data_end(right);
-		memmove_extent_buffer(right, btrfs_item_nr_offset(right, 0) +
-				      BTRFS_LEAF_DATA_SIZE(root->fs_info) -
-				      push_space,
-				      btrfs_item_nr_offset(right, 0) +
-				      leaf_data_end(right), push_space);
-
-		memmove_extent_buffer(right, btrfs_item_nr_offset(right, 0),
-			      btrfs_item_nr_offset(right, push_items),
-			     (btrfs_header_nritems(right) - push_items) *
-			     sizeof(struct btrfs_item));
-	}
-	right_nritems -= push_items;
-	btrfs_set_header_nritems(right, right_nritems);
-	push_space = BTRFS_LEAF_DATA_SIZE(root->fs_info);
-	for (i = 0; i < right_nritems; i++) {
-		push_space = push_space - btrfs_item_size(right, i);
-		btrfs_set_item_offset(right, i, push_space);
-	}
-
-	btrfs_mark_buffer_dirty(left);
-	if (right_nritems)
-		btrfs_mark_buffer_dirty(right);
-
-	btrfs_item_key(right, &disk_key, 0);
-	fixup_low_keys(path, &disk_key, 1);
-
-	/* then fixup the leaf pointer in the path */
-	if (path->slots[0] < push_items) {
-		path->slots[0] += old_left_nritems;
-		free_extent_buffer(path->nodes[0]);
-		path->nodes[0] = left;
-		path->slots[1] -= 1;
-	} else {
-		free_extent_buffer(left);
-		path->slots[0] -= push_items;
-	}
-	BUG_ON(path->slots[0] < 0);
+	return __push_leaf_left(trans, path, min_data_size, empty, left,
+				free_space, right_nritems, max_slot);
+out:
+	btrfs_tree_unlock(left);
+	free_extent_buffer(left);
 	return ret;
 }
 
 /*
  * split the path's leaf in two, making sure there is at least data_size
  * available for the resulting leaf level of the path.
- *
- * returns 0 if all went well and < 0 on failure.
  */
 static noinline int copy_for_split(struct btrfs_trans_handle *trans,
-			       struct btrfs_root *root,
-			       struct btrfs_path *path,
-			       struct extent_buffer *l,
-			       struct extent_buffer *right,
-			       int slot, int mid, int nritems)
+				   struct btrfs_path *path,
+				   struct extent_buffer *l,
+				   struct extent_buffer *right,
+				   int slot, int mid, int nritems)
 {
+	struct btrfs_fs_info *fs_info = trans->fs_info;
 	int data_copy_size;
 	int rt_data_off;
 	int i;
-	int ret = 0;
-	int wret;
+	int ret;
 	struct btrfs_disk_key disk_key;
+	struct btrfs_map_token token;
 
 	nritems = nritems - mid;
 	btrfs_set_header_nritems(right, nritems);
 	data_copy_size = btrfs_item_data_end(l, mid) - leaf_data_end(l);
 
-	copy_extent_buffer(right, l, btrfs_item_nr_offset(right, 0),
-			   btrfs_item_nr_offset(l, mid),
-			   nritems * sizeof(struct btrfs_item));
+	copy_leaf_items(right, l, 0, mid, nritems);
 
-	copy_extent_buffer(right, l,
-		     btrfs_item_nr_offset(right, 0) +
-		     BTRFS_LEAF_DATA_SIZE(root->fs_info) - data_copy_size,
-			 btrfs_item_nr_offset(l, 0) + leaf_data_end(l), data_copy_size);
+	copy_leaf_data(right, l, BTRFS_LEAF_DATA_SIZE(fs_info) - data_copy_size,
+		       leaf_data_end(l), data_copy_size);
 
-	rt_data_off = BTRFS_LEAF_DATA_SIZE(root->fs_info) -
-		      btrfs_item_data_end(l, mid);
+	rt_data_off = BTRFS_LEAF_DATA_SIZE(fs_info) - btrfs_item_data_end(l, mid);
 
+	btrfs_init_map_token(&token, right);
 	for (i = 0; i < nritems; i++) {
-		u32 ioff = btrfs_item_offset(right, i);
-		btrfs_set_item_offset(right, i, ioff + rt_data_off);
+		u32 ioff;
+
+		ioff = btrfs_token_item_offset(&token, i);
+		btrfs_set_token_item_offset(&token, i, ioff + rt_data_off);
 	}
 
 	btrfs_set_header_nritems(l, mid);
-	ret = 0;
 	btrfs_item_key(right, &disk_key, 0);
-	wret = insert_ptr(trans, root, path, &disk_key, right->start,
-			  path->slots[1] + 1, 1);
-	if (wret)
-		ret = wret;
+	ret = insert_ptr(trans, path, &disk_key, right->start, path->slots[1] + 1, 1);
+	if (ret < 0)
+		return ret;
 
 	btrfs_mark_buffer_dirty(right);
 	btrfs_mark_buffer_dirty(l);
 	BUG_ON(path->slots[0] != slot);
 
 	if (mid <= slot) {
+		btrfs_tree_unlock(path->nodes[0]);
 		free_extent_buffer(path->nodes[0]);
 		path->nodes[0] = right;
 		path->slots[0] -= mid;
 		path->slots[1] += 1;
 	} else {
+		btrfs_tree_unlock(right);
 		free_extent_buffer(right);
 	}
 
 	BUG_ON(path->slots[0] < 0);
 
-	return ret;
+	return 0;
+}
+
+/*
+ * double splits happen when we need to insert a big item in the middle
+ * of a leaf.  A double split can leave us with 3 mostly empty leaves:
+ * leaf: [ slots 0 - N] [ our target ] [ N + 1 - total in leaf ]
+ *          A                 B                 C
+ *
+ * We avoid this by trying to push the items on either side of our target
+ * into the adjacent leaves.  If all goes well we can avoid the double split
+ * completely.
+ */
+static noinline int push_for_double_split(struct btrfs_trans_handle *trans,
+					  struct btrfs_root *root,
+					  struct btrfs_path *path,
+					  int data_size)
+{
+	int ret;
+	int progress = 0;
+	int slot;
+	u32 nritems;
+	int space_needed = data_size;
+
+	slot = path->slots[0];
+	if (slot < btrfs_header_nritems(path->nodes[0]))
+		space_needed -= btrfs_leaf_free_space(path->nodes[0]);
+
+	/*
+	 * try to push all the items after our slot into the
+	 * right leaf
+	 */
+	ret = push_leaf_right(trans, root, path, 1, space_needed, 0, slot);
+	if (ret < 0)
+		return ret;
+
+	if (ret == 0)
+		progress++;
+
+	nritems = btrfs_header_nritems(path->nodes[0]);
+	/*
+	 * our goal is to get our slot at the start or end of a leaf.  If
+	 * we've done so we're done
+	 */
+	if (path->slots[0] == 0 || path->slots[0] == nritems)
+		return 0;
+
+	if (btrfs_leaf_free_space(path->nodes[0]) >= data_size)
+		return 0;
+
+	/* try to push all the items before our slot into the next leaf */
+	slot = path->slots[0];
+	space_needed = data_size;
+	if (slot > 0)
+		space_needed -= btrfs_leaf_free_space(path->nodes[0]);
+	ret = push_leaf_left(trans, root, path, 1, space_needed, 0, slot);
+	if (ret < 0)
+		return ret;
+
+	if (ret == 0)
+		progress++;
+
+	if (progress)
+		return 0;
+	return 1;
 }
 
 /*
@@ -2162,24 +3745,36 @@ static noinline int split_leaf(struct btrfs_trans_handle *trans,
 	int mid;
 	int slot;
 	struct extent_buffer *right;
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	int ret = 0;
 	int wret;
 	int split;
 	int num_doubles = 0;
+	int tried_avoid_double = 0;
 
 	l = path->nodes[0];
 	slot = path->slots[0];
 	if (extend && data_size + btrfs_item_size(l, slot) +
-	    sizeof(struct btrfs_item) > BTRFS_LEAF_DATA_SIZE(root->fs_info))
+	    sizeof(struct btrfs_item) > BTRFS_LEAF_DATA_SIZE(fs_info))
 		return -EOVERFLOW;
 
 	/* first try to make some room by pushing left and right */
-	if (data_size && ins_key->type != BTRFS_DIR_ITEM_KEY) {
-		wret = push_leaf_right(trans, root, path, data_size, 0);
+	if (data_size && path->nodes[1]) {
+		int space_needed = data_size;
+
+		if (slot < btrfs_header_nritems(l))
+			space_needed -= btrfs_leaf_free_space(l);
+
+		wret = push_leaf_right(trans, root, path, space_needed,
+				       space_needed, 0, 0);
 		if (wret < 0)
 			return wret;
 		if (wret) {
-			wret = push_leaf_left(trans, root, path, data_size, 0);
+			space_needed = data_size;
+			if (slot > 0)
+				space_needed -= btrfs_leaf_free_space(l);
+			wret = push_leaf_left(trans, root, path, space_needed,
+					      space_needed, 0, (u32)-1);
 			if (wret < 0)
 				return wret;
 		}
@@ -2205,22 +3800,23 @@ again:
 	if (mid <= slot) {
 		if (nritems == 1 ||
 		    leaf_space_used(l, mid, nritems - mid) + data_size >
-			BTRFS_LEAF_DATA_SIZE(root->fs_info)) {
+			BTRFS_LEAF_DATA_SIZE(fs_info)) {
 			if (slot >= nritems) {
 				split = 0;
 			} else {
 				mid = slot;
 				if (mid != nritems &&
 				    leaf_space_used(l, mid, nritems - mid) +
-				    data_size >
-				    BTRFS_LEAF_DATA_SIZE(root->fs_info)) {
+				    data_size > BTRFS_LEAF_DATA_SIZE(fs_info)) {
+					if (data_size && !tried_avoid_double)
+						goto push_for_double;
 					split = 2;
 				}
 			}
 		}
 	} else {
 		if (leaf_space_used(l, 0, mid) + data_size >
-			BTRFS_LEAF_DATA_SIZE(root->fs_info)) {
+			BTRFS_LEAF_DATA_SIZE(fs_info)) {
 			if (!extend && data_size && slot == 0) {
 				split = 0;
 			} else if ((extend || !data_size) && slot == 0) {
@@ -2229,9 +3825,10 @@ again:
 				mid = slot;
 				if (mid != nritems &&
 				    leaf_space_used(l, mid, nritems - mid) +
-				    data_size >
-				    BTRFS_LEAF_DATA_SIZE(root->fs_info)) {
-					split = 2 ;
+				    data_size > BTRFS_LEAF_DATA_SIZE(fs_info)) {
+					if (data_size && !tried_avoid_double)
+						goto push_for_double;
+					split = 2;
 				}
 			}
 		}
@@ -2242,58 +3839,68 @@ again:
 	else
 		btrfs_item_key(l, &disk_key, mid);
 
+	/*
+	 * We have to about BTRFS_NESTING_NEW_ROOT here if we've done a double
+	 * split, because we're only allowed to have MAX_LOCKDEP_SUBCLASSES
+	 * subclasses, which is 8 at the time of this patch, and we've maxed it
+	 * out.  In the future we could add a
+	 * BTRFS_NESTING_SPLIT_THE_SPLITTENING if we need to, but for now just
+	 * use BTRFS_NESTING_NEW_ROOT.
+	 */
 	right = btrfs_alloc_tree_block(trans, root, 0, root->root_key.objectid,
 				       &disk_key, 0, l->start, 0,
-				       BTRFS_NESTING_NORMAL);
-	if (IS_ERR(right)) {
-		BUG_ON(1);
+				       num_doubles ? BTRFS_NESTING_NEW_ROOT :
+				       BTRFS_NESTING_SPLIT);
+	if (IS_ERR(right))
 		return PTR_ERR(right);
-	}
 
-	memset_extent_buffer(right, 0, 0, sizeof(struct btrfs_header));
-	btrfs_set_header_bytenr(right, right->start);
-	btrfs_set_header_generation(right, trans->transid);
-	btrfs_set_header_backref_rev(right, BTRFS_MIXED_BACKREF_REV);
-	btrfs_set_header_owner(right, root->root_key.objectid);
-	btrfs_set_header_level(right, 0);
-	write_extent_buffer_fsid(right, root->fs_info->fs_devices->metadata_uuid);
-	write_extent_buffer_chunk_tree_uuid(right, root->fs_info->chunk_tree_uuid);
-
-	root_add_used(root, root->fs_info->nodesize);
+	root_add_used(root, fs_info->nodesize);
 
 	if (split == 0) {
 		if (mid <= slot) {
 			btrfs_set_header_nritems(right, 0);
-			wret = insert_ptr(trans, root, path,
-					  &disk_key, right->start,
-					  path->slots[1] + 1, 1);
-			if (wret)
-				ret = wret;
-
+			ret = insert_ptr(trans, path, &disk_key,
+					 right->start, path->slots[1] + 1, 1);
+			if (ret < 0) {
+				btrfs_tree_unlock(right);
+				free_extent_buffer(right);
+				return ret;
+			}
+			btrfs_tree_unlock(path->nodes[0]);
 			free_extent_buffer(path->nodes[0]);
 			path->nodes[0] = right;
 			path->slots[0] = 0;
 			path->slots[1] += 1;
 		} else {
 			btrfs_set_header_nritems(right, 0);
-			wret = insert_ptr(trans, root, path,
-					  &disk_key,
-					  right->start,
-					  path->slots[1], 1);
-			if (wret)
-				ret = wret;
+			ret = insert_ptr(trans, path, &disk_key,
+					 right->start, path->slots[1], 1);
+			if (ret < 0) {
+				btrfs_tree_unlock(right);
+				free_extent_buffer(right);
+				return ret;
+			}
+			btrfs_tree_unlock(path->nodes[0]);
 			free_extent_buffer(path->nodes[0]);
 			path->nodes[0] = right;
 			path->slots[0] = 0;
 			if (path->slots[1] == 0)
 				fixup_low_keys(path, &disk_key, 1);
 		}
-		btrfs_mark_buffer_dirty(right);
+		/*
+		 * We create a new leaf 'right' for the required ins_len and
+		 * we'll do btrfs_mark_buffer_dirty() on this leaf after copying
+		 * the content of ins_len to 'right'.
+		 */
 		return ret;
 	}
 
-	ret = copy_for_split(trans, root, path, l, right, slot, mid, nritems);
-	BUG_ON(ret);
+	ret = copy_for_split(trans, path, l, right, slot, mid, nritems);
+	if (ret < 0) {
+		btrfs_tree_unlock(right);
+		free_extent_buffer(right);
+		return ret;
+	}
 
 	if (split == 2) {
 		BUG_ON(num_doubles != 0);
@@ -2301,9 +3908,148 @@ again:
 		goto again;
 	}
 
+	return 0;
+
+push_for_double:
+	push_for_double_split(trans, root, path, data_size);
+	tried_avoid_double = 1;
+	if (btrfs_leaf_free_space(path->nodes[0]) >= data_size)
+		return 0;
+	goto again;
+}
+
+static noinline int setup_leaf_for_split(struct btrfs_trans_handle *trans,
+					 struct btrfs_root *root,
+					 struct btrfs_path *path, int ins_len)
+{
+	struct btrfs_key key;
+	struct extent_buffer *leaf;
+	struct btrfs_file_extent_item *fi;
+	u64 extent_len = 0;
+	u32 item_size;
+	int ret;
+
+	leaf = path->nodes[0];
+	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
+
+	BUG_ON(key.type != BTRFS_EXTENT_DATA_KEY &&
+	       key.type != BTRFS_EXTENT_CSUM_KEY);
+
+	if (btrfs_leaf_free_space(leaf) >= ins_len)
+		return 0;
+
+	item_size = btrfs_item_size(leaf, path->slots[0]);
+	if (key.type == BTRFS_EXTENT_DATA_KEY) {
+		fi = btrfs_item_ptr(leaf, path->slots[0],
+				    struct btrfs_file_extent_item);
+		extent_len = btrfs_file_extent_num_bytes(leaf, fi);
+	}
+	btrfs_release_path(path);
+
+	path->keep_locks = 1;
+	path->search_for_split = 1;
+	ret = btrfs_search_slot(trans, root, &key, path, 0, 1);
+	path->search_for_split = 0;
+	if (ret > 0)
+		ret = -EAGAIN;
+	if (ret < 0)
+		goto err;
+
+	ret = -EAGAIN;
+	leaf = path->nodes[0];
+	/* if our item isn't there, return now */
+	if (item_size != btrfs_item_size(leaf, path->slots[0]))
+		goto err;
+
+	/* the leaf has  changed, it now has room.  return now */
+	if (btrfs_leaf_free_space(path->nodes[0]) >= ins_len)
+		goto err;
+
+	if (key.type == BTRFS_EXTENT_DATA_KEY) {
+		fi = btrfs_item_ptr(leaf, path->slots[0],
+				    struct btrfs_file_extent_item);
+		if (extent_len != btrfs_file_extent_num_bytes(leaf, fi))
+			goto err;
+	}
+
+	ret = split_leaf(trans, root, &key, path, ins_len, 1);
+	if (ret)
+		goto err;
+
+	path->keep_locks = 0;
+	btrfs_unlock_up_safe(path, 1);
+	return 0;
+err:
+	path->keep_locks = 0;
 	return ret;
 }
 
+static noinline int split_item(struct btrfs_path *path,
+			       const struct btrfs_key *new_key,
+			       unsigned long split_offset)
+{
+	struct extent_buffer *leaf;
+	int orig_slot, slot;
+	char *buf;
+	u32 nritems;
+	u32 item_size;
+	u32 orig_offset;
+	struct btrfs_disk_key disk_key;
+
+	leaf = path->nodes[0];
+	/*
+	 * Shouldn't happen because the caller must have previously called
+	 * setup_leaf_for_split() to make room for the new item in the leaf.
+	 */
+	if (WARN_ON(btrfs_leaf_free_space(leaf) < sizeof(struct btrfs_item)))
+		return -ENOSPC;
+
+	orig_slot = path->slots[0];
+	orig_offset = btrfs_item_offset(leaf, path->slots[0]);
+	item_size = btrfs_item_size(leaf, path->slots[0]);
+
+	buf = kmalloc(item_size, GFP_NOFS);
+	if (!buf)
+		return -ENOMEM;
+
+	read_extent_buffer(leaf, buf, btrfs_item_ptr_offset(leaf,
+			    path->slots[0]), item_size);
+
+	slot = path->slots[0] + 1;
+	nritems = btrfs_header_nritems(leaf);
+	if (slot != nritems) {
+		/* shift the items */
+		memmove_leaf_items(leaf, slot + 1, slot, nritems - slot);
+	}
+
+	btrfs_cpu_key_to_disk(&disk_key, new_key);
+	btrfs_set_item_key(leaf, &disk_key, slot);
+
+	btrfs_set_item_offset(leaf, slot, orig_offset);
+	btrfs_set_item_size(leaf, slot, item_size - split_offset);
+
+	btrfs_set_item_offset(leaf, orig_slot,
+				 orig_offset + item_size - split_offset);
+	btrfs_set_item_size(leaf, orig_slot, split_offset);
+
+	btrfs_set_header_nritems(leaf, nritems + 1);
+
+	/* write the data for the start of the original item */
+	write_extent_buffer(leaf, buf,
+			    btrfs_item_ptr_offset(leaf, path->slots[0]),
+			    split_offset);
+
+	/* write the data for the new item */
+	write_extent_buffer(leaf, buf + split_offset,
+			    btrfs_item_ptr_offset(leaf, slot),
+			    item_size - split_offset);
+	btrfs_mark_buffer_dirty(leaf);
+
+	BUG_ON(btrfs_leaf_free_space(leaf) < 0);
+	kfree(buf);
+	return 0;
+}
+
 /*
  * This function splits a single item into two items,
  * giving 'new_key' to the new item and splitting the
@@ -2325,96 +4071,22 @@ int btrfs_split_item(struct btrfs_trans_handle *trans,
 		     const struct btrfs_key *new_key,
 		     unsigned long split_offset)
 {
-	u32 item_size;
-	struct extent_buffer *leaf;
-	struct btrfs_key orig_key;
-	int ret = 0;
-	int slot;
-	u32 nritems;
-	u32 orig_offset;
-	struct btrfs_disk_key disk_key;
-	char *buf;
+	int ret;
+	ret = setup_leaf_for_split(trans, root, path,
+				   sizeof(struct btrfs_item));
+	if (ret)
+		return ret;
 
-	leaf = path->nodes[0];
-	btrfs_item_key_to_cpu(leaf, &orig_key, path->slots[0]);
-	if (btrfs_leaf_free_space(leaf) >=
-	    sizeof(struct btrfs_item))
-		goto split;
-
-	item_size = btrfs_item_size(leaf, path->slots[0]);
-	btrfs_release_path(path);
-
-	path->search_for_split = 1;
-
-	ret = btrfs_search_slot(trans, root, &orig_key, path, 0, 1);
-	path->search_for_split = 0;
-
-	/* if our item isn't there or got smaller, return now */
-	if (ret != 0 || item_size != btrfs_item_size(path->nodes[0],
-							path->slots[0])) {
-		return -EAGAIN;
-	}
-
-	ret = split_leaf(trans, root, &orig_key, path, 0, 0);
-	BUG_ON(ret);
-
-	BUG_ON(btrfs_leaf_free_space(leaf) < sizeof(struct btrfs_item));
-	leaf = path->nodes[0];
-
-split:
-	orig_offset = btrfs_item_offset(leaf, path->slots[0]);
-	item_size = btrfs_item_size(leaf, path->slots[0]);
-
-
-	buf = kmalloc(item_size, GFP_NOFS);
-	BUG_ON(!buf);
-	read_extent_buffer(leaf, buf, btrfs_item_ptr_offset(leaf,
-			    path->slots[0]), item_size);
-	slot = path->slots[0] + 1;
-	leaf = path->nodes[0];
-
-	nritems = btrfs_header_nritems(leaf);
-
-	if (slot < nritems) {
-		/* shift the items */
-		memmove_extent_buffer(leaf, btrfs_item_nr_offset(leaf, slot + 1),
-			      btrfs_item_nr_offset(leaf, slot),
-			      (nritems - slot) * sizeof(struct btrfs_item));
-
-	}
-
-	btrfs_cpu_key_to_disk(&disk_key, new_key);
-	btrfs_set_item_key(leaf, &disk_key, slot);
-
-	btrfs_set_item_offset(leaf, slot, orig_offset);
-	btrfs_set_item_size(leaf, slot, item_size - split_offset);
-
-	btrfs_set_item_offset(leaf, path->slots[0],
-				 orig_offset + item_size - split_offset);
-	btrfs_set_item_size(leaf, path->slots[0], split_offset);
-
-	btrfs_set_header_nritems(leaf, nritems + 1);
-
-	/* write the data for the start of the original item */
-	write_extent_buffer(leaf, buf,
-			    btrfs_item_ptr_offset(leaf, path->slots[0]),
-			    split_offset);
-
-	/* write the data for the new item */
-	write_extent_buffer(leaf, buf + split_offset,
-			    btrfs_item_ptr_offset(leaf, slot),
-			    item_size - split_offset);
-	btrfs_mark_buffer_dirty(leaf);
-
-	ret = 0;
-	if (btrfs_leaf_free_space(leaf) < 0) {
-		btrfs_print_leaf(leaf);
-		BUG();
-	}
-	kfree(buf);
+	ret = split_item(path, new_key, split_offset);
 	return ret;
 }
 
+/*
+ * make the item pointed to by the path smaller.  new_size indicates
+ * how small to make it, and from_end tells us if we just chop bytes
+ * off the end of the item or if we shift the item to chop bytes off
+ * the front.
+ */
 void btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end)
 {
 	int slot;
@@ -2425,6 +4097,7 @@ void btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end)
 	unsigned int old_size;
 	unsigned int size_diff;
 	int i;
+	struct btrfs_map_token token;
 
 	leaf = path->nodes[0];
 	slot = path->slots[0];
@@ -2447,17 +4120,18 @@ void btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end)
 	 * item0..itemN ... dataN.offset..dataN.size .. data0.size
 	 */
 	/* first correct the data pointers */
+	btrfs_init_map_token(&token, leaf);
 	for (i = slot; i < nritems; i++) {
 		u32 ioff;
-		ioff = btrfs_item_offset(leaf, i);
-		btrfs_set_item_offset(leaf, i, ioff + size_diff);
+
+		ioff = btrfs_token_item_offset(&token, i);
+		btrfs_set_token_item_offset(&token, i, ioff + size_diff);
 	}
 
 	/* shift the data */
 	if (from_end) {
-		memmove_extent_buffer(leaf, btrfs_item_nr_offset(leaf, 0) +
-			      data_end + size_diff, btrfs_item_nr_offset(leaf, 0) +
-			      data_end, old_data_start + new_size - data_end);
+		memmove_leaf_data(leaf, data_end + size_diff, data_end,
+				  old_data_start + new_size - data_end);
 	} else {
 		struct btrfs_disk_key disk_key;
 		u64 offset;
@@ -2477,15 +4151,13 @@ void btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end)
 			    BTRFS_FILE_EXTENT_INLINE) {
 				ptr = btrfs_item_ptr_offset(leaf, slot);
 				memmove_extent_buffer(leaf, ptr,
-				        (unsigned long)fi,
-				        offsetof(struct btrfs_file_extent_item,
-						 disk_bytenr));
+				      (unsigned long)fi,
+				      BTRFS_FILE_EXTENT_INLINE_DATA_START);
 			}
 		}
 
-		memmove_extent_buffer(leaf, btrfs_item_nr_offset(leaf, 0) +
-			      data_end + size_diff, btrfs_item_nr_offset(leaf, 0) +
-			      data_end, old_data_start - data_end);
+		memmove_leaf_data(leaf, data_end + size_diff, data_end,
+				  old_data_start - data_end);
 
 		offset = btrfs_disk_key_offset(&disk_key);
 		btrfs_set_disk_key_offset(&disk_key, offset + size_diff);
@@ -2503,6 +4175,9 @@ void btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end)
 	}
 }
 
+/*
+ * make the item pointed to by the path bigger, data_size is the added size.
+ */
 void btrfs_extend_item(struct btrfs_path *path, u32 data_size)
 {
 	int slot;
@@ -2512,6 +4187,7 @@ void btrfs_extend_item(struct btrfs_path *path, u32 data_size)
 	unsigned int old_data;
 	unsigned int old_size;
 	int i;
+	struct btrfs_map_token token;
 
 	leaf = path->nodes[0];
 
@@ -2528,24 +4204,26 @@ void btrfs_extend_item(struct btrfs_path *path, u32 data_size)
 	BUG_ON(slot < 0);
 	if (slot >= nritems) {
 		btrfs_print_leaf(leaf);
-		printk("slot %d too large, nritems %u\n", slot, nritems);
-		BUG_ON(1);
+		btrfs_crit(leaf->fs_info, "slot %d too large, nritems %d",
+			   slot, nritems);
+		BUG();
 	}
 
 	/*
 	 * item0..itemN ... dataN.offset..dataN.size .. data0.size
 	 */
 	/* first correct the data pointers */
+	btrfs_init_map_token(&token, leaf);
 	for (i = slot; i < nritems; i++) {
 		u32 ioff;
-		ioff = btrfs_item_offset(leaf, i);
-		btrfs_set_item_offset(leaf, i, ioff - data_size);
+
+		ioff = btrfs_token_item_offset(&token, i);
+		btrfs_set_token_item_offset(&token, i, ioff - data_size);
 	}
 
 	/* shift the data */
-	memmove_extent_buffer(leaf, btrfs_item_nr_offset(leaf, 0) +
-		      data_end - data_size, btrfs_item_nr_offset(leaf, 0) +
-		      data_end, old_data - data_end);
+	memmove_leaf_data(leaf, data_end - data_size, data_end,
+			  old_data - data_end);
 
 	data_end = old_data;
 	old_size = btrfs_item_size(leaf, slot);
@@ -2559,59 +4237,63 @@ void btrfs_extend_item(struct btrfs_path *path, u32 data_size)
 }
 
 /*
- * Given a key and some data, insert an item into the tree.
- * This does all the path init required, making room in the tree if needed.
+ * Make space in the node before inserting one or more items.
+ *
+ * @root:	root we are inserting items to
+ * @path:	points to the leaf/slot where we are going to insert new items
+ * @batch:      information about the batch of items to insert
+ *
+ * Main purpose is to save stack depth by doing the bulk of the work in a
+ * function that doesn't call btrfs_search_slot
  */
-int btrfs_insert_empty_items(struct btrfs_trans_handle *trans,
-			    struct btrfs_root *root,
-			    struct btrfs_path *path,
-			    const struct btrfs_item_batch *batch)
+static void setup_items_for_insert(struct btrfs_root *root, struct btrfs_path *path,
+				   const struct btrfs_item_batch *batch)
 {
-	struct extent_buffer *leaf;
-	int ret = 0;
-	int slot;
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	int i;
 	u32 nritems;
-	u32 total_size = 0;
 	unsigned int data_end;
 	struct btrfs_disk_key disk_key;
+	struct extent_buffer *leaf;
+	int slot;
+	struct btrfs_map_token token;
+	u32 total_size;
 
-	/* create a root if there isn't one */
-	if (!root->node)
-		BUG();
-
-	total_size = batch->total_data_size +
-		(batch->nr * sizeof(struct btrfs_item));
-	ret = btrfs_search_slot(trans, root, &batch->keys[0], path, total_size, 1);
-	if (ret == 0) {
-		return -EEXIST;
+	/*
+	 * Before anything else, update keys in the parent and other ancestors
+	 * if needed, then release the write locks on them, so that other tasks
+	 * can use them while we modify the leaf.
+	 */
+	if (path->slots[0] == 0) {
+		btrfs_cpu_key_to_disk(&disk_key, &batch->keys[0]);
+		fixup_low_keys(path, &disk_key, 1);
 	}
-	if (ret < 0)
-		goto out;
+	btrfs_unlock_up_safe(path, 1);
 
 	leaf = path->nodes[0];
+	slot = path->slots[0];
 
 	nritems = btrfs_header_nritems(leaf);
 	data_end = leaf_data_end(leaf);
+	total_size = batch->total_data_size + (batch->nr * sizeof(struct btrfs_item));
 
 	if (btrfs_leaf_free_space(leaf) < total_size) {
 		btrfs_print_leaf(leaf);
-		printk("not enough freespace need %u have %d\n",
-		       total_size, btrfs_leaf_free_space(leaf));
+		btrfs_crit(fs_info, "not enough freespace need %u have %d",
+			   total_size, btrfs_leaf_free_space(leaf));
 		BUG();
 	}
 
-	slot = path->slots[0];
-	BUG_ON(slot < 0);
-
-	if (slot < nritems) {
+	btrfs_init_map_token(&token, leaf);
+	if (slot != nritems) {
 		unsigned int old_data = btrfs_item_data_end(leaf, slot);
 
 		if (old_data < data_end) {
 			btrfs_print_leaf(leaf);
-			printk("slot %d old_data %u data_end %u\n",
-			       slot, old_data, data_end);
-			BUG_ON(1);
+			btrfs_crit(fs_info,
+		"item at slot %d with data offset %u beyond data end of leaf %u",
+				   slot, old_data, data_end);
+			BUG();
 		}
 		/*
 		 * item0..itemN ... dataN.offset..dataN.size .. data0.size
@@ -2620,22 +4302,16 @@ int btrfs_insert_empty_items(struct btrfs_trans_handle *trans,
 		for (i = slot; i < nritems; i++) {
 			u32 ioff;
 
-			ioff = btrfs_item_offset(leaf, i);
-			btrfs_set_item_offset(leaf, i,
-					      ioff - batch->total_data_size);
+			ioff = btrfs_token_item_offset(&token, i);
+			btrfs_set_token_item_offset(&token, i,
+						       ioff - batch->total_data_size);
 		}
-
 		/* shift the items */
-		memmove_extent_buffer(leaf,
-			      btrfs_item_nr_offset(leaf, slot + batch->nr),
-			      btrfs_item_nr_offset(leaf, slot),
-			      (nritems - slot) * sizeof(struct btrfs_item));
+		memmove_leaf_items(leaf, slot + batch->nr, slot, nritems - slot);
 
 		/* shift the data */
-		memmove_extent_buffer(leaf, btrfs_item_nr_offset(leaf, 0) +
-			      data_end - batch->total_data_size,
-			      btrfs_item_nr_offset(leaf, 0) +
-			      data_end, old_data - data_end);
+		memmove_leaf_data(leaf, data_end - batch->total_data_size,
+				  data_end, old_data - data_end);
 		data_end = old_data;
 	}
 
@@ -2644,34 +4320,76 @@ int btrfs_insert_empty_items(struct btrfs_trans_handle *trans,
 		btrfs_cpu_key_to_disk(&disk_key, &batch->keys[i]);
 		btrfs_set_item_key(leaf, &disk_key, slot + i);
 		data_end -= batch->data_sizes[i];
-		btrfs_set_item_offset(leaf, slot + i, data_end);
-		btrfs_set_item_size(leaf, slot + i, batch->data_sizes[i]);
+		btrfs_set_token_item_offset(&token, slot + i, data_end);
+		btrfs_set_token_item_size(&token, slot + i, batch->data_sizes[i]);
 	}
+
 	btrfs_set_header_nritems(leaf, nritems + batch->nr);
 	btrfs_mark_buffer_dirty(leaf);
 
-	ret = 0;
-	if (slot == 0) {
-		btrfs_cpu_key_to_disk(&disk_key, &batch->keys[0]);
-		fixup_low_keys(path, &disk_key, 1);
-	}
-
 	if (btrfs_leaf_free_space(leaf) < 0) {
 		btrfs_print_leaf(leaf);
 		BUG();
 	}
+}
 
-out:
-	return ret;
+/*
+ * Insert a new item into a leaf.
+ *
+ * @root:      The root of the btree.
+ * @path:      A path pointing to the target leaf and slot.
+ * @key:       The key of the new item.
+ * @data_size: The size of the data associated with the new key.
+ */
+void btrfs_setup_item_for_insert(struct btrfs_root *root,
+				 struct btrfs_path *path,
+				 const struct btrfs_key *key,
+				 u32 data_size)
+{
+	struct btrfs_item_batch batch;
+
+	batch.keys = key;
+	batch.data_sizes = &data_size;
+	batch.total_data_size = data_size;
+	batch.nr = 1;
+
+	setup_items_for_insert(root, path, &batch);
+}
+
+/*
+ * Given a key and some data, insert items into the tree.
+ * This does all the path init required, making room in the tree if needed.
+ */
+int btrfs_insert_empty_items(struct btrfs_trans_handle *trans,
+			    struct btrfs_root *root,
+			    struct btrfs_path *path,
+			    const struct btrfs_item_batch *batch)
+{
+	int ret = 0;
+	int slot;
+	u32 total_size;
+
+	total_size = batch->total_data_size + (batch->nr * sizeof(struct btrfs_item));
+	ret = btrfs_search_slot(trans, root, &batch->keys[0], path, total_size, 1);
+	if (ret == 0)
+		return -EEXIST;
+	if (ret < 0)
+		return ret;
+
+	slot = path->slots[0];
+	BUG_ON(slot < 0);
+
+	setup_items_for_insert(root, path, batch);
+	return 0;
 }
 
 /*
  * Given a key and some data, insert an item into the tree.
  * This does all the path init required, making room in the tree if needed.
  */
-int btrfs_insert_item(struct btrfs_trans_handle *trans,
-		      struct btrfs_root *root, const struct btrfs_key *cpu_key,
-		      void *data, u32 data_size)
+int btrfs_insert_item(struct btrfs_trans_handle *trans, struct btrfs_root *root,
+		      const struct btrfs_key *cpu_key, void *data,
+		      u32 data_size)
 {
 	int ret = 0;
 	struct btrfs_path *path;
@@ -2681,7 +4399,6 @@ int btrfs_insert_item(struct btrfs_trans_handle *trans,
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
-
 	ret = btrfs_insert_empty_item(trans, root, path, cpu_key, data_size);
 	if (!ret) {
 		leaf = path->nodes[0];
@@ -2693,28 +4410,79 @@ int btrfs_insert_item(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
+/*
+ * This function duplicates an item, giving 'new_key' to the new item.
+ * It guarantees both items live in the same tree leaf and the new item is
+ * contiguous with the original item.
+ *
+ * This allows us to split a file extent in place, keeping a lock on the leaf
+ * the entire time.
+ */
+int btrfs_duplicate_item(struct btrfs_trans_handle *trans,
+			 struct btrfs_root *root,
+			 struct btrfs_path *path,
+			 const struct btrfs_key *new_key)
+{
+	struct extent_buffer *leaf;
+	int ret;
+	u32 item_size;
+
+	leaf = path->nodes[0];
+	item_size = btrfs_item_size(leaf, path->slots[0]);
+	ret = setup_leaf_for_split(trans, root, path,
+				   item_size + sizeof(struct btrfs_item));
+	if (ret)
+		return ret;
+
+	path->slots[0]++;
+	btrfs_setup_item_for_insert(root, path, new_key, item_size);
+	leaf = path->nodes[0];
+	memcpy_extent_buffer(leaf,
+			     btrfs_item_ptr_offset(leaf, path->slots[0]),
+			     btrfs_item_ptr_offset(leaf, path->slots[0] - 1),
+			     item_size);
+	return 0;
+}
+
 /*
  * delete the pointer from a given node.
  *
- * If the delete empties a node, the node is removed from the tree,
- * continuing all the way the root if required.  The root is converted into
- * a leaf if all the nodes are emptied.
+ * the tree should have been previously balanced so the deletion does not
+ * empty a node.
+ *
+ * This is exported for use inside btrfs-progs, don't un-export it.
  */
 int btrfs_del_ptr(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		  struct btrfs_path *path, int level, int slot)
 {
 	struct extent_buffer *parent = path->nodes[level];
 	u32 nritems;
+	int ret;
 
 	nritems = btrfs_header_nritems(parent);
-	if (slot < nritems - 1) {
-		/* shift the items */
+	if (slot != nritems - 1) {
+		if (level) {
+			ret = btrfs_tree_mod_log_insert_move(parent, slot,
+					slot + 1, nritems - slot - 1);
+			if (ret < 0) {
+				btrfs_abort_transaction(trans, ret);
+				return ret;
+			}
+		}
 		memmove_extent_buffer(parent,
 			      btrfs_node_key_ptr_offset(parent, slot),
 			      btrfs_node_key_ptr_offset(parent, slot + 1),
 			      sizeof(struct btrfs_key_ptr) *
 			      (nritems - slot - 1));
+	} else if (level) {
+		ret = btrfs_tree_mod_log_insert_key(parent, slot,
+						    BTRFS_MOD_LOG_KEY_REMOVE);
+		if (ret < 0) {
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
 	}
+
 	nritems--;
 	btrfs_set_header_nritems(parent, nritems);
 	if (nritems == 0 && parent == root->node) {
@@ -2728,7 +4496,6 @@ int btrfs_del_ptr(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		fixup_low_keys(path, &disk_key, level + 1);
 	}
 	btrfs_mark_buffer_dirty(parent);
-
 	return 0;
 }
 
@@ -2750,15 +4517,23 @@ static noinline int btrfs_del_leaf(struct btrfs_trans_handle *trans,
 	int ret;
 
 	WARN_ON(btrfs_header_generation(leaf) != trans->transid);
-	btrfs_del_ptr(trans, root, path, 1, path->slots[1]);
+	ret = btrfs_del_ptr(trans, root, path, 1, path->slots[1]);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * btrfs_free_extent is expensive, we want to make sure we
+	 * aren't holding any locks when we call it
+	 */
+	btrfs_unlock_up_safe(path, 0);
 
 	root_sub_used(root, leaf->len);
 
-	ret = btrfs_free_extent(trans, leaf->start, leaf->len, 0,
-				root->root_key.objectid, 0, 0);
-	return ret;
+	atomic_inc(&leaf->refs);
+	btrfs_free_tree_block(trans, btrfs_root_id(root), leaf, 0, 1);
+	free_extent_buffer_stale(leaf);
+	return 0;
 }
-
 /*
  * delete the item at the leaf level in path.  If that empties
  * the leaf, remove it from the tree
@@ -2766,41 +4541,37 @@ static noinline int btrfs_del_leaf(struct btrfs_trans_handle *trans,
 int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		    struct btrfs_path *path, int slot, int nr)
 {
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct extent_buffer *leaf;
-	int last_off;
-	int dsize = 0;
 	int ret = 0;
 	int wret;
-	int i;
 	u32 nritems;
 
 	leaf = path->nodes[0];
-	last_off = btrfs_item_offset(leaf, slot + nr - 1);
-
-	for (i = 0; i < nr; i++)
-		dsize += btrfs_item_size(leaf, slot + i);
-
 	nritems = btrfs_header_nritems(leaf);
 
 	if (slot + nr != nritems) {
-		int data_end = leaf_data_end(leaf);
+		const u32 last_off = btrfs_item_offset(leaf, slot + nr - 1);
+		const int data_end = leaf_data_end(leaf);
+		struct btrfs_map_token token;
+		u32 dsize = 0;
+		int i;
 
-		memmove_extent_buffer(leaf, btrfs_item_nr_offset(leaf, 0) +
-			      data_end + dsize,
-			      btrfs_item_nr_offset(leaf, 0) + data_end,
-			      last_off - data_end);
+		for (i = 0; i < nr; i++)
+			dsize += btrfs_item_size(leaf, slot + i);
 
+		memmove_leaf_data(leaf, data_end + dsize, data_end,
+				  last_off - data_end);
+
+		btrfs_init_map_token(&token, leaf);
 		for (i = slot + nr; i < nritems; i++) {
 			u32 ioff;
 
-			ioff = btrfs_item_offset(leaf, i);
-			btrfs_set_item_offset(leaf, i, ioff + dsize);
+			ioff = btrfs_token_item_offset(&token, i);
+			btrfs_set_token_item_offset(&token, i, ioff + dsize);
 		}
 
-		memmove_extent_buffer(leaf, btrfs_item_nr_offset(leaf, slot),
-			      btrfs_item_nr_offset(leaf, slot + nr),
-			      sizeof(struct btrfs_item) *
-			      (nritems - slot - nr));
+		memmove_leaf_items(leaf, slot, slot + nr, nritems - slot - nr);
 	}
 	btrfs_set_header_nritems(leaf, nritems - nr);
 	nritems -= nr;
@@ -2811,10 +4582,9 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 			btrfs_set_header_level(leaf, 0);
 		} else {
 			btrfs_clear_buffer_dirty(trans, leaf);
-			wret = btrfs_del_leaf(trans, root, path, leaf);
-			BUG_ON(ret);
-			if (wret)
-				ret = wret;
+			ret = btrfs_del_leaf(trans, root, path, leaf);
+			if (ret < 0)
+				return ret;
 		}
 	} else {
 		int used = leaf_space_used(leaf, 0, nritems);
@@ -2825,35 +4595,69 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 			fixup_low_keys(path, &disk_key, 1);
 		}
 
-		/* delete the leaf if it is mostly empty */
-		if (used < BTRFS_LEAF_DATA_SIZE(root->fs_info) / 4) {
+		/*
+		 * Try to delete the leaf if it is mostly empty. We do this by
+		 * trying to move all its items into its left and right neighbours.
+		 * If we can't move all the items, then we don't delete it - it's
+		 * not ideal, but future insertions might fill the leaf with more
+		 * items, or items from other leaves might be moved later into our
+		 * leaf due to deletions on those leaves.
+		 */
+		if (used < BTRFS_LEAF_DATA_SIZE(fs_info) / 3) {
+			u32 min_push_space;
+
 			/* push_leaf_left fixes the path.
 			 * make sure the path still points to our leaf
-			 * for possible call to del_ptr below
+			 * for possible call to btrfs_del_ptr below
 			 */
 			slot = path->slots[1];
-			extent_buffer_get(leaf);
-
-			wret = push_leaf_left(trans, root, path, 1, 1);
+			atomic_inc(&leaf->refs);
+			/*
+			 * We want to be able to at least push one item to the
+			 * left neighbour leaf, and that's the first item.
+			 */
+			min_push_space = sizeof(struct btrfs_item) +
+				btrfs_item_size(leaf, 0);
+			wret = push_leaf_left(trans, root, path, 0,
+					      min_push_space, 1, (u32)-1);
 			if (wret < 0 && wret != -ENOSPC)
 				ret = wret;
 
 			if (path->nodes[0] == leaf &&
 			    btrfs_header_nritems(leaf)) {
-				wret = push_leaf_right(trans, root, path, 1, 1);
+				/*
+				 * If we were not able to push all items from our
+				 * leaf to its left neighbour, then attempt to
+				 * either push all the remaining items to the
+				 * right neighbour or none. There's no advantage
+				 * in pushing only some items, instead of all, as
+				 * it's pointless to end up with a leaf having
+				 * too few items while the neighbours can be full
+				 * or nearly full.
+				 */
+				nritems = btrfs_header_nritems(leaf);
+				min_push_space = leaf_space_used(leaf, 0, nritems);
+				wret = push_leaf_right(trans, root, path, 0,
+						       min_push_space, 1, 0);
 				if (wret < 0 && wret != -ENOSPC)
 					ret = wret;
 			}
 
 			if (btrfs_header_nritems(leaf) == 0) {
-				btrfs_clear_buffer_dirty(trans, leaf);
 				path->slots[1] = slot;
 				ret = btrfs_del_leaf(trans, root, path, leaf);
-				BUG_ON(ret);
+				if (ret < 0)
+					return ret;
 				free_extent_buffer(leaf);
-
+				ret = 0;
 			} else {
-				btrfs_mark_buffer_dirty(leaf);
+				/* if we're still in the path, make sure
+				 * we're dirty.  Otherwise, one of the
+				 * push_leaf functions must have already
+				 * dirtied this buffer
+				 */
+				if (path->nodes[0] == leaf)
+					btrfs_mark_buffer_dirty(leaf);
 				free_extent_buffer(leaf);
 			}
 		} else {
@@ -2864,124 +4668,419 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 }
 
 /*
- * walk up the tree as far as required to find the previous leaf.
- * returns 0 if it found something or 1 if there are no lesser leaves.
- * returns < 0 on io errors.
+ * A helper function to walk down the tree starting at min_key, and looking
+ * for nodes or leaves that are have a minimum transaction id.
+ * This is used by the btree defrag code, and tree logging
+ *
+ * This does not cow, but it does stuff the starting key it finds back
+ * into min_key, so you can call btrfs_search_slot with cow=1 on the
+ * key and get a writable path.
+ *
+ * This honors path->lowest_level to prevent descent past a given level
+ * of the tree.
+ *
+ * min_trans indicates the oldest transaction that you are interested
+ * in walking through.  Any nodes or leaves older than min_trans are
+ * skipped over (without reading them).
+ *
+ * returns zero if something useful was found, < 0 on error and 1 if there
+ * was nothing in the tree that matched the search criteria.
  */
-int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *path)
+int btrfs_search_forward(struct btrfs_root *root, struct btrfs_key *min_key,
+			 struct btrfs_path *path,
+			 u64 min_trans)
 {
+	struct extent_buffer *cur;
+	struct btrfs_key found_key;
 	int slot;
-	int level = 1;
-	struct extent_buffer *c;
-	struct extent_buffer *next = NULL;
+	int sret;
+	u32 nritems;
+	int level;
+	int ret = 1;
+	int keep_locks = path->keep_locks;
 
-	while(level < BTRFS_MAX_LEVEL) {
-		if (!path->nodes[level])
-			return 1;
+	ASSERT(!path->nowait);
+	path->keep_locks = 1;
+again:
+	cur = btrfs_read_lock_root_node(root);
+	level = btrfs_header_level(cur);
+	WARN_ON(path->nodes[level]);
+	path->nodes[level] = cur;
+	path->locks[level] = BTRFS_READ_LOCK;
 
-		slot = path->slots[level];
-		c = path->nodes[level];
-		if (slot == 0) {
-			level++;
-			if (level == BTRFS_MAX_LEVEL)
-				return 1;
-			continue;
-		}
-		slot--;
-
-		next = btrfs_read_node_slot(c, slot);
-		if (!extent_buffer_uptodate(next)) {
-			if (IS_ERR(next))
-				return PTR_ERR(next);
-			return -EIO;
-		}
-		break;
+	if (btrfs_header_generation(cur) < min_trans) {
+		ret = 1;
+		goto out;
 	}
-	path->slots[level] = slot;
-	while(1) {
-		level--;
-		c = path->nodes[level];
-		free_extent_buffer(c);
-		slot = btrfs_header_nritems(next);
-		if (slot != 0)
+	while (1) {
+		nritems = btrfs_header_nritems(cur);
+		level = btrfs_header_level(cur);
+		sret = btrfs_bin_search(cur, 0, min_key, &slot);
+		if (sret < 0) {
+			ret = sret;
+			goto out;
+		}
+
+		/* at the lowest level, we're done, setup the path and exit */
+		if (level == path->lowest_level) {
+			if (slot >= nritems)
+				goto find_next_key;
+			ret = 0;
+			path->slots[level] = slot;
+			btrfs_item_key_to_cpu(cur, &found_key, slot);
+			goto out;
+		}
+		if (sret && slot > 0)
 			slot--;
-		path->nodes[level] = next;
-		path->slots[level] = slot;
-		if (!level)
+		/*
+		 * check this node pointer against the min_trans parameters.
+		 * If it is too old, skip to the next one.
+		 */
+		while (slot < nritems) {
+			u64 gen;
+
+			gen = btrfs_node_ptr_generation(cur, slot);
+			if (gen < min_trans) {
+				slot++;
+				continue;
+			}
 			break;
-		next = btrfs_read_node_slot(next, slot);
-		if (!extent_buffer_uptodate(next)) {
-			if (IS_ERR(next))
-				return PTR_ERR(next);
-			return -EIO;
 		}
+find_next_key:
+		/*
+		 * we didn't find a candidate key in this node, walk forward
+		 * and find another one
+		 */
+		if (slot >= nritems) {
+			path->slots[level] = slot;
+			sret = btrfs_find_next_key(root, path, min_key, level,
+						  min_trans);
+			if (sret == 0) {
+				btrfs_release_path(path);
+				goto again;
+			} else {
+				goto out;
+			}
+		}
+		/* save our key for returning back */
+		btrfs_node_key_to_cpu(cur, &found_key, slot);
+		path->slots[level] = slot;
+		if (level == path->lowest_level) {
+			ret = 0;
+			goto out;
+		}
+		cur = btrfs_read_node_slot(cur, slot);
+		if (IS_ERR(cur)) {
+			ret = PTR_ERR(cur);
+			goto out;
+		}
+
+		btrfs_tree_read_lock(cur);
+
+		path->locks[level - 1] = BTRFS_READ_LOCK;
+		path->nodes[level - 1] = cur;
+		unlock_up(path, level, 1, 0, NULL);
 	}
-	return 0;
+out:
+	path->keep_locks = keep_locks;
+	if (ret == 0) {
+		btrfs_unlock_up_safe(path, path->lowest_level + 1);
+		memcpy(min_key, &found_key, sizeof(found_key));
+	}
+	return ret;
 }
 
 /*
- * Walk up the tree as far as necessary to find the next sibling tree block.
- * More generic version of btrfs_next_leaf(), as it could find sibling nodes
- * if @path->lowest_level is not 0.
+ * this is similar to btrfs_next_leaf, but does not try to preserve
+ * and fixup the path.  It looks for and returns the next key in the
+ * tree based on the current path and the min_trans parameters.
  *
- * returns 0 if it found something or 1 if there are no greater leaves.
- * returns < 0 on io errors.
+ * 0 is returned if another key is found, < 0 if there are any errors
+ * and 1 is returned if there are no higher keys in the tree
+ *
+ * path->keep_locks should be set to 1 on the search made before
+ * calling this function.
  */
-int btrfs_next_sibling_tree_block(struct btrfs_fs_info *fs_info,
-				  struct btrfs_path *path)
+int btrfs_find_next_key(struct btrfs_root *root, struct btrfs_path *path,
+			struct btrfs_key *key, int level, u64 min_trans)
 {
 	int slot;
-	int level = path->lowest_level + 1;
 	struct extent_buffer *c;
-	struct extent_buffer *next = NULL;
 
-	BUG_ON(path->lowest_level + 1 >= BTRFS_MAX_LEVEL);
-	do {
+	WARN_ON(!path->keep_locks && !path->skip_locking);
+	while (level < BTRFS_MAX_LEVEL) {
 		if (!path->nodes[level])
 			return 1;
 
+		slot = path->slots[level] + 1;
+		c = path->nodes[level];
+next:
+		if (slot >= btrfs_header_nritems(c)) {
+			int ret;
+			int orig_lowest;
+			struct btrfs_key cur_key;
+			if (level + 1 >= BTRFS_MAX_LEVEL ||
+			    !path->nodes[level + 1])
+				return 1;
+
+			if (path->locks[level + 1] || path->skip_locking) {
+				level++;
+				continue;
+			}
+
+			slot = btrfs_header_nritems(c) - 1;
+			if (level == 0)
+				btrfs_item_key_to_cpu(c, &cur_key, slot);
+			else
+				btrfs_node_key_to_cpu(c, &cur_key, slot);
+
+			orig_lowest = path->lowest_level;
+			btrfs_release_path(path);
+			path->lowest_level = level;
+			ret = btrfs_search_slot(NULL, root, &cur_key, path,
+						0, 0);
+			path->lowest_level = orig_lowest;
+			if (ret < 0)
+				return ret;
+
+			c = path->nodes[level];
+			slot = path->slots[level];
+			if (ret == 0)
+				slot++;
+			goto next;
+		}
+
+		if (level == 0)
+			btrfs_item_key_to_cpu(c, key, slot);
+		else {
+			u64 gen = btrfs_node_ptr_generation(c, slot);
+
+			if (gen < min_trans) {
+				slot++;
+				goto next;
+			}
+			btrfs_node_key_to_cpu(c, key, slot);
+		}
+		return 0;
+	}
+	return 1;
+}
+
+int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
+			u64 time_seq)
+{
+	int slot;
+	int level;
+	struct extent_buffer *c;
+	struct extent_buffer *next;
+	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct btrfs_key key;
+	bool need_commit_sem = false;
+	u32 nritems;
+	int ret;
+	int i;
+
+	/*
+	 * The nowait semantics are used only for write paths, where we don't
+	 * use the tree mod log and sequence numbers.
+	 */
+	if (time_seq)
+		ASSERT(!path->nowait);
+
+	nritems = btrfs_header_nritems(path->nodes[0]);
+	if (nritems == 0)
+		return 1;
+
+	btrfs_item_key_to_cpu(path->nodes[0], &key, nritems - 1);
+again:
+	level = 1;
+	next = NULL;
+	btrfs_release_path(path);
+
+	path->keep_locks = 1;
+
+	if (time_seq) {
+		ret = btrfs_search_old_slot(root, &key, path, time_seq);
+	} else {
+		if (path->need_commit_sem) {
+			path->need_commit_sem = 0;
+			need_commit_sem = true;
+			if (path->nowait) {
+				if (!down_read_trylock(&fs_info->commit_root_sem)) {
+					ret = -EAGAIN;
+					goto done;
+				}
+			} else {
+				down_read(&fs_info->commit_root_sem);
+			}
+		}
+		ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+	}
+	path->keep_locks = 0;
+
+	if (ret < 0)
+		goto done;
+
+	nritems = btrfs_header_nritems(path->nodes[0]);
+	/*
+	 * by releasing the path above we dropped all our locks.  A balance
+	 * could have added more items next to the key that used to be
+	 * at the very end of the block.  So, check again here and
+	 * advance the path if there are now more items available.
+	 */
+	if (nritems > 0 && path->slots[0] < nritems - 1) {
+		if (ret == 0)
+			path->slots[0]++;
+		ret = 0;
+		goto done;
+	}
+	/*
+	 * So the above check misses one case:
+	 * - after releasing the path above, someone has removed the item that
+	 *   used to be at the very end of the block, and balance between leafs
+	 *   gets another one with bigger key.offset to replace it.
+	 *
+	 * This one should be returned as well, or we can get leaf corruption
+	 * later(esp. in __btrfs_drop_extents()).
+	 *
+	 * And a bit more explanation about this check,
+	 * with ret > 0, the key isn't found, the path points to the slot
+	 * where it should be inserted, so the path->slots[0] item must be the
+	 * bigger one.
+	 */
+	if (nritems > 0 && ret > 0 && path->slots[0] == nritems - 1) {
+		ret = 0;
+		goto done;
+	}
+
+	while (level < BTRFS_MAX_LEVEL) {
+		if (!path->nodes[level]) {
+			ret = 1;
+			goto done;
+		}
+
 		slot = path->slots[level] + 1;
 		c = path->nodes[level];
 		if (slot >= btrfs_header_nritems(c)) {
 			level++;
-			if (level == BTRFS_MAX_LEVEL)
-				return 1;
+			if (level == BTRFS_MAX_LEVEL) {
+				ret = 1;
+				goto done;
+			}
 			continue;
 		}
 
-		if (path->reada)
-			reada_for_search(fs_info, path, level, slot, 0);
 
-		next = btrfs_read_node_slot(c, slot);
-		if (!extent_buffer_uptodate(next))
-			return -EIO;
+		/*
+		 * Our current level is where we're going to start from, and to
+		 * make sure lockdep doesn't complain we need to drop our locks
+		 * and nodes from 0 to our current level.
+		 */
+		for (i = 0; i < level; i++) {
+			if (path->locks[level]) {
+				btrfs_tree_read_unlock(path->nodes[i]);
+				path->locks[i] = 0;
+			}
+			free_extent_buffer(path->nodes[i]);
+			path->nodes[i] = NULL;
+		}
+
+		next = c;
+		ret = read_block_for_search(root, path, &next, level,
+					    slot, &key);
+		if (ret == -EAGAIN && !path->nowait)
+			goto again;
+
+		if (ret < 0) {
+			btrfs_release_path(path);
+			goto done;
+		}
+
+		if (!path->skip_locking) {
+			ret = btrfs_try_tree_read_lock(next);
+			if (!ret && path->nowait) {
+				ret = -EAGAIN;
+				goto done;
+			}
+			if (!ret && time_seq) {
+				/*
+				 * If we don't get the lock, we may be racing
+				 * with push_leaf_left, holding that lock while
+				 * itself waiting for the leaf we've currently
+				 * locked. To solve this situation, we give up
+				 * on our lock and cycle.
+				 */
+				free_extent_buffer(next);
+				btrfs_release_path(path);
+				cond_resched();
+				goto again;
+			}
+			if (!ret)
+				btrfs_tree_read_lock(next);
+		}
 		break;
-	} while (level < BTRFS_MAX_LEVEL);
+	}
 	path->slots[level] = slot;
-	while(1) {
+	while (1) {
 		level--;
-		c = path->nodes[level];
-		free_extent_buffer(c);
 		path->nodes[level] = next;
 		path->slots[level] = 0;
-		/*
-		 * Fsck will happily load corrupt blocks in order to fix them,
-		 * so we need an extra check just to make sure this block isn't
-		 * marked uptodate but invalid.
-		 */
-		if (check_block(fs_info, path, level))
-			return -EIO;
-		if (level == path->lowest_level)
+		if (!path->skip_locking)
+			path->locks[level] = BTRFS_READ_LOCK;
+		if (!level)
 			break;
-		if (path->reada)
-			reada_for_search(fs_info, path, level, 0, 0);
-		next = btrfs_read_node_slot(next, 0);
-		if (!extent_buffer_uptodate(next))
-			return -EIO;
+
+		ret = read_block_for_search(root, path, &next, level,
+					    0, &key);
+		if (ret == -EAGAIN && !path->nowait)
+			goto again;
+
+		if (ret < 0) {
+			btrfs_release_path(path);
+			goto done;
+		}
+
+		if (!path->skip_locking) {
+			if (path->nowait) {
+				if (!btrfs_try_tree_read_lock(next)) {
+					ret = -EAGAIN;
+					goto done;
+				}
+			} else {
+				btrfs_tree_read_lock(next);
+			}
+		}
 	}
+	ret = 0;
+done:
+	unlock_up(path, 0, 1, 0, NULL);
+	if (need_commit_sem) {
+		int ret2;
+
+		path->need_commit_sem = 1;
+		ret2 = finish_need_commit_sem_search(path);
+		up_read(&fs_info->commit_root_sem);
+		if (ret2)
+			ret = ret2;
+	}
+
+	return ret;
+}
+
+int btrfs_next_old_item(struct btrfs_root *root, struct btrfs_path *path, u64 time_seq)
+{
+	path->slots[0]++;
+	if (path->slots[0] >= btrfs_header_nritems(path->nodes[0]))
+		return btrfs_next_old_leaf(root, path, time_seq);
 	return 0;
 }
 
+/*
+ * this uses btrfs_prev_leaf to walk backwards in the tree, and keeps
+ * searching until it gets past min_objectid or finds an item of 'type'
+ *
+ * returns 0 if something is found, 1 if nothing was found and < 0 on error
+ */
 int btrfs_previous_item(struct btrfs_root *root,
 			struct btrfs_path *path, u64 min_objectid,
 			int type)
@@ -2991,7 +5090,7 @@ int btrfs_previous_item(struct btrfs_root *root,
 	u32 nritems;
 	int ret;
 
-	while(1) {
+	while (1) {
 		if (path->slots[0] == 0) {
 			ret = btrfs_prev_leaf(root, path);
 			if (ret != 0)
@@ -3020,7 +5119,7 @@ int btrfs_previous_item(struct btrfs_root *root,
 
 /*
  * search in extent tree to find a previous Metadata/Data extent item with
- * min objectid.
+ * min objecitd.
  *
  * returns 0 if something is found, 1 if nothing was found and < 0 on error
  */
@@ -3059,3 +5158,18 @@ int btrfs_previous_extent_item(struct btrfs_root *root,
 	}
 	return 1;
 }
+
+int __init btrfs_ctree_init(void)
+{
+	btrfs_path_cachep = kmem_cache_create("btrfs_path",
+			sizeof(struct btrfs_path), 0,
+			SLAB_MEM_SPREAD, NULL);
+	if (!btrfs_path_cachep)
+		return -ENOMEM;
+	return 0;
+}
+
+void __cold btrfs_ctree_exit(void)
+{
+	kmem_cache_destroy(btrfs_path_cachep);
+}
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index fbdf3aef..a0a85d92 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1057,8 +1057,9 @@ static inline int btrfs_insert_empty_item(struct btrfs_trans_handle *trans,
 	return btrfs_insert_empty_items(trans, root, path, &batch);
 }
 
-int btrfs_next_sibling_tree_block(struct btrfs_fs_info *fs_info,
-				  struct btrfs_path *path);
+int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
+			u64 time_seq);
+int btrfs_next_old_item(struct btrfs_root *root, struct btrfs_path *path, u64 time_seq);
 
 /*
  * Walk up the tree as far as necessary to find the next leaf.
@@ -1069,33 +1070,48 @@ int btrfs_next_sibling_tree_block(struct btrfs_fs_info *fs_info,
 static inline int btrfs_next_leaf(struct btrfs_root *root,
 				  struct btrfs_path *path)
 {
-	path->lowest_level = 0;
-	return btrfs_next_sibling_tree_block(root->fs_info, path);
+	return btrfs_next_old_leaf(root, path, 0);
 }
 
 static inline int btrfs_next_item(struct btrfs_root *root,
 				  struct btrfs_path *p)
 {
-	++p->slots[0];
-	if (p->slots[0] >= btrfs_header_nritems(p->nodes[0])) {
-		int ret;
-		ret = btrfs_next_leaf(root, p);
-		/*
-		 * Revert the increased slot, or the path may point to
-		 * an invalid item.
-		 */
-		if (ret)
-			p->slots[0]--;
-		return ret;
-	}
-	return 0;
+	return btrfs_next_old_item(root, p, 0);
 }
 
+int btrfs_block_can_be_shared(struct btrfs_root *root,
+			      struct extent_buffer *buf);
 int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *path);
 int btrfs_leaf_free_space(const struct extent_buffer *leaf);
 void btrfs_set_item_key_safe(struct btrfs_fs_info *fs_info,
 			     struct btrfs_path *path,
 			     const struct btrfs_key *new_key);
+struct extent_buffer *btrfs_root_node(struct btrfs_root *root);
+int btrfs_realloc_node(struct btrfs_trans_handle *trans,
+		       struct btrfs_root *root, struct extent_buffer *parent,
+		       int start_slot, u64 *last_ret,
+		       struct btrfs_key *progress);
+int btrfs_search_old_slot(struct btrfs_root *root, const struct btrfs_key *key,
+			  struct btrfs_path *p, u64 time_seq);
+int btrfs_search_backwards(struct btrfs_root *root, struct btrfs_key *key,
+			   struct btrfs_path *path);
+int btrfs_get_next_valid_item(struct btrfs_root *root, struct btrfs_key *key,
+			      struct btrfs_path *path);
+void btrfs_setup_item_for_insert(struct btrfs_root *root,
+				 struct btrfs_path *path,
+				 const struct btrfs_key *key,
+				 u32 data_size);
+int btrfs_duplicate_item(struct btrfs_trans_handle *trans,
+			 struct btrfs_root *root,
+			 struct btrfs_path *path,
+			 const struct btrfs_key *new_key);
+int btrfs_search_forward(struct btrfs_root *root, struct btrfs_key *min_key,
+			 struct btrfs_path *path,
+			 u64 min_trans);
+int btrfs_find_next_key(struct btrfs_root *root, struct btrfs_path *path,
+			struct btrfs_key *key, int level, u64 min_trans);
+int __init btrfs_ctree_init(void);
+void __cold btrfs_ctree_exit(void);
 
 int btrfs_super_csum_size(const struct btrfs_super_block *sb);
 const char *btrfs_super_csum_name(u16 csum_type);
-- 
2.41.0

