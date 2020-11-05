Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599D82A7A0D
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Nov 2020 10:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgKEJIE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Nov 2020 04:08:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:33160 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbgKEJIE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Nov 2020 04:08:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604567282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7jfyejCXeQquy9KP6OySMDZ7WjmTsRMZoRXfZkX6Vhw=;
        b=CN/Kepdw0YdH4xTKvIvK/v6QPFR1RLm7f3M58EkyLWUEn7w/FSCSRbo9IZdlyze1hj+t9L
        rM4KRkT1Pcz42Gld0bEdHmGpzAFkoBl5iXQ95iFaqas634hscUqrY7HLhMbXJxpT9yRno7
        oW4ZGo6ICZYpzimokgRVahrgFUMHhD0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 72E15AAF1;
        Thu,  5 Nov 2020 09:08:02 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Rename __set_extent_bit to set_extent_bit
Date:   Thu,  5 Nov 2020 11:08:00 +0200
Message-Id: <20201105090800.19098-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are only 2 direct calls to set_extent_bit outside of extent-io - in
btrfs_find_new_delalloc_bytes and btrfs_truncate_block, the rest are thin wrappers
around __set_extent_bit. This adds unnecessary indirection and just makes it
more annoying when looking at the various extent bit manipulation functions.
This patch renames __set_extent_bit to set_extent_bit effectively removing
a level of indirection. No functional changes.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/extent-io-tree.h | 21 +++++++++++++--------
 fs/btrfs/extent_io.c      | 32 ++++++++++++--------------------
 fs/btrfs/file.c           |  3 ++-
 fs/btrfs/inode.c          |  2 +-
 4 files changed, 28 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index cab4273ff8d3..62a02b333eeb 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -154,14 +154,17 @@ static inline int clear_extent_bits(struct extent_io_tree *tree, u64 start,
 int set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 			   unsigned bits, struct extent_changeset *changeset);
 int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		   unsigned bits, struct extent_state **cached_state, gfp_t mask);
