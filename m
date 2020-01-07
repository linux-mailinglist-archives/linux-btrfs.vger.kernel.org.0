Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6DA9132FAA
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2020 20:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbgAGTmp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jan 2020 14:42:45 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45811 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgAGTmp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jan 2020 14:42:45 -0500
Received: by mail-qk1-f194.google.com with SMTP id x1so447142qkl.12
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jan 2020 11:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Mn+kMHIiUJgKd+wMMeWQ6ti1vsV3R72fJfMtgyNqzYw=;
        b=uDDDiBqwhzm65F55g3keCYGel70hLF+O36v0KBf+nDty4P6f4CDlYuRpytCuyuXUD4
         IvAhCC8CpZbxQeJAKSf4Seiqp9BvnEnXHhdzg0VfWsxu1YSXc+Fg3bwHvvoTtAbbfrSa
         CZL1jUeYMAUXdvnzlGAaqrH32Uwy+RNsfW0WCdFA/pjeZWuL9O8M5VW4MID1iMlwGiPf
         6doL4CfgpKi9Qn4si6iG0PEuNNVb5CfKq9ryZwxz7+yCIU4PJXRysL5ml/EPc6gDpKoE
         xFGbUQR+dnsm/WmdYUm8Uu1m1Q8+g//iaKmrXIvNh/ehFFHPi+ecnODKgMSl9cI9btMk
         yU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mn+kMHIiUJgKd+wMMeWQ6ti1vsV3R72fJfMtgyNqzYw=;
        b=YcmHBWZwAB+ob7/Q1uQs8stAyN9lH9Cxh2rtZmUW3tGYZPqRFY9zI5gr7GSJCWEWTq
         J6krhZtXgBuUsynAhDMeJne6GXlKcoaq+ArHAOQHXlUnPQcSF9y9GzMX/fkbqYGnfWe9
         Qd+fCQCqEEm/EL6djVVGmXlKHfima7KsTA0vDuGKLIXww24HdcXfVVwodLOGNQ1tAVHs
         7cgnFzFpV0Q8ruTSuBH3Smku6IUn6V1Pt/Cb0NkSHPZVjZ1HGtsl5e/FdDeuNivPDLer
         KfoUhj1nvuKroQJjB7cAoa+zrwNxp6MIp97L7Is2sTxe7wxKVdnn6nhMSCF85XXkcjqQ
         HPVQ==
X-Gm-Message-State: APjAAAVmqXwtxdxSVLPHMN71ibk+sWjLKxqqFpU7rDE8/RnZJLmwuHMp
        gPeLKq0M4zjHr2Ca2Oi2d19W80pNoOFZhQ==
X-Google-Smtp-Source: APXvYqxyhFyHJEoG1+uZQi5eNUNUyoCPkMCtguTJDH/nUvzfyMCg5hfEvJviKBze1uGYFPbcal0biQ==
X-Received: by 2002:a05:620a:14a4:: with SMTP id x4mr901828qkj.493.1578426163552;
        Tue, 07 Jan 2020 11:42:43 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id t29sm282881qkm.27.2020.01.07.11.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 11:42:42 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/5] btrfs: introduce the inode->file_extent_tree
Date:   Tue,  7 Jan 2020 14:42:34 -0500
Message-Id: <20200107194237.145694-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200107194237.145694-1-josef@toxicpanda.com>
References: <20200107194237.145694-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In order to keep track of where we have file extents on disk, and thus
where it is safe to adjust the i_size to, we need to have a tree in
place to keep track of the contiguous areas we have file extents for.
Add helpers to use this tree, as it's not required for NO_HOLES file
systems.  We will use this by setting DIRTY for areas we know we have
file extent item's set, and clearing it when we remove file extent items
for truncation.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/btrfs_inode.h    |  5 +++
 fs/btrfs/ctree.h          |  5 +++
 fs/btrfs/extent-io-tree.h |  1 +
 fs/btrfs/extent_io.c      | 11 +++++
 fs/btrfs/file-item.c      | 91 +++++++++++++++++++++++++++++++++++++++
 fs/btrfs/inode.c          |  6 +++
 6 files changed, 119 insertions(+)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 4e12a477d32e..d9dcbac513ed 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -60,6 +60,11 @@ struct btrfs_inode {
 	 */
 	struct extent_io_tree io_failure_tree;
 
+	/* keeps track of where we have extent items mapped in order to make
+	 * sure our i_size adjustments are accurate.
+	 */
+	struct extent_io_tree file_extent_tree;
+
 	/* held while logging the inode in tree-log.c */
 	struct mutex log_mutex;
 
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index a01ff3e0ead4..7142124d03c5 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2807,6 +2807,11 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 				     struct btrfs_file_extent_item *fi,
 				     const bool new_inline,
 				     struct extent_map *em);
