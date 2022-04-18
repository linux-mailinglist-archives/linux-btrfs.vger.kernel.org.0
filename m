Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1DC505298
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Apr 2022 14:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239040AbiDRMuG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Apr 2022 08:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239702AbiDRMqy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Apr 2022 08:46:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B8829CA7
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Apr 2022 05:33:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 09D6F1F37E;
        Mon, 18 Apr 2022 12:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650285188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=7UYLQ/ykyfV7LXCT8d1d97TnB5jimtavllgYnPIYqqs=;
        b=XXARhKr0uDHDaBKwssVOMKfFfW/i1zyyTuOJfn489wcMY6oDt/t6LBsPm42R9mMuaVGBJe
        B9FBJc1bO+rTMnWv4mVyadNi4zQ3Ams9BNtWUWxVjdvpEnmWtpjwUPPjetcFwBAaHUhGr7
        RGvXPZiPDJMLZWNLmzuMHYmcqHmWX3c=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BF3DB13ACB;
        Mon, 18 Apr 2022 12:33:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TM3cKoNaXWKHKAAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 18 Apr 2022 12:33:07 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: kernel-doc fixes to make btrfs W=1 clean
Date:   Mon, 18 Apr 2022 15:33:05 +0300
Message-Id: <20220418123305.1418876-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With some minor adjustments to existing comments fs/btrfs/ is actually W=1 clean.
This change involves mainly adding function names in the kernel-doc as well as
making some comments not be a kernel-doc (i.e for static functions).

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/backref.c          |  3 +--
 fs/btrfs/block-group.c      |  3 +--
 fs/btrfs/ctree.c            |  3 +--
 fs/btrfs/delalloc-space.c   |  7 +++----
 fs/btrfs/delayed-ref.c      |  9 +++------
 fs/btrfs/discard.c          |  2 +-
 fs/btrfs/extent_io.c        | 19 ++++++++-----------
 fs/btrfs/extent_map.c       |  6 ++----
 fs/btrfs/file-item.c        | 15 +++++----------
 fs/btrfs/free-space-cache.c |  2 +-
 fs/btrfs/inode.c            |  5 ++---
 fs/btrfs/ordered-data.c     |  3 +--
 fs/btrfs/space-info.c       |  9 ++++-----
 fs/btrfs/tree-log.c         |  5 ++---
 fs/btrfs/volumes.c          |  4 ++--
 fs/btrfs/zstd.c             |  2 +-
 16 files changed, 38 insertions(+), 59 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index ebc392ea1d74..641f92ed99fd 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1512,8 +1512,7 @@ int btrfs_find_all_roots(struct btrfs_trans_handle *trans,
 }

 /**
- * Check if an extent is shared or not
- *
+ * btrfs_check_shared -  Check if an extent is shared or not
  * @root:   root inode belongs to
  * @inum:   inode number of the inode whose extent we are checking
  * @bytenr: logical bytenr of the extent we are checking
diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 571c30a7fe0f..5680da10898d 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1746,8 +1746,7 @@ static void set_avail_alloc_bits(struct btrfs_fs_info *fs_info, u64 flags)
 }

 /**
- * Map a physical disk address to a list of logical addresses
- *
+ * btrfs_rmap_block - Map a physical disk address to a list of logical addresses
  * @fs_info:       the filesystem
  * @chunk_start:   logical address of block group
  * @bdev:	   physical device to resolve, can be NULL to indicate any device
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 1e24695ede0a..2c69e8951d66 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2305,8 +2305,7 @@ int btrfs_search_backwards(struct btrfs_root *root, struct btrfs_key *key,
 }

 /**
- * Search for a valid slot for the given path.
- *
+ * btrfs_get_next_valid_item  - Search for a valid slot for the given path.
  * @root:	The root node of the tree.
  * @key:	Will contain a valid item if found.
  * @path:	The starting point to validate the slot.
diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index 36ab0859a263..cc251e748213 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -193,7 +193,7 @@ void btrfs_free_reserved_data_space(struct btrfs_inode *inode,
 	btrfs_qgroup_free_data(inode, reserved, start, len);
 }

-/**
+/*
  * Release any excessive reservation
  *
  * @inode:       the inode we need to release from
@@ -369,8 +369,7 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes,
 }

 /**
- * Release a metadata reservation for an inode
- *
+ * btrfs_delalloc_release_metadata - Release a metadata reservation for an inode
  * @inode: the inode to release the reservation for.
  * @num_bytes: the number of bytes we are releasing.
  * @qgroup_free: free qgroup reservation or convert it to per-trans reservation
@@ -467,7 +466,7 @@ int btrfs_delalloc_reserve_space(struct btrfs_inode *inode,
 }

 /**
- * Release data and metadata space for delalloc
+ * btrfs_delalloc_release_space - Release data and metadata space for delalloc
  *
  * @inode:       inode we're releasing space for
  * @reserved:    list of changed/reserved ranges
diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 4176df149d04..44f4c11a72fe 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -70,8 +70,7 @@ int btrfs_should_throttle_delayed_refs(struct btrfs_trans_handle *trans)
 }

 /**
- * Release a ref head's reservation
- *
+ * btrfs_delayed_refs_rsv_release - Release a ref head's reservation
  * @fs_info:  the filesystem
  * @nr:       number of items to drop
  *
@@ -138,8 +137,7 @@ void btrfs_update_delayed_refs_rsv(struct btrfs_trans_handle *trans)
 }

 /**
- * Transfer bytes to our delayed refs rsv
- *
+ * btrfs_migrate_to_delayed_refs_rsv - Transfer bytes to our delayed refs rsv
  * @fs_info:   the filesystem
  * @src:       source block rsv to transfer from
  * @num_bytes: number of bytes to transfer
@@ -187,8 +185,7 @@ void btrfs_migrate_to_delayed_refs_rsv(struct btrfs_fs_info *fs_info,
 }

 /**
- * Refill based on our delayed refs usage
- *
+ * btrfs_delayed_refs_rsv_refill - Refill based on our delayed refs usage
  * @fs_info: the filesystem
  * @flush:   control how we can flush for this reservation.
  *
diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index e1b7bd927d69..a23b1ffc26e4 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -184,7 +184,7 @@ static struct btrfs_block_group *find_next_block_group(
 	return ret_block_group;
 }

-/**
+/*
  * Wrap find_next_block_group()
  *
  * @discard_ctl:   discard control
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 779123e68d7b..aa124c2a604e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -400,7 +400,7 @@ static struct rb_node *tree_insert(struct rb_root *root,
 	return NULL;
 }

-/**
+/*
  * Search @tree for an entry that contains @offset. Such entry would have
  * entry->start <= offset && entry->end >= offset.
  *
@@ -1600,8 +1600,7 @@ int find_first_extent_bit(struct extent_io_tree *tree, u64 start,
 }

 /**
- * Find a contiguous area of bits
- *
+ * find_contiguous_extent_bit - Find a contiguous area of bits
  * @tree:      io tree to check
  * @start:     offset to start the search from
  * @start_ret: the first offset we found with the bits set
@@ -1638,9 +1637,8 @@ int find_contiguous_extent_bit(struct extent_io_tree *tree, u64 start,
 }

 /**
- * Find the first range that has @bits not set. This range could start before
- * @start.
- *
+ * find_first_clear_extent_bit - Find the first range that has @bits not set.
+ *				 This range could start before @start.
  * @tree:      the tree to search
  * @start:     offset at/after which the found extent should start
  * @start_ret: records the beginning of the range
@@ -3137,8 +3135,7 @@ static void end_bio_extent_readpage(struct bio *bio)
 }

 /**
- * Populate every free slot in a provided array with pages.
- *
+ * btrfs_alloc_page_array - Populate every free slot in a provided array with pages.
  * @nr_pages:   number of pages to allocate
  * @page_array: the array to fill with pages; any existing non-null entries in
  * 		the array will be skipped
@@ -3229,7 +3226,7 @@ struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size)
 	return bio;
 }

-/**
+/*
  * Attempt to add a page to bio
  *
  * @bio_ctrl:	record both the bio, and its bio_flags
@@ -4959,7 +4956,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 	return ret;
 }

-/**
+/*
  * Walk the list of dirty pages of the given address space and write all of them.
  *
  * @mapping: address space structure to write
@@ -7501,7 +7498,7 @@ void btrfs_readahead_tree_block(struct btrfs_fs_info *fs_info,
 		free_extent_buffer(eb);
 }

-/*
+/**
  * btrfs_readahead_node_child - readahead a node's child block
  * @node:	parent node we're reading from
  * @slot:	slot in the parent node for the child we want to read
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 6fee14ce2e6b..95614ec97b89 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -387,8 +387,7 @@ static void extent_map_device_clear_bits(struct extent_map *em, unsigned bits)
 }

 /**
- * Add new extent map to the extent tree
- *
+ * add_extent_mapping - Add new extent map to the extent tree
  * @tree:	tree to insert new map in
  * @em:		map to insert
  * @modified:	indicate whether the given @em should be added to the
@@ -583,8 +582,7 @@ static noinline int merge_extent_mapping(struct extent_map_tree *em_tree,
 }

 /**
- * Add extent mapping into em_tree
- *
+ * btrfs_add_extent_mapping - Add extent mapping into em_tree
  * @fs_info:  the filesystem
  * @em_tree:  extent tree into which we want to insert the extent mapping
  * @em_in:    extent we are inserting
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index c828f971a346..671af3b37c7a 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -25,8 +25,7 @@
 				       PAGE_SIZE))

 /**
- * Set inode's size according to filesystem options
- *
+ * btrfs_inode_safe_disk_i_size_write - Set inode's size according to filesystem options
  * @inode:      inode we want to update the disk_i_size for
  * @new_i_size: i_size we want to set to, 0 if we use i_size
  *
@@ -65,8 +64,7 @@ void btrfs_inode_safe_disk_i_size_write(struct btrfs_inode *inode, u64 new_i_siz
 }

 /**
- * Mark range within a file as having a new extent inserted
- *
+ * btrfs_inode_set_file_extent_range - Mark range within a file as having a new extent inserted
  * @inode: inode being modified
  * @start: start file offset of the file extent we've inserted
  * @len:   logical length of the file extent item
@@ -93,8 +91,7 @@ int btrfs_inode_set_file_extent_range(struct btrfs_inode *inode, u64 start,
 }

 /**
- * Marks an inode range as not having a backing extent
- *
+ * btrfs_inode_clear_file_extent_range - Marks an inode range as not having a backing extent
  * @inode: inode being modified
  * @start: start file offset of the file extent we've inserted
  * @len:   logical length of the file extent item
@@ -353,8 +350,7 @@ static int search_file_offset_in_bio(struct bio *bio, struct inode *inode,
 }

 /**
- * Lookup the checksum for the read bio in csum tree.
- *
+ * btrfs_lookup_bio_sums - Lookup the checksum for the read bio in csum tree.
  * @inode: inode that the bio is for.
  * @bio: bio to look up.
  * @dst: Buffer of size nblocks * btrfs_super_csum_size() used to return
@@ -621,8 +617,7 @@ int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
 }

 /**
- * Calculate checksums of the data contained inside a bio
- *
+ * btrfs_csum_one_bio - Calculate checksums of the data contained inside a bio
  * @inode:	 Owner of the data inside the bio
  * @bio:	 Contains the data to be checksummed
  * @offset:      If (u64)-1, @bio may contain discontiguous bio vecs, so the
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index f7adee6fa05e..ccbbea058ce6 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1323,7 +1323,7 @@ int btrfs_wait_cache_io(struct btrfs_trans_handle *trans,
 				     path, block_group->start);
 }

-/**
+/*
  * Write out cached info to an inode
  *
  * @root:        root the inode belongs to
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 29879fb257d5..e6004c474917 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3501,7 +3501,7 @@ void btrfs_run_delayed_iputs(struct btrfs_fs_info *fs_info)
 }

 /**
- * Wait for flushing all delayed iputs
+ * btrfs_wait_on_delayed_iputs - Wait for flushing all delayed iputs
  *
  * @fs_info:  the filesystem
  *
@@ -11327,8 +11327,7 @@ void btrfs_update_inode_bytes(struct btrfs_inode *inode,
 }

 /**
- * Verify that there are no ordered extents for a given file range.
- *
+ * btrfs_assert_inode_range_clean - Verify that there are no ordered extents for a given file range.
  * @inode:   The target inode.
  * @start:   Start offset of the file range, should be sector size aligned.
  * @end:     End offset (inclusive) of the file range, its value +1 should be
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 1957b14b329a..30f6bc28eaf8 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -144,8 +144,7 @@ static inline struct rb_node *tree_search(struct btrfs_ordered_inode_tree *tree,
 }

 /**
- * Add an ordered extent to the per-inode tree.
- *
+ * btrfs_add_ordered_extent - Add an ordered extent to the per-inode tree.
  * @inode:           Inode that this extent is for.
  * @file_offset:     Logical offset in file where the extent starts.
  * @num_bytes:       Logical length of extent in file.
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 2dd8754cb990..92f0ce112ade 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1378,7 +1378,7 @@ static void wait_reserve_ticket(struct btrfs_fs_info *fs_info,
 	spin_unlock(&space_info->lock);
 }

-/**
+/*
  * Do the appropriate flushing and waiting for a ticket
  *
  * @fs_info:    the filesystem
@@ -1471,7 +1471,7 @@ static inline bool can_steal(enum btrfs_reserve_flush_enum flush)
 		flush == BTRFS_RESERVE_FLUSH_EVICT);
 }

-/**
+/*
  * Try to reserve bytes from the block_rsv's space
  *
  * @fs_info:    the filesystem
@@ -1598,8 +1598,7 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 }

 /**
- * Trye to reserve metadata bytes from the block_rsv's space
- *
+ * btrfs_reserve_metadata_bytes - Try to reserve metadata bytes from the block_rsv's space
  * @fs_info:    the filesystem
  * @block_rsv:  block_rsv we're allocating for
  * @orig_bytes: number of bytes we want
@@ -1633,7 +1632,7 @@ int btrfs_reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
 }

 /**
- * Try to reserve data bytes for an allocation
+ * btrfs_reserve_data_bytes - Try to reserve data bytes for an allocation
  *
  * @fs_info: the filesystem
  * @bytes:   number of bytes we need
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index e356334ef797..e131e34dac51 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3040,7 +3040,7 @@ static inline void btrfs_remove_log_ctx(struct btrfs_root *root,
 	mutex_unlock(&root->log_mutex);
 }

-/*
+/*
  * Invoked in log mutex context, or be sure there is no other task which
  * can access the list.
  */
