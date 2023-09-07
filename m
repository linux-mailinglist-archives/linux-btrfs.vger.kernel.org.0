Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCCD797F1F
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 01:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbjIGXQB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Sep 2023 19:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjIGXP7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Sep 2023 19:15:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1269BCF3
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Sep 2023 16:15:55 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BFE9E210DB;
        Thu,  7 Sep 2023 23:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694128553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lq1UjernmQ7f3NkT+NjSdIKv/pszJh9OYnCi+zHF3C8=;
        b=Ah6VaQ/rx+2Cl9aGwc7D2CYu5/Q5RsIxUM1sN7RHWe1Nyv0Gxlf10zWzVi7j4NMKPxTO+7
        bqkYhYDeBsj+A8qWGofjvlJwD4O2CqgPFLQDyGrYkUKGL7SquPNtcsAOH2WsQkMYZafbUI
        drYf3GddIk5Tzi+Y/bKMgwqBZp/L/A8=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id B2B182C142;
        Thu,  7 Sep 2023 23:15:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E62DCDA8C5; Fri,  8 Sep 2023 01:09:22 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 01/10] btrfs: move functions comments from qgroup.h to qgroup.c
Date:   Fri,  8 Sep 2023 01:09:22 +0200
Message-ID: <a8e34e7713822d76e71f39e8b9481a79076ea9d0.1694126893.git.dsterba@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694126893.git.dsterba@suse.com>
References: <cover.1694126893.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We keep the comments next to the implementation, there were some left
to move.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/qgroup.c | 71 +++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/qgroup.h | 76 -----------------------------------------------
 2 files changed, 71 insertions(+), 76 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 127b91290e9a..a51f1ceb867a 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1793,6 +1793,17 @@ int btrfs_limit_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid,
 	return ret;
 }
 
+/*
+ * Inform qgroup to trace one dirty extent, its info is recorded in @record.
+ * So qgroup can account it at transaction committing time.
+ *
+ * No lock version, caller must acquire delayed ref lock and allocated memory,
+ * then call btrfs_qgroup_trace_extent_post() after exiting lock context.
+ *
+ * Return 0 for success insert
+ * Return >0 for existing record, caller can free @record safely.
+ * Error is not possible
+ */
 int btrfs_qgroup_trace_extent_nolock(struct btrfs_fs_info *fs_info,
 				struct btrfs_delayed_ref_root *delayed_refs,
 				struct btrfs_qgroup_extent_record *record)
