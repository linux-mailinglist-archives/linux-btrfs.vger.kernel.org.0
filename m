Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13CFD2A2D49
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Nov 2020 15:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgKBOtK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Nov 2020 09:49:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:39744 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbgKBOtJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Nov 2020 09:49:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604328548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rvbTYsy4YRwNVV6aIbVWRJpKZXTuUqqgm7O8PBwwsbo=;
        b=KqynQYb6FFt0ioMfpboxdDDj0k0qrY6eBbemYaJx6SHi6E4LV3WXJ1xio+HCY+MwckToo7
        6wq28pzX7A2F0wipfDugrIDD2KYfmV6I6wYNFmaKyTjmyYKRHlEt+eSUakexrkA1yDG9UO
        cixagEM9aKO7l5wbHv2TLppgyipePVQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 661B2B232;
        Mon,  2 Nov 2020 14:49:08 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 01/14] btrfs: Make btrfs_inode_safe_disk_i_size_write take btrfs_inode
Date:   Mon,  2 Nov 2020 16:48:53 +0200
Message-Id: <20201102144906.3767963-2-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102144906.3767963-1-nborisov@suse.com>
References: <20201102144906.3767963-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ctree.h     |  3 ++-
 fs/btrfs/file-item.c | 18 +++++++++---------
 fs/btrfs/file.c      |  2 +-
 fs/btrfs/inode.c     | 12 ++++++------
 fs/btrfs/reflink.c   |  2 +-
 5 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 8a83bce3225c..c0108a4730d1 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2967,7 +2967,8 @@ int btrfs_inode_clear_file_extent_range(struct btrfs_inode *inode, u64 start,
 					u64 len);
 int btrfs_inode_set_file_extent_range(struct btrfs_inode *inode, u64 start,
 				      u64 len);
-void btrfs_inode_safe_disk_i_size_write(struct inode *inode, u64 new_i_size);
+void btrfs_inode_safe_disk_i_size_write(struct btrfs_inode *inode,
+					u64 new_i_size);
 u64 btrfs_file_extent_end(const struct btrfs_path *path);
 
 /* inode.c */
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 816f57d52fc9..17c2695d083c 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -38,27 +38,27 @@
  * Finally new_i_size should only be set in the case of truncate where we're not
  * ready to use i_size_read() as the limiter yet.
  */
-void btrfs_inode_safe_disk_i_size_write(struct inode *inode, u64 new_i_size)
+void btrfs_inode_safe_disk_i_size_write(struct btrfs_inode *inode, u64 new_i_size)
 {
-	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	u64 start, end, i_size;
 	int ret;
 
-	i_size = new_i_size ?: i_size_read(inode);
+	i_size = new_i_size ?: i_size_read(&inode->vfs_inode);
 	if (btrfs_fs_incompat(fs_info, NO_HOLES)) {
-		BTRFS_I(inode)->disk_i_size = i_size;
+		inode->disk_i_size = i_size;
 		return;
 	}
 
-	spin_lock(&BTRFS_I(inode)->lock);
-	ret = find_contiguous_extent_bit(&BTRFS_I(inode)->file_extent_tree, 0,
-					 &start, &end, EXTENT_DIRTY);
+	spin_lock(&inode->lock);
+	ret = find_contiguous_extent_bit(&inode->file_extent_tree, 0, &start,
+					 &end, EXTENT_DIRTY);
 	if (!ret && start == 0)
 		i_size = min(i_size, end + 1);
 	else
 		i_size = 0;
-	BTRFS_I(inode)->disk_i_size = i_size;
-	spin_unlock(&BTRFS_I(inode)->lock);
+	inode->disk_i_size = i_size;
+	spin_unlock(&inode->lock);
 }
 
 /**
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 1c97e559aefb..4b44ad980a5d 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3090,7 +3090,7 @@ static int btrfs_fallocate_update_isize(struct inode *inode,
 
 	inode->i_ctime = current_time(inode);
 	i_size_write(inode, end);
-	btrfs_inode_safe_disk_i_size_write(inode, 0);
+	btrfs_inode_safe_disk_i_size_write(BTRFS_I(inode), 0);
 	ret = btrfs_update_inode(trans, root, inode);
 	ret2 = btrfs_end_transaction(trans);
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index bfb719c3836c..aa8c3a73bf1b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2606,7 +2606,7 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 	if (test_bit(BTRFS_ORDERED_NOCOW, &ordered_extent->flags)) {
 		BUG_ON(!list_empty(&ordered_extent->list)); /* Logic error */
 
-		btrfs_inode_safe_disk_i_size_write(inode, 0);
+		btrfs_inode_safe_disk_i_size_write(BTRFS_I(inode), 0);
 		if (freespace_inode)
 			trans = btrfs_join_transaction_spacecache(root);
 		else
@@ -2670,7 +2670,7 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 		goto out;
 	}
 
-	btrfs_inode_safe_disk_i_size_write(inode, 0);
+	btrfs_inode_safe_disk_i_size_write(BTRFS_I(inode), 0);
 	ret = btrfs_update_inode_fallback(trans, root, inode);
 	if (ret) { /* -ENOMEM or corruption */
 		btrfs_abort_transaction(trans, ret);
@@ -4464,7 +4464,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 		ASSERT(last_size >= new_size);
 		if (!ret && last_size > new_size)
 			last_size = new_size;
-		btrfs_inode_safe_disk_i_size_write(inode, last_size);
+		btrfs_inode_safe_disk_i_size_write(BTRFS_I(inode), last_size);
 		unlock_extent_cached(&BTRFS_I(inode)->io_tree, lock_start,
 				     (u64)-1, &cached_state);
 	}
@@ -4820,7 +4820,7 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
 		}
 
 		i_size_write(inode, newsize);
-		btrfs_inode_safe_disk_i_size_write(inode, 0);
+		btrfs_inode_safe_disk_i_size_write(BTRFS_I(inode), 0);
 		pagecache_isize_extended(inode, oldsize, newsize);
 		ret = btrfs_update_inode(trans, root, inode);
 		btrfs_drew_write_unlock(&root->snapshot_lock);
@@ -8502,7 +8502,7 @@ static int btrfs_truncate(struct inode *inode, bool skip_writeback)
 			ret = PTR_ERR(trans);
 			goto out;
 		}
-		btrfs_inode_safe_disk_i_size_write(inode, 0);
+		btrfs_inode_safe_disk_i_size_write(BTRFS_I(inode), 0);
 	}
 
 	if (trans) {
@@ -9731,7 +9731,7 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 			else
 				i_size = cur_offset;
 			i_size_write(inode, i_size);
-			btrfs_inode_safe_disk_i_size_write(inode, 0);
+			btrfs_inode_safe_disk_i_size_write(BTRFS_I(inode), 0);
 		}
 
 		ret = btrfs_update_inode(trans, root, inode);
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 99aa87c08912..e624f4cd0585 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -31,7 +31,7 @@ static int clone_finish_inode_update(struct btrfs_trans_handle *trans,
 		endoff = destoff + olen;
 	if (endoff > inode->i_size) {
 		i_size_write(inode, endoff);
-		btrfs_inode_safe_disk_i_size_write(inode, 0);
+		btrfs_inode_safe_disk_i_size_write(BTRFS_I(inode), 0);
 	}
 
 	ret = btrfs_update_inode(trans, root, inode);
-- 
2.25.1

