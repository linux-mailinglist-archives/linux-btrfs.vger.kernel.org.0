Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F716F697F
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 May 2023 13:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjEDLEt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 May 2023 07:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjEDLEl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 May 2023 07:04:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174973C3D
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 04:04:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FA866176C
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 11:04:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EBFBC433EF
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 11:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683198277;
        bh=uMU/BpmrKjgJLDqlj9eTIHQvSNnLweR2Z1WdEbGiuUQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=EPmypvwWhkUalek52TnAP7fENk0IrO34NBg6Y9FOujQK/wKdwkzgWYp32IlJbkGEz
         wAOnkJNVqZgKiM0fSH59j9cSyG9gCNb9fduj2KAcoup2XH+qRpvkAdjx2UJOdCQYMr
         0nAgnA4sDyo8QLtH4T/gjrjYXMIftG8hFxZiS+tE8GNzjVPby1KEkLHbEzzCR/5JmY
         QQR3S7Mi3/0BV08oHGu9UPlhKUuo+5SPU5FLwIJ7lWT3++jR5B6yB2RD+8LuJgAv42
         dsqEGR41hUjR++4gDedN3nlp9pxydYE/b+XND2zxJ5RhQ3s+eu9GliPMnk0WVz0bz1
         lTzLZb8ILAbUA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 6/9] btrfs: assert proper locks are held at tree_insert_offset()
Date:   Thu,  4 May 2023 12:04:23 +0100
Message-Id: <19d432471a2a0c856fc1fc64a3ae683f23444148.1683196407.git.fdmanana@suse.com>
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

There are multiple code paths leading to tree_insert_offset(), and each
path takes the necessary locks before tree_insert_offset() is called,
since they do other things that require those locks to be held. This makes
it easy to miss the locking somewhere, so make tree_insert_offset() assert
that the required locks are being held by the calling task.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/free-space-cache.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 4cdc7d857158..31d9bb958dc7 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1598,12 +1598,25 @@ static inline u64 offset_to_bitmap(struct btrfs_free_space_ctl *ctl,
 	return bitmap_start;
 }
 
-static int tree_insert_offset(struct rb_root *root,
+static int tree_insert_offset(struct btrfs_free_space_ctl *ctl,
+			      struct btrfs_free_cluster *cluster,
 			      struct btrfs_free_space *new_entry)
 {
-	struct rb_node **p = &root->rb_node;
+	struct rb_root *root;
+	struct rb_node **p;
 	struct rb_node *parent = NULL;
 
+	lockdep_assert_held(&ctl->tree_lock);
+
+	if (cluster) {
+		lockdep_assert_held(&cluster->lock);
+		root = &cluster->root;
+	} else {
+		root = &ctl->free_space_offset;
+	}
+
+	p = &root->rb_node;
+
 	while (*p) {
 		struct btrfs_free_space *info;
 
@@ -1836,7 +1849,7 @@ static int link_free_space(struct btrfs_free_space_ctl *ctl,
 	int ret = 0;
 
 	ASSERT(info->bytes || info->bitmap);
-	ret = tree_insert_offset(&ctl->free_space_offset, info);
+	ret = tree_insert_offset(ctl, NULL, info);
 	if (ret)
 		return ret;
 
@@ -3014,7 +3027,7 @@ static void __btrfs_return_cluster_to_free_space(
 					entry->bytes;
 			}
 		}
-		tree_insert_offset(&ctl->free_space_offset, entry);
+		tree_insert_offset(ctl, NULL, entry);
 		rb_add_cached(&entry->bytes_index, &ctl->free_space_bytes,
 			      entry_less);
 	}
@@ -3388,7 +3401,7 @@ static int btrfs_bitmap_cluster(struct btrfs_block_group *block_group,
 	 */
 	RB_CLEAR_NODE(&entry->bytes_index);
 
-	ret = tree_insert_offset(&cluster->root, entry);
+	ret = tree_insert_offset(ctl, cluster, entry);
 	ASSERT(!ret); /* -EEXIST; Logic error */
 
 	trace_btrfs_setup_cluster(block_group, cluster,
@@ -3478,7 +3491,7 @@ setup_cluster_no_bitmap(struct btrfs_block_group *block_group,
 
 		rb_erase(&entry->offset_index, &ctl->free_space_offset);
 		rb_erase_cached(&entry->bytes_index, &ctl->free_space_bytes);
-		ret = tree_insert_offset(&cluster->root, entry);
+		ret = tree_insert_offset(ctl, cluster, entry);
 		total_size += entry->bytes;
 		ASSERT(!ret); /* -EEXIST; Logic error */
 	} while (node && entry != last);
-- 
2.35.1