@@ -1828,6 +1839,27 @@ int btrfs_qgroup_trace_extent_nolock(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
+/*
+ * Post handler after qgroup_trace_extent_nolock().
+ *
+ * NOTE: Current qgroup does the expensive backref walk at transaction
+ * committing time with TRANS_STATE_COMMIT_DOING, this blocks incoming
+ * new transaction.
+ * This is designed to allow btrfs_find_all_roots() to get correct new_roots
+ * result.
+ *
+ * However for old_roots there is no need to do backref walk at that time,
+ * since we search commit roots to walk backref and result will always be
+ * correct.
+ *
+ * Due to the nature of no lock version, we can't do backref there.
+ * So we must call btrfs_qgroup_trace_extent_post() after exiting
+ * spinlock context.
+ *
+ * TODO: If we can fix and prove btrfs_find_all_roots() can get correct result
+ * using current root, then we can move all expensive backref walk out of
+ * transaction committing, but not now as qgroup accounting will be wrong again.
+ */
 int btrfs_qgroup_trace_extent_post(struct btrfs_trans_handle *trans,
 				   struct btrfs_qgroup_extent_record *qrecord)
 {
@@ -1881,6 +1913,19 @@ int btrfs_qgroup_trace_extent_post(struct btrfs_trans_handle *trans,
 	return 0;
 }
 
+/*
+ * Inform qgroup to trace one dirty extent, specified by @bytenr and
+ * @num_bytes.
+ * So qgroup can account it at commit trans time.
+ *
+ * Better encapsulated version, with memory allocation and backref walk for
+ * commit roots.
+ * So this can sleep.
+ *
+ * Return 0 if the operation is done.
+ * Return <0 for error, like memory allocation failure or invalid parameter
+ * (NULL trans)
+ */
 int btrfs_qgroup_trace_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 			      u64 num_bytes)
 {
@@ -1911,6 +1956,12 @@ int btrfs_qgroup_trace_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 	return btrfs_qgroup_trace_extent_post(trans, record);
 }
 
+/*
+ * Inform qgroup to trace all leaf items of data
+ *
+ * Return 0 for success
+ * Return <0 for error(ENOMEM)
+ */
 int btrfs_qgroup_trace_leaf_items(struct btrfs_trans_handle *trans,
 				  struct extent_buffer *eb)
 {
@@ -2341,6 +2392,16 @@ static int qgroup_trace_subtree_swap(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
+/*
+ * Inform qgroup to trace a whole subtree, including all its child tree
+ * blocks and data.
+ * The root tree block is specified by @root_eb.
+ *
+ * Normally used by relocation(tree block swap) and subvolume deletion.
+ *
+ * Return 0 for success
+ * Return <0 for error(ENOMEM or tree search error)
+ */
 int btrfs_qgroup_trace_subtree(struct btrfs_trans_handle *trans,
 			       struct extent_buffer *root_eb,
 			       u64 root_gen, int root_level)
@@ -4050,6 +4111,10 @@ int __btrfs_qgroup_reserve_meta(struct btrfs_root *root, int num_bytes,
 	return btrfs_qgroup_reserve_meta(root, num_bytes, type, enforce);
 }
 
+/*
+ * Per-transaction meta reservation should be all freed at transaction commit
+ * time
+ */
 void btrfs_qgroup_free_meta_all_pertrans(struct btrfs_root *root)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
@@ -4119,6 +4184,12 @@ static void qgroup_convert_meta(struct btrfs_fs_info *fs_info, u64 ref_root,
 	spin_unlock(&fs_info->qgroup_lock);
 }
 
+/*
+ * Convert @num_bytes of META_PREALLOCATED reservation to META_PERTRANS.
+ *
+ * This is called when preallocated meta reservation needs to be used.
+ * Normally after btrfs_join_transaction() call.
+ */
 void btrfs_qgroup_convert_reserved_meta(struct btrfs_root *root, int num_bytes)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index b4416d5be47d..12614bc1e70b 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -294,80 +294,16 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info);
 void btrfs_free_qgroup_config(struct btrfs_fs_info *fs_info);
 struct btrfs_delayed_extent_op;
 
-/*
- * Inform qgroup to trace one dirty extent, its info is recorded in @record.
- * So qgroup can account it at transaction committing time.
- *
- * No lock version, caller must acquire delayed ref lock and allocated memory,
- * then call btrfs_qgroup_trace_extent_post() after exiting lock context.
- *
- * Return 0 for success insert
- * Return >0 for existing record, caller can free @record safely.
- * Error is not possible
- */
 int btrfs_qgroup_trace_extent_nolock(
 		struct btrfs_fs_info *fs_info,
 		struct btrfs_delayed_ref_root *delayed_refs,
 		struct btrfs_qgroup_extent_record *record);
-
-/*
- * Post handler after qgroup_trace_extent_nolock().
- *
- * NOTE: Current qgroup does the expensive backref walk at transaction
- * committing time with TRANS_STATE_COMMIT_DOING, this blocks incoming
- * new transaction.
- * This is designed to allow btrfs_find_all_roots() to get correct new_roots
- * result.
- *
- * However for old_roots there is no need to do backref walk at that time,
- * since we search commit roots to walk backref and result will always be
- * correct.
- *
- * Due to the nature of no lock version, we can't do backref there.
- * So we must call btrfs_qgroup_trace_extent_post() after exiting
- * spinlock context.
- *
- * TODO: If we can fix and prove btrfs_find_all_roots() can get correct result
- * using current root, then we can move all expensive backref walk out of
- * transaction committing, but not now as qgroup accounting will be wrong again.
- */
 int btrfs_qgroup_trace_extent_post(struct btrfs_trans_handle *trans,
 				   struct btrfs_qgroup_extent_record *qrecord);
-
-/*
- * Inform qgroup to trace one dirty extent, specified by @bytenr and
- * @num_bytes.
- * So qgroup can account it at commit trans time.
- *
- * Better encapsulated version, with memory allocation and backref walk for
- * commit roots.
- * So this can sleep.
- *
- * Return 0 if the operation is done.
- * Return <0 for error, like memory allocation failure or invalid parameter
- * (NULL trans)
- */
 int btrfs_qgroup_trace_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 			      u64 num_bytes);
-
-/*
- * Inform qgroup to trace all leaf items of data
- *
- * Return 0 for success
- * Return <0 for error(ENOMEM)
- */
 int btrfs_qgroup_trace_leaf_items(struct btrfs_trans_handle *trans,
 				  struct extent_buffer *eb);
-/*
- * Inform qgroup to trace a whole subtree, including all its child tree
- * blocks and data.
- * The root tree block is specified by @root_eb.
- *
- * Normally used by relocation(tree block swap) and subvolume deletion.
- *
- * Return 0 for success
- * Return <0 for error(ENOMEM or tree search error)
- */
 int btrfs_qgroup_trace_subtree(struct btrfs_trans_handle *trans,
 			       struct extent_buffer *root_eb,
 			       u64 root_gen, int root_level);
@@ -435,20 +371,8 @@ static inline void btrfs_qgroup_free_meta_prealloc(struct btrfs_root *root,
 			BTRFS_QGROUP_RSV_META_PREALLOC);
 }
 
-/*
- * Per-transaction meta reservation should be all freed at transaction commit
- * time
- */
 void btrfs_qgroup_free_meta_all_pertrans(struct btrfs_root *root);
-
-/*
- * Convert @num_bytes of META_PREALLOCATED reservation to META_PERTRANS.
- *
- * This is called when preallocated meta reservation needs to be used.
- * Normally after btrfs_join_transaction() call.
- */
 void btrfs_qgroup_convert_reserved_meta(struct btrfs_root *root, int num_bytes);
-
 void btrfs_qgroup_check_reserved_leak(struct btrfs_inode *inode);
 
 /* btrfs_qgroup_swapped_blocks related functions */
-- 
2.41.0

