Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A2B317317
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Feb 2021 23:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbhBJWP2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Feb 2021 17:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbhBJWPY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Feb 2021 17:15:24 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B692FC061786
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Feb 2021 14:14:43 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id h8so3386021qkk.6
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Feb 2021 14:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UUKqMOoaVU6i360/ikILJBalJxPMx24J0kCBLuD9Ymk=;
        b=aaWWEvrCKOSw0DRZVrO2RZt/WvMwqWuvpaeg3/XVQJ7FRAkiKaRPgN5N3wQ17ePRaa
         AQyXJ6rZ4ONoM7QsNy23/YEB2iAt8FAf97IH8TNtEhrOsGfuqOCc5R7OMae4lrHfT8Uy
         Z6jVEsslSeZpoEiYbdSBll9RPVSRvrJ3OHWntGjAKhzELbw6RKnoVw96Hzkg83G6LAEX
         0mk/o+EUqAEbF0054I4JTxHV655wlqQ6JUGxIm84Vk33DIVlajxDi8txC/vqfFkEJUUJ
         X8d04k5Uq+GS6LFX0lUMjgWC6NQ7ZPM1t0NfsRVY4+Tiv13UyKjxD6kdF1f/6xacH9Cu
         T4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UUKqMOoaVU6i360/ikILJBalJxPMx24J0kCBLuD9Ymk=;
        b=mYRej6PzslLeuyRFHPa0l8VgvJnWjbX5XpUwQwr/v1UhmtlSyH9pFLUVdAPxFigXtr
         tXxP1x9M2bC64Q0o7PYUmEdSiXDzPDtYwk8hIkPyXdF+bAgStzV7k8CpKD7UGwpJGTZc
         rwPf5Dd6WbnjBWhdglR1OmzmZ1F0Ts+5/XMsrc9LUr3Gu8ocmaAqXSFAdVci0wrU+AeV
         fLtR0fbCW1FlMn0R5Wd+2uVC+lCsp6XBezIuKDoG4Egoq7sL/br9J7YwP1cW3GwmkjQs
         9XOXsth2g10wF7V/qCFOvL6IkouA9p/HQAf9K3KpMR/j9EWIb38Y/l0vgc0SUW8i9nGY
         S/8w==
X-Gm-Message-State: AOAM532cYO1lx8gNsoMQ4IGanBY6uBnRf0G67SK9BSua6SO+6jHgmtGz
        BWUIO7YmKDe+rcpp0gkKJfxfgQwlm9pUZRsF
X-Google-Smtp-Source: ABdhPJyffQZux4vA1bQGFsQeM9bvwTw0jybt5F4YY858EX9FO1A+ukKtN0tH69H4zNcMtPnGgpLG4w==
X-Received: by 2002:a37:b96:: with SMTP id 144mr5902390qkl.314.1612995282545;
        Wed, 10 Feb 2021 14:14:42 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l137sm2539326qke.6.2021.02.10.14.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 14:14:41 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2 2/4] btrfs: cleanup inode_lock/inode_unlock uses
