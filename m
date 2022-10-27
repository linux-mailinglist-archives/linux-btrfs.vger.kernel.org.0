Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B504F60F73E
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Oct 2022 14:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235603AbiJ0M3R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Oct 2022 08:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235609AbiJ0M3M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Oct 2022 08:29:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE28F15380D
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Oct 2022 05:29:07 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 441F62189E;
        Thu, 27 Oct 2022 12:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666873746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=GzRLzPv6Mf+fA6Qsmd7rh2K/tl72E/fjq6zB4s7pLl0=;
        b=o/ldb0BnsGCn8JaqDafz9+AkmRIJe58/ol3AYQ3fUOQriY7u9m6OIpJJ2dcAxSANFHmrdm
        MGsqddi4rxiU0c2J6HQhFmXqd2Z6X/M7qmPmlsiCWxkcl7p523XhY6wvTDybDX7yYtXKWh
        4kV++GNenvMMaYIZqUwVLxxMK41+9T4=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 3081B2C141;
        Thu, 27 Oct 2022 12:29:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 800CFDA79B; Thu, 27 Oct 2022 14:28:52 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: update function comments
Date:   Thu, 27 Oct 2022 14:28:51 +0200
Message-Id: <20221027122851.15926-1-dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Update, reformat or reword function comments. This also removes the kdoc
marker so we don't get reports when the function name is missing.

Changes made:

- remove kdoc markers
- reformat the brief description to be a proper sentence
- reword to imperative voice
- align parameter list
- fix typos

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/block-group.c      |  20 +++----
 fs/btrfs/ctree.c            |  11 ++--
 fs/btrfs/delalloc-space.c   |  59 +++++++++----------
 fs/btrfs/delayed-ref.c      |  19 +++---
 fs/btrfs/discard.c          | 111 ++++++++++++++++++++----------------
 fs/btrfs/extent_io.c        |  59 ++++++++++---------
 fs/btrfs/extent_map.c       |  65 ++++++++++-----------
 fs/btrfs/file-item.c        |  50 ++++++++--------
 fs/btrfs/free-space-cache.c |   9 +--
 fs/btrfs/inode.c            |  14 ++---
 fs/btrfs/ioctl.c            |   2 +-
 fs/btrfs/ordered-data.c     |  13 +++--
 fs/btrfs/raid56.c           |   4 +-
 fs/btrfs/reflink.c          |  18 +++---
 fs/btrfs/space-info.c       |  16 +++---
 fs/btrfs/tree-log.c         |   2 +-
 fs/btrfs/ulist.c            |  35 +++++++-----
 fs/btrfs/volumes.c          |  43 +++++++-------
 fs/btrfs/zoned.c            |   6 +-
 fs/btrfs/zstd.c             |   2 +-
 20 files changed, 289 insertions(+), 269 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 5a743c4d4e97..cfe495d39ebd 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -299,7 +299,7 @@ struct btrfs_block_group *btrfs_next_block_group(
 	return cache;
 }
 
-/**
+/*
  * Check if we can do a NOCOW write for a given extent.
  *
  * @fs_info:       The filesystem information object.
@@ -340,11 +340,9 @@ struct btrfs_block_group *btrfs_inc_nocow_writers(struct btrfs_fs_info *fs_info,
 	return bg;
 }
 
-/**
+/*
  * Decrement the number of NOCOW writers in a block group.
  *
- * @bg:       The block group.
- *
  * This is meant to be called after a previous call to btrfs_inc_nocow_writers(),
  * and on the block group returned by that call. Typically this is called after
  * creating an ordered extent for a NOCOW write, to prevent races with scrub and
@@ -1813,8 +1811,8 @@ static void set_avail_alloc_bits(struct btrfs_fs_info *fs_info, u64 flags)
 	write_sequnlock(&fs_info->profiles_lock);
 }
 
-/**
- * Map a physical disk address to a list of logical addresses
+/*
+ * Map a physical disk address to a list of logical addresses.
  *
  * @fs_info:       the filesystem
  * @chunk_start:   logical address of block group
@@ -3421,8 +3419,9 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-/**
- * btrfs_add_reserved_bytes - update the block_group and space info counters
+/*
+ * Update the block_group and space info counters.
+ *
  * @cache:	The cache we are manipulating
  * @ram_bytes:  The number of bytes of file content, and will be same to
  *              @num_bytes except for the compress path.
@@ -3465,8 +3464,9 @@ int btrfs_add_reserved_bytes(struct btrfs_block_group *cache,
 	return ret;
 }
 
-/**
- * btrfs_free_reserved_bytes - update the block_group and space info counters
+/*
+ * Update the block_group and space info counters.
+ *
  * @cache:      The cache we are manipulating
  * @num_bytes:  The number of bytes in question
  * @delalloc:   The blocks are allocated for the delalloc write
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 140257f22c69..b1a34a1c66c0 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2347,7 +2347,7 @@ int btrfs_search_backwards(struct btrfs_root *root, struct btrfs_key *key,
 	return ret;
 }
 
-/**
+/*
  * Search for a valid slot for the given path.
  *
  * @root:	The root node of the tree.
@@ -3969,14 +3969,15 @@ void btrfs_extend_item(struct btrfs_path *path, u32 data_size)
 	}
 }
 
-/**
- * setup_items_for_insert - Helper called before inserting one or more items
- * to a leaf. Main purpose is to save stack depth by doing the bulk of the work
- * in a function that doesn't call btrfs_search_slot
+/*
+ * Make space in the node before inserting one or more items.
  *
  * @root:	root we are inserting items to
  * @path:	points to the leaf/slot where we are going to insert new items
  * @batch:      information about the batch of items to insert
+ *
+ * Main purpose is to save stack depth by doing the bulk of the work in a
+ * function that doesn't call btrfs_search_slot
  */
 static void setup_items_for_insert(struct btrfs_root *root, struct btrfs_path *path,
 				   const struct btrfs_item_batch *batch)
diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index 605d8874a446..7ddb1d104e8e 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -202,8 +202,8 @@ void btrfs_free_reserved_data_space(struct btrfs_inode *inode,
 	btrfs_qgroup_free_data(inode, reserved, start, len);
 }
 
