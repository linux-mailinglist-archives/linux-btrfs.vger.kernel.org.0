Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC14E294821
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440714AbgJUG0N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:26:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:42536 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440710AbgJUG0N (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:26:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7PrMMvEhLabVCCzuTsnuZg8Sq7AdfYmwb86BWJMBfN4=;
        b=HUAo9+AkkYTPWxjx/MKphZxNln/BIAdH2Kn6eBtrlopULnvmkJPZ4P1r8UAO2pP5ng2d69
        WCJsOc2xBFZJFweYcN5ftFNzdn+P8WtTesTmw8T8M09wLrbi3jGNser7020/Lr+/U/PnzD
        gHEg76cHJP71K2QyBprr2cicZ4YfGAE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 13CAFAC1D
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:26:11 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 05/68] btrfs: extent_io: sink the @failed_start parameter for set_extent_bit()
Date:   Wed, 21 Oct 2020 14:24:51 +0800
Message-Id: <20201021062554.68132-6-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The @failed_start parameter is only paired with @exclusive_bits, and
those parameters are only used for EXTENT_LOCKED bit, which have their
own wrappers lock_extent_bits().

Thus for regular set_extent_bit() calls, the failed_start makes no
sense, just sink the parameter.

Also, since @failed_start and @exclusive_bits are used in pairs, add
extra assert to make it more obvious.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent-io-tree.h | 18 ++++++++----------
 fs/btrfs/extent_io.c      | 12 ++++++++----
 fs/btrfs/file.c           |  6 +++---
 fs/btrfs/inode.c          |  3 +--
 4 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 219a09a2b734..9a60d8426796 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -153,15 +153,15 @@ static inline int clear_extent_bits(struct extent_io_tree *tree, u64 start,
 int set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 			   unsigned bits, struct extent_changeset *changeset);
 int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		   unsigned bits, u64 *failed_start,
-		   struct extent_state **cached_state, gfp_t mask);
+		   unsigned bits, struct extent_state **cached_state,
+		   gfp_t mask);
 int set_extent_bits_nowait(struct extent_io_tree *tree, u64 start, u64 end,
 			   unsigned bits);
 
 static inline int set_extent_bits(struct extent_io_tree *tree, u64 start,
 		u64 end, unsigned bits)
 {
-	return set_extent_bit(tree, start, end, bits, NULL, NULL, GFP_NOFS);
+	return set_extent_bit(tree, start, end, bits, NULL, GFP_NOFS);
 }
 
 static inline int clear_extent_uptodate(struct extent_io_tree *tree, u64 start,
@@ -174,8 +174,7 @@ static inline int clear_extent_uptodate(struct extent_io_tree *tree, u64 start,
 static inline int set_extent_dirty(struct extent_io_tree *tree, u64 start,
 		u64 end, gfp_t mask)
 {
-	return set_extent_bit(tree, start, end, EXTENT_DIRTY, NULL,
-			      NULL, mask);
+	return set_extent_bit(tree, start, end, EXTENT_DIRTY, NULL, mask);
 }
 
 static inline int clear_extent_dirty(struct extent_io_tree *tree, u64 start,
@@ -196,7 +195,7 @@ static inline int set_extent_delalloc(struct extent_io_tree *tree, u64 start,
 {
 	return set_extent_bit(tree, start, end,
 			      EXTENT_DELALLOC | EXTENT_UPTODATE | extra_bits,
-			      NULL, cached_state, GFP_NOFS);
+			      cached_state, GFP_NOFS);
 }
 
 static inline int set_extent_defrag(struct extent_io_tree *tree, u64 start,
@@ -204,20 +203,19 @@ static inline int set_extent_defrag(struct extent_io_tree *tree, u64 start,
 {
 	return set_extent_bit(tree, start, end,
 			      EXTENT_DELALLOC | EXTENT_UPTODATE | EXTENT_DEFRAG,
-			      NULL, cached_state, GFP_NOFS);
+			      cached_state, GFP_NOFS);
 }
 
 static inline int set_extent_new(struct extent_io_tree *tree, u64 start,
 		u64 end)
 {
-	return set_extent_bit(tree, start, end, EXTENT_NEW, NULL, NULL,
-			GFP_NOFS);
+	return set_extent_bit(tree, start, end, EXTENT_NEW, NULL, GFP_NOFS);
 }
 
 static inline int set_extent_uptodate(struct extent_io_tree *tree, u64 start,
 		u64 end, struct extent_state **cached_state, gfp_t mask)
 {
-	return set_extent_bit(tree, start, end, EXTENT_UPTODATE, NULL,
+	return set_extent_bit(tree, start, end, EXTENT_UPTODATE,
 			      cached_state, mask);
 }
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 2980e8384e74..ca219c42ddc6 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -980,6 +980,10 @@ __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	btrfs_debug_check_extent_io_range(tree, start, end);
 	trace_btrfs_set_extent_bit(tree, start, end - start + 1, bits);
 
+	if (exclusive_bits)
+		ASSERT(failed_start);
+	else
+		ASSERT(!failed_start);
 again:
 	if (!prealloc && gfpflags_allow_blocking(mask)) {
 		/*
@@ -1180,11 +1184,11 @@ __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 }
 
 int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		   unsigned bits, u64 * failed_start,
-		   struct extent_state **cached_state, gfp_t mask)
+		   unsigned bits, struct extent_state **cached_state,
+		   gfp_t mask)
 {
-	return __set_extent_bit(tree, start, end, bits, 0, failed_start,
-				cached_state, mask, NULL);
+	return __set_extent_bit(tree, start, end, bits, 0, NULL, cached_state,
+			        mask, NULL);
 }
 
 
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 4507c3d09399..d3766d2bb8d6 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -481,8 +481,8 @@ static int btrfs_find_new_delalloc_bytes(struct btrfs_inode *inode,
 
 		ret = set_extent_bit(&inode->io_tree, search_start,
 				     search_start + em_len - 1,
-				     EXTENT_DELALLOC_NEW,
-				     NULL, cached_state, GFP_NOFS);
+				     EXTENT_DELALLOC_NEW, cached_state,
+				     GFP_NOFS);
 next:
 		search_start = extent_map_end(em);
 		free_extent_map(em);
@@ -1830,7 +1830,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 
 			set_extent_bit(&BTRFS_I(inode)->io_tree, lockstart,
 				       lockend, EXTENT_NORESERVE, NULL,
-				       NULL, GFP_NOFS);
+				       GFP_NOFS);
 		}
 
 		btrfs_drop_pages(pages, num_pages);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9570458aa847..1d2fe21489ca 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4619,8 +4619,7 @@ int btrfs_truncate_block(struct inode *inode, loff_t from, loff_t len,
 
 	if (only_release_metadata)
 		set_extent_bit(&BTRFS_I(inode)->io_tree, block_start,
-				block_end, EXTENT_NORESERVE, NULL, NULL,
-				GFP_NOFS);
+				block_end, EXTENT_NORESERVE, NULL, GFP_NOFS);
 
 out_unlock:
 	if (ret) {
-- 
2.28.0

