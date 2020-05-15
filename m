Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35201D4586
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 May 2020 08:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgEOGBy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 May 2020 02:01:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:44850 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbgEOGBx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 May 2020 02:01:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1A89AADFE
        for <linux-btrfs@vger.kernel.org>; Fri, 15 May 2020 06:01:55 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 2/3] btrfs: inode: Cleanup the log tree exceptions in btrfs_truncate_inode_items()
Date:   Fri, 15 May 2020 14:01:41 +0800
Message-Id: <20200515060142.23609-3-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515060142.23609-1-wqu@suse.com>
References: <20200515060142.23609-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are a lot of root owner check in btrfs_truncate_inode_items()
like:

	if (test_bit(BTRFS_ROOT_SHAREABLE, &root->state) ||
	    root == fs_info->tree_root)

But considering that, there are only those trees can have INODE_ITEMs:
- tree root (For v1 space cache)
- subvolume trees
- tree reloc trees
- data reloc tree
- log trees

And since subvolume/tree reloc/data reloc trees all have SHAREABLE bit,
and we're checking tree root manually, so above check is just excluding
log trees.

This patch will replace two of such checks to a much simpler one:

	if (root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID)

This would merge btrfs_drop_extent_cache() and lock_extent_bits() call
into the same if branch.

Finally replace ALIGN() with round_up(), as I'm always bad at determing
the alignement direction.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a6c26c10ffc5..ae6b47edabc5 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4121,20 +4121,18 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 		return -ENOMEM;
 	path->reada = READA_BACK;
 
-	if (root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID)
+	if (root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID) {
+		/*
+		 * We want to drop from the next block forward in case this
+		 * new size is not block aligned since we will be keeping the
+		 * last block of the extent just the way it is.
+		 */
 		lock_extent_bits(&BTRFS_I(inode)->io_tree, lock_start, (u64)-1,
 				 &cached_state);
-
-	/*
-	 * We want to drop from the next block forward in case this new size is
-	 * not block aligned since we will be keeping the last block of the
-	 * extent just the way it is.
-	 */
-	if (test_bit(BTRFS_ROOT_SHAREABLE, &root->state) ||
-	    root == fs_info->tree_root)
-		btrfs_drop_extent_cache(BTRFS_I(inode), ALIGN(new_size,
+		btrfs_drop_extent_cache(BTRFS_I(inode), round_up(new_size,
 					fs_info->sectorsize),
 					(u64)-1, 0);
+	}
 
 	/*
 	 * This function is also used to drop the items in the log tree before
@@ -4335,8 +4333,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 		should_throttle = false;
 
 		if (found_extent &&
-		    (test_bit(BTRFS_ROOT_SHAREABLE, &root->state) ||
-		     root == fs_info->tree_root)) {
+		    root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID) {
 			struct btrfs_ref ref = { 0 };
 
 			bytes_deleted += extent_num_bytes;
-- 
2.26.2

