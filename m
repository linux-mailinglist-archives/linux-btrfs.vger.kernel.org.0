Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAAF820492D
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jun 2020 07:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbgFWFVZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Jun 2020 01:21:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:50160 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727087AbgFWFVY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Jun 2020 01:21:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 23C2CAFCC
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Jun 2020 05:21:22 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 3/3] btrfs: refactor btrfs_check_can_nocow() into two variants
Date:   Tue, 23 Jun 2020 13:21:12 +0800
Message-Id: <20200623052112.198682-4-wqu@suse.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623052112.198682-1-wqu@suse.com>
References: <20200623052112.198682-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function btrfs_check_can_nocow() now has two completely different call
patterns.

For nowait variant, callers don't need to do any cleanup.
While for wait variant, callers need to release the lock if they can do
nocow write.

This is somehow confusing, and is already a problem for the exported
btrfs_check_can_nocow().

So this patch will separate the different patterns into different
functions.
For nowait variant, the function will be called check_nocow_nolock().
For wait variant, the function pair will be btrfs_check_nocow_lock()
btrfs_check_nocow_unlock().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h |  5 +--
 fs/btrfs/file.c  | 83 ++++++++++++++++++++++++++++--------------------
 fs/btrfs/inode.c |  6 ++--
 3 files changed, 53 insertions(+), 41 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index b7e14189da32..ce716c4e3b13 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3035,8 +3035,9 @@ int btrfs_dirty_pages(struct inode *inode, struct page **pages,
 		      size_t num_pages, loff_t pos, size_t write_bytes,
 		      struct extent_state **cached);
 int btrfs_fdatawrite_range(struct inode *inode, loff_t start, loff_t end);
-int btrfs_check_can_nocow(struct btrfs_inode *inode, loff_t pos,
-			  size_t *write_bytes, bool nowait);
+int btrfs_check_nocow_lock(struct btrfs_inode *inode, loff_t pos,
+			   size_t *write_bytes);
+void btrfs_check_nocow_unlock(struct btrfs_inode *inode);
 
 /* tree-defrag.c */
 int btrfs_defrag_leaves(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 2bee888cb929..30c404d7c8ca 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1533,29 +1533,8 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct page **pages,
 	return ret;
 }
 
