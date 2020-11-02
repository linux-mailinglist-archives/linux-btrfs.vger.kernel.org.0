Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821022A2D4A
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Nov 2020 15:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgKBOtL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Nov 2020 09:49:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:39780 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbgKBOtK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Nov 2020 09:49:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604328549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B0J4InTqcfU7bXdrCizp/gXq2YJSzZyhDa0NjekKOkI=;
        b=MgxGbCUMpHq3BSDe9kHpU/hDtJbPdvZjIhWkhKD7ma3VUOrZo4nBLqc5Yph1OxreARSkWk
        2IrsATyX6DzsHKkxaO6ESrQwtzkEGKRawGttNKLCyfKDqz8fm3KS13ZeLLpb3NUNwSChdK
        muMczfHDhsRC2oIiQAVvjh/nhNFBu6w=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 39393B905;
        Mon,  2 Nov 2020 14:49:09 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 04/14] btrfs: Make btrfs_finish_ordered_io btrfs_inode-centric
Date:   Mon,  2 Nov 2020 16:48:56 +0200
Message-Id: <20201102144906.3767963-5-nborisov@suse.com>
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
 fs/btrfs/inode.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4ec4e59ddb47..5bcac6f27cf9 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2561,11 +2561,11 @@ static int insert_ordered_extent_file_extent(struct btrfs_trans_handle *trans,
  */
 static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 {
-	struct inode *inode = ordered_extent->inode;
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct btrfs_root *root = BTRFS_I(inode)->root;
+	struct btrfs_inode *inode = BTRFS_I(ordered_extent->inode);
+	struct btrfs_root *root = inode->root;
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_trans_handle *trans = NULL;
-	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
+	struct extent_io_tree *io_tree = &inode->io_tree;
 	struct extent_state *cached_state = NULL;
 	u64 start, end;
 	int compress_type = 0;
@@ -2586,14 +2586,14 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 	    !test_bit(BTRFS_ORDERED_DIRECT, &ordered_extent->flags))
 		clear_new_delalloc_bytes = true;
 
-	freespace_inode = btrfs_is_free_space_inode(BTRFS_I(inode));
+	freespace_inode = btrfs_is_free_space_inode(inode);
 
 	if (test_bit(BTRFS_ORDERED_IOERR, &ordered_extent->flags)) {
 		ret = -EIO;
 		goto out;
 	}
 
-	btrfs_free_io_failure_record(BTRFS_I(inode), start, end);
+	btrfs_free_io_failure_record(inode, start, end);
 
 	if (test_bit(BTRFS_ORDERED_TRUNCATED, &ordered_extent->flags)) {
 		truncated = true;
@@ -2606,7 +2606,7 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 	if (test_bit(BTRFS_ORDERED_NOCOW, &ordered_extent->flags)) {
 		BUG_ON(!list_empty(&ordered_extent->list)); /* Logic error */
 
-		btrfs_inode_safe_disk_i_size_write(BTRFS_I(inode), 0);
+		btrfs_inode_safe_disk_i_size_write(inode, 0);
 		if (freespace_inode)
 			trans = btrfs_join_transaction_spacecache(root);
 		else
@@ -2616,8 +2616,8 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 			trans = NULL;
 			goto out;
 		}
-		trans->block_rsv = &BTRFS_I(inode)->block_rsv;
-		ret = btrfs_update_inode_fallback(trans, root, inode);
+		trans->block_rsv = &inode->block_rsv;
+		ret = btrfs_update_inode_fallback(trans, root, &inode->vfs_inode);
 		if (ret) /* -ENOMEM or corruption */
 			btrfs_abort_transaction(trans, ret);
 		goto out;
@@ -2636,13 +2636,13 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 		goto out;
 	}
 
-	trans->block_rsv = &BTRFS_I(inode)->block_rsv;
+	trans->block_rsv = &inode->block_rsv;
 
 	if (test_bit(BTRFS_ORDERED_COMPRESSED, &ordered_extent->flags))
 		compress_type = ordered_extent->compress_type;
 	if (test_bit(BTRFS_ORDERED_PREALLOC, &ordered_extent->flags)) {
 		BUG_ON(compress_type);
-		ret = btrfs_mark_extent_written(trans, BTRFS_I(inode),
+		ret = btrfs_mark_extent_written(trans, inode,
 						ordered_extent->file_offset,
 						ordered_extent->file_offset +
 						logical_len);
@@ -2656,8 +2656,7 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 						ordered_extent->disk_num_bytes);
 		}
 	}
-	unpin_extent_cache(&BTRFS_I(inode)->extent_tree,
-			   ordered_extent->file_offset,
+	unpin_extent_cache(&inode->extent_tree, ordered_extent->file_offset,
 			   ordered_extent->num_bytes, trans->transid);
 	if (ret < 0) {
 		btrfs_abort_transaction(trans, ret);
@@ -2670,8 +2669,8 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 		goto out;
 	}
 
-	btrfs_inode_safe_disk_i_size_write(BTRFS_I(inode), 0);
-	ret = btrfs_update_inode_fallback(trans, root, inode);
+	btrfs_inode_safe_disk_i_size_write(inode, 0);
+	ret = btrfs_update_inode_fallback(trans, root, &inode->vfs_inode);
 	if (ret) { /* -ENOMEM or corruption */
 		btrfs_abort_transaction(trans, ret);
 		goto out;
@@ -2683,7 +2682,7 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 		clear_bits |= EXTENT_LOCKED;
 	if (clear_new_delalloc_bytes)
 		clear_bits |= EXTENT_DELALLOC_NEW;
-	clear_extent_bit(&BTRFS_I(inode)->io_tree, start, end, clear_bits,
+	clear_extent_bit(&inode->io_tree, start, end, clear_bits,
 			 (clear_bits & EXTENT_LOCKED) ? 1 : 0, 0,
 			 &cached_state);
 
@@ -2698,7 +2697,7 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 		clear_extent_uptodate(io_tree, unwritten_start, end, NULL);
 
 		/* Drop the cache for the part of the extent we didn't write. */
-		btrfs_drop_extent_cache(BTRFS_I(inode), unwritten_start, end, 0);
+		btrfs_drop_extent_cache(inode, unwritten_start, end, 0);
 
 		/*
 		 * If the ordered extent had an IOERR or something else went
@@ -2733,7 +2732,7 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 	 * This needs to be done to make sure anybody waiting knows we are done
 	 * updating everything for this ordered extent.
 	 */
-	btrfs_remove_ordered_extent(BTRFS_I(inode), ordered_extent);
+	btrfs_remove_ordered_extent(inode, ordered_extent);
 
 	/* once for us */
 	btrfs_put_ordered_extent(ordered_extent);
@@ -4296,7 +4295,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 				if (test_bit(BTRFS_ROOT_SHAREABLE,
 					     &root->state) &&
 				    extent_start != 0)
-					inode_sub_bytes(&inode->vfs_info,
+					inode_sub_bytes(&inode->vfs_inode,
 							num_dec);
 				btrfs_mark_buffer_dirty(leaf);
 			} else {
-- 
2.25.1

