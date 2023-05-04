Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8E36F697D
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 May 2023 13:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjEDLE5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 May 2023 07:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjEDLEm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 May 2023 07:04:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFFF35B8
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 04:04:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CD206176A
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 11:04:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C44C4339B
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 11:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683198279;
        bh=8VEapYDS3rVWS3k+U7V9h4mOg5TgBmAa3TgFbBcLPWk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=SbuYXY0gn7Cd+/KZ4qDSf5alUc0kns1XR00m5eNgZSxs9WblH4BcGqE8/9wgkenD9
         rdRIa9AzdfoBOZxRpuAAhrwhOp8ESLb0/Gh+jnr8tJ2TS8qbrhhseP02YNEZ4DvnDu
         1kLfkt0ResIQQ4VRnnnIddEnRUz6n5gvDQQMplOuwIxOe04IdKgJpPTUvtfI/VY48p
         FvUuC1yeWTXOG1k4/c6C2kMwbvaOlIaVNJqoFH0YkZnyQTE6gfOgl/npFnKXHdc2be
         K02bdNNJMNMeGxrmxrictcizDFq9Ijp57gE/Qde+X6gqnscByqhNOtNOqW6Sbfnq+F
         z8SjCGCU/vbeg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 9/9] btrfs: assert tree lock is held when removing free space entries
Date:   Thu,  4 May 2023 12:04:26 +0100
Message-Id: <9bdbe975c02ac41e03512cc334c199602d04a87d.1683196407.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1683196407.git.fdmanana@suse.com>
References: <cover.1683196407.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Removing a free space entry from an in memory space cache requires having
the corresponding btrfs_free_space_ctl's 'tree_lock' held. We have several
code paths that remove an entry, so add assertions where appropriate to
verify we are holding the lock, as the lock is acquired by some other
function up in the call chain, which makes it easy to miss in the future.

Note: for this to work we need to lock the local btrfs_free_space_ctl at
load_free_space_cache(), which was not being done because it's local,
declared on the stack, so no other task has access to it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/free-space-cache.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index f5ddfb2e58a9..fdca565477f3 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -927,25 +927,27 @@ static int copy_free_space_cache(struct btrfs_block_group *block_group,
 			const u64 bytes = info->bytes;
 
 			unlink_free_space(ctl, info, true);
+			spin_unlock(&ctl->tree_lock);
 			kmem_cache_free(btrfs_free_space_cachep, info);
 			ret = btrfs_add_free_space(block_group, offset, bytes);
+			spin_lock(&ctl->tree_lock);
 		} else {
 			u64 offset = info->offset;
 			u64 bytes = ctl->unit;
 
-			while (search_bitmap(ctl, info, &offset, &bytes,
-					     false) == 0) {
+			ret = search_bitmap(ctl, info, &offset, &bytes, false);
+			if (ret == 0) {
+				bitmap_clear_bits(ctl, info, offset, bytes, true);
+				spin_unlock(&ctl->tree_lock);
 				ret = btrfs_add_free_space(block_group, offset,
 							   bytes);
-				if (ret)
-					break;
-				bitmap_clear_bits(ctl, info, offset, bytes, true);
-				offset = info->offset;
-				bytes = ctl->unit;
+				spin_lock(&ctl->tree_lock);
+			} else {
+				free_bitmap(ctl, info);
+				ret = 0;
 			}
-			free_bitmap(ctl, info);
 		}
-		cond_resched();
+		cond_resched_lock(&ctl->tree_lock);
 	}
 	return ret;
 }
@@ -1039,7 +1041,9 @@ int load_free_space_cache(struct btrfs_block_group *block_group)
 					  block_group->bytes_super));
 
 	if (matched) {
+		spin_lock(&tmp_ctl.tree_lock);
 		ret = copy_free_space_cache(block_group, &tmp_ctl);
+		spin_unlock(&tmp_ctl.tree_lock);
 		/*
 		 * ret == 1 means we successfully loaded the free space cache,
 		 * so we need to re-set it here.
@@ -1832,6 +1836,8 @@ static inline void unlink_free_space(struct btrfs_free_space_ctl *ctl,
 				     struct btrfs_free_space *info,
 				     bool update_stat)
 {
+	lockdep_assert_held(&ctl->tree_lock);
+
 	rb_erase(&info->offset_index, &ctl->free_space_offset);
 	rb_erase_cached(&info->bytes_index, &ctl->free_space_bytes);
 	ctl->free_extents--;
@@ -1881,6 +1887,8 @@ static void relink_bitmap_entry(struct btrfs_free_space_ctl *ctl,
 	if (RB_EMPTY_NODE(&info->bytes_index))
 		return;
 
+	lockdep_assert_held(&ctl->tree_lock);
+
 	rb_erase_cached(&info->bytes_index, &ctl->free_space_bytes);
 	rb_add_cached(&info->bytes_index, &ctl->free_space_bytes, entry_less);
 }
@@ -2991,8 +2999,11 @@ static void __btrfs_return_cluster_to_free_space(
 			     struct btrfs_block_group *block_group,
 			     struct btrfs_free_cluster *cluster)
 {
+	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
 	struct rb_node *node;
 
+	lockdep_assert_held(&ctl->tree_lock);
+
 	spin_lock(&cluster->lock);
 	if (cluster->block_group != block_group) {
 		spin_unlock(&cluster->lock);
@@ -3005,7 +3016,6 @@ static void __btrfs_return_cluster_to_free_space(
 
 	node = rb_first(&cluster->root);
 	while (node) {
-		struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
 		struct btrfs_free_space *entry;
 
 		entry = rb_entry(node, struct btrfs_free_space, offset_index);
@@ -3344,6 +3354,8 @@ static int btrfs_bitmap_cluster(struct btrfs_block_group *block_group,
 	unsigned long total_found = 0;
 	int ret;
 
+	lockdep_assert_held(&ctl->tree_lock);
+
 	i = offset_to_bit(entry->offset, ctl->unit,
 			  max_t(u64, offset, entry->offset));
 	want_bits = bytes_to_bits(bytes, ctl->unit);
@@ -3433,6 +3445,8 @@ setup_cluster_no_bitmap(struct btrfs_block_group *block_group,
 	u64 max_extent;
 	u64 total_size = 0;
 
+	lockdep_assert_held(&ctl->tree_lock);
+
 	entry = tree_search_offset(ctl, offset, 0, 1);
 	if (!entry)
 		return -ENOSPC;
-- 
2.35.1

