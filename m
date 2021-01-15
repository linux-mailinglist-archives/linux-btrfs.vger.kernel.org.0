Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E145E2F87E6
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Jan 2021 22:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbhAOVtn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Jan 2021 16:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbhAOVtl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Jan 2021 16:49:41 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A498C0613D3
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jan 2021 13:49:01 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id bd6so4703908qvb.9
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jan 2021 13:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OumoT81qpxCDVJURrN3X61sq1dWFWgAsjgIMNuZtdvM=;
        b=F+fwibtDb2yBmdsW1OpGKF3jCR8pYfMiaEr3dDPau97le6QR84SD1t7zE0xHv/Lor1
         6O/GT/cyexc4UTEteCAxDsPjfgdHSx9uGvEJ3rA1VKYon/sj6MW5KhPFunzgiw0KYliW
         5wWdU67cav269j+QmEMsmqJMxvrBdQJhXeTpzxD8lbAzbirHlyM1WOprblIUY9lAT4XI
         Tn5vm3I5y4N0/2fry+rRiBPx/vszz1/cqbSD9wG238EE2UGGr5nfs+kde7jBmxoxdFAQ
         5ddNcdpBM8NKcUNZDtU/yt9Zqn+RhdkfMHGEmZDm4ASTU2zn7l74Rerr+mfLykdb/I7O
         tVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OumoT81qpxCDVJURrN3X61sq1dWFWgAsjgIMNuZtdvM=;
        b=BioxkNI43ECQLunz9TgosL6DYCV58a5DYq3Y6ZHpjguVltR94oyBzGd3YIDeQYQkN4
         BsGumL2vSNLwz+p05uDq4KZ3nSCFWn2ObfCrz3eEAuMl1AZ/QJSgR2d4zeyHly5q8rUz
         U+uv+XnpA4wwVXmHlkc4yPd35H512lpmQdi+wjWlU+CRZQ+TivBh96wpJiYVKi5K/pdH
         6S91gp5NBN6OR32j1qfmzDb16+4oPIFtjNys2j6OfsYfxWz+G+bO9sQ2IsihAcUoTudj
         z57OM4NhP6D5d9qgzko0EKOzzTR2UslUIsU11os98gNeAxYxK3wtvA0XaqsBqUOaFuEw
         UqyQ==
X-Gm-Message-State: AOAM5311Skk/R8mBzRGfxZdoC+uMPUiTF53FF7NTP1l8E1jSsEibZRyN
        x2twf8BuPfRm9V10ZYkjMA/PKOXAR3s+1wc6
X-Google-Smtp-Source: ABdhPJxzXKbmHvtwe0hHPHjRwprP5haulKYzRv8w5NGAjaO4nUqBR/o67qb5YK5/azAF7n/HUXYVLQ==
X-Received: by 2002:a05:6214:6af:: with SMTP id s15mr14058462qvz.34.1610747340161;
        Fri, 15 Jan 2021 13:49:00 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s30sm5675581qte.44.2021.01.15.13.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 13:48:59 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v3 1/2] btrfs: handle ->total_bytes_pinned inside the delayed ref itself
Date:   Fri, 15 Jan 2021 16:48:55 -0500
Message-Id: <d273732f509d6674291155e3907787ca2bba0436.1610747242.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1610747242.git.josef@toxicpanda.com>
References: <cover.1610747242.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently we pass things around to figure out if we maybe free'ing data
based on the state of the delayed refs head.  This makes the accounting
sort of confusing and hard to follow, as it's distinctly separate from
the delayed ref heads stuff, but also depends on it entirely.

Fix this by explicitly adjusting the space_info->total_bytes_pinned in
the delayed refs code.  We now have two places where we modify this
counter, once where we create the delayed and destroy the delayed refs,
and once when we pin and unpin the extents.  This means there is a
slight overlap between delayed refs and the pin/unpin mechanisms, but
this is simply used by the ENOSPC infrastructure to determine if we need
to commit the transaction, so there's no adverse affect from this, we
might simply commit thinking it will give us enough space when it might
not.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 11 ++---
 fs/btrfs/delayed-ref.c | 53 ++++++++++++++---------
 fs/btrfs/delayed-ref.h | 16 +++++--
 fs/btrfs/extent-tree.c | 97 ++++++------------------------------------
 fs/btrfs/space-info.h  | 17 ++++++++
 5 files changed, 77 insertions(+), 117 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 0886e81e5540..535ff2a8fe35 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1363,9 +1363,8 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		btrfs_space_info_update_bytes_pinned(fs_info, space_info,
 						     -block_group->pinned);
 		space_info->bytes_readonly += block_group->pinned;