-/**
- * Release any excessive reservation
+/*
+ * Release any excessive reservations for an inode.
  *
  * @inode:       the inode we need to release from
  * @qgroup_free: free or convert qgroup meta. Unlike normal operation, qgroup
@@ -377,12 +377,12 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes,
 	return 0;
 }
 
-/**
- * Release a metadata reservation for an inode
+/*
+ * Release a metadata reservation for an inode.
  *
- * @inode: the inode to release the reservation for.
- * @num_bytes: the number of bytes we are releasing.
- * @qgroup_free: free qgroup reservation or convert it to per-trans reservation
+ * @inode:        the inode to release the reservation for.
+ * @num_bytes:    the number of bytes we are releasing.
+ * @qgroup_free:  free qgroup reservation or convert it to per-trans reservation
  *
  * This will release the metadata reservation for an inode.  This can be called
  * once we complete IO for a given set of bytes to release their metadata
@@ -405,10 +405,11 @@ void btrfs_delalloc_release_metadata(struct btrfs_inode *inode, u64 num_bytes,
 	btrfs_inode_rsv_release(inode, qgroup_free);
 }
 
-/**
- * btrfs_delalloc_release_extents - release our outstanding_extents
- * @inode: the inode to balance the reservation for.
- * @num_bytes: the number of bytes we originally reserved with
+/*
+ * Release our outstanding_extents for an inode.
+ *
+ * @inode:      the inode to balance the reservation for.
+ * @num_bytes:  the number of bytes we originally reserved with
  *
  * When we reserve space we increase outstanding_extents for the extents we may
  * add.  Once we've set the range as delalloc or created our ordered extents we
@@ -433,30 +434,30 @@ void btrfs_delalloc_release_extents(struct btrfs_inode *inode, u64 num_bytes)
 	btrfs_inode_rsv_release(inode, true);
 }
 
-/**
- * btrfs_delalloc_reserve_space - reserve data and metadata space for
- * delalloc
- * @inode: inode we're writing to
- * @start: start range we are writing to
- * @len: how long the range we are writing to
- * @reserved: mandatory parameter, record actually reserved qgroup ranges of
- * 	      current reservation.
+/*
+ * Reserve data and metadata space for delalloc
+ *
+ * @inode:     inode we're writing to
+ * @start:     start range we are writing to
+ * @len:       how long the range we are writing to
+ * @reserved:  mandatory parameter, record actually reserved qgroup ranges of
+ * 	       current reservation.
  *
  * This will do the following things
  *
- * - reserve space in data space info for num bytes
- *   and reserve precious corresponding qgroup space
+ * - reserve space in data space info for num bytes and reserve precious
+ *   corresponding qgroup space
  *   (Done in check_data_free_space)
  *
  * - reserve space for metadata space, based on the number of outstanding
- *   extents and how much csums will be needed
- *   also reserve metadata space in a per root over-reserve method.
+ *   extents and how much csums will be needed also reserve metadata space in a
+ *   per root over-reserve method.
  * - add to the inodes->delalloc_bytes
  * - add it to the fs_info's delalloc inodes list.
  *   (Above 3 all done in delalloc_reserve_metadata)
  *
  * Return 0 for success
- * Return <0 for error(-ENOSPC or -EQUOT)
+ * Return <0 for error(-ENOSPC or -EDQUOT)
  */
 int btrfs_delalloc_reserve_space(struct btrfs_inode *inode,
 			struct extent_changeset **reserved, u64 start, u64 len)
@@ -475,7 +476,7 @@ int btrfs_delalloc_reserve_space(struct btrfs_inode *inode,
 	return ret;
 }
 
-/**
+/*
  * Release data and metadata space for delalloc
  *
  * @inode:       inode we're releasing space for
@@ -484,10 +485,10 @@ int btrfs_delalloc_reserve_space(struct btrfs_inode *inode,
  * @len:         length of the space already reserved
  * @qgroup_free: should qgroup reserved-space also be freed
  *
- * This function will release the metadata space that was not used and will
- * decrement ->delalloc_bytes and remove it from the fs_info delalloc_inodes
- * list if there are no delalloc bytes left.
- * Also it will handle the qgroup reserved space.
+ * Release the metadata space that was not used and will decrement
+ * ->delalloc_bytes and remove it from the fs_info->delalloc_inodes list if
+ * there are no delalloc bytes left.  Also it will handle the qgroup reserved
+ * space.
  */
 void btrfs_delalloc_release_space(struct btrfs_inode *inode,
 				  struct extent_changeset *reserved,
diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 010cc16297d8..573ebab886e2 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -71,14 +71,14 @@ int btrfs_should_throttle_delayed_refs(struct btrfs_trans_handle *trans)
 	return btrfs_check_space_for_delayed_refs(trans->fs_info);
 }
 
