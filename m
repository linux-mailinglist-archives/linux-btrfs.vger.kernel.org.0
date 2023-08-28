Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA0078A72B
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Aug 2023 10:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjH1IHd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Aug 2023 04:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjH1IHS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Aug 2023 04:07:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BB81A5
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 01:06:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09ACA6331E
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 08:06:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB322C433C9
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 08:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693210009;
        bh=L+ooVbAtynx8OtH3rNLw2sfO6BCLsKQGu9+Hiodyal8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=kJJG3Z4z+kSHYN9qlY+R8m2m7ajIgeZvuufklwTjGoru2o9z4CsT8g5nPFjxDGdDs
         uNLc3IzHib8ysUM0D4e8v3egx13GWDJ5vFnFatG85NkuE7JxdSaIT46Kdg/xC8VvsK
         FQY6vdmVU/NsnMsOFIBcx5r22+TfyUEWdaGCdq58FFE/wRpfWo37v4rqM0A/eKfEji
         bndjFh32z7Zt7A2lfARvzTtJOwZGwQarsp/JwAVo8SwWg0SimIasFFMIf50opFe7bQ
         G1Jn5c5f2xVmAw6i2jnz1gdD4aH2guAsuZG2J8DgRObMga5L1lW+L/Uq5m9RAFDhee
         i1mLKqkA5kU2g==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/3] btrfs: remove BUG() after failure to insert delayed dir index item
Date:   Mon, 28 Aug 2023 09:06:43 +0100
Message-Id: <ee7caf888c95075685cd068d6e78f96be283b4b5.1693209858.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1693209858.git.fdmanana@suse.com>
References: <cover.1693209858.git.fdmanana@suse.com>
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
 fs/btrfs/delayed-inode.c | 74 +++++++++++++++++++++++++---------------
 1 file changed, 47 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index f9dae729811b..eb175ae52245 100644
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
+		btrfs_release_delayed_item(delayed_item);
+		btrfs_release_dir_index_item_space(trans);
+		mutex_unlock(&delayed_node->mutex);
+		goto release_node;
+	}
+
 	if (delayed_node->index_item_leaves == 0 ||
 	    delayed_node->curr_index_batch_size + data_len > leaf_data_size) {
 		delayed_node->curr_index_batch_size = data_len;
@@ -1472,37 +1515,14 @@ int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
 		 * impossible.
 		 */
 		if (WARN_ON(ret)) {
-			mutex_unlock(&delayed_node->mutex);
 			btrfs_release_delayed_item(delayed_item);
+			mutex_unlock(&delayed_node->mutex);
 			goto release_node;
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