Date:   Wed, 10 Feb 2021 17:14:34 -0500
Message-Id: <89a4671fb7927a5485cf52a95822bebfe64302cc.1612995212.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1612995212.git.josef@toxicpanda.com>
References: <cover.1612995212.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A few places we intermix btrfs_inode_lock with a inode_unlock, and some
places we just use inode_lock/inode_unlock instead of btrfs_inode_lock.
None of these places are using this incorrectly, but as we adjust some
of these callers it would be nice to keep everything consistent, so
convert everybody to use btrfs_inode_lock/btrfs_inode_unlock.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/delayed-inode.c |  4 ++--
 fs/btrfs/file.c          | 18 +++++++++---------
 fs/btrfs/ioctl.c         | 26 +++++++++++++-------------
 fs/btrfs/reflink.c       |  4 ++--
 fs/btrfs/relocation.c    |  4 ++--
 5 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index ec0b50b8c5d6..ec6c277f1f91 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1588,8 +1588,8 @@ bool btrfs_readdir_get_delayed_items(struct inode *inode,
 	 * We can only do one readdir with delayed items at a time because of
 	 * item->readdir_list.
 	 */
-	inode_unlock_shared(inode);
-	inode_lock(inode);
+	btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
+	btrfs_inode_lock(inode, 0);
 
 	mutex_lock(&delayed_node->mutex);
 	item = __btrfs_first_delayed_insertion_item(delayed_node);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 01a72f53fb5d..728736e3d4b8 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2122,7 +2122,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	if (ret)
 		goto out;
 
-	inode_lock(inode);
+	btrfs_inode_lock(inode, 0);
 
 	atomic_inc(&root->log_batch);
 
@@ -2154,7 +2154,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 */
 	ret = start_ordered_ops(inode, start, end);
 	if (ret) {
-		inode_unlock(inode);
+		btrfs_inode_unlock(inode, 0);
 		goto out;
 	}
 
@@ -2255,7 +2255,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 * file again, but that will end up using the synchronization
 	 * inside btrfs_sync_log to keep things safe.
 	 */
-	inode_unlock(inode);
+	btrfs_inode_unlock(inode, 0);
 
 	if (ret != BTRFS_NO_LOG_SYNC) {
 		if (!ret) {
@@ -2285,7 +2285,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 
 out_release_extents:
 	btrfs_release_log_ctx_extents(&ctx);
-	inode_unlock(inode);
+	btrfs_inode_unlock(inode, 0);
 	goto out;
 }
 
@@ -2868,7 +2868,7 @@ static int btrfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 	if (ret)
 		return ret;
 
-	inode_lock(inode);
+	btrfs_inode_lock(inode, 0);
 	ino_size = round_up(inode->i_size, fs_info->sectorsize);
 	ret = find_first_non_hole(BTRFS_I(inode), &offset, &len);
 	if (ret < 0)
@@ -2908,7 +2908,7 @@ static int btrfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 		truncated_block = true;
 		ret = btrfs_truncate_block(BTRFS_I(inode), offset, 0, 0);
 		if (ret) {
-			inode_unlock(inode);
+			btrfs_inode_unlock(inode, 0);
 			return ret;
 		}
 	}
@@ -3009,7 +3009,7 @@ static int btrfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 				ret = ret2;
 		}
 	}
-	inode_unlock(inode);
+	btrfs_inode_unlock(inode, 0);
 	return ret;
 }
 
