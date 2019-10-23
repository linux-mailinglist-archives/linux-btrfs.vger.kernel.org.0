Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 095A2E20EA
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2019 18:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbfJWQsD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 12:48:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:57006 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726359AbfJWQsD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 12:48:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7845FAD54;
        Wed, 23 Oct 2019 16:48:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A69C5DA734; Wed, 23 Oct 2019 18:48:13 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 2/6] btrfs: move block_group_item::flags to block group
Date:   Wed, 23 Oct 2019 18:48:13 +0200
Message-Id: <6d9dc41164cbe9197375c845f26a5707dfcc4734.1571848791.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1571848791.git.dsterba@suse.com>
References: <cover.1571848791.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The flags are read from the item that's embedded to block group struct,
but the item will be removed. Use the ::flags after read and before
write.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/block-group.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 4da5e0f6cb82..52e2a05c8345 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1755,7 +1755,7 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 		/* Duplicate as the item is still partially used */
 		memcpy(&cache->item, &bgi, sizeof(bgi));
 		cache->used = btrfs_block_group_used(&bgi);
-		cache->flags = btrfs_block_group_flags(&cache->item);
+		cache->flags = btrfs_block_group_flags(&bgi);
 		if (!mixed &&
 		    ((cache->flags & BTRFS_BLOCK_GROUP_METADATA) &&
 		    (cache->flags & BTRFS_BLOCK_GROUP_DATA))) {
@@ -1885,6 +1885,7 @@ void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)
 		 */
 		memcpy(&item, &block_group->item, sizeof(item));
 		btrfs_set_block_group_used(&item, block_group->used);
+		btrfs_set_block_group_flags(&item, block_group->flags);
 		memcpy(&key, &block_group->key, sizeof(key));
 		spin_unlock(&block_group->lock);
 
@@ -1920,8 +1921,6 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
 	cache->used = bytes_used;
 	btrfs_set_block_group_chunk_objectid(&cache->item,
 					     BTRFS_FIRST_CHUNK_TREE_OBJECTID);
-	btrfs_set_block_group_flags(&cache->item, type);
-
 	cache->flags = type;
 	cache->last_byte_to_unpin = (u64)-1;
 	cache->cached = BTRFS_CACHE_FINISHED;
@@ -2140,6 +2139,7 @@ static int write_one_cache_group(struct btrfs_trans_handle *trans,
 	/* Partial copy of item, update the rest from memory */
 	memcpy(&bgi, &cache->item, sizeof(bgi));
 	btrfs_set_block_group_used(&bgi, cache->used);
+	btrfs_set_block_group_flags(&bgi, cache->flags);
 	write_extent_buffer(leaf, &bgi, bi, sizeof(bgi));
 	btrfs_mark_buffer_dirty(leaf);
 fail:
-- 
2.23.0

