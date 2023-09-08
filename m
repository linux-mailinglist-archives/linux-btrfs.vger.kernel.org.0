Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D11797F20
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 01:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbjIGXQC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Sep 2023 19:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbjIGXQB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Sep 2023 19:16:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4448EBD
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Sep 2023 16:15:57 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 073542185F;
        Thu,  7 Sep 2023 23:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694128556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GTFlID4g3qoVZMbG+k8GbHLyRPkPumwJZHkuDRwP56U=;
        b=BMrGVlZUrszClm7yfXl+jft8jCwpR0iv1uwuVrhkPeg8e2i1Z9/xBlukh7Ymb50HCnB945
        ynD4ax7t+heL/qfYF/MmvFVUSFeubG2j3/mFPRf/MI+v8WeLTFSKxrkjcM5m+uygQVEClN
        kPfJ8rqume2oysbH0suVHtX0oAeT9sg=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id EBC3B2C142;
        Thu,  7 Sep 2023 23:15:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 21ACCDA8C5; Fri,  8 Sep 2023 01:09:25 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 02/10] btrfs: reformat remaining kdoc style comments
Date:   Fri,  8 Sep 2023 01:09:25 +0200
Message-ID: <6f4732200ecc2a0722323f68c91549c10c858c22.1694126893.git.dsterba@suse.com>
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

Function name in the comment does not bring much value to code not
exposed as API and we don't stick to the kdoc format anymore. Update
formatting of parameter descriptions.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.c         |  4 ++--
 fs/btrfs/delayed-inode.c |  6 +++---
 fs/btrfs/delayed-ref.c   |  3 +--
 fs/btrfs/disk-io.c       | 11 ++++++-----
 fs/btrfs/extent-tree.c   |  6 +++---
 fs/btrfs/extent_io.c     | 22 ++++++++++++----------
 fs/btrfs/inode-item.c    |  2 +-
 fs/btrfs/inode.c         |  9 +++++----
 fs/btrfs/locking.c       |  3 ++-
 fs/btrfs/messages.c      |  8 ++++----
 fs/btrfs/ref-verify.c    |  2 +-
 fs/btrfs/root-tree.c     |  6 ++++--
 fs/btrfs/space-info.c    |  3 ++-
 fs/btrfs/transaction.c   |  4 ++--
 fs/btrfs/tree-log.c      |  7 +++----
 fs/btrfs/ulist.c         |  3 ++-
 fs/btrfs/volumes.c       |  3 ++-
 fs/btrfs/zstd.c          | 11 +++++++----
 18 files changed, 62 insertions(+), 51 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index a4cb4b642987..792f9e3afad8 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2054,8 +2054,8 @@ static int search_leaf(struct btrfs_trans_handle *trans,
 }
 
 /*
- * btrfs_search_slot - look for a key in a tree and perform necessary
- * modifications to preserve tree invariants.
+ * Look for a key in a tree and perform necessary modifications to preserve
+ * tree invariants.
  *
  * @trans:	Handle of transaction, used when modifying the tree
  * @p:		Holds all btree nodes along the search path
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index d7ac39a3dd10..3e4fd354d458 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -328,7 +328,8 @@ static struct btrfs_delayed_item *btrfs_alloc_delayed_item(u16 data_len,
 }
 
 /*
- * __btrfs_lookup_delayed_item - look up the delayed item by key
+ * Look up the delayed item by key.
+ *
  * @delayed_node: pointer to the delayed node
  * @index:	  the dir index value to lookup (offset of a dir index key)
  *
@@ -1760,8 +1761,7 @@ int btrfs_should_delete_dir_index(struct list_head *del_list,
 }
 
 /*
- * btrfs_readdir_delayed_dir_index - read dir info stored in the delayed tree
- *
+ * Read dir info stored in the delayed tree.
  */
 int btrfs_readdir_delayed_dir_index(struct dir_context *ctx,
 				    struct list_head *ins_list)
diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 6a13cf00218b..c468148fc437 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -813,8 +813,7 @@ add_delayed_ref_head(struct btrfs_trans_handle *trans,
 }
 
 /*
- * init_delayed_ref_common - Initialize the structure which represents a
- *			     modification to a an extent.
+ * Initialize the structure which represents a modification to a an extent.
  *
  * @fs_info:    Internal to the mounted filesystem mount structure.
  *
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 6404b17a5bdc..489589052f27 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1403,7 +1403,8 @@ struct btrfs_root *btrfs_get_new_fs_root(struct btrfs_fs_info *fs_info,
 }
 
 /*
- * btrfs_get_fs_root_commit_root - return a root for the given objectid
+ * Return a root for the given objectid.
+ *
  * @fs_info:	the fs_info
  * @objectid:	the objectid we need to lookup
  *
@@ -1700,11 +1701,11 @@ static void backup_super_roots(struct btrfs_fs_info *info)
 }
 
 /*
- * read_backup_root - Reads a backup root based on the passed priority. Prio 0
- * is the newest, prio 1/2/3 are 2nd newest/3rd newest/4th (oldest) backup roots
+ * Reads a backup root based on the passed priority. Prio 0 is the newest, prio
+ * 1/2/3 are 2nd newest/3rd newest/4th (oldest) backup roots
  *
- * fs_info - filesystem whose backup roots need to be read
- * priority - priority of backup root required
+ * @fs_info:  filesystem whose backup roots need to be read
+ * @priority: priority of backup root required
  *
  * Returns backup root index on success and -EINVAL otherwise.
  */
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index e4d337b78e76..5ef4e852ae2e 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1435,7 +1435,7 @@ int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 }
 
 /*
- * __btrfs_inc_extent_ref - insert backreference for a given extent
+ * Insert backreference for a given extent.
  *
  * The counterpart is in __btrfs_free_extent(), with examples and more details
  * how it works.
@@ -4440,8 +4440,8 @@ static noinline int find_free_extent(struct btrfs_root *root,
 }
 
 /*
- * btrfs_reserve_extent - entry point to the extent allocator. Tries to find a
- *			  hole that is at least as big as @num_bytes.
+ * Entry point to the extent allocator. Tries to find a hole that is at least
+ * as big as @num_bytes.
  *
  * @root           -	The root that will contain this extent
  *
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ac3fca5a5e41..8156dcc4b1fa 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4249,14 +4249,14 @@ void copy_extent_buffer(const struct extent_buffer *dst,
 }
 
 /*
- * eb_bitmap_offset() - calculate the page and offset of the byte containing the
- * given bit number
- * @eb: the extent buffer
- * @start: offset of the bitmap item in the extent buffer
- * @nr: bit number
- * @page_index: return index of the page in the extent buffer that contains the
- * given bit number
- * @page_offset: return offset into the page given by page_index
+ * Calculate the page and offset of the byte containing the given bit number.
+ *
+ * @eb:           the extent buffer
+ * @start:        offset of the bitmap item in the extent buffer
+ * @nr:           bit number
+ * @page_index:   return index of the page in the extent buffer that contains
+ *                the given bit number
+ * @page_offset:  return offset into the page given by page_index
  *
  * This helper hides the ugliness of finding the byte in an extent buffer which
  * contains a given bit.
@@ -4615,7 +4615,8 @@ int try_release_extent_buffer(struct page *page)
 }
 
 /*
- * btrfs_readahead_tree_block - attempt to readahead a child block
+ * Attempt to readahead a child block.
+ *
  * @fs_info:	the fs_info
  * @bytenr:	bytenr to read
  * @owner_root: objectid of the root that owns this eb
@@ -4654,7 +4655,8 @@ void btrfs_readahead_tree_block(struct btrfs_fs_info *fs_info,
 }
 
 /*
- * btrfs_readahead_node_child - readahead a node's child block
+ * Readahead a node's child block.
+ *
  * @node:	parent node we're reading from
  * @slot:	slot in the parent node for the child we want to read
  *
diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index 4c322b720a80..c19c0f10f0e2 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -247,7 +247,7 @@ int btrfs_del_inode_ref(struct btrfs_trans_handle *trans,
 }
 
 /*
- * btrfs_insert_inode_extref() - Inserts an extended inode ref into a tree.
+ * Insert an extended inode ref into a tree.
  *
  * The caller must have checked against BTRFS_LINK_MAX already.
  */
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f09fbdc43f0f..032265d0946a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -348,7 +348,7 @@ static void __cold btrfs_print_data_csum_error(struct btrfs_inode *inode,
 }
 
 /*
- * btrfs_inode_lock - lock inode i_rwsem based on arguments passed
+ * Lock inode i_rwsem based on arguments passed.
  *
  * ilock_flags can have the following bit set:
  *
@@ -382,7 +382,7 @@ int btrfs_inode_lock(struct btrfs_inode *inode, unsigned int ilock_flags)
 }
 
 /*
- * btrfs_inode_unlock - unock inode i_rwsem
+ * Unock inode i_rwsem.
  *
  * ilock_flags should contain the same bits set as passed to btrfs_inode_lock()
  * to decide whether the lock acquired is shared or exclusive.
@@ -3310,7 +3310,7 @@ bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
 }
 
 /*
- * btrfs_add_delayed_iput - perform a delayed iput on @inode
+ * Perform a delayed iput on @inode.
  *
  * @inode: The inode we want to perform iput on
  *
@@ -4645,7 +4645,8 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
 }
 
 /*
- * btrfs_truncate_block - read, zero a chunk and write a block
+ * Read, zero a chunk and write a block.
+ *
  * @inode - inode that we're zeroing
  * @from - the offset to start zeroing
  * @len - the length to zero, 0 to zero the entire range respective to the
diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index 79a125c0f4a2..c3128cdf1177 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -182,7 +182,8 @@ void btrfs_tree_read_unlock(struct extent_buffer *eb)
 }
 
 /*
- * __btrfs_tree_lock - lock eb for write
+ * Lock eb for write.
+ *
  * @eb:		the eb to lock
  * @nest:	the nesting to use for the lock
  *
diff --git a/fs/btrfs/messages.c b/fs/btrfs/messages.c
index 7695decc7243..5be060cb6ef5 100644
--- a/fs/btrfs/messages.c
+++ b/fs/btrfs/messages.c
@@ -110,8 +110,8 @@ const char * __attribute_const__ btrfs_decode_error(int errno)
 }
 
 /*
- * __btrfs_handle_fs_error decodes expected errors from the caller and
- * invokes the appropriate error response.
+ * Decodes expected errors from the caller and invokes the appropriate error
+ * response.
  */
 __cold
 void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char *function,
