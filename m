Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2928F6259D4
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Nov 2022 12:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbiKKLuv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Nov 2022 06:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbiKKLus (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Nov 2022 06:50:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B708527DFE
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 03:50:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B472B825D1
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 11:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913D1C433C1
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 11:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668167446;
        bh=flc+OlLp4siZK4hJVRla/9qefL5DIv3KYEKILD+W8GE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Omshl2UKV3IOIFNtXmswTD5ISmNTw8Xq3xNN7SteDZm7Ad2FXyu7VEsbVzY7GP5Eu
         6lJRF6Q/OJmMSuULOc44Bel0MXQ4rpWLGInzUOjaEjyrRcdKNfmwzZxrRcBEYdpqBT
         f1jq4SM6CdxC6AeLP/hBo2zGKCwVLiM/f0OtvbW8xS0gBOaQJY5Kvz3j4RZ9OpNp/i
         4NoPb+DJf2Z95bDEa9D4tmClVW8EGKKUY441MwUhTFpRvbTw+aP1MMPyZ9AAeb6AY5
         BrEvKMWrFpY88ML3yahE87tSQm3f3QcVo1fxdgio09okmJ82ApkN6/C8gOYjQrZEF4
         UHnrbUJHCmfQA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 8/9] btrfs: use cached state when looking for delalloc ranges with fiemap
Date:   Fri, 11 Nov 2022 11:50:34 +0000
Message-Id: <d7bee83ed765fe81b96349c7de00cd2e647d228b.1668166764.git.fdmanana@suse.com>
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

During fiemap, whenever we find a hole or prealloc extent, we will look
for delalloc in that range, and one of the things we do for that is to
find out ranges in the inode's io_tree marked with EXTENT_DELALLOC, using
calls to count_range_bits().

Since we process file extents from left to right, if we have a file with
several holes or prealloc extents, we benefit from keeping a cached extent
state record for calls to count_range_bits(). Most of the time the last
extent state record we visited in one call to count_range_bits() matches
the first extent state record we will use in the next call to
count_range_bits(), so there's a benefit here. So use an extent state
record to cache results from count_range_bits() calls during fiemap.

This change is part of a patchset that has the goal to make performance
better for applications that use lseek's SEEK_HOLE and SEEK_DATA modes to
iterate over the extents of a file. Two examples are the cp program from
coreutils 9.0+ and the tar program (when using its --sparse / -S option).
A sample test and results are listed in the changelog of the last patch
in the series:

  1/9 btrfs: remove leftover setting of EXTENT_UPTODATE state in an inode's io_tree
  2/9 btrfs: add an early exit when searching for delalloc range for lseek/fiemap
  3/9 btrfs: skip unnecessary delalloc searches during lseek/fiemap
  4/9 btrfs: search for delalloc more efficiently during lseek/fiemap
  5/9 btrfs: remove no longer used btrfs_next_extent_map()
  6/9 btrfs: allow passing a cached state record to count_range_bits()
  7/9 btrfs: update stale comment for count_range_bits()
  8/9 btrfs: use cached state when looking for delalloc ranges with fiemap
  9/9 btrfs: use cached state when looking for delalloc ranges with lseek

