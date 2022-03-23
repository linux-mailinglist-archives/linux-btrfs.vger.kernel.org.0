Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F184E5639
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Mar 2022 17:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245444AbiCWQVO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Mar 2022 12:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237130AbiCWQVN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Mar 2022 12:21:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E3A7563D
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 09:19:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC4D66183B
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 16:19:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA2DC340E8
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 16:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648052382;
        bh=mD3dV1/IK6G9T3JKmAJENuqzXIRGle5vK8cCtd2YmHI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=rDLEyXRRWSRqA4HHpslyBXPCYq3Hx5eQlUGxtZguSgZY4bcX97dndXXwO7p/D12Is
         7OSrXpxCdsdMn5TWuhSFmNWeXBGLoQjaGCo/j8jCPtvP+q+ybmO7jsb/MCQ5ncpJeu
         2Ihh85GmY7llutZ/oFg30FKBN9tONgJA+U6ag2NHgAjeiV45OAEEzh8Yxk8fdyHRY7
         SQ6HGETR59lN/STMNffmzYQjtYfa48Eh9JxH2vqGWp4h/aJuOWGvhPwNxPlVO8gA1r
         jpjwezAoc9AKAg/ulRxfe2XPWDqksr0YZeFA9FxPNvnstlHdu3ckyTpe/lQqqzY7MT
         MYbgKIoPxx7nQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/8] btrfs: avoid double nocow check when doing nowait dio writes
Date:   Wed, 23 Mar 2022 16:19:25 +0000
Message-Id: <adb2fd0d9a5337f1740a50b04b4731bf82843a39.1648051582.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1648051582.git.fdmanana@suse.com>
References: <cover.1648051582.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When doing a NOWAIT direct IO write we are checking twice if we can COW
into the target file range using can_nocow_extent() - once at the very
beginning of the write path, at btrfs_write_check() via
check_nocow_nolock(), and later again at btrfs_get_blocks_direct_write().

The can_nocow_extent() function does a lot of expensive things - searching
for the file extent item in the inode's subvolume tree, searching for the
extent item in the extent tree, checking delayed references, etc, so it
isn't a very cheap call.

We can remove the first check at btrfs_write_check(), and add there a
quick check to verify if the inode has the NODATACOW or PREALLOC flags,
and quickly bail out if it doesn't have neither of those flags, as that
means we have to COW and therefore can't comply with the NOWAIT semantics.

After this we do only one call to can_nocow_extent(), while we are at
btrfs_get_blocks_direct_write(), where we have already locked the file
range and we did a try lock on the range before, at
btrfs_dio_iomap_begin() (since the previous patch in the series).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c  | 102 +++++++++++++++--------------------------------
 fs/btrfs/inode.c |   8 +++-
 2 files changed, 39 insertions(+), 71 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index bd329316945f..ceac806155b8 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1460,8 +1460,27 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct page **pages,
 	return ret;
 }
 
-static int check_can_nocow(struct btrfs_inode *inode, loff_t pos,
-			   size_t *write_bytes, bool nowait)
+/*
+ * Check if we can do nocow write into the range [@pos, @pos + @write_bytes)
+ *
+ * @pos:         File offset.
+ * @write_bytes: The length to write, will be updated to the nocow writeable
+ *               range.
+ *
+ * This function will flush ordered extents in the range to ensure proper
+ * nocow checks.
+ *
+ * Return:
+ * > 0          If we can nocow, and updates @write_bytes.
+ *  0           If we can't do a nocow write.
+ * -EAGAIN      If we can't do a nocow write because snapshoting of the inode's
+ *              root is in progress.
+ * < 0          If an error happened.
+ *
+ * NOTE: Callers need to call btrfs_check_nocow_unlock() if we return > 0.
+ */
+int btrfs_check_nocow_lock(struct btrfs_inode *inode, loff_t pos,
+			   size_t *write_bytes)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_root *root = inode->root;
@@ -1472,7 +1491,7 @@ static int check_can_nocow(struct btrfs_inode *inode, loff_t pos,
 	if (!(inode->flags & (BTRFS_INODE_NODATACOW | BTRFS_INODE_PREALLOC)))
 		return 0;
 
-	if (!nowait && !btrfs_drew_try_write_lock(&root->snapshot_lock))
+	if (!btrfs_drew_try_write_lock(&root->snapshot_lock))
 		return -EAGAIN;
 
 	lockstart = round_down(pos, fs_info->sectorsize);
@@ -1480,71 +1499,21 @@ static int check_can_nocow(struct btrfs_inode *inode, loff_t pos,
 			   fs_info->sectorsize) - 1;
 	num_bytes = lockend - lockstart + 1;
 
-	if (nowait) {
-		struct btrfs_ordered_extent *ordered;
-
-		if (!try_lock_extent(&inode->io_tree, lockstart, lockend))
-			return -EAGAIN;
-
-		ordered = btrfs_lookup_ordered_range(inode, lockstart,
-						     num_bytes);
-		if (ordered) {
-			btrfs_put_ordered_extent(ordered);
-			ret = -EAGAIN;
-			goto out_unlock;
-		}
-	} else {
-		btrfs_lock_and_flush_ordered_range(inode, lockstart,
-						   lockend, NULL);
-	}
-
+	btrfs_lock_and_flush_ordered_range(inode, lockstart, lockend, NULL);
 	ret = can_nocow_extent(&inode->vfs_inode, lockstart, &num_bytes,
 			NULL, NULL, NULL, false);
 	if (ret <= 0) {
 		ret = 0;
-		if (!nowait)
-			btrfs_drew_write_unlock(&root->snapshot_lock);
+		btrfs_drew_write_unlock(&root->snapshot_lock);
 	} else {
 		*write_bytes = min_t(size_t, *write_bytes ,
 				     num_bytes - pos + lockstart);
 	}
-out_unlock:
 	unlock_extent(&inode->io_tree, lockstart, lockend);
 
 	return ret;
 }
 
