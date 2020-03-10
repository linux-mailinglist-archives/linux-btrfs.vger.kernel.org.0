Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 221C417F285
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Mar 2020 09:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgCJI7j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Mar 2020 04:59:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:55288 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbgCJI7i (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Mar 2020 04:59:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 44421B2EB;
        Tue, 10 Mar 2020 08:59:33 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Remove __ prefix from btrfs_block_rsv_release
Date:   Tue, 10 Mar 2020 10:59:31 +0200
Message-Id: <20200310085931.16478-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently the non-prefixed version is a simple wrapper used to hide
the 4th argument of the prefixed version. This doesn't bring much value
in practice and only makes the code harder to follow by adding another
level of indirection. Rectify this by removing the __ prefix and
have only one public function to release bytes from a block reservation.
No semantic changes.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/block-rsv.c      | 11 ++++++-----
 fs/btrfs/block-rsv.h      | 12 ++----------
 fs/btrfs/delalloc-space.c |  4 ++--
 fs/btrfs/delayed-inode.c  |  6 ++----
 fs/btrfs/delayed-ref.c    |  3 +--
 fs/btrfs/inode-map.c      |  2 +-
 fs/btrfs/inode.c          |  2 +-
 fs/btrfs/props.c          |  2 +-
 fs/btrfs/relocation.c     |  8 ++++----
 fs/btrfs/root-tree.c      |  2 +-
 fs/btrfs/transaction.c    |  8 ++++----
 11 files changed, 25 insertions(+), 35 deletions(-)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 2f6439435cc3..27efec8f7c5b 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -203,7 +203,7 @@ void btrfs_free_block_rsv(struct btrfs_fs_info *fs_info,
 {
 	if (!rsv)
 		return;
-	btrfs_block_rsv_release(fs_info, rsv, (u64)-1);
+	btrfs_block_rsv_release(fs_info, rsv, (u64)-1, NULL);
 	kfree(rsv);
 }

@@ -270,9 +270,9 @@ int btrfs_block_rsv_refill(struct btrfs_root *root,
 	return ret;
 }

-u64 __btrfs_block_rsv_release(struct btrfs_fs_info *fs_info,
-			      struct btrfs_block_rsv *block_rsv,
-			      u64 num_bytes, u64 *qgroup_to_release)
+u64 btrfs_block_rsv_release(struct btrfs_fs_info *fs_info,
+			    struct btrfs_block_rsv *block_rsv, u64 num_bytes,
+			    u64 *qgroup_to_release)
 {
 	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
 	struct btrfs_block_rsv *delayed_rsv = &fs_info->delayed_refs_rsv;
@@ -436,7 +436,8 @@ void btrfs_init_global_block_rsv(struct btrfs_fs_info *fs_info)

 void btrfs_release_global_block_rsv(struct btrfs_fs_info *fs_info)
 {
-	btrfs_block_rsv_release(fs_info, &fs_info->global_block_rsv, (u64)-1);
+	btrfs_block_rsv_release(fs_info, &fs_info->global_block_rsv, (u64)-1,
+				NULL);
 	WARN_ON(fs_info->trans_block_rsv.size > 0);
 	WARN_ON(fs_info->trans_block_rsv.reserved > 0);
 	WARN_ON(fs_info->chunk_block_rsv.size > 0);
diff --git a/fs/btrfs/block-rsv.h b/fs/btrfs/block-rsv.h
index d1428bb73fc5..0b6ae5302837 100644
--- a/fs/btrfs/block-rsv.h
+++ b/fs/btrfs/block-rsv.h
@@ -73,7 +73,7 @@ int btrfs_cond_migrate_bytes(struct btrfs_fs_info *fs_info,
 			     int min_factor);
 void btrfs_block_rsv_add_bytes(struct btrfs_block_rsv *block_rsv,
 			       u64 num_bytes, bool update_size);
-u64 __btrfs_block_rsv_release(struct btrfs_fs_info *fs_info,
+u64 btrfs_block_rsv_release(struct btrfs_fs_info *fs_info,
 			      struct btrfs_block_rsv *block_rsv,
 			      u64 num_bytes, u64 *qgroup_to_release);
 void btrfs_update_global_block_rsv(struct btrfs_fs_info *fs_info);
@@ -82,20 +82,12 @@ void btrfs_release_global_block_rsv(struct btrfs_fs_info *fs_info);
 struct btrfs_block_rsv *btrfs_use_block_rsv(struct btrfs_trans_handle *trans,
 					    struct btrfs_root *root,
 					    u32 blocksize);
-
-static inline void btrfs_block_rsv_release(struct btrfs_fs_info *fs_info,
-					   struct btrfs_block_rsv *block_rsv,
-					   u64 num_bytes)
-{
-	__btrfs_block_rsv_release(fs_info, block_rsv, num_bytes, NULL);
-}
-
 static inline void btrfs_unuse_block_rsv(struct btrfs_fs_info *fs_info,
 					 struct btrfs_block_rsv *block_rsv,
 					 u32 blocksize)
 {
 	btrfs_block_rsv_add_bytes(block_rsv, blocksize, false);
-	btrfs_block_rsv_release(fs_info, block_rsv, 0);
+	btrfs_block_rsv_release(fs_info, block_rsv, 0, NULL);
 }

 #endif /* BTRFS_BLOCK_RSV_H */
diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index f23d07a981e4..1245739a3a6e 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -330,8 +330,8 @@ static void btrfs_inode_rsv_release(struct btrfs_inode *inode, bool qgroup_free)
 	 * are releasing 0 bytes, and then we'll just get the reservation over
 	 * the size free'd.
 	 */
-	released = __btrfs_block_rsv_release(fs_info, block_rsv, 0,
-					     &qgroup_to_release);
+	released = btrfs_block_rsv_release(fs_info, block_rsv, 0,
+					   &qgroup_to_release);
 	if (released > 0)
 		trace_btrfs_space_reservation(fs_info, "delalloc",
 					      btrfs_ino(inode), released, 0);
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index ee70584ddc45..f678980fe564 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -595,8 +595,7 @@ static void btrfs_delayed_item_release_metadata(struct btrfs_root *root,
 	trace_btrfs_space_reservation(fs_info, "delayed_item",
 				      item->key.objectid, item->bytes_reserved,
 				      0);
-	btrfs_block_rsv_release(fs_info, rsv,
-				item->bytes_reserved);
+	btrfs_block_rsv_release(fs_info, rsv, item->bytes_reserved, NULL);
 }

 static int btrfs_delayed_inode_reserve_metadata(
@@ -677,8 +676,7 @@ static void btrfs_delayed_inode_release_metadata(struct btrfs_fs_info *fs_info,
 	rsv = &fs_info->delayed_block_rsv;
 	trace_btrfs_space_reservation(fs_info, "delayed_inode",
 				      node->inode_id, node->bytes_reserved, 0);
-	btrfs_block_rsv_release(fs_info, rsv,
-				node->bytes_reserved);
+	btrfs_block_rsv_release(fs_info, rsv, node->bytes_reserved, NULL);
 	if (qgroup_free)
 		btrfs_qgroup_free_meta_prealloc(node->root,
 				node->bytes_reserved);
diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index dfdb7d4f8406..353cc2994d10 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -82,8 +82,7 @@ void btrfs_delayed_refs_rsv_release(struct btrfs_fs_info *fs_info, int nr)
 	u64 num_bytes = btrfs_calc_insert_metadata_size(fs_info, nr);
 	u64 released = 0;

-	released = __btrfs_block_rsv_release(fs_info, block_rsv, num_bytes,
-					     NULL);
+	released = btrfs_block_rsv_release(fs_info, block_rsv, num_bytes, NULL);
 	if (released)
 		trace_btrfs_space_reservation(fs_info, "delayed_refs_rsv",
 					      0, released, 0);
diff --git a/fs/btrfs/inode-map.c b/fs/btrfs/inode-map.c
index d5c9c69d8263..6009e0e939b5 100644
--- a/fs/btrfs/inode-map.c
+++ b/fs/btrfs/inode-map.c
@@ -515,7 +515,7 @@ int btrfs_save_ino_cache(struct btrfs_root *root,
 	trace_btrfs_space_reservation(fs_info, "ino_cache", trans->transid,
 				      trans->bytes_reserved, 0);
 	btrfs_block_rsv_release(fs_info, trans->block_rsv,
-				trans->bytes_reserved);
+				trans->bytes_reserved, NULL);
 out:
 	trans->block_rsv = rsv;
 	trans->bytes_reserved = num_bytes;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4f1ee0305a37..e872fc387b1d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8736,7 +8736,7 @@ static int btrfs_truncate(struct inode *inode, bool skip_writeback)
 			break;
 		}

-		btrfs_block_rsv_release(fs_info, rsv, -1);
+		btrfs_block_rsv_release(fs_info, rsv, -1, NULL);
 		ret = btrfs_block_rsv_migrate(&fs_info->trans_block_rsv,
 					      rsv, min_size, false);
 		BUG_ON(ret);	/* shouldn't happen */
diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
index deb59e7cfcac..ff1ff90e48b1 100644
--- a/fs/btrfs/props.c
+++ b/fs/btrfs/props.c
@@ -383,7 +383,7 @@ static int inherit_props(struct btrfs_trans_handle *trans,

 		if (need_reserve) {
 			btrfs_block_rsv_release(fs_info, trans->block_rsv,
-					num_bytes);
+					num_bytes, NULL);
 			if (ret)
 				return ret;
 		}
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 02afe294ee2d..f8a16e2da81f 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2478,7 +2478,7 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 	if (IS_ERR(trans)) {
 		if (!err)
 			btrfs_block_rsv_release(fs_info, rc->block_rsv,
-						num_bytes);
+						num_bytes, NULL);
 		return PTR_ERR(trans);
 	}

@@ -2486,7 +2486,7 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 		if (num_bytes != rc->merging_rsv_size) {
 			btrfs_end_transaction(trans);
 			btrfs_block_rsv_release(fs_info, rc->block_rsv,
-						num_bytes);
+						num_bytes, NULL);
 			goto again;
 		}
 	}
@@ -4265,7 +4265,7 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 	set_reloc_control(rc);

 	backref_cache_cleanup(&rc->backref_cache);
-	btrfs_block_rsv_release(fs_info, rc->block_rsv, (u64)-1);
+	btrfs_block_rsv_release(fs_info, rc->block_rsv, (u64)-1, NULL);

 	/*
 	 * Even in the case when the relocation is cancelled, we should all go
@@ -4281,7 +4281,7 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)

 	rc->merge_reloc_tree = 0;
 	unset_reloc_control(rc);
-	btrfs_block_rsv_release(fs_info, rc->block_rsv, (u64)-1);
+	btrfs_block_rsv_release(fs_info, rc->block_rsv, (u64)-1, NULL);

 	/* get rid of pinned extents */
 	trans = btrfs_join_transaction(rc->extent_root);
diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index 98b6e0d980f9..668f22844017 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -520,5 +520,5 @@ int btrfs_subvolume_reserve_metadata(struct btrfs_root *root,
 void btrfs_subvolume_release_metadata(struct btrfs_fs_info *fs_info,
 				      struct btrfs_block_rsv *rsv)
 {
-	btrfs_block_rsv_release(fs_info, rsv, (u64)-1);
+	btrfs_block_rsv_release(fs_info, rsv, (u64)-1, NULL);
 }
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index ca617441ecbb..b989605974c2 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -221,7 +221,7 @@ void btrfs_trans_release_chunk_metadata(struct btrfs_trans_handle *trans)
 	WARN_ON_ONCE(!list_empty(&trans->new_bgs));

 	btrfs_block_rsv_release(fs_info, &fs_info->chunk_block_rsv,
-				trans->chunk_bytes_reserved);
+				trans->chunk_bytes_reserved, NULL);
 	trans->chunk_bytes_reserved = 0;
 }

@@ -675,7 +675,7 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 alloc_fail:
 	if (num_bytes)
 		btrfs_block_rsv_release(fs_info, &fs_info->trans_block_rsv,
-					num_bytes);
+					num_bytes, NULL);
 reserve_fail:
 	btrfs_qgroup_free_meta_pertrans(root, qgroup_reserved);
 	return ERR_PTR(ret);
@@ -898,7 +898,7 @@ static void btrfs_trans_release_metadata(struct btrfs_trans_handle *trans)
 	trace_btrfs_space_reservation(fs_info, "transaction",
 				      trans->transid, trans->bytes_reserved, 0);
 	btrfs_block_rsv_release(fs_info, trans->block_rsv,
-				trans->bytes_reserved);
+				trans->bytes_reserved, NULL);
 	trans->bytes_reserved = 0;
 }

--
2.17.1

