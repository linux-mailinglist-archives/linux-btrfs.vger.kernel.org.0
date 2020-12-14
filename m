Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCFD2D9ED5
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Dec 2020 19:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440746AbgLNSUk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Dec 2020 13:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440721AbgLNSU2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Dec 2020 13:20:28 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DF6C061793
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Dec 2020 10:19:48 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id i67so8968426qkf.11
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Dec 2020 10:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=X5143zDzE8AvLarE6SdUPx/9IUh1GYaqX7I2YiVbxbo=;
        b=hwkvuzpHephdRTm+cW+M7jGc8n0D16+blhWpT1o/Q0HkBq3nxMlFOa5A2U8pIBB2o6
         ZvRMaxmmTBkynsnMx6EqKjH6cLm33tu12HPGGUkyJ7Hl6NMnfAn/2T2Fan6flFZDZLVb
         VfdNXE8xJw78S3cfewOSmQjifcivvIGWadJ1KmFfAWdMXiND1B2LJCkrhxF3Xil1Fng8
         KFDwtaT+y81exRy3rCddgWAUZA4NZO55wb/JOUHH48aplx1N5iDMFI1ZRlLWPAszFEFC
         IpZq8/roVJvMQ9cN0vxfsl6E+ARFzKM3dsK3CRJszkP9jBGfcMRO1H7Js6yZGP+/vpw+
         zBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X5143zDzE8AvLarE6SdUPx/9IUh1GYaqX7I2YiVbxbo=;
        b=EQ1Q45M28BJqJnL6srteZ82HyQSZnpKgVNy40tTJp7y+gr+pIfztewT26fGE7hsQ8v
         Re3WhAbldDmM8QxN+Lpc6Fuarg9GdN3YCifIyEqGOH6aYrucXuuuxqNhnw2Yh8Up1x67
         W74FEqI+dYz+SulVdWKk6y9OP7qOdRudnn3f0E2VTzFd0vaEOXvMk1JUrBAgvqqudj4T
         dm4dlmphb4EwEygmuswIFmPDtz+0kt+ZHGoZnJSUfsoJwGuNQOt+ohIWIB+s8CgTwL6p
         XTW/Biv2XZXOi6zMlvm5qtGHnvpGtbwZ780pHkgm+6hqpZsYOJ96R+FLqGj8G9WWlziZ
         nZjg==
X-Gm-Message-State: AOAM533pW6BaBQ6zswa1B2mVLY9zAzA+zl9PRyY1f7Ms5tyED09UiJ1P
        MJd7cDjVmMq9CmHnMRffBT7eTLzN+E4XAAim
X-Google-Smtp-Source: ABdhPJyGhBcTJ2a+uQijXZCge8ETHZaVDnJQvH3F6nA1kYopLDa/9gXmXGnZ8Z2YL27SSbEFSH7Ixg==
X-Received: by 2002:a37:a085:: with SMTP id j127mr33016368qke.273.1607969987288;
        Mon, 14 Dec 2020 10:19:47 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k32sm14800729qte.59.2020.12.14.10.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 10:19:46 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/4] btrfs: cleanup inode_lock/inode_unlock uses
Date:   Mon, 14 Dec 2020 13:19:39 -0500
Message-Id: <11f7daa4cdb14f05e53b6ba49cb837307e770f66.1607969636.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607969636.git.josef@toxicpanda.com>
References: <cover.1607969636.git.josef@toxicpanda.com>
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

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/delayed-inode.c |  4 ++--
 fs/btrfs/file.c          | 18 +++++++++---------
 fs/btrfs/ioctl.c         | 26 +++++++++++++-------------
 fs/btrfs/reflink.c       |  4 ++--
 fs/btrfs/relocation.c    |  4 ++--
 5 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 70c0340d839c..7532229e7efb 100644
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
index 0e41459b8de6..ed633ae87e06 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2131,7 +2131,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	if (ret)
 		goto out;
 
-	inode_lock(inode);
+	btrfs_inode_lock(inode, 0);
 
 	atomic_inc(&root->log_batch);
 
@@ -2163,7 +2163,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 */
 	ret = start_ordered_ops(inode, start, end);
 	if (ret) {
-		inode_unlock(inode);
+		btrfs_inode_unlock(inode, 0);
 		goto out;
 	}
 
@@ -2259,7 +2259,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 * file again, but that will end up using the synchronization
 	 * inside btrfs_sync_log to keep things safe.
 	 */
