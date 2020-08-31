Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72F72578C7
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Aug 2020 13:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgHaLyJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Aug 2020 07:54:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:40310 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbgHaLyE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Aug 2020 07:54:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8B533B7AB;
        Mon, 31 Aug 2020 11:53:55 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 02/12] btrfs: Make btrfs_lookup_first_ordered_extent take btrfs_inode
Date:   Mon, 31 Aug 2020 14:42:39 +0300
Message-Id: <20200831114249.8360-3-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200831114249.8360-1-nborisov@suse.com>
References: <20200831114249.8360-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/file.c         | 6 ++++--
 fs/btrfs/inode.c        | 3 ++-
 fs/btrfs/ordered-data.c | 6 +++---
 fs/btrfs/ordered-data.h | 2 +-
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index b62679382799..8a3bf5fec655 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2508,7 +2508,8 @@ static int btrfs_punch_hole_lock_range(struct inode *inode,
 
 		lock_extent_bits(&BTRFS_I(inode)->io_tree, lockstart, lockend,
 				 cached_state);
-		ordered = btrfs_lookup_first_ordered_extent(inode, lockend);
+		ordered = btrfs_lookup_first_ordered_extent(BTRFS_I(inode),
+							    lockend);
 
 		/*
 		 * We need to make sure we have no ordered extents in this range
@@ -3367,7 +3368,8 @@ static long btrfs_fallocate(struct file *file, int mode,
 		 */
 		lock_extent_bits(&BTRFS_I(inode)->io_tree, alloc_start,
 				 locked_end, &cached_state);
-		ordered = btrfs_lookup_first_ordered_extent(inode, locked_end);
+		ordered = btrfs_lookup_first_ordered_extent(BTRFS_I(inode),
+							    locked_end);
 
 		if (ordered &&
 		    ordered->file_offset + ordered->num_bytes > alloc_start &&
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c59615efab9e..74321962cd0f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8600,7 +8600,8 @@ void btrfs_destroy_inode(struct inode *inode)
 		return;
 
 	while (1) {
-		ordered = btrfs_lookup_first_ordered_extent(inode, (u64)-1);
+		ordered = btrfs_lookup_first_ordered_extent(BTRFS_I(inode),
+							    (u64)-1);
 		if (!ordered)
 			break;
 		else {
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 4732c5b89460..5a7e9c5872d3 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -710,7 +710,7 @@ int btrfs_wait_ordered_range(struct inode *inode, u64 start, u64 len)
 
 	end = orig_end;
 	while (1) {
-		ordered = btrfs_lookup_first_ordered_extent(inode, end);
+		ordered = btrfs_lookup_first_ordered_extent(BTRFS_I(inode), end);
 		if (!ordered)
 			break;
 		if (ordered->file_offset > orig_end) {
@@ -838,13 +838,13 @@ void btrfs_get_ordered_extents_for_logging(struct btrfs_inode *inode,
  * if none is found
  */
 struct btrfs_ordered_extent *
-btrfs_lookup_first_ordered_extent(struct inode *inode, u64 file_offset)
+btrfs_lookup_first_ordered_extent(struct btrfs_inode *inode, u64 file_offset)
 {
 	struct btrfs_ordered_inode_tree *tree;
 	struct rb_node *node;
 	struct btrfs_ordered_extent *entry = NULL;
 
-	tree = &BTRFS_I(inode)->ordered_tree;
+	tree = &inode->ordered_tree;
 	spin_lock_irq(&tree->lock);
 	node = tree_search(tree, file_offset);
 	if (!node)
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 644258a7dfb1..b287a2a403e6 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -178,7 +178,7 @@ void btrfs_start_ordered_extent(struct inode *inode,
 				struct btrfs_ordered_extent *entry, int wait);
 int btrfs_wait_ordered_range(struct inode *inode, u64 start, u64 len);
 struct btrfs_ordered_extent *
-btrfs_lookup_first_ordered_extent(struct inode * inode, u64 file_offset);
+btrfs_lookup_first_ordered_extent(struct btrfs_inode *inode, u64 file_offset);
 struct btrfs_ordered_extent *btrfs_lookup_ordered_range(
 		struct btrfs_inode *inode,
 		u64 file_offset,
-- 
2.17.1