Reported-by: Wang Yugui <wangyugui@e16-tech.com>
Link: https://lore.kernel.org/linux-btrfs/20221106073028.71F9.409509F4@e16-tech.com/
Link: https://lore.kernel.org/linux-btrfs/CAL3q7H5NSVicm7nYBJ7x8fFkDpno8z3PYt5aPU43Bajc1H0h1Q@mail.gmail.com/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_io.c | 11 ++++++++++-
 fs/btrfs/file.c      | 10 +++++++---
 fs/btrfs/file.h      |  1 +
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index bf19011037d1..1e8d58fc0806 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3698,6 +3698,7 @@ static int fiemap_search_slot(struct btrfs_inode *inode, struct btrfs_path *path
 static int fiemap_process_hole(struct btrfs_inode *inode,
 			       struct fiemap_extent_info *fieinfo,
 			       struct fiemap_cache *cache,
+			       struct extent_state **delalloc_cached_state,
 			       struct btrfs_backref_share_check_ctx *backref_ctx,
 			       u64 disk_bytenr, u64 extent_offset,
 			       u64 extent_gen,
@@ -3722,6 +3723,7 @@ static int fiemap_process_hole(struct btrfs_inode *inode,
 		bool delalloc;
 
 		delalloc = btrfs_find_delalloc_in_range(inode, cur_offset, end,
+							delalloc_cached_state,
 							&delalloc_start,
 							&delalloc_end);
 		if (!delalloc)
@@ -3892,6 +3894,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 {
 	const u64 ino = btrfs_ino(inode);
 	struct extent_state *cached_state = NULL;
+	struct extent_state *delalloc_cached_state = NULL;
 	struct btrfs_path *path;
 	struct fiemap_cache cache = { 0 };
 	struct btrfs_backref_share_check_ctx *backref_ctx;
@@ -3966,6 +3969,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 			const u64 range_end = min(key.offset, lockend) - 1;
 
 			ret = fiemap_process_hole(inode, fieinfo, &cache,
+						  &delalloc_cached_state,
 						  backref_ctx, 0, 0, 0,
 						  prev_extent_end, range_end);
 			if (ret < 0) {
@@ -4006,6 +4010,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 						 extent_len, flags);
 		} else if (extent_type == BTRFS_FILE_EXTENT_PREALLOC) {
 			ret = fiemap_process_hole(inode, fieinfo, &cache,
+						  &delalloc_cached_state,
 						  backref_ctx,
 						  disk_bytenr, extent_offset,
 						  extent_gen, key.offset,
@@ -4013,6 +4018,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 		} else if (disk_bytenr == 0) {
 			/* We have an explicit hole. */
 			ret = fiemap_process_hole(inode, fieinfo, &cache,
+						  &delalloc_cached_state,
 						  backref_ctx, 0, 0, 0,
 						  key.offset, extent_end - 1);
 		} else {
@@ -4070,7 +4076,8 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 	path = NULL;
 
 	if (!stopped && prev_extent_end < lockend) {
-		ret = fiemap_process_hole(inode, fieinfo, &cache, backref_ctx,
+		ret = fiemap_process_hole(inode, fieinfo, &cache,
+					  &delalloc_cached_state, backref_ctx,
 					  0, 0, 0, prev_extent_end, lockend - 1);
 		if (ret < 0)
 			goto out_unlock;
@@ -4088,6 +4095,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 			delalloc = btrfs_find_delalloc_in_range(inode,
 								prev_extent_end,
 								i_size - 1,
+								&delalloc_cached_state,
 								&delalloc_start,
 								&delalloc_end);
 			if (!delalloc)
@@ -4102,6 +4110,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 out_unlock:
 	unlock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
 out:
+	free_extent_state(delalloc_cached_state);
 	btrfs_free_backref_share_ctx(backref_ctx);
 	btrfs_free_path(path);
 	return ret;
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index dc8399610ca3..da390f891220 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3214,6 +3214,7 @@ static long btrfs_fallocate(struct file *file, int mode,
  * looping while it gets adjacent subranges, and merging them together.
  */
 static bool find_delalloc_subrange(struct btrfs_inode *inode, u64 start, u64 end,
+				   struct extent_state **cached_state,
 				   bool *search_io_tree,
 				   u64 *delalloc_start_ret, u64 *delalloc_end_ret)
 {
@@ -3236,7 +3237,7 @@ static bool find_delalloc_subrange(struct btrfs_inode *inode, u64 start, u64 end
 			delalloc_len = count_range_bits(&inode->io_tree,
 							delalloc_start_ret, end,
 							len, EXTENT_DELALLOC, 1,
-							NULL);
+							cached_state);
 		} else {
 			spin_unlock(&inode->lock);
 		}
@@ -3324,6 +3325,8 @@ static bool find_delalloc_subrange(struct btrfs_inode *inode, u64 start, u64 end
  *                       sector size aligned.
  * @end:                 The end offset (inclusive value) of the search range.
  *                       It does not need to be sector size aligned.
+ * @cached_state:        Extent state record used for speeding up delalloc
+ *                       searches in the inode's io_tree. Can be NULL.
  * @delalloc_start_ret:  Output argument, set to the start offset of the
  *                       subrange found with delalloc (may not be sector size
  *                       aligned).
@@ -3335,6 +3338,7 @@ static bool find_delalloc_subrange(struct btrfs_inode *inode, u64 start, u64 end
  * end offsets of the subrange.
  */
 bool btrfs_find_delalloc_in_range(struct btrfs_inode *inode, u64 start, u64 end,
+				  struct extent_state **cached_state,
 				  u64 *delalloc_start_ret, u64 *delalloc_end_ret)
 {
 	u64 cur_offset = round_down(start, inode->root->fs_info->sectorsize);
@@ -3348,7 +3352,7 @@ bool btrfs_find_delalloc_in_range(struct btrfs_inode *inode, u64 start, u64 end,
 		bool delalloc;
 
 		delalloc = find_delalloc_subrange(inode, cur_offset, end,
-						  &search_io_tree,
+						  cached_state, &search_io_tree,
 						  &delalloc_start,
 						  &delalloc_end);
 		if (!delalloc)
@@ -3400,7 +3404,7 @@ static bool find_desired_extent_in_hole(struct btrfs_inode *inode, int whence,
 	u64 delalloc_end;
 	bool delalloc;
 
-	delalloc = btrfs_find_delalloc_in_range(inode, start, end,
+	delalloc = btrfs_find_delalloc_in_range(inode, start, end, NULL,
 						&delalloc_start, &delalloc_end);
 	if (delalloc && whence == SEEK_DATA) {
 		*start_ret = delalloc_start;
diff --git a/fs/btrfs/file.h b/fs/btrfs/file.h
index f3d794e33d46..82b34fbb295f 100644
--- a/fs/btrfs/file.h
+++ b/fs/btrfs/file.h
@@ -27,6 +27,7 @@ int btrfs_check_nocow_lock(struct btrfs_inode *inode, loff_t pos,
 			   size_t *write_bytes, bool nowait);
 void btrfs_check_nocow_unlock(struct btrfs_inode *inode);
 bool btrfs_find_delalloc_in_range(struct btrfs_inode *inode, u64 start, u64 end,
+				  struct extent_state **cached_state,
 				  u64 *delalloc_start_ret, u64 *delalloc_end_ret);
 
 #endif
-- 
2.35.1

