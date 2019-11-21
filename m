Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8920110520B
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Nov 2019 13:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfKUMDl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Nov 2019 07:03:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:52424 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726802AbfKUMDk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Nov 2019 07:03:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0B5A7B1AC;
        Thu, 21 Nov 2019 12:03:38 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 3/3] btrfs: Rename __btrfs_free_reserved_extent to btrfs_pin_reserved_extent
Date:   Thu, 21 Nov 2019 14:03:31 +0200
Message-Id: <20191121120331.29070-4-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191121120331.29070-1-nborisov@suse.com>
References: <20191121120331.29070-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

__btrfs_free_reserved_extent now performs the actions of
btrfs_free_and_pin_reserved_extent. But this name is a bit of a misnomer
, since the extent is not really freed but just pinned. Reflect this
in the new name. No semantics changes.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ctree.h       |  4 ++--
 fs/btrfs/extent-tree.c | 30 +++++++++++-------------------
 fs/btrfs/tree-log.c    | 12 +++++-------
 3 files changed, 18 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 5b2196e2778b..fea637806ac4 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2445,8 +2445,8 @@ int btrfs_free_extent(struct btrfs_trans_handle *trans, struct btrfs_ref *ref);
 
 int btrfs_free_reserved_extent(struct btrfs_fs_info *fs_info,
 			       u64 start, u64 len, int delalloc);
-int btrfs_free_and_pin_reserved_extent(struct btrfs_fs_info *fs_info,
-				       u64 start, u64 len);
+int btrfs_pin_reserved_extent(struct btrfs_fs_info *fs_info, u64 start,
+			      u64 len);
 void btrfs_prepare_extent_commit(struct btrfs_fs_info *fs_info);
 int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans);
 int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index dae6f8d07852..f451dfcca303 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4150,12 +4150,10 @@ int btrfs_reserve_extent(struct btrfs_root *root, u64 ram_bytes,
 	return ret;
 }
 
-static int __btrfs_free_reserved_extent(struct btrfs_fs_info *fs_info,
-					u64 start, u64 len,
-					int pin, int delalloc)
+int btrfs_free_reserved_extent(struct btrfs_fs_info *fs_info,
+			       u64 start, u64 len, int delalloc)
 {
 	struct btrfs_block_group *cache;
-	int ret = 0;
 
 	cache = btrfs_lookup_block_group(fs_info, start);
 	if (!cache) {
@@ -4164,15 +4162,18 @@ static int __btrfs_free_reserved_extent(struct btrfs_fs_info *fs_info,
 		return -ENOSPC;
 	}
 
-	ret = pin_down_extent(cache, start, len, 1);
+	btrfs_add_free_space(cache, start, len);
+	btrfs_free_reserved_bytes(cache, len, delalloc);
+	trace_btrfs_reserved_extent_free(fs_info, start, len);
+
 	btrfs_put_block_group(cache);
-	return ret;
+	return 0;
 }
 
-int btrfs_free_reserved_extent(struct btrfs_fs_info *fs_info,
-			       u64 start, u64 len, int delalloc)
+int btrfs_pin_reserved_extent(struct btrfs_fs_info *fs_info, u64 start, u64 len)
 {
 	struct btrfs_block_group *cache;
+	int ret = 0;
 
 	cache = btrfs_lookup_block_group(fs_info, start);
 	if (!cache) {
@@ -4181,18 +4182,9 @@ int btrfs_free_reserved_extent(struct btrfs_fs_info *fs_info,
 		return -ENOSPC;
 	}
 
-	btrfs_add_free_space(cache, start, len);
-	btrfs_free_reserved_bytes(cache, len, delalloc);
-	trace_btrfs_reserved_extent_free(fs_info, start, len);
-
+	ret = pin_down_extent(cache, start, len, 1);
 	btrfs_put_block_group(cache);
-	return 0;
-}
-
-int btrfs_free_and_pin_reserved_extent(struct btrfs_fs_info *fs_info,
-				       u64 start, u64 len)
-{
-	return __btrfs_free_reserved_extent(fs_info, start, len, 1, 0);
+	return ret;
 }
 
 static int alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 6f757361db53..7321f1da3dd7 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2731,9 +2731,8 @@ static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
 
 				WARN_ON(root_owner !=
 					BTRFS_TREE_LOG_OBJECTID);
-				ret = btrfs_free_and_pin_reserved_extent(
-							fs_info, bytenr,
-							blocksize);
+				ret = btrfs_pin_reserved_extent(fs_info,
+							bytenr, blocksize);
 				if (ret) {
 					free_extent_buffer(next);
 					return ret;
@@ -2814,8 +2813,7 @@ static noinline int walk_up_log_tree(struct btrfs_trans_handle *trans,
 				}
 
 				WARN_ON(root_owner != BTRFS_TREE_LOG_OBJECTID);
-				ret = btrfs_free_and_pin_reserved_extent(
-						fs_info,
+				ret = btrfs_pin_reserved_extent(fs_info,
 						path->nodes[*level]->start,
 						path->nodes[*level]->len);
 				if (ret)
@@ -2897,8 +2895,8 @@ static int walk_log_tree(struct btrfs_trans_handle *trans,
 
 			WARN_ON(log->root_key.objectid !=
 				BTRFS_TREE_LOG_OBJECTID);
-			ret = btrfs_free_and_pin_reserved_extent(fs_info,
-							next->start, next->len);
+			ret = btrfs_pin_reserved_extent(fs_info, next->start,
+							next->len);
 			if (ret)
 				goto out;
 		}
-- 
2.17.1