-static int check_nocow_nolock(struct btrfs_inode *inode, loff_t pos,
-			      size_t *write_bytes)
-{
-	return check_can_nocow(inode, pos, write_bytes, true);
-}
-
-/*
- * Check if we can do nocow write into the range [@pos, @pos + @write_bytes)
- *
- * @pos:	 File offset
- * @write_bytes: The length to write, will be updated to the nocow writeable
- *		 range
- *
- * This function will flush ordered extents in the range to ensure proper
- * nocow checks.
- *
- * Return:
- * >0		and update @write_bytes if we can do nocow write
- *  0		if we can't do nocow write
- * -EAGAIN	if we can't get the needed lock or there are ordered extents
- * 		for * (nowait == true) case
- * <0		if other error happened
- *
- * NOTE: Callers need to release the lock by btrfs_check_nocow_unlock().
- */
-int btrfs_check_nocow_lock(struct btrfs_inode *inode, loff_t pos,
-			   size_t *write_bytes)
-{
-	return check_can_nocow(inode, pos, write_bytes, false);
-}
-
 void btrfs_check_nocow_unlock(struct btrfs_inode *inode)
 {
 	btrfs_drew_write_unlock(&inode->root->snapshot_lock);
@@ -1579,20 +1548,15 @@ static int btrfs_write_check(struct kiocb *iocb, struct iov_iter *from,
 	loff_t oldsize;
 	loff_t start_pos;
 
-	if (iocb->ki_flags & IOCB_NOWAIT) {
-		size_t nocow_bytes = count;
-
-		/* We will allocate space in case nodatacow is not set, so bail */
-		if (check_nocow_nolock(BTRFS_I(inode), pos, &nocow_bytes) <= 0)
-			return -EAGAIN;
-		/*
-		 * There are holes in the range or parts of the range that must
-		 * be COWed (shared extents, RO block groups, etc), so just bail
-		 * out.
-		 */
-		if (nocow_bytes < count)
-			return -EAGAIN;
-	}
+	/*
+	 * Quickly bail out on NOWAIT writes if we don't have the nodatacow or
+	 * prealloc flags, as without those flags we always have to COW. We will
+	 * later check if we can really COW into the target range (using
+	 * can_nocow_extent() at btrfs_get_blocks_direct_write()).
+	 */
+	if ((iocb->ki_flags & IOCB_NOWAIT) &&
+	    !(BTRFS_I(inode)->flags & (BTRFS_INODE_NODATACOW | BTRFS_INODE_PREALLOC)))
+		return -EAGAIN;
 
 	current->backing_dev_info = inode_to_bdi(inode);
 	ret = file_remove_privs(file);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2412116a279d..c4b77017bf5c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7408,7 +7408,8 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 static int btrfs_get_blocks_direct_write(struct extent_map **map,
 					 struct inode *inode,
 					 struct btrfs_dio_data *dio_data,
-					 u64 start, u64 len)
+					 u64 start, u64 len,
+					 unsigned int iomap_flags)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct extent_map *em = *map;
@@ -7478,6 +7479,9 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		free_extent_map(em);
 		*map = NULL;
 
+		if (iomap_flags & IOMAP_NOWAIT)
+			return -EAGAIN;
+
 		/* We have to COW, so need to reserve metadata and data space. */
 		ret = btrfs_delalloc_reserve_space(BTRFS_I(inode),
 						   &dio_data->data_reserved,
@@ -7654,7 +7658,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 
 	if (write) {
 		ret = btrfs_get_blocks_direct_write(&em, inode, dio_data,
-						    start, len);
+						    start, len, flags);
 		if (ret < 0)
 			goto unlock_err;
 		unlock_extents = true;
-- 
2.33.0

