Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB868178E79
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2020 11:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgCDKeI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Mar 2020 05:34:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:36810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbgCDKeI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Mar 2020 05:34:08 -0500
Received: from debian6.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC76820705
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Mar 2020 10:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583318048;
        bh=bhsXzYzMoi4rRjwEGne9d8e8E6jUXmGPWL94YxKN190=;
        h=From:To:Subject:Date:From;
        b=M9bt3A19bO+amzLxGtBjnD+Ln4Y3xPVW01GEyqI9lXvyW+Ie61Te9F6uwIEbjmIjI
         SSlmu5s81Vo6gDtZvcuhWwBiQg/iq6bjFNyOvfO00tq0/99Ed1ng/3S/x/RHnM+hh7
         tE0l4e5bxV1caTxQztv2ntKqEWz6p6T++I6+HSBo=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] Btrfs: make ranged full fsyncs more efficient
Date:   Wed,  4 Mar 2020 10:34:04 +0000
Message-Id: <20200304103404.5571-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Commit 0c713cbab6200b ("Btrfs: fix race between ranged fsync and writeback
of adjacent ranges") fixed a bug where we could end up with file extent
items in a log tree that represent file ranges that overlap due to a race
between the hole detection of a ranged full fsync and writeback for a
different file range.

The problem was solved by forcing any ranged full fsync to become a
non-ranged full fsync - setting the range start to 0 and the end offset to
LLONG_MAX. This was a simple solution because the code that detected and
marked holes was very complex, it used to be done at copy_items() and
implied several searches on the fs/subvolume tree. The drawback of that
solution was that we started to flush delalloc for the entire file and
wait for all the ordered extents to complete for ranged full fsyncs
(including ordered extents covering ranges completely outside the given
range). Fortunatelly ranged full fsyncs are not the most common case.

However a later fix for detecting and marking holes was made by commit
0e56315ca147b3 ("Btrfs: fix missing hole after hole punching and fsync
when using NO_HOLES") and it simplified a lot the detection of holes,
and now copy_items() no longer does it and we do it in a much more simple
way at btrfs_log_holes(). This makes it now possible to simply make the
code that detects holes to operate only on the initial range and no longer
need to operate on the whole file, while also avoiding the need to flush
delalloc for the entire file and wait for ordered extents that cover
ranges that don't overlap the given range.

So this change just does that, making any ranged full fsync to actually
operate only on the given range and not the whole file.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c     | 13 -----------
 fs/btrfs/tree-log.c | 64 +++++++++++++++++++++++++++++++++++++----------------
 2 files changed, 45 insertions(+), 32 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 6ba39f11580c..617f0d7f222f 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2094,19 +2094,6 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	atomic_inc(&root->log_batch);
 
 	/*
-	 * If the inode needs a full sync, make sure we use a full range to
-	 * avoid log tree corruption, due to hole detection racing with ordered
-	 * extent completion for adjacent ranges, and assertion failures during
-	 * hole detection. Do this while holding the inode lock, to avoid races
-	 * with other tasks.
-	 */
-	if (test_bit(BTRFS_INODE_NEEDS_FULL_SYNC,
-		     &BTRFS_I(inode)->runtime_flags)) {
-		start = 0;
-		end = LLONG_MAX;
-	}
-
-	/*
 	 * Before we acquired the inode's lock, someone may have dirtied more
 	 * pages in the target range. We need to make sure that writeback for
 	 * any such pages does not start while we are logging the inode, because
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 19c107be9ef6..53e69791cf6b 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4534,29 +4534,43 @@ static int btrfs_log_all_xattrs(struct btrfs_trans_handle *trans,
 static int btrfs_log_holes(struct btrfs_trans_handle *trans,
 			   struct btrfs_root *root,
 			   struct btrfs_inode *inode,
-			   struct btrfs_path *path)
+			   struct btrfs_path *path,
+			   u64 start,
+			   u64 end)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
+	const u64 sectorsize = fs_info->sectorsize;
 	struct btrfs_key key;
 	const u64 ino = btrfs_ino(inode);
 	const u64 i_size = i_size_read(&inode->vfs_inode);
-	u64 prev_extent_end = 0;
+	u64 prev_extent_end;
 	int ret;
 
 	if (!btrfs_fs_incompat(fs_info, NO_HOLES) || i_size == 0)
 		return 0;
 
+	start = ALIGN_DOWN(start, sectorsize);
+	end = ALIGN(end, sectorsize);
+	prev_extent_end = start;
+
 	key.objectid = ino;
 	key.type = BTRFS_EXTENT_DATA_KEY;
-	key.offset = 0;
+	key.offset = start;
 
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 	if (ret < 0)
 		return ret;
 
+	if (ret > 0 && path->slots[0] > 0) {
+		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0] - 1);
+		if (key.objectid == ino && key.type == BTRFS_EXTENT_DATA_KEY)
+			path->slots[0]--;
+	}
+
 	while (true) {
 		struct btrfs_file_extent_item *extent;
 		struct extent_buffer *leaf = path->nodes[0];
+		u64 extent_end;
 		u64 len;
 
 		if (path->slots[0] >= btrfs_header_nritems(path->nodes[0])) {
@@ -4574,9 +4588,28 @@ static int btrfs_log_holes(struct btrfs_trans_handle *trans,
 		if (key.objectid != ino || key.type != BTRFS_EXTENT_DATA_KEY)
 			break;
 
+		extent = btrfs_item_ptr(leaf, path->slots[0],
+					struct btrfs_file_extent_item);
+		if (btrfs_file_extent_type(leaf, extent) ==
+		    BTRFS_FILE_EXTENT_INLINE) {
+			len = btrfs_file_extent_ram_bytes(leaf, extent);
+			extent_end = ALIGN(key.offset + len, sectorsize);
+		} else {
+			len = btrfs_file_extent_num_bytes(leaf, extent);
+			extent_end = key.offset + len;
+		}
+
+		if (extent_end <= start)
+			goto next_slot;
+
 		/* We have a hole, log it. */
 		if (prev_extent_end < key.offset) {
-			const u64 hole_len = key.offset - prev_extent_end;
+			u64 hole_len;
+
+			if (key.offset >= end)
+				hole_len = end - prev_extent_end;
+			else
+				hole_len = key.offset - prev_extent_end;
 
 			/*
 			 * Release the path to avoid deadlocks with other code
@@ -4606,27 +4639,20 @@ static int btrfs_log_holes(struct btrfs_trans_handle *trans,
 			leaf = path->nodes[0];
 		}
 
-		extent = btrfs_item_ptr(leaf, path->slots[0],
-					struct btrfs_file_extent_item);
-		if (btrfs_file_extent_type(leaf, extent) ==
-		    BTRFS_FILE_EXTENT_INLINE) {
-			len = btrfs_file_extent_ram_bytes(leaf, extent);
-			prev_extent_end = ALIGN(key.offset + len,
-						fs_info->sectorsize);
-		} else {
-			len = btrfs_file_extent_num_bytes(leaf, extent);
-			prev_extent_end = key.offset + len;
-		}
-
+		prev_extent_end = min(extent_end, end);
+		if (extent_end >= end)
+			break;
+next_slot:
 		path->slots[0]++;
 		cond_resched();
 	}
 
-	if (prev_extent_end < i_size) {
+	if (prev_extent_end < end && prev_extent_end < i_size) {
 		u64 hole_len;
 
 		btrfs_release_path(path);
-		hole_len = ALIGN(i_size - prev_extent_end, fs_info->sectorsize);
+		hole_len = min(ALIGN(i_size, sectorsize), end);
+		hole_len -= prev_extent_end;
 		ret = btrfs_insert_file_extent(trans, root->log_root,
 					       ino, prev_extent_end, 0, 0,
 					       hole_len, 0, hole_len,
@@ -5259,7 +5285,7 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 	if (max_key.type >= BTRFS_EXTENT_DATA_KEY && !fast_search) {
 		btrfs_release_path(path);
 		btrfs_release_path(dst_path);
-		err = btrfs_log_holes(trans, root, inode, path);
+		err = btrfs_log_holes(trans, root, inode, path, start, end);
 		if (err)
 			goto out_unlock;
 	}
-- 
2.11.0

