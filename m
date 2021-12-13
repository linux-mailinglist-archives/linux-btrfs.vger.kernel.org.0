Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C6A472CE7
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Dec 2021 14:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237220AbhLMNLW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Dec 2021 08:11:22 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:35264 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbhLMNLQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Dec 2021 08:11:16 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4C9C72111A
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Dec 2021 13:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639401075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YGsKDka2SaO0Dfd0TXtcSLXHgIwLb1RZgo2YH9hP0VA=;
        b=pCTDKE28psNoqsSedJvOmHmoTCr0zHV78zJ5b0gSuvwltBO4QN+F2CcYZ2utwDxvg2caJ9
        Tp7zRzZUKmelrf4n1XETCtbx1CyE9TrPf1p8PyweJvGWfcYQxV+MuyTLOL9i/r+MJOHHbm
        NJirpgOqB5d/VjkRsaunhnhuNxZNriI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6DAB213D6E
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Dec 2021 13:11:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UM1RDnJGt2EFCAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Dec 2021 13:11:14 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: remove reada mechanism
Date:   Mon, 13 Dec 2021 21:10:53 +0800
Message-Id: <20211213131054.102526-3-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211213131054.102526-1-wqu@suse.com>
References: <20211213131054.102526-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently there is only one user for btrfs metadata readahead, and
that's scrub.

But even for the single user, it's not providing the correct
functionality it needs, as scrub needs reada for commit root, which
current readahead can't provide. (Although it's pretty easy to add such
feature).

Despite this, there are some extra problems related to metadata
readahead:

- Duplicated feature with btrfs_path::reada

- Partly duplicated feature of btrfs_fs_info::buffer_radix
  Btrfs already caches its metadata in buffer_radix, while readahead
  tries to read the tree block no matter if it's already cached.

- Poor layer separation
  To my surprise, metadata readahead works kinda at device level.
  This is definitely not the correct layer it should be, since metadata
  is at btrfs logical address space, it should not bother device at all.

  This brings extra chance for bugs to sneak in, while brings
  unnecessary complexity.

- Dead codes
  In the very beginning of scrub.c we have #undef DEBUG, rendering all
  the debug related code useless and unable to test.

Thus here I purpose to remove the metadata readahead mechanism
completely.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/Makefile      |    2 +-
 fs/btrfs/ctree.h       |   25 -
 fs/btrfs/dev-replace.c |    5 -
 fs/btrfs/disk-io.c     |   20 +-
 fs/btrfs/extent_io.c   |    3 -
 fs/btrfs/reada.c       | 1086 ----------------------------------------
 fs/btrfs/scrub.c       |   36 --
 fs/btrfs/super.c       |    1 -
 fs/btrfs/volumes.c     |    7 -
 fs/btrfs/volumes.h     |    7 -
 10 files changed, 3 insertions(+), 1189 deletions(-)
 delete mode 100644 fs/btrfs/reada.c

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index 3dcf9bcc2326..4188ba3fd8c3 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -27,7 +27,7 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
 	   extent_io.o volumes.o async-thread.o ioctl.o locking.o orphan.o \
 	   export.o tree-log.o free-space-cache.o zlib.o lzo.o zstd.o \
 	   compression.o delayed-ref.o relocation.o delayed-inode.o scrub.o \
-	   reada.o backref.o ulist.o qgroup.o send.o dev-replace.o raid56.o \
+	   backref.o ulist.o qgroup.o send.o dev-replace.o raid56.o \
 	   uuid-tree.o props.o free-space-tree.o tree-checker.o space-info.o \
 	   block-rsv.o delalloc-space.o block-group.o discard.o reflink.o \
 	   subpage.o tree-mod-log.o
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index dfee4b403da1..eeda7b687fca 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -821,7 +821,6 @@ struct btrfs_fs_info {
 	struct btrfs_workqueue *endio_write_workers;
 	struct btrfs_workqueue *endio_freespace_worker;
 	struct btrfs_workqueue *caching_workers;
-	struct btrfs_workqueue *readahead_workers;
 
 	/*
 	 * fixup workers take dirty pages that didn't properly go through
@@ -958,13 +957,6 @@ struct btrfs_fs_info {
 
 	struct btrfs_delayed_root *delayed_root;
 
-	/* readahead tree */
-	spinlock_t reada_lock;
-	struct radix_tree_root reada_tree;
-
-	/* readahead works cnt */
-	atomic_t reada_works_cnt;
-
 	/* Extent buffer radix tree */
 	spinlock_t buffer_lock;
 	/* Entries are eb->start / sectorsize */
@@ -3836,23 +3828,6 @@ static inline void btrfs_bio_counter_dec(struct btrfs_fs_info *fs_info)
 	btrfs_bio_counter_sub(fs_info, 1);
 }
 
