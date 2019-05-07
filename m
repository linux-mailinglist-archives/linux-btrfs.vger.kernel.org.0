Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB3E715DFD
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2019 09:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfEGHT3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 May 2019 03:19:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:53542 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726720AbfEGHT2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 May 2019 03:19:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5C8BFAC3B
        for <linux-btrfs@vger.kernel.org>; Tue,  7 May 2019 07:19:27 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 1/3] btrfs: Implement btrfs_lock_and_flush_ordered_range
Date:   Tue,  7 May 2019 10:19:22 +0300
Message-Id: <20190507071924.17643-2-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190507071924.17643-1-nborisov@suse.com>
References: <20190507071924.17643-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a certain idiom used in multiple places in btrfs' codebase,
dealing with flushing an ordered range. Factor this in a separate
function that can be reused. Future patches will replace the existing
code with that function.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ordered-data.c | 33 +++++++++++++++++++++++++++++++++
 fs/btrfs/ordered-data.h |  4 ++++
 2 files changed, 37 insertions(+)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 52889da69113..37401cc04a6b 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -962,6 +962,39 @@ int btrfs_find_ordered_sum(struct inode *inode, u64 offset, u64 disk_bytenr,
 	return index;
 }
 
+/*
+ * btrfs_flush_ordered_range - Lock the passed range and ensures all pending
+ * ordered extents in it are run to completion.
+ *
+ * @tree:         IO tree used for locking out other users of the range
+ * @inode:        Inode whose ordered tree is to be searched
+ * @start:        Beginning of range to flush
+ * @end:          Last byte of range to lock
+ * @cached_state: If passed, will return the extent state responsible for the
+ * locked range. It's the caller's responsibility to free the cached state.
+ *
+ * This function always returns with the given range locked, ensuring after it's
+ * called no order extent can be pending.
+ */
+void btrfs_lock_and_flush_ordered_range(struct extent_io_tree *tree,
+					struct btrfs_inode *inode, u64 start,
+					u64 end,
+					struct extent_state **cached_state)
+{
+	struct btrfs_ordered_extent *ordered;
+
+	while (1) {
+		lock_extent_bits(tree, start, end, cached_state);
+		ordered = btrfs_lookup_ordered_range(inode, start,
+						     end - start + 1);
+		if (!ordered)
+			break;
+		unlock_extent_cached(tree, start, end, cached_state);
+		btrfs_start_ordered_extent(&inode->vfs_inode, ordered, 1);
+		btrfs_put_ordered_extent(ordered);
+	}
+}
+
 int __init ordered_data_init(void)
 {
 	btrfs_ordered_extent_cache = kmem_cache_create("btrfs_ordered_extent",
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 4c5991c3de14..9b68179d580f 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -188,6 +188,10 @@ u64 btrfs_wait_ordered_extents(struct btrfs_root *root, u64 nr,
 			       const u64 range_start, const u64 range_len);
 u64 btrfs_wait_ordered_roots(struct btrfs_fs_info *fs_info, u64 nr,
 			      const u64 range_start, const u64 range_len);
+void btrfs_lock_and_flush_ordered_range(struct extent_io_tree *tree,
+					struct btrfs_inode *inode, u64 start,
+					u64 end,
+					struct extent_state **cached_state);
 int __init ordered_data_init(void);
 void __cold ordered_data_exit(void);
 
-- 
2.17.1