-/**
- * Release a ref head's reservation
+/*
+ * Release a ref head's reservation.
  *
  * @fs_info:  the filesystem
  * @nr:       number of items to drop
  *
- * This drops the delayed ref head's count from the delayed refs rsv and frees
- * any excess reservation we had.
+ * Drops the delayed ref head's count from the delayed refs rsv and free any
+ * excess reservation we had.
  */
 void btrfs_delayed_refs_rsv_release(struct btrfs_fs_info *fs_info, int nr)
 {
@@ -104,8 +104,7 @@ void btrfs_delayed_refs_rsv_release(struct btrfs_fs_info *fs_info, int nr)
 }
 
 /*
- * btrfs_update_delayed_refs_rsv - adjust the size of the delayed refs rsv
- * @trans - the trans that may have generated delayed refs
+ * Adjust the size of the delayed refs rsv.
  *
  * This is to be called anytime we may have adjusted trans->delayed_ref_updates,
  * it'll calculate the additional size and add it to the delayed_refs_rsv.
@@ -139,8 +138,8 @@ void btrfs_update_delayed_refs_rsv(struct btrfs_trans_handle *trans)
 	trans->delayed_ref_updates = 0;
 }
 
-/**
- * Transfer bytes to our delayed refs rsv
+/*
+ * Transfer bytes to our delayed refs rsv.
  *
  * @fs_info:   the filesystem
  * @src:       source block rsv to transfer from
@@ -188,8 +187,8 @@ void btrfs_migrate_to_delayed_refs_rsv(struct btrfs_fs_info *fs_info,
 				delayed_refs_rsv->space_info, to_free);
 }
 
-/**
- * Refill based on our delayed refs usage
+/*
+ * Refill based on our delayed refs usage.
  *
  * @fs_info: the filesystem
  * @flush:   control how we can flush for this reservation.
diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index 51f0ef386046..ff2e524d9937 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -62,7 +62,7 @@
 #define BTRFS_DISCARD_MAX_DELAY_MSEC	(1000UL)
 #define BTRFS_DISCARD_MAX_IOPS		(10U)
 
-/* Montonically decreasing minimum length filters after index 0 */
+/* Monotonically decreasing minimum length filters after index 0 */
 static int discard_minlen[BTRFS_NR_DISCARD_LISTS] = {
 	0,
 	BTRFS_ASYNC_DISCARD_MAX_FILTER,
@@ -147,10 +147,11 @@ static bool remove_from_discard_list(struct btrfs_discard_ctl *discard_ctl,
 	return running;
 }
 
-/**
- * find_next_block_group - find block_group that's up next for discarding
- * @discard_ctl: discard control
- * @now: current time
+/*
+ * Find block_group that's up next for discarding.
+ *
+ * @discard_ctl:  discard control
+ * @now:          current time
  *
  * Iterate over the discard lists to find the next block_group up for
  * discarding checking the discard_eligible_time of block_group.
@@ -185,17 +186,17 @@ static struct btrfs_block_group *find_next_block_group(
 	return ret_block_group;
 }
 
-/**
- * Wrap find_next_block_group()
+/*
+ * Look up next block group and set it for use.
  *
  * @discard_ctl:   discard control
  * @discard_state: the discard_state of the block_group after state management
  * @discard_index: the discard_index of the block_group after state management
  * @now:           time when discard was invoked, in ns
  *
- * This wraps find_next_block_group() and sets the block_group to be in use.
- * discard_state's control flow is managed here.  Variables related to
- * discard_state are reset here as needed (eg discard_cursor).  @discard_state
+ * Wrap find_next_block_group() and set the block_group to be in use.
+ * @discard_state's control flow is managed here.  Variables related to
+ * @discard_state are reset here as needed (eg. @discard_cursor).  @discard_state
  * and @discard_index are remembered as it may change while we're discarding,
  * but we want the discard to execute in the context determined here.
  */
@@ -234,10 +235,11 @@ static struct btrfs_block_group *peek_discard_list(
 	return block_group;
 }
 
-/**
- * btrfs_discard_check_filter - updates a block groups filters
- * @block_group: block group of interest
- * @bytes: recently freed region size after coalescing
+/*
+ * Update a block group's filters.
+ *
+ * @block_group:  block group of interest
+ * @bytes:        recently freed region size after coalescing
  *
  * Async discard maintains multiple lists with progressively smaller filters
  * to prioritize discarding based on size.  Should a free space that matches
@@ -272,8 +274,9 @@ void btrfs_discard_check_filter(struct btrfs_block_group *block_group,
 	}
 }
 
-/**
- * btrfs_update_discard_index - moves a block group along the discard lists
+/*
+ * Move a block group along the discard lists.
+ *
  * @discard_ctl: discard control
  * @block_group: block_group of interest
  *
@@ -292,13 +295,14 @@ static void btrfs_update_discard_index(struct btrfs_discard_ctl *discard_ctl,
 	add_to_discard_list(discard_ctl, block_group);
 }
 
-/**
- * btrfs_discard_cancel_work - remove a block_group from the discard lists
+/*
+ * Remove a block_group from the discard lists.
+ *
  * @discard_ctl: discard control
  * @block_group: block_group of interest
  *
- * This removes @block_group from the discard lists.  If necessary, it waits on
- * the current work and then reschedules the delayed work.
+ * Remove @block_group from the discard lists.  If necessary, wait on the
+ * current work and then reschedule the delayed work.
  */
 void btrfs_discard_cancel_work(struct btrfs_discard_ctl *discard_ctl,
 			       struct btrfs_block_group *block_group)
@@ -309,12 +313,13 @@ void btrfs_discard_cancel_work(struct btrfs_discard_ctl *discard_ctl,
 	}
 }
 
-/**
- * btrfs_discard_queue_work - handles queuing the block_groups
+/*
+ * Handles queuing the block_groups.
+ *
  * @discard_ctl: discard control
  * @block_group: block_group of interest
  *
- * This maintains the LRU order of the discard lists.
+ * Maintain the LRU order of the discard lists.
  */
 void btrfs_discard_queue_work(struct btrfs_discard_ctl *discard_ctl,
 			      struct btrfs_block_group *block_group)
@@ -384,7 +389,8 @@ static void __btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
 }
 
 /*
- * btrfs_discard_schedule_work - responsible for scheduling the discard work
+ * Responsible for scheduling the discard work.
+ *
  * @discard_ctl:  discard control
  * @override:     override the current timer
  *
@@ -402,15 +408,16 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
 	spin_unlock(&discard_ctl->lock);
 }
 
-/**
- * btrfs_finish_discard_pass - determine next step of a block_group
+/*
+ * Determine next step of a block_group.
+ *
  * @discard_ctl: discard control
  * @block_group: block_group of interest
  *
- * This determines the next step for a block group after it's finished going
- * through a pass on a discard list.  If it is unused and fully trimmed, we can
- * mark it unused and send it to the unused_bgs path.  Otherwise, pass it onto
- * the appropriate filter list or let it fall off.
+ * Determine the next step for a block group after it's finished going through
+ * a pass on a discard list.  If it is unused and fully trimmed, we can mark it
+ * unused and send it to the unused_bgs path.  Otherwise, pass it onto the
+ * appropriate filter list or let it fall off.
  */
 static void btrfs_finish_discard_pass(struct btrfs_discard_ctl *discard_ctl,
 				      struct btrfs_block_group *block_group)
@@ -427,12 +434,13 @@ static void btrfs_finish_discard_pass(struct btrfs_discard_ctl *discard_ctl,
 	}
 }
 
-/**
- * btrfs_discard_workfn - discard work function
+/*
+ * Discard work queue callback
+ *
  * @work: work
  *
- * This finds the next block_group to start discarding and then discards a
- * single region.  It does this in a two-pass fashion: first extents and second
+ * Find the next block_group to start discarding and then discard a single
+ * region.  It does this in a two-pass fashion: first extents and second
  * bitmaps.  Completely discarded block groups are sent to the unused_bgs path.
  */
 static void btrfs_discard_workfn(struct work_struct *work)
