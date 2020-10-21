Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1BA294D94
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 15:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441723AbgJUNcg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 09:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441714AbgJUNcd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 09:32:33 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5FFC0613CE
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:32:32 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b69so2371702qkg.8
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=sIaKJlnLcc+VMYoVOFWgx4rUFpLptaI1yfLG01cK48k=;
        b=RS2Mf+mzGibGwiBdXVDKDJ4SoxjKuAZfdOcylnUoPXDmge+JZuug5FafQA612Ys2ol
         E7MRJDL2JKsS221vZhEoT+kXDO2czXC8Q3PSpKmlnetg/YRVct8OobjKjqIS83DhpF1n
         VVV7cptoYOY37XlZwkajGmWuiMutwzy2ur4yYrC1ZoKEvlc5lt/0l6hm4LyXZu0A4yTY
         RFT13ZOJQczWmLxkB0abNU5d9WWfd790gKlNEgScTNgpLS/SAdC1ekTLxYiJUuwOoXBH
         66ToStw+iZRl3j8gGEoUsSyf4L/vpaLqI4Q7G3Mmzy7HqTnSv5Xyh7TACb4vVsaYSB4n
         ZkBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sIaKJlnLcc+VMYoVOFWgx4rUFpLptaI1yfLG01cK48k=;
        b=FTywKYf0dUNwhPPjaDz9QKsXLYaQ7myc31fXLqzFHpVEknnwnqwyJ9up2NssxjEgzj
         r12YJsB0rOWJej0UeQnB5PoatYxzDczD78uDgORc7U2+D7a7TkwD2XNjNJS6X/774Yh2
         EZC/LDyGeS3C+AqCzRbDtehP3Rrd0tUywRw5BsbWyg6nOwIlq2NHzlQnSCrOQvVyvvYC
         QFddBvgYdNAC29X9/S6OfJVeDziyIn05dgf1jX2TrbuZAAuHKwHPPfj095i4b7TDawJ5
         D46E+DbLU0YJUBst7wP2VAgfYvDwueczcFZMuFLNSALCWZRdR1BASlqaz8XTPXXFC3PP
         E9gw==
X-Gm-Message-State: AOAM531mkLLjFQl4G0FLWNuogb55jdTxrmMl2wiWFn0hoA/Tew7jnGMv
        sbF01iXIFEg4Be/FMcED7w004Zx4ZHBlKL6Y
X-Google-Smtp-Source: ABdhPJwGn4/VsKBOvYGv0lVdoEe5u0ycBWXMvKRMmD724cJU7KSEeMJG2Bqi/DpwCYKPHxUUjtfuSw==
X-Received: by 2002:a37:6246:: with SMTP id w67mr2882110qkb.35.1603287150623;
        Wed, 21 Oct 2020 06:32:30 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z6sm1102660qtw.36.2020.10.21.06.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 06:32:30 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/2] btrfs: handle ->total_bytes_pinned inside the delayed ref itself
