Return-Path: <linux-btrfs+bounces-9131-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 317B59AEBDB
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 18:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4EEF283EE7
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 16:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395481F80D3;
	Thu, 24 Oct 2024 16:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBcRkI7L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CA21F80C5
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 16:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787072; cv=none; b=oTaDyB3YeRlpxvs1Axs7rYXOc1V2OmTyYJ8768dLW6X4nCs6rc8l+kaK3+2U+OsNtWvEeS8uT86htQmaxFZUuXoY2N5XI+KxkwGla+YJWuemTf2p13ba4h+dhC625q21jkoxThHnibyHvK0bbOnJBIxkWcbP9F4JCk1JdKcITzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787072; c=relaxed/simple;
	bh=cu95UB+UXB0wLs+7O9SjbVPLqM7KKuGS1wCjgUM5lBQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E70XSzO5Urq3XgYcth3yXV8j4agYa/CrHtYEnEWrw+VvCrgIxQS2UXF8D3vUv5J1/gotjiYs8/IyZhdzpCnxB+h13U9tlpjeoV+r2M59X93eewKls9q422oPvx+16IAZtgXrw2tcvqyJAFG44c6svtJwWcHZkPiKJ5x9f5bP8nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBcRkI7L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC99C4CEE5
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 16:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729787072;
	bh=cu95UB+UXB0wLs+7O9SjbVPLqM7KKuGS1wCjgUM5lBQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rBcRkI7L50k5FnAvg7mbxsFUk4+5OTj2aCVfZRVVNQI4kgabPphGmCZ9nXQxwKlh9
	 VrSsnR0M5pnV8aXC1VoO5Yh88Ks2MijBPhFl9TM3bJRQ+mI1G/5pR0GV7kAMsmFudv
	 Q4/5v2tGJ0YmrCj43Iu+hNuhysZ3rJGn1TBfcnFQNqkzCtr8fAyM2HYDMr6zRRych3
	 lcXaHh6KMNlfSE9vA+DqHHwllQ0PwqKx2GwN6SMlLGL1EUKczUj8PFXzA2VQw3qolu
	 BJ51EuxCYtQTKPOu1aMkAuqWInRI0Vnvdh6U72c1sy3s6kRVT71am+BqruMJVJUpIM
	 vwZSetgnSo6rg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 02/18] btrfs: move btrfs_destroy_delayed_refs() to delayed-ref.c
Date: Thu, 24 Oct 2024 17:24:10 +0100
Message-Id: <46045d4ec41a0d522f16bd9a14913ec3d9c6dd3b.1729784712.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1729784712.git.fdmanana@suse.com>
References: <cover.1729784712.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

It's better suited at delayed-ref.c since it's about delayed refs and
contains logic to iterate over them (using the red black tree, doing all
the locking, freeing, etc), so move it from disk-io.c, which is pretty
big, into delayed-ref.c, hidding implementation details of how delayed
refs are tracked and managed. This also facilitates the next patches in
the series.

This change moves the code between files but also does the following
simple cleanups:

1) Rename the 'cache' variable to 'bg', since it's a block group
   (the 'cache' logic comes from old days where the block group
   structure was named 'btrfs_block_group_cache');

2) Move the 'ref' variable declaration to the scope of the inner
   while loop, since it's not used outside that loop.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-ref.c | 81 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/delayed-ref.h |  2 ++
 fs/btrfs/disk-io.c     | 80 -----------------------------------------
 3 files changed, 83 insertions(+), 80 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 04586aa11917..3ac2000f394d 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -9,6 +9,7 @@
 #include "messages.h"
 #include "ctree.h"
 #include "delayed-ref.h"
+#include "extent-tree.h"
 #include "transaction.h"
 #include "qgroup.h"
 #include "space-info.h"
@@ -1238,6 +1239,86 @@ bool btrfs_find_delayed_tree_ref(struct btrfs_delayed_ref_head *head,
 	return found;
 }
 
