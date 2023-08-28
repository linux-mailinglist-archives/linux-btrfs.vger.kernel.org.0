Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBB578A6A4
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Aug 2023 09:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjH1Hhq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Aug 2023 03:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjH1HhY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Aug 2023 03:37:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C79CC
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 00:37:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA5F262DEB
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 07:37:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A948BC433C9
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 07:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693208241;
        bh=yrCV6tp3oD+30ZdkQ9c9ncIOwrislgD3Y59+oOoK+a0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=KtxfnSj94BKw2F2NwqbnzbP/ShbHH0khSIHWnUbglSAtTIe9rK4aRB/jppBGpWoHs
         /7VWcPcDe5mGYSQiHvooDaTz64WuQkn+53joXvXz7kTgYfYWAuhFO1ssuUZJQ22tNh
         dOtpY9NMYK+ykftNiBoJWr0HWSo7fmGA6Xe4G17Cb8dHPVmdFZPFxHIkhg659KjbJn
         4qlonQm+6f6V8ooJOQRniLBDMcWB/FwRXjBENvb2xVgOfMTon/McbXnBbVC/XsbNAj
         UEamT1LgGuUs8lwnokVbADOOE+gN4b0TTVkGgX7Ws95p3m5u+SGy7tbwMUVoJ+3JU/
         ovUDBJIvAy5XQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: remove BUG() after failure to insert delayed dir index item
Date:   Mon, 28 Aug 2023 08:37:15 +0100
Message-Id: <4500e40c9d2b4449c3950dc83d7a9ec94cdc6664.1693207973.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1693207973.git.fdmanana@suse.com>
References: <cover.1693207973.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Instead of calling BUG() when we fail to insert a delayed dir index item
into the delayed node's tree, we can just release all the resources we
have allocated/acquired before and return the error to the caller. This is
fine because all existing call chains undo anything they have done before
calling btrfs_insert_delayed_dir_index() or BUG_ON (when creating pending
snapshots in the transaction commit path).

So remove the BUG() call and do proper error handling.

This relates to a syzbot report linked below, but does not fix it because
it only prevents hitting a BUG(), it does not fix the issue where somehow
we attempt to use twice the same index number for different index items.

Link: https://lore.kernel.org/linux-btrfs/00000000000036e1290603e097e0@google.com/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-inode.c | 72 +++++++++++++++++++++++++---------------
 1 file changed, 46 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index f9dae729811b..5da7442a1d96 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1413,7 +1413,29 @@ void btrfs_balance_delayed_items(struct btrfs_fs_info *fs_info)
 	btrfs_wq_run_delayed_node(delayed_root, fs_info, BTRFS_DELAYED_BATCH);
 }
 
-/* Will return 0 or -ENOMEM */
+static void btrfs_release_dir_index_item_space(struct btrfs_trans_handle *trans)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	const u64 bytes = btrfs_calc_insert_metadata_size(fs_info, 1);
+
+	if (test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags))
+		return;
+
+	/*
+	 * Adding the new dir index item does not require touching another
+	 * leaf, so we can release 1 unit of metadata that was previously
+	 * reserved when starting the transaction. This applies only to
+	 * the case where we had a transaction start and excludes the
+	 * transaction join case (when replaying log trees).
+	 */
+	trace_btrfs_space_reservation(fs_info, "transaction",
+				      trans->transid, bytes, 0);
+	btrfs_block_rsv_release(fs_info, trans->block_rsv, bytes, NULL);
+	ASSERT(trans->bytes_reserved >= bytes);
+	trans->bytes_reserved -= bytes;
+}
+
+/* Will return 0, -ENOMEM or -EEXIST (index number collision, unexpected). */
 int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
 				   const char *name, int name_len,
 				   struct btrfs_inode *dir,
@@ -1455,6 +1477,27 @@ int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
 
 	mutex_lock(&delayed_node->mutex);
 
+	/*
+	 * First attempt to insert the delayed item. This is to make the error
+	 * handling path simpler in case we fail (-EEXIST). There's no risk of
+	 * any other task coming in and running the delayed item before we do
+	 * the metadata space reservation below, because we are holding the
+	 * delayed node's mutex and that mutex must also be locked before the
+	 * node's delayed items can be run.
+	 */
+	ret = __btrfs_add_delayed_item(delayed_node, delayed_item);
+	if (unlikely(ret)) {
+		btrfs_err(trans->fs_info,
+"error adding delayed dir index item, name: %.*s, index: %llu, root: %llu, dir: %llu, dir->index_cnt: %llu, delayed_node->index_cnt: %llu, error: %d",
+			  name_len, name, index, btrfs_root_id(delayed_node->root),
+			  delayed_node->inode_id, dir->index_cnt,
+			  delayed_node->index_cnt, ret);
+		mutex_unlock(&delayed_node->mutex);
+		btrfs_release_delayed_item(delayed_item);
+		btrfs_release_dir_index_item_space(trans);
+		goto release_node;
+	}
+
 	if (delayed_node->index_item_leaves == 0 ||
 	    delayed_node->curr_index_batch_size + data_len > leaf_data_size) {
 		delayed_node->curr_index_batch_size = data_len;
@@ -1478,31 +1521,8 @@ int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
 		}
 
 		delayed_node->index_item_leaves++;
-	} else if (!test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags)) {
-		const u64 bytes = btrfs_calc_insert_metadata_size(fs_info, 1);
-
-		/*
-		 * Adding the new dir index item does not require touching another
-		 * leaf, so we can release 1 unit of metadata that was previously
-		 * reserved when starting the transaction. This applies only to
-		 * the case where we had a transaction start and excludes the
-		 * transaction join case (when replaying log trees).
-		 */
-		trace_btrfs_space_reservation(fs_info, "transaction",
-					      trans->transid, bytes, 0);
-		btrfs_block_rsv_release(fs_info, trans->block_rsv, bytes, NULL);
-		ASSERT(trans->bytes_reserved >= bytes);
-		trans->bytes_reserved -= bytes;
-	}
-
-	ret = __btrfs_add_delayed_item(delayed_node, delayed_item);
-	if (unlikely(ret)) {
-		btrfs_err(trans->fs_info,
-"error adding delayed dir index item, name: %.*s, index: %llu, root: %llu, dir: %llu, dir->index_cnt: %llu, delayed_node->index_cnt: %llu, error: %d",
-			  name_len, name, index, btrfs_root_id(delayed_node->root),
-			  delayed_node->inode_id, dir->index_cnt,
-			  delayed_node->index_cnt, ret);
-		BUG();
+	} else {
+		btrfs_release_dir_index_item_space(trans);
 	}
 	mutex_unlock(&delayed_node->mutex);
 
-- 
2.40.1

