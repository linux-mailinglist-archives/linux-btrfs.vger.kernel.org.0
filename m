Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752A06259D5
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Nov 2022 12:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbiKKLuw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Nov 2022 06:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbiKKLut (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Nov 2022 06:50:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01E827910
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 03:50:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42209B82510
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 11:50:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743EDC433B5
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 11:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668167446;
        bh=y4GeIG30dFdvSkVmKcYKvmwqJGTtvk67SLfUkL1CwMk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=XQ64o0kOBjekLqQmVd9lwJRcWcbySizOj4BmhdWEWVt8APF0ROvo5NfhFe0uzeFlR
         H88yMLdFj70fWotX/BYUUqkYYwKawIARaTiOrnZI6QItO4zV4FmBnZYbaklLjsl6cL
         sRnTIFoUDJfj5W+O8Fseudo/TLqBulaWSFFSRKW+2sxCZFNLTGZTuR7Ji5TOjL9x9C
         n/EO7Vg8PfANiryXjm658Ydjqyoq1NR4OTdF+/4VbPBOcbqmoNOaII/DVMr/lHbuhk
         0IOppFMEUzomf/N8IJCDokiD7eYFc7nmMasF8rNRgIGT0UZ4xBV2ZbZN7BR67F8TDp
         xhKFn8Y58+7Ew==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 9/9] btrfs: use cached state when looking for delalloc ranges with lseek
Date:   Fri, 11 Nov 2022 11:50:35 +0000
Message-Id: <df6dcc34db567e683cd050d0eb59523f549265a5.1668166764.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1668166764.git.fdmanana@suse.com>
References: <cover.1668166764.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

During lseek (SEEK_HOLE/DATA), whenever we find a hole or prealloc extent,
we will look for delalloc in that range, and one of the things we do for
that is to find out ranges in the inode's io_tree marked with
EXTENT_DELALLOC, using calls to count_range_bits().

Typically there's a single, or few, searches in the io_tree for delalloc
per lseek call. However it's common for applications to keep calling
lseek with SEEK_HOLE and SEEK_DATA to find where extents and holes are in
a file, read the extents and skip holes in order to avoid unnecessary IO
and save disk space by preserving holes.

One popular user is the cp utility from coreutils. Starting with coreutils
9.0, cp uses SEEK_HOLE and SEEK_DATA to iterate over the extents of a
file. Before 9.0, it used fiemap to figure out where holes and extents are
in the source file. Another popular user is the tar utility when used with
the --sparse / -S option to detect and preserve holes.

Given that the pattern is to keep calling lseek with a start offset that
matches the returned offset from the previous lseek call, we can benefit
from caching the last extent state visited in count_range_bits() and use
it for the next count_range_bits() from the next lseek call. Example,
the following strace excerpt from running tar:

   $ strace tar cJSvf foo.tar.xz qemu_disk_file.raw
   (...)
   lseek(5, 125019574272, SEEK_HOLE)       = 125024989184
   lseek(5, 125024989184, SEEK_DATA)       = 125024993280
   lseek(5, 125024993280, SEEK_HOLE)       = 125025239040
   lseek(5, 125025239040, SEEK_DATA)       = 125025255424
   lseek(5, 125025255424, SEEK_HOLE)       = 125025353728
   lseek(5, 125025353728, SEEK_DATA)       = 125025357824
   lseek(5, 125025357824, SEEK_HOLE)       = 125026766848
   lseek(5, 125026766848, SEEK_DATA)       = 125026770944
   lseek(5, 125026770944, SEEK_HOLE)       = 125027053568
   (...)

Shows that pattern, which is the same as with cp from coreutils 9.0+.

So start using a cached state for the delalloc searches in lseek, and
store it in struct file's private data so that it can be reused across
lseek calls.

This change is part of a patchset that is compresed of the following
patches:

  1/9 btrfs: remove leftover setting of EXTENT_UPTODATE state in an inode's io_tree
  2/9 btrfs: add an early exit when searching for delalloc range for lseek/fiemap
  3/9 btrfs: skip unnecessary delalloc searches during lseek/fiemap
  4/9 btrfs: search for delalloc more efficiently during lseek/fiemap
  5/9 btrfs: remove no longer used btrfs_next_extent_map()
  6/9 btrfs: allow passing a cached state record to count_range_bits()
  7/9 btrfs: update stale comment for count_range_bits()
  8/9 btrfs: use cached state when looking for delalloc ranges with fiemap
  9/9 btrfs: use cached state when looking for delalloc ranges with lseek

