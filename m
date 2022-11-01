Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327F16152F8
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 21:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiKAUNe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 16:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiKAUN1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 16:13:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E522BCE
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 13:13:24 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 48A1F1F88E;
        Tue,  1 Nov 2022 20:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667333603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lNeaCTdYGxEhExn3N0bcfZDzqStX0/A4UjGVoJXfSns=;
        b=WYmVE3HzfxjNf+vlfWTzPnY0akAVQ2JGL1XiyfWekeQSdABb5PKjtkdhCpnWZ5++Bvo5aS
        TD2sfPYN630A9LYzLCq26Wxu1rTX8Laj2EU7M5WgIyN+oFzJ6egWb7rofc0a7Sl8zPgkQR
        ejy//jtAFNlCyDG1q1Zx2qL2xKm0hZ8=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 41F572C141;
        Tue,  1 Nov 2022 20:13:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 91F96DA79D; Tue,  1 Nov 2022 21:13:06 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 40/40] btrfs: pass btrfs_inode to btrfs_add_delayed_iput
Date:   Tue,  1 Nov 2022 21:13:06 +0100
Message-Id: <f56053bc51c89a26e4245dd31396050dd0d146b4.1667331829.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1667331828.git.dsterba@suse.com>
References: <cover.1667331828.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function is for internal interfaces so we should use the
btrfs_inode.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/btrfs_inode.h      |  2 +-
 fs/btrfs/extent_io.c        |  2 +-
 fs/btrfs/free-space-cache.c |  4 ++--
 fs/btrfs/inode.c            | 19 +++++++++----------
 fs/btrfs/ordered-data.c     |  2 +-
 fs/btrfs/relocation.c       |  4 ++--
 fs/btrfs/tree-log.c         | 24 ++++++++++++------------
 7 files changed, 28 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 9e31dc8b0285..195c09e20609 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -501,7 +501,7 @@ int btrfs_update_inode_fallback(struct btrfs_trans_handle *trans,
 int btrfs_orphan_add(struct btrfs_trans_handle *trans, struct btrfs_inode *inode);
 int btrfs_orphan_cleanup(struct btrfs_root *root);
 int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size);
-void btrfs_add_delayed_iput(struct inode *inode);
+void btrfs_add_delayed_iput(struct btrfs_inode *inode);
 void btrfs_run_delayed_iputs(struct btrfs_fs_info *fs_info);
 int btrfs_wait_on_delayed_iputs(struct btrfs_fs_info *fs_info);
 int btrfs_prealloc_file_range(struct inode *inode, int mode,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 05768f7f7872..859a41624c31 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3228,7 +3228,7 @@ static int extent_write_cache_pages(struct address_space *mapping,
 	if (wbc->range_cyclic || (wbc->nr_to_write > 0 && range_whole))
 		mapping->writeback_index = done_index;
 
-	btrfs_add_delayed_iput(inode);
+	btrfs_add_delayed_iput(BTRFS_I(inode));
 	return ret;
 }
 
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 627bd6120368..0d250d052487 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -260,7 +260,7 @@ int btrfs_remove_free_space_inode(struct btrfs_trans_handle *trans,
 	}
 	ret = btrfs_orphan_add(trans, BTRFS_I(inode));
 	if (ret) {
-		btrfs_add_delayed_iput(inode);
+		btrfs_add_delayed_iput(BTRFS_I(inode));
 		goto out;
 	}
 	clear_nlink(inode);
@@ -274,7 +274,7 @@ int btrfs_remove_free_space_inode(struct btrfs_trans_handle *trans,
 		spin_unlock(&block_group->lock);
 	}
 	/* One for the lookup ref */
-	btrfs_add_delayed_iput(inode);
+	btrfs_add_delayed_iput(BTRFS_I(inode));
 
 	key.objectid = BTRFS_FREE_SPACE_OBJECTID;
 	key.type = 0;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9d4e97eb5651..c6af4843ddaf 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1493,7 +1493,7 @@ static noinline void async_cow_start(struct btrfs_work *work)
 
 	compressed_extents = compress_file_range(async_chunk);
 	if (compressed_extents == 0) {
-		btrfs_add_delayed_iput(&async_chunk->inode->vfs_inode);
+		btrfs_add_delayed_iput(async_chunk->inode);
 		async_chunk->inode = NULL;
 	}
 }