@@ -508,11 +516,12 @@ static void btrfs_discard_workfn(struct work_struct *work)
 	spin_unlock(&discard_ctl->lock);
 }
 
-/**
- * btrfs_run_discard_work - determines if async discard should be running
+/*
+ * Determine if async discard should be running.
+ *
  * @discard_ctl: discard control
  *
- * Checks if the file system is writeable and BTRFS_FS_DISCARD_RUNNING is set.
+ * Check if the file system is writeable and BTRFS_FS_DISCARD_RUNNING is set.
  */
 bool btrfs_run_discard_work(struct btrfs_discard_ctl *discard_ctl)
 {
@@ -524,8 +533,9 @@ bool btrfs_run_discard_work(struct btrfs_discard_ctl *discard_ctl)
 		test_bit(BTRFS_FS_DISCARD_RUNNING, &fs_info->flags));
 }
 
-/**
- * btrfs_discard_calc_delay - recalculate the base delay
+/*
+ * Recalculate the base delay.
+ *
  * @discard_ctl: discard control
  *
  * Recalculate the base delay which is based off the total number of
@@ -546,7 +556,7 @@ void btrfs_discard_calc_delay(struct btrfs_discard_ctl *discard_ctl)
 	spin_lock(&discard_ctl->lock);
 
 	/*
-	 * The following is to fix a potential -1 discrepenancy that we're not
+	 * The following is to fix a potential -1 discrepancy that we're not
 	 * sure how to reproduce. But given that this is the only place that
 	 * utilizes these numbers and this is only called by from
 	 * btrfs_finish_extent_commit() which is synchronized, we can correct
@@ -579,13 +589,14 @@ void btrfs_discard_calc_delay(struct btrfs_discard_ctl *discard_ctl)
 	spin_unlock(&discard_ctl->lock);
 }
 
-/**
- * btrfs_discard_update_discardable - propagate discard counters
+/*
+ * Propagate discard counters.
+ *
  * @block_group: block_group of interest
  *
- * This propagates deltas of counters up to the discard_ctl.  It maintains a
- * current counter and a previous counter passing the delta up to the global
- * stat.  Then the current counter value becomes the previous counter value.
+ * Propagate deltas of counters up to the discard_ctl.  It maintains a current
+ * counter and a previous counter passing the delta up to the global stat.
+ * Then the current counter value becomes the previous counter value.
  */
 void btrfs_discard_update_discardable(struct btrfs_block_group *block_group)
 {
@@ -620,8 +631,9 @@ void btrfs_discard_update_discardable(struct btrfs_block_group *block_group)
 	}
 }
 
-/**
- * btrfs_discard_punt_unused_bgs_list - punt unused_bgs list to discard lists
+/*
+ * Punt unused_bgs list to discard lists.
+ *
  * @fs_info: fs_info of interest
  *
  * The unused_bgs list needs to be punted to the discard lists because the
@@ -645,8 +657,9 @@ void btrfs_discard_punt_unused_bgs_list(struct btrfs_fs_info *fs_info)
 	spin_unlock(&fs_info->unused_bgs_lock);
 }
 
-/**
- * btrfs_discard_purge_list - purge discard lists
+/*
+ * Purge discard lists.
+ *
  * @discard_ctl: discard control
  *
  * If we are disabling async discard, we may have intercepted block groups that
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 4b47bb8c590f..545d9e1f0f83 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1298,7 +1298,7 @@ static void end_bio_extent_readpage(struct btrfs_bio *bbio)
 	bio_put(bio);
 }
 
-/**
+/*
  * Populate every free slot in a provided array with pages.
  *
  * @nr_pages:   number of pages to allocate
@@ -1334,16 +1334,16 @@ int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array)
 	return 0;
 }
 
-/**
- * Attempt to add a page to bio
+/*
+ * Attempt to add a page to bio.
  *
- * @bio_ctrl:	record both the bio, and its bio_flags
- * @page:	page to add to the bio
- * @disk_bytenr:  offset of the new bio or to check whether we are adding
- *                a contiguous page to the previous one
- * @size:	portion of page that we want to write
- * @pg_offset:	starting offset in the page
- * @compress_type:   compression type of the current bio to see if we can merge them
+ * @bio_ctrl:       record both the bio, and its bio_flags
+ * @page:	    page to add to the bio
+ * @disk_bytenr:    offset of the new bio or to check whether we are adding
+ *                  a contiguous page to the previous one
+ * @size:	    portion of page that we want to write
+ * @pg_offset:	    starting offset in the page
+ * @compress_type:  compression type of the current bio to see if we can merge them
  *
  * Attempt to add a page to bio considering stripe alignment etc.
  *
@@ -3066,7 +3066,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 	return ret;
 }
 
-/**
+/*
  * Walk the list of dirty pages of the given address space and write all of them.
  *
  * @mapping: address space structure to write
@@ -5460,11 +5460,12 @@ static inline void eb_bitmap_offset(const struct extent_buffer *eb,
 	*page_offset = offset_in_page(offset);
 }
 
-/**
- * extent_buffer_test_bit - determine whether a bit in a bitmap item is set
- * @eb: the extent buffer
- * @start: offset of the bitmap item in the extent buffer
- * @nr: bit number to test
+/*
+ * Determine whether a bit in a bitmap item is set.
+ *
+ * @eb:     the extent buffer
+ * @start:  offset of the bitmap item in the extent buffer
+ * @nr:     bit number to test
  */
 int extent_buffer_test_bit(const struct extent_buffer *eb, unsigned long start,
 			   unsigned long nr)
@@ -5481,12 +5482,13 @@ int extent_buffer_test_bit(const struct extent_buffer *eb, unsigned long start,
 	return 1U & (kaddr[offset] >> (nr & (BITS_PER_BYTE - 1)));
 }
 
-/**
- * extent_buffer_bitmap_set - set an area of a bitmap
- * @eb: the extent buffer
- * @start: offset of the bitmap item in the extent buffer
- * @pos: bit number of the first bit
- * @len: number of bits to set
+/*
+ * Set an area of a bitmap to 1.
+ *
+ * @eb:     the extent buffer
+ * @start:  offset of the bitmap item in the extent buffer
+ * @pos:    bit number of the first bit
+ * @len:    number of bits to set
  */
 void extent_buffer_bitmap_set(const struct extent_buffer *eb, unsigned long start,
 			      unsigned long pos, unsigned long len)
