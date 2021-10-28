Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA80343E488
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Oct 2021 17:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhJ1PGN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Oct 2021 11:06:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:33418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230406AbhJ1PGM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Oct 2021 11:06:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E8D061038
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Oct 2021 15:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635433425;
        bh=DxTCAnnM7d0TGPTGd9skffEqVUqomxRhFqsP5wqfExk=;
        h=From:To:Subject:Date:From;
        b=NnXBWrwU6Xp8XKzjjqJaOuBj8u79zxiHM6d9Oz1rHlNAUO/Aq6jkZydjBSOFgMjc5
         ilL0WYqWtBsiY9F8B/o8BWgNmulwOMl03QguZKcLgIQeRkiuO1phGDbGIsvVe4l+PO
         wD/4+KRBBv56G1xbgHngmNIuD9Vjnft0PV4LmD9/yTFLQlem2jfV3vBBjDgETRRJdd
         nu4uPNWfh2uUXFH9h7h1NRfb7JtSZzC7b94AFdeG5ys5bmWAxyq3a7Hft5miuxN6oQ
         4xNo7zYeLc3ii2mQPs/aMJ8TsxCbaE6wfnCIydn4dnKIbvLQXS7q2u1gvafBOr8AuP
         JKX7t8dUAo+zg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix ENOSPC failure when attempting direct IO write into NOCOW range
Date:   Thu, 28 Oct 2021 16:03:41 +0100
Message-Id: <42b432f82ad45a829a9712a15e1684f2e85c82ea.1635433374.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When doing a direct IO write against a file range that either has
preallocated extents in that range or has regular extents and the file
has the NOCOW attribute set, the write fails with -ENOSPC when all of
the following conditions are met:

1) There are no data blocks groups with enough free space matching
   the size of the write;

2) There's not enough unallocated space for allocating a new data block
   group;

3) The extents in the target file range are not shared, neither through
   snapshots nor through reflinks.

This is wrong because a NOCOW write can be done in such case, and in fact
it's possible to do it using a buffered IO write, since when failing to
allocate data space, the buffered IO path checks if a NOCOW write is
possible.

The failure in direct IO write path comes from the fact that early on,
at btrfs_dio_iomap_begin(), we try to allocate data space for the write
and if it that fails we return the error and stop - we never check if we
can do NOCOW. But later, at btrfs_get_blocks_direct_write(), we check
if we can do a NOCOW write into the range, or a subset of the range, and
then release the previously reserved data space.

Fix this by doing the data reservation only if needed, when we must COW,
at btrfs_get_blocks_direct_write() instead of doing it at
btrfs_dio_iomap_begin(). This also simplifies a bit the logic and removes
the inneficiency of doing unnecessary data reservations.

The following example test script reproduces the problem:

  $ cat dio-nocow-enospc.sh
  #!/bin/bash

  DEV=/dev/sdj
  MNT=/mnt/sdj

  # Use a small fixed size (1G) filesystem so that it's quick to fill
  # it up.
  # Make sure the mixed block groups feature is not enabled because we
  # later want to not have more space available for allocating data
  # extents but still have enough metadata space free for the file writes.
  mkfs.btrfs -f -b $((1024 * 1024 * 1024)) -O ^mixed-bg $DEV
  mount $DEV $MNT

  # Create our test file with the NOCOW attribute set.
  touch $MNT/foobar
  chattr +C $MNT/foobar

  # Now fill in all unallocated space with data for our test file.
  # This will allocate a data block group that will be full and leave
  # no (or a very small amount of) unallocated space in the device, so
  # that it will not be possible to allocate a new block group later.
  echo
  echo "Creating test file with initial data..."
  xfs_io -c "pwrite -S 0xab -b 1M 0 900M" $MNT/foobar

  # Now try a direct IO write against file range [0, 10M[.
  # This should succeed since this is a NOCOW file and an extent for the
  # range was previously allocated.
  echo
  echo "Trying direct IO write over allocated space..."
  xfs_io -d -c "pwrite -S 0xcd -b 10M 0 10M" $MNT/foobar

  umount $MNT