The following test was run before and after applying the whole patchset:

   $ cat test-cp.sh
   #!/bin/bash

   DEV=/dev/sdh
   MNT=/mnt/sdh

   # coreutils 8.32, cp uses fiemap to detect holes and extents
   #CP_PROG=/usr/bin/cp
   # coreutils 9.1, cp uses SEEK_HOLE/DATA to detect holes and extents
   CP_PROG=/home/fdmanana/git/hub/coreutils/src/cp

   umount $DEV &> /dev/null
   mkfs.btrfs -f $DEV
   mount $DEV $MNT

   FILE_SIZE=$((1024 * 1024 * 1024))
   echo "Creating file with a size of $((FILE_SIZE / 1024 / 1024))M"
   # Create a very sparse file, where each extent has a length of 4K and
   # is preceded by a 4K hole and followed by another 4K hole.
   start=$(date +%s%N)
   echo -n > $MNT/foobar
   for ((off = 0; off < $FILE_SIZE; off += 8192)); do
           xfs_io -c "pwrite -S 0xab $off 4K" $MNT/foobar > /dev/null
           echo -ne "\r$off / $FILE_SIZE ..."
   done
   end=$(date +%s%N)
   echo -e "\nFile created ($(( (end - start) / 1000000 )) milliseconds)"

   start=$(date +%s%N)
   $CP_PROG $MNT/foobar /dev/null
   end=$(date +%s%N)
   dur=$(( (end - start) / 1000000 ))
   echo "cp took $dur milliseconds with data/metadata cached and delalloc"

   # Flush all delalloc.
   sync

   start=$(date +%s%N)
   $CP_PROG $MNT/foobar /dev/null
   end=$(date +%s%N)
   dur=$(( (end - start) / 1000000 ))
   echo "cp took $dur milliseconds with data/metadata cached and no delalloc"

   # Unmount and mount again to test the case without any metadata
   # loaded in memory.
   umount $MNT
   mount $DEV $MNT

   start=$(date +%s%N)
   $CP_PROG $MNT/foobar /dev/null
   end=$(date +%s%N)
   dur=$(( (end - start) / 1000000 ))
   echo "cp took $dur milliseconds without data/metadata cached and no delalloc"

   umount $MNT

The results, running on a box with a non-debug kernel (Debian's default
kernel config), were the following:

128M file, before patchset:

   cp took 16574 milliseconds with data/metadata cached and delalloc
   cp took 122 milliseconds with data/metadata cached and no delalloc
   cp took 20144 milliseconds without data/metadata cached and no delalloc

128M file, after patchset:

   cp took 6277 milliseconds with data/metadata cached and delalloc
   cp took 109 milliseconds with data/metadata cached and no delalloc
   cp took 210 milliseconds without data/metadata cached and no delalloc

512M file, before patchset:

   cp took 14369 milliseconds with data/metadata cached and delalloc
   cp took 429 milliseconds with data/metadata cached and no delalloc
   cp took 88034 milliseconds without data/metadata cached and no delalloc

512M file, after patchset:

   cp took 12106 milliseconds with data/metadata cached and delalloc
   cp took 427 milliseconds with data/metadata cached and no delalloc
   cp took 824 milliseconds without data/metadata cached and no delalloc

1G file, before patchset:

   cp took 10074 milliseconds with data/metadata cached and delalloc
   cp took 886 milliseconds with data/metadata cached and no delalloc
   cp took 181261 milliseconds without data/metadata cached and no delalloc

1G file, after patchset:

   cp took 3320 milliseconds with data/metadata cached and delalloc
   cp took 880 milliseconds with data/metadata cached and no delalloc
   cp took 1801 milliseconds without data/metadata cached and no delalloc

