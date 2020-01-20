Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B86B142CE0
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jan 2020 15:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgATOJZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jan 2020 09:09:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:49096 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728668AbgATOJY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jan 2020 09:09:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 86DC3B1A7;
        Mon, 20 Jan 2020 14:09:21 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 05/11] btrfs: Make btrfs_pin_reserved_extent take transaction
Date:   Mon, 20 Jan 2020 16:09:12 +0200
Message-Id: <20200120140918.15647-6-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200120140918.15647-1-nborisov@suse.com>
References: <20200120140918.15647-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_pin_reserved_extent is now only called with a valid transaction so
exploit the fact to take a transaction. This is preparation for tracking
pinned extents on a per-transaction basis.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ctree.h       | 2 +-
 fs/btrfs/extent-tree.c | 8 +++++---
 fs/btrfs/tree-log.c    | 6 +++---
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 11eaabe104b8..1fe1cbe20bba 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2498,7 +2498,7 @@ int btrfs_free_extent(struct btrfs_trans_handle *trans, struct btrfs_ref *ref);
 
 int btrfs_free_reserved_extent(struct btrfs_fs_info *fs_info,
 			       u64 start, u64 len, int delalloc);
-int btrfs_pin_reserved_extent(struct btrfs_fs_info *fs_info, u64 start,
+int btrfs_pin_reserved_extent(struct btrfs_trans_handle *trans, u64 start,
 			      u64 len);
 void btrfs_prepare_extent_commit(struct btrfs_fs_info *fs_info);
 int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 31ae94a7591c..cf6048fa6e9a 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4185,14 +4185,16 @@ int btrfs_free_reserved_extent(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
-int btrfs_pin_reserved_extent(struct btrfs_fs_info *fs_info, u64 start, u64 len)
+int btrfs_pin_reserved_extent(struct btrfs_trans_handle *trans, u64 start,
+			      u64 len)
 {
 	struct btrfs_block_group *cache;
 	int ret = 0;
 
-	cache = btrfs_lookup_block_group(fs_info, start);
+	cache = btrfs_lookup_block_group(trans->fs_info, start);
 	if (!cache) {
-		btrfs_err(fs_info, "unable to find block group for %llu", start);
+		btrfs_err(trans->fs_info, "unable to find block group for %llu",
+			  start);
 		return -ENOSPC;
 	}
 
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 4c550579e621..ccbac7663d3b 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2743,7 +2743,7 @@ static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
 					btrfs_clean_tree_block(next);
 					btrfs_wait_tree_block_writeback(next);
 					btrfs_tree_unlock(next);
-					ret = btrfs_pin_reserved_extent(fs_info,
+					ret = btrfs_pin_reserved_extent(trans,
 								bytenr, blocksize);
 					if (ret) {
 						free_extent_buffer(next);
@@ -2820,7 +2820,7 @@ static noinline int walk_up_log_tree(struct btrfs_trans_handle *trans,
 					btrfs_clean_tree_block(next);
 					btrfs_wait_tree_block_writeback(next);
 					btrfs_tree_unlock(next);
-					ret = btrfs_pin_reserved_extent(fs_info,
+					ret = btrfs_pin_reserved_extent(trans,
 							path->nodes[*level]->start,
 							path->nodes[*level]->len);
 					if (ret)
@@ -2901,7 +2901,7 @@ static int walk_log_tree(struct btrfs_trans_handle *trans,
 				btrfs_clean_tree_block(next);
 				btrfs_wait_tree_block_writeback(next);
 				btrfs_tree_unlock(next);
-				ret = btrfs_pin_reserved_extent(fs_info, next->start,
+				ret = btrfs_pin_reserved_extent(trans, next->start,
 								next->len);
 				if (ret)
 					goto out;
-- 
2.17.1