When running the test:

  $ ./dio-nocow-enospc.sh
  (...)

  Creating test file with initial data...
  wrote 943718400/943718400 bytes at offset 0
  900 MiB, 900 ops; 0:00:01.43 (625.526 MiB/sec and 625.5265 ops/sec)

  Trying direct IO write over allocated space...
  pwrite: No space left on device

A test case for fstests will follow, testing both this direct IO write
scenario as well as the buffered IO write scenario to make it less likely
to get future regressions on the buffered IO case.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 142 ++++++++++++++++++++++++++---------------------
 1 file changed, 78 insertions(+), 64 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5fec009fbe63..11cf255ed60c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -60,8 +60,6 @@ struct btrfs_iget_args {
 };
 
 struct btrfs_dio_data {
-	u64 reserve;
-	loff_t length;
 	ssize_t submitted;
 	struct extent_changeset *data_reserved;
 };
@@ -7771,6 +7769,10 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct extent_map *em = *map;
+	int type;
+	u64 block_start, orig_start, orig_block_len, ram_bytes;
+	bool can_nocow = false;
+	bool space_reserved = false;
 	int ret = 0;
 
 	/*
@@ -7785,9 +7787,6 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 	if (test_bit(EXTENT_FLAG_PREALLOC, &em->flags) ||
 	    ((BTRFS_I(inode)->flags & BTRFS_INODE_NODATACOW) &&
 	     em->block_start != EXTENT_MAP_HOLE)) {
-		int type;
-		u64 block_start, orig_start, orig_block_len, ram_bytes;
-
 		if (test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
 			type = BTRFS_ORDERED_PREALLOC;
 		else
@@ -7797,53 +7796,92 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 
 		if (can_nocow_extent(inode, start, &len, &orig_start,
 				     &orig_block_len, &ram_bytes, false) == 1 &&
-		    btrfs_inc_nocow_writers(fs_info, block_start)) {
-			struct extent_map *em2;
+		    btrfs_inc_nocow_writers(fs_info, block_start))
+			can_nocow = true;
+	}
 
-			em2 = btrfs_create_dio_extent(BTRFS_I(inode), start, len,
-						      orig_start, block_start,
-						      len, orig_block_len,
-						      ram_bytes, type);
+	if (can_nocow) {
+		struct extent_map *em2;
+
+		/* We can NOCOW, so only need to reserve metadata space. */
+		ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode), len);
+		if (ret < 0) {
+			/* Our caller expects us to free the input extent map. */
+			free_extent_map(em);
+			*map = NULL;
 			btrfs_dec_nocow_writers(fs_info, block_start);
-			if (type == BTRFS_ORDERED_PREALLOC) {
-				free_extent_map(em);
-				*map = em = em2;
-			}
+			goto out;
+		}
+		space_reserved = true;
 
-			if (em2 && IS_ERR(em2)) {
-				ret = PTR_ERR(em2);
-				goto out;
-			}
-			/*
-			 * For inode marked NODATACOW or extent marked PREALLOC,
-			 * use the existing or preallocated extent, so does not
-			 * need to adjust btrfs_space_info's bytes_may_use.
-			 */
-			btrfs_free_reserved_data_space_noquota(fs_info, len);
-			goto skip_cow;
+		em2 = btrfs_create_dio_extent(BTRFS_I(inode), start, len,
+					      orig_start, block_start,
+					      len, orig_block_len,
+					      ram_bytes, type);
+		btrfs_dec_nocow_writers(fs_info, block_start);
+		if (type == BTRFS_ORDERED_PREALLOC) {
+			free_extent_map(em);
+			*map = em = em2;
 		}
-	}
 