-/*
- * Check if we can do nocow write into the range [@pos, @pos + @write_bytes)
- *
- * @pos:	 File offset
- * @write_bytes: The length to write, will be updated to the nocow writeable
- *		 range
- * @nowait:	 Whether this function could sleep.
- *
- * This function will flush ordered extents in the range to ensure proper
- * nocow checks for (nowait == false) case.
- *
- * Return:
- * >0 and update @write_bytes if we can do nocow write.
- * 0 if we can't do nocow write.
- * -EAGAIN if we can't get the needed lock or there are ordered extents for
- * (nowait == true) case.
- * <0 if other error happened.
- *
- * NOTE: For wait (nowait==false) calls, callers need to release the drew write
- * 	 lock of inode->root->snapshot_lock when return value > 0.
- */
-int btrfs_check_can_nocow(struct btrfs_inode *inode, loff_t pos,
-			  size_t *write_bytes, bool nowait)
+static int check_can_nocow(struct btrfs_inode *inode, loff_t pos,
+			   size_t *write_bytes, bool nowait)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_root *root = inode->root;
@@ -1563,6 +1542,9 @@ int btrfs_check_can_nocow(struct btrfs_inode *inode, loff_t pos,
 	u64 num_bytes;
 	int ret;
 
+	if (!(inode->flags & (BTRFS_INODE_NODATACOW | BTRFS_INODE_PREALLOC)))
+		return 0;
+
 	if (!nowait && !btrfs_drew_try_write_lock(&root->snapshot_lock))
 		return -EAGAIN;
 
@@ -1605,6 +1587,42 @@ int btrfs_check_can_nocow(struct btrfs_inode *inode, loff_t pos,
 	return ret;
 }
 
+static int check_nocow_nolock(struct btrfs_inode *inode, loff_t pos,
+			      size_t *write_bytes)
+{
+	return check_can_nocow(inode, pos, write_bytes, false);
+}
+
+/*
+ * Check if we can do nocow write into the range [@pos, @pos + @write_bytes)
+ *
+ * @pos:	 File offset
+ * @write_bytes: The length to write, will be updated to the nocow writeable
+ *		 range
+ *
+ * This function will flush ordered extents in the range to ensure proper
+ * nocow checks.
+ *
+ * Return:
+ * >0 and update @write_bytes if we can do nocow write.
+ * 0 if we can't do nocow write.
+ * -EAGAIN if we can't get the needed lock or there are ordered extents for
+ * (nowait == true) case.
+ * <0 if other error happened.
+ *
+ * NOTE: Callers need to release the lock by btrfs_check_nocow_unlock().
+ */
+int btrfs_check_nocow_lock(struct btrfs_inode *inode, loff_t pos,
+			   size_t *write_bytes)
+{
+	return check_can_nocow(inode, pos, write_bytes, false);
+}
+
+void btrfs_check_nocow_unlock(struct btrfs_inode *inode)
+{
+	btrfs_drew_write_unlock(&inode->root->snapshot_lock);
+}
+
 static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 					       struct iov_iter *i)
 {
@@ -1612,7 +1630,6 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 	loff_t pos = iocb->ki_pos;
 	struct inode *inode = file_inode(file);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct page **pages = NULL;
 	struct extent_changeset *data_reserved = NULL;
 	u64 release_bytes = 0;
@@ -1668,10 +1685,8 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 		ret = btrfs_check_data_free_space(inode, &data_reserved, pos,
 						  write_bytes);
 		if (ret < 0) {
-			if ((BTRFS_I(inode)->flags & (BTRFS_INODE_NODATACOW |
-						      BTRFS_INODE_PREALLOC)) &&
-			    btrfs_check_can_nocow(BTRFS_I(inode), pos,
-						  &write_bytes, false) > 0) {
+			if (btrfs_check_nocow_lock(BTRFS_I(inode), pos,
+						   &write_bytes) > 0) {
 				/*
 				 * For nodata cow case, no need to reserve
 				 * data space.
@@ -1700,7 +1715,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 						data_reserved, pos,
 						write_bytes);
 			else
-				btrfs_drew_write_unlock(&root->snapshot_lock);
+				btrfs_check_nocow_unlock(BTRFS_I(inode));
 			break;
 		}
 
@@ -1804,7 +1819,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 
 		release_bytes = 0;
 		if (only_release_metadata)
-			btrfs_drew_write_unlock(&root->snapshot_lock);
+			btrfs_check_nocow_unlock(BTRFS_I(inode));
 
 		if (only_release_metadata && copied > 0) {
 			lockstart = round_down(pos,
@@ -1831,7 +1846,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 
 	if (release_bytes) {
 		if (only_release_metadata) {
-			btrfs_drew_write_unlock(&root->snapshot_lock);
+			btrfs_check_nocow_unlock(BTRFS_I(inode));
 			btrfs_delalloc_release_metadata(BTRFS_I(inode),
 					release_bytes, true);
 		} else {
@@ -1946,10 +1961,8 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 		 * We will allocate space in case nodatacow is not set,
 		 * so bail
 		 */
-		if (!(BTRFS_I(inode)->flags & (BTRFS_INODE_NODATACOW |
-					      BTRFS_INODE_PREALLOC)) ||
-		    btrfs_check_can_nocow(BTRFS_I(inode), pos, &nocow_bytes,
-					  true) <= 0) {
+		if (check_nocow_nolock(BTRFS_I(inode), pos, &nocow_bytes)
+		    <= 0) {
 			inode_unlock(inode);
 			return -EAGAIN;
 		}
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 339d739b2d29..3e2596f2ab74 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4541,10 +4541,8 @@ int btrfs_truncate_block(struct inode *inode, loff_t from, loff_t len,
 	ret = btrfs_check_data_free_space(inode, &data_reserved, block_start,
 					  blocksize);
 	if (ret < 0) {
-		if ((BTRFS_I(inode)->flags & (BTRFS_INODE_NODATACOW |
-					      BTRFS_INODE_PREALLOC)) &&
-		    btrfs_check_can_nocow(BTRFS_I(inode), block_start,
-					  &write_bytes, false) > 0) {
+		if (btrfs_check_nocow_lock(BTRFS_I(inode), block_start,
+					   &write_bytes) > 0) {
 			/* For nocow case, no need to reserve data space. */
 			only_release_metadata = true;
 		} else {
-- 
2.27.0