-	inode_unlock(inode);
+	btrfs_inode_unlock(inode, 0);
 
 	if (ret != BTRFS_NO_LOG_SYNC) {
 		if (!ret) {
@@ -2289,7 +2289,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 
 out_release_extents:
 	btrfs_release_log_ctx_extents(&ctx);
-	inode_unlock(inode);
+	btrfs_inode_unlock(inode, 0);
 	goto out;
 }
 
@@ -2872,7 +2872,7 @@ static int btrfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 	if (ret)
 		return ret;
 
-	inode_lock(inode);
+	btrfs_inode_lock(inode, 0);
 	ino_size = round_up(inode->i_size, fs_info->sectorsize);
 	ret = find_first_non_hole(BTRFS_I(inode), &offset, &len);
 	if (ret < 0)
@@ -2912,7 +2912,7 @@ static int btrfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 		truncated_block = true;
 		ret = btrfs_truncate_block(BTRFS_I(inode), offset, 0, 0);
 		if (ret) {
-			inode_unlock(inode);
+			btrfs_inode_unlock(inode, 0);
 			return ret;
 		}
 	}
@@ -3013,7 +3013,7 @@ static int btrfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 				ret = ret2;
 		}
 	}
-	inode_unlock(inode);
+	btrfs_inode_unlock(inode, 0);
 	return ret;
 }
 
@@ -3378,7 +3378,7 @@ static long btrfs_fallocate(struct file *file, int mode,
 
 	if (mode & FALLOC_FL_ZERO_RANGE) {
 		ret = btrfs_zero_range(inode, offset, len, mode);
-		inode_unlock(inode);
+		btrfs_inode_unlock(inode, 0);
 		return ret;
 	}
 
@@ -3488,7 +3488,7 @@ static long btrfs_fallocate(struct file *file, int mode,
 	unlock_extent_cached(&BTRFS_I(inode)->io_tree, alloc_start, locked_end,
 			     &cached_state);
 out:
-	inode_unlock(inode);
+	btrfs_inode_unlock(inode, 0);
 	/* Let go of our reservation. */
 	if (ret != 0 && !(mode & FALLOC_FL_ZERO_RANGE))
 		btrfs_free_reserved_data_space(BTRFS_I(inode), data_reserved,
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index dde49a791f3e..becb5d9ae3ce 100644
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
@@ -1010,7 +1010,7 @@ static noinline int btrfs_mksubvol(const struct path *parent,
 out_dput:
 	dput(dentry);
 out_unlock:
-	inode_unlock(dir);
+	btrfs_inode_unlock(dir, 0);
 	return error;
 }
 
@@ -1602,7 +1602,7 @@ int btrfs_defrag_file(struct inode *inode, struct file *file,
 			ra_index += cluster;
 		}
 
-		inode_lock(inode);
+		btrfs_inode_lock(inode, 0);
 		if (IS_SWAPFILE(inode)) {
 			ret = -ETXTBSY;
 		} else {
@@ -1611,13 +1611,13 @@ int btrfs_defrag_file(struct inode *inode, struct file *file,
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
@@ -1665,9 +1665,9 @@ int btrfs_defrag_file(struct inode *inode, struct file *file,
 
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
@@ -3083,9 +3083,9 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
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
@@ -3094,7 +3094,7 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 out_dput:
 	dput(dentry);
 out_unlock_dir:
-	inode_unlock(dir);
+	btrfs_inode_unlock(dir, 0);
 free_subvol_name:
 	kfree(subvol_name_ptr);
 free_parent:
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index b03e7891394e..97f58b15eba2 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -816,7 +816,7 @@ loff_t btrfs_remap_file_range(struct file *src_file, loff_t off,
 		return -EINVAL;
 
 	if (same_inode)
-		inode_lock(src_inode);
+		btrfs_inode_lock(src_inode, 0);
 	else
 		lock_two_nondirectories(src_inode, dst_inode);
 
@@ -832,7 +832,7 @@ loff_t btrfs_remap_file_range(struct file *src_file, loff_t off,
 
 out_unlock:
 	if (same_inode)
-		inode_unlock(src_inode);
+		btrfs_inode_unlock(src_inode, 0);
 	else
 		unlock_two_nondirectories(src_inode, dst_inode);
 
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 19b7db8b2117..3fa4f7ba8da3 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2553,7 +2553,7 @@ static noinline_for_stack int prealloc_file_extent_cluster(
 	if (ret)
 		return ret;
 
-	inode_lock(&inode->vfs_inode);
+	btrfs_inode_lock(&inode->vfs_inode, 0);
 	for (nr = 0; nr < cluster->nr; nr++) {
 		start = cluster->boundary[nr] - offset;
 		if (nr + 1 < cluster->nr)
@@ -2571,7 +2571,7 @@ static noinline_for_stack int prealloc_file_extent_cluster(
 		if (ret)
 			break;
 	}
-	inode_unlock(&inode->vfs_inode);
+	btrfs_inode_unlock(&inode->vfs_inode, 0);
 
 	if (cur_offset < prealloc_end)
 		btrfs_free_reserved_data_space_noquota(inode->root->fs_info,
-- 
2.26.2

