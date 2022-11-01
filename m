Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308186152EC
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 21:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiKAUNJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 16:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiKAUNG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 16:13:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5607C1D0F3
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 13:13:05 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0D7AB336C4;
        Tue,  1 Nov 2022 20:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667333584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I4GWn4hif4EEGoAuJoPrbh0OWXdq6YAYPwv514DrUmo=;
        b=KZo/lxo3PctNCDcKe7QUnBiq8UoEAV68H1mZqA9/5//2FyRhb/oGZNWfoPZMvpIK2gpq9U
        hDYSIPaGMZin8dcaSjHtkrhz8wPVk8WEFXcl+uG5qdTx73fEz2OPb/PLxyhf54f6ePVD6X
        lqoJbroEXtIQQ+vBRE/b1axmBZNErPw=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 04B182C141;
        Tue,  1 Nov 2022 20:13:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 551B2DA79D; Tue,  1 Nov 2022 21:12:47 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 31/40] btrfs: pass btrfs_inode to btrfs_clear_delalloc_extent
Date:   Tue,  1 Nov 2022 21:12:47 +0100
Message-Id: <8a5ede0fcaa5d6e39164f78cef6ba79fd144f66d.1667331829.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1667331828.git.dsterba@suse.com>
References: <cover.1667331828.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham
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
 fs/btrfs/btrfs_inode.h    | 2 +-
 fs/btrfs/extent-io-tree.c | 2 +-
 fs/btrfs/inode.c          | 5 ++---
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index ddf1867ba6d5..9e31dc8b0285 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -473,7 +473,7 @@ struct inode *btrfs_new_subvol_inode(struct user_namespace *mnt_userns,
 				     struct inode *dir);
  void btrfs_set_delalloc_extent(struct btrfs_inode *inode, struct extent_state *state,
 			        u32 bits);
-void btrfs_clear_delalloc_extent(struct inode *inode,
+void btrfs_clear_delalloc_extent(struct btrfs_inode *inode,
 				 struct extent_state *state, u32 bits);
 void btrfs_merge_delalloc_extent(struct btrfs_inode *inode, struct extent_state *new,
 				 struct extent_state *other);
diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 124aede5e492..285b0ff6e953 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -509,7 +509,7 @@ static struct extent_state *clear_state_bit(struct extent_io_tree *tree,
 	int ret;
 
 	if (tree->inode)
-		btrfs_clear_delalloc_extent(&tree->inode->vfs_inode, state, bits);
+		btrfs_clear_delalloc_extent(tree->inode, state, bits);
 
 	ret = add_extent_changeset(state, bits_to_clear, changeset, 0);
 	BUG_ON(ret < 0);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9cbbccb2be5f..a609b2071c99 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2471,11 +2471,10 @@ void btrfs_set_delalloc_extent(struct btrfs_inode *inode, struct extent_state *s
  * Once a range is no longer delalloc this function ensures that proper
  * accounting happens.
  */
-void btrfs_clear_delalloc_extent(struct inode *vfs_inode,
+void btrfs_clear_delalloc_extent(struct btrfs_inode *inode,
 				 struct extent_state *state, u32 bits)
 {
-	struct btrfs_inode *inode = BTRFS_I(vfs_inode);
-	struct btrfs_fs_info *fs_info = btrfs_sb(vfs_inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	u64 len = state->end + 1 - state->start;
 	u32 num_extents = count_max_extents(fs_info, len);
 
-- 
2.37.3

