Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7319D1EA71D
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jun 2020 17:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgFAPiS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jun 2020 11:38:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:34070 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727963AbgFAPhx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jun 2020 11:37:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8D239B224;
        Mon,  1 Jun 2020 15:37:53 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 23/46] btrfs: Make btrfs_dec_test_first_ordered_pending take btrfs_inode
Date:   Mon,  1 Jun 2020 18:37:21 +0300
Message-Id: <20200601153744.31891-24-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200601153744.31891-1-nborisov@suse.com>
References: <20200601153744.31891-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It doesn't really need vfs_inode but btrfs_inode.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/inode.c        | 8 ++++----
 fs/btrfs/ordered-data.c | 7 +++----
 fs/btrfs/ordered-data.h | 2 +-
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 192a2f0ce4ba..561bd8b4d7f3 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7558,10 +7558,10 @@ static void __endio_write_update_ordered(struct inode *inode,

 	while (ordered_offset < offset + bytes) {
 		last_offset = ordered_offset;
-		if (btrfs_dec_test_first_ordered_pending(inode, &ordered,
-							   &ordered_offset,
-							   ordered_bytes,
-							   uptodate)) {
+		if (btrfs_dec_test_first_ordered_pending(BTRFS_I(inode), &ordered,
+							 &ordered_offset,
+							 ordered_bytes,
+							 uptodate)) {
 			btrfs_init_work(&ordered->work, finish_ordered_fn, NULL,
 					NULL);
 			btrfs_queue_work(wq, &ordered->work);
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index b3e3ab28dd78..4d32876649a5 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -290,12 +290,12 @@ void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
  * file_offset is updated to one byte past the range that is recorded as
  * complete.  This allows you to walk forward in the file.
  */
-int btrfs_dec_test_first_ordered_pending(struct inode *inode,
+int btrfs_dec_test_first_ordered_pending(struct btrfs_inode *inode,
 				   struct btrfs_ordered_extent **cached,
 				   u64 *file_offset, u64 io_size, int uptodate)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct btrfs_ordered_inode_tree *tree;
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct btrfs_ordered_inode_tree *tree = &inode->ordered_tree;
 	struct rb_node *node;
 	struct btrfs_ordered_extent *entry = NULL;
 	int ret;
@@ -304,7 +304,6 @@ int btrfs_dec_test_first_ordered_pending(struct inode *inode,
 	u64 dec_start;
 	u64 to_dec;

-	tree = &BTRFS_I(inode)->ordered_tree;
 	spin_lock_irqsave(&tree->lock, flags);
 	node = tree_search(tree, *file_offset);
 	if (!node) {
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index a0c6c31fc79b..d9819bfcd3ec 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -150,7 +150,7 @@ void btrfs_remove_ordered_extent(struct inode *inode,
 int btrfs_dec_test_ordered_pending(struct inode *inode,
 				   struct btrfs_ordered_extent **cached,
 				   u64 file_offset, u64 io_size, int uptodate);
-int btrfs_dec_test_first_ordered_pending(struct inode *inode,
+int btrfs_dec_test_first_ordered_pending(struct btrfs_inode *inode,
 				   struct btrfs_ordered_extent **cached,
 				   u64 *file_offset, u64 io_size,
 				   int uptodate);
--
2.17.1