@@ -1533,7 +1533,7 @@ static noinline void async_cow_free(struct btrfs_work *work)
 
 	async_chunk = container_of(work, struct async_chunk, work);
 	if (async_chunk->inode)
-		btrfs_add_delayed_iput(&async_chunk->inode->vfs_inode);
+		btrfs_add_delayed_iput(async_chunk->inode);
 	if (async_chunk->blkcg_css)
 		css_put(async_chunk->blkcg_css);
 
@@ -3016,7 +3016,7 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 	 * that could need flushing space. Recursing back to fixup worker would
 	 * deadlock.
 	 */
-	btrfs_add_delayed_iput(&inode->vfs_inode);
+	btrfs_add_delayed_iput(inode);
 }
 
 /*
@@ -3590,18 +3590,17 @@ unsigned int btrfs_verify_data_csum(struct btrfs_bio *bbio,
  * the inode to the delayed iput machinery. Delayed iputs are processed at
  * transaction commit time/superblock commit/cleaner kthread.
  */
-void btrfs_add_delayed_iput(struct inode *inode)
+void btrfs_add_delayed_iput(struct btrfs_inode *inode)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct btrfs_inode *binode = BTRFS_I(inode);
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 
-	if (atomic_add_unless(&inode->i_count, -1, 1))
+	if (atomic_add_unless(&inode->vfs_inode.i_count, -1, 1))
 		return;
 
 	atomic_inc(&fs_info->nr_delayed_iputs);
 	spin_lock(&fs_info->delayed_iput_lock);
-	ASSERT(list_empty(&binode->delayed_iput));
-	list_add_tail(&binode->delayed_iput, &fs_info->delayed_iputs);
+	ASSERT(list_empty(&inode->delayed_iput));
+	list_add_tail(&inode->delayed_iput, &fs_info->delayed_iputs);
 	spin_unlock(&fs_info->delayed_iput_lock);
 	if (!test_bit(BTRFS_FS_CLEANER_RUNNING, &fs_info->flags))
 		wake_up_process(fs_info->cleaner_kthread);
@@ -9660,7 +9659,7 @@ static int start_delalloc_inodes(struct btrfs_root *root,
 					 &work->work);
 		} else {
 			ret = filemap_fdatawrite_wbc(inode->i_mapping, wbc);
-			btrfs_add_delayed_iput(inode);
+			btrfs_add_delayed_iput(BTRFS_I(inode));
 			if (ret || wbc->nr_to_write <= 0)
 				goto out;
 		}
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 8fda1949b71b..4bed0839b640 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -504,7 +504,7 @@ void btrfs_put_ordered_extent(struct btrfs_ordered_extent *entry)
 		ASSERT(list_empty(&entry->log_list));
 		ASSERT(RB_EMPTY_NODE(&entry->rb_node));
 		if (entry->inode)
