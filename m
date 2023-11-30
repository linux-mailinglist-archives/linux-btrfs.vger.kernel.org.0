Return-Path: <linux-btrfs+bounces-457-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B89367FFEBC
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Nov 2023 23:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EB07B20C6D
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Nov 2023 22:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFD561695;
	Thu, 30 Nov 2023 22:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IqblMzBe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9800139
	for <linux-btrfs@vger.kernel.org>; Thu, 30 Nov 2023 14:49:17 -0800 (PST)
Received: from ds.suse.cz (unknown [10.100.12.205])
	by smtp-out2.suse.de (Postfix) with ESMTP id 2D9F31FD0C;
	Thu, 30 Nov 2023 22:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1701384556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eapP+bK3Ya2rfmWx1eBBgGmgH9lJusZZ68FF1V2DhaQ=;
	b=IqblMzBe2FbgGPB2wOztX7oL++a73nAoFLOwkJiXLfHsgSzjM2gu6d2cSmTbFYkQR5LVEx
	bu2G/9RjeG2sBmdKO67LdjK6unzt91Bj2+t6b9Ll4LE9L+7ZAm+l3pigH7+Ev97XUzb65d
	Rga4SxN26aG1EkJaH7EX/CsG7hK5h6s=
Received: by ds.suse.cz (Postfix, from userid 10065)
	id C5507DA86C; Thu, 30 Nov 2023 23:42:02 +0100 (CET)
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	anand.jain@oracle.com
Subject: [PATCH v2] btrfs: allocate btrfs_inode::file_extent_tree only without NO_HOLES
Date: Thu, 30 Nov 2023 23:42:01 +0100
Message-ID: <20231130224201.29933-1-dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: 1.10
X-Spamd-Result: default: False [1.10 / 50.00];
	 ARC_NA(0.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-0.989];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FORGED_SENDER(0.30)[dsterba@suse.com,dsterba@suse.cz];
	 RCVD_COUNT_ZERO(0.00)[0];
	 MIME_TRACE(0.00)[0:+];
	 FROM_NEQ_ENVFROM(0.10)[dsterba@suse.com,dsterba@suse.cz];
	 BAYES_HAM(-3.00)[99.99%]