@@ -6931,8 +6931,7 @@ void btrfs_record_snapshot_destroy(struct btrfs_trans_handle *trans,
 }

 /**
- * Update the log after adding a new name for an inode.
- *
+ * btrfs_log_new_name - Update the log after adding a new name for an inode.
  * @trans:              Transaction handle.
  * @old_dentry:         The dentry associated with the old name and the old
  *                      parent directory.
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 2368a2ffbee7..19fec1b3446b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -534,7 +534,7 @@ btrfs_get_bdev_and_sb(const char *device_path, fmode_t flags, void *holder,
 	return ret;
 }

-/**
+/*
  *  Search and remove all stale devices (which are not mounted).
  *  When both inputs are NULL, it will search and release all stale devices.
  *
@@ -2316,7 +2316,7 @@ void btrfs_destroy_dev_replace_tgtdev(struct btrfs_device *tgtdev)
 }

 /**
- * Populate args from device at path
+ * btrfs_get_dev_args_from_path - Populate args from device at path
  *
  * @fs_info:	the filesystem
  * @args:	the args to populate
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 0fe31a6f6e68..ca2102a46fae 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -94,7 +94,7 @@ static inline struct workspace *list_to_workspace(struct list_head *list)
 void zstd_free_workspace(struct list_head *ws);
 struct list_head *zstd_alloc_workspace(unsigned int level);

-/**
+/*
  * Timer callback to free unused workspaces.
  *
  * @t: timer
--
2.25.1

