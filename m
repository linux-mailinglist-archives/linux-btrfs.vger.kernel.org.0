Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD8C38FE65
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 May 2021 12:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhEYKHE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 May 2021 06:07:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231640AbhEYKHD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 May 2021 06:07:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA2936117A
        for <linux-btrfs@vger.kernel.org>; Tue, 25 May 2021 10:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621937131;
        bh=2fuPau59zrwB1RJvX7YHCTpiwF5PJExpKMjABZnsfT4=;
        h=From:To:Subject:Date:From;
        b=sd3WicS73j5qjipSqTCtO6J94J85w6q52JdQINO00JLH4va1bf1/TDWuQCYj8r89Z
         /otQq6B2r0dhTqnvzXrsULjWIHxTkWlM17UU1t3vzyFJxZCs4czv7pLuxoDczqRf3P
         o/2aT8k2ZuUravSlLbrcbNsao7mJYRjEV9kWQPirLL41k7HWqtAnbjUuWmcbULNjAZ
         y72DkrSNKcOYJ88zl8MuZrQUPKLSo/fiIdAxDuuPRN2UXOPjLA/ajo2QolWeVvB3CL
         npyGYw284yGnyh0rHGosPCJxbHLEJ0YclqGLOAyzrg13OWd6Yr9uhGQX6ZpOLu+YYf
         SYibUcWpFIvfw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix deadlock when cloning inline extents and low on available space
Date:   Tue, 25 May 2021 11:05:28 +0100
Message-Id: <fe861a6c4f23f3980fcf198bdbd7e92cdc6847b9.1621936270.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

There are a few cases where cloning an inline extent requires copying data
into a page of the destination inode. For these cases we are allocating
the required data and metadata space while holding a leaf locked. This can
result in a deadlock when we are low on available space because allocating
the space may flush delalloc and two deadlock scenarios can happen:

1) When starting writeback for an inode with a very small dirty range that
   fits in an inline extent, we deadlock during the writeback when trying
   to insert the inline extent, at cow_file_range_inline(), if the extent
   is going to be located in the leaf for which we are already holding a
   read lock;

2) After successfully starting writeback, for non-inline extent cases,
   the async reclaim thread will hang waiting for an ordered extent to
   complete if the ordered extent completion needs to modify the leaf
   for which the clone task is holding a read lock (for adding or
   replacing file extent items). So the cloning task will wait forever
   on the async reclaim thread to make progress, which in turn is
   waiting for the ordered extent completion which in turn is waiting
   to acquire a write lock on the same leaf.

So fix this by making sure we release the path (and therefore the leaf)
everytime we need to copy the inline extent's data into a page of the
destination inode, as by that time we do not need to have the leaf locked.

Fixes: 05a5a7621ce66c ("Btrfs: implement full reflink support for inline extents")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/reflink.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 06682128d8fa..58ddc7ed9e84 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -207,10 +207,7 @@ static int clone_copy_inline_extent(struct inode *dst,
 			 * inline extent's data to the page.
 			 */
 			ASSERT(key.offset > 0);
-			ret = copy_inline_to_page(BTRFS_I(dst), new_key->offset,
-						  inline_data, size, datal,
-						  comp_type);
-			goto out;
+			goto copy_to_page;
 		}
 	} else if (i_size_read(dst) <= datal) {
 		struct btrfs_file_extent_item *ei;
@@ -226,13 +223,10 @@ static int clone_copy_inline_extent(struct inode *dst,
 		    BTRFS_FILE_EXTENT_INLINE)
 			goto copy_inline_extent;
 
-		ret = copy_inline_to_page(BTRFS_I(dst), new_key->offset,
-					  inline_data, size, datal, comp_type);
-		goto out;
+		goto copy_to_page;
 	}
 
 copy_inline_extent:
-	ret = 0;
 	/*
 	 * We have no extent items, or we have an extent at offset 0 which may
 	 * or may not be inlined. All these cases are dealt the same way.
@@ -244,11 +238,13 @@ static int clone_copy_inline_extent(struct inode *dst,
 		 * clone. Deal with all these cases by copying the inline extent
 		 * data into the respective page at the destination inode.
 		 */
-		ret = copy_inline_to_page(BTRFS_I(dst), new_key->offset,
-					  inline_data, size, datal, comp_type);
-		goto out;
+		goto copy_to_page;
 	}
 
+	/*
+	 * Release path before starting a new transaction so we don't hold locks
+	 * that would confuse lockdep.
+	 */
 	btrfs_release_path(path);
 	/*
 	 * If we end up here it means were copy the inline extent into a leaf
@@ -285,11 +281,6 @@ static int clone_copy_inline_extent(struct inode *dst,
 	ret = btrfs_inode_set_file_extent_range(BTRFS_I(dst), 0, aligned_end);
 out:
 	if (!ret && !trans) {
-		/*
-		 * Release path before starting a new transaction so we don't
-		 * hold locks that would confuse lockdep.
-		 */
-		btrfs_release_path(path);
 		/*
 		 * No transaction here means we copied the inline extent into a
 		 * page of the destination inode.
@@ -310,6 +301,21 @@ static int clone_copy_inline_extent(struct inode *dst,
 		*trans_out = trans;
 
 	return ret;
+
+copy_to_page:
+	/*
+	 * Release our path because we don't need it anymore and also because
+	 * copy_inline_to_page() needs to reserve data and metadata, which may
+	 * need to flush delalloc when we are low on available space and
+	 * therefore cause a deadlock if writeback of an inline extent needs to
+	 * write to the same leaf or an ordered extent completion needs to write
+	 * to the same leaf.
+	 */
+	btrfs_release_path(path);
+
+	ret = copy_inline_to_page(BTRFS_I(dst), new_key->offset,
+				  inline_data, size, datal, comp_type);
+	goto out;
 }
 
 /**
-- 
2.28.0

