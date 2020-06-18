Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF0F1FECD5
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jun 2020 09:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbgFRHuA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Jun 2020 03:50:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:35888 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbgFRHuA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Jun 2020 03:50:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BD5B7AAC3
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Jun 2020 07:49:57 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 2/3] btrfs: refactor check_can_nocow() into two variants
Date:   Thu, 18 Jun 2020 15:49:49 +0800
Message-Id: <20200618074950.136553-3-wqu@suse.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200618074950.136553-1-wqu@suse.com>
References: <20200618074950.136553-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function check_can_nocow() now has two completely different call
patterns.
For nowait variant, callers don't need to do any cleanup.
While for wait variant, callers need to release the lock if they can do
nocow write.

This is somehow confusing, and will be a problem if check_can_nocow()
get exported.

So this patch will separate the different patterns into different
functions.
For nowait variant, the function will be called try_nocow_check().
For wait variant, the function pair will be start_nocow_check() and
end_nocow_check().

Also, adds btrfs_assert_drew_write_locked() for end_nocow_check() to
detected unpaired calls.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c    | 71 ++++++++++++++++++++++++++++------------------
 fs/btrfs/locking.h | 13 +++++++++
 2 files changed, 57 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 0e4f57fb2737..7c904e41c5b6 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1533,27 +1533,8 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct page **pages,
 	return ret;
 }
 
-/*
- * Check if we can do nocow write into the range [@pos, @pos + @write_bytes)
- *
- * This function will flush ordered extents in the range to ensure proper
- * nocow checks for (nowait == false) case.
- *
- * Return >0 and update @write_bytes if we can do nocow write into the range.
- * Return 0 if we can't do nocow write.
- * Return -EAGAIN if we can't get the needed lock, or for (nowait == true) case,
- * there are ordered extents need to be flushed.
- * Return <0 for if other error happened.
- *
- * NOTE: For wait (nowait==false) calls, callers need to release the drew write
- * 	 lock of inode->root->snapshot_lock if return value > 0.
- *
- * @pos:	 File offset of the range
- * @write_bytes: The length of the range to check, also contains the nocow
- * 		 writable length if we can do nocow write
- */
-static noinline int check_can_nocow(struct btrfs_inode *inode, loff_t pos,
-				    size_t *write_bytes, bool nowait)
+static noinline int __check_can_nocow(struct btrfs_inode *inode, loff_t pos,
+				      size_t *write_bytes, bool nowait)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_root *root = inode->root;
@@ -1603,6 +1584,43 @@ static noinline int check_can_nocow(struct btrfs_inode *inode, loff_t pos,
 	return ret;
 }
 
+/*
+ * Check if we can do nocow write into the range [@pos, @pos + @write_bytes)
+ *
+ * The start_nocow_check() version will flush ordered extents before checking,
+ * and needs end_nocow_check() calls if we can do nocow writes.
+ *
+ * While try_nocow_check() version won't do any sleep or hold any lock, thus
+ * no need to call end_nocow_check().
+ *
+ * Return >0 and update @write_bytes if we can do nocow write into the range.
+ * Return 0 if we can't do nocow write.
+ * Return -EAGAIN if we can't get the needed lock, or there are ordered extents
+ * needs to be flushed.
+ * Return <0 for if other error happened.
+ *
+ * @pos:	 File offset of the range
+ * @write_bytes: The length of the range to check, also contains the nocow
+ * 		 writable length if we can do nocow write
+ */
+static int start_nocow_check(struct btrfs_inode *inode, loff_t pos,
+			     size_t *write_bytes)
+{
+	return __check_can_nocow(inode, pos, write_bytes, false);
+}
+
+static int try_nocow_check(struct btrfs_inode *inode, loff_t pos,
+			   size_t *write_bytes)
+{
+	return __check_can_nocow(inode, pos, write_bytes, true);
+}
+
+static void end_nocow_check(struct btrfs_inode *inode)
+{
+	btrfs_assert_drew_write_locked(&inode->root->snapshot_lock);
+	btrfs_drew_write_unlock(&inode->root->snapshot_lock);
+}
+
 static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 					       struct iov_iter *i)
 {
@@ -1668,8 +1686,8 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 		if (ret < 0) {
 			if ((BTRFS_I(inode)->flags & (BTRFS_INODE_NODATACOW |
 						      BTRFS_INODE_PREALLOC)) &&
-			    check_can_nocow(BTRFS_I(inode), pos,
-					    &write_bytes, false) > 0) {
+			    start_nocow_check(BTRFS_I(inode), pos,
+				    	      &write_bytes) > 0) {
 				/*
 				 * For nodata cow case, no need to reserve
 				 * data space.
@@ -1802,7 +1820,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 
 		release_bytes = 0;
 		if (only_release_metadata)
-			btrfs_drew_write_unlock(&root->snapshot_lock);
+			end_nocow_check(BTRFS_I(inode));
 
 		if (only_release_metadata && copied > 0) {
 			lockstart = round_down(pos,
@@ -1829,7 +1847,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 
 	if (release_bytes) {
 		if (only_release_metadata) {
-			btrfs_drew_write_unlock(&root->snapshot_lock);
+			end_nocow_check(BTRFS_I(inode));
 			btrfs_delalloc_release_metadata(BTRFS_I(inode),
 					release_bytes, true);
 		} else {
@@ -1946,8 +1964,7 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 		 */
 		if (!(BTRFS_I(inode)->flags & (BTRFS_INODE_NODATACOW |
 					      BTRFS_INODE_PREALLOC)) ||
-		    check_can_nocow(BTRFS_I(inode), pos, &nocow_bytes,
-				    true) <= 0) {
+		    try_nocow_check(BTRFS_I(inode), pos, &nocow_bytes) <= 0) {
 			inode_unlock(inode);
 			return -EAGAIN;
 		}
diff --git a/fs/btrfs/locking.h b/fs/btrfs/locking.h
index d715846c10b8..28995fccafde 100644
--- a/fs/btrfs/locking.h
+++ b/fs/btrfs/locking.h
@@ -68,4 +68,17 @@ void btrfs_drew_write_unlock(struct btrfs_drew_lock *lock);
 void btrfs_drew_read_lock(struct btrfs_drew_lock *lock);
 void btrfs_drew_read_unlock(struct btrfs_drew_lock *lock);
 
+#ifdef CONFIG_BTRFS_DEBUG
+static inline void btrfs_assert_drew_write_locked(struct btrfs_drew_lock *lock)
+{
+	/* If there are readers, we're definitely not write locked */
+	BUG_ON(atomic_read(&lock->readers));
+	/* We should hold one percpu count, thus the value shouldn't be zero */
+	BUG_ON(percpu_counter_sum(&lock->writers) <= 0);
+}
+#else
+static inline void btrfs_assert_drew_write_locked(struct btrfs_drew_lock *lock)
+{
+}
+#endif
 #endif
-- 
2.27.0

