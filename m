Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56F3217F3EC
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Mar 2020 10:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgCJJn4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Mar 2020 05:43:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:55110 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbgCJJn4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Mar 2020 05:43:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2DED9AD55;
        Tue, 10 Mar 2020 09:43:54 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Remove block_rsv parameter from btrfs_drop_snapshot
Date:   Tue, 10 Mar 2020 11:43:51 +0200
Message-Id: <20200310094351.23680-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It's no longer used following 30d40577e322 ("btrfs: reloc: Also queue
orphan reloc tree for cleanup to avoid BUG_ON()"), so just remove it.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ctree.h       | 5 ++---
 fs/btrfs/extent-tree.c | 9 +--------
 fs/btrfs/relocation.c  | 4 ++--
 fs/btrfs/transaction.c | 4 ++--
 4 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index e490cfd70bba..af7229eac02b 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2657,9 +2657,8 @@ static inline int btrfs_next_item(struct btrfs_root *root, struct btrfs_path *p)
 	return btrfs_next_old_item(root, p, 0);
 }
 int btrfs_leaf_free_space(struct extent_buffer *leaf);
-int __must_check btrfs_drop_snapshot(struct btrfs_root *root,
-				     struct btrfs_block_rsv *block_rsv,
-				     int update_ref, int for_reloc);
+int __must_check btrfs_drop_snapshot(struct btrfs_root *root, int update_ref,
+				     int for_reloc);
 int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
 			struct btrfs_root *root,
 			struct extent_buffer *node,
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index a3778937d705..001605b672b8 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5288,9 +5288,7 @@ static noinline int walk_up_tree(struct btrfs_trans_handle *trans,
  *
  * If called with for_reloc == 0, may exit early with -EAGAIN
  */
-int btrfs_drop_snapshot(struct btrfs_root *root,
-			 struct btrfs_block_rsv *block_rsv, int update_ref,
-			 int for_reloc)
+int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_path *path;
@@ -5329,9 +5327,6 @@ int btrfs_drop_snapshot(struct btrfs_root *root,
 	if (err)
 		goto out_end_trans;
 
-	if (block_rsv)
-		trans->block_rsv = block_rsv;
-
 	/*
 	 * This will help us catch people modifying the fs tree while we're
 	 * dropping it.  It is unsafe to mess with the fs tree while it's being
@@ -5459,8 +5454,6 @@ int btrfs_drop_snapshot(struct btrfs_root *root,
 				err = PTR_ERR(trans);
 				goto out_free;
 			}
-			if (block_rsv)
-				trans->block_rsv = block_rsv;
 		}
 	}
 	btrfs_release_path(path);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index f8a16e2da81f..bd6866813510 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2276,7 +2276,7 @@ static int clean_dirty_subvols(struct reloc_control *rc)
 			root->reloc_root = NULL;
 			if (reloc_root) {
 
-				ret2 = btrfs_drop_snapshot(reloc_root, NULL, 0, 1);
+				ret2 = btrfs_drop_snapshot(reloc_root, 0, 1);
 				if (ret2 < 0 && !ret)
 					ret = ret2;
 			}
@@ -2289,7 +2289,7 @@ static int clean_dirty_subvols(struct reloc_control *rc)
 			btrfs_put_root(root);
 		} else {
 			/* Orphan reloc tree, just clean it up */
-			ret2 = btrfs_drop_snapshot(root, NULL, 0, 1);
+			ret2 = btrfs_drop_snapshot(root, 0, 1);
 			if (ret2 < 0 && !ret)
 				ret = ret2;
 		}
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index b989605974c2..32e92de564ed 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2427,9 +2427,9 @@ int btrfs_clean_one_deleted_snapshot(struct btrfs_root *root)
 
 	if (btrfs_header_backref_rev(root->node) <
 			BTRFS_MIXED_BACKREF_REV)
-		ret = btrfs_drop_snapshot(root, NULL, 0, 0);
+		ret = btrfs_drop_snapshot(root, 0, 0);
 	else
-		ret = btrfs_drop_snapshot(root, NULL, 1, 0);
+		ret = btrfs_drop_snapshot(root, 1, 0);
 
 	return (ret < 0) ? 0 : 1;
 }
-- 
2.17.1

