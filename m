Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94AE25393A0
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 May 2022 17:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345511AbiEaPHD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 May 2022 11:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345513AbiEaPG7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 May 2022 11:06:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE73DDBD
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 08:06:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C33A61343
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 15:06:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B669C3411D
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 15:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654009617;
        bh=1I0n3i6+SK34n0P2sJdyCZZJDMNdrmn158ujRCsCflc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=CROkw5qBOe6GatWth1EybncgMUpwyvysTg5JS7nz4J4NEuJ0VTdMJeufmJm+hQYLM
         HXazrOmpG+CbmemzVCvHcPUrJd27upoC8XtT1DZIU4s/XtZkIiirohb7BMUA+i4nqk
         VKQPsvcXqW9Z0XbbkVQ65/nHpORJWlvmgoXGzPu4ETAiUaviViRV0Tdysrz0RedoNu
         mR1DdTQbh0BetDI5IHQUnQzBbSrkItcynOVmnUBP/Oti4FtFTNXxp0/ZxAO1y989LK
         rtdUaQaJpcrp5amKoXqlcYwm8Mx0Eyb2d3ojnxNJt0EBaDKxuOyvu2qXJ1QleiJmuP
         /pZKiX09fVq+Q==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 11/12] btrfs: set delayed item type when initializing it
Date:   Tue, 31 May 2022 16:06:42 +0100
Message-Id: <5f892281a954183b1450d7479a5ac323fda9c039.1654009356.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1654009356.git.fdmanana@suse.com>
References: <cover.1654009356.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Currently we set the type of a delayed item only after successfully
inserting it into its respective rbtree. This is fine, as the type
is not used anywhere before that point, but for the next patch in the
series, there will be the need to check the type of a delayed item
before inserting it into a rbtree.

So set the type of a delayed item immediately after allocating it.
This also makes the trivial wrappers for adding insertion and deletion
useless, so it removes them as well.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-inode.c | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index b6fee8f0f1cd..814c20c90fe7 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -379,8 +379,7 @@ static struct btrfs_delayed_item *__btrfs_lookup_delayed_insertion_item(
 }
 
 static int __btrfs_add_delayed_item(struct btrfs_delayed_node *delayed_node,
-				    struct btrfs_delayed_item *ins,
-				    int action)
+				    struct btrfs_delayed_item *ins)
 {
 	struct rb_node **p, *node;
 	struct rb_node *parent_node = NULL;
@@ -389,9 +388,9 @@ static int __btrfs_add_delayed_item(struct btrfs_delayed_node *delayed_node,
 	int cmp;
 	bool leftmost = true;
 
-	if (action == BTRFS_DELAYED_INSERTION_ITEM)
+	if (ins->ins_or_del == BTRFS_DELAYED_INSERTION_ITEM)
 		root = &delayed_node->ins_root;
-	else if (action == BTRFS_DELAYED_DELETION_ITEM)
+	else if (ins->ins_or_del == BTRFS_DELAYED_DELETION_ITEM)
 		root = &delayed_node->del_root;
 	else
 		BUG();
@@ -417,12 +416,11 @@ static int __btrfs_add_delayed_item(struct btrfs_delayed_node *delayed_node,
 	rb_link_node(node, parent_node, p);
 	rb_insert_color_cached(node, root, leftmost);
 	ins->delayed_node = delayed_node;
-	ins->ins_or_del = action;
 
 	/* Delayed items are always for dir index items. */
 	ASSERT(ins->key.type == BTRFS_DIR_INDEX_KEY);
 
-	if (action == BTRFS_DELAYED_INSERTION_ITEM &&
+	if (ins->ins_or_del == BTRFS_DELAYED_INSERTION_ITEM &&
 	    ins->key.offset >= delayed_node->index_cnt)
 		delayed_node->index_cnt = ins->key.offset + 1;
 
@@ -431,20 +429,6 @@ static int __btrfs_add_delayed_item(struct btrfs_delayed_node *delayed_node,
 	return 0;
 }
 
-static int __btrfs_add_delayed_insertion_item(struct btrfs_delayed_node *node,
-					      struct btrfs_delayed_item *item)
-{
-	return __btrfs_add_delayed_item(node, item,
-					BTRFS_DELAYED_INSERTION_ITEM);
-}
-
-static int __btrfs_add_delayed_deletion_item(struct btrfs_delayed_node *node,
-					     struct btrfs_delayed_item *item)
-{
-	return __btrfs_add_delayed_item(node, item,
-					BTRFS_DELAYED_DELETION_ITEM);
-}
-
 static void finish_one_item(struct btrfs_delayed_root *delayed_root)
 {
 	int seq = atomic_inc_return(&delayed_root->items_seq);
@@ -1368,6 +1352,7 @@ int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
 	delayed_item->key.objectid = btrfs_ino(dir);
 	delayed_item->key.type = BTRFS_DIR_INDEX_KEY;
 	delayed_item->key.offset = index;
+	delayed_item->ins_or_del = BTRFS_DELAYED_INSERTION_ITEM;
 
 	dir_item = (struct btrfs_dir_item *)delayed_item->data;
 	dir_item->location = *disk_key;
@@ -1388,7 +1373,7 @@ int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
 	}
 
 	mutex_lock(&delayed_node->mutex);
-	ret = __btrfs_add_delayed_insertion_item(delayed_node, delayed_item);
+	ret = __btrfs_add_delayed_item(delayed_node, delayed_item);
 	if (unlikely(ret)) {
 		btrfs_err(trans->fs_info,
 			  "err add delayed dir index item(name: %.*s) into the insertion tree of the delayed node(root id: %llu, inode id: %llu, errno: %d)",
@@ -1450,6 +1435,7 @@ int btrfs_delete_delayed_dir_index(struct btrfs_trans_handle *trans,
 	}
 
 	item->key = item_key;
+	item->ins_or_del = BTRFS_DELAYED_DELETION_ITEM;
 
 	ret = btrfs_delayed_item_reserve_metadata(trans, dir->root, item);
 	/*
@@ -1464,7 +1450,7 @@ int btrfs_delete_delayed_dir_index(struct btrfs_trans_handle *trans,
 	}
 
 	mutex_lock(&node->mutex);
-	ret = __btrfs_add_delayed_deletion_item(node, item);
+	ret = __btrfs_add_delayed_item(node, item);
 	if (unlikely(ret)) {
 		btrfs_err(trans->fs_info,
 			  "err add delayed dir index item(index: %llu) into the deletion tree of the delayed node(root id: %llu, inode id: %llu, errno: %d)",
-- 
2.35.1

