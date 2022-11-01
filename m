Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707746152DE
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 21:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiKAUMp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 16:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiKAUMi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 16:12:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631191CB09
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 13:12:37 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 21D3D1F38A;
        Tue,  1 Nov 2022 20:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667333556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GSJKRj5R18mGlohGCiQ+ntaPufKQhp0/obOFgBpuKTQ=;
        b=fI38ztICLXhD8l/HjNjNsLNBHhew0hRB1/gANffMf4GgSbD9fQzZgsfKzgGxu4egpyouBq
        CBNPzjUlhMmfuQQhEIXUcFNQYQcWCVw0ugBkw4tHuV9FfUDiIyWTm9g847DacfAfxRZN0e
        yINwYEQ41J4Ei4PV/72xx9jo0AzrHkI=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 1A7D72C141;
        Tue,  1 Nov 2022 20:12:36 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 62820DA79D; Tue,  1 Nov 2022 21:12:19 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 18/40] btrfs: pass btrfs_inode to btrfs_inode_lock
Date:   Tue,  1 Nov 2022 21:12:19 +0100
Message-Id: <bd1b61739aa0f918af34ac6418aab0e36bb56324.1667331828.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1667331828.git.dsterba@suse.com>
References: <cover.1667331828.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
 fs/btrfs/defrag.c        |  4 ++--
 fs/btrfs/delayed-inode.c |  2 +-
 fs/btrfs/file.c          | 16 ++++++++--------
 fs/btrfs/inode.c         | 14 +++++++-------
 fs/btrfs/ioctl.c         |  2 +-
 fs/btrfs/reflink.c       |  2 +-
 fs/btrfs/relocation.c    |  2 +-
 8 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 9fe1a11a2eb3..a06d1c0a0cc2 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -545,7 +545,7 @@ enum btrfs_ilock_type {
 	ENUM_BIT(BTRFS_ILOCK_MMAP),
 };
 
-int btrfs_inode_lock(struct inode *inode, unsigned int ilock_flags);
+int btrfs_inode_lock(struct btrfs_inode *inode, unsigned int ilock_flags);
 void btrfs_inode_unlock(struct inode *inode, unsigned int ilock_flags);
 void btrfs_update_inode_bytes(struct btrfs_inode *inode, const u64 add_bytes,
 			      const u64 del_bytes);
diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 919dfe0f7e50..6aade4838927 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -1295,7 +1295,7 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 			       (SZ_256K >> PAGE_SHIFT)) << PAGE_SHIFT) - 1;
 		cluster_end = min(cluster_end, last_byte);
 