Reported-by: Wang Yugui <wangyugui@e16-tech.com>
Link: https://lore.kernel.org/linux-btrfs/20221106073028.71F9.409509F4@e16-tech.com/
Link: https://lore.kernel.org/linux-btrfs/CAL3q7H5NSVicm7nYBJ7x8fFkDpno8z3PYt5aPU43Bajc1H0h1Q@mail.gmail.com/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.h |  1 +
 fs/btrfs/file.c  | 40 ++++++++++++++++++++++++++++++++--------
 2 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 5649f8907984..99defab7e1f6 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -426,6 +426,7 @@ struct btrfs_drop_extents_args {
 
 struct btrfs_file_private {
 	void *filldir_buf;
+	struct extent_state *llseek_cached_state;
 };
 
 static inline u32 BTRFS_LEAF_DATA_SIZE(const struct btrfs_fs_info *info)
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index da390f891220..448b143a5cb2 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1696,10 +1696,12 @@ int btrfs_release_file(struct inode *inode, struct file *filp)
 {
 	struct btrfs_file_private *private = filp->private_data;
 
-	if (private && private->filldir_buf)
+	if (private) {
 		kfree(private->filldir_buf);
-	kfree(private);
-	filp->private_data = NULL;
+		free_extent_state(private->llseek_cached_state);
+		kfree(private);
+		filp->private_data = NULL;
+	}
 
 	/*
 	 * Set by setattr when we are about to truncate a file from a non-zero
@@ -3398,13 +3400,14 @@ bool btrfs_find_delalloc_in_range(struct btrfs_inode *inode, u64 start, u64 end,
  * is found, it updates @start_ret with the start of the subrange.
  */
 static bool find_desired_extent_in_hole(struct btrfs_inode *inode, int whence,
+					struct extent_state **cached_state,
 					u64 start, u64 end, u64 *start_ret)
 {
 	u64 delalloc_start;
 	u64 delalloc_end;
 	bool delalloc;
 
-	delalloc = btrfs_find_delalloc_in_range(inode, start, end, NULL,
+	delalloc = btrfs_find_delalloc_in_range(inode, start, end, cached_state,
 						&delalloc_start, &delalloc_end);
 	if (delalloc && whence == SEEK_DATA) {
 		*start_ret = delalloc_start;
@@ -3447,11 +3450,13 @@ static bool find_desired_extent_in_hole(struct btrfs_inode *inode, int whence,
 	return false;
 }
 
-static loff_t find_desired_extent(struct btrfs_inode *inode, loff_t offset,
-				  int whence)
+static loff_t find_desired_extent(struct file *file, loff_t offset, int whence)
 {
+	struct btrfs_inode *inode = BTRFS_I(file->f_mapping->host);
+	struct btrfs_file_private *private = file->private_data;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct extent_state *cached_state = NULL;
+	struct extent_state **delalloc_cached_state;
 	const loff_t i_size = i_size_read(&inode->vfs_inode);
 	const u64 ino = btrfs_ino(inode);
 	struct btrfs_root *root = inode->root;
@@ -3476,6 +3481,22 @@ static loff_t find_desired_extent(struct btrfs_inode *inode, loff_t offset,
 	    inode_get_bytes(&inode->vfs_inode) == i_size)
 		return i_size;
 
+	if (!private) {
+		private = kzalloc(sizeof(*private), GFP_KERNEL);
+		/*
+		 * No worries if memory allocation failed.
+		 * The private structure is used only for speeding up multiple
+		 * lseek SEEK_HOLE/DATA calls to a file when there's delalloc,
+		 * so everything will still be correct.
+		 */
+		file->private_data = private;
+	}
+
+	if (private)
+		delalloc_cached_state = &private->llseek_cached_state;
+	else
+		delalloc_cached_state = NULL;
+
 	/*
 	 * offset can be negative, in this case we start finding DATA/HOLE from
 	 * the very start of the file.
@@ -3553,6 +3574,7 @@ static loff_t find_desired_extent(struct btrfs_inode *inode, loff_t offset,
 				search_start = offset;
 
 			found = find_desired_extent_in_hole(inode, whence,
+							    delalloc_cached_state,
 							    search_start,
 							    key.offset - 1,
 							    &found_start);
@@ -3587,6 +3609,7 @@ static loff_t find_desired_extent(struct btrfs_inode *inode, loff_t offset,
 				search_start = offset;
 
 			found = find_desired_extent_in_hole(inode, whence,
+							    delalloc_cached_state,
 							    search_start,
 							    extent_end - 1,
 							    &found_start);
@@ -3628,7 +3651,8 @@ static loff_t find_desired_extent(struct btrfs_inode *inode, loff_t offset,
 
 	/* We have an implicit hole from the last extent found up to i_size. */
 	if (!found && start < i_size) {
-		found = find_desired_extent_in_hole(inode, whence, start,
+		found = find_desired_extent_in_hole(inode, whence,
+						    delalloc_cached_state, start,
 						    i_size - 1, &start);
 		if (!found)
 			start = i_size;
@@ -3657,7 +3681,7 @@ static loff_t btrfs_file_llseek(struct file *file, loff_t offset, int whence)
 	case SEEK_DATA:
 	case SEEK_HOLE:
 		btrfs_inode_lock(BTRFS_I(inode), BTRFS_ILOCK_SHARED);
-		offset = find_desired_extent(BTRFS_I(inode), offset, whence);
+		offset = find_desired_extent(file, offset, whence);
 		btrfs_inode_unlock(BTRFS_I(inode), BTRFS_ILOCK_SHARED);
 		break;
 	}
-- 
2.35.1