Date:   Wed, 21 Oct 2020 09:32:25 -0400
Message-Id: <511ea5400e68ac598aa45a9849b3088cdef23e4a.1603286785.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603286785.git.josef@toxicpanda.com>
References: <cover.1603286785.git.josef@toxicpanda.com>
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

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 11 ++---
 fs/btrfs/delayed-ref.c | 53 ++++++++++++++---------
 fs/btrfs/delayed-ref.h | 16 +++++--
 fs/btrfs/extent-tree.c | 97 ++++++------------------------------------
 fs/btrfs/space-info.h  | 17 ++++++++
 5 files changed, 77 insertions(+), 117 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 2b5f91b35032..d356995662fd 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1447,9 +1447,8 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
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
@@ -2910,10 +2909,8 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
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
index 6e414785b56f..467753128069 100644
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
index a7f0a1480cd9..5d97f5f3c85d 100644
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
@@ -1386,7 +1351,6 @@ int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 			 struct btrfs_ref *generic_ref)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	int old_ref_mod, new_ref_mod;
 	int ret;
 
 	ASSERT(generic_ref->type != BTRFS_REF_NOT_SET &&
@@ -1395,17 +1359,12 @@ int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
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
 
@@ -1797,20 +1756,9 @@ void btrfs_cleanup_ref_head_accounting(struct btrfs_fs_info *fs_info,
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
@@ -2592,8 +2540,7 @@ static int pin_down_extent(struct btrfs_trans_handle *trans,
 	spin_unlock(&cache->lock);
 	spin_unlock(&cache->space_info->lock);
 
-	percpu_counter_add_batch(&cache->space_info->total_bytes_pinned,
-		    num_bytes, BTRFS_TOTAL_BYTES_PINNED_BATCH);
+	__btrfs_mod_total_bytes_pinned(cache->space_info, num_bytes);
 	set_extent_dirty(&trans->transaction->pinned_extents, bytenr,
 			 bytenr + num_bytes - 1, GFP_NOFS | __GFP_NOFAIL);
 	return 0;
@@ -2844,8 +2791,7 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 		cache->pinned -= len;
 		btrfs_space_info_update_bytes_pinned(fs_info, space_info, -len);
 		space_info->max_extent_size = 0;
-		percpu_counter_add_batch(&space_info->total_bytes_pinned,
-			    -len, BTRFS_TOTAL_BYTES_PINNED_BATCH);
+		__btrfs_mod_total_bytes_pinned(space_info, -len);
 		if (cache->ro) {
 			space_info->bytes_readonly += len;
 			readonly = true;
@@ -3384,7 +3330,6 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_ref generic_ref = { 0 };
-	int pin = 1;
 	int ret;
 
 	btrfs_init_generic_ref(&generic_ref, BTRFS_DROP_DELAYED_REF,
@@ -3393,13 +3338,9 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
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
@@ -3411,7 +3352,6 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 				goto out;
 		}
 
-		pin = 0;
 		cache = btrfs_lookup_block_group(fs_info, buf->start);
 
 		if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN)) {
@@ -3428,9 +3368,6 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 		trace_btrfs_reserved_extent_free(fs_info, buf->start, buf->len);
 	}
 out:
-	if (pin)
-		add_pinned_bytes(fs_info, &generic_ref);
-
 	if (last_ref) {
 		/*
 		 * Deleting the buffer, clear the corrupt flag since it doesn't
@@ -3444,7 +3381,6 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 int btrfs_free_extent(struct btrfs_trans_handle *trans, struct btrfs_ref *ref)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	int old_ref_mod, new_ref_mod;
 	int ret;
 
 	if (btrfs_is_testing(fs_info))
@@ -3460,14 +3396,11 @@ int btrfs_free_extent(struct btrfs_trans_handle *trans, struct btrfs_ref *ref)
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
@@ -3476,9 +3409,6 @@ int btrfs_free_extent(struct btrfs_trans_handle *trans, struct btrfs_ref *ref)
 	       ref->data_ref.ref_root == BTRFS_TREE_LOG_OBJECTID)))
 		btrfs_ref_tree_mod(fs_info, ref);
 
-	if (ret == 0 && old_ref_mod >= 0 && new_ref_mod < 0)
-		add_pinned_bytes(fs_info, ref);
-
 	return ret;
 }
 
@@ -4596,7 +4526,6 @@ int btrfs_alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 				     struct btrfs_key *ins)
 {
 	struct btrfs_ref generic_ref = { 0 };
-	int ret;
 
 	BUG_ON(root->root_key.objectid == BTRFS_TREE_LOG_OBJECTID);
 
@@ -4604,9 +4533,7 @@ int btrfs_alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 			       ins->objectid, ins->offset, 0);
 	btrfs_init_data_ref(&generic_ref, root->root_key.objectid, owner, offset);
 	btrfs_ref_tree_mod(root->fs_info, &generic_ref);
-	ret = btrfs_add_delayed_data_ref(trans, &generic_ref,
-					 ram_bytes, NULL, NULL);
-	return ret;
+	return btrfs_add_delayed_data_ref(trans, &generic_ref, ram_bytes);
 }
 
 /*
@@ -4795,7 +4722,7 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
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