@@ -283,8 +283,8 @@ void __cold btrfs_err_32bit_limit(struct btrfs_fs_info *fs_info)
 #endif
 
 /*
- * __btrfs_panic decodes unexpected, fatal errors from the caller, issues an
- * alert, and either panics or BUGs, depending on mount options.
+ * Decode unexpected, fatal errors from the caller, issue an alert, and either
+ * panic or BUGs, depending on mount options.
  */
 __cold
 void __btrfs_panic(struct btrfs_fs_info *fs_info, const char *function,
diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index 95d28497de7c..26a7fb655f71 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -652,7 +652,7 @@ static void dump_block_entry(struct btrfs_fs_info *fs_info,
 }
 
 /*
- * btrfs_ref_tree_mod: called when we modify a ref for a bytenr
+ * Called when we modify a ref for a bytenr.
  *
  * This will add an action item to the given bytenr and do sanity checks to make
  * sure we haven't messed something up.  If we are making a new allocation and
diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index 859874579456..db992f7a5d38 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -51,7 +51,8 @@ static void btrfs_read_root_item(struct extent_buffer *eb, int slot,
 }
 
 /*
- * btrfs_find_root - lookup the root by the key.
+ * Lookup the root by the key.
+ *
  * root: the root of the root tree
  * search_key: the key to search
  * path: the path we search
@@ -485,7 +486,8 @@ void btrfs_update_root_times(struct btrfs_trans_handle *trans,
 }
 
 /*
- * btrfs_subvolume_reserve_metadata() - reserve space for subvolume operation
+ * Reserve space for subvolume operation.
+ *
  * root: the root of the parent directory
  * rsv: block reservation
  * items: the number of items that we need do reservation
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index d7e8cd4f140c..58de9a14e525 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -978,7 +978,8 @@ static bool steal_from_global_rsv(struct btrfs_fs_info *fs_info,
 }
 
 /*
- * maybe_fail_all_tickets - we've exhausted our flushing, start failing tickets
+ * We've exhausted our flushing, start failing tickets.
+ *
  * @fs_info - fs_info for this fs
  * @space_info - the space info we were flushing
  *
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 0bf42dccb041..035e7f5747cd 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -817,7 +817,7 @@ struct btrfs_trans_handle *btrfs_join_transaction_nostart(struct btrfs_root *roo
 }
 
 /*
- * btrfs_attach_transaction() - catch the running transaction
+ * Catch the running transaction.
  *
  * It is used when we want to commit the current the transaction, but
  * don't want to start a new one.
@@ -836,7 +836,7 @@ struct btrfs_trans_handle *btrfs_attach_transaction(struct btrfs_root *root)
 }
 
 /*
- * btrfs_attach_transaction_barrier() - catch the running transaction
+ * Catch the running transaction.
  *
  * It is similar to the above function, the difference is this one
  * will wait for all the inactive transactions until they fully
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index cbb17b542131..1834a6ec12bd 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2848,10 +2848,9 @@ static inline void btrfs_remove_all_log_ctxs(struct btrfs_root *root,
 }
 
 /*
- * btrfs_sync_log does sends a given tree log down to the disk and
- * updates the super blocks to record it.  When this call is done,
- * you know that any inodes previously logged are safely on disk only
- * if it returns 0.
+ * Sends a given tree log down to the disk and updates the super blocks to
+ * record it.  When this call is done, you know that any inodes previously
+ * logged are safely on disk only if it returns 0.
  *
  * Any other return value means you need to call btrfs_commit_transaction.
  * Some of the edge cases for fsyncing directories that have had unlinks
diff --git a/fs/btrfs/ulist.c b/fs/btrfs/ulist.c
index 33606025513d..b4ac2b0cd235 100644
--- a/fs/btrfs/ulist.c
+++ b/fs/btrfs/ulist.c
@@ -223,7 +223,8 @@ int ulist_add_merge(struct ulist *ulist, u64 val, u64 aux,
 }
 
 /*
- * ulist_del - delete one node from ulist
+ * Delete one node from ulist.
+ *
  * @ulist:	ulist to remove node from
  * @val:	value to delete
  * @aux:	aux to delete
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1325f76fbd50..871a55d36e32 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3027,7 +3027,8 @@ static int btrfs_del_sys_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset)
 }
 
 /*
- * btrfs_get_chunk_map() - Find the mapping containing the given logical extent.
+ * Find the mapping containing the given logical extent.
+ *
  * @logical: Logical block offset in bytes.
  * @length: Length of extent in bytes.
  *
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index e7ac4ec809a4..5511766485cd 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -145,7 +145,7 @@ static void zstd_reclaim_timer_fn(struct timer_list *timer)
 }
 
 /*
- * zstd_calc_ws_mem_sizes - calculate monotonic memory bounds
+ * Calculate monotonic memory bounds.
  *
  * It is possible based on the level configurations that a higher level
  * workspace uses less memory than a lower level workspace.  In order to reuse
@@ -218,7 +218,8 @@ void zstd_cleanup_workspace_manager(void)
 }
 
 /*
- * zstd_find_workspace - find workspace
+ * Find workspace for given level.
+ *
  * @level: compression level
  *
  * This iterates over the set bits in the active_map beginning at the requested
@@ -256,7 +257,8 @@ static struct list_head *zstd_find_workspace(unsigned int level)
 }
 
 /*
- * zstd_get_workspace - zstd's get_workspace
+ * Zstd get_workspace for level.
+ *
  * @level: compression level
  *
  * If @level is 0, then any compression level can be used.  Therefore, we begin
@@ -296,7 +298,8 @@ struct list_head *zstd_get_workspace(unsigned int level)
 }
 
 /*
- * zstd_put_workspace - zstd put_workspace
+ * Zstd put_workspace.
+ *
  * @ws: list_head for the workspace
  *
  * When putting back a workspace, we only need to update the LRU if we are of
-- 
2.41.0

