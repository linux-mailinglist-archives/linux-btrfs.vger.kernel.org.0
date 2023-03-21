Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79EF96C3007
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 12:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjCULPF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 07:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjCULOw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 07:14:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC683B858
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 04:14:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4AF0CB815B4
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:14:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99144C4339B
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679397266;
        bh=UWqbeMMaFS3sux1zAjaQCy/q8tfylgXmh16CGfsTp84=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=UC9jItzqmrKhNlDklgtcBKr4iulV8BmD0wykxmAyHQ2X2Sl2HQeOI65zw8X0JWQwK
         u4HIP8nKjqH4+VPAiHj5e2Ecoi44godZO/0AOpEWAiUKp3IE5uBW5fUj2Yn5V3ElIz
         bZN7rbWdx8/+cMoUH7ikl8U9Q34uOqlhQB+QHUwdLshnh/vCm9wyNxQ3Iz2IKxdAq9
         56L2fIRdP1G3aG/8u621LVBXLJJ/Qp84lZC6oVrvQc2LjYN3yntq4ezlU40cr+GTnc
         GhMRRN/AmgSqYHajck1a8HVSaWkyx6ZQhYTxnLS6pGkBYiMdcoJyf80jk6gmBPYBT7
         ljNRQn3DHM3aA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 24/24] btrfs: simplify exit paths of btrfs_evict_inode()
Date:   Tue, 21 Mar 2023 11:14:00 +0000
Message-Id: <b831b63a2d19c77f520898f0a0ead203670aa538.1679326435.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1679326426.git.fdmanana@suse.com>
References: <cover.1679326426.git.fdmanana@suse.com>
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

Instead of using two labels at btrfs_evict_inode() for exiting depending
on whether we need to delete the inode items and orphan or some error
happened, we can use a single exit label if we initialize the block
reserve to NULL, since btrfs_free_block_rsv() ignores a NULL block reserve
pointer. So just do that. It will also make an upcoming change simpler by
avoiding one extra error label.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0b3710d47dd0..865d56ff2ce1 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5271,7 +5271,7 @@ void btrfs_evict_inode(struct inode *inode)
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_trans_handle *trans;
 	struct btrfs_root *root = BTRFS_I(inode)->root;
-	struct btrfs_block_rsv *rsv;
+	struct btrfs_block_rsv *rsv = NULL;
 	int ret;
 
 	trace_btrfs_inode_evict(inode);
@@ -5288,18 +5288,18 @@ void btrfs_evict_inode(struct inode *inode)
 	    ((btrfs_root_refs(&root->root_item) != 0 &&
 	      root->root_key.objectid != BTRFS_ROOT_TREE_OBJECTID) ||
 	     btrfs_is_free_space_inode(BTRFS_I(inode))))
-		goto no_delete;
+		goto out;
 
 	if (is_bad_inode(inode))
-		goto no_delete;
+		goto out;
 
 	if (test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags))
-		goto no_delete;
+		goto out;
 
 	if (inode->i_nlink > 0) {
 		BUG_ON(btrfs_root_refs(&root->root_item) != 0 &&
 		       root->root_key.objectid != BTRFS_ROOT_TREE_OBJECTID);
-		goto no_delete;
+		goto out;
 	}
 
 	/*
@@ -5308,7 +5308,7 @@ void btrfs_evict_inode(struct inode *inode)
 	 */
 	ret = btrfs_commit_inode_delayed_inode(BTRFS_I(inode));
 	if (ret)
-		goto no_delete;
+		goto out;
 
 	/*
 	 * This drops any pending insert or delete operations we have for this
@@ -5320,7 +5320,7 @@ void btrfs_evict_inode(struct inode *inode)
 
 	rsv = btrfs_alloc_block_rsv(fs_info, BTRFS_BLOCK_RSV_TEMP);
 	if (!rsv)
-		goto no_delete;
+		goto out;
 	rsv->size = btrfs_calc_metadata_size(fs_info, 1);
 	rsv->failfast = true;
 
@@ -5336,7 +5336,7 @@ void btrfs_evict_inode(struct inode *inode)
 
 		trans = evict_refill_and_join(root, rsv);
 		if (IS_ERR(trans))
-			goto free_rsv;
+			goto out;
 
 		trans->block_rsv = rsv;
 
@@ -5350,7 +5350,7 @@ void btrfs_evict_inode(struct inode *inode)
 		 */
 		btrfs_btree_balance_dirty_nodelay(fs_info);
 		if (ret && ret != -ENOSPC && ret != -EAGAIN)
-			goto free_rsv;
+			goto out;
 		else if (!ret)
 			break;
 	}
@@ -5372,9 +5372,8 @@ void btrfs_evict_inode(struct inode *inode)
 		btrfs_end_transaction(trans);
 	}
 
-free_rsv:
+out:
 	btrfs_free_block_rsv(fs_info, rsv);
-no_delete:
 	/*
 	 * If we didn't successfully delete, the orphan item will still be in
 	 * the tree and we'll retry on the next mount. Again, we might also want
-- 
2.34.1

