Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2016152DF
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 21:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiKAUMs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 16:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiKAUMk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 16:12:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896061D0F3
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 13:12:39 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4048B336C4;
        Tue,  1 Nov 2022 20:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667333558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MnMLcKPFs6BTx2S4cjHw1O/v11EPnXMXTGr2Ob2L/cc=;
        b=p+NK0scZc0hmp7YIOyRW7hJVunlLijhJh/1/ZypqNBGomz64IXjvzqVod4lBTq2y06Tt+h
        ziJB3Xoh+rU3oU5nVhsSIPpR5c6MtPsLT5RfVtg62OWmyEJgrBoUfBap738nwuPieGKOrt
        xzQL0/AmVLQIttZSa0KFiqgtg6Srkzo=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 38FDB2C141;
        Tue,  1 Nov 2022 20:12:38 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 80B82DA79D; Tue,  1 Nov 2022 21:12:21 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 19/40] btrfs: pass btrfs_inode to btrfs_inode_unlock
Date:   Tue,  1 Nov 2022 21:12:21 +0100
Message-Id: <855a43e661177305d759af90e798fc7ec708205c.1667331828.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1667331828.git.dsterba@suse.com>
References: <cover.1667331828.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function is for internal interfaces so we should use the
btrfs_inode.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/btrfs_inode.h   |  2 +-
 fs/btrfs/defrag.c        |  8 ++++----
 fs/btrfs/delayed-inode.c |  2 +-
 fs/btrfs/file.c          | 32 ++++++++++++++++----------------
 fs/btrfs/inode.c         | 18 +++++++++---------
 fs/btrfs/ioctl.c         |  6 +++---
 fs/btrfs/reflink.c       |  2 +-
 fs/btrfs/relocation.c    |  2 +-
 8 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index a06d1c0a0cc2..279bbbc59dc6 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -546,7 +546,7 @@ enum btrfs_ilock_type {
 };
 
 int btrfs_inode_lock(struct btrfs_inode *inode, unsigned int ilock_flags);
-void btrfs_inode_unlock(struct inode *inode, unsigned int ilock_flags);
+void btrfs_inode_unlock(struct btrfs_inode *inode, unsigned int ilock_flags);
 void btrfs_update_inode_bytes(struct btrfs_inode *inode, const u64 add_bytes,
 			      const u64 del_bytes);
 void btrfs_assert_inode_range_clean(struct btrfs_inode *inode, u64 start, u64 end);
diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 6aade4838927..0a3c261b69c9 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -1298,11 +1298,11 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 		btrfs_inode_lock(BTRFS_I(inode), 0);
 		if (IS_SWAPFILE(inode)) {
 			ret = -ETXTBSY;
-			btrfs_inode_unlock(inode, 0);
+			btrfs_inode_unlock(BTRFS_I(inode), 0);
 			break;
 		}
 		if (!(inode->i_sb->s_flags & SB_ACTIVE)) {
-			btrfs_inode_unlock(inode, 0);
+			btrfs_inode_unlock(BTRFS_I(inode), 0);
 			break;
 		}
 		if (do_compress)
@@ -1315,7 +1315,7 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 		if (sectors_defragged > prev_sectors_defragged)
 			balance_dirty_pages_ratelimited(inode->i_mapping);
 
-		btrfs_inode_unlock(inode, 0);
+		btrfs_inode_unlock(BTRFS_I(inode), 0);
 		if (ret < 0)
 			break;
 		cur = max(cluster_end + 1, last_scanned);
@@ -1353,7 +1353,7 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 	if (do_compress) {
 		btrfs_inode_lock(BTRFS_I(inode), 0);
 		BTRFS_I(inode)->defrag_compress = BTRFS_COMPRESS_NONE;
-		btrfs_inode_unlock(inode, 0);
+		btrfs_inode_unlock(BTRFS_I(inode), 0);
 	}
 	return ret;
 }
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 4edf44d8cd9e..0095c6e4c3d1 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1646,7 +1646,7 @@ bool btrfs_readdir_get_delayed_items(struct inode *inode,
 	 * We can only do one readdir with delayed items at a time because of
 	 * item->readdir_list.
 	 */
-	btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
+	btrfs_inode_unlock(BTRFS_I(inode), BTRFS_ILOCK_SHARED);
 	btrfs_inode_lock(BTRFS_I(inode), 0);
 
 	mutex_lock(&delayed_node->mutex);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index d498984c7212..5de89c1c6789 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1423,7 +1423,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 		iocb->ki_pos += num_written;
 	}
 out:
-	btrfs_inode_unlock(inode, ilock_flags);
+	btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
 	return num_written ? num_written : ret;
 }
 
@@ -1469,13 +1469,13 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 
 	err = generic_write_checks(iocb, from);
 	if (err <= 0) {
-		btrfs_inode_unlock(inode, ilock_flags);
+		btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
 		return err;
 	}
 
 	err = btrfs_write_check(iocb, from, err);
 	if (err < 0) {
-		btrfs_inode_unlock(inode, ilock_flags);
+		btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
 		goto out;
 	}
 