-		btrfs_inode_lock(inode, 0);
+		btrfs_inode_lock(BTRFS_I(inode), 0);
 		if (IS_SWAPFILE(inode)) {
 			ret = -ETXTBSY;
 			btrfs_inode_unlock(inode, 0);
@@ -1351,7 +1351,7 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 		ret = sectors_defragged;
 	}
 	if (do_compress) {
-		btrfs_inode_lock(inode, 0);
+		btrfs_inode_lock(BTRFS_I(inode), 0);
 		BTRFS_I(inode)->defrag_compress = BTRFS_COMPRESS_NONE;
 		btrfs_inode_unlock(inode, 0);
 	}
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index c024f97de9e0..4edf44d8cd9e 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1647,7 +1647,7 @@ bool btrfs_readdir_get_delayed_items(struct inode *inode,
 	 * item->readdir_list.
 	 */
 	btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
-	btrfs_inode_lock(inode, 0);
+	btrfs_inode_lock(BTRFS_I(inode), 0);
 
 	mutex_lock(&delayed_node->mutex);
 	item = __btrfs_first_delayed_insertion_item(delayed_node);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index b7855f794ba6..d498984c7212 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1193,7 +1193,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 	if (nowait)
 		ilock_flags |= BTRFS_ILOCK_TRY;
 
-	ret = btrfs_inode_lock(inode, ilock_flags);
+	ret = btrfs_inode_lock(BTRFS_I(inode), ilock_flags);
 	if (ret < 0)
 		return ret;
 
@@ -1463,7 +1463,7 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 		ilock_flags |= BTRFS_ILOCK_SHARED;
 
 relock:
-	err = btrfs_inode_lock(inode, ilock_flags);
+	err = btrfs_inode_lock(BTRFS_I(inode), ilock_flags);
 	if (err < 0)
 		return err;
 
@@ -1611,7 +1611,7 @@ static ssize_t btrfs_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	loff_t count;
 	ssize_t ret;
 
-	btrfs_inode_lock(inode, 0);
+	btrfs_inode_lock(BTRFS_I(inode), 0);
 	count = encoded->len;
 	ret = generic_write_checks_count(iocb, &count);
 	if (ret == 0 && count != encoded->len) {
@@ -1801,7 +1801,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	if (ret)
 		goto out;
 
-	btrfs_inode_lock(inode, BTRFS_ILOCK_MMAP);
+	btrfs_inode_lock(BTRFS_I(inode), BTRFS_ILOCK_MMAP);
 
 	atomic_inc(&root->log_batch);
 
@@ -2591,7 +2591,7 @@ static int btrfs_punch_hole(struct file *file, loff_t offset, loff_t len)
 	bool truncated_block = false;
 	bool updated_inode = false;
 
-	btrfs_inode_lock(inode, BTRFS_ILOCK_MMAP);
+	btrfs_inode_lock(BTRFS_I(inode), BTRFS_ILOCK_MMAP);
 
 	ret = btrfs_wait_ordered_range(inode, offset, len);
 	if (ret)
@@ -3049,7 +3049,7 @@ static long btrfs_fallocate(struct file *file, int mode,
 	if (mode & FALLOC_FL_PUNCH_HOLE)
 		return btrfs_punch_hole(file, offset, len);
 
-	btrfs_inode_lock(inode, BTRFS_ILOCK_MMAP);
+	btrfs_inode_lock(BTRFS_I(inode), BTRFS_ILOCK_MMAP);
 
 	if (!(mode & FALLOC_FL_KEEP_SIZE) && offset + len > inode->i_size) {
 		ret = inode_newsize_ok(inode, offset + len);
@@ -3686,7 +3686,7 @@ static loff_t btrfs_file_llseek(struct file *file, loff_t offset, int whence)
 		return generic_file_llseek(file, offset, whence);
 	case SEEK_DATA:
 	case SEEK_HOLE:
-		btrfs_inode_lock(inode, BTRFS_ILOCK_SHARED);
+		btrfs_inode_lock(BTRFS_I(inode), BTRFS_ILOCK_SHARED);
 		offset = find_desired_extent(BTRFS_I(inode), offset, whence);
 		btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
 		break;
@@ -3743,7 +3743,7 @@ static ssize_t btrfs_direct_read(struct kiocb *iocb, struct iov_iter *to)
 	if (check_direct_read(btrfs_sb(inode->i_sb), to, iocb->ki_pos))
 		return 0;
 
-	btrfs_inode_lock(inode, BTRFS_ILOCK_SHARED);
+	btrfs_inode_lock(BTRFS_I(inode), BTRFS_ILOCK_SHARED);
 again:
 	/*
 	 * This is similar to what we do for direct IO writes, see the comment
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b5601d280ef9..53cbe21f45b6 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -172,27 +172,27 @@ static void __cold btrfs_print_data_csum_error(struct btrfs_inode *inode,
  *		     return -EAGAIN
  * BTRFS_ILOCK_MMAP - acquire a write lock on the i_mmap_lock
  */
-int btrfs_inode_lock(struct inode *inode, unsigned int ilock_flags)
+int btrfs_inode_lock(struct btrfs_inode *inode, unsigned int ilock_flags)
 {
 	if (ilock_flags & BTRFS_ILOCK_SHARED) {
 		if (ilock_flags & BTRFS_ILOCK_TRY) {
-			if (!inode_trylock_shared(inode))
+			if (!inode_trylock_shared(&inode->vfs_inode))
 				return -EAGAIN;
 			else
 				return 0;
 		}
-		inode_lock_shared(inode);
+		inode_lock_shared(&inode->vfs_inode);
 	} else {
 		if (ilock_flags & BTRFS_ILOCK_TRY) {
-			if (!inode_trylock(inode))
+			if (!inode_trylock(&inode->vfs_inode))
 				return -EAGAIN;
 			else
 				return 0;
 		}
-		inode_lock(inode);
+		inode_lock(&inode->vfs_inode);
 	}
 	if (ilock_flags & BTRFS_ILOCK_MMAP)
-		down_write(&BTRFS_I(inode)->i_mmap_lock);
+		down_write(&inode->i_mmap_lock);
 	return 0;
 }
 
@@ -10528,7 +10528,7 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 
 	file_accessed(iocb->ki_filp);
 
-	btrfs_inode_lock(&inode->vfs_inode, BTRFS_ILOCK_SHARED);
+	btrfs_inode_lock(inode, BTRFS_ILOCK_SHARED);
 
 	if (iocb->ki_pos >= inode->vfs_inode.i_size) {
 		btrfs_inode_unlock(&inode->vfs_inode, BTRFS_ILOCK_SHARED);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 9c1cb5113178..20fd8a6c6fca 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2525,7 +2525,7 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 		goto out_dput;
 	}
 
-	btrfs_inode_lock(inode, 0);
+	btrfs_inode_lock(BTRFS_I(inode), 0);
 	err = btrfs_delete_subvolume(dir, dentry);
 	btrfs_inode_unlock(inode, 0);
 	if (!err)
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 9d728107536e..c62c7fdd55d9 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -893,7 +893,7 @@ loff_t btrfs_remap_file_range(struct file *src_file, loff_t off,
 		return -EINVAL;
 
 	if (same_inode) {
-		btrfs_inode_lock(src_inode, BTRFS_ILOCK_MMAP);
+		btrfs_inode_lock(BTRFS_I(src_inode), BTRFS_ILOCK_MMAP);
 	} else {
 		lock_two_nondirectories(src_inode, dst_inode);
 		btrfs_double_mmap_lock(src_inode, dst_inode);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index d119986d1599..773295d5da6d 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2874,7 +2874,7 @@ static noinline_for_stack int prealloc_file_extent_cluster(
 	if (ret)
 		return ret;
 
-	btrfs_inode_lock(&inode->vfs_inode, 0);
+	btrfs_inode_lock(inode, 0);
 	for (nr = 0; nr < cluster->nr; nr++) {
 		struct extent_state *cached_state = NULL;
 
-- 
2.37.3

