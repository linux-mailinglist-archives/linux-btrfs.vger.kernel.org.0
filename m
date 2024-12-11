Return-Path: <linux-btrfs+bounces-10229-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 290419ECF0E
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 15:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B48AC28401E
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 14:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99291ABEA8;
	Wed, 11 Dec 2024 14:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tg4BZm6Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02C51AAE01
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 14:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733928814; cv=none; b=QyvxmfHA1EUJKDutE0T5QVomAhWrdYzImUs9E2qZANpZAoouQ4bKskkNJpFaAesbFvDCqlxGbvfidi0CvrYcILBiyYen1V/zoIun8kswCeSSZFrSfYF5xczHkp5NBQq8pXOLr99Ml2s/xt7s7j/3VHBcqOYnX1j/FlRGmeOX6ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733928814; c=relaxed/simple;
	bh=FfqGGrIJ8xqJ4u62KUDF387J3v4JKcvwUsLGzjUoBuA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sotOwvfzf23aBJbOzYpCDRF1FqtEVYh+iJZ17eMRCWPdmdzCMPtYIU4S8RYjN5TzMLldW/vqiEP7Zf2azJ99F+Eayi8+Dx8dcDDGpeFjlgNJIL/lhadVcDHBzOc2oV0hcwT6/kvCvnHgYj+ucNKjIcKcVeo3KpJqQgBebNaTxzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tg4BZm6Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB22C4CED7
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 14:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733928813;
	bh=FfqGGrIJ8xqJ4u62KUDF387J3v4JKcvwUsLGzjUoBuA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=tg4BZm6YZjLiNVQyYx8envvRvwbweuJ3wRyNAGr8Qa9eKbr1G/Q/mIZtM5AtsgGb2
	 i0KZntsdNUMjPEnvJKlVPfqJUlR+MTebmlv4mmCVgHOHcB+3B5qfDuHYiUsfGMG0Jn
	 NcXkZM80tVAsYoFke237E8iue4j17nepFWSf18syHKuUUkrQOO4CIy+VuxQTjIg/2s
	 TOizJPpGzRqt8BscQat2RLF0whaw/jMmaBNWVVe6B2rWsfX2I3YI5iJeDcNw81zEu5
	 Sd1P4Cp3KfI57GBCUqTwAECbjQaVNE+8h1A20xD1iUtRaWiAk2Gjsr2AhbU0yJDoJK
	 Ua7SAEvhXvDEQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 02/11] btrfs: fix swap file activation failure due to extents that used to be shared
Date: Wed, 11 Dec 2024 14:53:19 +0000
Message-Id: <bda8a1de78c3d938a71a816401f96f0e0d6c3f72.1733832118.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1733832118.git.fdmanana@suse.com>
References: <cover.1733832118.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

When activating a swap file, to determine if an extent is shared we use
can_nocow_extent(), which ends up at btrfs_cross_ref_exist(). That helper
is meant to be quick because it's used in the NOCOW write path, when
flushing delalloc and when doing a direct IO write, however it does return
some false positives, meaning it may indicate that an extent is shared
even if it's no longer the case. For the write path this is fine, we just
do a unnecessary COW operation instead of doing a more rigorous check
which would be too heavy (calling btrfs_is_data_extent_shared()).

However when activating a swap file, the false positives simply result
in a failure, which is confusing for users/applications. One particular
case where this happens is when a data extent only has 1 reference but
that reference is not inlined in the extent item located in the extent
tree - this happens when we create more than 33 references for an extent
and then delete those 33 references plus every other non-inline reference
except one. The function check_committed_ref() assumes that if the size
of an extent item doesn't match the size of struct btrfs_extent_item
plus the size of an inline reference (plus an owner reference in case
simple quotas are enabled), then the extent is shared - that is not the
case however, we can have a single reference but it's not inlined - the
reason we do this is to be fast and avoid inspecting non-inline references
which may be located in another leaf of the extent tree, slowing down
write paths.

