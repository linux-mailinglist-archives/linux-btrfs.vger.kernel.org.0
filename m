Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157CB4D9E94
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 16:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349556AbiCOPYJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Mar 2022 11:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349464AbiCOPYE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Mar 2022 11:24:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F65B2F3
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 08:22:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF64D6120C
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 15:22:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF26CC340ED
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 15:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647357771;
        bh=m7t+boH1QR/Upp+/wF510RVC44QI/F0xBgUaG66r5OE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=USBkTz9w4fR2F0Xspx0kadVkZf8A+KRFhzZjw1MFM8fCxML7cUCek/AsIOKF3zTnB
         bVHY0Uq+lSzoYF/HcU7KKNdhZ947pq+tqA2TnItD9lCf8winSo2e/ZJw/7MHEQm3Zz
         +OIxTQpq0p3NCkEHaf4UTfQnmazTYisJl6pTXP4UXllBnSMw8aMrvJtnHsKnFOsuDo
         pf0qyGE9WuYlY+RCnenvmJZte/pTFaCTvVnuIiRmcdxqe5Ghurzr1d/oFr3X18Fmrv
         QAEjJ7LYSstFIGvuOCvrm8TTCVkVIr0Guj4YHQTcUel1VQYAzJ0jPMHkph/DLmWk1y
         LYGr2SzgUbkwg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 7/7] btrfs: add and use helper to assert an inode range is clean
Date:   Tue, 15 Mar 2022 15:22:41 +0000
Message-Id: <d708920a3bb286ef91b69f38694cadcf10a68c4a.1647357395.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1647357395.git.fdmanana@suse.com>
References: <cover.1647357395.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

We have four different scenarios where we don't expect to find ordered
extents after locking a file range:

1) During plain fallocate;
2) During hole punching;
3) During zero range;
4) During reflinks (both cloning and deduplication).

This is because in all these cases we follow the pattern:

1) Lock the inode's VFS lock in exclusive mode;

2) Lock the inode's i_mmap_lock in exclusive node, to serialize with
   mmap writes;

3) Flush delalloc in a file range and wait for all ordered extents
   to complete - both done through btrfs_wait_ordered_range();

4) Lock the file range in the inode's io_tree.

So add a helper that asserts that we don't have ordered extents for a
given range. Make the four scenarios listed above use this helper after
locking the respective file range.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.h   |  1 +
 fs/btrfs/file.c    |  4 ++++
 fs/btrfs/inode.c   | 37 +++++++++++++++++++++++++++++++++++++
 fs/btrfs/reflink.c | 13 +++++++++++--
 4 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 4db17bd05a21..c58baad426f8 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3327,6 +3327,7 @@ void btrfs_inode_unlock(struct inode *inode, unsigned int ilock_flags);
 void btrfs_update_inode_bytes(struct btrfs_inode *inode,
 			      const u64 add_bytes,
 			      const u64 del_bytes);
+void btrfs_assert_inode_range_clean(struct btrfs_inode *inode, u64 start, u64 end);
 
 /* ioctl.c */
 long btrfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 3019a5182766..0197ede06750 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2608,6 +2608,8 @@ static void btrfs_punch_hole_lock_range(struct inode *inode,
 		unlock_extent_cached(&BTRFS_I(inode)->io_tree, lockstart,
 				     lockend, cached_state);
 	}
+
+	btrfs_assert_inode_range_clean(BTRFS_I(inode), lockstart, lockend);
 }
 
 static int btrfs_insert_replace_extent(struct btrfs_trans_handle *trans,
@@ -3479,6 +3481,8 @@ static long btrfs_fallocate(struct file *file, int mode,
 	lock_extent_bits(&BTRFS_I(inode)->io_tree, alloc_start, locked_end,
 			 &cached_state);
 
+	btrfs_assert_inode_range_clean(BTRFS_I(inode), alloc_start, locked_end);
+
 	/* First, check if we exceed the qgroup limit */
 	INIT_LIST_HEAD(&reserve_list);
 	while (cur_offset < alloc_end) {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2e7143ff5523..50c7e23877a9 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -11306,6 +11306,43 @@ void btrfs_update_inode_bytes(struct btrfs_inode *inode,
 	spin_unlock(&inode->lock);
 }
 
+/*
+ * Verify that there are no ordered extents for a given file range.
+ *
+ * @inode:                The target inode.
+ * @start:                Start offset of the file range, should be sector size
+ *                        aligned.
+ * @end:                  End offset (inclusive) of the file range, its value +1
+ *                        should be sector size aligned.
+ *
+ * This should typically be used for cases where we locked an inode's VFS lock in
+ * exclusive mode, we have also locked the inode's i_mmap_lock in exclusive mode,
+ * we have flushed all delalloc in the range, we have waited for all ordered
+ * extents in the range to complete and finally we have locked the file range in
+ * the inode's io_tree.
+ */
+void btrfs_assert_inode_range_clean(struct btrfs_inode *inode, u64 start, u64 end)
+{
+	struct btrfs_root *root = inode->root;
+	struct btrfs_ordered_extent *ordered;
+
+	if (!IS_ENABLED(CONFIG_BTRFS_ASSERT))
+		return;
+
+	ordered = btrfs_lookup_first_ordered_range(inode, start,
+						   end + 1 - start);
+	if (ordered) {
+		btrfs_err(root->fs_info,
+"found unexpected ordered extent in file range [%llu, %llu] for inode %llu root %llu (ordered range [%llu, %llu])",
+			  start, end, btrfs_ino(inode), root->root_key.objectid,
+			  ordered->file_offset,
+			  ordered->file_offset + ordered->num_bytes - 1);
+		btrfs_put_ordered_extent(ordered);
+	}
+
+	ASSERT(ordered == NULL);
+}
+
 static const struct inode_operations btrfs_dir_inode_operations = {
 	.getattr	= btrfs_getattr,
 	.lookup		= btrfs_lookup,
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index bbd5da25c475..85d8f0d5d3e0 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -614,14 +614,23 @@ static void btrfs_double_extent_unlock(struct inode *inode1, u64 loff1,
 static void btrfs_double_extent_lock(struct inode *inode1, u64 loff1,
 				     struct inode *inode2, u64 loff2, u64 len)
 {
+	u64 range1_end = loff1 + len - 1;
+	u64 range2_end = loff2 + len - 1;
+
 	if (inode1 < inode2) {
 		swap(inode1, inode2);
 		swap(loff1, loff2);
+		swap(range1_end, range2_end);
 	} else if (inode1 == inode2 && loff2 < loff1) {
 		swap(loff1, loff2);
+		swap(range1_end, range2_end);
 	}
-	lock_extent(&BTRFS_I(inode1)->io_tree, loff1, loff1 + len - 1);
-	lock_extent(&BTRFS_I(inode2)->io_tree, loff2, loff2 + len - 1);
+
+	lock_extent(&BTRFS_I(inode1)->io_tree, loff1, range1_end);
+	lock_extent(&BTRFS_I(inode2)->io_tree, loff2, range2_end);
+
+	btrfs_assert_inode_range_clean(BTRFS_I(inode1), loff1, range1_end);
+	btrfs_assert_inode_range_clean(BTRFS_I(inode2), loff2, range2_end);
 }
 
 static void btrfs_double_mmap_lock(struct inode *inode1, struct inode *inode2)
-- 
2.33.0