-		percpu_counter_add_batch(&space_info->total_bytes_pinned,
-				   -block_group->pinned,
-				   BTRFS_TOTAL_BYTES_PINNED_BATCH);
+		__btrfs_mod_total_bytes_pinned(space_info,
+					       -block_group->pinned);
 		block_group->pinned = 0;
 
 		spin_unlock(&block_group->lock);
@@ -2888,10 +2887,8 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 			spin_unlock(&cache->lock);
 			spin_unlock(&cache->space_info->lock);
 
-			percpu_counter_add_batch(
-					&cache->space_info->total_bytes_pinned,
-					num_bytes,
-					BTRFS_TOTAL_BYTES_PINNED_BATCH);
+			__btrfs_mod_total_bytes_pinned(cache->space_info,
+						       num_bytes);
 			set_extent_dirty(&trans->transaction->pinned_extents,
 					 bytenr, bytenr + num_bytes - 1,
 					 GFP_NOFS | __GFP_NOFAIL);
diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 353cc2994d10..1edb0095f08d 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -648,12 +648,12 @@ static int insert_delayed_ref(struct btrfs_trans_handle *trans,
  */
 static noinline void update_existing_head_ref(struct btrfs_trans_handle *trans,
 			 struct btrfs_delayed_ref_head *existing,
-			 struct btrfs_delayed_ref_head *update,
-			 int *old_ref_mod_ret)
+			 struct btrfs_delayed_ref_head *update)
 {
 	struct btrfs_delayed_ref_root *delayed_refs =
 		&trans->transaction->delayed_refs;
 	struct btrfs_fs_info *fs_info = trans->fs_info;
+	u64 flags = btrfs_ref_head_to_space_flags(existing);
 	int old_ref_mod;
 
 	BUG_ON(existing->is_data != update->is_data);
@@ -701,8 +701,6 @@ static noinline void update_existing_head_ref(struct btrfs_trans_handle *trans,
 	 * currently, for refs we just added we know we're a-ok.
 	 */
 	old_ref_mod = existing->total_ref_mod;
-	if (old_ref_mod_ret)
-		*old_ref_mod_ret = old_ref_mod;
 	existing->ref_mod += update->ref_mod;
 	existing->total_ref_mod += update->ref_mod;
 
@@ -724,6 +722,24 @@ static noinline void update_existing_head_ref(struct btrfs_trans_handle *trans,
 			trans->delayed_ref_updates += csum_leaves;
 		}
 	}
+
+	/*
+	 * This handles the following conditions:
+	 *
+	 * 1. We had a ref mod of 0 or more and went negative, indicating that
+	 *    we may be freeing space, so add our space to the
+	 *    total_bytes_pinned counter.
+	 * 2. We were negative and went to 0 or positive, so no longer can say
+	 *    that the space would be pinned, decrement our counter from the
+	 *    total_bytes_pinned counter.
+	 */
+	if (existing->total_ref_mod < 0 && old_ref_mod >= 0)
+		btrfs_mod_total_bytes_pinned(fs_info, flags,
+					     existing->num_bytes);
+	else if (existing->total_ref_mod >= 0 && old_ref_mod < 0)
+		btrfs_mod_total_bytes_pinned(fs_info, flags,
+					     -existing->num_bytes);
+
 	spin_unlock(&existing->lock);
 }
 