The following test script reproduces the bug:

   $ cat test.sh
   #!/bin/bash

   DEV=/dev/sdi
   MNT=/mnt/sdi
   NUM_CLONES=50

   umount $DEV &> /dev/null

   run_test()
   {
        local sync_after_add_reflinks=$1
        local sync_after_remove_reflinks=$2

        mkfs.btrfs -f $DEV > /dev/null
        #mkfs.xfs -f $DEV > /dev/null
        mount $DEV $MNT

        touch $MNT/foo
        chmod 0600 $MNT/foo
   	# On btrfs the file must be NOCOW.
        chattr +C $MNT/foo &> /dev/null
        xfs_io -s -c "pwrite -b 1M 0 1M" $MNT/foo
        mkswap $MNT/foo

        for ((i = 1; i <= $NUM_CLONES; i++)); do
            touch $MNT/foo_clone_$i
            chmod 0600 $MNT/foo_clone_$i
            # On btrfs the file must be NOCOW.
            chattr +C $MNT/foo_clone_$i &> /dev/null
            cp --reflink=always $MNT/foo $MNT/foo_clone_$i
        done

        if [ $sync_after_add_reflinks -ne 0 ]; then
            # Flush delayed refs and commit current transaction.
            sync -f $MNT
        fi

        # Remove the original file and all clones except the last.
        rm -f $MNT/foo
        for ((i = 1; i < $NUM_CLONES; i++)); do
            rm -f $MNT/foo_clone_$i
        done

        if [ $sync_after_remove_reflinks -ne 0 ]; then
            # Flush delayed refs and commit current transaction.
            sync -f $MNT
        fi

        # Now use the last clone as a swap file. It should work since
        # its extent are not shared anymore.
        swapon $MNT/foo_clone_${NUM_CLONES}
        swapoff $MNT/foo_clone_${NUM_CLONES}

        umount $MNT
   }

   echo -e "\nTest without sync after creating and removing clones"
   run_test 0 0

   echo -e "\nTest with sync after creating clones"
   run_test 1 0

   echo -e "\nTest with sync after removing clones"
   run_test 0 1

   echo -e "\nTest with sync after creating and removing clones"
   run_test 1 1

Running the test:

   $ ./test.sh
   Test without sync after creating and removing clones
   wrote 1048576/1048576 bytes at offset 0
   1 MiB, 1 ops; 0.0017 sec (556.793 MiB/sec and 556.7929 ops/sec)
   Setting up swapspace version 1, size = 1020 KiB (1044480 bytes)
   no label, UUID=a6b9c29e-5ef4-4689-a8ac-bc199c750f02
   swapon: /mnt/sdi/foo_clone_50: swapon failed: Invalid argument
   swapoff: /mnt/sdi/foo_clone_50: swapoff failed: Invalid argument

   Test with sync after creating clones
   wrote 1048576/1048576 bytes at offset 0
   1 MiB, 1 ops; 0.0036 sec (271.739 MiB/sec and 271.7391 ops/sec)
   Setting up swapspace version 1, size = 1020 KiB (1044480 bytes)
   no label, UUID=5e9008d6-1f7a-4948-a1b4-3f30aba20a33
   swapon: /mnt/sdi/foo_clone_50: swapon failed: Invalid argument
   swapoff: /mnt/sdi/foo_clone_50: swapoff failed: Invalid argument

   Test with sync after removing clones
   wrote 1048576/1048576 bytes at offset 0
   1 MiB, 1 ops; 0.0103 sec (96.665 MiB/sec and 96.6651 ops/sec)
   Setting up swapspace version 1, size = 1020 KiB (1044480 bytes)
   no label, UUID=916c2740-fa9f-4385-9f06-29c3f89e4764

   Test with sync after creating and removing clones
   wrote 1048576/1048576 bytes at offset 0
   1 MiB, 1 ops; 0.0031 sec (314.268 MiB/sec and 314.2678 ops/sec)
   Setting up swapspace version 1, size = 1020 KiB (1044480 bytes)
   no label, UUID=06aab1dd-4d90-49c0-bd9f-3a8db4e2f912
   swapon: /mnt/sdi/foo_clone_50: swapon failed: Invalid argument
   swapoff: /mnt/sdi/foo_clone_50: swapoff failed: Invalid argument

Fix this by reworking btrfs_swap_activate() to instead of using extent
maps and checking for shared extents with can_nocow_extent(), iterate
over the inode's file extent items and use the accurate
btrfs_is_data_extent_shared().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 96 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 69 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 926d82fbdbae..7ddb8a01b60f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9799,15 +9799,16 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	struct extent_state *cached_state = NULL;
-	struct extent_map *em = NULL;
 	struct btrfs_chunk_map *map = NULL;
 	struct btrfs_device *device = NULL;
 	struct btrfs_swap_info bsi = {
 		.lowest_ppage = (sector_t)-1ULL,
 	};
+	struct btrfs_backref_share_check_ctx *backref_ctx = NULL;
+	struct btrfs_path *path = NULL;
 	int ret = 0;
 	u64 isize;
