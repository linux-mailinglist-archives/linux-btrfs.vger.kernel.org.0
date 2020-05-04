Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E431C4AC8
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 May 2020 01:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbgEDX6i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 May 2020 19:58:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:37914 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728278AbgEDX6i (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 May 2020 19:58:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C667EABAD
        for <linux-btrfs@vger.kernel.org>; Mon,  4 May 2020 23:58:38 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 4/7] btrfs: block-group: Refactor how we insert a block group item
Date:   Tue,  5 May 2020 07:58:22 +0800
Message-Id: <20200504235825.4199-5-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504235825.4199-1-wqu@suse.com>
References: <20200504235825.4199-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently the block group item insert is pretty straight forward, fill
the block group item structure and insert it into extent tree.

However the incoming skinny block group feature is going to change this,
so this patch will refactor such insert into a new function,
insert_block_group_item(), to make the incoming feature easier to add.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/block-group.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 914b1c2064ac..93e7835ca79d 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2068,13 +2068,32 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 	return ret;
 }
 
+static int insert_block_group_item(struct btrfs_trans_handle *trans,
+				   struct btrfs_block_group *block_group)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_block_group_item bgi;
+	struct btrfs_root *root;
+	struct btrfs_key key;
+
+	spin_lock(&block_group->lock);
+	btrfs_set_stack_block_group_used(&bgi, block_group->used);
+	btrfs_set_stack_block_group_chunk_objectid(&bgi,
+				BTRFS_FIRST_CHUNK_TREE_OBJECTID);
+	btrfs_set_stack_block_group_flags(&bgi, block_group->flags);
+	key.objectid = block_group->start;
+	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
+	key.offset = block_group->length;
+	spin_unlock(&block_group->lock);
+
+	root = fs_info->extent_root;
+	return btrfs_insert_item(trans, root, &key, &bgi, sizeof(bgi));
+}
+
 void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_block_group *block_group;
-	struct btrfs_root *extent_root = fs_info->extent_root;
-	struct btrfs_block_group_item item;
-	struct btrfs_key key;
 	int ret = 0;
 
 	if (!trans->can_flush_pending_bgs)
@@ -2087,21 +2106,11 @@ void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)
 		if (ret)
 			goto next;
 
-		spin_lock(&block_group->lock);
-		btrfs_set_stack_block_group_used(&item, block_group->used);
-		btrfs_set_stack_block_group_chunk_objectid(&item,
-				BTRFS_FIRST_CHUNK_TREE_OBJECTID);
-		btrfs_set_stack_block_group_flags(&item, block_group->flags);
-		key.objectid = block_group->start;
-		key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
-		key.offset = block_group->length;
-		spin_unlock(&block_group->lock);
-
-		ret = btrfs_insert_item(trans, extent_root, &key, &item,
-					sizeof(item));
+		ret = insert_block_group_item(trans, block_group);
 		if (ret)
 			btrfs_abort_transaction(trans, ret);
-		ret = btrfs_finish_chunk_alloc(trans, key.objectid, key.offset);
+		ret = btrfs_finish_chunk_alloc(trans, block_group->start,
+					block_group->length);
 		if (ret)
 			btrfs_abort_transaction(trans, ret);
 		add_block_group_free_space(trans, block_group);
-- 
2.26.2

