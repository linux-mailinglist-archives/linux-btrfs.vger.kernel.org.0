Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1457BE20EB
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2019 18:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfJWQsF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 12:48:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:57022 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726352AbfJWQsE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 12:48:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8A729ACD8;
        Wed, 23 Oct 2019 16:48:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EE986DA734; Wed, 23 Oct 2019 18:48:15 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 3/6] btrfs: remove embedded block_group_cache::item
Date:   Wed, 23 Oct 2019 18:48:15 +0200
Message-Id: <925c46538656d1b46146e09d19882e9c5038658c.1571848791.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1571848791.git.dsterba@suse.com>
References: <cover.1571848791.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The members ::used and ::flags are now in the block group cache
structure, the last one is chunk_objectid, but that's set to a fixed
value and otherwise unused. The item is constructed from a local
variable before write, so we can remove the embedded one from block
group.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/block-group.c | 16 +++++-----------
 fs/btrfs/block-group.h |  1 -
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 52e2a05c8345..0bb1cc5f3263 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1752,8 +1752,7 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 		read_extent_buffer(leaf, &bgi,
 				   btrfs_item_ptr_offset(leaf, path->slots[0]),
 				   sizeof(bgi));
-		/* Duplicate as the item is still partially used */
-		memcpy(&cache->item, &bgi, sizeof(bgi));
+		/* cache::chunk_objectid is unused */
 		cache->used = btrfs_block_group_used(&bgi);
 		cache->flags = btrfs_block_group_flags(&bgi);
 		if (!mixed &&
@@ -1879,12 +1878,9 @@ void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)
 			goto next;
 
 		spin_lock(&block_group->lock);
-		/*
-		 * Copy partially filled item from the cache and ovewrite used
-		 * that has the correct value
-		 */
-		memcpy(&item, &block_group->item, sizeof(item));
 		btrfs_set_block_group_used(&item, block_group->used);
+		btrfs_set_block_group_chunk_objectid(&item,
+				BTRFS_FIRST_CHUNK_TREE_OBJECTID);
 		btrfs_set_block_group_flags(&item, block_group->flags);
 		memcpy(&key, &block_group->key, sizeof(key));
 		spin_unlock(&block_group->lock);
@@ -1919,8 +1915,6 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
 		return -ENOMEM;
 
 	cache->used = bytes_used;
-	btrfs_set_block_group_chunk_objectid(&cache->item,
-					     BTRFS_FIRST_CHUNK_TREE_OBJECTID);
 	cache->flags = type;
 	cache->last_byte_to_unpin = (u64)-1;
 	cache->cached = BTRFS_CACHE_FINISHED;
@@ -2136,9 +2130,9 @@ static int write_one_cache_group(struct btrfs_trans_handle *trans,
 
 	leaf = path->nodes[0];
 	bi = btrfs_item_ptr_offset(leaf, path->slots[0]);
-	/* Partial copy of item, update the rest from memory */
-	memcpy(&bgi, &cache->item, sizeof(bgi));
 	btrfs_set_block_group_used(&bgi, cache->used);
+	btrfs_set_block_group_chunk_objectid(&bgi,
+			BTRFS_FIRST_CHUNK_TREE_OBJECTID);
 	btrfs_set_block_group_flags(&bgi, cache->flags);
 	write_extent_buffer(leaf, &bgi, bi, sizeof(bgi));
 	btrfs_mark_buffer_dirty(leaf);
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 8fa4a70228ee..d78fce7cd3a4 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -44,7 +44,6 @@ struct btrfs_caching_control {
 
 struct btrfs_block_group_cache {
 	struct btrfs_key key;
-	struct btrfs_block_group_item item;
 	struct btrfs_fs_info *fs_info;
 	struct inode *inode;
 	spinlock_t lock;
-- 
2.23.0