-	u64 start;
+	u64 prev_extent_end = 0;
 
 	/*
 	 * Acquire the inode's mmap lock to prevent races with memory mapped
@@ -9846,6 +9847,13 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 		goto out_unlock_mmap;
 	}
 
+	path = btrfs_alloc_path();
+	backref_ctx = btrfs_alloc_backref_share_check_ctx();
+	if (!path || !backref_ctx) {
+		ret = -ENOMEM;
+		goto out_unlock_mmap;
+	}
+
 	/*
 	 * Balance or device remove/replace/resize can move stuff around from
 	 * under us. The exclop protection makes sure they aren't running/won't
@@ -9904,24 +9912,39 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 	isize = ALIGN_DOWN(inode->i_size, fs_info->sectorsize);
 
 	lock_extent(io_tree, 0, isize - 1, &cached_state);
-	start = 0;
-	while (start < isize) {
-		u64 logical_block_start, physical_block_start;
+	while (prev_extent_end < isize) {
+		struct btrfs_key key;
+		struct extent_buffer *leaf;
+		struct btrfs_file_extent_item *ei;
 		struct btrfs_block_group *bg;
-		u64 len = isize - start;
+		u64 logical_block_start;
+		u64 physical_block_start;
+		u64 extent_gen;
+		u64 disk_bytenr;
+		u64 len;
 
-		em = btrfs_get_extent(BTRFS_I(inode), NULL, start, len);
-		if (IS_ERR(em)) {
-			ret = PTR_ERR(em);
+		key.objectid = btrfs_ino(BTRFS_I(inode));
+		key.type = BTRFS_EXTENT_DATA_KEY;
+		key.offset = prev_extent_end;
+
+		ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+		if (ret < 0)
 			goto out;
-		}
 
-		if (em->disk_bytenr == EXTENT_MAP_HOLE) {
+		/*
+		 * If key not found it means we have an implicit hole (NO_HOLES
+		 * is enabled).
+		 */
+		if (ret > 0) {
 			btrfs_warn(fs_info, "swapfile must not have holes");
 			ret = -EINVAL;
 			goto out;
 		}
-		if (em->disk_bytenr == EXTENT_MAP_INLINE) {
+
+		leaf = path->nodes[0];
+		ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_extent_item);
+
+		if (btrfs_file_extent_type(leaf, ei) == BTRFS_FILE_EXTENT_INLINE) {
 			/*
 			 * It's unlikely we'll ever actually find ourselves
 			 * here, as a file small enough to fit inline won't be
@@ -9933,23 +9956,45 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 			ret = -EINVAL;
 			goto out;
 		}
-		if (extent_map_is_compressed(em)) {
+
+		if (btrfs_file_extent_compression(leaf, ei) != BTRFS_COMPRESS_NONE) {
 			btrfs_warn(fs_info, "swapfile must not be compressed");
 			ret = -EINVAL;
 			goto out;
 		}
 
-		logical_block_start = extent_map_block_start(em) + (start - em->start);
-		len = min(len, em->len - (start - em->start));
-		free_extent_map(em);
-		em = NULL;
+		disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, ei);
+		if (disk_bytenr == 0) {
+			btrfs_warn(fs_info, "swapfile must not have holes");
+			ret = -EINVAL;
+			goto out;
+		}
+
+		logical_block_start = disk_bytenr + btrfs_file_extent_offset(leaf, ei);
+		extent_gen = btrfs_file_extent_generation(leaf, ei);
+		prev_extent_end = btrfs_file_extent_end(path);
+
+		if (prev_extent_end > isize)
+			len = isize - key.offset;
+		else
+			len = btrfs_file_extent_num_bytes(leaf, ei);
 
-		ret = can_nocow_extent(inode, start, &len, NULL, false, true);
+		backref_ctx->curr_leaf_bytenr = leaf->start;
+
+		/*
+		 * Don't need the path anymore, release to avoid deadlocks when
+		 * calling btrfs_is_data_extent_shared() because when joining a
+		 * transaction it can block waiting for the current one's commit
+		 * which in turn may be trying to lock the same leaf to flush
+		 * delayed items for example.
+		 */
+		btrfs_release_path(path);
+
+		ret = btrfs_is_data_extent_shared(BTRFS_I(inode), disk_bytenr,
+						  extent_gen, backref_ctx);
 		if (ret < 0) {
 			goto out;
-		} else if (ret) {
-			ret = 0;
-		} else {
+		} else if (ret > 0) {
 			btrfs_warn(fs_info,
 				   "swapfile must not be copy-on-write");
 			ret = -EINVAL;
@@ -9984,7 +10029,6 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 
 		physical_block_start = (map->stripes[0].physical +
 					(logical_block_start - map->start));
-		len = min(len, map->chunk_len - (logical_block_start - map->start));
 		btrfs_free_chunk_map(map);
 		map = NULL;
 
@@ -10025,20 +10069,16 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 				if (ret)
 					goto out;
 			}
-			bsi.start = start;
+			bsi.start = key.offset;
 			bsi.block_start = physical_block_start;
 			bsi.block_len = len;
 		}
-
-		start += len;
 	}
 
 	if (bsi.block_len)
 		ret = btrfs_add_swap_extent(sis, &bsi);
 
 out:
-	if (!IS_ERR_OR_NULL(em))
-		free_extent_map(em);
 	if (!IS_ERR_OR_NULL(map))
 		btrfs_free_chunk_map(map);
 
@@ -10053,6 +10093,8 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 
 out_unlock_mmap:
 	up_write(&BTRFS_I(inode)->i_mmap_lock);
+	btrfs_free_backref_share_ctx(backref_ctx);
+	btrfs_free_path(path);
 	if (ret)
 		return ret;
 
-- 
2.45.2


