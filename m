Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F91798B6D
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 19:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245421AbjIHRVE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 13:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjIHRVE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 13:21:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CEB1FCD
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 10:20:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A5FC433C8
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 17:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694193659;
        bh=XOntC1jRBHX65IMSdn4ph6MJX2hkTmZzK2ys5eLMDA4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=k17+0YuPAqIkHiTPkCYHCNj8IAbr8lMZqeISHqvEAXxLoJsRr3B34IHuoqm3v0XLH
         7dQRyRg5mEZu4JKAgRzOPXVzvnkt9jx5kLPe1TF/qTIm8D91qeUAmtTTUhgWcZ9sWC
         aFdlN1UM+QlaMLQ8lVOrgUbGI+GgZANuim2P0zx/Nnt/VHzR7NGq5cwHxtNO+qDzme
         TOIk8hJicSNdkZxLwp/ahqh1QMzY+tUlm0wC+1W//Fa0Mk0ABqvNG6CYMfZJIJs0fQ
         QmLvXoAssv4eyA+b97wtQ10VUpjSLbUiKFiPNIID2k8FRG8wCHcpZQaKzpwlmg+vzB
         UsCiO2p41fdLw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 17/21] btrfs: allow to run delayed refs by bytes to be released instead of count
Date:   Fri,  8 Sep 2023 18:20:34 +0100
Message-Id: <84017ea76addadb4f74aeb93ad1e63b7f1a78be6.1694192469.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694192469.git.fdmanana@suse.com>
References: <cover.1694192469.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When running delayed references, through btrfs_run_delayed_refs(), we can
specify how many to run, run all existing delayed references and keep
running delayed references while we can find any. This is controlled with
the value of the 'count' argument, where a value of 0 means to run all
delayed references that exist by the time btrfs_run_delayed_refs() is
called, (unsigned long)-1 means to keep running delayed references while
we are able find any, and any other value to run that exact number of
delayed references.

Typically a specific value other than 0 or -1 is used when flushing space
to try to release a certain amount of bytes for a ticket. In this case
we just simply calculate how many delayed reference heads correspond to a
specific amount of bytes, with calc_delayed_refs_nr(). However that only
takes into account the space reserved for the reference heads themselves,
and does not account for the space reserved for deleting checksums from
the csum tree (see add_delayed_ref_head() and update_existing_head_ref())
in case we are going to delete a data extent. This means we may end up
running more delayed references than necessary in case we process delayed
references for deleting a data extent.

So change the logic of btrfs_run_delayed_refs() to take a bytes argument
to specify how many bytes of delayed references to run/release, using the
special values of 0 to mean all existing delayed references and U64_MAX
(or (u64)-1) to keep running delayed references while we can find any.

This prevents running more delayed references than necessary, when we have
delayed references for deleting data extents, but also makes the upcoming
changes/patches simpler and it's preparatory work for them.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c |  3 +--
 fs/btrfs/extent-tree.c | 53 +++++++++++++++++++++++++++---------------
 fs/btrfs/extent-tree.h |  4 ++--
 fs/btrfs/space-info.c  | 17 ++------------
 fs/btrfs/transaction.c |  8 +++----
 5 files changed, 43 insertions(+), 42 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index b2e5107b7cec..fb506ee51d2c 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3474,8 +3474,7 @@ int btrfs_write_dirty_block_groups(struct btrfs_trans_handle *trans)
 		cache_save_setup(cache, trans, path);
 
 		if (!ret)