@@ -3374,7 +3374,7 @@ static long btrfs_fallocate(struct file *file, int mode,
 
 	if (mode & FALLOC_FL_ZERO_RANGE) {
 		ret = btrfs_zero_range(inode, offset, len, mode);
-		inode_unlock(inode);
+		btrfs_inode_unlock(inode, 0);
 		return ret;
 	}
 
@@ -3484,7 +3484,7 @@ static long btrfs_fallocate(struct file *file, int mode,
 	unlock_extent_cached(&BTRFS_I(inode)->io_tree, alloc_start, locked_end,
 			     &cached_state);
 out:
-	inode_unlock(inode);
+	btrfs_inode_unlock(inode, 0);
 	/* Let go of our reservation. */
 	if (ret != 0 && !(mode & FALLOC_FL_ZERO_RANGE))
 		btrfs_free_reserved_data_space(BTRFS_I(inode), data_reserved,
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a8c60d46d19c..c9f2bc0602d6 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -226,7 +226,7 @@ static int btrfs_ioctl_setflags(struct file *file, void __user *arg)
 	if (ret)
 		return ret;
 
-	inode_lock(inode);
+	btrfs_inode_lock(inode, 0);
 	fsflags = btrfs_mask_fsflags_for_type(inode, fsflags);
 	old_fsflags = btrfs_inode_flags_to_fsflags(binode->flags);
 
@@ -353,7 +353,7 @@ static int btrfs_ioctl_setflags(struct file *file, void __user *arg)
  out_end_trans:
 	btrfs_end_transaction(trans);
  out_unlock:
-	inode_unlock(inode);
+	btrfs_inode_unlock(inode, 0);
 	mnt_drop_write_file(file);
 	return ret;
 }
@@ -449,7 +449,7 @@ static int btrfs_ioctl_fssetxattr(struct file *file, void __user *arg)
 	if (ret)
 		return ret;
 
-	inode_lock(inode);
+	btrfs_inode_lock(inode, 0);
 
 	old_flags = binode->flags;
 	old_i_flags = inode->i_flags;
@@ -501,7 +501,7 @@ static int btrfs_ioctl_fssetxattr(struct file *file, void __user *arg)
 		inode->i_flags = old_i_flags;
 	}
 
-	inode_unlock(inode);
+	btrfs_inode_unlock(inode, 0);
 	mnt_drop_write_file(file);
 
 	return ret;
@@ -1013,7 +1013,7 @@ static noinline int btrfs_mksubvol(const struct path *parent,
 out_dput:
 	dput(dentry);
 out_unlock:
-	inode_unlock(dir);
+	btrfs_inode_unlock(dir, 0);
 	return error;
 }
 
@@ -1611,7 +1611,7 @@ int btrfs_defrag_file(struct inode *inode, struct file *file,
 			ra_index += cluster;
 		}
 
-		inode_lock(inode);
+		btrfs_inode_lock(inode, 0);
 		if (IS_SWAPFILE(inode)) {
 			ret = -ETXTBSY;
 		} else {
@@ -1620,13 +1620,13 @@ int btrfs_defrag_file(struct inode *inode, struct file *file,
 			ret = cluster_pages_for_defrag(inode, pages, i, cluster);
 		}
 		if (ret < 0) {
-			inode_unlock(inode);
+			btrfs_inode_unlock(inode, 0);
 			goto out_ra;
 		}
 
 		defrag_count += ret;
 		balance_dirty_pages_ratelimited(inode->i_mapping);
-		inode_unlock(inode);
+		btrfs_inode_unlock(inode, 0);
 
 		if (newer_than) {
 			if (newer_off == (u64)-1)
@@ -1674,9 +1674,9 @@ int btrfs_defrag_file(struct inode *inode, struct file *file,
 
 out_ra:
 	if (do_compress) {
-		inode_lock(inode);
+		btrfs_inode_lock(inode, 0);
 		BTRFS_I(inode)->defrag_compress = BTRFS_COMPRESS_NONE;
-		inode_unlock(inode);
+		btrfs_inode_unlock(inode, 0);
 	}
 	if (!file)
 		kfree(ra);
@@ -3092,9 +3092,9 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 		goto out_dput;
 	}
 
-	inode_lock(inode);
+	btrfs_inode_lock(inode, 0);
 	err = btrfs_delete_subvolume(dir, dentry);
-	inode_unlock(inode);
+	btrfs_inode_unlock(inode, 0);
 	if (!err) {
 		fsnotify_rmdir(dir, dentry);
 		d_delete(dentry);
@@ -3103,7 +3103,7 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 out_dput:
 	dput(dentry);
 out_unlock_dir:
-	inode_unlock(dir);
+	btrfs_inode_unlock(dir, 0);
 free_subvol_name:
 	kfree(subvol_name_ptr);
 free_parent:
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index b24396cf2f99..12df3ee84e93 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -819,7 +819,7 @@ loff_t btrfs_remap_file_range(struct file *src_file, loff_t off,
 		return -EINVAL;
 
 	if (same_inode)
-		inode_lock(src_inode);
+		btrfs_inode_lock(src_inode, 0);
 	else
 		lock_two_nondirectories(src_inode, dst_inode);
 
@@ -835,7 +835,7 @@ loff_t btrfs_remap_file_range(struct file *src_file, loff_t off,
 
 out_unlock:
 	if (same_inode)
-		inode_unlock(src_inode);
+		btrfs_inode_unlock(src_inode, 0);
 	else
 		unlock_two_nondirectories(src_inode, dst_inode);
 
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 232d5da7b7be..bf269ee17e68 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2578,7 +2578,7 @@ static noinline_for_stack int prealloc_file_extent_cluster(
 		return btrfs_end_transaction(trans);
 	}
 
-	inode_lock(&inode->vfs_inode);
+	btrfs_inode_lock(&inode->vfs_inode, 0);
 	for (nr = 0; nr < cluster->nr; nr++) {
 		start = cluster->boundary[nr] - offset;
 		if (nr + 1 < cluster->nr)
@@ -2596,7 +2596,7 @@ static noinline_for_stack int prealloc_file_extent_cluster(
 		if (ret)
 			break;
 	}
-	inode_unlock(&inode->vfs_inode);
+	btrfs_inode_unlock(&inode->vfs_inode, 0);
 
 	if (cur_offset < prealloc_end)
 		btrfs_free_reserved_data_space_noquota(inode->root->fs_info,
-- 
2.26.2

