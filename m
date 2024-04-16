Return-Path: <linux-btrfs+bounces-4308-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACF78A6BE0
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 15:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C7841F2278D
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 13:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC2F12C7FB;
	Tue, 16 Apr 2024 13:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wbl6xwVF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683B812C559
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Apr 2024 13:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713272903; cv=none; b=NIoJl8OoZ90IUgfVTxDX+wti3N0AX1asDPV4C08Q87SFbBeC2ltJHOdo+8IahjE7E81CgfJ/ZQwfYnvOFDhq2DcUqFIwNgyEtzE1wXtloISdJSS9PxSFwlrbEzl82j1CQpQOEM3N0RSub8FdrD4zpLeD8++luUFlKMf+zX71wwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713272903; c=relaxed/simple;
	bh=bpdAynDBPC6x2ztHBO/XyB4YARk/v6jttCB/E/J09kA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l67MAoIkboqMMjRE91aV9ZscsAi/T0cczxgoMDxYA8HkHp3+xnJC79qF3kSZJB+xXN41NF0DSY8VBPTOWxZTwafYdm1kfMm/J6fwCH6KGsNrj8yxAWYhlCRJrO8kO7SgNburj6FxaKrzXt230D3xMQlsac93xOUkKCd0pb32M/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wbl6xwVF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1B1C2BD10
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Apr 2024 13:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713272903;
	bh=bpdAynDBPC6x2ztHBO/XyB4YARk/v6jttCB/E/J09kA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Wbl6xwVFeRmD1ww0vMqEAQIP3jdOgmP2w4o/47XwDmM0ST05pcOPer6gqrPG2DFa8
	 MBpchkwoWivspmV1lmNm2Yl3NNxPHrgXcuFcCa58G3FMwfZF0Vxdkc9YTmvS4uJjOH
	 vWnh5KNJVYDBBosmYhA+wOg+DcKo8Ly3f8Yj6UBA3iFf/sDDkuWLapJH0XeSr/GJKE
	 ev2PVMLyM9GHzRNireMSbwpLx0ptY6RP3Aqp3vzbs+ELxmKaCJtjs1McwBwNEzY0IV
	 Y8KbKbH8sCzPEj7POtEnKTbu5MtDbvJUiQLf5+0B8HUrqjl/iPpqnRER7VOBrnpGEO
	 et6eDgO7H5zIQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 08/10] btrfs: add a shrinker for extent maps
Date: Tue, 16 Apr 2024 14:08:10 +0100
Message-Id: <4bfde54904b5a91a71eb0d86b9c78367865f93d8.1713267925.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1713267925.git.fdmanana@suse.com>
References: <cover.1713267925.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Extent maps are used either to represent existing file extent items, or to
represent new extents that are going to be written and the respective file
extent items are created when the ordered extent completes.

We currently don't have any limit for how many extent maps we can have,
neither per inode nor globally. Most of the time this not too noticeable
because extent maps are removed in the following situations:

1) When evicting an inode;

2) When releasing folios (pages) through the btrfs_release_folio() address
   space operation callback.

   However we won't release extent maps in the folio range if the folio is
   either dirty or under writeback or if the inode's i_size is less than
   or equals to 16M (see try_release_extent_mapping(). This 16M i_size
   constraint was added back in 2008 with commit 70dec8079d78 ("Btrfs:
   extent_io and extent_state optimizations"), but there's no explanation
   about why we have it or why the 16M value.

This means that for buffered IO we can reach an OOM situation due to too
many extent maps if either of the following happens:

1) There's a set of tasks constantly doing IO on many files with a size
   not larger than 16M, specially if they keep the files open for very
   long periods, therefore preventing inode eviction.

   This requires a really high number of such files, and having many non
   mergeable extent maps (due to random 4K writes for example) and a
   machine with very little memory;

2) There's a set tasks constantly doing random write IO (therefore
   creating many non mergeable extent maps) on files and keeping them
   open for long periods of time, so inode eviction doesn't happen and
   there's always a lot of dirty pages or pages under writeback,
   preventing btrfs_release_folio() from releasing the respective extent
   maps.

This second case was actually reported in the thread pointed by the Link
tag below, and it requires a very large file under heavy IO and a machine
with very little amount of RAM, which is probably hard to happen in
practice in a real world use case.

However when using direct IO this is not so hard to happen, because the
page cache is not used, and therefore btrfs_release_folio() is never
called. Which means extent maps are dropped only when evicting the inode,
and that means that if we have tasks that keep a file descriptor open and
keep doing IO on a very large file (or files), we can exhaust memory due
to an unbounded amount of extent maps. This is especially easy to happen
if we have a huge file with millions of small extents and their extent
maps are not mergeable (non contiguous offsets and disk locations).
This was reported in that thread with the following fio test:

   $ cat test.sh
   #!/bin/bash

   DEV=/dev/sdj
   MNT=/mnt/sdj
   MOUNT_OPTIONS="-o ssd"
   MKFS_OPTIONS=""

   cat <<EOF > /tmp/fio-job.ini
   [global]
   name=fio-rand-write
   filename=$MNT/fio-rand-write
   rw=randwrite
   bs=4K
   direct=1
   numjobs=16
   fallocate=none
   time_based
   runtime=90000

   [file1]
   size=300G
   ioengine=libaio
   iodepth=16

   EOF

   umount $MNT &> /dev/null
   mkfs.btrfs -f $MKFS_OPTIONS $DEV
   mount $MOUNT_OPTIONS $DEV $MNT

   fio /tmp/fio-job.ini
   umount $MNT