-			ret = btrfs_run_delayed_refs(trans,
-						     (unsigned long) -1);
+			ret = btrfs_run_delayed_refs(trans, U64_MAX);
 
 		if (!ret && cache->disk_cache_state == BTRFS_DC_SETUP) {
 			cache->io_ctl.inode = NULL;
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index b27e0a6878b3..475903a8d772 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1815,7 +1815,7 @@ static int run_and_cleanup_extent_op(struct btrfs_trans_handle *trans,
 	return ret ? ret : 1;
 }
 
-void btrfs_cleanup_ref_head_accounting(struct btrfs_fs_info *fs_info,
+u64 btrfs_cleanup_ref_head_accounting(struct btrfs_fs_info *fs_info,
 				  struct btrfs_delayed_ref_root *delayed_refs,
 				  struct btrfs_delayed_ref_head *head)
 {
@@ -1833,10 +1833,13 @@ void btrfs_cleanup_ref_head_accounting(struct btrfs_fs_info *fs_info,
 	}
 
 	btrfs_delayed_refs_rsv_release(fs_info, nr_items);
+
+	return btrfs_calc_delayed_ref_bytes(fs_info, nr_items);
 }
 
 static int cleanup_ref_head(struct btrfs_trans_handle *trans,
-			    struct btrfs_delayed_ref_head *head)
+			    struct btrfs_delayed_ref_head *head,
+			    u64 *bytes_released)
 {
 
 	struct btrfs_fs_info *fs_info = trans->fs_info;
@@ -1881,7 +1884,7 @@ static int cleanup_ref_head(struct btrfs_trans_handle *trans,
 		}
 	}
 
-	btrfs_cleanup_ref_head_accounting(fs_info, delayed_refs, head);
+	*bytes_released = btrfs_cleanup_ref_head_accounting(fs_info, delayed_refs, head);
 
 	trace_run_delayed_ref_head(fs_info, head, 0);
 	btrfs_delayed_ref_unlock(head);
@@ -2002,15 +2005,22 @@ static int btrfs_run_delayed_refs_for_head(struct btrfs_trans_handle *trans,
  * Returns -ENOMEM or -EIO on failure and will abort the transaction.
  */
 static noinline int __btrfs_run_delayed_refs(struct btrfs_trans_handle *trans,
-					     unsigned long nr)
+					     u64 min_bytes)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_delayed_ref_root *delayed_refs;
 	struct btrfs_delayed_ref_head *locked_ref = NULL;
 	int ret;
 	unsigned long count = 0;
+	unsigned long max_count = 0;
+	u64 bytes_processed = 0;
 
 	delayed_refs = &trans->transaction->delayed_refs;
+	if (min_bytes == 0) {
+		max_count = delayed_refs->num_heads_ready;
+		min_bytes = U64_MAX;
+	}
+
 	do {
 		if (!locked_ref) {
 			locked_ref = btrfs_obtain_ref_head(trans);
@@ -2046,11 +2056,14 @@ static noinline int __btrfs_run_delayed_refs(struct btrfs_trans_handle *trans,
 			 */
 			return ret;
 		} else if (!ret) {
+			u64 bytes_released = 0;
+
 			/*
 			 * Success, perform the usual cleanup of a processed
 			 * head
 			 */
-			ret = cleanup_ref_head(trans, locked_ref);
+			ret = cleanup_ref_head(trans, locked_ref, &bytes_released);
+			bytes_processed += bytes_released;
 			if (ret > 0 ) {
 				/* We dropped our lock, we need to loop. */
 				ret = 0;
@@ -2067,7 +2080,9 @@ static noinline int __btrfs_run_delayed_refs(struct btrfs_trans_handle *trans,
 
 		locked_ref = NULL;
 		cond_resched();
-	} while ((nr != -1 && count < nr) || locked_ref);
+	} while ((min_bytes != U64_MAX && bytes_processed < min_bytes) ||
+		 (max_count > 0 && count < max_count) ||
+		 locked_ref);
 
 	return 0;
 }
@@ -2116,22 +2131,25 @@ static u64 find_middle(struct rb_root *root)
 #endif
 
 /*
- * this starts processing the delayed reference count updates and
- * extent insertions we have queued up so far.  count can be
- * 0, which means to process everything in the tree at the start
- * of the run (but not newly added entries), or it can be some target
- * number you'd like to process.
+ * This starts processing the delayed reference count updates and extent
+ * insertions we have queued up so far.
+ *
+ * @trans:	Transaction handle.
+ * @min_bytes:	How many bytes of delayed references to process. After this
+ *		many bytes we stop processing delayed references if there are
+ *		any more. If 0 it means to run all existing delayed references,
+ *		but not new ones added after running all existing ones.
+ *		Use (u64)-1 (U64_MAX) to run all existing delayed references
+ *		plus any new ones that are added.
  *
  * Returns 0 on success or if called with an aborted transaction
  * Returns <0 on error and aborts the transaction
  */
-int btrfs_run_delayed_refs(struct btrfs_trans_handle *trans,
-			   unsigned long count)
+int btrfs_run_delayed_refs(struct btrfs_trans_handle *trans, u64 min_bytes)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_delayed_ref_root *delayed_refs;
 	int ret;
-	int run_all = count == (unsigned long)-1;
 
 	/* We'll clean this up in btrfs_cleanup_transaction */
 	if (TRANS_ABORTED(trans))
@@ -2141,20 +2159,17 @@ int btrfs_run_delayed_refs(struct btrfs_trans_handle *trans,
 		return 0;
 
 	delayed_refs = &trans->transaction->delayed_refs;
-	if (count == 0)
-		count = delayed_refs->num_heads_ready;
-
 again:
 #ifdef SCRAMBLE_DELAYED_REFS
 	delayed_refs->run_delayed_start = find_middle(&delayed_refs->root);
 #endif
-	ret = __btrfs_run_delayed_refs(trans, count);
+	ret = __btrfs_run_delayed_refs(trans, min_bytes);
 	if (ret < 0) {
 		btrfs_abort_transaction(trans, ret);
 		return ret;
 	}
 
-	if (run_all) {
+	if (min_bytes == U64_MAX) {
 		btrfs_create_pending_block_groups(trans);
 
 		spin_lock(&delayed_refs->lock);
diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
index 88c249c37516..64436f15c4eb 100644
--- a/fs/btrfs/extent-tree.h
+++ b/fs/btrfs/extent-tree.h
@@ -91,8 +91,8 @@ int btrfs_get_extent_inline_ref_type(const struct extent_buffer *eb,
 				     enum btrfs_inline_ref_type is_data);
 u64 hash_extent_data_ref(u64 root_objectid, u64 owner, u64 offset);
 
-int btrfs_run_delayed_refs(struct btrfs_trans_handle *trans, unsigned long count);
-void btrfs_cleanup_ref_head_accounting(struct btrfs_fs_info *fs_info,
+int btrfs_run_delayed_refs(struct btrfs_trans_handle *trans, u64 min_bytes);
+u64 btrfs_cleanup_ref_head_accounting(struct btrfs_fs_info *fs_info,
 				  struct btrfs_delayed_ref_root *delayed_refs,
 				  struct btrfs_delayed_ref_head *head);
 int btrfs_lookup_data_extent(struct btrfs_fs_info *fs_info, u64 start, u64 len);
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index ca7c702172fd..5443d76c83cb 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -556,18 +556,6 @@ static inline u64 calc_reclaim_items_nr(const struct btrfs_fs_info *fs_info,
 	return nr;
 }
 
-static inline u64 calc_delayed_refs_nr(const struct btrfs_fs_info *fs_info,
-				       u64 to_reclaim)
-{
-	const u64 bytes = btrfs_calc_delayed_ref_bytes(fs_info, 1);
-	u64 nr;
-
-	nr = div64_u64(to_reclaim, bytes);
-	if (!nr)
-		nr = 1;
-	return nr;
-}
-
 #define EXTENT_SIZE_PER_ITEM	SZ_256K
 
 /*
@@ -749,10 +737,9 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 			break;
 		}
 		if (state == FLUSH_DELAYED_REFS_NR)
-			nr = calc_delayed_refs_nr(fs_info, num_bytes);
+			btrfs_run_delayed_refs(trans, num_bytes);
 		else
-			nr = 0;
-		btrfs_run_delayed_refs(trans, nr);
+			btrfs_run_delayed_refs(trans, 0);
 		btrfs_end_transaction(trans);
 		break;
 	case ALLOC_CHUNK:
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index ee63d92d66b4..06050aa520dc 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1330,7 +1330,7 @@ static noinline int commit_cowonly_roots(struct btrfs_trans_handle *trans)
 	}
 
 	/* Now flush any delayed refs generated by updating all of the roots */
-	ret = btrfs_run_delayed_refs(trans, (unsigned long)-1);
+	ret = btrfs_run_delayed_refs(trans, U64_MAX);
 	if (ret)
 		return ret;
 
@@ -1345,7 +1345,7 @@ static noinline int commit_cowonly_roots(struct btrfs_trans_handle *trans)
 		 * so we want to keep this flushing in this loop to make sure
 		 * everything gets run.
 		 */
-		ret = btrfs_run_delayed_refs(trans, (unsigned long)-1);
+		ret = btrfs_run_delayed_refs(trans, U64_MAX);
 		if (ret)
 			return ret;
 	}
@@ -1563,7 +1563,7 @@ static int qgroup_account_snapshot(struct btrfs_trans_handle *trans,
 	 * for now flush the delayed refs to narrow the race window where the
 	 * qgroup counters could end up wrong.
 	 */
-	ret = btrfs_run_delayed_refs(trans, (unsigned long)-1);
+	ret = btrfs_run_delayed_refs(trans, U64_MAX);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		return ret;
@@ -2397,7 +2397,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	if (ret)
 		goto unlock_reloc;
 
-	ret = btrfs_run_delayed_refs(trans, (unsigned long)-1);
+	ret = btrfs_run_delayed_refs(trans, U64_MAX);
 	if (ret)
 		goto unlock_reloc;
 
-- 
2.40.1

