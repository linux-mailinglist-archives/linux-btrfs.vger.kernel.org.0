Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D943322A50
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Feb 2021 13:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbhBWMLk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Feb 2021 07:11:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:41630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232689AbhBWMJe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Feb 2021 07:09:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 901DD64E25
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Feb 2021 12:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614082133;
        bh=2fez1eKCiJtOXj51F8XTqr8DVrp7oBIqvrZhWsIjCW4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=bg3QI/A1CtpNiyVobNf/3V+O5zvY0MzmGcDLEZvt3NIHvUM49dtcxgKtY8pZyfMuV
         fX4HlIy3EVdYSIODxPt4kjk2X5PPo9Ln5aQCEjovc9nmyCRIh8dezg5bAlQ8zfkbHD
         DDK/l0ObsxSGSMGzXCW8tOYUZc+xyFZvWdOd2C6ipL9PSEWKrntfe4o8I6S7uLIAOZ
         RrfZEjWNGSR7USYrs/u+oKcjySSmVTtxlo6/fqbWqB2A5wIjxNYgXS2kU2scyOaa/P
         ya9Ukqowola+VRIv2p2JXTsEKkb6UonjIWABwqqPUIPzHmWNX/foKxu1UiIcxZfh9s
         0qhd/GWVhHcAA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: fix race between memory mapped writes and fsync
Date:   Tue, 23 Feb 2021 12:08:47 +0000
Message-Id: <913b5529db9d7ff6dcfb370785e471e0024241c2.1614081281.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1614081281.git.fdmanana@suse.com>
References: <cover.1614081281.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When doing an fsync we flush all delalloc, lock the inode (vfs lock), flush
any new delalloc that might have been created before taking the lock and
then wait either for the ordered extents to complete or just for the
writeback to complete (depending on whether the full sync flag is set or
not). We then start logging the inode and assume that while we are doing it
no one else is touching the inode's file extent items (or adding new ones).

That is generally true because all operations that modify an inode acquire
the inode's lock first, including buffered and direct IO writes. However
there is one exception: memory mapped writes, which do not and can not
acquire the inode's lock.

This can cause two types of issues: ending up logging file extent items
with overlapping ranges, which is detected by the tree checker and will
result in aborting the transaction when starting writeback for a log
tree's extent buffers, or a silent corruption where we log a version of
the file that never existed.

Scenario 1 - logging overlapping extents

The following steps explain how we can end up with file extents items with
overlapping ranges in a log tree due to a race between a fsync and memory
mapped writes:

1) Task A starts an fsync on inode X, which has the full sync runtime flag
   set. First it starts by flushing all delalloc for the inode;

2) Task A then locks the inode and flushes any other delalloc that might
   have been created after the previous flush and waits for all ordered
   extents to complete;

3) In the inode's root we have the following leaf:

   Leaf N, generation == current transaction id:

   ---------------------------------------------------------
   | (...)  [ file extent item, offset 640K, length 128K ] |
   ---------------------------------------------------------

   The last file extent item in leaf N covers the file range from 640K to
   768K;

4) Task B does a memory mapped write for the page corresponding to the
   file range from 764K to 768K;

5) Task A starts logging the inode. At copy_inode_items_to_log() it uses
   btrfs_search_forward() to search for leafs modified in the current
   transaction that contain items for the inode. It finds leaf N and copies
   all the inode items from that leaf into the log tree.

   Now the log tree has a copy of the last file extent item from leaf N.

   At the end of the while loop at copy_inode_items_to_log(), we have the
   minimum key set to:

   min_key.objectid = <inode X number>
   min_key.type = BTRFS_EXTENT_DATA_KEY
   min_key.offset = 640K

   Then we increment the key's offset by 1 so that the next call to
   btrfs_search_forward() leaves us at the first key greater than the key
   we just processed.

   But before btrfs_search_forward() is called again...

6) Dellaloc for the page at offset 764K, dirtied by task B, is started.
   It can be started for several reasons:

     - The async reclaim task is attempting to satisfy metadata or data
       reservation requests, and it has reached a point where it decided
       to flush delalloc;
     - Due to memory pressure the vm triggers writeback of dirty pages;
     - The system call sync_file_range(2) is called from user space.

7) When the respective ordered extent completes, it trims the length of
   the existing file extent item for file offset 640K from 128K to 124K,
   and a new file extent item is added with a key offset of 764K and a
   length of 4K;

8) Task A calls btrfs_search_forward(), which returns us a path pointing
   to the leaf (can be leaf N or some other) containing the new file extent
   item for file offset 764K.

   We end up copying this item to the log tree, which overlaps with the
   last copied file extent item, which covers the file range from 640K to
   768K.

   When writeback is triggered for log tree's extent buffers, the issue
   will be detected by the tree checker which will dump a trace and an
   error message on dmesg/syslog. If the writeback is triggered when
   syncing the log, which typically is, then we also end up aborting the
   current transaction.