-	/* this will cow the extent */
-	free_extent_map(em);
-	*map = em = btrfs_new_extent_direct(BTRFS_I(inode), start, len);
-	if (IS_ERR(em)) {
-		ret = PTR_ERR(em);
-		goto out;
+		if (IS_ERR(em2)) {
+			ret = PTR_ERR(em2);
+			goto out;
+		}
+	} else {
+		const u64 prev_len = len;
+
+		/* Our caller expects us to free the input extent map. */
+		free_extent_map(em);
+		*map = NULL;
+
+		/* We have to COW, so need to reserve metadata and data space. */
+		ret = btrfs_delalloc_reserve_space(BTRFS_I(inode),
+						   &dio_data->data_reserved,
+						   start, len);
+		if (ret < 0)
+			goto out;
+		space_reserved = true;
+
+		em = btrfs_new_extent_direct(BTRFS_I(inode), start, len);
+		if (IS_ERR(em)) {
+			ret = PTR_ERR(em);
+			goto out;
+		}
+		*map = em;
+		len = min(len, em->len - (start - em->start));
+		if (len < prev_len)
+			btrfs_delalloc_release_space(BTRFS_I(inode),
+						     dio_data->data_reserved,
+						     start + len, prev_len - len,
+						     true);
 	}
 
-	len = min(len, em->len - (start - em->start));
+	/*
+	 * We have created our ordered extent, so we can now release our reservation
+	 * for an outstanding extent.
+	 */
+	btrfs_delalloc_release_extents(BTRFS_I(inode), len);
 
-skip_cow:
 	/*
 	 * Need to update the i_size under the extent lock so buffered
 	 * readers will get the updated i_size when we unlock.
 	 */
 	if (start + len > i_size_read(inode))
 		i_size_write(inode, start + len);
-
-	dio_data->reserve -= len;
 out:
+	if (ret && space_reserved) {
+		btrfs_delalloc_release_extents(BTRFS_I(inode), len);
+		if (can_nocow) {
+			btrfs_delalloc_release_metadata(BTRFS_I(inode), len, true);
+		} else {
+			btrfs_delalloc_release_space(BTRFS_I(inode),
+						     dio_data->data_reserved,
+						     start, len, true);
+			extent_changeset_free(dio_data->data_reserved);
+			dio_data->data_reserved = NULL;
+		}
+	}
 	return ret;
 }
 
@@ -7885,18 +7923,6 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	if (!dio_data)
 		return -ENOMEM;
 
-	dio_data->length = length;
-	if (write) {
-		dio_data->reserve = round_up(length, fs_info->sectorsize);
-		ret = btrfs_delalloc_reserve_space(BTRFS_I(inode),
-				&dio_data->data_reserved,
-				start, dio_data->reserve);
-		if (ret) {
-			extent_changeset_free(dio_data->data_reserved);
-			kfree(dio_data);
-			return ret;
-		}
-	}
 	iomap->private = dio_data;
 
 
@@ -7989,14 +8015,8 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	unlock_extent_cached(&BTRFS_I(inode)->io_tree, lockstart, lockend,
 			     &cached_state);
 err:
-	if (dio_data) {
-		btrfs_delalloc_release_space(BTRFS_I(inode),
-				dio_data->data_reserved, start,
-				dio_data->reserve, true);
-		btrfs_delalloc_release_extents(BTRFS_I(inode), dio_data->reserve);
-		extent_changeset_free(dio_data->data_reserved);
-		kfree(dio_data);
-	}
+	kfree(dio_data);
+
 	return ret;
 }
 
@@ -8026,14 +8046,8 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 		ret = -ENOTBLK;
 	}
 
-	if (write) {
-		if (dio_data->reserve)
-			btrfs_delalloc_release_space(BTRFS_I(inode),
-					dio_data->data_reserved, pos,
-					dio_data->reserve, true);
-		btrfs_delalloc_release_extents(BTRFS_I(inode), dio_data->length);
+	if (write)
 		extent_changeset_free(dio_data->data_reserved);
-	}
 out:
 	kfree(dio_data);
 	iomap->private = NULL;
-- 
2.33.0