+int btrfs_inode_clear_file_extent_range(struct btrfs_inode *inode, u64 start,
+					u64 len);
+int btrfs_inode_set_file_extent_range(struct btrfs_inode *inode, u64 start,
+				      u64 len);
+void btrfs_inode_safe_disk_i_size_write(struct inode *inode, u64 new_isize);
 
 /* inode.c */
 struct extent_map *btrfs_get_extent_fiemap(struct btrfs_inode *inode,
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index a3febe746c79..c8bcd2e3184c 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -44,6 +44,7 @@ enum {
 	IO_TREE_TRANS_DIRTY_PAGES,
 	IO_TREE_ROOT_DIRTY_LOG_PAGES,
 	IO_TREE_SELFTEST,
+	IO_TREE_INODE_FILE_EXTENT,
 };
 
 struct extent_io_tree {
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e374411ed08c..410f5a64d3a6 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -265,6 +265,15 @@ void __cold extent_io_exit(void)
 	bioset_exit(&btrfs_bioset);
 }
 
+/*
+ * For the file_extent_tree, we want to hold the inode lock when we lookup and
+ * update the disk_i_size, but lockdep will complain because our io_tree we hold
+ * the tree lock and get the inode lock when setting delalloc.  These two things
+ * are unrelated, so make a class for the file_extent_tree so we don't get the
+ * two locking patterns mixed up.
+ */
+static struct lock_class_key file_extent_tree_class;
+
 void extent_io_tree_init(struct btrfs_fs_info *fs_info,
 			 struct extent_io_tree *tree, unsigned int owner,
 			 void *private_data)
@@ -276,6 +285,8 @@ void extent_io_tree_init(struct btrfs_fs_info *fs_info,
 	spin_lock_init(&tree->lock);
 	tree->private_data = private_data;
 	tree->owner = owner;
+	if (owner == IO_TREE_INODE_FILE_EXTENT)
+		lockdep_set_class(&tree->lock, &file_extent_tree_class);
 }
 
 void extent_io_tree_release(struct extent_io_tree *tree)
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 1a599f50837b..b733d85510ed 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -23,6 +23,97 @@
 #define MAX_CSUM_ITEMS(r, size) (min_t(u32, __MAX_CSUM_ITEMS(r, size), \
 				       PAGE_SIZE))
 