@@ -5523,12 +5525,13 @@ void extent_buffer_bitmap_set(const struct extent_buffer *eb, unsigned long star
 }
 
 
-/**
- * extent_buffer_bitmap_clear - clear an area of a bitmap
- * @eb: the extent buffer
- * @start: offset of the bitmap item in the extent buffer
- * @pos: bit number of the first bit
- * @len: number of bits to clear
+/*
+ * Clear an area of a bitmap.
+ *
+ * @eb:     the extent buffer
+ * @start:  offset of the bitmap item in the extent buffer
+ * @pos:    bit number of the first bit
+ * @len:    number of bits to clear
  */
 void extent_buffer_bitmap_clear(const struct extent_buffer *eb,
 				unsigned long start, unsigned long pos,
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index f97508afb659..cd45303f344d 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -28,12 +28,9 @@ void __cold extent_map_exit(void)
 	kmem_cache_destroy(extent_map_cache);
 }
 
-/**
- * extent_map_tree_init - initialize extent map tree
- * @tree:		tree to initialize
- *
- * Initialize the extent tree @tree.  Should be called for each new inode
- * or other user of the extent_map interface.
+/*
+ * Initialize the extent tree @tree.  Should be called for each new inode or
+ * other user of the extent_map interface.
  */
 void extent_map_tree_init(struct extent_map_tree *tree)
 {
@@ -42,12 +39,9 @@ void extent_map_tree_init(struct extent_map_tree *tree)
 	rwlock_init(&tree->lock);
 }
 
-/**
- * alloc_extent_map - allocate new extent map structure
- *
- * Allocate a new extent_map structure.  The new structure is
- * returned with a reference count of one and needs to be
- * freed using free_extent_map()
+/*
+ * Allocate a new extent_map structure.  The new structure is returned with a
+ * reference count of one and needs to be freed using free_extent_map()
  */
 struct extent_map *alloc_extent_map(void)
 {
@@ -62,12 +56,9 @@ struct extent_map *alloc_extent_map(void)
 	return em;
 }
 
-/**
- * free_extent_map - drop reference count of an extent_map
- * @em:		extent map being released
- *
- * Drops the reference out on @em by one and free the structure
- * if the reference count hits zero.
+/*
+ * Drop the reference out on @em by one and free the structure if the reference
+ * count hits zero.
  */
 void free_extent_map(struct extent_map *em)
 {
@@ -82,7 +73,7 @@ void free_extent_map(struct extent_map *em)
 	}
 }
 
-/* simple helper to do math around the end of an extent, handling wrap */
+/* Do the math around the end of an extent, handling wrapping. */
 static u64 range_end(u64 start, u64 len)
 {
 	if (start + len < start)
@@ -138,8 +129,8 @@ static int tree_insert(struct rb_root_cached *root, struct extent_map *em)
 }
 
 /*
- * search through the tree for an extent_map with a given offset.  If
- * it can't be found, try to find some neighboring extents
+ * Search through the tree for an extent_map with a given offset.  If it can't
+ * be found, try to find some neighboring extents
  */
 static struct rb_node *__tree_search(struct rb_root *root, u64 offset,
 				     struct rb_node **prev_or_next_ret)
@@ -191,7 +182,7 @@ static struct rb_node *__tree_search(struct rb_root *root, u64 offset,
 	return NULL;
 }
 
-/* check to see if two extent_map structs are adjacent and safe to merge */
+/* Check to see if two extent_map structs are adjacent and safe to merge. */
 static int mergable_maps(struct extent_map *prev, struct extent_map *next)
 {
 	if (test_bit(EXTENT_FLAG_PINNED, &prev->flags))
@@ -289,8 +280,9 @@ static void try_merge_map(struct extent_map_tree *tree, struct extent_map *em)
 	}
 }
 
