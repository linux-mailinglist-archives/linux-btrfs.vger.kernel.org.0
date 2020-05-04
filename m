Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B351C4AC9
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 May 2020 01:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbgEDX6l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 May 2020 19:58:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:37920 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728278AbgEDX6k (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 May 2020 19:58:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 75A5AAEB9
        for <linux-btrfs@vger.kernel.org>; Mon,  4 May 2020 23:58:40 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 5/7] btrfs: block-group: Rename write_one_cahce_group()
Date:   Tue,  5 May 2020 07:58:23 +0800
Message-Id: <20200504235825.4199-6-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504235825.4199-1-wqu@suse.com>
References: <20200504235825.4199-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The name of this function contains the word "cache", which is left from
the era where btrfs_block_group is called btrfs_block_group_cache.

Now this "cache" doesn't match any thing, and we have better namings for
functions like read/insert/remove_block_group_item().

So rename this function to update_block_group_item().

Since we're here, also rename the local variables to be more like a
Chrismas tree, and rename @extent_root to @root for later reuse.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/block-group.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 93e7835ca79d..46846749b631 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2346,23 +2346,24 @@ void btrfs_dec_block_group_ro(struct btrfs_block_group *cache)
 	spin_unlock(&sinfo->lock);
 }
 
-static int write_one_cache_group(struct btrfs_trans_handle *trans,
-				 struct btrfs_path *path,
-				 struct btrfs_block_group *cache)
+static int update_block_group_item(struct btrfs_trans_handle *trans,
+				   struct btrfs_path *path,
+				   struct btrfs_block_group *cache)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	int ret;
-	struct btrfs_root *extent_root = fs_info->extent_root;
-	unsigned long bi;
-	struct extent_buffer *leaf;
 	struct btrfs_block_group_item bgi;
+	struct extent_buffer *leaf;
+	struct btrfs_root *root;
 	struct btrfs_key key;
+	unsigned long bi;
+	int ret;
 
 	key.objectid = cache->start;
 	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
 	key.offset = cache->length;
+	root = fs_info->extent_root;
 
-	ret = btrfs_search_slot(trans, extent_root, &key, path, 0, 1);
+	ret = btrfs_search_slot(trans, root, &key, path, 0, 1);
 	if (ret) {
 		if (ret > 0)
 			ret = -ENOENT;
@@ -2674,7 +2675,7 @@ int btrfs_start_dirty_block_groups(struct btrfs_trans_handle *trans)
 			}
 		}
 		if (!ret) {
-			ret = write_one_cache_group(trans, path, cache);
+			ret = update_block_group_item(trans, path, cache);
 			/*
 			 * Our block group might still be attached to the list
 			 * of new block groups in the transaction handle of some
@@ -2823,7 +2824,7 @@ int btrfs_write_dirty_block_groups(struct btrfs_trans_handle *trans)
 			}
 		}
 		if (!ret) {
-			ret = write_one_cache_group(trans, path, cache);
+			ret = update_block_group_item(trans, path, cache);
 			/*
 			 * One of the free space endio workers might have
 			 * created a new block group while updating a free space
@@ -2840,7 +2841,7 @@ int btrfs_write_dirty_block_groups(struct btrfs_trans_handle *trans)
 			if (ret == -ENOENT) {
 				wait_event(cur_trans->writer_wait,
 				   atomic_read(&cur_trans->num_writers) == 1);
-				ret = write_one_cache_group(trans, path, cache);
+				ret = update_block_group_item(trans, path, cache);
 			}
 			if (ret)
 				btrfs_abort_transaction(trans, ret);
-- 
2.26.2