Monitoring the btrfs_extent_map slab while running the test with:

   $ watch -d -n 1 'cat /sys/kernel/slab/btrfs_extent_map/objects \
                        /sys/kernel/slab/btrfs_extent_map/total_objects'

Shows the number of active and total extent maps skyrocketing to tens of
millions, and on systems with a short amount of memory it's easy and quick
to get into an OOM situation, as reported in that thread.

So to avoid this issue add a shrinker that will remove extents maps, as
long as they are not pinned, and takes proper care with any concurrent
fsync to avoid missing extents (setting the full sync flag while in the
middle of a fast fsync). This shrinker is triggered through the callbacks
nr_cached_objects and free_cached_objects of struct super_operations.

The shrinker will iterates over all roots and over all inodes of each
root, and keeps track of the last scanned root and inode, so that the
next time it runs, it starts from that root and from the next inode.
This is similar to what xfs does for its inode reclaim (implements those
callbacks, and cycles through inodes by starting from where it ended
last time).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c | 159 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/extent_map.h |   1 +
 fs/btrfs/fs.h         |   2 +
 fs/btrfs/super.c      |  17 +++++
 4 files changed, 179 insertions(+)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 2fcf28148a81..b638d87db500 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -8,6 +8,7 @@
 #include "extent_map.h"
 #include "compression.h"
 #include "btrfs_inode.h"
+#include "disk-io.h"
 
 
 static struct kmem_cache *extent_map_cache;
@@ -1026,3 +1027,161 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 	free_extent_map(split_pre);
 	return ret;
 }