-/**
- * unpin_extent_cache - unpin an extent from the cache
+/*
+ * Unpin an extent from the cache.
+ *
  * @tree:	tree to unpin the extent in
  * @start:	logical offset in the file
  * @len:	length of the extent
@@ -393,7 +385,7 @@ static void extent_map_device_clear_bits(struct extent_map *em, unsigned bits)
 	}
 }
 
-/**
+/*
  * Add new extent map to the extent tree
  *
  * @tree:	tree to insert new map in
@@ -452,8 +444,9 @@ __lookup_extent_mapping(struct extent_map_tree *tree,
 	return em;
 }
 
-/**
- * lookup_extent_mapping - lookup extent_map
+/*
+ * Lookup extent_map that intersects @start + @len range.
+ *
  * @tree:	tree to lookup in
  * @start:	byte offset to start the search
  * @len:	length of the lookup range
@@ -469,8 +462,9 @@ struct extent_map *lookup_extent_mapping(struct extent_map_tree *tree,
 	return __lookup_extent_mapping(tree, start, len, 1);
 }
 
-/**
- * search_extent_mapping - find a nearby extent map
+/*
+ * Find a nearby extent map intersecting @start + @len (not an exact search).
+ *
  * @tree:	tree to lookup in
  * @start:	byte offset to start the search
  * @len:	length of the lookup range
@@ -486,13 +480,14 @@ struct extent_map *search_extent_mapping(struct extent_map_tree *tree,
 	return __lookup_extent_mapping(tree, start, len, 0);
 }
 
-/**
- * remove_extent_mapping - removes an extent_map from the extent tree
+/*
+ * Remove an extent_map from the extent tree.
+ *
  * @tree:	extent tree to remove from
  * @em:		extent map being removed
  *
- * Removes @em from @tree.  No reference counts are dropped, and no checks
- * are done to see if the range is in use
+ * Remove @em from @tree.  No reference counts are dropped, and no checks
+ * are done to see if the range is in use.
  */
 void remove_extent_mapping(struct extent_map_tree *tree, struct extent_map *em)
 {
@@ -615,8 +610,8 @@ static noinline int merge_extent_mapping(struct extent_map_tree *em_tree,
 	return add_extent_mapping(em_tree, em, 0);
 }
 
-/**
- * Add extent mapping into em_tree
+/*
+ * Add extent mapping into em_tree.
  *
  * @fs_info:  the filesystem
  * @em_tree:  extent tree into which we want to insert the extent mapping
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index bce6c8d31bc0..403a857d230e 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -27,8 +27,8 @@
 #define MAX_CSUM_ITEMS(r, size) (min_t(u32, __MAX_CSUM_ITEMS(r, size), \
 				       PAGE_SIZE))
 
-/**
- * Set inode's size according to filesystem options
+/*
+ * Set inode's size according to filesystem options.
  *
  * @inode:      inode we want to update the disk_i_size for
  * @new_i_size: i_size we want to set to, 0 if we use i_size
@@ -67,8 +67,8 @@ void btrfs_inode_safe_disk_i_size_write(struct btrfs_inode *inode, u64 new_i_siz
 	spin_unlock(&inode->lock);
 }
 
-/**
- * Mark range within a file as having a new extent inserted
+/*
+ * Mark range within a file as having a new extent inserted.
  *
  * @inode: inode being modified
  * @start: start file offset of the file extent we've inserted
@@ -95,8 +95,8 @@ int btrfs_inode_set_file_extent_range(struct btrfs_inode *inode, u64 start,
 			       EXTENT_DIRTY);
 }
 
-/**
- * Marks an inode range as not having a backing extent
+/*
+ * Mark an inode range as not having a backing extent.
  *
  * @inode: inode being modified
  * @start: start file offset of the file extent we've inserted
@@ -257,7 +257,7 @@ int btrfs_lookup_file_extent(struct btrfs_trans_handle *trans,
 
 /*
  * Find checksums for logical bytenr range [disk_bytenr, disk_bytenr + len) and
- * estore the result to @dst.
+ * store the result to @dst.
  *
  * Return >0 for the number of sectors we found.
  * Return 0 for the range [disk_bytenr, disk_bytenr + sectorsize) has no csum
@@ -363,15 +363,15 @@ static int search_file_offset_in_bio(struct bio *bio, struct inode *inode,
 	return ret;
 }
 
-/**
+/*
  * Lookup the checksum for the read bio in csum tree.
  *
- * @inode: inode that the bio is for.
- * @bio: bio to look up.
- * @dst: Buffer of size nblocks * btrfs_super_csum_size() used to return
- *       checksum (nblocks = bio->bi_iter.bi_size / fs_info->sectorsize). If
- *       NULL, the checksum buffer is allocated and returned in
- *       btrfs_bio(bio)->csum instead.
+ * @inode:  inode that the bio is for.
+ * @bio:    bio to look up.
+ * @dst:    Buffer of size nblocks * btrfs_super_csum_size() used to return
+ *          checksum (nblocks = bio->bi_iter.bi_size / fs_info->sectorsize). If
+ *          NULL, the checksum buffer is allocated and returned in
+ *          btrfs_bio(bio)->csum instead.
  *
  * Return: BLK_STS_RESOURCE if allocating memory fails, BLK_STS_OK otherwise.
  */
@@ -633,8 +633,8 @@ int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
 	return ret;
 }
 
-/**
- * Calculate checksums of the data contained inside a bio
+/*
+ * Calculate checksums of the data contained inside a bio.
  *
  * @inode:	 Owner of the data inside the bio
  * @bio:	 Contains the data to be checksummed
@@ -749,15 +749,16 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
 }
 
 /*
- * helper function for csum removal, this expects the
- * key to describe the csum pointed to by the path, and it expects
- * the csum to overlap the range [bytenr, len]
+ * Remove one checksum overlapping a range.
+ *
+ * This expects the key to describe the csum pointed to by the path, and it
+ * expects the csum to overlap the range [bytenr, len]
  *
- * The csum should not be entirely contained in the range and the
- * range should not be entirely contained in the csum.
+ * The csum should not be entirely contained in the range and the range should
+ * not be entirely contained in the csum.
  *
- * This calls btrfs_truncate_item with the correct args based on the
- * overlap, and fixes up the key as required.
+ * This calls btrfs_truncate_item with the correct args based on the overlap,
+ * and fixes up the key as required.
  */
 static noinline void truncate_one_csum(struct btrfs_fs_info *fs_info,
 				       struct btrfs_path *path,
@@ -806,8 +807,7 @@ static noinline void truncate_one_csum(struct btrfs_fs_info *fs_info,
 }
 
 /*
- * deletes the csum items from the csum tree for a given
- * range of bytes.
+ * Delete the csum items from the csum tree for a given range of bytes.
  */
 int btrfs_del_csums(struct btrfs_trans_handle *trans,
 		    struct btrfs_root *root, u64 bytenr, u64 len)
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 26ff1a5100b9..599b41523479 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1369,8 +1369,8 @@ int btrfs_wait_cache_io(struct btrfs_trans_handle *trans,
 				     path, block_group->start);
 }
 
-/**
- * Write out cached info to an inode
+/*
+ * Write out cached info to an inode.
  *
  * @root:        root the inode belongs to
  * @inode:       freespace inode we are writing out
@@ -3034,10 +3034,7 @@ void btrfs_remove_free_space_cache(struct btrfs_block_group *block_group)
 
 }
 
-/**
- * btrfs_is_free_space_trimmed - see if everything is trimmed
- * @block_group: block_group of interest
- *
+/*
  * Walk @block_group's free space rb_tree to determine if everything is trimmed.
  */
 bool btrfs_is_free_space_trimmed(struct btrfs_block_group *block_group)
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2bb78352eba3..9175ef5bd047 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6894,18 +6894,18 @@ static noinline int uncompress_inline(struct btrfs_path *path,
 	return ret;
 }
 
