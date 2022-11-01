Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848106152EA
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 21:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiKAUNH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 16:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiKAUND (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 16:13:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AB91E734
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 13:13:01 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B8DA61F8BA;
        Tue,  1 Nov 2022 20:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667333579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QeGhQNFh+EgNkyVs51EEpPjfMqG1231bjC1RcpnPGso=;
        b=MxV0VLdey+4uN8Pikcye3hlb8r1/Se9ZrGPtCcr74gatB4Detd/ajpapIwFQqBTl6RCLVA
        ju1NgMXfBqO4TOe2mb27yS3TBrrW14v6q6Vws3Bkvu2HD/qtkFdoHDbnir5CXwKfLEsyim
        j10OlmEqenl8c2GtKaoISfB3/OFH3gY=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id B22172C141;
        Tue,  1 Nov 2022 20:12:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0E4BEDA79D; Tue,  1 Nov 2022 21:12:43 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 29/40] btrfs: pass btrfs_inode to btrfs_set_delalloc_extent
Date:   Tue,  1 Nov 2022 21:12:42 +0100
Message-Id: <b4e5348815f7b240d504fc7f8f90ad000b78f9c6.1667331829.git.dsterba@suse.com>
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
 fs/btrfs/btrfs_inode.h    |  2 +-
 fs/btrfs/extent-io-tree.c |  2 +-
 fs/btrfs/inode.c          | 33 ++++++++++++++++-----------------
 3 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 130c95c6f7df..8a8280233199 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -471,7 +471,7 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 void btrfs_new_inode_args_destroy(struct btrfs_new_inode_args *args);
 struct inode *btrfs_new_subvol_inode(struct user_namespace *mnt_userns,
 				     struct inode *dir);
- void btrfs_set_delalloc_extent(struct inode *inode, struct extent_state *state,
+ void btrfs_set_delalloc_extent(struct btrfs_inode *inode, struct extent_state *state,
 			        u32 bits);
 void btrfs_clear_delalloc_extent(struct inode *inode,
 				 struct extent_state *state, u32 bits);
diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 942212e1dbaf..1b4c52d7201d 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -373,7 +373,7 @@ static void set_state_bits(struct extent_io_tree *tree,
 	int ret;
 
 	if (tree->inode)
-		btrfs_set_delalloc_extent(&tree->inode->vfs_inode, state, bits);
+		btrfs_set_delalloc_extent(tree->inode, state, bits);
 
 	ret = add_extent_changeset(state, bits_to_set, changeset, 1);
 	BUG_ON(ret < 0);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 27dd57978fdf..c373125e13c2 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2421,10 +2421,10 @@ static void btrfs_del_delalloc_inode(struct btrfs_root *root,
  * Properly track delayed allocation bytes in the inode and to maintain the
  * list of inodes that have pending delalloc work to be done.
  */
-void btrfs_set_delalloc_extent(struct inode *inode, struct extent_state *state,
+void btrfs_set_delalloc_extent(struct btrfs_inode *inode, struct extent_state *state,
 			       u32 bits)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 
 	if ((bits & EXTENT_DEFRAG) && !(bits & EXTENT_DELALLOC))
 		WARN_ON(1);
@@ -2434,14 +2434,14 @@ void btrfs_set_delalloc_extent(struct inode *inode, struct extent_state *state,
 	 * bit, which is only set or cleared with irqs on
 	 */
 	if (!(state->state & EXTENT_DELALLOC) && (bits & EXTENT_DELALLOC)) {
-		struct btrfs_root *root = BTRFS_I(inode)->root;
+		struct btrfs_root *root = inode->root;
 		u64 len = state->end + 1 - state->start;
 		u32 num_extents = count_max_extents(fs_info, len);
-		bool do_list = !btrfs_is_free_space_inode(BTRFS_I(inode));
+		bool do_list = !btrfs_is_free_space_inode(inode);
 
-		spin_lock(&BTRFS_I(inode)->lock);
-		btrfs_mod_outstanding_extents(BTRFS_I(inode), num_extents);
-		spin_unlock(&BTRFS_I(inode)->lock);
+		spin_lock(&inode->lock);
+		btrfs_mod_outstanding_extents(inode, num_extents);
+		spin_unlock(&inode->lock);
 
 		/* For sanity tests */
 		if (btrfs_is_testing(fs_info))
@@ -2449,22 +2449,21 @@ void btrfs_set_delalloc_extent(struct inode *inode, struct extent_state *state,
 
 		percpu_counter_add_batch(&fs_info->delalloc_bytes, len,
 					 fs_info->delalloc_batch);
-		spin_lock(&BTRFS_I(inode)->lock);
-		BTRFS_I(inode)->delalloc_bytes += len;
+		spin_lock(&inode->lock);
+		inode->delalloc_bytes += len;
 		if (bits & EXTENT_DEFRAG)
-			BTRFS_I(inode)->defrag_bytes += len;
+			inode->defrag_bytes += len;
 		if (do_list && !test_bit(BTRFS_INODE_IN_DELALLOC_LIST,
-					 &BTRFS_I(inode)->runtime_flags))
-			btrfs_add_delalloc_inodes(root, BTRFS_I(inode));
-		spin_unlock(&BTRFS_I(inode)->lock);
+					 &inode->runtime_flags))
+			btrfs_add_delalloc_inodes(root, inode);
+		spin_unlock(&inode->lock);
 	}
 
 	if (!(state->state & EXTENT_DELALLOC_NEW) &&
 	    (bits & EXTENT_DELALLOC_NEW)) {
-		spin_lock(&BTRFS_I(inode)->lock);
-		BTRFS_I(inode)->new_delalloc_bytes += state->end + 1 -
-			state->start;
-		spin_unlock(&BTRFS_I(inode)->lock);
+		spin_lock(&inode->lock);
+		inode->new_delalloc_bytes += state->end + 1 - state->start;
+		spin_unlock(&inode->lock);
 	}
 }
 
-- 
2.37.3

