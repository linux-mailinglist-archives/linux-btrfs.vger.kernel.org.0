Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D39D6152E0
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 21:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiKAUMn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 16:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiKAUMg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 16:12:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A4F1CB09
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 13:12:35 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E82DB1F8C2;
        Tue,  1 Nov 2022 20:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667333553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=THprjREbCPirP4Q8sHT1VynKMkVwc4tL7bZhzaE6DLA=;
        b=ahc6vgrlmsRrWIlgcCts3sbKUxhQtSjUeToKvgOjTe89DJhNFa4qU/zuzKxjTKojjkBf4J
        zkmR5PJ9CeVN+76ezyejg3Y9XZn+MPIhSZf8uy1Zp+eJFhit0CAvJaboq+0/FxRV/fF9Dt
        hXEVeqxRszQyJQAEjCj98H5nHxF/Jvk=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E13812C141;
        Tue,  1 Nov 2022 20:12:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3BF62DA79D; Tue,  1 Nov 2022 21:12:17 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 17/40] btrfs: pass btrfs_inode to btrfs_truncate
Date:   Tue,  1 Nov 2022 21:12:17 +0100
Message-Id: <9d803e20f54e884249f546a3b1037d77d25263fd.1667331828.git.dsterba@suse.com>
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
 fs/btrfs/inode.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index dbe55974eb82..b5601d280ef9 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -124,7 +124,7 @@ static const struct file_operations btrfs_dir_file_operations;
 static struct kmem_cache *btrfs_inode_cachep;
 
 static int btrfs_setsize(struct inode *inode, struct iattr *attr);
-static int btrfs_truncate(struct inode *inode, bool skip_writeback);
+static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback);
 static noinline int cow_file_range(struct btrfs_inode *inode,
 				   struct page *locked_page,
 				   u64 start, u64 end, int *page_started,
@@ -5269,7 +5269,7 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
 
 		inode_dio_wait(inode);
 
-		ret = btrfs_truncate(inode, newsize == oldsize);
+		ret = btrfs_truncate(BTRFS_I(inode), newsize == oldsize);
 		if (ret && inode->i_nlink) {
 			int err;
 
@@ -8631,16 +8631,16 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	return ret;
 }
 
-static int btrfs_truncate(struct inode *inode, bool skip_writeback)
+static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback)
 {
 	struct btrfs_truncate_control control = {
-		.inode = BTRFS_I(inode),
-		.ino = btrfs_ino(BTRFS_I(inode)),
+		.inode = inode,
+		.ino = btrfs_ino(inode),
 		.min_type = BTRFS_EXTENT_DATA_KEY,
 		.clear_extent_range = true,
 	};
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct btrfs_root *root = BTRFS_I(inode)->root;
+	struct btrfs_root *root = inode->root;
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_block_rsv *rsv;
 	int ret;
 	struct btrfs_trans_handle *trans;
@@ -8648,7 +8648,8 @@ static int btrfs_truncate(struct inode *inode, bool skip_writeback)
 	u64 min_size = btrfs_calc_metadata_size(fs_info, 1);
 
 	if (!skip_writeback) {
-		ret = btrfs_wait_ordered_range(inode, inode->i_size & (~mask),
+		ret = btrfs_wait_ordered_range(&inode->vfs_inode,
+					       inode->vfs_inode.i_size & (~mask),
 					       (u64)-1);
 		if (ret)
 			return ret;
@@ -8707,34 +8708,32 @@ static int btrfs_truncate(struct inode *inode, bool skip_writeback)
 
 	while (1) {
 		struct extent_state *cached_state = NULL;
-		const u64 new_size = inode->i_size;
+		const u64 new_size = inode->vfs_inode.i_size;
 		const u64 lock_start = ALIGN_DOWN(new_size, fs_info->sectorsize);
 
 		control.new_size = new_size;
-		lock_extent(&BTRFS_I(inode)->io_tree, lock_start, (u64)-1,
-				 &cached_state);
+		lock_extent(&inode->io_tree, lock_start, (u64)-1, &cached_state);
 		/*
 		 * We want to drop from the next block forward in case this new
 		 * size is not block aligned since we will be keeping the last
 		 * block of the extent just the way it is.
 		 */
-		btrfs_drop_extent_map_range(BTRFS_I(inode),
+		btrfs_drop_extent_map_range(inode,
 					    ALIGN(new_size, fs_info->sectorsize),
 					    (u64)-1, false);
 
 		ret = btrfs_truncate_inode_items(trans, root, &control);
 
-		inode_sub_bytes(inode, control.sub_bytes);
-		btrfs_inode_safe_disk_i_size_write(BTRFS_I(inode), control.last_size);
+		inode_sub_bytes(&inode->vfs_inode, control.sub_bytes);
+		btrfs_inode_safe_disk_i_size_write(inode, control.last_size);
 
-		unlock_extent(&BTRFS_I(inode)->io_tree, lock_start, (u64)-1,
-			      &cached_state);
+		unlock_extent(&inode->io_tree, lock_start, (u64)-1, &cached_state);
 
 		trans->block_rsv = &fs_info->trans_block_rsv;
 		if (ret != -ENOSPC && ret != -EAGAIN)
 			break;
 
-		ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
+		ret = btrfs_update_inode(trans, root, inode);
 		if (ret)
 			break;
 
@@ -8765,7 +8764,7 @@ static int btrfs_truncate(struct inode *inode, bool skip_writeback)
 		btrfs_end_transaction(trans);
 		btrfs_btree_balance_dirty(fs_info);
 
-		ret = btrfs_truncate_block(BTRFS_I(inode), inode->i_size, 0, 0);
+		ret = btrfs_truncate_block(inode, inode->vfs_inode.i_size, 0, 0);
 		if (ret)
 			goto out;
 		trans = btrfs_start_transaction(root, 1);
@@ -8773,14 +8772,14 @@ static int btrfs_truncate(struct inode *inode, bool skip_writeback)
 			ret = PTR_ERR(trans);
 			goto out;
 		}
-		btrfs_inode_safe_disk_i_size_write(BTRFS_I(inode), 0);
+		btrfs_inode_safe_disk_i_size_write(inode, 0);
 	}
 
 	if (trans) {
 		int ret2;
 
 		trans->block_rsv = &fs_info->trans_block_rsv;
-		ret2 = btrfs_update_inode(trans, root, BTRFS_I(inode));
+		ret2 = btrfs_update_inode(trans, root, inode);
 		if (ret2 && !ret)
 			ret = ret2;
 
@@ -8806,7 +8805,7 @@ static int btrfs_truncate(struct inode *inode, bool skip_writeback)
 	 * extents beyond i_size to drop.
 	 */
 	if (control.extents_found > 0)
-		btrfs_set_inode_full_sync(BTRFS_I(inode));
+		btrfs_set_inode_full_sync(inode);
 
 	return ret;
 }
-- 
2.37.3