-/* reada.c */
-struct reada_control {
-	struct btrfs_fs_info	*fs_info;		/* tree to prefetch */
-	struct btrfs_key	key_start;
-	struct btrfs_key	key_end;	/* exclusive */
-	atomic_t		elems;
-	struct kref		refcnt;
-	wait_queue_head_t	wait;
-};
-struct reada_control *btrfs_reada_add(struct btrfs_root *root,
-			      struct btrfs_key *start, struct btrfs_key *end);
-int btrfs_reada_wait(void *handle);
-void btrfs_reada_detach(void *handle);
-int btree_readahead_hook(struct extent_buffer *eb, int err);
-void btrfs_reada_remove_dev(struct btrfs_device *dev);
-void btrfs_reada_undo_remove_dev(struct btrfs_device *dev);
-
 static inline int is_fstree(u64 rootid)
 {
 	if (rootid == BTRFS_FS_TREE_OBJECTID ||
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 66fa61cb3f23..62b9651ea662 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -906,9 +906,6 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 	}
 	btrfs_wait_ordered_roots(fs_info, U64_MAX, 0, (u64)-1);
 
-	if (!scrub_ret)
-		btrfs_reada_remove_dev(src_device);
-
 	/*
 	 * We have to use this loop approach because at this point src_device
 	 * has to be available for transaction commit to complete, yet new
@@ -917,7 +914,6 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 	while (1) {
 		trans = btrfs_start_transaction(root, 0);
 		if (IS_ERR(trans)) {
-			btrfs_reada_undo_remove_dev(src_device);
 			mutex_unlock(&dev_replace->lock_finishing_cancel_unmount);
 			return PTR_ERR(trans);
 		}
@@ -968,7 +964,6 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 		up_write(&dev_replace->rwsem);
 		mutex_unlock(&fs_info->chunk_mutex);
 		mutex_unlock(&fs_info->fs_devices->device_list_mutex);
-		btrfs_reada_undo_remove_dev(src_device);
 		btrfs_rm_dev_replace_blocked(fs_info);
 		if (tgt_device)
 			btrfs_destroy_dev_replace_tgtdev(tgt_device);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5c598e124c25..8d7438aecdd0 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -665,9 +665,6 @@ static int validate_subpage_buffer(struct page *page, u64 start, u64 end,
 	if (ret < 0)
 		goto err;
 
-	if (test_and_clear_bit(EXTENT_BUFFER_READAHEAD, &eb->bflags))
-		btree_readahead_hook(eb, ret);
-
 	set_extent_buffer_uptodate(eb);
 
 	free_extent_buffer(eb);
@@ -715,10 +712,6 @@ int btrfs_validate_metadata_buffer(struct btrfs_bio *bbio,
 	}
 	ret = validate_extent_buffer(eb);
 err:
-	if (reads_done &&
-	    test_and_clear_bit(EXTENT_BUFFER_READAHEAD, &eb->bflags))
-		btree_readahead_hook(eb, ret);
-
 	if (ret) {
 		/*
 		 * our io error hook is going to dec the io pages
@@ -2224,7 +2217,6 @@ static void btrfs_stop_all_workers(struct btrfs_fs_info *fs_info)
 	btrfs_destroy_workqueue(fs_info->endio_freespace_worker);
 	btrfs_destroy_workqueue(fs_info->delayed_workers);
 	btrfs_destroy_workqueue(fs_info->caching_workers);
-	btrfs_destroy_workqueue(fs_info->readahead_workers);
 	btrfs_destroy_workqueue(fs_info->flush_workers);
 	btrfs_destroy_workqueue(fs_info->qgroup_rescan_workers);
 	if (fs_info->discard_ctl.discard_workers)
@@ -2437,9 +2429,6 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
 	fs_info->delayed_workers =
 		btrfs_alloc_workqueue(fs_info, "delayed-meta", flags,
 				      max_active, 0);
-	fs_info->readahead_workers =
-		btrfs_alloc_workqueue(fs_info, "readahead", flags,
-				      max_active, 2);
 	fs_info->qgroup_rescan_workers =
 		btrfs_alloc_workqueue(fs_info, "qgroup-rescan", flags, 1, 0);
 	fs_info->discard_ctl.discard_workers =
@@ -2451,9 +2440,8 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
 	      fs_info->endio_meta_write_workers &&
 	      fs_info->endio_write_workers && fs_info->endio_raid56_workers &&
 	      fs_info->endio_freespace_worker && fs_info->rmw_workers &&
-	      fs_info->caching_workers && fs_info->readahead_workers &&
-	      fs_info->fixup_workers && fs_info->delayed_workers &&
-	      fs_info->qgroup_rescan_workers &&
+	      fs_info->caching_workers && fs_info->fixup_workers &&
+	      fs_info->delayed_workers && fs_info->qgroup_rescan_workers &&
 	      fs_info->discard_ctl.discard_workers)) {
 		return -ENOMEM;
 	}
@@ -3083,7 +3071,6 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 
 	atomic_set(&fs_info->async_delalloc_pages, 0);
 	atomic_set(&fs_info->defrag_running, 0);
-	atomic_set(&fs_info->reada_works_cnt, 0);
 	atomic_set(&fs_info->nr_delayed_iputs, 0);
 	atomic64_set(&fs_info->tree_mod_seq, 0);
 	fs_info->global_root_tree = RB_ROOT;
@@ -3094,9 +3081,6 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	fs_info->tree_mod_log = RB_ROOT;
 	fs_info->commit_interval = BTRFS_DEFAULT_COMMIT_INTERVAL;
 	fs_info->avg_delayed_ref_runtime = NSEC_PER_SEC >> 6; /* div by 64 */
-	/* readahead state */
-	INIT_RADIX_TREE(&fs_info->reada_tree, GFP_NOFS & ~__GFP_DIRECT_RECLAIM);
-	spin_lock_init(&fs_info->reada_lock);
 	btrfs_init_ref_verify(fs_info);
 
 	fs_info->thread_pool_size = min_t(unsigned long,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1a67f4b3986b..c9f1f5f3846b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3087,9 +3087,6 @@ static void end_bio_extent_readpage(struct bio *bio)
 			set_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags);
 			eb->read_mirror = mirror;
 			atomic_dec(&eb->io_pages);
-			if (test_and_clear_bit(EXTENT_BUFFER_READAHEAD,
-					       &eb->bflags))
-				btree_readahead_hook(eb, -EIO);
 		}
 readpage_ok:
 		if (likely(uptodate)) {
diff --git a/fs/btrfs/reada.c b/fs/btrfs/reada.c
deleted file mode 100644
index eb96fdc3be25..000000000000
--- a/fs/btrfs/reada.c
+++ /dev/null
@@ -1,1086 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2011 STRATO.  All rights reserved.
- */
-
-#include <linux/sched.h>
-#include <linux/pagemap.h>
-#include <linux/writeback.h>
-#include <linux/blkdev.h>
-#include <linux/slab.h>
-#include <linux/workqueue.h>
-#include "ctree.h"
-#include "volumes.h"
-#include "disk-io.h"
-#include "transaction.h"
-#include "dev-replace.h"
-#include "block-group.h"
-
-#undef DEBUG
-
-/*
- * This is the implementation for the generic read ahead framework.
- *
- * To trigger a readahead, btrfs_reada_add must be called. It will start
- * a read ahead for the given range [start, end) on tree root. The returned
- * handle can either be used to wait on the readahead to finish
- * (btrfs_reada_wait), or to send it to the background (btrfs_reada_detach).
- *
- * The read ahead works as follows:
- * On btrfs_reada_add, the root of the tree is inserted into a radix_tree.
- * reada_start_machine will then search for extents to prefetch and trigger
- * some reads. When a read finishes for a node, all contained node/leaf
- * pointers that lie in the given range will also be enqueued. The reads will
- * be triggered in sequential order, thus giving a big win over a naive
- * enumeration. It will also make use of multi-device layouts. Each disk
- * will have its on read pointer and all disks will by utilized in parallel.
- * Also will no two disks read both sides of a mirror simultaneously, as this
- * would waste seeking capacity. Instead both disks will read different parts
- * of the filesystem.
- * Any number of readaheads can be started in parallel. The read order will be
- * determined globally, i.e. 2 parallel readaheads will normally finish faster
- * than the 2 started one after another.
- */
-
-#define MAX_IN_FLIGHT 6
-
-struct reada_extctl {
-	struct list_head	list;
-	struct reada_control	*rc;
-	u64			generation;
-};
-
-struct reada_extent {
-	u64			logical;
-	u64			owner_root;
-	struct btrfs_key	top;
-	struct list_head	extctl;
-	int 			refcnt;
-	spinlock_t		lock;
-	struct reada_zone	*zones[BTRFS_MAX_MIRRORS];
-	int			nzones;
-	int			scheduled;
-	int			level;
-};
-
-struct reada_zone {
-	u64			start;
-	u64			end;
-	u64			elems;
-	struct list_head	list;
-	spinlock_t		lock;
-	int			locked;
-	struct btrfs_device	*device;
-	struct btrfs_device	*devs[BTRFS_MAX_MIRRORS]; /* full list, incl
-							   * self */
-	int			ndevs;
-	struct kref		refcnt;
-};
-
-struct reada_machine_work {
-	struct btrfs_work	work;
-	struct btrfs_fs_info	*fs_info;
-};
-
-static void reada_extent_put(struct btrfs_fs_info *, struct reada_extent *);
-static void reada_control_release(struct kref *kref);
-static void reada_zone_release(struct kref *kref);
-static void reada_start_machine(struct btrfs_fs_info *fs_info);
-static void __reada_start_machine(struct btrfs_fs_info *fs_info);
-
-static int reada_add_block(struct reada_control *rc, u64 logical,
-			   struct btrfs_key *top, u64 owner_root,
-			   u64 generation, int level);
-
-/* recurses */
-/* in case of err, eb might be NULL */
-static void __readahead_hook(struct btrfs_fs_info *fs_info,
-			     struct reada_extent *re, struct extent_buffer *eb,
-			     int err)
-{
-	int nritems;
-	int i;
-	u64 bytenr;
-	u64 generation;
-	struct list_head list;
-
-	spin_lock(&re->lock);
-	/*
-	 * just take the full list from the extent. afterwards we
-	 * don't need the lock anymore
-	 */
-	list_replace_init(&re->extctl, &list);
-	re->scheduled = 0;
-	spin_unlock(&re->lock);
-
-	/*
-	 * this is the error case, the extent buffer has not been
-	 * read correctly. We won't access anything from it and
-	 * just cleanup our data structures. Effectively this will
-	 * cut the branch below this node from read ahead.
-	 */
-	if (err)
-		goto cleanup;
-
-	/*
-	 * FIXME: currently we just set nritems to 0 if this is a leaf,
-	 * effectively ignoring the content. In a next step we could
-	 * trigger more readahead depending from the content, e.g.
-	 * fetch the checksums for the extents in the leaf.
-	 */
-	if (!btrfs_header_level(eb))
-		goto cleanup;
-
-	nritems = btrfs_header_nritems(eb);
-	generation = btrfs_header_generation(eb);
-	for (i = 0; i < nritems; i++) {
-		struct reada_extctl *rec;
-		u64 n_gen;
-		struct btrfs_key key;
-		struct btrfs_key next_key;
-
-		btrfs_node_key_to_cpu(eb, &key, i);
-		if (i + 1 < nritems)
-			btrfs_node_key_to_cpu(eb, &next_key, i + 1);
-		else
-			next_key = re->top;
-		bytenr = btrfs_node_blockptr(eb, i);
-		n_gen = btrfs_node_ptr_generation(eb, i);
-
-		list_for_each_entry(rec, &list, list) {
-			struct reada_control *rc = rec->rc;
-
-			/*
-			 * if the generation doesn't match, just ignore this
-			 * extctl. This will probably cut off a branch from
-			 * prefetch. Alternatively one could start a new (sub-)
-			 * prefetch for this branch, starting again from root.
-			 * FIXME: move the generation check out of this loop
-			 */
-#ifdef DEBUG
-			if (rec->generation != generation) {
-				btrfs_debug(fs_info,
-					    "generation mismatch for (%llu,%d,%llu) %llu != %llu",
-					    key.objectid, key.type, key.offset,
-					    rec->generation, generation);
-			}
-#endif
-			if (rec->generation == generation &&
-			    btrfs_comp_cpu_keys(&key, &rc->key_end) < 0 &&
-			    btrfs_comp_cpu_keys(&next_key, &rc->key_start) > 0)
-				reada_add_block(rc, bytenr, &next_key,
-						btrfs_header_owner(eb), n_gen,
-						btrfs_header_level(eb) - 1);
-		}
-	}
-
-cleanup:
-	/*
-	 * free extctl records
-	 */
-	while (!list_empty(&list)) {
-		struct reada_control *rc;
-		struct reada_extctl *rec;
-
-		rec = list_first_entry(&list, struct reada_extctl, list);
-		list_del(&rec->list);
-		rc = rec->rc;
-		kfree(rec);
-
-		kref_get(&rc->refcnt);
-		if (atomic_dec_and_test(&rc->elems)) {
-			kref_put(&rc->refcnt, reada_control_release);
-			wake_up(&rc->wait);
-		}
-		kref_put(&rc->refcnt, reada_control_release);
-
-		reada_extent_put(fs_info, re);	/* one ref for each entry */
-	}
-
-	return;
-}
-
-int btree_readahead_hook(struct extent_buffer *eb, int err)
-{
-	struct btrfs_fs_info *fs_info = eb->fs_info;
-	int ret = 0;
-	struct reada_extent *re;
-
-	/* find extent */
-	spin_lock(&fs_info->reada_lock);
-	re = radix_tree_lookup(&fs_info->reada_tree,
-			       eb->start >> fs_info->sectorsize_bits);
-	if (re)
-		re->refcnt++;
-	spin_unlock(&fs_info->reada_lock);
-	if (!re) {
-		ret = -1;
-		goto start_machine;
-	}
-
-	__readahead_hook(fs_info, re, eb, err);
-	reada_extent_put(fs_info, re);	/* our ref */
-
-start_machine:
-	reada_start_machine(fs_info);
-	return ret;
-}
-
-static struct reada_zone *reada_find_zone(struct btrfs_device *dev, u64 logical,
-					  struct btrfs_io_context *bioc)
-{
-	struct btrfs_fs_info *fs_info = dev->fs_info;
-	int ret;
-	struct reada_zone *zone;
-	struct btrfs_block_group *cache = NULL;
-	u64 start;
-	u64 end;
-	int i;
-
-	zone = NULL;
-	spin_lock(&fs_info->reada_lock);
-	ret = radix_tree_gang_lookup(&dev->reada_zones, (void **)&zone,
-				     logical >> fs_info->sectorsize_bits, 1);
-	if (ret == 1 && logical >= zone->start && logical <= zone->end) {
-		kref_get(&zone->refcnt);
-		spin_unlock(&fs_info->reada_lock);
-		return zone;
-	}
-
-	spin_unlock(&fs_info->reada_lock);
-
-	cache = btrfs_lookup_block_group(fs_info, logical);
-	if (!cache)
-		return NULL;
-
-	start = cache->start;
-	end = start + cache->length - 1;
-	btrfs_put_block_group(cache);
-
-	zone = kzalloc(sizeof(*zone), GFP_KERNEL);
-	if (!zone)
-		return NULL;
-
-	ret = radix_tree_preload(GFP_KERNEL);
-	if (ret) {
-		kfree(zone);
-		return NULL;
-	}
-
-	zone->start = start;
-	zone->end = end;
-	INIT_LIST_HEAD(&zone->list);
-	spin_lock_init(&zone->lock);
-	zone->locked = 0;
-	kref_init(&zone->refcnt);
-	zone->elems = 0;
-	zone->device = dev; /* our device always sits at index 0 */
-	for (i = 0; i < bioc->num_stripes; ++i) {
-		/* bounds have already been checked */
-		zone->devs[i] = bioc->stripes[i].dev;
-	}
-	zone->ndevs = bioc->num_stripes;
-
-	spin_lock(&fs_info->reada_lock);
-	ret = radix_tree_insert(&dev->reada_zones,
-			(unsigned long)(zone->end >> fs_info->sectorsize_bits),
-			zone);
-
-	if (ret == -EEXIST) {
-		kfree(zone);
-		ret = radix_tree_gang_lookup(&dev->reada_zones, (void **)&zone,
-					logical >> fs_info->sectorsize_bits, 1);
-		if (ret == 1 && logical >= zone->start && logical <= zone->end)
-			kref_get(&zone->refcnt);
-		else
-			zone = NULL;
-	}
-	spin_unlock(&fs_info->reada_lock);
-	radix_tree_preload_end();
-
-	return zone;
-}
-
-static struct reada_extent *reada_find_extent(struct btrfs_fs_info *fs_info,
-					      u64 logical,
-					      struct btrfs_key *top,
-					      u64 owner_root, int level)
-{
-	int ret;
-	struct reada_extent *re = NULL;
-	struct reada_extent *re_exist = NULL;
-	struct btrfs_io_context *bioc = NULL;
-	struct btrfs_device *dev;
-	struct btrfs_device *prev_dev;
-	u64 length;
-	int real_stripes;
-	int nzones = 0;
-	unsigned long index = logical >> fs_info->sectorsize_bits;
-	int dev_replace_is_ongoing;
-	int have_zone = 0;
-
-	spin_lock(&fs_info->reada_lock);
-	re = radix_tree_lookup(&fs_info->reada_tree, index);
-	if (re)
-		re->refcnt++;
-	spin_unlock(&fs_info->reada_lock);
-
-	if (re)
-		return re;
-
-	re = kzalloc(sizeof(*re), GFP_KERNEL);
-	if (!re)
-		return NULL;
-
-	re->logical = logical;
-	re->top = *top;
-	INIT_LIST_HEAD(&re->extctl);
-	spin_lock_init(&re->lock);
-	re->refcnt = 1;
-	re->owner_root = owner_root;
-	re->level = level;
-
-	/*
-	 * map block
-	 */
-	length = fs_info->nodesize;
-	ret = btrfs_map_block(fs_info, BTRFS_MAP_GET_READ_MIRRORS, logical,
-			      &length, &bioc, 0);
-	if (ret || !bioc || length < fs_info->nodesize)
-		goto error;
-
-	if (bioc->num_stripes > BTRFS_MAX_MIRRORS) {
-		btrfs_err(fs_info,
-			   "readahead: more than %d copies not supported",
-			   BTRFS_MAX_MIRRORS);
-		goto error;
-	}
-
-	real_stripes = bioc->num_stripes - bioc->num_tgtdevs;
-	for (nzones = 0; nzones < real_stripes; ++nzones) {
-		struct reada_zone *zone;
-
-		dev = bioc->stripes[nzones].dev;
-
-		/* cannot read ahead on missing device. */
-		if (!dev->bdev)
-			continue;
-
-		zone = reada_find_zone(dev, logical, bioc);
-		if (!zone)
-			continue;
-
-		re->zones[re->nzones++] = zone;
-		spin_lock(&zone->lock);
-		if (!zone->elems)
-			kref_get(&zone->refcnt);
-		++zone->elems;
-		spin_unlock(&zone->lock);
-		spin_lock(&fs_info->reada_lock);
-		kref_put(&zone->refcnt, reada_zone_release);
-		spin_unlock(&fs_info->reada_lock);
-	}
-	if (re->nzones == 0) {
-		/* not a single zone found, error and out */
-		goto error;
-	}
-
-	/* Insert extent in reada tree + all per-device trees, all or nothing */
-	down_read(&fs_info->dev_replace.rwsem);
-	ret = radix_tree_preload(GFP_KERNEL);
-	if (ret) {
-		up_read(&fs_info->dev_replace.rwsem);
-		goto error;
-	}
-
-	spin_lock(&fs_info->reada_lock);
-	ret = radix_tree_insert(&fs_info->reada_tree, index, re);
-	if (ret == -EEXIST) {
-		re_exist = radix_tree_lookup(&fs_info->reada_tree, index);
-		re_exist->refcnt++;
-		spin_unlock(&fs_info->reada_lock);
-		radix_tree_preload_end();
-		up_read(&fs_info->dev_replace.rwsem);
-		goto error;
-	}
-	if (ret) {
-		spin_unlock(&fs_info->reada_lock);
-		radix_tree_preload_end();
-		up_read(&fs_info->dev_replace.rwsem);
-		goto error;
-	}
-	radix_tree_preload_end();
-	prev_dev = NULL;
-	dev_replace_is_ongoing = btrfs_dev_replace_is_ongoing(
-			&fs_info->dev_replace);
-	for (nzones = 0; nzones < re->nzones; ++nzones) {
-		dev = re->zones[nzones]->device;
-
-		if (dev == prev_dev) {
-			/*
-			 * in case of DUP, just add the first zone. As both
-			 * are on the same device, there's nothing to gain
-			 * from adding both.
-			 * Also, it wouldn't work, as the tree is per device
-			 * and adding would fail with EEXIST
-			 */
-			continue;
-		}
-		if (!dev->bdev)
-			continue;
-
-		if (test_bit(BTRFS_DEV_STATE_NO_READA, &dev->dev_state))
-			continue;
-
-		if (dev_replace_is_ongoing &&
-		    dev == fs_info->dev_replace.tgtdev) {
-			/*
-			 * as this device is selected for reading only as
-			 * a last resort, skip it for read ahead.
-			 */
-			continue;
-		}
-		prev_dev = dev;
-		ret = radix_tree_insert(&dev->reada_extents, index, re);
-		if (ret) {
-			while (--nzones >= 0) {
-				dev = re->zones[nzones]->device;
-				BUG_ON(dev == NULL);
-				/* ignore whether the entry was inserted */
-				radix_tree_delete(&dev->reada_extents, index);
-			}
-			radix_tree_delete(&fs_info->reada_tree, index);
-			spin_unlock(&fs_info->reada_lock);
-			up_read(&fs_info->dev_replace.rwsem);
-			goto error;
-		}
-		have_zone = 1;
-	}
-	if (!have_zone)
-		radix_tree_delete(&fs_info->reada_tree, index);
-	spin_unlock(&fs_info->reada_lock);
-	up_read(&fs_info->dev_replace.rwsem);
-
-	if (!have_zone)
-		goto error;
-
-	btrfs_put_bioc(bioc);
-	return re;
-
-error:
-	for (nzones = 0; nzones < re->nzones; ++nzones) {
-		struct reada_zone *zone;
-
-		zone = re->zones[nzones];
-		kref_get(&zone->refcnt);
-		spin_lock(&zone->lock);
-		--zone->elems;
-		if (zone->elems == 0) {
-			/*
-			 * no fs_info->reada_lock needed, as this can't be
-			 * the last ref
-			 */
-			kref_put(&zone->refcnt, reada_zone_release);
-		}
-		spin_unlock(&zone->lock);
-
-		spin_lock(&fs_info->reada_lock);
-		kref_put(&zone->refcnt, reada_zone_release);
-		spin_unlock(&fs_info->reada_lock);
-	}
-	btrfs_put_bioc(bioc);
-	kfree(re);
-	return re_exist;
-}
-
-static void reada_extent_put(struct btrfs_fs_info *fs_info,
-			     struct reada_extent *re)
-{
-	int i;
-	unsigned long index = re->logical >> fs_info->sectorsize_bits;
-
-	spin_lock(&fs_info->reada_lock);
-	if (--re->refcnt) {
-		spin_unlock(&fs_info->reada_lock);
-		return;
-	}
-
-	radix_tree_delete(&fs_info->reada_tree, index);
-	for (i = 0; i < re->nzones; ++i) {
-		struct reada_zone *zone = re->zones[i];
-
-		radix_tree_delete(&zone->device->reada_extents, index);
-	}
-
-	spin_unlock(&fs_info->reada_lock);
-
-	for (i = 0; i < re->nzones; ++i) {
-		struct reada_zone *zone = re->zones[i];
-
-		kref_get(&zone->refcnt);
-		spin_lock(&zone->lock);
-		--zone->elems;
-		if (zone->elems == 0) {
-			/* no fs_info->reada_lock needed, as this can't be
-			 * the last ref */
-			kref_put(&zone->refcnt, reada_zone_release);
-		}
-		spin_unlock(&zone->lock);
-
-		spin_lock(&fs_info->reada_lock);
-		kref_put(&zone->refcnt, reada_zone_release);
-		spin_unlock(&fs_info->reada_lock);
-	}
-
-	kfree(re);
-}
-
-static void reada_zone_release(struct kref *kref)
-{
-	struct reada_zone *zone = container_of(kref, struct reada_zone, refcnt);
-	struct btrfs_fs_info *fs_info = zone->device->fs_info;
-
-	lockdep_assert_held(&fs_info->reada_lock);
-
-	radix_tree_delete(&zone->device->reada_zones,
-			  zone->end >> fs_info->sectorsize_bits);
-
-	kfree(zone);
-}
-
-static void reada_control_release(struct kref *kref)
-{
-	struct reada_control *rc = container_of(kref, struct reada_control,
-						refcnt);
-
-	kfree(rc);
-}
-
-static int reada_add_block(struct reada_control *rc, u64 logical,
-			   struct btrfs_key *top, u64 owner_root,
-			   u64 generation, int level)
-{
-	struct btrfs_fs_info *fs_info = rc->fs_info;
-	struct reada_extent *re;
-	struct reada_extctl *rec;
-
-	/* takes one ref */
-	re = reada_find_extent(fs_info, logical, top, owner_root, level);
-	if (!re)
-		return -1;
-
-	rec = kzalloc(sizeof(*rec), GFP_KERNEL);
-	if (!rec) {
-		reada_extent_put(fs_info, re);
-		return -ENOMEM;
-	}
-
-	rec->rc = rc;
-	rec->generation = generation;
-	atomic_inc(&rc->elems);
-
-	spin_lock(&re->lock);
-	list_add_tail(&rec->list, &re->extctl);
-	spin_unlock(&re->lock);
-
-	/* leave the ref on the extent */
-
-	return 0;
-}
-
-/*
- * called with fs_info->reada_lock held
- */
-static void reada_peer_zones_set_lock(struct reada_zone *zone, int lock)
-{
-	int i;
-	unsigned long index = zone->end >> zone->device->fs_info->sectorsize_bits;
-
-	for (i = 0; i < zone->ndevs; ++i) {
-		struct reada_zone *peer;
-		peer = radix_tree_lookup(&zone->devs[i]->reada_zones, index);
-		if (peer && peer->device != zone->device)
-			peer->locked = lock;
-	}
-}
-
-/*
- * called with fs_info->reada_lock held
- */
-static int reada_pick_zone(struct btrfs_device *dev)
-{
-	struct reada_zone *top_zone = NULL;
-	struct reada_zone *top_locked_zone = NULL;
-	u64 top_elems = 0;
-	u64 top_locked_elems = 0;
-	unsigned long index = 0;
-	int ret;
-
-	if (dev->reada_curr_zone) {
-		reada_peer_zones_set_lock(dev->reada_curr_zone, 0);
-		kref_put(&dev->reada_curr_zone->refcnt, reada_zone_release);
-		dev->reada_curr_zone = NULL;
-	}
-	/* pick the zone with the most elements */
-	while (1) {
-		struct reada_zone *zone;
-
-		ret = radix_tree_gang_lookup(&dev->reada_zones,
-					     (void **)&zone, index, 1);
-		if (ret == 0)
-			break;
-		index = (zone->end >> dev->fs_info->sectorsize_bits) + 1;
-		if (zone->locked) {
-			if (zone->elems > top_locked_elems) {
-				top_locked_elems = zone->elems;
-				top_locked_zone = zone;
-			}
-		} else {
-			if (zone->elems > top_elems) {
-				top_elems = zone->elems;
-				top_zone = zone;
-			}
-		}
-	}
-	if (top_zone)
-		dev->reada_curr_zone = top_zone;
-	else if (top_locked_zone)
-		dev->reada_curr_zone = top_locked_zone;
-	else
-		return 0;
-
-	dev->reada_next = dev->reada_curr_zone->start;
-	kref_get(&dev->reada_curr_zone->refcnt);
-	reada_peer_zones_set_lock(dev->reada_curr_zone, 1);
-
-	return 1;
-}
-
-static int reada_tree_block_flagged(struct btrfs_fs_info *fs_info, u64 bytenr,
-				    u64 owner_root, int level, int mirror_num,
-				    struct extent_buffer **eb)
-{
-	struct extent_buffer *buf = NULL;
-	int ret;
-
-	buf = btrfs_find_create_tree_block(fs_info, bytenr, owner_root, level);
-	if (IS_ERR(buf))
-		return 0;
-
-	set_bit(EXTENT_BUFFER_READAHEAD, &buf->bflags);
-
-	ret = read_extent_buffer_pages(buf, WAIT_PAGE_LOCK, mirror_num);
-	if (ret) {
-		free_extent_buffer_stale(buf);
-		return ret;
-	}
-
-	if (test_bit(EXTENT_BUFFER_CORRUPT, &buf->bflags)) {
-		free_extent_buffer_stale(buf);
-		return -EIO;
-	} else if (extent_buffer_uptodate(buf)) {
-		*eb = buf;
-	} else {
-		free_extent_buffer(buf);
-	}
-	return 0;
-}
-
-static int reada_start_machine_dev(struct btrfs_device *dev)
-{
-	struct btrfs_fs_info *fs_info = dev->fs_info;
-	struct reada_extent *re = NULL;
-	int mirror_num = 0;
-	struct extent_buffer *eb = NULL;
-	u64 logical;
-	int ret;
-	int i;
-
-	spin_lock(&fs_info->reada_lock);
-	if (dev->reada_curr_zone == NULL) {
-		ret = reada_pick_zone(dev);
-		if (!ret) {
-			spin_unlock(&fs_info->reada_lock);
-			return 0;
-		}
-	}
-	/*
-	 * FIXME currently we issue the reads one extent at a time. If we have
-	 * a contiguous block of extents, we could also coagulate them or use
-	 * plugging to speed things up
-	 */
-	ret = radix_tree_gang_lookup(&dev->reada_extents, (void **)&re,
-				dev->reada_next >> fs_info->sectorsize_bits, 1);
-	if (ret == 0 || re->logical > dev->reada_curr_zone->end) {
-		ret = reada_pick_zone(dev);
-		if (!ret) {
-			spin_unlock(&fs_info->reada_lock);
-			return 0;
-		}
-		re = NULL;
-		ret = radix_tree_gang_lookup(&dev->reada_extents, (void **)&re,
-				dev->reada_next >> fs_info->sectorsize_bits, 1);
-	}
-	if (ret == 0) {
-		spin_unlock(&fs_info->reada_lock);
-		return 0;
-	}
-	dev->reada_next = re->logical + fs_info->nodesize;
-	re->refcnt++;
-
-	spin_unlock(&fs_info->reada_lock);
-
-	spin_lock(&re->lock);
-	if (re->scheduled || list_empty(&re->extctl)) {
-		spin_unlock(&re->lock);
-		reada_extent_put(fs_info, re);
-		return 0;
-	}
-	re->scheduled = 1;
-	spin_unlock(&re->lock);
-
-	/*
-	 * find mirror num
-	 */
-	for (i = 0; i < re->nzones; ++i) {
-		if (re->zones[i]->device == dev) {
-			mirror_num = i + 1;
-			break;
-		}
-	}
-	logical = re->logical;
-
-	atomic_inc(&dev->reada_in_flight);
-	ret = reada_tree_block_flagged(fs_info, logical, re->owner_root,
-				       re->level, mirror_num, &eb);
-	if (ret)
-		__readahead_hook(fs_info, re, NULL, ret);
-	else if (eb)
-		__readahead_hook(fs_info, re, eb, ret);
-
-	if (eb)
-		free_extent_buffer(eb);
-
-	atomic_dec(&dev->reada_in_flight);
-	reada_extent_put(fs_info, re);
-
-	return 1;
-
-}
-
-static void reada_start_machine_worker(struct btrfs_work *work)
-{
-	struct reada_machine_work *rmw;
-	int old_ioprio;
-
-	rmw = container_of(work, struct reada_machine_work, work);
-
-	old_ioprio = IOPRIO_PRIO_VALUE(task_nice_ioclass(current),
-				       task_nice_ioprio(current));
-	set_task_ioprio(current, BTRFS_IOPRIO_READA);
-	__reada_start_machine(rmw->fs_info);
-	set_task_ioprio(current, old_ioprio);
-
-	atomic_dec(&rmw->fs_info->reada_works_cnt);
-
-	kfree(rmw);
-}
-
-/* Try to start up to 10k READA requests for a group of devices */
-static int reada_start_for_fsdevs(struct btrfs_fs_devices *fs_devices)
-{
-	u64 enqueued;
-	u64 total = 0;
-	struct btrfs_device *device;
-
-	do {
-		enqueued = 0;
-		list_for_each_entry(device, &fs_devices->devices, dev_list) {
-			if (atomic_read(&device->reada_in_flight) <
-			    MAX_IN_FLIGHT)
-				enqueued += reada_start_machine_dev(device);
-		}
-		total += enqueued;
-	} while (enqueued && total < 10000);
-
-	return total;
-}
-
-static void __reada_start_machine(struct btrfs_fs_info *fs_info)
-{
-	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices, *seed_devs;
-	int i;
-	u64 enqueued = 0;
-
-	mutex_lock(&fs_devices->device_list_mutex);
-
-	enqueued += reada_start_for_fsdevs(fs_devices);
-	list_for_each_entry(seed_devs, &fs_devices->seed_list, seed_list)
-		enqueued += reada_start_for_fsdevs(seed_devs);
-
-	mutex_unlock(&fs_devices->device_list_mutex);
-	if (enqueued == 0)
-		return;
-
-	/*
-	 * If everything is already in the cache, this is effectively single
-	 * threaded. To a) not hold the caller for too long and b) to utilize
-	 * more cores, we broke the loop above after 10000 iterations and now
-	 * enqueue to workers to finish it. This will distribute the load to
-	 * the cores.
-	 */
-	for (i = 0; i < 2; ++i) {
-		reada_start_machine(fs_info);
-		if (atomic_read(&fs_info->reada_works_cnt) >
-		    BTRFS_MAX_MIRRORS * 2)
-			break;
-	}
-}
-
-static void reada_start_machine(struct btrfs_fs_info *fs_info)
-{
-	struct reada_machine_work *rmw;
-
-	rmw = kzalloc(sizeof(*rmw), GFP_KERNEL);
-	if (!rmw) {
-		/* FIXME we cannot handle this properly right now */
-		BUG();
-	}
-	btrfs_init_work(&rmw->work, reada_start_machine_worker, NULL, NULL);
-	rmw->fs_info = fs_info;
-
-	btrfs_queue_work(fs_info->readahead_workers, &rmw->work);
-	atomic_inc(&fs_info->reada_works_cnt);
-}
-
-#ifdef DEBUG
-static void dump_devs(struct btrfs_fs_info *fs_info, int all)
-{
-	struct btrfs_device *device;
-	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
-	unsigned long index;
-	int ret;
-	int i;
-	int j;
-	int cnt;
-
-	spin_lock(&fs_info->reada_lock);
-	list_for_each_entry(device, &fs_devices->devices, dev_list) {
-		btrfs_debug(fs_info, "dev %lld has %d in flight", device->devid,
-			atomic_read(&device->reada_in_flight));
-		index = 0;
-		while (1) {
-			struct reada_zone *zone;
-			ret = radix_tree_gang_lookup(&device->reada_zones,
-						     (void **)&zone, index, 1);
-			if (ret == 0)
-				break;
-			pr_debug("  zone %llu-%llu elems %llu locked %d devs",
-				    zone->start, zone->end, zone->elems,
-				    zone->locked);
-			for (j = 0; j < zone->ndevs; ++j) {
-				pr_cont(" %lld",
-					zone->devs[j]->devid);
-			}
-			if (device->reada_curr_zone == zone)
-				pr_cont(" curr off %llu",
-					device->reada_next - zone->start);
-			pr_cont("\n");
-			index = (zone->end >> fs_info->sectorsize_bits) + 1;
-		}
-		cnt = 0;
-		index = 0;
-		while (all) {
-			struct reada_extent *re = NULL;
-
-			ret = radix_tree_gang_lookup(&device->reada_extents,
-						     (void **)&re, index, 1);
-			if (ret == 0)
-				break;
-			pr_debug("  re: logical %llu size %u empty %d scheduled %d",
-				re->logical, fs_info->nodesize,
-				list_empty(&re->extctl), re->scheduled);
-
-			for (i = 0; i < re->nzones; ++i) {
-				pr_cont(" zone %llu-%llu devs",
-					re->zones[i]->start,
-					re->zones[i]->end);
-				for (j = 0; j < re->zones[i]->ndevs; ++j) {
-					pr_cont(" %lld",
-						re->zones[i]->devs[j]->devid);
-				}
-			}
-			pr_cont("\n");
-			index = (re->logical >> fs_info->sectorsize_bits) + 1;
-			if (++cnt > 15)
-				break;
-		}
-	}
-
-	index = 0;
-	cnt = 0;
-	while (all) {
-		struct reada_extent *re = NULL;
-
-		ret = radix_tree_gang_lookup(&fs_info->reada_tree, (void **)&re,
-					     index, 1);
-		if (ret == 0)
-			break;
-		if (!re->scheduled) {
-			index = (re->logical >> fs_info->sectorsize_bits) + 1;
-			continue;
-		}
-		pr_debug("re: logical %llu size %u list empty %d scheduled %d",
-			re->logical, fs_info->nodesize,
-			list_empty(&re->extctl), re->scheduled);
-		for (i = 0; i < re->nzones; ++i) {
-			pr_cont(" zone %llu-%llu devs",
-				re->zones[i]->start,
-				re->zones[i]->end);
-			for (j = 0; j < re->zones[i]->ndevs; ++j) {
-				pr_cont(" %lld",
-				       re->zones[i]->devs[j]->devid);
-			}
-		}
-		pr_cont("\n");
-		index = (re->logical >> fs_info->sectorsize_bits) + 1;
-	}
-	spin_unlock(&fs_info->reada_lock);
-}
-#endif
-
-/*
- * interface
- */
-struct reada_control *btrfs_reada_add(struct btrfs_root *root,
-			struct btrfs_key *key_start, struct btrfs_key *key_end)
-{
-	struct reada_control *rc;
-	u64 start;
-	u64 generation;
-	int ret;
-	int level;
-	struct extent_buffer *node;
-	static struct btrfs_key max_key = {
-		.objectid = (u64)-1,
-		.type = (u8)-1,
-		.offset = (u64)-1
-	};
-
-	rc = kzalloc(sizeof(*rc), GFP_KERNEL);
-	if (!rc)
-		return ERR_PTR(-ENOMEM);
-
-	rc->fs_info = root->fs_info;
-	rc->key_start = *key_start;
-	rc->key_end = *key_end;
-	atomic_set(&rc->elems, 0);
-	init_waitqueue_head(&rc->wait);
-	kref_init(&rc->refcnt);
-	kref_get(&rc->refcnt); /* one ref for having elements */
-
-	node = btrfs_root_node(root);
-	start = node->start;
-	generation = btrfs_header_generation(node);
-	level = btrfs_header_level(node);
-	free_extent_buffer(node);
-
-	ret = reada_add_block(rc, start, &max_key, root->root_key.objectid,
-			      generation, level);
-	if (ret) {
-		kfree(rc);
-		return ERR_PTR(ret);
-	}
-
-	reada_start_machine(root->fs_info);
-
-	return rc;
-}
-
-#ifdef DEBUG
-int btrfs_reada_wait(void *handle)
-{
-	struct reada_control *rc = handle;
-	struct btrfs_fs_info *fs_info = rc->fs_info;
-
-	while (atomic_read(&rc->elems)) {
-		if (!atomic_read(&fs_info->reada_works_cnt))
-			reada_start_machine(fs_info);
-		wait_event_timeout(rc->wait, atomic_read(&rc->elems) == 0,
-				   5 * HZ);
-		dump_devs(fs_info, atomic_read(&rc->elems) < 10 ? 1 : 0);
-	}
-
-	dump_devs(fs_info, atomic_read(&rc->elems) < 10 ? 1 : 0);
-
-	kref_put(&rc->refcnt, reada_control_release);
-
-	return 0;
-}
-#else
-int btrfs_reada_wait(void *handle)
-{
-	struct reada_control *rc = handle;
-	struct btrfs_fs_info *fs_info = rc->fs_info;
-
-	while (atomic_read(&rc->elems)) {
-		if (!atomic_read(&fs_info->reada_works_cnt))
-			reada_start_machine(fs_info);
-		wait_event_timeout(rc->wait, atomic_read(&rc->elems) == 0,
-				   (HZ + 9) / 10);
-	}
-
-	kref_put(&rc->refcnt, reada_control_release);
-
-	return 0;
-}
-#endif
-
-void btrfs_reada_detach(void *handle)
-{
-	struct reada_control *rc = handle;
-
-	kref_put(&rc->refcnt, reada_control_release);
-}
-
-/*
- * Before removing a device (device replace or device remove ioctls), call this
- * function to wait for all existing readahead requests on the device and to
- * make sure no one queues more readahead requests for the device.
- *
- * Must be called without holding neither the device list mutex nor the device
- * replace semaphore, otherwise it will deadlock.
- */
-void btrfs_reada_remove_dev(struct btrfs_device *dev)
-{
-	struct btrfs_fs_info *fs_info = dev->fs_info;
-
-	/* Serialize with readahead extent creation at reada_find_extent(). */
-	spin_lock(&fs_info->reada_lock);
-	set_bit(BTRFS_DEV_STATE_NO_READA, &dev->dev_state);
-	spin_unlock(&fs_info->reada_lock);
-
-	/*
-	 * There might be readahead requests added to the radix trees which
-	 * were not yet added to the readahead work queue. We need to start
-	 * them and wait for their completion, otherwise we can end up with
-	 * use-after-free problems when dropping the last reference on the
-	 * readahead extents and their zones, as they need to access the
-	 * device structure.
-	 */
-	reada_start_machine(fs_info);
-	btrfs_flush_workqueue(fs_info->readahead_workers);
-}
-
-/*
- * If when removing a device (device replace or device remove ioctls) an error
- * happens after calling btrfs_reada_remove_dev(), call this to undo what that
- * function did. This is safe to call even if btrfs_reada_remove_dev() was not
- * called before.
- */
-void btrfs_reada_undo_remove_dev(struct btrfs_device *dev)
-{
-	spin_lock(&dev->fs_info->reada_lock);
-	clear_bit(BTRFS_DEV_STATE_NO_READA, &dev->dev_state);
-	spin_unlock(&dev->fs_info->reada_lock);
-}
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index a3bd3dfd5e8b..e1c8e8812793 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3193,10 +3193,7 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	u64 physical_end;
 	u64 generation;
 	int mirror_num;
-	struct reada_control *reada1;
-	struct reada_control *reada2;
 	struct btrfs_key key;
-	struct btrfs_key key_end;
 	u64 increment = map->stripe_len;
 	u64 offset;
 	u64 extent_logical;
@@ -3246,11 +3243,6 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	path->search_commit_root = 1;
 	path->skip_locking = 1;
 
-	/*
-	 * trigger the readahead for extent tree csum tree and wait for
-	 * completion. During readahead, the scrub is officially paused
-	 * to not hold off transaction commits
-	 */
 	logical = base + offset;
 	physical_end = physical + nstripes * map->stripe_len;
 	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
@@ -3265,36 +3257,8 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	scrub_blocked_if_needed(fs_info);
 
 	root = btrfs_extent_root(fs_info, logical);
-
-	/* FIXME it might be better to start readahead at commit root */
-	key.objectid = logical;
-	key.type = BTRFS_EXTENT_ITEM_KEY;
-	key.offset = (u64)0;
-	key_end.objectid = logic_end;
-	key_end.type = BTRFS_METADATA_ITEM_KEY;
-	key_end.offset = (u64)-1;
-	reada1 = btrfs_reada_add(root, &key, &key_end);
-
 	csum_root = btrfs_csum_root(fs_info, logical);
 
-	if (cache->flags & BTRFS_BLOCK_GROUP_DATA) {
-		key.objectid = BTRFS_EXTENT_CSUM_OBJECTID;
-		key.type = BTRFS_EXTENT_CSUM_KEY;
-		key.offset = logical;
-		key_end.objectid = BTRFS_EXTENT_CSUM_OBJECTID;
-		key_end.type = BTRFS_EXTENT_CSUM_KEY;
-		key_end.offset = logic_end;
-		reada2 = btrfs_reada_add(csum_root, &key, &key_end);
-	} else {
-		reada2 = NULL;
-	}
-
-	if (!IS_ERR(reada1))
-		btrfs_reada_wait(reada1);
-	if (!IS_ERR_OR_NULL(reada2))
-		btrfs_reada_wait(reada2);
-
-
 	/*
 	 * collect all data csums for the stripe to avoid seeking during
 	 * the scrub. This might currently (crc32) end up to be about 1MB
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index a1c54a2c787c..0ec09fe01be6 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1842,7 +1842,6 @@ static void btrfs_resize_thread_pool(struct btrfs_fs_info *fs_info,
 	btrfs_workqueue_set_max(fs_info->endio_write_workers, new_pool_size);
 	btrfs_workqueue_set_max(fs_info->endio_freespace_worker, new_pool_size);
 	btrfs_workqueue_set_max(fs_info->delayed_workers, new_pool_size);
-	btrfs_workqueue_set_max(fs_info->readahead_workers, new_pool_size);
 	btrfs_workqueue_set_max(fs_info->scrub_wr_completion_workers,
 				new_pool_size);
 }
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index f38c230111be..141fd7b4b018 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1166,7 +1166,6 @@ static void btrfs_close_one_device(struct btrfs_device *device)
 	ASSERT(!test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state));
 	ASSERT(list_empty(&device->dev_alloc_list));
 	ASSERT(list_empty(&device->post_commit_list));
-	ASSERT(atomic_read(&device->reada_in_flight) == 0);
 }
 
 static void close_fs_devices(struct btrfs_fs_devices *fs_devices)
@@ -2148,8 +2147,6 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
 	}
 
 	ret = btrfs_shrink_device(device, 0);
-	if (!ret)
-		btrfs_reada_remove_dev(device);
 	if (ret)
 		goto error_undo;
 
@@ -2247,7 +2244,6 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
 	return ret;
 
 error_undo:
-	btrfs_reada_undo_remove_dev(device);
 	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
 		mutex_lock(&fs_info->chunk_mutex);
 		list_add(&device->dev_alloc_list,
@@ -6978,11 +6974,8 @@ struct btrfs_device *btrfs_alloc_device(struct btrfs_fs_info *fs_info,
 	INIT_LIST_HEAD(&dev->dev_alloc_list);
 	INIT_LIST_HEAD(&dev->post_commit_list);
 
-	atomic_set(&dev->reada_in_flight, 0);
 	atomic_set(&dev->dev_stats_ccnt, 0);
 	btrfs_device_data_ordered_init(dev);
-	INIT_RADIX_TREE(&dev->reada_zones, GFP_NOFS & ~__GFP_DIRECT_RECLAIM);
-	INIT_RADIX_TREE(&dev->reada_extents, GFP_NOFS & ~__GFP_DIRECT_RECLAIM);
 	extent_io_tree_init(fs_info, &dev->alloc_state,
 			    IO_TREE_DEVICE_ALLOC_STATE, NULL);
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 3b8130680749..b2467a9159d0 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -123,13 +123,6 @@ struct btrfs_device {
 	/* per-device scrub information */
 	struct scrub_ctx *scrub_ctx;
 
-	/* readahead state */
-	atomic_t reada_in_flight;
-	u64 reada_next;
-	struct reada_zone *reada_curr_zone;
-	struct radix_tree_root reada_zones;
-	struct radix_tree_root reada_extents;
-
 	/* disk I/O failure stats. For detailed description refer to
 	 * enum btrfs_dev_stat_values in ioctl.h */
 	int dev_stats_valid;
-- 
2.34.1