@@ -1486,13 +1486,13 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	 */
 	if ((ilock_flags & BTRFS_ILOCK_SHARED) &&
 	    pos + iov_iter_count(from) > i_size_read(inode)) {
-		btrfs_inode_unlock(inode, ilock_flags);
+		btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
 		ilock_flags &= ~BTRFS_ILOCK_SHARED;
 		goto relock;
 	}
 
 	if (check_direct_IO(fs_info, from, pos)) {
-		btrfs_inode_unlock(inode, ilock_flags);
+		btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
 		goto buffered;
 	}
 
@@ -1523,7 +1523,7 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	 * iocb, and that needs to lock the inode. So unlock it before calling
 	 * iomap_dio_complete() to avoid a deadlock.
 	 */
-	btrfs_inode_unlock(inode, ilock_flags);
+	btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
 
 	if (IS_ERR_OR_NULL(dio))
 		err = PTR_ERR_OR_ZERO(dio);
@@ -1630,7 +1630,7 @@ static ssize_t btrfs_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 
 	ret = btrfs_do_encoded_write(iocb, from, encoded);
 out:
-	btrfs_inode_unlock(inode, 0);
+	btrfs_inode_unlock(BTRFS_I(inode), 0);
 	return ret;
 }
 
@@ -1825,7 +1825,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 */
 	ret = start_ordered_ops(inode, start, end);
 	if (ret) {
-		btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
+		btrfs_inode_unlock(BTRFS_I(inode), BTRFS_ILOCK_MMAP);
 		goto out;
 	}
 
@@ -1928,7 +1928,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 * file again, but that will end up using the synchronization
 	 * inside btrfs_sync_log to keep things safe.
 	 */
-	btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
+	btrfs_inode_unlock(BTRFS_I(inode), BTRFS_ILOCK_MMAP);
 
 	if (ret == BTRFS_NO_LOG_SYNC) {
 		ret = btrfs_end_transaction(trans);
@@ -1996,7 +1996,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 
 out_release_extents:
 	btrfs_release_log_ctx_extents(&ctx);
-	btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
+	btrfs_inode_unlock(BTRFS_I(inode), BTRFS_ILOCK_MMAP);
 	goto out;
 }
 
@@ -2639,7 +2639,7 @@ static int btrfs_punch_hole(struct file *file, loff_t offset, loff_t len)
 		truncated_block = true;
 		ret = btrfs_truncate_block(BTRFS_I(inode), offset, 0, 0);
 		if (ret) {
-			btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
+			btrfs_inode_unlock(BTRFS_I(inode), BTRFS_ILOCK_MMAP);
 			return ret;
 		}
 	}
@@ -2738,7 +2738,7 @@ static int btrfs_punch_hole(struct file *file, loff_t offset, loff_t len)
 				ret = ret2;
 		}
 	}
-	btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
+	btrfs_inode_unlock(BTRFS_I(inode), BTRFS_ILOCK_MMAP);
 	return ret;
 }
 
@@ -3099,7 +3099,7 @@ static long btrfs_fallocate(struct file *file, int mode,
 
 	if (mode & FALLOC_FL_ZERO_RANGE) {
 		ret = btrfs_zero_range(inode, offset, len, mode);
-		btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
+		btrfs_inode_unlock(BTRFS_I(inode), BTRFS_ILOCK_MMAP);
 		return ret;
 	}
 
@@ -3197,7 +3197,7 @@ static long btrfs_fallocate(struct file *file, int mode,
 	unlock_extent(&BTRFS_I(inode)->io_tree, alloc_start, locked_end,
 		      &cached_state);
 out:
-	btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
+	btrfs_inode_unlock(BTRFS_I(inode), BTRFS_ILOCK_MMAP);
 	extent_changeset_free(data_reserved);
 	return ret;
 }
@@ -3688,7 +3688,7 @@ static loff_t btrfs_file_llseek(struct file *file, loff_t offset, int whence)
 	case SEEK_HOLE:
 		btrfs_inode_lock(BTRFS_I(inode), BTRFS_ILOCK_SHARED);
 		offset = find_desired_extent(BTRFS_I(inode), offset, whence);
-		btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
+		btrfs_inode_unlock(BTRFS_I(inode), BTRFS_ILOCK_SHARED);
 		break;
 	}
 
@@ -3792,7 +3792,7 @@ static ssize_t btrfs_direct_read(struct kiocb *iocb, struct iov_iter *to)
 			goto again;
 		}
 	}
-	btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
+	btrfs_inode_unlock(BTRFS_I(inode), BTRFS_ILOCK_SHARED);
 	return ret < 0 ? ret : read;
 }
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 53cbe21f45b6..977def66afab 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -202,14 +202,14 @@ int btrfs_inode_lock(struct btrfs_inode *inode, unsigned int ilock_flags)
  * ilock_flags should contain the same bits set as passed to btrfs_inode_lock()
  * to decide whether the lock acquired is shared or exclusive.
  */