@@ -798,8 +814,7 @@ static noinline struct btrfs_delayed_ref_head *
 add_delayed_ref_head(struct btrfs_trans_handle *trans,
 		     struct btrfs_delayed_ref_head *head_ref,
 		     struct btrfs_qgroup_extent_record *qrecord,
-		     int action, int *qrecord_inserted_ret,
-		     int *old_ref_mod, int *new_ref_mod)
+		     int action, int *qrecord_inserted_ret)
 {
 	struct btrfs_delayed_ref_head *existing;
 	struct btrfs_delayed_ref_root *delayed_refs;
@@ -821,8 +836,7 @@ add_delayed_ref_head(struct btrfs_trans_handle *trans,
 	existing = htree_insert(&delayed_refs->href_root,
 				&head_ref->href_node);
 	if (existing) {
-		update_existing_head_ref(trans, existing, head_ref,
-					 old_ref_mod);
+		update_existing_head_ref(trans, existing, head_ref);
 		/*
 		 * we've updated the existing ref, free the newly
 		 * allocated ref
@@ -830,14 +844,17 @@ add_delayed_ref_head(struct btrfs_trans_handle *trans,
 		kmem_cache_free(btrfs_delayed_ref_head_cachep, head_ref);
 		head_ref = existing;
 	} else {
-		if (old_ref_mod)
-			*old_ref_mod = 0;
+		u64 flags = btrfs_ref_head_to_space_flags(head_ref);
+
 		if (head_ref->is_data && head_ref->ref_mod < 0) {
 			delayed_refs->pending_csums += head_ref->num_bytes;
 			trans->delayed_ref_updates +=
 				btrfs_csum_bytes_to_leaves(trans->fs_info,
 							   head_ref->num_bytes);
 		}
+		if (head_ref->ref_mod < 0)
+			btrfs_mod_total_bytes_pinned(trans->fs_info, flags,
+						     head_ref->num_bytes);
 		delayed_refs->num_heads++;
 		delayed_refs->num_heads_ready++;
 		atomic_inc(&delayed_refs->num_entries);
@@ -845,8 +862,6 @@ add_delayed_ref_head(struct btrfs_trans_handle *trans,
 	}
 	if (qrecord_inserted_ret)
 		*qrecord_inserted_ret = qrecord_inserted;
-	if (new_ref_mod)
-		*new_ref_mod = head_ref->total_ref_mod;
 
 	return head_ref;
 }
@@ -909,8 +924,7 @@ static void init_delayed_ref_common(struct btrfs_fs_info *fs_info,
  */
 int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 			       struct btrfs_ref *generic_ref,
-			       struct btrfs_delayed_extent_op *extent_op,
-			       int *old_ref_mod, int *new_ref_mod)
+			       struct btrfs_delayed_extent_op *extent_op)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_delayed_tree_ref *ref;
@@ -977,8 +991,7 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 	 * the spin lock
 	 */
 	head_ref = add_delayed_ref_head(trans, head_ref, record,
-					action, &qrecord_inserted,
-					old_ref_mod, new_ref_mod);
+					action, &qrecord_inserted);
 
 	ret = insert_delayed_ref(trans, delayed_refs, head_ref, &ref->node);
 	spin_unlock(&delayed_refs->lock);
@@ -1006,8 +1019,7 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
  */
 int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
 			       struct btrfs_ref *generic_ref,
-			       u64 reserved, int *old_ref_mod,
-			       int *new_ref_mod)
+			       u64 reserved)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_delayed_data_ref *ref;
@@ -1073,8 +1085,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
 	 * the spin lock
 	 */
 	head_ref = add_delayed_ref_head(trans, head_ref, record,
-					action, &qrecord_inserted,
-					old_ref_mod, new_ref_mod);
+					action, &qrecord_inserted);
 
 	ret = insert_delayed_ref(trans, delayed_refs, head_ref, &ref->node);
 	spin_unlock(&delayed_refs->lock);
@@ -1117,7 +1128,7 @@ int btrfs_add_delayed_extent_op(struct btrfs_trans_handle *trans,
 	spin_lock(&delayed_refs->lock);
 
 	add_delayed_ref_head(trans, head_ref, NULL, BTRFS_UPDATE_DELAYED_HEAD,
-			     NULL, NULL, NULL);
+			     NULL);
 
 	spin_unlock(&delayed_refs->lock);
 
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index 1c977e6d45dc..3ba140468f12 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -326,6 +326,16 @@ static inline void btrfs_put_delayed_ref(struct btrfs_delayed_ref_node *ref)
 	}
 }
 
