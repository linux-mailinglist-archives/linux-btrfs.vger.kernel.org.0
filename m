Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C5A6152DD
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 21:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiKAUMt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 16:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiKAUMn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 16:12:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A335A1E3DA
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 13:12:41 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 65D2B1F38A;
        Tue,  1 Nov 2022 20:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667333560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ujvh5rivmr3IsuehTVmOW/++54m8eez96sTU/kIuJdg=;
        b=DrWEYLwXTScbbITascBJoLaWCfRNM8rIf/VqKZlHe0unQA0tybBis8uxTX5o6q2rT5caMC
        EwQU0nHisgDgI6m2W8lv7J83ejTiOp50jsIRET/QjJ9Z/GldSP/KiCxCS+Dki9UlfhxYk5
        AZKDRudKszTwPDOI4ItyERCGChJ/C3E=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 5E96D2C141;
        Tue,  1 Nov 2022 20:12:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A316CDA79D; Tue,  1 Nov 2022 21:12:23 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 20/40] btrfs: pass btrfs_inode to btrfs_dirty_inode
Date:   Tue,  1 Nov 2022 21:12:23 +0100
Message-Id: <b867b791c4aad09538e87a666f364baf8b3b9537.1667331828.git.dsterba@suse.com>
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
 fs/btrfs/inode.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 977def66afab..754198b18d41 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -286,7 +286,7 @@ static inline void btrfs_cleanup_ordered_extents(struct btrfs_inode *inode,
 	return btrfs_mark_ordered_io_finished(inode, NULL, offset, bytes, false);
 }
 
-static int btrfs_dirty_inode(struct inode *inode);
+static int btrfs_dirty_inode(struct btrfs_inode *inode);
 
 static int btrfs_init_inode_security(struct btrfs_trans_handle *trans,
 				     struct btrfs_new_inode_args *args)
@@ -5312,7 +5312,7 @@ static int btrfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentr
 	if (attr->ia_valid) {
 		setattr_copy(mnt_userns, inode, attr);
 		inode_inc_iversion(inode);
-		err = btrfs_dirty_inode(inode);
+		err = btrfs_dirty_inode(BTRFS_I(inode));
 
 		if (!err && attr->ia_valid & ATTR_MODE)
 			err = posix_acl_chmod(mnt_userns, inode, inode->i_mode);
@@ -6143,21 +6143,21 @@ static int btrfs_real_readdir(struct file *file, struct dir_context *ctx)
  * FIXME, needs more benchmarking...there are no reasons other than performance
  * to keep or drop this code.
  */
-static int btrfs_dirty_inode(struct inode *inode)
+static int btrfs_dirty_inode(struct btrfs_inode *inode)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct btrfs_root *root = BTRFS_I(inode)->root;
+	struct btrfs_root *root = inode->root;
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_trans_handle *trans;
 	int ret;
 
-	if (test_bit(BTRFS_INODE_DUMMY, &BTRFS_I(inode)->runtime_flags))
+	if (test_bit(BTRFS_INODE_DUMMY, &inode->runtime_flags))
 		return 0;
 
 	trans = btrfs_join_transaction(root);
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
-	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
+	ret = btrfs_update_inode(trans, root, inode);
 	if (ret && (ret == -ENOSPC || ret == -EDQUOT)) {
 		/* whoops, lets try again with the full transaction */
 		btrfs_end_transaction(trans);
@@ -6165,10 +6165,10 @@ static int btrfs_dirty_inode(struct inode *inode)
 		if (IS_ERR(trans))
 			return PTR_ERR(trans);
 
-		ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
+		ret = btrfs_update_inode(trans, root, inode);
 	}
 	btrfs_end_transaction(trans);
-	if (BTRFS_I(inode)->delayed_node)
+	if (inode->delayed_node)
 		btrfs_balance_delayed_items(fs_info);
 
 	return ret;
@@ -6195,7 +6195,7 @@ static int btrfs_update_time(struct inode *inode, struct timespec64 *now,
 		inode->i_mtime = *now;
 	if (flags & S_ATIME)
 		inode->i_atime = *now;
-	return dirty ? btrfs_dirty_inode(inode) : 0;
+	return dirty ? btrfs_dirty_inode(BTRFS_I(inode)) : 0;
 }
 
 /*
-- 
2.37.3

