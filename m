Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2866ABB60
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Mar 2023 11:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjCFKOn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Mar 2023 05:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjCFKOO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Mar 2023 05:14:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1102100
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Mar 2023 02:13:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDF1560D36
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Mar 2023 10:13:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF623C433D2
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Mar 2023 10:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678097619;
        bh=gfN7nUf9CRMJoaHFQzS3UpdDDvYU7BgHDrskUFaGulg=;
        h=From:To:Subject:Date:From;
        b=q/AnJFvveDtBepkO3cx/r1w5BXwUd2mcD3Iu2/uv3eIdx9KKCVNFmDVNfK9wgQdmc
         Dw1tp49hRRcdYJjXTddLvvYgRZQ8UAA04/VbItOQuOXFp2nn+6RYgliCTOfR1lSmBO
         P+aZOTOBweBI4qSpgofUJY4+G39WMsAiucP7+/nL/dQIYMiO/1UzDp+pl+vG6h+SL9
         2Kz4lNfq+hZGv2hNl21TQ+C2av2Qp8C613ScCQ9u34magVF94h/6Jhxc5uusC89FtM
         UfRM9JeUajgqS4kdgrlhnrQclqSM+Yev14e4f1zElYnVq70Mx2iG9Cq/rkdgzr0ghT
         3A8a9cakNMloQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix block group item corruption after inserting new block group
Date:   Mon,  6 Mar 2023 10:13:34 +0000
Message-Id: <257397e78b93bcb888daec01c1e02be87cd4dee7.1678097398.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
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

We can often end up inserting a block group item, for a new block group,
with a wrong value for the used bytes field.

This happens if for the new allocated block group, in the same transaction
that created the block group, we have tasks allocating extents from it as
well as tasks removing extents from it.

For example:

1) Task A creates a metadata block group X;

2) Two extents are allocated from block group X, so its "used" field is
   updated to 32K, and its "commit_used" field remains as 0;

3) Transaction commit starts, by some task B, and it enters
   btrfs_start_dirty_block_groups(). There it tries to update the block
   group item for block group X, which currently has its "used" field with
   a value of 32K. But that fails since the block group item was not yet
   inserted, and so on failure update_block_group_item() sets the
   "commit_used" field of the block group back to 0;

4) The block group item is inserted by task A, when for example
   btrfs_create_pending_block_groups() is called when releasing its
   transaction handle. This results in insert_block_group_item() inserting
   the block group item in the extent tree (or block group tree), with a
   "used" field having a value of 32K, but without updating the
   "commit_used" field in the block group, which remains with value of 0;

5) The two extents are freed from block X, so its "used" field changes
   from 32K to 0;

6) The transaction commit by task B continues, it enters
   btrfs_write_dirty_block_groups() which calls update_block_group_item()
   for block group X, and there it decides to skip the block group item
   update, because "used" has a value of 0 and "commit_used" has a value
   of 0 too.

   As a result, we end up with a block item having a 32K "used" field but
   no extents allocated from it.

When this issue happens, a btrfs check reports an error like this:

   [1/7] checking root items
   [2/7] checking extents
   block group [1104150528 1073741824] used 39796736 but extent items used 0
   ERROR: errors found in extent allocation tree or chunk allocation
   (...)

Fix this by making insert_block_group_item() update the block group's
"commit_used" field.

Fixes: 7248e0cebbef ("btrfs: skip update of block group item if used bytes are the same")
CC: stable@vger.kernel.org # 6.2+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index fd11d03a50ff..953e9547ca07 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2493,18 +2493,29 @@ static int insert_block_group_item(struct btrfs_trans_handle *trans,
 	struct btrfs_block_group_item bgi;
 	struct btrfs_root *root = btrfs_block_group_root(fs_info);
 	struct btrfs_key key;
+	u64 old_commit_used;
+	int ret;
 
 	spin_lock(&block_group->lock);
 	btrfs_set_stack_block_group_used(&bgi, block_group->used);
 	btrfs_set_stack_block_group_chunk_objectid(&bgi,
 						   block_group->global_root_id);
 	btrfs_set_stack_block_group_flags(&bgi, block_group->flags);
+	old_commit_used = block_group->commit_used;
+	block_group->commit_used = block_group->used;
 	key.objectid = block_group->start;
 	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
 	key.offset = block_group->length;
 	spin_unlock(&block_group->lock);
 
-	return btrfs_insert_item(trans, root, &key, &bgi, sizeof(bgi));
+	ret = btrfs_insert_item(trans, root, &key, &bgi, sizeof(bgi));
+	if (ret < 0) {
+		spin_lock(&block_group->lock);
+		block_group->commit_used = old_commit_used;
+		spin_unlock(&block_group->lock);
+	}
+
+	return ret;
 }
 
 static int insert_dev_extent(struct btrfs_trans_handle *trans,
-- 
2.34.1

