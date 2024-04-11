Return-Path: <linux-btrfs+bounces-4156-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6668A1C64
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 19:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF7B81C218BC
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 17:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA2216DEBB;
	Thu, 11 Apr 2024 16:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKjEbILr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A5A18412C
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 16:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712852370; cv=none; b=ufXGxhqR6tCO7gYjrG19aOqCIEkOqoyVAAA0nll3MsJgnaZaS+vl3Dpj6ogpme8fHvB53k2dHtstrERsWK7UX2j6x4no4mTtJ79ryNYQ6aVCCGKlL7bZsGWQ07s68TGglQm068MEfP+CzLDPhvx6n0y3C3d+Dvdi38nAkIjhmnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712852370; c=relaxed/simple;
	bh=9I0a4Xww6gAPTiXPED9QC5SFtk80nyL3MojG8Y6Tr8I=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QHhQfEjW+rvgzBHeZ1Zgfd3IhgxXpzHNogoD3r4d0b2wgQq3yy3tWcMmbaAwyFxCcwNM8XTVMLaMJl8o4SlxuJ9dmPReu5oSeK1n8mnDBufXgq/1NjWN+HFiRXYK9hO78ErsIiiFEOXi9eUBn8UcZaSIox1x4Hnou/PgR4vvNcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKjEbILr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B702C113CD
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 16:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712852369;
	bh=9I0a4Xww6gAPTiXPED9QC5SFtk80nyL3MojG8Y6Tr8I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=VKjEbILrOoLGLj+3bjKP9vKX9uDBFodeZ1A/nwnrGa2MtP91v0qBzts6uWEi5RVad
	 Lsn9I3krsg1EIVLGRxVNG5I/7U3NJ1FBnfio/pqY4Llimj0S7BYBxsKDPCdTkcWpL3
	 m0eP+6dQMhKWs3ua8ooO7nWz+VYw9vOR5fT2CwKekxBRQOfn18VWH0vCQtoA1di1ts
	 3JDKeuTPsLm+07kaDq0F/OWjWcsi/Zitq0fZqQBLh3Azc6+010j/MiwA9Vw9T6XgVR
	 SeIH+hKzN7QDhjTaujRnhsItz9uxQkQV/fE1g/QhgHudCVPhPWOMXBhY0BEVyjKe/p
	 1RklIN/nJBIrg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 13/15] btrfs: add a shrinker for extent maps
Date: Thu, 11 Apr 2024 17:19:07 +0100
Message-Id: <1cb649870b6cad4411da7998735ab1141bb9f2f0.1712837044.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1712837044.git.fdmanana@suse.com>
References: <cover.1712837044.git.fdmanana@suse.com>
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
middle of a fast fsync). This shrinker is similar to the one ext4 uses
for its extent_status structure, which is analogous to btrfs' extent_map
structure.

