Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0CF9EF2DE
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Nov 2019 02:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387409AbfKEBfo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Nov 2019 20:35:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:48532 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728602AbfKEBfn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 Nov 2019 20:35:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 587F5B24A
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Nov 2019 01:35:42 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.cz
Subject: [PATCH 2/2] btrfs: block-group: Reuse the item key from caller of read_one_block_group()
Date:   Tue,  5 Nov 2019 09:35:35 +0800
Message-Id: <20191105013535.14239-3-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191105013535.14239-1-wqu@suse.com>
References: <20191105013535.14239-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For read_one_block_group(), its only caller has already got the item key
to search next block group item.

So we can use that key directly without doing our own convertion on
stack.

Also, since that key used in btrfs_read_block_groups() is vital for
block group item search, add 'const' keyword for that parameter to
prevent read_one_block_group() to modify it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/block-group.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index c2bd85d29070..a2970de7833e 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1679,21 +1679,20 @@ static int check_chunk_block_group_mappings(struct btrfs_fs_info *fs_info)
 
 static int read_one_block_group(struct btrfs_fs_info *info,
 				struct btrfs_path *path,
+				const struct btrfs_key *key,
 				int need_clear)
 {
 	struct extent_buffer *leaf = path->nodes[0];
 	struct btrfs_block_group_cache *cache;
 	struct btrfs_space_info *space_info;
-	struct btrfs_key key;
 	struct btrfs_block_group_item bgi;
 	const bool mixed = btrfs_fs_incompat(info, MIXED_GROUPS);
 	int slot = path->slots[0];
 	int ret;
 
-	btrfs_item_key_to_cpu(leaf, &key, slot);
-	ASSERT(key.type == BTRFS_BLOCK_GROUP_ITEM_KEY);
+	ASSERT(key->type == BTRFS_BLOCK_GROUP_ITEM_KEY);
 
-	cache = btrfs_create_block_group_cache(info, key.objectid, key.offset);
+	cache = btrfs_create_block_group_cache(info, key->objectid, key->offset);
 	if (!cache)
 		return -ENOMEM;
 
@@ -1742,15 +1741,15 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 	 * are empty, and we can just add all the space in and be done with it.
 	 * This saves us _a_lot_ of time, particularly in the full case.
 	 */
-	if (key.offset == cache->used) {
+	if (key->offset == cache->used) {
 		cache->last_byte_to_unpin = (u64)-1;
 		cache->cached = BTRFS_CACHE_FINISHED;
 		btrfs_free_excluded_extents(cache);
 	} else if (cache->used == 0) {
 		cache->last_byte_to_unpin = (u64)-1;
 		cache->cached = BTRFS_CACHE_FINISHED;
-		add_new_free_space(cache, key.objectid,
-				   key.objectid + key.offset);
+		add_new_free_space(cache, key->objectid,
+				   key->objectid + key->offset);
 		btrfs_free_excluded_extents(cache);
 	}
 
@@ -1760,7 +1759,7 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 		goto error;
 	}
 	trace_btrfs_add_block_group(info, cache, 0);
-	btrfs_update_space_info(info, cache->flags, key.offset,
+	btrfs_update_space_info(info, cache->flags, key->offset,
 				cache->used, cache->bytes_super, &space_info);
 
 	cache->space_info = space_info;
@@ -1813,7 +1812,7 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 			goto error;
 
 		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
-		ret = read_one_block_group(info, path, need_clear);
+		ret = read_one_block_group(info, path, &key, need_clear);
 		if (ret < 0)
 			goto error;
 		key.objectid += key.offset;
-- 
2.23.0

