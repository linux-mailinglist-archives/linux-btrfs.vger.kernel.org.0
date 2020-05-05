Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A351C4AD2
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 May 2020 02:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbgEEACn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 May 2020 20:02:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:38750 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728223AbgEEACm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 May 2020 20:02:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 55184AF01
        for <linux-btrfs@vger.kernel.org>; Tue,  5 May 2020 00:02:43 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 04/11] btrfs-progs: block-group: Refactor how we insert a block group item
Date:   Tue,  5 May 2020 08:02:23 +0800
Message-Id: <20200505000230.4454-5-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200505000230.4454-1-wqu@suse.com>
References: <20200505000230.4454-1-wqu@suse.com>
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
 extent-tree.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/extent-tree.c b/extent-tree.c
index 3de95052a645..911fd25f3c6e 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -2804,6 +2804,26 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans,
 	return 0;
 }
 
+static int insert_block_group_item(struct btrfs_trans_handle *trans,
+				   struct btrfs_block_group *block_group)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_block_group_item bgi;
+	struct btrfs_root *root;
+	struct btrfs_key key;
+
+	btrfs_set_stack_block_group_used(&bgi, block_group->used);
+	btrfs_set_stack_block_group_chunk_objectid(&bgi,
+				BTRFS_FIRST_CHUNK_TREE_OBJECTID);
+	btrfs_set_stack_block_group_flags(&bgi, block_group->flags);
+	key.objectid = block_group->start;
+	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
+	key.offset = block_group->length;
+
+	root = fs_info->extent_root;
+	return btrfs_insert_item(trans, root, &key, &bgi, sizeof(bgi));
+}
+
 /*
  * This is for converter use only.
  *
@@ -2822,7 +2842,6 @@ int btrfs_make_block_groups(struct btrfs_trans_handle *trans,
 	u64 total_data = 0;
 	u64 total_metadata = 0;
 	int ret;
-	struct btrfs_root *extent_root = fs_info->extent_root;
 	struct btrfs_block_group *cache;
 
 	total_bytes = btrfs_super_total_bytes(fs_info->super_copy);
@@ -2873,21 +2892,10 @@ int btrfs_make_block_groups(struct btrfs_trans_handle *trans,
 	/* then insert all the items */
 	cur_start = 0;
 	while(cur_start < total_bytes) {
-		struct btrfs_block_group_item bgi;
-		struct btrfs_key key;
-
 		cache = btrfs_lookup_block_group(fs_info, cur_start);
 		BUG_ON(!cache);
 
-		btrfs_set_stack_block_group_used(&bgi, cache->used);
-		btrfs_set_stack_block_group_flags(&bgi, cache->flags);
-		btrfs_set_stack_block_group_chunk_objectid(&bgi,
-				BTRFS_FIRST_CHUNK_TREE_OBJECTID);
-		key.objectid = cache->start;
-		key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
-		key.offset = cache->length;
-		ret = btrfs_insert_item(trans, extent_root, &key, &bgi,
-					sizeof(bgi));
+		ret = insert_block_group_item(trans, cache);
 		BUG_ON(ret);
 
 		cur_start = cache->start + cache->length;
-- 
2.26.2