-/**
- * btrfs_get_extent - Lookup the first extent overlapping a range in a file.
+/*
+ * Lookup the first extent overlapping a range in a file.
+ *
  * @inode:	file to search in
  * @page:	page to read extent data into if the extent is inline
  * @pg_offset:	offset into @page to copy to
  * @start:	file offset
  * @len:	length of range starting at @start
  *
- * This returns the first &struct extent_map which overlaps with the given
- * range, reading it from the B-tree and caching it if necessary. Note that
- * there may be more extents which overlap the given range after the returned
- * extent_map.
+ * Return the first &struct extent_map which overlaps the given range, reading
+ * it from the B-tree and caching it if necessary. Note that there may be more
+ * extents which overlap the given range after the returned extent_map.
  *
  * If @page is not NULL and the extent is inline, this also reads the extent
  * data directly into the page and marks the extent up to date in the io_tree.
@@ -11301,7 +11301,7 @@ void btrfs_update_inode_bytes(struct btrfs_inode *inode,
 	spin_unlock(&inode->lock);
 }
 
-/**
+/*
  * Verify that there are no ordered extents for a given file range.
  *
  * @inode:   The target inode.
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index d3565c6cf2e2..fb0a2b833a15 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4343,7 +4343,7 @@ void btrfs_update_ioctl_balance_args(struct btrfs_fs_info *fs_info,
 	spin_unlock(&fs_info->balance_lock);
 }
 
-/**
+/*
  * Try to acquire fs_info::balance_mutex as well as set BTRFS_EXLCOP_BALANCE as
  * required.
  *
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 1cbaacdc50da..1c36407803ca 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -144,7 +144,7 @@ static inline struct rb_node *tree_search(struct btrfs_ordered_inode_tree *tree,
 	return ret;
 }
 
-/**
+/*
  * Add an ordered extent to the per-inode tree.
  *
  * @inode:           Inode that this extent is for.
@@ -1020,17 +1020,18 @@ struct btrfs_ordered_extent *btrfs_lookup_first_ordered_range(
 }
 
 /*
- * btrfs_flush_ordered_range - Lock the passed range and ensures all pending
- * ordered extents in it are run to completion.
+ * Lock the passed range and ensures all pending ordered extents in it are run
+ * to completion.
  *
  * @inode:        Inode whose ordered tree is to be searched
  * @start:        Beginning of range to flush
  * @end:          Last byte of range to lock
  * @cached_state: If passed, will return the extent state responsible for the
- * locked range. It's the caller's responsibility to free the cached state.
+ *                locked range. It's the caller's responsibility to free the
+ *                cached state.
  *
- * This function always returns with the given range locked, ensuring after it's
- * called no order extent can be pending.
+ * Always return with the given range locked, ensuring after it's called no
+ * order extent can be pending.
  */
 void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, u64 start,
 					u64 end,
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 349270537c2e..ef272e7d932c 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -908,8 +908,8 @@ static void raid_write_end_io(struct bio *bio)
 	rbio_orig_end_io(rbio, err);
 }
 