The file_extent_tree was added in 41a2ee75aab0 ("btrfs: introduce
per-inode file extent tree") so we have an explicit mapping of the file
extents to know where it is safe to update i_size. When the feature
NO_HOLES is enabled, and it's been a mkfs default since 5.15, the tree
is not necessary.

To save some space in the inode, allocate the tree only when necessary.
This reduces size by 16 bytes from 1096 to 1080 on a x86_64 release
config.

Signed-off-by: David Sterba <dsterba@suse.com>
---

v2:
- add missing kfree() to btrfs_free_inode() and
  btrfs_test_destroy_inode()

 fs/btrfs/btrfs_inode.h    |  6 ++++--
 fs/btrfs/extent-io-tree.c |  2 ++
 fs/btrfs/file-item.c      |  6 +++---
 fs/btrfs/inode.c          | 25 ++++++++++++++++++++-----
 4 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 5572ae52444e..bfbd0d896fcf 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -107,9 +107,11 @@ struct btrfs_inode {
 
 	/*
 	 * Keep track of where the inode has extent items mapped in order to
-	 * make sure the i_size adjustments are accurate
+	 * make sure the i_size adjustments are accurate. Not required when the
+	 * filesystem is NO_HOLES, the status can't be set while mounted as
+	 * it's a mkfs-time feature.
 	 */
-	struct extent_io_tree file_extent_tree;
+	struct extent_io_tree *file_extent_tree;
 
 	/* held while logging the inode in tree-log.c */
 	struct mutex log_mutex;
diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index dbd201a99693..e3ee5449cc4a 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -962,6 +962,8 @@ int find_contiguous_extent_bit(struct extent_io_tree *tree, u64 start,
 	struct extent_state *state;
 	int ret = 1;
 
+	ASSERT(!btrfs_fs_incompat(extent_io_tree_to_fs_info(tree), NO_HOLES));
+
 	spin_lock(&tree->lock);
 	state = find_first_extent_bit_state(tree, start, bits);
 	if (state) {
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 45cae356e89b..1f0110f48353 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -59,7 +59,7 @@ void btrfs_inode_safe_disk_i_size_write(struct btrfs_inode *inode, u64 new_i_siz
 		goto out_unlock;
 	}
 
-	ret = find_contiguous_extent_bit(&inode->file_extent_tree, 0, &start,
+	ret = find_contiguous_extent_bit(inode->file_extent_tree, 0, &start,
 					 &end, EXTENT_DIRTY);
 	if (!ret && start == 0)
 		i_size = min(i_size, end + 1);
@@ -94,7 +94,7 @@ int btrfs_inode_set_file_extent_range(struct btrfs_inode *inode, u64 start,
 
 	if (btrfs_fs_incompat(inode->root->fs_info, NO_HOLES))
 		return 0;
-	return set_extent_bit(&inode->file_extent_tree, start, start + len - 1,
+	return set_extent_bit(inode->file_extent_tree, start, start + len - 1,
 			      EXTENT_DIRTY, NULL);
 }
 
@@ -123,7 +123,7 @@ int btrfs_inode_clear_file_extent_range(struct btrfs_inode *inode, u64 start,
 
 	if (btrfs_fs_incompat(inode->root->fs_info, NO_HOLES))
 		return 0;
-	return clear_extent_bit(&inode->file_extent_tree, start,
+	return clear_extent_bit(inode->file_extent_tree, start,
 				start + len - 1, EXTENT_DIRTY, NULL);
 }
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 096b3004a19f..9746e81daa36 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8472,10 +8472,20 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
 	struct btrfs_inode *ei;
 	struct inode *inode;
+	struct extent_io_tree *file_extent_tree = NULL;
+
+	/* Self tests may pass a NULL fs_info. */
+	if (fs_info && !btrfs_fs_incompat(fs_info, NO_HOLES)) {
+		file_extent_tree = kmalloc(sizeof(struct extent_io_tree), GFP_KERNEL);
+		if (!file_extent_tree)
+			return NULL;
+	}
 
 	ei = alloc_inode_sb(sb, btrfs_inode_cachep, GFP_KERNEL);
-	if (!ei)
+	if (!ei) {
+		kfree(file_extent_tree);
 		return NULL;
+	}
 
 	ei->root = NULL;
 	ei->generation = 0;
@@ -8516,10 +8526,13 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 	extent_io_tree_init(fs_info, &ei->io_tree, IO_TREE_INODE_IO);
 	ei->io_tree.inode = ei;
 
-	extent_io_tree_init(fs_info, &ei->file_extent_tree,
-			    IO_TREE_INODE_FILE_EXTENT);
-	/* Lockdep class is set only for the file extent tree. */
-	lockdep_set_class(&ei->file_extent_tree.lock, &file_extent_tree_class);
+	ei->file_extent_tree = file_extent_tree;
+	if (file_extent_tree) {
+		extent_io_tree_init(fs_info, ei->file_extent_tree,
+				    IO_TREE_INODE_FILE_EXTENT);
+		/* Lockdep class is set only for the file extent tree. */
+		lockdep_set_class(&ei->file_extent_tree->lock, &file_extent_tree_class);
+	}
 	mutex_init(&ei->log_mutex);
 	spin_lock_init(&ei->ordered_tree_lock);
 	ei->ordered_tree = RB_ROOT;
@@ -8536,12 +8549,14 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 void btrfs_test_destroy_inode(struct inode *inode)
 {
 	btrfs_drop_extent_map_range(BTRFS_I(inode), 0, (u64)-1, false);
+	kfree(BTRFS_I(inode)->file_extent_tree);
 	kmem_cache_free(btrfs_inode_cachep, BTRFS_I(inode));
 }
 #endif
 
 void btrfs_free_inode(struct inode *inode)
 {
+	kfree(BTRFS_I(inode)->file_extent_tree);
 	kmem_cache_free(btrfs_inode_cachep, BTRFS_I(inode));
 }
 
-- 
2.42.1