+		   unsigned bits, unsigned exclusive_bits, u64 *failed_start,
+		   struct extent_state **cached_state, gfp_t mask,
+		   struct extent_changeset *changeset);
 int set_extent_bits_nowait(struct extent_io_tree *tree, u64 start, u64 end,
 			   unsigned bits);

 static inline int set_extent_bits(struct extent_io_tree *tree, u64 start,
 		u64 end, unsigned bits)
 {
-	return set_extent_bit(tree, start, end, bits, NULL, GFP_NOFS);
+	return set_extent_bit(tree, start, end, bits, 0, NULL, NULL, GFP_NOFS,
+			      NULL);
 }

 static inline int clear_extent_uptodate(struct extent_io_tree *tree, u64 start,
@@ -174,7 +177,8 @@ static inline int clear_extent_uptodate(struct extent_io_tree *tree, u64 start,
 static inline int set_extent_dirty(struct extent_io_tree *tree, u64 start,
 		u64 end, gfp_t mask)
 {
-	return set_extent_bit(tree, start, end, EXTENT_DIRTY, NULL, mask);
+	return set_extent_bit(tree, start, end, EXTENT_DIRTY, 0, NULL, NULL,
+			      mask, NULL);
 }

 static inline int clear_extent_dirty(struct extent_io_tree *tree, u64 start,
@@ -195,7 +199,7 @@ static inline int set_extent_delalloc(struct extent_io_tree *tree, u64 start,
 {
 	return set_extent_bit(tree, start, end,
 			      EXTENT_DELALLOC | EXTENT_UPTODATE | extra_bits,
-			      cached_state, GFP_NOFS);
+			      0, NULL, cached_state, GFP_NOFS, NULL);
 }

 static inline int set_extent_defrag(struct extent_io_tree *tree, u64 start,
@@ -203,20 +207,21 @@ static inline int set_extent_defrag(struct extent_io_tree *tree, u64 start,
 {
 	return set_extent_bit(tree, start, end,
 			      EXTENT_DELALLOC | EXTENT_UPTODATE | EXTENT_DEFRAG,
-			      cached_state, GFP_NOFS);
+			      0, NULL, cached_state, GFP_NOFS, NULL);
 }

 static inline int set_extent_new(struct extent_io_tree *tree, u64 start,
 		u64 end)
 {
-	return set_extent_bit(tree, start, end, EXTENT_NEW, NULL, GFP_NOFS);
+	return set_extent_bit(tree, start, end, EXTENT_NEW, 0, NULL, NULL,
+			GFP_NOFS, NULL);
 }

 static inline int set_extent_uptodate(struct extent_io_tree *tree, u64 start,
 		u64 end, struct extent_state **cached_state, gfp_t mask)
 {
-	return set_extent_bit(tree, start, end, EXTENT_UPTODATE,
-			      cached_state, mask);
+	return set_extent_bit(tree, start, end, EXTENT_UPTODATE, 0, NULL,
+			      cached_state, mask, NULL);
 }

 int find_first_extent_bit(struct extent_io_tree *tree, u64 start,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index f3515d3c1321..ec76f76acd06 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -962,11 +962,11 @@ static void cache_state(struct extent_state *state,
  * [start, end] is inclusive This takes the tree lock.
  */

-static int __must_check
-__set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		 unsigned bits, unsigned exclusive_bits,
-		 u64 *failed_start, struct extent_state **cached_state,
-		 gfp_t mask, struct extent_changeset *changeset)
+int __must_check
+set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end, unsigned bits,
+	       unsigned exclusive_bits, u64 *failed_start,
+	       struct extent_state **cached_state, gfp_t mask,
+	       struct extent_changeset *changeset)
 {
 	struct extent_state *state;
 	struct extent_state *prealloc = NULL;
@@ -1183,14 +1183,6 @@ __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,

 }

-int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		   unsigned bits, struct extent_state **cached_state, gfp_t mask)
-{
-	return __set_extent_bit(tree, start, end, bits, 0, NULL, cached_state,
-			        mask, NULL);
-}
-
-
 /**
  * convert_extent_bit - convert all bits in a given range from one bit to
  * 			another
@@ -1421,14 +1413,14 @@ int set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 	 */
 	BUG_ON(bits & EXTENT_LOCKED);

-	return __set_extent_bit(tree, start, end, bits, 0, NULL, NULL, GFP_NOFS,
+	return set_extent_bit(tree, start, end, bits, 0, NULL, NULL, GFP_NOFS,
 				changeset);
 }

 int set_extent_bits_nowait(struct extent_io_tree *tree, u64 start, u64 end,
 			   unsigned bits)
 {
-	return __set_extent_bit(tree, start, end, bits, 0, NULL, NULL,
+	return set_extent_bit(tree, start, end, bits, 0, NULL, NULL,
 				GFP_NOWAIT, NULL);
 }

@@ -1464,9 +1456,9 @@ int lock_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 	u64 failed_start;

 	while (1) {
-		err = __set_extent_bit(tree, start, end, EXTENT_LOCKED,
-				       EXTENT_LOCKED, &failed_start,
-				       cached_state, GFP_NOFS, NULL);
+		err = set_extent_bit(tree, start, end, EXTENT_LOCKED,
+				     EXTENT_LOCKED, &failed_start,
+				     cached_state, GFP_NOFS, NULL);
 		if (err == -EEXIST) {
 			wait_extent_bit(tree, failed_start, end, EXTENT_LOCKED);
 			start = failed_start;
@@ -1482,8 +1474,8 @@ int try_lock_extent(struct extent_io_tree *tree, u64 start, u64 end)
 	int err;
 	u64 failed_start;

-	err = __set_extent_bit(tree, start, end, EXTENT_LOCKED, EXTENT_LOCKED,
-			       &failed_start, NULL, GFP_NOFS, NULL);
+	err = set_extent_bit(tree, start, end, EXTENT_LOCKED, EXTENT_LOCKED,
+			     &failed_start, NULL, GFP_NOFS, NULL);
 	if (err == -EEXIST) {
 		if (failed_start > start)
 			clear_extent_bit(tree, start, failed_start - 1,
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 26d1cb8a8623..c153e3aba177 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -481,7 +481,8 @@ static int btrfs_find_new_delalloc_bytes(struct btrfs_inode *inode,

 		ret = set_extent_bit(&inode->io_tree, search_start,
 				     search_start + em_len - 1,
-				     EXTENT_DELALLOC_NEW, cached_state, GFP_NOFS);
+				     EXTENT_DELALLOC_NEW, 0,
+				     NULL, cached_state, GFP_NOFS, NULL);
 next:
 		search_start = extent_map_end(em);
 		free_extent_map(em);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3b5e73e8dffb..1ff87d1888dc 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4655,7 +4655,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,

 	if (only_release_metadata)
 		set_extent_bit(io_tree, block_start, block_end,
-			       EXTENT_NORESERVE, NULL, NULL, GFP_NOFS);
+			       EXTENT_NORESERVE, 0, NULL, NULL, GFP_NOFS, NULL);

 out_unlock:
 	if (ret) {
--
2.25.1