-void btrfs_inode_unlock(struct inode *inode, unsigned int ilock_flags)
+void btrfs_inode_unlock(struct btrfs_inode *inode, unsigned int ilock_flags)
 {
 	if (ilock_flags & BTRFS_ILOCK_MMAP)
-		up_write(&BTRFS_I(inode)->i_mmap_lock);
+		up_write(&inode->i_mmap_lock);
 	if (ilock_flags & BTRFS_ILOCK_SHARED)
-		inode_unlock_shared(inode);
+		inode_unlock_shared(&inode->vfs_inode);
 	else
-		inode_unlock(inode);
+		inode_unlock(&inode->vfs_inode);
 }
 
 /*
@@ -10276,7 +10276,7 @@ static ssize_t btrfs_encoded_read_inline(
 	read_extent_buffer(leaf, tmp, ptr, count);
 	btrfs_release_path(path);
 	unlock_extent(io_tree, start, lockend, cached_state);
-	btrfs_inode_unlock(&inode->vfs_inode, BTRFS_ILOCK_SHARED);
+	btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
 	*unlocked = true;
 
 	ret = copy_to_iter(tmp, count, iter);
@@ -10479,7 +10479,7 @@ static ssize_t btrfs_encoded_read_regular(struct kiocb *iocb,
 		goto out;
 
 	unlock_extent(io_tree, start, lockend, cached_state);
-	btrfs_inode_unlock(&inode->vfs_inode, BTRFS_ILOCK_SHARED);
+	btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
 	*unlocked = true;
 
 	if (compressed) {
@@ -10531,7 +10531,7 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 	btrfs_inode_lock(inode, BTRFS_ILOCK_SHARED);
 
 	if (iocb->ki_pos >= inode->vfs_inode.i_size) {
-		btrfs_inode_unlock(&inode->vfs_inode, BTRFS_ILOCK_SHARED);
+		btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
 		return 0;
 	}
 	start = ALIGN_DOWN(iocb->ki_pos, fs_info->sectorsize);
@@ -10629,7 +10629,7 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 
 	if (disk_bytenr == EXTENT_MAP_HOLE) {
 		unlock_extent(io_tree, start, lockend, &cached_state);
-		btrfs_inode_unlock(&inode->vfs_inode, BTRFS_ILOCK_SHARED);
+		btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
 		unlocked = true;
 		ret = iov_iter_zero(count, iter);
 		if (ret != count)
@@ -10652,7 +10652,7 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 		unlock_extent(io_tree, start, lockend, &cached_state);
 out_unlock_inode:
 	if (!unlocked)
-		btrfs_inode_unlock(&inode->vfs_inode, BTRFS_ILOCK_SHARED);
+		btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
 	return ret;
 }
 
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 20fd8a6c6fca..0873eae20f63 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1002,7 +1002,7 @@ static noinline int btrfs_mksubvol(const struct path *parent,
 out_dput:
 	dput(dentry);
 out_unlock:
-	btrfs_inode_unlock(dir, 0);
+	btrfs_inode_unlock(BTRFS_I(dir), 0);
 	return error;
 }
 
@@ -2527,14 +2527,14 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 
 	btrfs_inode_lock(BTRFS_I(inode), 0);
 	err = btrfs_delete_subvolume(dir, dentry);
-	btrfs_inode_unlock(inode, 0);
+	btrfs_inode_unlock(BTRFS_I(inode), 0);
 	if (!err)
 		d_delete_notify(dir, dentry);
 
 out_dput:
 	dput(dentry);
 out_unlock_dir:
-	btrfs_inode_unlock(dir, 0);
+	btrfs_inode_unlock(BTRFS_I(dir), 0);
 free_subvol_name:
 	kfree(subvol_name_ptr);
 free_parent:
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index c62c7fdd55d9..0474bbe39da7 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -911,7 +911,7 @@ loff_t btrfs_remap_file_range(struct file *src_file, loff_t off,
 
 out_unlock:
 	if (same_inode) {
-		btrfs_inode_unlock(src_inode, BTRFS_ILOCK_MMAP);
+		btrfs_inode_unlock(BTRFS_I(src_inode), BTRFS_ILOCK_MMAP);
 	} else {
 		btrfs_double_mmap_unlock(src_inode, dst_inode);
 		unlock_two_nondirectories(src_inode, dst_inode);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 773295d5da6d..1a337602723c 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2894,7 +2894,7 @@ static noinline_for_stack int prealloc_file_extent_cluster(
 		if (ret)
 			break;
 	}
-	btrfs_inode_unlock(&inode->vfs_inode, 0);
+	btrfs_inode_unlock(inode, 0);
 
 	if (cur_offset < prealloc_end)
 		btrfs_free_reserved_data_space_noquota(inode->root->fs_info,
-- 
2.37.3