-/**
- * Get a sector pointer specified by its @stripe_nr and @sector_nr
+/*
+ * Get a sector pointer specified by its @stripe_nr and @sector_nr.
  *
  * @rbio:               The raid bio
  * @stripe_nr:          Stripe number, valid range [0, real_stripe)
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index f0243eb33df7..9ba7914c7169 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -321,16 +321,16 @@ static int clone_copy_inline_extent(struct inode *dst,
 	goto out;
 }
 
-/**
- * btrfs_clone() - clone a range from inode file to another
+/*
+ * Clone a range from inode file to another.
  *
- * @src: Inode to clone from
- * @inode: Inode to clone to
- * @off: Offset within source to start clone from
- * @olen: Original length, passed by user, of range to clone
- * @olen_aligned: Block-aligned value of olen
- * @destoff: Offset within @inode to start clone
- * @no_time_update: Whether to update mtime/ctime on the target inode
+ * @src:             Inode to clone from
+ * @inode:           Inode to clone to
+ * @off:             Offset within source to start clone from
+ * @olen:            Original length, passed by user, of range to clone
+ * @olen_aligned:    Block-aligned value of olen
+ * @destoff:         Offset within @inode to start clone
+ * @no_time_update:  Whether to update mtime/ctime on the target inode
  */
 static int btrfs_clone(struct inode *src, struct inode *inode,
 		       const u64 off, const u64 olen, const u64 olen_aligned,
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 382a2a53d2ff..4b76f3a8460e 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1493,8 +1493,8 @@ static void wait_reserve_ticket(struct btrfs_fs_info *fs_info,
 	spin_unlock(&space_info->lock);
 }
 
-/**
- * Do the appropriate flushing and waiting for a ticket
+/*
+ * Do the appropriate flushing and waiting for a ticket.
  *
  * @fs_info:    the filesystem
  * @space_info: space info for the reservation
@@ -1596,8 +1596,8 @@ static inline bool can_ticket(enum btrfs_reserve_flush_enum flush)
 		flush != BTRFS_RESERVE_FLUSH_EMERGENCY);
 }
 
-/**
- * Try to reserve bytes from the block_rsv's space
+/*
+ * Try to reserve bytes from the block_rsv's space.
  *
  * @fs_info:    the filesystem
  * @space_info: space info we want to allocate from
@@ -1736,8 +1736,8 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 				     orig_bytes, flush);
 }
 
-/**
- * Trye to reserve metadata bytes from the block_rsv's space
+/*
+ * Try to reserve metadata bytes from the block_rsv's space.
  *
  * @fs_info:    the filesystem
  * @block_rsv:  block_rsv we're allocating for
@@ -1771,8 +1771,8 @@ int btrfs_reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
-/**
- * Try to reserve data bytes for an allocation
+/*
+ * Try to reserve data bytes for an allocation.
  *
  * @fs_info: the filesystem
  * @bytes:   number of bytes we need
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index aff14a9ad98f..f88377f08a2b 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -7330,7 +7330,7 @@ void btrfs_record_snapshot_destroy(struct btrfs_trans_handle *trans,
 	mutex_unlock(&dir->log_mutex);
 }
 
-/**
+/*
  * Update the log after adding a new name for an inode.
  *
  * @trans:              Transaction handle.
diff --git a/fs/btrfs/ulist.c b/fs/btrfs/ulist.c
index f2f20c8d84aa..13af1e41f9d7 100644
--- a/fs/btrfs/ulist.c
+++ b/fs/btrfs/ulist.c
@@ -38,8 +38,9 @@
  * loop would be similar to the above.
  */
 
-/**
- * ulist_init - freshly initialize a ulist
+/*
+ * Freshly initialize a ulist.
+ *
  * @ulist:	the ulist to initialize
  *
  * Note: don't use this function to init an already used ulist, use
@@ -52,8 +53,9 @@ void ulist_init(struct ulist *ulist)
 	ulist->nnodes = 0;
 }
 
-/**
- * ulist_release - free up additionally allocated memory for the ulist
+/*
+ * Free up additionally allocated memory for the ulist.
+ *
  * @ulist:	the ulist from which to free the additional memory
  *
  * This is useful in cases where the base 'struct ulist' has been statically
@@ -71,8 +73,9 @@ void ulist_release(struct ulist *ulist)
 	INIT_LIST_HEAD(&ulist->nodes);
 }
 
-/**
- * ulist_reinit - prepare a ulist for reuse
+/*
+ * Prepare a ulist for reuse.
+ *
  * @ulist:	ulist to be reused
  *
  * Free up all additional memory allocated for the list elements and reinit
@@ -84,8 +87,9 @@ void ulist_reinit(struct ulist *ulist)
 	ulist_init(ulist);
 }
 
-/**
- * ulist_alloc - dynamically allocate a ulist
+/*
+ * Dynamically allocate a ulist.
+ *
  * @gfp_mask:	allocation flags to for base allocation
  *
  * The allocated ulist will be returned in an initialized state.
@@ -102,8 +106,9 @@ struct ulist *ulist_alloc(gfp_t gfp_mask)
 	return ulist;
 }
 
-/**
- * ulist_free - free dynamically allocated ulist
+/*
+ * Free dynamically allocated ulist.
+ *
  * @ulist:	ulist to free
  *
  * It is not necessary to call ulist_release before.
@@ -164,8 +169,9 @@ static int ulist_rbtree_insert(struct ulist *ulist, struct ulist_node *ins)
 	return 0;
 }
 
-/**
- * ulist_add - add an element to the ulist
+/*
+ * Add an element to the ulist.
+ *
  * @ulist:	ulist to add the element to
  * @val:	value to add to ulist
  * @aux:	auxiliary value to store along with val
@@ -243,8 +249,9 @@ int ulist_del(struct ulist *ulist, u64 val, u64 aux)
 	return 0;
 }
 
-/**
- * ulist_next - iterate ulist
+/*
+ * Iterate ulist.
+ *
  * @ulist:	ulist to iterate
  * @uiter:	iterator variable, initialized with ULIST_ITER_INIT(&iterator)
  *
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 0182ae70911e..bbbe6b3848f8 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -531,14 +531,14 @@ btrfs_get_bdev_and_sb(const char *device_path, fmode_t flags, void *holder,
 	return ret;
 }
 
-/**
- *  Search and remove all stale devices (which are not mounted).
- *  When both inputs are NULL, it will search and release all stale devices.
+/*
+ *  Search and remove all stale devices (which are not mounted).  When both
+ *  inputs are NULL, it will search and release all stale devices.
  *
- *  @devt:	Optional. When provided will it release all unmounted devices
- *		matching this devt only.
+ *  @devt:         Optional. When provided will it release all unmounted devices
+ *                 matching this devt only.
  *  @skip_device:  Optional. Will skip this device when searching for the stale
- *		devices.
+ *                 devices.
  *
  *  Return:	0 for success or if @devt is 0.
  *		-EBUSY if @devt is a mounted device.
@@ -1466,8 +1466,9 @@ static bool dev_extent_hole_check_zoned(struct btrfs_device *device,
 	return changed;
 }
 
-/**
- * dev_extent_hole_check - check if specified hole is suitable for allocation
+/*
+ * Check if specified hole is suitable for allocation.
+ *
  * @device:	the device which we have the hole
  * @hole_start: starting position of the hole
  * @hole_size:	the size of the hole
@@ -1521,7 +1522,8 @@ static bool dev_extent_hole_check(struct btrfs_device *device, u64 *hole_start,
 }
 
 /*
- * find_free_dev_extent_start - find free space in the specified device
+ * Find free space in the specified device.
+ *
  * @device:	  the device which we search the free space in
  * @num_bytes:	  the size of the free space that we need
  * @search_start: the position from which to begin the search
@@ -1529,9 +1531,8 @@ static bool dev_extent_hole_check(struct btrfs_device *device, u64 *hole_start,
  * @len:	  the size of the free space. that we find, or the size
  *		  of the max free space if we don't find suitable free space
  *
- * this uses a pretty simple search, the expectation is that it is
- * called very infrequently and that a given device has a small number
- * of extents
+ * This does a pretty simple search, the expectation is that it is called very
+ * infrequently and that a given device has a small number of extents.
  *
  * @start is used to store the start of the free space if we find. But if we
  * don't find suitable free space, it will be used to store the start position
@@ -2310,8 +2311,8 @@ void btrfs_destroy_dev_replace_tgtdev(struct btrfs_device *tgtdev)
 	btrfs_free_device(tgtdev);
 }
 
-/**
- * Populate args from device at path
+/*
+ * Populate args from device at path.
  *
  * @fs_info:	the filesystem
  * @args:	the args to populate
@@ -4019,10 +4020,11 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
 	return ret;
 }
 
-/**
- * alloc_profile_is_valid - see if a given profile is valid and reduced
- * @flags: profile to validate
- * @extended: if true @flags is treated as an extended profile
+/*
+ * See if a given profile is valid and reduced.
+ *
+ * @flags:     profile to validate
+ * @extended:  if true @flags is treated as an extended profile
  */
 static int alloc_profile_is_valid(u64 flags, int extended)
 {
@@ -6997,8 +6999,9 @@ static struct btrfs_device *add_missing_dev(struct btrfs_fs_devices *fs_devices,
 	return device;
 }
 
-/**
- * btrfs_alloc_device - allocate struct btrfs_device
+/*
+ * Allocate new device struct, set up devid and UUID.
+ *
  * @fs_info:	used only for generating a new devid, can be NULL if
  *		devid is provided (i.e. @devid != NULL).
  * @devid:	a pointer to devid for this device.  If NULL a new devid
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 0b906f2bb220..9d12a23e1a59 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -979,8 +979,8 @@ int btrfs_reset_sb_log_zones(struct block_device *bdev, int mirror)
 				zone_sectors * BTRFS_NR_SB_LOG_ZONES, GFP_NOFS);
 }
 
-/**
- * btrfs_find_allocatable_zones - find allocatable zones within a given region
+/*
+ * Find allocatable zones within a given region.
  *
  * @device:	the device to allocate a region on
  * @hole_start: the position of the hole to allocate the region
@@ -1823,7 +1823,7 @@ struct btrfs_device *btrfs_zoned_get_device(struct btrfs_fs_info *fs_info,
 	return device;
 }
 
-/**
+/*
  * Activate block group and underlying device zones
  *
  * @block_group: the block group to activate
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 35a0224d4eb7..4575b3703e74 100644
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
2.37.3

