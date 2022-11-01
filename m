Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38EA76152E9
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 21:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiKAUNG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 16:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiKAUND (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 16:13:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA941E73F
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 13:12:58 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 908771F38A;
        Tue,  1 Nov 2022 20:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667333577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iu+41EOe0uMeLxa6gNxs7+waADX5coH1qI4j5CdXnIs=;
        b=Pfh0ajYtGnV1NTUyhGjBhnzMHxiuRRYvXAul4jTchChLIoY6H4FAwMkR58p8B0TthaVnR9
        j6iFlMJUv+kCalPsVqekOMV17neP/92PVHWyqiPBaNoU9hbxDvtzPtU79HKN1/HKFVTKZI
        xMPQpQ8rrqD8GicsnNZaJ0uXG/KLZuM=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 8A08F2C141;
        Tue,  1 Nov 2022 20:12:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DA043DA79D; Tue,  1 Nov 2022 21:12:40 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 28/40] btrfs: pass btrfs_inode to btrfs_merge_delalloc_extent
Date:   Tue,  1 Nov 2022 21:12:40 +0100
Message-Id: <91d177cd730baee5ac9ef60ecad82f79ed26c0c2.1667331828.git.dsterba@suse.com>
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
 fs/btrfs/btrfs_inode.h    |  2 +-
 fs/btrfs/extent-io-tree.c |  6 ++----
 fs/btrfs/inode.c          | 16 ++++++++--------
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 481c75c47fc4..130c95c6f7df 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -475,7 +475,7 @@ struct inode *btrfs_new_subvol_inode(struct user_namespace *mnt_userns,
 			        u32 bits);
 void btrfs_clear_delalloc_extent(struct inode *inode,
 				 struct extent_state *state, u32 bits);
-void btrfs_merge_delalloc_extent(struct inode *inode, struct extent_state *new,
+void btrfs_merge_delalloc_extent(struct btrfs_inode *inode, struct extent_state *new,
 				 struct extent_state *other);
 void btrfs_split_delalloc_extent(struct inode *inode,
 				 struct extent_state *orig, u64 split);
diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index bbcc65593d1d..942212e1dbaf 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -347,8 +347,7 @@ static void merge_state(struct extent_io_tree *tree, struct extent_state *state)
 	if (other && other->end == state->start - 1 &&
 	    other->state == state->state) {
 		if (tree->inode)
-			btrfs_merge_delalloc_extent(&tree->inode->vfs_inode, state,
-						    other);
+			btrfs_merge_delalloc_extent(tree->inode, state, other);
 		state->start = other->start;
 		rb_erase(&other->rb_node, &tree->state);
 		RB_CLEAR_NODE(&other->rb_node);
@@ -358,8 +357,7 @@ static void merge_state(struct extent_io_tree *tree, struct extent_state *state)
 	if (other && other->start == state->end + 1 &&
 	    other->state == state->state) {
 		if (tree->inode)
-			btrfs_merge_delalloc_extent(&tree->inode->vfs_inode, state,
-						    other);
+			btrfs_merge_delalloc_extent(tree->inode, state, other);
 		state->end = other->end;
 		rb_erase(&other->rb_node, &tree->state);
 		RB_CLEAR_NODE(&other->rb_node);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8b329a361096..27dd57978fdf 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2314,10 +2314,10 @@ void btrfs_split_delalloc_extent(struct inode *inode,
  * that are just merged onto old extents, such as when we are doing sequential
  * writes, so we can properly account for the metadata space we'll need.
  */
-void btrfs_merge_delalloc_extent(struct inode *inode, struct extent_state *new,
+void btrfs_merge_delalloc_extent(struct btrfs_inode *inode, struct extent_state *new,
 				 struct extent_state *other)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	u64 new_size, old_size;
 	u32 num_extents;
 
@@ -2332,9 +2332,9 @@ void btrfs_merge_delalloc_extent(struct inode *inode, struct extent_state *new,
 
 	/* we're not bigger than the max, unreserve the space and go */
 	if (new_size <= fs_info->max_extent_size) {
-		spin_lock(&BTRFS_I(inode)->lock);
-		btrfs_mod_outstanding_extents(BTRFS_I(inode), -1);
-		spin_unlock(&BTRFS_I(inode)->lock);
+		spin_lock(&inode->lock);
+		btrfs_mod_outstanding_extents(inode, -1);
+		spin_unlock(&inode->lock);
 		return;
 	}
 
@@ -2363,9 +2363,9 @@ void btrfs_merge_delalloc_extent(struct inode *inode, struct extent_state *new,
 	if (count_max_extents(fs_info, new_size) >= num_extents)
 		return;
 
-	spin_lock(&BTRFS_I(inode)->lock);
-	btrfs_mod_outstanding_extents(BTRFS_I(inode), -1);
-	spin_unlock(&BTRFS_I(inode)->lock);
+	spin_lock(&inode->lock);
+	btrfs_mod_outstanding_extents(inode, -1);
+	spin_unlock(&inode->lock);
 }
 
 static void btrfs_add_delalloc_inodes(struct btrfs_root *root,
-- 
2.37.3