+/**
+ * @inode - the inode we want to update the disk_i_size for
+ * @new_isize - the isize we want to set to, 0 if we use i_size
+ *
+ * With NO_HOLES set this simply sets the disk_is_size to whatever i_size_read()
+ * returns as it is perfectly fine with a file that has holes without hole file
+ * extent items.
+ *
+ * However for !NO_HOLES we need to only return the area that is contiguous from
+ * the 0 offset of the file.  Otherwise we could end up adjust i_size up to an
+ * extent that has a gap in between.
+ *
+ * Finally new_isize should only be set in the case of truncate where we're not
+ * ready to use i_size_read() as the limiter yet.
+ */
+void btrfs_inode_safe_disk_i_size_write(struct inode *inode, u64 new_isize)
+{
+	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
+	u64 start, end, isize;
+	int ret;
+
+	isize = new_isize ? new_isize : i_size_read(inode);
+	if (btrfs_fs_incompat(fs_info, NO_HOLES)) {
+		BTRFS_I(inode)->disk_i_size = isize;
+		return;
+	}
+
+	spin_lock(&BTRFS_I(inode)->lock);
+	ret = find_first_extent_bit(&BTRFS_I(inode)->file_extent_tree, 0,
+				    &start, &end, EXTENT_DIRTY, NULL);
+	if (!ret && start == 0)
+		isize = min(isize, end + 1);
+	else
+		isize = 0;
+	BTRFS_I(inode)->disk_i_size = isize;
+	spin_unlock(&BTRFS_I(inode)->lock);
+}
+
+/**
+ * @inode - the inode we're modifying
+ * @start - the start file offset of the file extent we've inserted
+ * @len - the logical length of the file extent item
+ *
+ * Call when we are insering a new file extent where there was none before.
+ * Does not need to call this in the case where we're replacing an existing file
+ * extent, however if you're unsure it's fine to call this multiple times.
+ *
+ * The start and len must match the file extent item, so thus must be sectorsize
+ * aligned.
+ */
+int btrfs_inode_set_file_extent_range(struct btrfs_inode *inode, u64 start,
+				      u64 len)
+{
+	if (len == 0)
+		return 0;
+
+	ASSERT(IS_ALIGNED(start + len, inode->root->fs_info->sectorsize));
+
+	if (btrfs_fs_incompat(inode->root->fs_info, NO_HOLES))
+		return 0;
+	return set_extent_bits(&inode->file_extent_tree, start, start + len - 1,
+			       EXTENT_DIRTY);
+}
+
+/**
+ * @inode - the inode we're modifying
+ * @start - the start file offset of the file extent we've inserted
+ * @len - the logical length of the file extent item
+ *
+ * Called when we drop a file extent, for example when we truncate.  Doesn't
+ * need to be called for cases where we're replacing a file extent, like when
+ * we've cow'ed a file extent.
+ *
+ * The start and len must match the file extent item, so thus must be sectorsize
+ * aligned.
+ */
+int btrfs_inode_clear_file_extent_range(struct btrfs_inode *inode, u64 start,
+					u64 len)
+{
+	if (len == 0)
+		return 0;
+
+	ASSERT(IS_ALIGNED(start + len, inode->root->fs_info->sectorsize) ||
+	       len == (u64)-1);
+
+	if (btrfs_fs_incompat(inode->root->fs_info, NO_HOLES))
+		return 0;
+	return clear_extent_bit(&inode->file_extent_tree, start,
+				start + len - 1, EXTENT_DIRTY, 0, 0, NULL);
+}
+
 static inline u32 max_ordered_sum_bytes(struct btrfs_fs_info *fs_info,
 					u16 csum_size)
 {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index db67e1984c91..ab8b972863b1 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3784,6 +3784,9 @@ static int btrfs_read_locked_inode(struct inode *inode,
 	i_uid_write(inode, btrfs_inode_uid(leaf, inode_item));
 	i_gid_write(inode, btrfs_inode_gid(leaf, inode_item));
 	btrfs_i_size_write(BTRFS_I(inode), btrfs_inode_size(leaf, inode_item));
+	btrfs_inode_set_file_extent_range(BTRFS_I(inode), 0,
+					  round_up(i_size_read(inode),
+						   fs_info->sectorsize));
 
 	inode->i_atime.tv_sec = btrfs_timespec_sec(leaf, &inode_item->atime);
 	inode->i_atime.tv_nsec = btrfs_timespec_nsec(leaf, &inode_item->atime);
@@ -9363,6 +9366,8 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 	extent_io_tree_init(fs_info, &ei->io_tree, IO_TREE_INODE_IO, inode);
 	extent_io_tree_init(fs_info, &ei->io_failure_tree,
 			    IO_TREE_INODE_IO_FAILURE, inode);
+	extent_io_tree_init(fs_info, &ei->file_extent_tree,
+			    IO_TREE_INODE_FILE_EXTENT, inode);
 	ei->io_tree.track_uptodate = true;
 	ei->io_failure_tree.track_uptodate = true;
 	atomic_set(&ei->sync_writers, 0);
@@ -9429,6 +9434,7 @@ void btrfs_destroy_inode(struct inode *inode)
 	btrfs_qgroup_check_reserved_leak(inode);
 	inode_tree_del(inode);
 	btrfs_drop_extent_cache(BTRFS_I(inode), 0, (u64)-1, 0);
+	btrfs_inode_clear_file_extent_range(BTRFS_I(inode), 0, (u64)-1);
 	btrfs_put_root(BTRFS_I(inode)->root);
 }
 
-- 
2.23.0