+void btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
+				struct btrfs_fs_info *fs_info)
+{
+	struct rb_node *node;
+	struct btrfs_delayed_ref_root *delayed_refs = &trans->delayed_refs;
+
+	spin_lock(&delayed_refs->lock);
+	while ((node = rb_first_cached(&delayed_refs->href_root)) != NULL) {
+		struct btrfs_delayed_ref_head *head;
+		struct rb_node *n;
+		bool pin_bytes = false;
+
+		head = rb_entry(node, struct btrfs_delayed_ref_head,
+				href_node);
+		if (btrfs_delayed_ref_lock(delayed_refs, head))
+			continue;
+
+		spin_lock(&head->lock);
+		while ((n = rb_first_cached(&head->ref_tree)) != NULL) {
+			struct btrfs_delayed_ref_node *ref;
+
+			ref = rb_entry(n, struct btrfs_delayed_ref_node, ref_node);
+			rb_erase_cached(&ref->ref_node, &head->ref_tree);
+			RB_CLEAR_NODE(&ref->ref_node);
+			if (!list_empty(&ref->add_list))
+				list_del(&ref->add_list);
+			atomic_dec(&delayed_refs->num_entries);
+			btrfs_put_delayed_ref(ref);
+			btrfs_delayed_refs_rsv_release(fs_info, 1, 0);
+		}
+		if (head->must_insert_reserved)
+			pin_bytes = true;
+		btrfs_free_delayed_extent_op(head->extent_op);
+		btrfs_delete_ref_head(delayed_refs, head);
+		spin_unlock(&head->lock);
+		spin_unlock(&delayed_refs->lock);
+		mutex_unlock(&head->mutex);
+
+		if (pin_bytes) {
+			struct btrfs_block_group *bg;
+
+			bg = btrfs_lookup_block_group(fs_info, head->bytenr);
+			if (WARN_ON_ONCE(bg == NULL)) {
+				/*
+				 * Unexpected and there's nothing we can do here
+				 * because we are in a transaction abort path,
+				 * so any errors can only be ignored or reported
+				 * while attempting to cleanup all resources.
+				 */
+				btrfs_err(fs_info,
+"block group for delayed ref at %llu was not found while destroying ref head",
+					  head->bytenr);
+			} else {
+				spin_lock(&bg->space_info->lock);
+				spin_lock(&bg->lock);
+				bg->pinned += head->num_bytes;
+				btrfs_space_info_update_bytes_pinned(fs_info,
+								     bg->space_info,
+								     head->num_bytes);
+				bg->reserved -= head->num_bytes;
+				bg->space_info->bytes_reserved -= head->num_bytes;
+				spin_unlock(&bg->lock);
+				spin_unlock(&bg->space_info->lock);
+
+				btrfs_put_block_group(bg);
+			}
+
+			btrfs_error_unpin_extent_range(fs_info, head->bytenr,
+				head->bytenr + head->num_bytes - 1);
+		}
+		btrfs_cleanup_ref_head_accounting(fs_info, delayed_refs, head);
+		btrfs_put_delayed_ref_head(head);
+		cond_resched();
+		spin_lock(&delayed_refs->lock);
+	}
+	btrfs_qgroup_destroy_extent_records(trans);
+
+	spin_unlock(&delayed_refs->lock);
+}
+
 void __cold btrfs_delayed_ref_exit(void)
 {
 	kmem_cache_destroy(btrfs_delayed_ref_head_cachep);
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index 352921e76c74..ccc040f94264 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -399,6 +399,8 @@ int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_info *fs_info,
 bool btrfs_check_space_for_delayed_refs(struct btrfs_fs_info *fs_info);
 bool btrfs_find_delayed_tree_ref(struct btrfs_delayed_ref_head *head,
 				 u64 root, u64 parent);
+void btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
+				struct btrfs_fs_info *fs_info);
 
 static inline u64 btrfs_delayed_ref_owner(struct btrfs_delayed_ref_node *node)
 {
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 47598e525ea5..f5d30c04ba66 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4529,86 +4529,6 @@ static void btrfs_destroy_all_ordered_extents(struct btrfs_fs_info *fs_info)
 	btrfs_wait_ordered_roots(fs_info, U64_MAX, NULL);
 }
 