-			btrfs_add_delayed_iput(entry->inode);
+			btrfs_add_delayed_iput(BTRFS_I(entry->inode));
 		while (!list_empty(&entry->list)) {
 			cur = entry->list.next;
 			sum = list_entry(cur, struct btrfs_ordered_sum, list);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index bdf845077002..6452f4faaa04 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1117,7 +1117,7 @@ int replace_file_extents(struct btrfs_trans_handle *trans,
 				inode = find_next_inode(root, key.objectid);
 				first = 0;
 			} else if (inode && btrfs_ino(BTRFS_I(inode)) < key.objectid) {
-				btrfs_add_delayed_iput(inode);
+				btrfs_add_delayed_iput(BTRFS_I(inode));
 				inode = find_next_inode(root, key.objectid);
 			}
 			if (inode && btrfs_ino(BTRFS_I(inode)) == key.objectid) {
@@ -1181,7 +1181,7 @@ int replace_file_extents(struct btrfs_trans_handle *trans,
 	if (dirty)
 		btrfs_mark_buffer_dirty(leaf);
 	if (inode)
-		btrfs_add_delayed_iput(inode);
+		btrfs_add_delayed_iput(BTRFS_I(inode));
 	return ret;
 }
 
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 8d559b076405..8fcfaf015a70 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5422,7 +5422,7 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
 			}
 
 			if (!need_log_inode(trans, BTRFS_I(di_inode))) {
-				btrfs_add_delayed_iput(di_inode);
+				btrfs_add_delayed_iput(BTRFS_I(di_inode));
 				break;
 			}
 
@@ -5431,7 +5431,7 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
 				log_mode = LOG_INODE_ALL;
 			ret = btrfs_log_inode(trans, BTRFS_I(di_inode),
 					      log_mode, ctx);
-			btrfs_add_delayed_iput(di_inode);
+			btrfs_add_delayed_iput(BTRFS_I(di_inode));
 			if (ret)
 				goto out;
 			if (ctx->log_new_dentries) {
@@ -5625,11 +5625,11 @@ static int add_conflicting_inode(struct btrfs_trans_handle *trans,
 	 * so that the log ends up with the new name and without the old name.
 	 */
 	if (!need_log_inode(trans, BTRFS_I(inode))) {
-		btrfs_add_delayed_iput(inode);
+		btrfs_add_delayed_iput(BTRFS_I(inode));
 		return 0;
 	}
 
-	btrfs_add_delayed_iput(inode);
+	btrfs_add_delayed_iput(BTRFS_I(inode));
 
 	ino_elem = kmalloc(sizeof(*ino_elem), GFP_NOFS);
 	if (!ino_elem)
@@ -5704,7 +5704,7 @@ static int log_conflicting_inodes(struct btrfs_trans_handle *trans,
 			 */
 			ret = btrfs_log_inode(trans, BTRFS_I(inode),
 					      LOG_INODE_ALL, ctx);
-			btrfs_add_delayed_iput(inode);
+			btrfs_add_delayed_iput(BTRFS_I(inode));
 			if (ret)
 				break;
 			continue;
@@ -5721,7 +5721,7 @@ static int log_conflicting_inodes(struct btrfs_trans_handle *trans,
 		 * that, we can avoid doing it again.
 		 */
 		if (!need_log_inode(trans, BTRFS_I(inode))) {
-			btrfs_add_delayed_iput(inode);
+			btrfs_add_delayed_iput(BTRFS_I(inode));
 			continue;
 		}
 
@@ -5733,7 +5733,7 @@ static int log_conflicting_inodes(struct btrfs_trans_handle *trans,
 		 * log with the new name before we unpin it.
 		 */
 		ret = btrfs_log_inode(trans, BTRFS_I(inode), LOG_INODE_EXISTS, ctx);
-		btrfs_add_delayed_iput(inode);
+		btrfs_add_delayed_iput(BTRFS_I(inode));
 		if (ret)
 			break;
 	}
@@ -6243,7 +6243,7 @@ static int log_new_delayed_dentries(struct btrfs_trans_handle *trans,
 		}
 
 		if (!need_log_inode(trans, BTRFS_I(di_inode))) {
-			btrfs_add_delayed_iput(di_inode);
+			btrfs_add_delayed_iput(BTRFS_I(di_inode));
 			continue;
 		}
 
@@ -6256,7 +6256,7 @@ static int log_new_delayed_dentries(struct btrfs_trans_handle *trans,
 		if (!ret && ctx->log_new_dentries)
 			ret = log_new_dir_dentries(trans, BTRFS_I(di_inode), ctx);
 
-		btrfs_add_delayed_iput(di_inode);
+		btrfs_add_delayed_iput(BTRFS_I(di_inode));
 
 		if (ret)
 			break;
@@ -6717,7 +6717,7 @@ static int btrfs_log_all_parents(struct btrfs_trans_handle *trans,
 			}
 
 			if (!need_log_inode(trans, BTRFS_I(dir_inode))) {
-				btrfs_add_delayed_iput(dir_inode);
+				btrfs_add_delayed_iput(BTRFS_I(dir_inode));
 				continue;
 			}
 
@@ -6727,7 +6727,7 @@ static int btrfs_log_all_parents(struct btrfs_trans_handle *trans,
 			if (!ret && ctx->log_new_dentries)
 				ret = log_new_dir_dentries(trans,
 						   BTRFS_I(dir_inode), ctx);
-			btrfs_add_delayed_iput(dir_inode);
+			btrfs_add_delayed_iput(BTRFS_I(dir_inode));
 			if (ret)
 				goto out;
 		}
@@ -6772,7 +6772,7 @@ static int log_new_ancestors(struct btrfs_trans_handle *trans,
 		    need_log_inode(trans, BTRFS_I(inode)))
 			ret = btrfs_log_inode(trans, BTRFS_I(inode),
 					      LOG_INODE_EXISTS, ctx);
-		btrfs_add_delayed_iput(inode);
+		btrfs_add_delayed_iput(BTRFS_I(inode));
 		if (ret)
 			return ret;
 
-- 
2.37.3

