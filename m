Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE3CFCC76
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2019 19:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfKNSCs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Nov 2019 13:02:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:58188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbfKNSCs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Nov 2019 13:02:48 -0500
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACEEF2071F
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2019 18:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573754567;
        bh=fC1Adku/8IDUYnC5EgOhGo5JwEpgZPhZqN5PkFVAVkM=;
        h=From:To:Subject:Date:From;
        b=yrlDsG5fSY/rScWYjHAAo3XuzEvhAVvkKFCvvrNqGtj/luDOnf4Wd8DBD3NQdbyco
         quOoMWniBC5BcajVvwGLVKB+Js/USR2F3LhSQOss35EFH0IGRbgsOE1QejBKfPiTJQ
         oj0zAYj2eLUBez9DQy7YV9s5Tc0U1c9i0a1xo+3o=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] Btrfs: fix block group remaining RO forever after error during device replace
Date:   Thu, 14 Nov 2019 18:02:43 +0000
Message-Id: <20191114180243.10857-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When doing a device replace, while at scrub.c:scrub_enumerate_chunks(), we
set the block group to RO mode and then wait for any ongoing writes into
extents of the block group to complete. While doing that wait we overwrite
the value of the variable 'ret' and can break out of the loop if an error
happens without turning the block group back into RW mode. So what happens
is the following:

1) btrfs_inc_block_group_ro() returns 0, meaning it set the block group
   to RO mode (its ->ro field set to 1 or incremented to some value > 1);

2) Then btrfs_wait_ordered_roots() returns a value > 0;

3) Then if either joinning or committing the transaction fails, we break
   out of the loop wihtout calling btrfs_dec_block_group_ro(), leaving
   the block group in RO mode forever.

To fix this, just remove the code that waits for ongoing writes to extents
of the block group, since it's not needed because in the initial setup
phase of a device replace operation, before starting to find all chunks
and their extents, we set the target device for replace while holding
fs_info->dev_replace->rwsem, which ensures that after releasing that
semaphore, any writes into the source device are made to the target device
as well (__btrfs_map_block() guarantees that). So while at
scrub_enumerate_chunks() we only need to worry about finding and copying
extents (from the source device to the target device) that were written
before we started the device replace operation.

Fixes: f0e9b7d6401959 ("Btrfs: fix race setting block group readonly during device replace")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ordered-data.c |  6 +-----
 fs/btrfs/ordered-data.h |  2 +-
 fs/btrfs/scrub.c        | 39 ---------------------------------------
 3 files changed, 2 insertions(+), 45 deletions(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 24b6c72b9a59..c1bcd748ff45 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -573,12 +573,11 @@ u64 btrfs_wait_ordered_extents(struct btrfs_root *root, u64 nr,
 	return count;
 }
 
-u64 btrfs_wait_ordered_roots(struct btrfs_fs_info *fs_info, u64 nr,
+void btrfs_wait_ordered_roots(struct btrfs_fs_info *fs_info, u64 nr,
 			     const u64 range_start, const u64 range_len)
 {
 	struct btrfs_root *root;
 	struct list_head splice;
-	u64 total_done = 0;
 	u64 done;
 
 	INIT_LIST_HEAD(&splice);
@@ -598,7 +597,6 @@ u64 btrfs_wait_ordered_roots(struct btrfs_fs_info *fs_info, u64 nr,
 		done = btrfs_wait_ordered_extents(root, nr,
 						  range_start, range_len);
 		btrfs_put_fs_root(root);
-		total_done += done;
 
 		spin_lock(&fs_info->ordered_root_lock);
 		if (nr != U64_MAX) {
@@ -608,8 +606,6 @@ u64 btrfs_wait_ordered_roots(struct btrfs_fs_info *fs_info, u64 nr,
 	list_splice_tail(&splice, &fs_info->ordered_roots);
 	spin_unlock(&fs_info->ordered_root_lock);
 	mutex_unlock(&fs_info->ordered_operations_mutex);
-
-	return total_done;
 }
 
 /*
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 5204171ea962..4eb0319a86d7 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -186,7 +186,7 @@ int btrfs_find_ordered_sum(struct inode *inode, u64 offset, u64 disk_bytenr,
 			   u8 *sum, int len);
 u64 btrfs_wait_ordered_extents(struct btrfs_root *root, u64 nr,
 			       const u64 range_start, const u64 range_len);
-u64 btrfs_wait_ordered_roots(struct btrfs_fs_info *fs_info, u64 nr,
+void btrfs_wait_ordered_roots(struct btrfs_fs_info *fs_info, u64 nr,
 			      const u64 range_start, const u64 range_len);
 void btrfs_lock_and_flush_ordered_range(struct extent_io_tree *tree,
 					struct btrfs_inode *inode, u64 start,
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index f7d4e03f4c5d..b2a85def3468 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3564,45 +3564,6 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 		 */
 		scrub_pause_on(fs_info);
 		ret = btrfs_inc_block_group_ro(cache);
-		if (!ret && sctx->is_dev_replace) {
-			/*
-			 * If we are doing a device replace wait for any tasks
-			 * that started delalloc right before we set the block
-			 * group to RO mode, as they might have just allocated
-			 * an extent from it or decided they could do a nocow
-			 * write. And if any such tasks did that, wait for their
-			 * ordered extents to complete and then commit the
-			 * current transaction, so that we can later see the new
-			 * extent items in the extent tree - the ordered extents
-			 * create delayed data references (for cow writes) when
-			 * they complete, which will be run and insert the
-			 * corresponding extent items into the extent tree when
-			 * we commit the transaction they used when running
-			 * inode.c:btrfs_finish_ordered_io(). We later use
-			 * the commit root of the extent tree to find extents
-			 * to copy from the srcdev into the tgtdev, and we don't
-			 * want to miss any new extents.
-			 */
-			btrfs_wait_block_group_reservations(cache);
-			btrfs_wait_nocow_writers(cache);
-			ret = btrfs_wait_ordered_roots(fs_info, U64_MAX,
-						       cache->key.objectid,
-						       cache->key.offset);
-			if (ret > 0) {
-				struct btrfs_trans_handle *trans;
-
-				trans = btrfs_join_transaction(root);
-				if (IS_ERR(trans))
-					ret = PTR_ERR(trans);
-				else
-					ret = btrfs_commit_transaction(trans);
-				if (ret) {
-					scrub_pause_off(fs_info);
-					btrfs_put_block_group(cache);
-					break;
-				}
-			}
-		}
 		scrub_pause_off(fs_info);
 
 		if (ret == 0) {
-- 
2.11.0

