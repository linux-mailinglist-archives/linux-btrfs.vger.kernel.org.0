Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A195BCE0B
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Sep 2022 16:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiISOGs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Sep 2022 10:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiISOGr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Sep 2022 10:06:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2982A96B
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 07:06:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D85861D07
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 14:06:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9177FC433D7
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 14:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663596405;
        bh=Hh2J65AxHGwhdNXJ6C8pRWCLkruvX4y5J7kyW+iXZHQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=U4BB9RsB9nVpk2hZO39tvwx4AsXvjLVQr+p4QSSHm9OAYcAOtfYfOnjWoCrg2FBLs
         6MFRfXJL9o97N945a6PzdeMzCJDhi690i2EkK21v6MZ2jBS8mtDDnyZX26JCeYejtn
         FxqHkY+3F5zYRiNmaGCAUJfHEJluTEoubawPE+nUsmVhZr2UipgZesjrZlOeJCudG2
         2oIgR4btjovQIJUO7esw55+n5aQkJMMNg5PR/zfAlZr9/9ZvRHrdAJLy17rlt3bFb2
         8T/3hApRehC9MgzMijpuuFAzxkEBDenPiZ/+mRql5oAUOjND+mICaD8ARo0Ta/yfqR
         CcfgsnAMyB+fQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 01/13] btrfs: fix missed extent on fsync after dropping extent maps
Date:   Mon, 19 Sep 2022 15:06:28 +0100
Message-Id: <25d72acc3215f74fbb885562667bf12401c214e9.1663594828.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1663594828.git.fdmanana@suse.com>
References: <cover.1663594828.git.fdmanana@suse.com>
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

When dropping extent maps for a range, through btrfs_drop_extent_cache(),
if we find an extent map that starts before our target range and/or ends
before the target range, and we are not able to allocate extent maps for
splitting that extent map, then we don't fail and simply remove the entire
extent map from the inode's extent map tree.

This is generally fine, because in case anyone needs to access the extent
map, it can just load it again later from the respective file extent
item(s) in the subvolume btree. However, if that extent map is new and is
in the list of modified extents, then a fast fsync will miss the parts of
the extent that were outside our range (that needed to be split),
therefore not logging them. Fix that by marking the inode for a full
fsync. This issue was introduced after removing BUG_ON()s triggered when
the split extent map allocations failed, done by commit 7014cdb49305ed
("Btrfs: btrfs_drop_extent_cache should never fail"), back in 2012, and
the fast fsync path already existed but was very recent.

Also, in the case where we could allocate extent maps for the split
operations but then fail to add a split extent map to the tree, mark the
inode for a full fsync as well. This is not supposed to ever fail, and we
assert that, but in case assertions are disabled (CONFIG_BTRFS_ASSERT is
not set), it's the correct thing to do to make sure a fast fsync will not
miss a new extent.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 58 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index fea508a35900..0e52292cf8bc 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -523,6 +523,7 @@ void btrfs_drop_extent_cache(struct btrfs_inode *inode, u64 start, u64 end,
 		testend = 0;
 	}
 	while (1) {
+		bool ends_after_range = false;
 		int no_splits = 0;
 
 		modified = false;
@@ -539,10 +540,12 @@ void btrfs_drop_extent_cache(struct btrfs_inode *inode, u64 start, u64 end,
 			write_unlock(&em_tree->lock);
 			break;
 		}
+		if (testend && em->start + em->len > start + len)
+			ends_after_range = true;
 		flags = em->flags;
 		gen = em->generation;
 		if (skip_pinned && test_bit(EXTENT_FLAG_PINNED, &em->flags)) {
-			if (testend && em->start + em->len >= start + len) {
+			if (ends_after_range) {
 				free_extent_map(em);
 				write_unlock(&em_tree->lock);
 				break;
@@ -592,7 +595,7 @@ void btrfs_drop_extent_cache(struct btrfs_inode *inode, u64 start, u64 end,
 			split = split2;
 			split2 = NULL;
 		}
-		if (testend && em->start + em->len > start + len) {
+		if (ends_after_range) {
 			u64 diff = start + len - em->start;
 
 			split->start = start + len;
@@ -630,14 +633,42 @@ void btrfs_drop_extent_cache(struct btrfs_inode *inode, u64 start, u64 end,
 			} else {
 				ret = add_extent_mapping(em_tree, split,
 							 modified);
-				ASSERT(ret == 0); /* Logic error */
+				/* Logic error, shouldn't happen. */
+				ASSERT(ret == 0);
+				if (WARN_ON(ret != 0) && modified)
+					btrfs_set_inode_full_sync(inode);
 			}
 			free_extent_map(split);
 			split = NULL;
 		}
 next:
-		if (extent_map_in_tree(em))
+		if (extent_map_in_tree(em)) {
+			/*
+			 * If the extent map is still in the tree it means that
+			 * either of the following is true:
+			 *
+			 * 1) It fits entirely in our range (doesn't end beyond
+			 *    it or starts before it);
+			 *
+			 * 2) It starts before our range and/or ends after our
+			 *    range, and we were not able to allocate the extent
+			 *    maps for split operations, @split and @split2.
+			 *
+			 * If we are at case 2) then we just remove the entire
+			 * extent map - this is fine since if anyone needs it to
+			 * access the subranges outside our range, will just
+			 * load it again from the subvolume tree's file extent
+			 * item. However if the extent map was in the list of
+			 * modified extents, then we must mark the inode for a
+			 * full fsync, otherwise a fast fsync will miss this
+			 * extent if it's new and needs to be logged.
+			 */
+			if ((em->start < start || ends_after_range) && modified) {
+				ASSERT(no_splits);
+				btrfs_set_inode_full_sync(inode);
+			}
 			remove_extent_mapping(em_tree, em);
+		}
 		write_unlock(&em_tree->lock);
 
 		/* once for us */
@@ -2199,14 +2230,6 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 
 	atomic_inc(&root->log_batch);
 
-	/*
-	 * Always check for the full sync flag while holding the inode's lock,
-	 * to avoid races with other tasks. The flag must be either set all the
-	 * time during logging or always off all the time while logging.
-	 */
-	full_sync = test_bit(BTRFS_INODE_NEEDS_FULL_SYNC,
-			     &BTRFS_I(inode)->runtime_flags);
-
 	/*
 	 * Before we acquired the inode's lock and the mmap lock, someone may
 	 * have dirtied more pages in the target range. We need to make sure
@@ -2231,6 +2254,17 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 		goto out;
 	}
 
+	/*
+	 * Always check for the full sync flag while holding the inode's lock,
+	 * to avoid races with other tasks. The flag must be either set all the
+	 * time during logging or always off all the time while logging.
+	 * We check the flag here after starting delalloc above, because when
+	 * running delalloc the full sync flag may be set if we need to drop
+	 * extra extent map ranges due to temporary memory allocation failures.
+	 */
+	full_sync = test_bit(BTRFS_INODE_NEEDS_FULL_SYNC,
+			     &BTRFS_I(inode)->runtime_flags);
+
 	/*
 	 * We have to do this here to avoid the priority inversion of waiting on
 	 * IO of a lower priority task while holding a transaction open.
-- 
2.35.1

