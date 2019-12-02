Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D89710E7CC
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2019 10:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfLBJkX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Dec 2019 04:40:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:47446 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726410AbfLBJkW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Dec 2019 04:40:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A6A48BB08;
        Mon,  2 Dec 2019 09:40:19 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 3/3] btrfs: Ensure btrfs_pin_reserved_extent is always called with valid transaction
Date:   Mon,  2 Dec 2019 11:40:15 +0200
Message-Id: <20191202094015.19444-4-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191202094015.19444-1-nborisov@suse.com>
References: <20191202094015.19444-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_pin_reserved_extent only makes sense when called with a valid
transaction handle. At the moment all cases when it's called and
the transaction handle passed to its caller are from error context in
which 'btrfs_fs_info::pinned_extents' is not going to be processed e.g.

btrfs_Free_fs_roots <--called from open_ctree error label or
close_ctree, after all transaction processing has ceased.
 btrfs_free_log_root_tree
  free_log_tree
   walk_log_tree

btrfs_drop_and_free_fs_root
  btrfs_Free_log <-- called if fs is flagged BTRFS_FS_STATE_ERROR, all
  IO is stopped.
   free_log_tree
     walk_log_tree

To make this explicit in the code rework the 3 call sites where
btrfs_pin_reserved_extent is called. This is in preparation to moving
pinned extent machinery to btrfs_transaction.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/tree-log.c | 49 ++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 6ccf260b313e..b76150cce0fe 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2712,20 +2712,18 @@ static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
 					free_extent_buffer(next);
 					return ret;
 				}
-
-				if (trans) {
-					btrfs_tree_lock(next);
-					btrfs_set_lock_blocking_write(next);
-					btrfs_clean_tree_block(next);
-					btrfs_wait_tree_block_writeback(next);
-					btrfs_tree_unlock(next);
-				} else {
+				if (!trans) {
 					if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &next->bflags))
 						clear_extent_buffer_dirty(next);
+					return ret;
 				}
 
-				WARN_ON(root_owner !=
-					BTRFS_TREE_LOG_OBJECTID);
+				btrfs_tree_lock(next);
+				btrfs_set_lock_blocking_write(next);
+				btrfs_clean_tree_block(next);
+				btrfs_wait_tree_block_writeback(next);
+				btrfs_tree_unlock(next);
+				WARN_ON(root_owner != BTRFS_TREE_LOG_OBJECTID);
 				ret = btrfs_pin_reserved_extent(fs_info,
 							bytenr, blocksize);
 				if (ret) {
@@ -2791,18 +2789,18 @@ static noinline int walk_up_log_tree(struct btrfs_trans_handle *trans,
 				struct extent_buffer *next;
 
 				next = path->nodes[*level];
-
-				if (trans) {
-					btrfs_tree_lock(next);
-					btrfs_set_lock_blocking_write(next);
-					btrfs_clean_tree_block(next);
-					btrfs_wait_tree_block_writeback(next);
-					btrfs_tree_unlock(next);
-				} else {
+				if (!trans) {
 					if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &next->bflags))
 						clear_extent_buffer_dirty(next);
+					return ret;
 				}
 
+				btrfs_tree_lock(next);
+				btrfs_set_lock_blocking_write(next);
+				btrfs_clean_tree_block(next);
+				btrfs_wait_tree_block_writeback(next);
+				btrfs_tree_unlock(next);
+
 				WARN_ON(root_owner != BTRFS_TREE_LOG_OBJECTID);
 				ret = btrfs_pin_reserved_extent(fs_info,
 						path->nodes[*level]->start,
@@ -2873,17 +2871,18 @@ static int walk_log_tree(struct btrfs_trans_handle *trans,
 
 			next = path->nodes[orig_level];
 
-			if (trans) {
-				btrfs_tree_lock(next);
-				btrfs_set_lock_blocking_write(next);
-				btrfs_clean_tree_block(next);
-				btrfs_wait_tree_block_writeback(next);
-				btrfs_tree_unlock(next);
-			} else {
+			if (!trans) {
 				if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &next->bflags))
 					clear_extent_buffer_dirty(next);
+				goto out;
 			}
 
+			btrfs_tree_lock(next);
+			btrfs_set_lock_blocking_write(next);
+			btrfs_clean_tree_block(next);
+			btrfs_wait_tree_block_writeback(next);
+			btrfs_tree_unlock(next);
+
 			ret = btrfs_pin_reserved_extent(fs_info, next->start,
 							next->len);
 			if (ret)
-- 
2.17.1

