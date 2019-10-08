Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13B1BD0012
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2019 19:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfJHRnL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Oct 2019 13:43:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:49138 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725939AbfJHRnL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 8 Oct 2019 13:43:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E7EE4ADD9;
        Tue,  8 Oct 2019 17:43:08 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Rename btrfs_join_transaction_nolock
Date:   Tue,  8 Oct 2019 20:43:06 +0300
Message-Id: <20191008174306.2395-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This function is used only during the final phase of freespace cache
writeout. This is necessary since using the plain btrfs_join_transaction
api is deadlock prone. The deadlock looks like:

T1:
btrfs_commit_Transaction
 commit_cowonly_roots
    btrfs_write_dirty_block_groups
     btrfs_wait_cache_io
      __btrfs_wait_cache_io
       btrfs_wait_ordered_range <-- Triggers ordered IO for freespace
       inode and blocks transaction commit until freespace cache
       writeout.

T2: <-- after T1 has triggered the writeout
finish_ordered_fn
 btrfs_finish_ordered_io
  btrfs_join_transaction <--- this would block waiting for current
  transaction to commit, but since trans commit is waiting for this
  writeout to finish.

The special purpose functions prevents it by simply skipping the "wait
for writeout" since it's guaranteed the transaction won't proceed until
we are done.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/inode.c       | 12 ++++++------
 fs/btrfs/transaction.c |  2 +-
 fs/btrfs/transaction.h |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 16415815217c..1c6f7c0a2b1d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3053,7 +3053,7 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 	int compress_type = 0;
 	int ret = 0;
 	u64 logical_len = ordered_extent->len;
-	bool nolock;
+	bool freespace_inode;
 	bool truncated = false;
 	bool range_locked = false;
 	bool clear_new_delalloc_bytes = false;
@@ -3064,7 +3064,7 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 	    !test_bit(BTRFS_ORDERED_DIRECT, &ordered_extent->flags))
 		clear_new_delalloc_bytes = true;
 
-	nolock = btrfs_is_free_space_inode(BTRFS_I(inode));
+	freespace_inode = btrfs_is_free_space_inode(BTRFS_I(inode));
 
 	if (test_bit(BTRFS_ORDERED_IOERR, &ordered_extent->flags)) {
 		ret = -EIO;
@@ -3095,8 +3095,8 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 		btrfs_qgroup_free_data(inode, NULL, ordered_extent->file_offset,
 				       ordered_extent->len);
 		btrfs_ordered_update_i_size(inode, 0, ordered_extent);
-		if (nolock)
-			trans = btrfs_join_transaction_nolock(root);
+		if (freespace_inode)
+			trans = btrfs_join_transaction_spacecache(root);
 		else
 			trans = btrfs_join_transaction(root);
 		if (IS_ERR(trans)) {
@@ -3130,8 +3130,8 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 			EXTENT_DEFRAG, 0, 0, &cached_state);
 	}
 
-	if (nolock)
-		trans = btrfs_join_transaction_nolock(root);
+	if (freespace_inode)
+		trans = btrfs_join_transaction_spacecache(root);
 	else
 		trans = btrfs_join_transaction(root);
 	if (IS_ERR(trans)) {
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 54b8718054ce..6f133906c862 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -729,7 +729,7 @@ struct btrfs_trans_handle *btrfs_join_transaction(struct btrfs_root *root)
 				 true);
 }
 
-struct btrfs_trans_handle *btrfs_join_transaction_nolock(struct btrfs_root *root)
+struct btrfs_trans_handle *btrfs_join_transaction_spacecache(struct btrfs_root *root)
 {
 	return start_transaction(root, 0, TRANS_JOIN_NOLOCK,
 				 BTRFS_RESERVE_NO_FLUSH, true);
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index 2ac89fb0d709..49f7196368f5 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -183,7 +183,7 @@ struct btrfs_trans_handle *btrfs_start_transaction_fallback_global_rsv(
 					unsigned int num_items,
 					int min_factor);
 struct btrfs_trans_handle *btrfs_join_transaction(struct btrfs_root *root);
-struct btrfs_trans_handle *btrfs_join_transaction_nolock(struct btrfs_root *root);
+struct btrfs_trans_handle *btrfs_join_transaction_spacecache(struct btrfs_root *root);
 struct btrfs_trans_handle *btrfs_join_transaction_nostart(struct btrfs_root *root);
 struct btrfs_trans_handle *btrfs_attach_transaction(struct btrfs_root *root);
 struct btrfs_trans_handle *btrfs_attach_transaction_barrier(
-- 
2.17.1