+static inline u64 btrfs_ref_head_to_space_flags(
+				struct btrfs_delayed_ref_head *head_ref)
+{
+	if (head_ref->is_data)
+		return BTRFS_BLOCK_GROUP_DATA;
+	else if (head_ref->is_system)
+		return BTRFS_BLOCK_GROUP_SYSTEM;
+	return BTRFS_BLOCK_GROUP_METADATA;
+}
+
 static inline void btrfs_put_delayed_ref_head(struct btrfs_delayed_ref_head *head)
 {
 	if (refcount_dec_and_test(&head->refs))
@@ -334,12 +344,10 @@ static inline void btrfs_put_delayed_ref_head(struct btrfs_delayed_ref_head *hea
 
 int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 			       struct btrfs_ref *generic_ref,
-			       struct btrfs_delayed_extent_op *extent_op,
-			       int *old_ref_mod, int *new_ref_mod);
+			       struct btrfs_delayed_extent_op *extent_op);
 int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
 			       struct btrfs_ref *generic_ref,
-			       u64 reserved, int *old_ref_mod,
-			       int *new_ref_mod);
+			       u64 reserved);
 int btrfs_add_delayed_extent_op(struct btrfs_trans_handle *trans,
 				u64 bytenr, u64 num_bytes,
 				struct btrfs_delayed_extent_op *extent_op);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 30b1a630dc2f..290d957f4603 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -82,41 +82,6 @@ void btrfs_free_excluded_extents(struct btrfs_block_group *cache)
 			  EXTENT_UPTODATE);
 }
 
-static u64 generic_ref_to_space_flags(struct btrfs_ref *ref)
-{
-	if (ref->type == BTRFS_REF_METADATA) {
-		if (ref->tree_ref.root == BTRFS_CHUNK_TREE_OBJECTID)
-			return BTRFS_BLOCK_GROUP_SYSTEM;
-		else
-			return BTRFS_BLOCK_GROUP_METADATA;
-	}
-	return BTRFS_BLOCK_GROUP_DATA;
-}
-
-static void add_pinned_bytes(struct btrfs_fs_info *fs_info,
-			     struct btrfs_ref *ref)
-{
-	struct btrfs_space_info *space_info;
-	u64 flags = generic_ref_to_space_flags(ref);
-
-	space_info = btrfs_find_space_info(fs_info, flags);
-	ASSERT(space_info);
-	percpu_counter_add_batch(&space_info->total_bytes_pinned, ref->len,
-		    BTRFS_TOTAL_BYTES_PINNED_BATCH);
-}
-
-static void sub_pinned_bytes(struct btrfs_fs_info *fs_info,
-			     struct btrfs_ref *ref)
-{
-	struct btrfs_space_info *space_info;
-	u64 flags = generic_ref_to_space_flags(ref);
-
-	space_info = btrfs_find_space_info(fs_info, flags);
-	ASSERT(space_info);
-	percpu_counter_add_batch(&space_info->total_bytes_pinned, -ref->len,
-		    BTRFS_TOTAL_BYTES_PINNED_BATCH);
-}
-
 /* simple helper to search for an existing data extent at a given offset */
 int btrfs_lookup_data_extent(struct btrfs_fs_info *fs_info, u64 start, u64 len)
 {
@@ -1388,7 +1353,6 @@ int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 			 struct btrfs_ref *generic_ref)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	int old_ref_mod, new_ref_mod;
 	int ret;
 
 	ASSERT(generic_ref->type != BTRFS_REF_NOT_SET &&
@@ -1397,17 +1361,12 @@ int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 	       generic_ref->tree_ref.root == BTRFS_TREE_LOG_OBJECTID);
 
 	if (generic_ref->type == BTRFS_REF_METADATA)
-		ret = btrfs_add_delayed_tree_ref(trans, generic_ref,
-				NULL, &old_ref_mod, &new_ref_mod);
+		ret = btrfs_add_delayed_tree_ref(trans, generic_ref, NULL);
 	else