Link: https://lore.kernel.org/linux-btrfs/13f94633dcf04d29aaf1f0a43d42c55e@amazon.com/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c    |   7 +-
 fs/btrfs/extent_map.c | 156 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/extent_map.h |   2 +
 fs/btrfs/fs.h         |   2 +
 4 files changed, 163 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 3c2d35b2062e..8bb295eaf3d7 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1266,11 +1266,10 @@ static void free_global_roots(struct btrfs_fs_info *fs_info)
 
 void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 {
+	btrfs_unregister_extent_map_shrinker(fs_info);
 	percpu_counter_destroy(&fs_info->dirty_metadata_bytes);
 	percpu_counter_destroy(&fs_info->delalloc_bytes);
 	percpu_counter_destroy(&fs_info->ordered_bytes);
-	ASSERT(percpu_counter_sum_positive(&fs_info->evictable_extent_maps) == 0);
-	percpu_counter_destroy(&fs_info->evictable_extent_maps);
 	percpu_counter_destroy(&fs_info->dev_replace.bio_counter);
 	btrfs_free_csum_hash(fs_info);
 	btrfs_free_stripe_hash_table(fs_info);
@@ -2846,11 +2845,11 @@ static int init_mount_fs_info(struct btrfs_fs_info *fs_info, struct super_block
 	sb->s_blocksize = BTRFS_BDEV_BLOCKSIZE;
 	sb->s_blocksize_bits = blksize_bits(BTRFS_BDEV_BLOCKSIZE);
 
-	ret = percpu_counter_init(&fs_info->ordered_bytes, 0, GFP_KERNEL);
+	ret = btrfs_register_extent_map_shrinker(fs_info);
 	if (ret)
 		return ret;
 
-	ret = percpu_counter_init(&fs_info->evictable_extent_maps, 0, GFP_KERNEL);
+	ret = percpu_counter_init(&fs_info->ordered_bytes, 0, GFP_KERNEL);
 	if (ret)
 		return ret;
 
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 2fcf28148a81..9791acda5b57 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -8,6 +8,7 @@
 #include "extent_map.h"
 #include "compression.h"
 #include "btrfs_inode.h"
+#include "disk-io.h"
 
 
 static struct kmem_cache *extent_map_cache;
@@ -1026,3 +1027,158 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 	free_extent_map(split_pre);
 	return ret;
 }
+
+static unsigned long btrfs_scan_inode(struct btrfs_inode *inode,
+				      unsigned long *scanned,
+				      unsigned long nr_to_scan)
+{
+	struct extent_map_tree *tree = &inode->extent_tree;
+	unsigned long nr_dropped = 0;
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
+	 */
+	down_read(&inode->i_mmap_lock);
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
+		if (!list_empty(&em->list))
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
+static unsigned long btrfs_scan_root(struct btrfs_root *root,
+				     unsigned long *scanned,
+				     unsigned long nr_to_scan)
+{
+	struct btrfs_inode *inode;
+	unsigned long nr_dropped = 0;
+	u64 min_ino = 0;
+
+	inode = btrfs_find_first_inode(root, min_ino);
+	while (inode) {
+		nr_dropped += btrfs_scan_inode(inode, scanned, nr_to_scan);
+
+		min_ino = btrfs_ino(inode) + 1;
+		iput(&inode->vfs_inode);
+
+		if (*scanned >= nr_to_scan)
+			break;
+
+		cond_resched();
+		inode = btrfs_find_first_inode(root, min_ino);
+	}
+
+	return nr_dropped;
+}
+
+static unsigned long btrfs_extent_maps_scan(struct shrinker *shrinker,
+					    struct shrink_control *sc)
+{
+	struct btrfs_fs_info *fs_info = shrinker->private_data;
+	unsigned long nr_dropped = 0;
+	unsigned long scanned = 0;
+	u64 next_root_id = 0;
+
+	while (scanned < sc->nr_to_scan) {
+		struct btrfs_root *root;
+		unsigned long count;
+
+		spin_lock(&fs_info->fs_roots_radix_lock);
+		count = radix_tree_gang_lookup(&fs_info->fs_roots_radix,
+					       (void **)&root, next_root_id, 1);
+		if (count == 0) {
+			spin_unlock(&fs_info->fs_roots_radix_lock);
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
+			nr_dropped += btrfs_scan_root(root, &scanned, sc->nr_to_scan);
+
+		btrfs_put_root(root);
+	}
+
+	return nr_dropped;
+}
+
+static unsigned long btrfs_extent_maps_count(struct shrinker *shrinker,
+					     struct shrink_control *sc)
+{
+	struct btrfs_fs_info *fs_info = shrinker->private_data;
+
+	return percpu_counter_sum_positive(&fs_info->evictable_extent_maps);
+}
+
+int btrfs_register_extent_map_shrinker(struct btrfs_fs_info *fs_info)
+{
+	int ret;
+
+	ret = percpu_counter_init(&fs_info->evictable_extent_maps, 0, GFP_KERNEL);
+	if (ret)
+		return ret;
+
+	fs_info->extent_map_shrinker = shrinker_alloc(0, "em-btrfs:%s", fs_info->sb->s_id);
+	if (!fs_info->extent_map_shrinker) {
+		percpu_counter_destroy(&fs_info->evictable_extent_maps);
+		return -ENOMEM;
+	}
+
+	fs_info->extent_map_shrinker->scan_objects = btrfs_extent_maps_scan;
+	fs_info->extent_map_shrinker->count_objects = btrfs_extent_maps_count;
+	fs_info->extent_map_shrinker->private_data = fs_info;
+
+	shrinker_register(fs_info->extent_map_shrinker);
+
+	return 0;
+}
+
+void btrfs_unregister_extent_map_shrinker(struct btrfs_fs_info *fs_info)
+{
+	shrinker_free(fs_info->extent_map_shrinker);
+	ASSERT(percpu_counter_sum_positive(&fs_info->evictable_extent_maps) == 0);
+	percpu_counter_destroy(&fs_info->evictable_extent_maps);
+}
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index c3707461ff62..8a6be2f7a0e2 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -140,5 +140,7 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode,
 int btrfs_replace_extent_map_range(struct btrfs_inode *inode,
 				   struct extent_map *new_em,
 				   bool modified);
+int btrfs_register_extent_map_shrinker(struct btrfs_fs_info *fs_info);
+void btrfs_unregister_extent_map_shrinker(struct btrfs_fs_info *fs_info);
 
 #endif
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 534d30dafe32..f1414814bd69 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -857,6 +857,8 @@ struct btrfs_fs_info {
 	struct lockdep_map btrfs_trans_pending_ordered_map;
 	struct lockdep_map btrfs_ordered_extent_map;
 
+	struct shrinker *extent_map_shrinker;
+
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	spinlock_t ref_verify_lock;
 	struct rb_root block_tree;
-- 
2.43.0