This is the same type of problem fixed in 0c713cbab6200b ("Btrfs: fix race
between ranged fsync and writeback of adjacent ranges").

Scenario 2 - logging a version of the file that never existed

This scenario only happens when using the NO_HOLES feature and results in
a silent corruption, in the sense that is not detectable by 'btrfs check'
or the tree checker:

1) We have an inode I with a size of 1M and two file extent items, one
   covering an extent with disk_bytenr == X for the file range [0, 512K[
   and another one covering another extent with disk_bytenr == Y for the
   file range [512K, 1M[;

2) A hole is punched for the file range [512K, 1M[;

3) Task A starts an fsync of inode I, which has the full sync runtime flag
   set. It starts by flushing all existing delalloc, locks the inode (VFS
   lock), starts any new delalloc that might have been created before
   taking the lock and waits for all ordered extents to complete;

4) Some other task does a memory mapped write for the page corresponding to
   the file range [640K, 644K[ for example;

5) Task A then logs all items of the inode with the call to
   copy_inode_items_to_log();

6) In the meanwhile delalloc for the range [640K, 644K[ is started. It can
   be started for several reasons:

     - The async reclaim task is attempting to satisfy metadata or data
       reservation requests, and it has reached a point where it decided
       to flush delalloc;
     - Due to memory pressure the vm triggers writeback of dirty pages;
     - The system call sync_file_range(2) is called from user space.

7) The ordered extent for the range [640K, 644K[ completes and a file
   extent item for that range is added to the subvolume tree, pointing
   to a 4K extent with a disk_bytenr == Z;

8) Task A then calls btrfs_log_holes(), to scan for implicit holes in
   the subvolume tree. It finds two implicit holes:

   - one for the file range [512K, 640K[
   - one for the file range [644K, 1M[

   As a result we end up neither logging a hole for the range [640K, 644K[
   nor logging the file extent item with a disk_bytenr == Z.
   This means that if we have a power failure and replay the log tree we
   end up getting the following file extent layout:

   [ disk_bytenr X ]    [   hole   ]    [ disk_bytenr Y ]    [  hole  ]
   0             512K  512K      640K  640K           644K  644K     1M

   Which does not corresponding to any layout the file ever had before
   the power failure. The only two valid layouts would be:

   [ disk_bytenr X ]    [   hole   ]
   0             512K  512K        1M

   and

   [ disk_bytenr X ]    [   hole   ]    [ disk_bytenr Z ]    [  hole  ]
   0             512K  512K      640K  640K           644K  644K     1M

This can be fixed by serializing memory mapped writes with fsync, and there
are two ways to do it:

1) Make a fsync lock the entire file range, from 0 to (u64)-1 / LLONG_MAX
   in the inode's io tree. This prevents the race but also blocks any reads
   during the duration of the fsync, which has a negative impact for many
   common workloads;

2) Make an fsync write lock the i_mmap_lock semaphore in the inode. This
   semaphore was recently added by Josef's patch set:

   btrfs: add a i_mmap_lock to our inode
   btrfs: cleanup inode_lock/inode_unlock uses
   btrfs: exclude mmaps while doing remap
   btrfs: exclude mmap from happening during all fallocate operations

   and is used to solve races between memory mapped writes and
   clone/dedupe/fallocate. This also makes us have the same behaviour we
   have regarding other writes (buffered and direct IO) and fsync - block
   them while the inode logging is in progress.

This change uses the second approach due to the performance impact of the
first one.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 3a2928749349..809eee806505 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2122,7 +2122,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	if (ret)
 		goto out;
 
-	btrfs_inode_lock(inode, 0);
+	btrfs_inode_lock(inode, BTRFS_ILOCK_MMAP);
 
 	atomic_inc(&root->log_batch);
 
@@ -2135,11 +2135,11 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 			     &BTRFS_I(inode)->runtime_flags);
 
 	/*
-	 * Before we acquired the inode's lock, someone may have dirtied more
-	 * pages in the target range. We need to make sure that writeback for
-	 * any such pages does not start while we are logging the inode, because
-	 * if it does, any of the following might happen when we are not doing a
-	 * full inode sync:
+	 * Before we acquired the inode's lock and the mmap lock, someone may
+	 * have dirtied more pages in the target range. We need to make sure
+	 * that writeback for any such pages does not start while we are logging
+	 * the inode, because if it does, any of the following might happen when
+	 * we are not doing a full inode sync:
 	 *
 	 * 1) We log an extent after its writeback finishes but before its
 	 *    checksums are added to the csum tree, leading to -EIO errors
@@ -2154,7 +2154,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 */
 	ret = start_ordered_ops(inode, start, end);
 	if (ret) {
-		btrfs_inode_unlock(inode, 0);
+		btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
 		goto out;
 	}
 
@@ -2255,7 +2255,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 * file again, but that will end up using the synchronization
 	 * inside btrfs_sync_log to keep things safe.
 	 */
-	btrfs_inode_unlock(inode, 0);
+	btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
 
 	if (ret != BTRFS_NO_LOG_SYNC) {
 		if (!ret) {
@@ -2285,7 +2285,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 
 out_release_extents:
 	btrfs_release_log_ctx_extents(&ctx);
-	btrfs_inode_unlock(inode, 0);
+	btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
 	goto out;
 }
 
-- 
2.28.0

