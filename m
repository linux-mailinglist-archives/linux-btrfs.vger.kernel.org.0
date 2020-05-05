Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92F41C4AD0
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 May 2020 02:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbgEEACj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 May 2020 20:02:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:38722 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728223AbgEEACj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 May 2020 20:02:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A8DABAEE7
        for <linux-btrfs@vger.kernel.org>; Tue,  5 May 2020 00:02:39 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 02/11] btrfs-progs: block-group: Refactor how we read one block group item
Date:   Tue,  5 May 2020 08:02:21 +0800
Message-Id: <20200505000230.4454-3-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200505000230.4454-1-wqu@suse.com>
References: <20200505000230.4454-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Structure btrfs_block_group has the following members which are
currently read from on-disk block group item and key:
- Length
  From item key.
- Used
- Flags
  From block group item.

However for incoming skinny block group tree, we are going to read those
members from different sources.

This patch will refactor such read by:
- Refactor length/used/flags initialization into one function
  The new function, fill_one_block_group() will handle the
  initialization of such members.

- Use btrfs_block_group::length to replace key::offset
  Since skinny block group item would have a different meaning for its
  key offset.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 extent-tree.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/extent-tree.c b/extent-tree.c
index bd7dbf551876..5fc4308336dd 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -172,6 +172,7 @@ static int btrfs_add_block_group_cache(struct btrfs_fs_info *info,
 	struct rb_node *parent = NULL;
 	struct btrfs_block_group *cache;
 
+	ASSERT(block_group->length != 0);
 	p = &info->block_group_cache_tree.rb_node;
 
 	while (*p) {
@@ -2630,6 +2631,27 @@ error:
 	return ret;
 }
 
+static int read_block_group_item(struct btrfs_block_group *cache,
+				 struct btrfs_path *path,
+				 const struct btrfs_key *key)
+{
+	struct extent_buffer *leaf = path->nodes[0];
+	struct btrfs_block_group_item bgi;
+	int slot = path->slots[0];
+
+	ASSERT(key->type == BTRFS_BLOCK_GROUP_ITEM_KEY);
+
+	cache->start = key->objectid;
+	cache->length = key->offset;
+
+	read_extent_buffer(leaf, &bgi, btrfs_item_ptr_offset(leaf, slot),
+			   sizeof(bgi));
+	cache->used = btrfs_stack_block_group_used(&bgi);
+	cache->flags = btrfs_stack_block_group_flags(&bgi);
+
+	return 0;
+}
+
 /*
  * Read out one BLOCK_GROUP_ITEM and insert it into block group cache.
  *
@@ -2642,7 +2664,6 @@ static int read_one_block_group(struct btrfs_fs_info *fs_info,
 	struct extent_buffer *leaf = path->nodes[0];
 	struct btrfs_space_info *space_info;
 	struct btrfs_block_group *cache;
-	struct btrfs_block_group_item bgi;
 	struct btrfs_key key;
 	int slot = path->slots[0];
 	int ret;
@@ -2660,14 +2681,11 @@ static int read_one_block_group(struct btrfs_fs_info *fs_info,
 	cache = kzalloc(sizeof(*cache), GFP_NOFS);
 	if (!cache)
 		return -ENOMEM;
-	read_extent_buffer(leaf, &bgi, btrfs_item_ptr_offset(leaf, slot),
-			   sizeof(bgi));
-	cache->start = key.objectid;
-	cache->length = key.offset;
-	cache->cached = 0;
-	cache->pinned = 0;
-	cache->flags = btrfs_stack_block_group_flags(&bgi);
-	cache->used = btrfs_stack_block_group_used(&bgi);
+	ret = read_block_group_item(cache, path, &key);
+	if (ret < 0) {
+		free(cache);
+		return ret;
+	}
 	INIT_LIST_HEAD(&cache->dirty_list);
 
 	set_avail_alloc_bits(fs_info, cache->flags);
-- 
2.26.2

