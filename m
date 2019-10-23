Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF43E20EC
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2019 18:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfJWQsI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 12:48:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:57036 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726352AbfJWQsH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 12:48:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D3382AD54;
        Wed, 23 Oct 2019 16:48:05 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 419A9DA734; Wed, 23 Oct 2019 18:48:18 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 4/6] btrfs: rename block_group_item on-stack accessors to follow naming
Date:   Wed, 23 Oct 2019 18:48:18 +0200
Message-Id: <ef0d23acaf30f86cc54321e81c338bef72f9cd2c.1571848791.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1571848791.git.dsterba@suse.com>
References: <cover.1571848791.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

All accessors defined by BTRFS_SETGET_STACK_FUNCS contain _stack_ in the
name, the block group ones were not following that scheme, so let's
switch them.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/block-group.c  | 18 +++++++++---------
 fs/btrfs/ctree.h        |  6 +++---
 fs/btrfs/tree-checker.c | 10 +++++-----
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 0bb1cc5f3263..3957b1817385 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1474,7 +1474,7 @@ static int find_first_block_group(struct btrfs_fs_info *fs_info,
 				read_extent_buffer(leaf, &bg,
 					btrfs_item_ptr_offset(leaf, slot),
 					sizeof(bg));
-				flags = btrfs_block_group_flags(&bg) &
+				flags = btrfs_stack_block_group_flags(&bg) &
 					BTRFS_BLOCK_GROUP_TYPE_MASK;
 
 				if (flags != (em->map_lookup->type &
@@ -1753,8 +1753,8 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 				   btrfs_item_ptr_offset(leaf, path->slots[0]),
 				   sizeof(bgi));
 		/* cache::chunk_objectid is unused */
-		cache->used = btrfs_block_group_used(&bgi);
-		cache->flags = btrfs_block_group_flags(&bgi);
+		cache->used = btrfs_stack_block_group_used(&bgi);
+		cache->flags = btrfs_stack_block_group_flags(&bgi);
 		if (!mixed &&
 		    ((cache->flags & BTRFS_BLOCK_GROUP_METADATA) &&
 		    (cache->flags & BTRFS_BLOCK_GROUP_DATA))) {
@@ -1878,10 +1878,10 @@ void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)
 			goto next;
 
 		spin_lock(&block_group->lock);
-		btrfs_set_block_group_used(&item, block_group->used);
-		btrfs_set_block_group_chunk_objectid(&item,
+		btrfs_set_stack_block_group_used(&item, block_group->used);
+		btrfs_set_stack_block_group_chunk_objectid(&item,
 				BTRFS_FIRST_CHUNK_TREE_OBJECTID);
-		btrfs_set_block_group_flags(&item, block_group->flags);
+		btrfs_set_stack_block_group_flags(&item, block_group->flags);
 		memcpy(&key, &block_group->key, sizeof(key));
 		spin_unlock(&block_group->lock);
 
@@ -2130,10 +2130,10 @@ static int write_one_cache_group(struct btrfs_trans_handle *trans,
 
 	leaf = path->nodes[0];
 	bi = btrfs_item_ptr_offset(leaf, path->slots[0]);
-	btrfs_set_block_group_used(&bgi, cache->used);
-	btrfs_set_block_group_chunk_objectid(&bgi,
+	btrfs_set_stack_block_group_used(&bgi, cache->used);
+	btrfs_set_stack_block_group_chunk_objectid(&bgi,
 			BTRFS_FIRST_CHUNK_TREE_OBJECTID);
-	btrfs_set_block_group_flags(&bgi, cache->flags);
+	btrfs_set_stack_block_group_flags(&bgi, cache->flags);
 	write_extent_buffer(leaf, &bgi, bi, sizeof(bgi));
 	btrfs_mark_buffer_dirty(leaf);
 fail:
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index d5c9fbe32c0c..09f404ce70fd 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1519,18 +1519,18 @@ static inline u64 btrfs_stripe_devid_nr(struct extent_buffer *eb,
 }
 
 /* struct btrfs_block_group_item */
-BTRFS_SETGET_STACK_FUNCS(block_group_used, struct btrfs_block_group_item,
+BTRFS_SETGET_STACK_FUNCS(stack_block_group_used, struct btrfs_block_group_item,
 			 used, 64);
 BTRFS_SETGET_FUNCS(disk_block_group_used, struct btrfs_block_group_item,
 			 used, 64);
-BTRFS_SETGET_STACK_FUNCS(block_group_chunk_objectid,
+BTRFS_SETGET_STACK_FUNCS(stack_block_group_chunk_objectid,
 			struct btrfs_block_group_item, chunk_objectid, 64);
 
 BTRFS_SETGET_FUNCS(disk_block_group_chunk_objectid,
 		   struct btrfs_block_group_item, chunk_objectid, 64);
 BTRFS_SETGET_FUNCS(disk_block_group_flags,
 		   struct btrfs_block_group_item, flags, 64);
-BTRFS_SETGET_STACK_FUNCS(block_group_flags,
+BTRFS_SETGET_STACK_FUNCS(stack_block_group_flags,
 			struct btrfs_block_group_item, flags, 64);
 
 /* struct btrfs_free_space_info */
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index df7a12056dd2..623354468dce 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -512,23 +512,23 @@ static int check_block_group_item(struct extent_buffer *leaf,
 
 	read_extent_buffer(leaf, &bgi, btrfs_item_ptr_offset(leaf, slot),
 			   sizeof(bgi));
-	if (btrfs_block_group_chunk_objectid(&bgi) !=
+	if (btrfs_stack_block_group_chunk_objectid(&bgi) !=
 	    BTRFS_FIRST_CHUNK_TREE_OBJECTID) {
 		block_group_err(leaf, slot,
 		"invalid block group chunk objectid, have %llu expect %llu",
-				btrfs_block_group_chunk_objectid(&bgi),
+				btrfs_stack_block_group_chunk_objectid(&bgi),
 				BTRFS_FIRST_CHUNK_TREE_OBJECTID);
 		return -EUCLEAN;
 	}
 
-	if (btrfs_block_group_used(&bgi) > key->offset) {
+	if (btrfs_stack_block_group_used(&bgi) > key->offset) {
 		block_group_err(leaf, slot,
 			"invalid block group used, have %llu expect [0, %llu)",
-				btrfs_block_group_used(&bgi), key->offset);
+				btrfs_stack_block_group_used(&bgi), key->offset);
 		return -EUCLEAN;
 	}
 
-	flags = btrfs_block_group_flags(&bgi);
+	flags = btrfs_stack_block_group_flags(&bgi);
 	if (hweight64(flags & BTRFS_BLOCK_GROUP_PROFILE_MASK) > 1) {
 		block_group_err(leaf, slot,
 "invalid profile flags, have 0x%llx (%lu bits set) expect no more than 1 bit set",
-- 
2.23.0