-		ret = btrfs_add_delayed_data_ref(trans, generic_ref, 0,
-						 &old_ref_mod, &new_ref_mod);
+		ret = btrfs_add_delayed_data_ref(trans, generic_ref, 0);
 
 	btrfs_ref_tree_mod(fs_info, generic_ref);
 
-	if (ret == 0 && old_ref_mod < 0 && new_ref_mod >= 0)
-		sub_pinned_bytes(fs_info, generic_ref);
-
 	return ret;
 }
 
@@ -1796,20 +1755,9 @@ void btrfs_cleanup_ref_head_accounting(struct btrfs_fs_info *fs_info,
 	int nr_items = 1;	/* Dropping this ref head update. */
 
 	if (head->total_ref_mod < 0) {
-		struct btrfs_space_info *space_info;
-		u64 flags;
-
-		if (head->is_data)
-			flags = BTRFS_BLOCK_GROUP_DATA;
-		else if (head->is_system)
-			flags = BTRFS_BLOCK_GROUP_SYSTEM;
-		else
-			flags = BTRFS_BLOCK_GROUP_METADATA;
-		space_info = btrfs_find_space_info(fs_info, flags);
-		ASSERT(space_info);
-		percpu_counter_add_batch(&space_info->total_bytes_pinned,
-				   -head->num_bytes,
-				   BTRFS_TOTAL_BYTES_PINNED_BATCH);
+		u64 flags = btrfs_ref_head_to_space_flags(head);
+		btrfs_mod_total_bytes_pinned(fs_info, flags,
+					     -head->num_bytes);
 
 		/*
 		 * We had csum deletions accounted for in our delayed refs rsv,
@@ -2572,8 +2520,7 @@ static int pin_down_extent(struct btrfs_trans_handle *trans,
 	spin_unlock(&cache->lock);
 	spin_unlock(&cache->space_info->lock);
 
-	percpu_counter_add_batch(&cache->space_info->total_bytes_pinned,
-		    num_bytes, BTRFS_TOTAL_BYTES_PINNED_BATCH);
+	__btrfs_mod_total_bytes_pinned(cache->space_info, num_bytes);
 	set_extent_dirty(&trans->transaction->pinned_extents, bytenr,
 			 bytenr + num_bytes - 1, GFP_NOFS | __GFP_NOFAIL);
 	return 0;
@@ -2806,8 +2753,7 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 		cache->pinned -= len;
 		btrfs_space_info_update_bytes_pinned(fs_info, space_info, -len);
 		space_info->max_extent_size = 0;
-		percpu_counter_add_batch(&space_info->total_bytes_pinned,
-			    -len, BTRFS_TOTAL_BYTES_PINNED_BATCH);
+		__btrfs_mod_total_bytes_pinned(space_info, -len);
 		if (cache->ro) {
 			space_info->bytes_readonly += len;
 			readonly = true;
@@ -3343,7 +3289,6 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_ref generic_ref = { 0 };
-	int pin = 1;
 	int ret;
 
 	btrfs_init_generic_ref(&generic_ref, BTRFS_DROP_DELAYED_REF,
@@ -3352,13 +3297,9 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 			    root->root_key.objectid);
 
 	if (root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID) {
-		int old_ref_mod, new_ref_mod;
-
 		btrfs_ref_tree_mod(fs_info, &generic_ref);
-		ret = btrfs_add_delayed_tree_ref(trans, &generic_ref, NULL,
-						 &old_ref_mod, &new_ref_mod);
+		ret = btrfs_add_delayed_tree_ref(trans, &generic_ref, NULL);
 		BUG_ON(ret); /* -ENOMEM */
-		pin = old_ref_mod >= 0 && new_ref_mod < 0;
 	}
 
 	if (last_ref && btrfs_header_generation(buf) == trans->transid) {
@@ -3370,7 +3311,6 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 				goto out;
 		}
 
-		pin = 0;
 		cache = btrfs_lookup_block_group(fs_info, buf->start);
 
 		if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN)) {
@@ -3387,9 +3327,6 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 		trace_btrfs_reserved_extent_free(fs_info, buf->start, buf->len);
 	}
 out:
-	if (pin)
-		add_pinned_bytes(fs_info, &generic_ref);
-
 	if (last_ref) {
 		/*
 		 * Deleting the buffer, clear the corrupt flag since it doesn't
@@ -3403,7 +3340,6 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 int btrfs_free_extent(struct btrfs_trans_handle *trans, struct btrfs_ref *ref)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	int old_ref_mod, new_ref_mod;
 	int ret;
 
 	if (btrfs_is_testing(fs_info))
@@ -3419,14 +3355,11 @@ int btrfs_free_extent(struct btrfs_trans_handle *trans, struct btrfs_ref *ref)
 	     ref->data_ref.ref_root == BTRFS_TREE_LOG_OBJECTID)) {
 		/* unlocks the pinned mutex */
 		btrfs_pin_extent(trans, ref->bytenr, ref->len, 1);
-		old_ref_mod = new_ref_mod = 0;
 		ret = 0;
 	} else if (ref->type == BTRFS_REF_METADATA) {
-		ret = btrfs_add_delayed_tree_ref(trans, ref, NULL,
-						 &old_ref_mod, &new_ref_mod);
+		ret = btrfs_add_delayed_tree_ref(trans, ref, NULL);
 	} else {
-		ret = btrfs_add_delayed_data_ref(trans, ref, 0,
-						 &old_ref_mod, &new_ref_mod);
+		ret = btrfs_add_delayed_data_ref(trans, ref, 0);
 	}
 
 	if (!((ref->type == BTRFS_REF_METADATA &&
@@ -3435,9 +3368,6 @@ int btrfs_free_extent(struct btrfs_trans_handle *trans, struct btrfs_ref *ref)
 	       ref->data_ref.ref_root == BTRFS_TREE_LOG_OBJECTID)))
 		btrfs_ref_tree_mod(fs_info, ref);
 
-	if (ret == 0 && old_ref_mod >= 0 && new_ref_mod < 0)
-		add_pinned_bytes(fs_info, ref);
-
 	return ret;
 }
 
@@ -4553,7 +4483,6 @@ int btrfs_alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 				     struct btrfs_key *ins)
 {
 	struct btrfs_ref generic_ref = { 0 };
-	int ret;
 
 	BUG_ON(root->root_key.objectid == BTRFS_TREE_LOG_OBJECTID);
 
@@ -4561,9 +4490,7 @@ int btrfs_alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 			       ins->objectid, ins->offset, 0);
 	btrfs_init_data_ref(&generic_ref, root->root_key.objectid, owner, offset);
 	btrfs_ref_tree_mod(root->fs_info, &generic_ref);
-	ret = btrfs_add_delayed_data_ref(trans, &generic_ref,
-					 ram_bytes, NULL, NULL);
-	return ret;
+	return btrfs_add_delayed_data_ref(trans, &generic_ref, ram_bytes);
 }
 
 /*
@@ -4756,7 +4683,7 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 		btrfs_init_tree_ref(&generic_ref, level, root_objectid);
 		btrfs_ref_tree_mod(fs_info, &generic_ref);
 		ret = btrfs_add_delayed_tree_ref(trans, &generic_ref,
-						 extent_op, NULL, NULL);
+						 extent_op);
 		if (ret)
 			goto out_free_delayed;
 	}
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 5646393b928c..8f8700788833 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -152,4 +152,21 @@ static inline void btrfs_space_info_free_bytes_may_use(
 int btrfs_reserve_data_bytes(struct btrfs_fs_info *fs_info, u64 bytes,
 			     enum btrfs_reserve_flush_enum flush);
 
+static inline void __btrfs_mod_total_bytes_pinned(
+					struct btrfs_space_info *space_info,
+					s64 mod)
+{
+	percpu_counter_add_batch(&space_info->total_bytes_pinned, mod,
+				 BTRFS_TOTAL_BYTES_PINNED_BATCH);
+}
+
+static inline void btrfs_mod_total_bytes_pinned(struct btrfs_fs_info *fs_info,
+						u64 flags, s64 mod)
+{
+	struct btrfs_space_info *space_info = btrfs_find_space_info(fs_info,
+								    flags);
+	ASSERT(space_info);
+	__btrfs_mod_total_bytes_pinned(space_info, mod);
+}
+
 #endif /* BTRFS_SPACE_INFO_H */
-- 
2.26.2

