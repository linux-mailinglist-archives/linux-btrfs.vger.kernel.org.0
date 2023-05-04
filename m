Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360A96F697A
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 May 2023 13:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjEDLEu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 May 2023 07:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjEDLEk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 May 2023 07:04:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFCCE42
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 04:04:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4E5C6176A
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 11:04:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D7EC433D2
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 11:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683198276;
        bh=M3A+gurSB3Smm/xbx/c6zhm92Wbfh15vd00c/87XQu0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=A9BQWuTpxUmwTxWbdesYFayUZEyTG5nP0zbXDyDkFAXp3a4Fs5QSVj/HlMsb+IsyO
         5CDEvGMeW3i/f44olUzs8qmGmbssdz8WJu/D701bR3ekrl+/6RHisFTEO4iY4SYjHP
         8niAhobviV6t1licHF0GP9THps3xbdtuzUzwkFjcGeTgqayZYlDNCs2IUhkGH7iN//
         1KKd9Un+85wshROo+BdO1+B/DwtX6nedyaqr9wPeyGtHIBnZva4Go8UZhWBoRcuDuJ
         uRZ/62S7OHqelqGNMzEguzKW6OfLqhaC+pWpFGFSFBkVOyyXkZHIYYw+fU1aj1zshh
         LacQq42ug2GEg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/9] btrfs: simplify arguments to tree_insert_offset()
Date:   Thu,  4 May 2023 12:04:22 +0100
Message-Id: <d71237f8af1d78089de7f83e3c631a6f97a09f45.1683196407.git.fdmanana@suse.com>
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

For the in memory component of space caching (free space cache and free
space tree), three of the arguments passed to tree_insert_offset() can
always be taken from the new free space entry that we are about to add.

So simplify tree_insert_offset() to take the new entry instead of the
'offset', 'node' and 'bitmap' arguments. This will also allow to make
further changes simpler.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/free-space-cache.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index b16ed01c76ff..4cdc7d857158 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1598,20 +1598,21 @@ static inline u64 offset_to_bitmap(struct btrfs_free_space_ctl *ctl,
 	return bitmap_start;
 }
 
-static int tree_insert_offset(struct rb_root *root, u64 offset,
-			      struct rb_node *node, int bitmap)
+static int tree_insert_offset(struct rb_root *root,
+			      struct btrfs_free_space *new_entry)
 {
 	struct rb_node **p = &root->rb_node;
 	struct rb_node *parent = NULL;
-	struct btrfs_free_space *info;
 
 	while (*p) {
+		struct btrfs_free_space *info;
+
 		parent = *p;
 		info = rb_entry(parent, struct btrfs_free_space, offset_index);
 
-		if (offset < info->offset) {
+		if (new_entry->offset < info->offset) {
 			p = &(*p)->rb_left;
-		} else if (offset > info->offset) {
+		} else if (new_entry->offset > info->offset) {
 			p = &(*p)->rb_right;
 		} else {
 			/*
@@ -1627,7 +1628,7 @@ static int tree_insert_offset(struct rb_root *root, u64 offset,
 			 * found a bitmap, we want to go left, or before
 			 * logically.
 			 */
-			if (bitmap) {
+			if (new_entry->bitmap) {
 				if (info->bitmap) {
 					WARN_ON_ONCE(1);
 					return -EEXIST;
@@ -1643,8 +1644,8 @@ static int tree_insert_offset(struct rb_root *root, u64 offset,
 		}
 	}
 
-	rb_link_node(node, parent, p);
-	rb_insert_color(node, root);
+	rb_link_node(&new_entry->offset_index, parent, p);
+	rb_insert_color(&new_entry->offset_index, root);
 
 	return 0;
 }
@@ -1835,8 +1836,7 @@ static int link_free_space(struct btrfs_free_space_ctl *ctl,
 	int ret = 0;
 
 	ASSERT(info->bytes || info->bitmap);
-	ret = tree_insert_offset(&ctl->free_space_offset, info->offset,
-				 &info->offset_index, (info->bitmap != NULL));
+	ret = tree_insert_offset(&ctl->free_space_offset, info);
 	if (ret)
 		return ret;
 
@@ -2974,8 +2974,6 @@ static void __btrfs_return_cluster_to_free_space(
 			     struct btrfs_block_group *block_group,
 			     struct btrfs_free_cluster *cluster)
 {
-	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
-	struct btrfs_free_space *entry;
 	struct rb_node *node;
 
 	spin_lock(&cluster->lock);
@@ -2990,15 +2988,15 @@ static void __btrfs_return_cluster_to_free_space(
 
 	node = rb_first(&cluster->root);
 	while (node) {
-		bool bitmap;
+		struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
+		struct btrfs_free_space *entry;
 
 		entry = rb_entry(node, struct btrfs_free_space, offset_index);
 		node = rb_next(&entry->offset_index);
 		rb_erase(&entry->offset_index, &cluster->root);
 		RB_CLEAR_NODE(&entry->offset_index);
 
-		bitmap = (entry->bitmap != NULL);
-		if (!bitmap) {
+		if (!entry->bitmap) {
 			/* Merging treats extents as if they were new */
 			if (!btrfs_free_space_trimmed(entry)) {
 				ctl->discardable_extents[BTRFS_STAT_CURR]--;
@@ -3016,8 +3014,7 @@ static void __btrfs_return_cluster_to_free_space(
 					entry->bytes;
 			}
 		}
-		tree_insert_offset(&ctl->free_space_offset,
-				   entry->offset, &entry->offset_index, bitmap);
+		tree_insert_offset(&ctl->free_space_offset, entry);
 		rb_add_cached(&entry->bytes_index, &ctl->free_space_bytes,
 			      entry_less);
 	}
@@ -3391,8 +3388,7 @@ static int btrfs_bitmap_cluster(struct btrfs_block_group *block_group,
 	 */
 	RB_CLEAR_NODE(&entry->bytes_index);
 
-	ret = tree_insert_offset(&cluster->root, entry->offset,
-				 &entry->offset_index, 1);
+	ret = tree_insert_offset(&cluster->root, entry);
 	ASSERT(!ret); /* -EEXIST; Logic error */
 
 	trace_btrfs_setup_cluster(block_group, cluster,
@@ -3482,8 +3478,7 @@ setup_cluster_no_bitmap(struct btrfs_block_group *block_group,
 
 		rb_erase(&entry->offset_index, &ctl->free_space_offset);
 		rb_erase_cached(&entry->bytes_index, &ctl->free_space_bytes);
-		ret = tree_insert_offset(&cluster->root, entry->offset,
-					 &entry->offset_index, 0);
+		ret = tree_insert_offset(&cluster->root, entry);
 		total_size += entry->bytes;
 		ASSERT(!ret); /* -EEXIST; Logic error */
 	} while (node && entry != last);
-- 
2.35.1