+
+static long btrfs_scan_inode(struct btrfs_inode *inode, long *scanned, long nr_to_scan)
+{
+	const u64 cur_fs_gen = btrfs_get_fs_generation(inode->root->fs_info);
+	struct extent_map_tree *tree = &inode->extent_tree;
+	long nr_dropped = 0;
+	struct rb_node *node;
+
+	/*
+	 * Take the mmap lock so that we serialize with the inode logging phase
+	 * of fsync because we may need to set the full sync flag on the inode,
+	 * in case we have to remove extent maps in the tree's list of modified
+	 * extents. If we set the full sync flag in the inode while an fsync is
+	 * in progress, we may risk missing new extents because before the flag
+	 * is set, fsync decides to only wait for writeback to complete and then
+	 * during inode logging it sees the flag set and uses the subvolume tree
+	 * to find new extents, which may not be there yet because ordered
+	 * extents haven't completed yet.
+	 *
+	 * We also do a try lock because otherwise we could deadlock. This is
+	 * because the shrinker for this filesystem may be invoked while we are
+	 * in a path that is holding the mmap lock in write mode. For example in
+	 * a reflink operation while COWing an extent buffer, when allocating
+	 * pages for a new extent buffer and under memory pressure, the shrinker
+	 * may be invoked, and therefore we would deadlock by attempting to read
+	 * lock the mmap lock while we are holding already a write lock on it.
+	 */
+	if (!down_read_trylock(&inode->i_mmap_lock))
+		return 0;
+
+	write_lock(&tree->lock);
+	node = rb_first_cached(&tree->map);
+	while (node) {
+		struct extent_map *em;
+
+		em = rb_entry(node, struct extent_map, rb_node);
+		node = rb_next(node);
+		(*scanned)++;
+
+		if (em->flags & EXTENT_FLAG_PINNED)
+			goto next;
+
+		/*
+		 * If the inode is in the list of modified extents (new) and its
+		 * generation is the same (or is greater than) the current fs
+		 * generation, it means it was not yet persisted so we have to
+		 * set the full sync flag so that the next fsync will not miss
+		 * it.
+		 */
+		if (!list_empty(&em->list) && em->generation >= cur_fs_gen)
+			btrfs_set_inode_full_sync(inode);
+
+		remove_extent_mapping(inode, em);
+		/* Drop the reference for the tree. */
+		free_extent_map(em);
+		nr_dropped++;
+next:
+		if (*scanned >= nr_to_scan)
+			break;
+
+		/*
+		 * Restart if we had to resched, and any extent maps that were
+		 * pinned before may have become unpinned after we released the
+		 * lock and took it again.
+		 */
+		if (cond_resched_rwlock_write(&tree->lock))
+			node = rb_first_cached(&tree->map);
+	}
+	write_unlock(&tree->lock);
+	up_read(&inode->i_mmap_lock);
+
+	return nr_dropped;
+}
+
+static long btrfs_scan_root(struct btrfs_root *root, long *scanned, long nr_to_scan)
+{
+	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct btrfs_inode *inode;
+	long nr_dropped = 0;
+	u64 min_ino = fs_info->extent_map_shrinker_last_ino + 1;
+
+	inode = btrfs_find_first_inode(root, min_ino);
+	while (inode) {
+		nr_dropped += btrfs_scan_inode(inode, scanned, nr_to_scan);
+
+		min_ino = btrfs_ino(inode) + 1;
+		fs_info->extent_map_shrinker_last_ino = btrfs_ino(inode);
+		iput(&inode->vfs_inode);
+
+		if (*scanned >= nr_to_scan)
+			break;
+
+		cond_resched();
+		inode = btrfs_find_first_inode(root, min_ino);
+	}
+
+	if (inode) {
+		/*
+		 * There are still inodes in this root or we happened to process
+		 * the last one and reached the scan limit. In either case set
+		 * the current root to this one, so we'll resume from the next
+		 * inode if there is one or we will find out this was the last
+		 * one and move to the next root.
+		 */
+		fs_info->extent_map_shrinker_last_root = btrfs_root_id(root);
+	} else {
+		/*
+		 * No more inodes in this root, set extent_map_shrinker_last_ino to 0 so
+		 * that when processing the next root we start from its first inode.
+		 */
+		fs_info->extent_map_shrinker_last_ino = 0;
+		fs_info->extent_map_shrinker_last_root = btrfs_root_id(root) + 1;
+	}
+
+	return nr_dropped;
+}
+
+long btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_to_scan)
+{
+	const u64 start_root_id = fs_info->extent_map_shrinker_last_root;
+	u64 next_root_id = start_root_id;
+	bool cycled = false;
+	long nr_dropped = 0;
+	long scanned = 0;
+
+	while (scanned < nr_to_scan) {
+		struct btrfs_root *root;
+		unsigned long count;
+
+		spin_lock(&fs_info->fs_roots_radix_lock);
+		count = radix_tree_gang_lookup(&fs_info->fs_roots_radix,
+					       (void **)&root, next_root_id, 1);
+		if (count == 0) {
+			spin_unlock(&fs_info->fs_roots_radix_lock);
+			if (start_root_id > 0 && !cycled) {
+				next_root_id = 0;
+				fs_info->extent_map_shrinker_last_root = 0;
+				fs_info->extent_map_shrinker_last_ino = 0;
+				cycled = true;
+				continue;
+			}
+			break;
+		}
+		next_root_id = btrfs_root_id(root) + 1;
+		root = btrfs_grab_root(root);
+		spin_unlock(&fs_info->fs_roots_radix_lock);
+
+		if (!root)
+			continue;
+
+		if (is_fstree(btrfs_root_id(root)))
+			nr_dropped += btrfs_scan_root(root, &scanned, nr_to_scan);
+
+		btrfs_put_root(root);
+	}
+
+	return nr_dropped;
+}
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index c3707461ff62..8306a8f294d0 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -140,5 +140,6 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode,
 int btrfs_replace_extent_map_range(struct btrfs_inode *inode,
 				   struct extent_map *new_em,
 				   bool modified);
+long btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_to_scan);
 
 #endif
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 534d30dafe32..9711c9c0e78f 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -631,6 +631,8 @@ struct btrfs_fs_info {
 	s32 delalloc_batch;
 
 	struct percpu_counter evictable_extent_maps;
+	u64 extent_map_shrinker_last_root;
+	u64 extent_map_shrinker_last_ino;
 
 	/* Protected by 'trans_lock'. */
 	struct list_head dirty_cowonly_roots;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 7e44ccaf348f..a3877e65d3b5 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2374,6 +2374,21 @@ static int btrfs_show_devname(struct seq_file *m, struct dentry *root)
 	return 0;
 }
 
+static long btrfs_nr_cached_objects(struct super_block *sb, struct shrink_control *sc)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
+
+	return percpu_counter_sum_positive(&fs_info->evictable_extent_maps);
+}
+
+static long btrfs_free_cached_objects(struct super_block *sb, struct shrink_control *sc)
+{
+	const long nr_to_scan = min_t(unsigned long, LONG_MAX, sc->nr_to_scan);
+	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
+
+	return btrfs_free_extent_maps(fs_info, nr_to_scan);
+}
+
 static const struct super_operations btrfs_super_ops = {
 	.drop_inode	= btrfs_drop_inode,
 	.evict_inode	= btrfs_evict_inode,
@@ -2387,6 +2402,8 @@ static const struct super_operations btrfs_super_ops = {
 	.statfs		= btrfs_statfs,
 	.freeze_fs	= btrfs_freeze,
 	.unfreeze_fs	= btrfs_unfreeze,
+	.nr_cached_objects = btrfs_nr_cached_objects,
+	.free_cached_objects = btrfs_free_cached_objects,
 };
 
 static const struct file_operations btrfs_ctl_fops = {
-- 
2.43.0