-static void btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
-				       struct btrfs_fs_info *fs_info)
-{
-	struct rb_node *node;
-	struct btrfs_delayed_ref_root *delayed_refs = &trans->delayed_refs;
-	struct btrfs_delayed_ref_node *ref;
-
-	spin_lock(&delayed_refs->lock);
-	while ((node = rb_first_cached(&delayed_refs->href_root)) != NULL) {
-		struct btrfs_delayed_ref_head *head;
-		struct rb_node *n;
-		bool pin_bytes = false;
-
-		head = rb_entry(node, struct btrfs_delayed_ref_head,
-				href_node);
-		if (btrfs_delayed_ref_lock(delayed_refs, head))
-			continue;
-
-		spin_lock(&head->lock);
-		while ((n = rb_first_cached(&head->ref_tree)) != NULL) {
-			ref = rb_entry(n, struct btrfs_delayed_ref_node,
-				       ref_node);
-			rb_erase_cached(&ref->ref_node, &head->ref_tree);
-			RB_CLEAR_NODE(&ref->ref_node);
-			if (!list_empty(&ref->add_list))
-				list_del(&ref->add_list);
-			atomic_dec(&delayed_refs->num_entries);
-			btrfs_put_delayed_ref(ref);
-			btrfs_delayed_refs_rsv_release(fs_info, 1, 0);
-		}
-		if (head->must_insert_reserved)
-			pin_bytes = true;
-		btrfs_free_delayed_extent_op(head->extent_op);
-		btrfs_delete_ref_head(delayed_refs, head);
-		spin_unlock(&head->lock);
-		spin_unlock(&delayed_refs->lock);
-		mutex_unlock(&head->mutex);
-
-		if (pin_bytes) {
-			struct btrfs_block_group *cache;
-
-			cache = btrfs_lookup_block_group(fs_info, head->bytenr);
-			if (WARN_ON_ONCE(cache == NULL)) {
-				/*
-				 * Unexpected and there's nothing we can do here
-				 * because we are in a transaction abort path,
-				 * so any errors can only be ignored or reported
-				 * while attempting to cleanup all resources.
-				 */
-				btrfs_err(fs_info,
-"block group for delayed ref at %llu was not found while destroying ref head",
-					  head->bytenr);
-			} else {
-				spin_lock(&cache->space_info->lock);
-				spin_lock(&cache->lock);
-				cache->pinned += head->num_bytes;
-				btrfs_space_info_update_bytes_pinned(fs_info,
-								     cache->space_info,
-								     head->num_bytes);
-				cache->reserved -= head->num_bytes;
-				cache->space_info->bytes_reserved -= head->num_bytes;
-				spin_unlock(&cache->lock);
-				spin_unlock(&cache->space_info->lock);
-
-				btrfs_put_block_group(cache);
-			}
-
-			btrfs_error_unpin_extent_range(fs_info, head->bytenr,
-				head->bytenr + head->num_bytes - 1);
-		}
-		btrfs_cleanup_ref_head_accounting(fs_info, delayed_refs, head);
-		btrfs_put_delayed_ref_head(head);
-		cond_resched();
-		spin_lock(&delayed_refs->lock);
-	}
-	btrfs_qgroup_destroy_extent_records(trans);
-
-	spin_unlock(&delayed_refs->lock);
-}
-
 static void btrfs_destroy_delalloc_inodes(struct btrfs_root *root)
 {
 	struct btrfs_inode *btrfs_inode;
-- 
2.43.0


