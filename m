Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024D87AAFA5
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 12:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbjIVKhp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 06:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbjIVKhl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 06:37:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A2F1B1
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 03:37:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5336C433C8
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 10:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695379053;
        bh=1PZGIpQhgfgv1p7tmvCtm1bOPZdWAM8ReixEaHfZ+Oo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=UZ1iOpPNI9XiqdboPbVvSjtLYnm1Qs0NPIlqFs41w5SgZfUcw69gK7zYW+X+MAFc1
         pMjdMvxLUptdE/0oyms/UL4/qWfDT1600tgaPV5hYyxwjOYf3zjzJoG+kz9ANkOGTq
         kFEL1Ebk38uJ2+hWAsAaA+DAnilBzJb+jIpxG/HcQ5O7+I2BhbQgBTlxBngVxRPJeu
         x4S5BG0dYIIG7QiKeBTHZolKK1VEvgG1X8ZSh1I7fxW52NYKLFzEMRLPFKG5rQNIXx
         pzg3bgHq4ihW7fvfYKU++q6EyDIMO8i90N3M1/w4yGqSfXFIsyLYLYjBqOh+1uzA6y
         P29eMPGpjlkuw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/8] btrfs: remove redundant root argument from btrfs_update_inode_fallback()
Date:   Fri, 22 Sep 2023 11:37:21 +0100
Message-Id: <341efed98859d5db55fcb05c7288780762ddf497.1695333082.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1695333082.git.fdmanana@suse.com>
References: <cover.1695333082.git.fdmanana@suse.com>
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

The root argument for btrfs_update_inode_fallback() always matches the
root of the given inode, so remove the root argument and get it from the
inode argument.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/btrfs_inode.h |  2 +-
 fs/btrfs/inode.c       | 12 ++++++------
 fs/btrfs/transaction.c |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 4311ac9ca0ae..d12556627cce 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -484,7 +484,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 int btrfs_update_inode(struct btrfs_trans_handle *trans,
 		       struct btrfs_root *root, struct btrfs_inode *inode);
 int btrfs_update_inode_fallback(struct btrfs_trans_handle *trans,
-				struct btrfs_root *root, struct btrfs_inode *inode);
+				struct btrfs_inode *inode);
 int btrfs_orphan_add(struct btrfs_trans_handle *trans, struct btrfs_inode *inode);
 int btrfs_orphan_cleanup(struct btrfs_root *root);
 int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index fb7d7d0077f0..44836d1f99a9 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3074,7 +3074,7 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 			goto out;
 		}
 		trans->block_rsv = &inode->block_rsv;
-		ret = btrfs_update_inode_fallback(trans, root, inode);
+		ret = btrfs_update_inode_fallback(trans, inode);
 		if (ret) /* -ENOMEM or corruption */
 			btrfs_abort_transaction(trans, ret);
 		goto out;
@@ -3144,7 +3144,7 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 				 &cached_state);
 
 	btrfs_inode_safe_disk_i_size_write(inode, 0);
-	ret = btrfs_update_inode_fallback(trans, root, inode);
+	ret = btrfs_update_inode_fallback(trans, inode);
 	if (ret) { /* -ENOMEM or corruption */
 		btrfs_abort_transaction(trans, ret);
 		goto out;
@@ -4030,13 +4030,13 @@ int btrfs_update_inode(struct btrfs_trans_handle *trans,
 }
 
 int btrfs_update_inode_fallback(struct btrfs_trans_handle *trans,
-				struct btrfs_root *root, struct btrfs_inode *inode)
+				struct btrfs_inode *inode)
 {
 	int ret;
 
-	ret = btrfs_update_inode(trans, root, inode);
+	ret = btrfs_update_inode(trans, inode->root, inode);
 	if (ret == -ENOSPC)
-		return btrfs_update_inode_item(trans, root, inode);
+		return btrfs_update_inode_item(trans, inode->root, inode);
 	return ret;
 }
 
@@ -4316,7 +4316,7 @@ static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
 	btrfs_i_size_write(dir, dir->vfs_inode.i_size - fname.disk_name.len * 2);
 	inode_inc_iversion(&dir->vfs_inode);
 	dir->vfs_inode.i_mtime = inode_set_ctime_current(&dir->vfs_inode);
-	ret = btrfs_update_inode_fallback(trans, root, dir);
+	ret = btrfs_update_inode_fallback(trans, dir);
 	if (ret)
 		btrfs_abort_transaction(trans, ret);
 out:
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 3f9f933039c6..240dad25fa16 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1942,7 +1942,7 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 	btrfs_i_size_write(BTRFS_I(parent_inode), parent_inode->i_size +
 						  fname.disk_name.len * 2);
 	parent_inode->i_mtime = inode_set_ctime_current(parent_inode);
-	ret = btrfs_update_inode_fallback(trans, parent_root, BTRFS_I(parent_inode));
+	ret = btrfs_update_inode_fallback(trans, BTRFS_I(parent_inode));
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		goto fail;
-- 
2.40.1

